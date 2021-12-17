"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
+учитываются внутренние прямоугольные перегородки,которые изолированы друг от друга и от внешней перегородки
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
"""
function mark_S2(r::Robot) #главная функция
    num=0
    actions=[]
    while ((isborder(r,Sud)) && (isborder(r,West)))==false
        push!(actions, moves!(r,West))
        push!(actions, moves!(r,Sud))
        num += 2
    end
    putmarker!(r)
    while !isborder(r,Ost)
        move!(r,Ost)
        putmarker!(r)
    end
    side = West
    while !isborder(r,Nord)
        change=1
        move!(r,Nord)
        putmarker!(r)
        while change!=0
            change=move_full_detour(r,side)
            putmarker!(r)
        end
        side=inverse(side)
    end
    moves!(r,West)
    moves!(r,Sud)
    while (num>0) == true
        side=isodd(num) ? Ost : Nord
        for _ in 1:actions[num]
            move!(r,side)
        end
        num-=1
    end
end

function move_full_detour(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)&&!isborder(r,next(side))
        move!(r,next(side))
        num_steps+=1
    end
    change=0
    if !isborder(r,side)
        move!(r,side)
        change+=1
    end
    if num_steps !=0
        while isborder(r,inverse(next(side)))
            move!(r,side)
            change+=1
        end
        for _ in 1:num_steps
            move!(r,inverse(next(side)))
        end
    end
    return change
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function next(side::HorizonSide)
    return HorizonSide(mod(Int(side)+3,4))
end
    
function inverse(side::HorizonSide) 
    return HorizonSide(mod(Int(side) +2, 4))
end 

mark_S2(r)