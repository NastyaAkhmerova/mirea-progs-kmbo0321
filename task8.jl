"""
ДАНО: Робот - рядом с горизонтальной перегородкой (под ней),
бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом
"""

function move_to_side(side::HorizonSide, k::Int)
    for i in 1:k
        move!(r, side)
    end
end

n = 1
while isborder(r, Nord)
    if (n % 2 == 0)
        move_to_side(West, n)
    else
        move_to_side(Ost, n)
    end
    global n += 1
end

move_to_side(side, k)