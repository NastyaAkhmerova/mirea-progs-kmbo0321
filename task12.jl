"""
На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток,
начиная с юго-западного угла поля, когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля
(n - это параметр функции). Начальное положение Робота - произвольное, конечное - совпадает с начальным.
Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля
и "шахматных" клеток.
"""
function chess(r::Robot) #главная функция
    go_ver = moves!(r,Sud)
    go_hor = moves!(r,West)
    putmarker!(r)
 
    num_steps_h = checking(r,Nord)
    back(r,Sud)
    num_steps_d = checking(r,Ost)
    back(r,West)
    if num_steps_h < num_steps_d
        steps = num_steps_h
    else
        steps = num_steps_d
    end  
        putmarkers!(r,Nord,steps)
        back(r,Sud)
        putmarkers!(r,Ost,steps)
        back(r,West)
    for i in 1:steps
        move!(r,Nord) 
        putmarkers!(r,Ost,steps)
        back(r,West)
    end
    back(r,Sud)
    
    moves!(r,Ost,go_hor)
    moves!(r,Nord,go_ver)
end

function check_of_marker(r::Robot,side::HorizonSide) #если робот на клетке с маркером - следующая без и так по очереди
     if ismarker(r)
        move!(r,side)
     else
        move!(r,side)
        putmarker!(r)
     end   
end    
function putmarkers!(r::Robot, side::HorizonSide,steps::Int) 
    for j in 1:steps
        check_of_marker(r,side)
    end
end
function checking(r::Robot,side::HorizonSide) #считывает длину (ширины, высоты)
     num_steps = 0
     while  !isborder(r,side)
        move!(r,side)
        num_steps += 1
     end
    return num_steps 
end 
function back(r::Robot,side::HorizonSide) 
    while !isborder(r,side)
        move!(r,side)
    end
end  
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while !isborder(r,side)
        move!(r,side)
        num_steps += 1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end 

chess(r)