"""
ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток
"""
COUNT=0

function great_painter(r::Robot) #главная функция
    global COUNT = 0
    overal_temp = 0
    side = Ost
    while !isborder(r,Nord)
        overal_temp += row_temp(r,side) #сумма температур маркеров
        move!(r,Nord)
        side=inverse(side)
    end
    overal_temp += row_temp(r,side)
    average_temp = overal_temp/COUNT #среднее арифметическое
    return average_temp
end

function row_temp(r::Robot, side::HorizonSide) #запоминает значение температуры маркера
    row_temp = 0
    while !isborder(r,side)
        row_temp += check_temp(r)
        move!(r,side)
    end
    row_temp += check_temp(r)
    return row_temp
end

function check_temp(r::Robot) #считывает температуры, считает кол-во маркеров
    global COUNT
    if ismarker(r)
        COUNT += 1
        return temperature(r)
    else
        return 0
    end
end

function inverse(side::HorizonSide)
    return HorizonSide(mod(Int(side) +2, 4))
end

great_painter(r)