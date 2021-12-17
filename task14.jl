"""
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля, 
на котром возможны внутренние перегородки прямоугольной формы (некоторые прямоугольники могут вырождаться в отрезки) 
и в некоторых клетках изначально могут находиться маркеры.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, 
расставленных вплоть до внешней рамки (кроме этих маркеров на поле могут находиться и какие-то другие).
"""

function mark_kross2(r::Robot) #главная функция
    for side in (Nord,West,Sud,Ost)
        count=1
        while count!=0
            count=workaround_wall(r,side)
            putmarker!(r)
        end
        while ismarker(r)==true
            workaround_wall(r,inverse(side))
        end
        side=inverse(next(side))
    end
putmarker!(r)
end
            
function workaround_wall(r::Robot, side::HorizonSide) #функция для обхода внутренних перегородок
    num_steps=0
    while isborder(r,side) && !isborder(r,next(side)) #уходим от линии маркеров чтобы обойти перегородки
        move!(r,next(side))
        num_steps+=1
    end
    count=0 
    if isborder(r,side)==false
        move!(r,side)
        count+=1 #считаем шаги при движении по линии
    end
    if num_steps !=0
        while isborder(r,inverse(next(side))) #проходим перегородку на другой линии
            move!(r,side)
            count+=1
        end
        for t in 1:num_steps
        move!(r,inverse(next(side))) #возвращаемся на линию
        end
    end
    return count #Возвращение значения счётчика(сколько будет маркеров в линии)
end

function next(side::HorizonSide)
    return HorizonSide(mod(Int(side)+3,4))
end
    
function inverse(side::HorizonSide) 
    return HorizonSide(mod(Int(side) +2, 4))
end 

mark_kross2(r)