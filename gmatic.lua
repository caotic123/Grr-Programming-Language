 local lex = {"[", "]", " <- ", "Ώ"}
 local deli = {lex[1], lex[2], " ", "\n"}
 local error_ = {
	{"Syntax Error: '[' or ']'", os.exit},
	{"Syntax error : Excessed number of '[' ']'", os.exit},
	{"Error : Inital "..lex[4].." don't found", os.exit},
    {"Error : "..lex[4].." was defined out main scope", os.exit}
   }

 local forb_lex = {9}

 function error__(i) 
	print(error_[i][1])
	error_[i][2] ()
  end

 function p_(s)
	local p = 0
	local t = ""
	local _ = {}
	local str = ""
	if not _analy_sub_context(s) then 
	  error__(2)
	end
	for i=1, string.len(s) do
	   t = string.sub(s, i, i)
	   p = (t == lex[1] and p+1 or t == lex[2] and p-1 or p)
	   if (t == lex[2] and p == 0) then
	     _[#_+1] = str
	     str = ""
	   else
		str = str..((p >= 1) and not (p == 1 and t == lex[1]) and t or "")
	   end
	end
	if (p ~= 0) then
		error__(1)
	end
   return _
  end
 
 function _analy_sub_context(t)
   local p = 1
   local __ = 0
   for i=0, #t do
     p = t:sub(i, i) == lex[1] and p+1 or t:sub(i, i) == lex[2] and p-1 or p
     __ = (t:sub(i, i) == lex[2] and p == 2) and __+1 or __
       --print("("..t..")"..((__ and p ~= 1) and "Error" or "Right"))
	end
    return (not (__ >= 2))
  end
 
--  r_rrl = function(s, t, d)
--	return s[d] and r_rrl(s, {s[d], unpack(t)}, (d and d+1 or d)) or t
 -- end

  f = function(x) return x(x) end

  find_car = (function(__) return (function(s, r, func_) return  (__ (__, r, func_, unpack(s))) end) end) (function(_, f, func_, t, ...)  return (func_(f, t) and t) or (t ~= nil and _(_, f, func_, ...)) end)

  treat_str = function(str, i, d, c, _)
    while(i <= d or i >= 1) do
	  if (str:sub(i, i) ~= " " and str:sub(i, i) ~= "\n") then
	    str = str:sub(_(#str, i))
		break
	  end i = c(i) end
  return str end

  left_r = function(s) return treat_str(s, 1, #s, (function(_) return _+1 end), (function(_, __) return __, _ end)) end
  right_r = function(s) return treat_str(s, #s, #s, (function(_) return _-1 end), (function(_, __) return 1, __ end)) end
 
  function rule__(s)
	t = {}
	for i=1, #s do
	  if (s:sub(i, (i-1)+#lex[3]) == lex[3]) then
	    t[#t+1] = {}
		t[#t][1] = right_r(left_r(string.sub(s, f(function(_) return (function(s, t) return (find_car(deli, s:sub(t, t), (function(_, __) return _ == __ end) ) and t) or t == 0 and t or _ (_) (s, t-1) end) end) (s, i-1), i)))
	    t[#t][2] = right_r(left_r(s:sub(i+#lex[3], (f(function(_) return (function(s, t) return find_car(deli, s:sub(t, t), (function(_, __) return _ == __ end)) and t or t > #s and t or _ (_) (s, t+1) end) end) (s, i+#lex[3])))))
		end
   end

   return t end

  function g_onl_r(s)
  local t = {}
  local p_ = 0
  local x = 0
  for i=1, string.len(s) do
	t = s:sub(i, i)
    x = (t == lex[1] and x+1 or t == lex[2] and x-1 or x)
    if (x == 1 and t == lex[1]) then p_ = i end
	if (x == 0 and t == lex[2]) then s = string.sub(s, 1, p_-1)..string.sub(s, i, #s-i) i = 1 end 
  end
  return left_r(right_r(s)) end

  function r_rules(c_, t, id)
	local s = (p_(c_))
    for i,k in pairs(s) do
	  t[#t+1] = {(id and id or 1), rule__(g_onl_r(k)), (#s >= 1 and r_rules(k, {}, (id and id or 1)+1) or {})}
    end
  return t
  end
  
  function get_all_rule(t_)
	local r = t_[1][2]
	local _t = {}
	for i=1, #r do
	  table.insert(_t, {r[i][1], r[i][2], t_[1][1]})
	end
	return _t
  end

  function not_empyth(t_) 
  return #t_ ~= 0
  end

  function next_rule(t_)
	local r = t_[1][#t_[1]]
	return r
  end

  function init_rl(ast)
	local t = {}
	local s
	local ___
	while(not_empyth(ast)) do
	  s = find_car(get_all_rule(ast), lex[4], function(_, __) return __ == nil and true or _ == __[1] end)
	  t = s and s ~= nil and {unpack(s)} or t
	  ___ = s and s ~= nil and ast[1] or ___
	  ast = next_rule(ast)
	end
	if not not_empyth(t) then error__(3) end
	if (___[1] ~= 1) then error__(4) end
	return t
	end
 
  c_rl_g = function(_) return #_ <= 1 and {{_:sub(1, 1), 1}} or {{_:sub(1, 1), 1}, unpack(c_rl_g(_:sub(2, #_)))} end

  print_tabel = function(__) for k,i in pairs(__) do print(i[1].." "..i[2].." - "..i[3]) end end
  function g_m()
    local s = io.read() 
    local g_fil = assert(io.open (s..".gmt", "r"))
	local c = g_fil:read("*all")
	for i,k in pairs(forb_lex) do
		c = string.gsub(c, string.char(k), " ")
	end
    local t_ = r_rules(c, {})
	local n = {unpack(t_)}
	local r = get_all_rule(t_)
	local struct_ = c_rl_g(init_rl(t_)[2])
	print(struct_[10][1])
	while(not_empyth(n)) do
	  print_tabel(get_all_rule(n))
	  n = next_rule(n)
	end

  return true
  end


g_m()