"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля с внутренними перегодками
РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: 
нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке,
следующий - за исключением двух последних клеток на Востоке, и т.д.
"""

function mountain_but_harder(r::Robot) 
    steps=0
    num_steps=[]
    while isborder(r,Sud)==false && isborder(r,West)==false
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
        steps+=2
    end
    putmarker!(r)
    putmarkers!(r,Ost)
    for_width=get_num_movements!(r, West)#=ширина поля=#
    while isborder(r,Nord)==false && for_width>0
        width=for_width #фиксированная величина(ширина) границ,доступных для движения
        move!(r,Nord)
        while width>0
            putmarker!(r)
            width-=build_trajectory(r,Ost)
        end
        for_marking_trajectory(r,West)
        for_width-=1  #уменьшаем на 1 ширину линии(траектория относительно ширины)
    end
    get_num_movements!(r,Sud)
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord
        for k in 1:num_steps[steps]
            move!(r,side)
        end
        steps-=1
    end
end
    
function putmarkers!(r::Robot, side::HorizonSide) 
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
function build_trajectory(r::Robot, side::HorizonSide) 
    num_steps=0
    while isborder(r,side)==true && isborder(r,next(side))==false #цикл для схода с линии маркеровки(для обхода перегородок)
        move!(r,next(side))
        num_steps+=1
    end
    count=0 
    if isborder(r,side)==false #считаем клетки которые НЕ НУЖНО обходить
        move!(r,side)
        count+=1
    end
    if num_steps !=0 # true если встречались перегородки
        while isborder(r,inverse(next(side)))==true
            move!(r,side)
            count+=1
        end
        for a in 1:num_steps
            move!(r,inverse(next(side)))
        end
    end
    return count 
end
    
function for_marking_trajectory(r::Robot, side::HorizonSide)
    count=1
    while count!=0
        count=build_trajectory(r,side)
    end
end

function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps += 1    
    end
    return num_steps
end 

function next(side::HorizonSide)
    return HorizonSide(mod(Int(side)+3,4))
end
    
function inverse(side::HorizonSide) 
    return HorizonSide(mod(Int(side) +2, 4))
end 

mountain_but_harder(r)