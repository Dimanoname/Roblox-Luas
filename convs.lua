local Library = {}

Library.Round = function(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

Library.ToLetters = function(num)
	if num / 1e57 >=1 then
		newnum = num / 1e303
		return Library.Round(newnum, 2).. "Ce"
	elseif num / 1e57 >=1 then
		newnum = num / 1e57
		return Library.Round(newnum, 2).. "OcDe"
	elseif num / 1e54 >=1 then
		newnum = num / 1e54
		return Library.Round(newnum, 2).. "SpDe"
	elseif num / 1e51 >=1 then
		newnum = num / 1e51
		return Library.Round(newnum, 2).. "SxDe"
	elseif num / 1e48 >=1 then
		newnum = num / 1e48
		return Library.Round(newnum, 2).. "QiDe"
	elseif num / 1e45 >=1 then
		newnum = num / 1e45
		return Library.Round(newnum, 2).. "QaDe"
	elseif num / 1e42 >=1 then
		newnum = num / 1e42
		return Library.Round(newnum, 2).. "TDe"
	elseif num / 1e39 >=1 then
		newnum = num / 1e39
		return Library.Round(newnum, 2).. "DDe"
	elseif num / 1e36 >=1 then
		newnum = num / 1e36
		return Library.Round(newnum, 2).. "Un"
	elseif num / 1e33 >=1 then
		newnum = num / 1e33
		return Library.Round(newnum, 2).. "De"
	elseif num / 1e30 >=1 then
		newnum = num / 1e30
		return Library.Round(newnum, 2).. "No"
	elseif num / 1e27 >=1 then
		newnum = num / 1e27
		return Library.Round(newnum, 2).. "Oc"
	elseif num / 1e24 >=1 then
		newnum = num / 1e24
		return Library.Round(newnum, 2).. "Sp"
	elseif num / 1e21 >=1 then
		newnum = num / 1e21
		return Library.Round(newnum, 2).. "Sx"
	elseif num / 1e18 >=1 then
		newnum = num / 1e18
		return Library.Round(newnum, 2).. "Qi"
	elseif num / 1e15 >=1 then
		newnum = num / 1e15
		return Library.Round(newnum, 2).. "Qa"
	elseif num / 1e12 >=1 then
		newnum = num / 1e12
		return Library.Round(newnum, 2).. "T"
	elseif num / 1e09 >=1 then
		newnum = num / 1e09
		return Library.Round(newnum, 2).. "B"
	elseif num / 1e06 >=1 then
		newnum = num / 1e06
		return Library.Round(newnum, 2).. "M"
	elseif num / 1e03 >=1 then
		newnum = num / 1e03
		return Library.Round(newnum, 2).. "K"
	else return num
	end
end

return Library
