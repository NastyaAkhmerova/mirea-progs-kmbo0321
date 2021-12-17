"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.
"""

function xkross!(r::Robot)
    for side in ((Nord,Ost), (Sud,Ost), (Sud, West), (Nord, West))
        luch!(r,side)
    end
    putmarker!(r)
end

function moveformark!(r,side)
    while ismarker(r)
        move!(r,side)
    end
end

function luch!(r,side)
    markline!(r,side)
    moveformark!(r,inverse(side))
end

function markline!(r,side)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end


inverse(s::HorizonSide)=HorizonSide((Int(s)+2)%4)
inverse(s::NTuple)=inverse.(s)


HorizonSideRobots.isborder(r,side::NTuple) = isborder(r,side[1])||isborder(r,side[2])
HorizonSideRobots.move!(r,side::NTuple) = for s in side move!(r,s) end


xkross!(r)

