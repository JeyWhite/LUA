WORDS = {
    {{"один", "одна"}, {"два", "две"}, "три", "четыре", "пять", "шесть", "семь", "восемь", "девять", "десять",
    "одиннадцать", "двенадцать", "тринадцать","четырнадать", "пятнадцать", "шестьнадцать", "семнадцать", "восемнадцать", "девятьнадцать"},
    {"десять", "двадцать", "тридцать", "сорок","пятдесят", "шестьдесят", "семдесят", "восемьдесят", "девяносто"},
    {"сто", "двести", "триста", "четыреста", "пятьсот", "шестьсот", "семьсот", "восемьсот", "девятьсот"}
}
DEC_PPLACES = {
    [4] = {"тысяча", "тысячи", "тысяч"},
    [7] = {"миллион", "миллиона", "милллионов"},
    [10] = {"миллиард", "миллиарда","миллиардов"},
    [13] = {"трилион", "трилиона", "трилионов"},
    [16] = {"трилиард", "трилиарда","трилиардов"}
}

function PlaceByPos(digit, pos)
    if DEC_PPLACES[pos] == nil then
        return ""
    else
        if digit == 1 then
            return DEC_PPLACES[pos][1] .. " "
        elseif digit > 1 and digit <= 4  then
            return DEC_PPLACES[pos][2] .. " "
        else
            return DEC_PPLACES[pos][3] .. " "
        end
    end 
end

function DigitByPos(digit, pos) 
    local res
    local wordsSet = ((pos - 1)%3)+1
    if digit == 0 then
        res = ""
    elseif digit > 0 and digit <= 2 then
        if pos == 4 then
            res = (WORDS[wordsSet][digit][2] .. " " .. PlaceByPos(digit, pos))
        else
            res = (WORDS[wordsSet][digit][1] .. " " .. PlaceByPos(digit, pos))
        end
    elseif digit > 2 and digit < 20 then
        res = (WORDS[wordsSet][digit] .. " " .. PlaceByPos(digit, pos))
    else
        res = "Дичь!"
    end
    return res
end

function GetOneDigit(num, pos)
    return math.floor(num%(10^pos)/(10^(pos-1)))
end

function SmartGetDigit(num, pos)
    local res = GetOneDigit(num, pos)
    local nextNum = GetOneDigit(num, pos-1)
    if ((pos%3) - 2) == 0 and res == 1 then
        res = (res *10)+nextNum 
    end
    return res
end

--- задача: написать число прописью 
function NumToWords(num)
    if num%1~=0 then
        return "дроби не поддерживаются"
    end 
    local res = ""
    if num <0 then
        res = "минус "
        num = math.abs(num)
    end
    local toPass = false
    for i = string.len(tostring(num)), 1, -1 do
        if not toPass then
            local curDigit = SmartGetDigit(num,i)
            toPass = curDigit>9
            if toPass then 
                res = res .. DigitByPos(curDigit, i-1)
            else
                res = res .. DigitByPos(curDigit, i)
            end
        else 
            toPass = false
        end    
    end
    return res
end

print(NumToWords(82017511614))