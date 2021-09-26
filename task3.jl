""" 
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
"""
function mark_S(r::Robot)
    go_ver = moves!(r, Sud)
    go_hor = moves!(r, West)
    
    while !isborder(r, Ost)
        for side in (Nord, Sud)
            mark_all(r, side)
        end
    end

    if !isborder(r, Sud)
        left_Bottom(r)
    else
        while !isborder(r, West)
            move!(r, West)
        end
    end

    moves!(r, Nord, go_ver)
    moves!(r, Ost, go_hor)
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while !isborder(r,side)
        move!(r,side)
        num_steps += 1
    end
    return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function mark_all(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
    end 

    if !isborder(r, Ost)
        putmarker!(r)
        move!(r, Ost)
    else
        putmarker!(r)
    end
end

function left_bottom(r::Robot)
    while !isborder(r, Sud)
        move!(r, Sud)
    end
    
    while !isborder(r, West)
        move!(r, West)
    end 
end

mark_S(r)
show(r)