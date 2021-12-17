"""
Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки 
в пятой задаче перегородки были изолированы-теперь перегородки могут быть любыми
РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
"""
function mark_ugol!(r::Robot)
    num_vert,num_hor = ugol(r)
    for side in (Nord,Ost,Sud,West)
        moves!(r,side)
        putmarker!(r)
    end
    moves!(r, Ost, num_hor)
    moves1!(r, Nord, num_vert)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while !isborder(r,side)
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function moves1!(r::Robot,side::HorizonSide,num_steps::Int)
    q=0
    while q<num_steps 
        if isborder(r,Nord)
            while isborder(r,side)
                move!(r,Ost)
            end
            move!(r,Nord)
            q+=1
            if isborder(r,West)
                while isborder(r,West)
                    move!(r,Nord)
                    q+=1
                end
            end
            move!(r,West)
        end
        if q<num_steps
        move!(r,side)
        q+=1
        end
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
    if isborder(r,side)
        putmarker!(r)
    end
end

function ugol(r::Robot)
    num_vert=0
    num_hor=0
    while (!isborder(r,Sud) || !isborder(r,West))
        num_vert+= moves!(r, Sud)
        num_hor+= moves!(r, West)
        repeat
    end
    return num_vert,num_hor
end

mark_ugol!(r)