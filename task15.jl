"""
ДАНО: Робот - в произвольной клетке поля c внутренними перегородками и маркерами
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
"""
function solve(r::Robot)
    mvs = []
    go_to_corner!(r, mvs) # Занять угол
    mark_corners!(r) #покрасить углы 
    return_back!(r, mvs) #вернуться в начальное положение 
end

function moveIfPossible!(r::Robot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function go_to_corner!(r::Robot, mvs::AbstractArray)
    while isborder(r, Nord) == false || isborder(r, Ost) == false
        moveIfPossible!(r, mvs, Nord)
        moveIfPossible!(r, mvs, Ost)
    end
    # робот достиг правого верхнего угла 
end

function mark_corners!(r::Robot)
    for side in (Sud, West, Nord, Ost)
        putmarkers!(r, side)
    end
end

function inverse(side::HorizonSide) #принимает сторону света и возращает противоположную
    return HorizonSide(mod(Int(side) +2, 4))
end 

function return_back!(r::Robot, mvs::AbstractArray)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end

solve(r)