#ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
#РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакирован
function mark_perimetr!(r::Robot)
    go_ver = moves!(r, Sud)
    go_hor = moves!(r, West)

    for side in (Nord, Ost, Sud, West)
        putmarkers!(r, side)
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

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end


mark_perimetr!(r)
show(r)