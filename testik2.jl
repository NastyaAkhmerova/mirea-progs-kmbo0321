"""
ДАНО: Робот - в произвольной клетке ограниченного
прямоугольного поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении,
в клетке с роботом стоит маркер,
и все остальные клетки поля промаркированы в шахматном порядке
"""

function inverse(Side::HorizonSide)
    return HorizonSide((mod(Int(Side)+2, 4)))
end

global flag = true

function putmarkers!(r::Robot, side::HorizonSide)
    global flag
    while !isborder(r,side)
        move!(r,side)
        flag = !flag
        if flag
            putmarker!(r)
        end
    end
end

function mark_chess!(r::Robot)
    global flag
    mvs = []
    go_to_corner!(r, mvs)
    print(mvs)
    S = Ost
    mark_line(r,S)
    while !isborder(r, Nord)
        move!(r, Nord)
        flag = !flag
        S = inverse(S)
        mark_line(r, S)
    end
    go_to_corner_Sud_West!(r)
    return_back!(r, mvs) #вернуться в начальное положение
end

function mark_line(r, S)
    global flag
    if flag
        putmarker!(r)
    end
    putmarkers!(r,S)
end

function go_to_corner!(r::Robot, mvs::AbstractArray)
    while isborder(r, Sud) == false || isborder(r, West) == false
        moveIfPossible!(r, mvs, Sud)
        moveIfPossible!(r, mvs, West)
    end
    # робот достиг правого нижнего угла 
end

function moveIfPossible!(r::Robot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function return_back!(r::Robot, mvs::AbstractArray)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end

function go_to_corner_Sud_West!(r::Robot)
    while !isborder(r, Sud) || !isborder(r, West)
        while !isborder(r, Sud)
            move!(r, Sud)
        end
        while !isborder(r, West)
            move!(r, West)
        end
    end
end
mark_chess!(r)