"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля,
на котором могут находиться также внутренние прямоугольные перегородки 
(все перегородки изолированы друг от друга, 
прямоугольники могут вырождаться в отрезки)
РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
"""
function solve(r::Robot)
    mvs = []
    go_to_corner!(r, mvs) # Занять угол
    mark_corners!(r) #покрасить цглы 
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

function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end 
end

function mark_corners!(r::Robot)
    for side in (Sud, West, Nord, Ost)
        moves!(r, side)
        putmarker!(r)
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

solve(r)