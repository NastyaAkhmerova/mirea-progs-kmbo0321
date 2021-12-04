function mark_kross(r::Robot) #главная функция
    for side in (Nord, West, Sud, Ost)
        putmarkers!(r, side)
        move_by_markers!(r, inverse(side))
    end
    putmarker!(r)
end

function inverse(side::HorizonSide) #принимает сторону света и возращает противоположную
    return HorizonSide(mod(Int(side) +2, 4))
end 

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end

function move_by_markers!(r::Robot, side)
    while ismarker(r)
        move!(r,side)
    end
end

mark_kross(r)
show(r)