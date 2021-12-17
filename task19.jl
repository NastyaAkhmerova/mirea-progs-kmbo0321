"""
На неограниченном поле имеется один маркер, который нужно найти
(дополнительно на неограниченном поле могут находиться изолированные прямолинейные перегородки, 
в том числе и неограниченно продолжающиеся в одну из своих сторон).
"""

function main(r::Robot)
    steps = 1
    side = Nord
    while ismarker(r)==false
        for _ in 1:2
            special_move!(r,side,steps)
            side=counterclockwise_side(side)
        end
        steps += 1
    end
end

function go_around(r, direct_side)
    move_side = clockwise_side(direct_side)
    left_moves = 0
    right_moves = 0
    while isborder(r, direct_side)
        left_moves += 1
        right_moves = left_moves
        while isborder(r,direct_side) && right_moves > 0
            right_moves -= 1
            move!(r,move_side)
        end
        side=inverse(move_side)
    end
    move!(r,direct_side)
    left_moves /= 2
    while left_moves > 0
        left_moves -= 1
        move!(r,move_side)
    end
end

function special_move!(r::Robot,side::HorizonSide,num::Int)
    for _ in 1:num
        if ismarker(r)
            return nothing
        end
        isborder(r, side) ? go_around(r, side) : move!(r,side)
    end
end

function inverse(side::HorizonSide) 
    return HorizonSide(mod(Int(side) +2, 4))
end

function counterclockwise_side(side::HorizonSide)
    return HorizonSide(mod(Int(side)+1,4))
end 

function clockwise_side(side::HorizonSide)
    return HorizonSide(mod(Int(side)-1,4))
end

main(r)