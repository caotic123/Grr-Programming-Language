local lex = {"[", "]", " <- ", "Ώ", "(", ")", "λ"}
local deli = {lex[1], lex[2], " ", "\n"}
local error_ = {
    {"Syntax Error: '[' or ']'", os.exit},
    {"Syntax error : Excessed number of '[' ']'", os.exit},
    {"Error : Inital "..lex[4].." don't found", os.exit},
    {"Error : "..lex[4].." was defined out main scope", os.exit},
    {"Error : Rules are ambigous or defined in same context", os.exit},
    {"Error : Rules was defined?", os.exit},
    {"Error : An undefined behavior ocurred"}
}

local forb_lex = {9}

function error__(i, x)
    if x then print(x) end
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
    end
    return (not (__ >= 2))
end


f = function(x) return x(x) end

find_car = (function(__) return (function(s, r, func_) return  (__ (__, r, func_, unpack(s))) end) end) (function(_, f, func_, t, ...)  return (t ~= nil and func_(f, t) and t) or (t ~= nil and _(_, f, func_, ...)) end)

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
    local t = {}
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

function is_s_context(rx_, cy_)
    local function prx_p(t, c) return t:sub(c, c) == lex[6] and c or c < # t and prx_p(t, c+1) or false end
    local p = 0
    local s_
    local r_ = 1
    local context = {""}
    local c_c = 1
    local p_contx = {{}}
    local t = false
    if (is_rcont(rx_) and is_rcont(cy_)) then
        for i=1, #cy_ do
            s_ = cy_:sub(i, i)
            p = s_ == lex[5] and p+1 or s_ == lex[6] and p-1 or p

            if (p == 0 and s_ == lex[6] and rx_:sub(r_+1, r_+1) == lex[6]) then
                if (not prx_p(rx_, r_)) then return false end
                r_ = prx_p(rx_, r_)
                p_contx[c_c] = {p_contx[c_c] and p_contx[c_c][1] or nil, i}
                c_c = c_c+1
                context[c_c] = ""
                p_contx[c_c] = {}
            end
            if (s_ == rx_:sub(r_, r_)) then
             --   t = s_ ~= lex[5] and s_ ~= lex[6] and t or true
                if (s_ ~= lex[5] and s_ ~= lex[6]) then t = true end
                p_contx[c_c][1] = s_ == lex[5] and i or p_contx[c_c][1]
                r_ = r_+1
            else
                context[c_c] = context[c_c]..s_
                if (p == 0) then return false end end
        end
    end
    if (not t) then return false end
    if (r_ < #rx_) then return false end
    return {context, p_contx}
end

function is_rcont(rl) return rl:find("%"..lex[5]) and rl:find("%"..lex[6]) end

function get_rl(ast, rul)
    local _ = {}
    while(not_empyth(ast)) do
        s = find_car(get_all_rule(ast), rul, function(_, __) return is_rcont(_) and is_rcont(__[1]) and is_s_context(__[1], _) or _ == __[1] end)
        if (s and s ~= nil) then table.insert(_, {s[2], ast[1][1], s[1]}) end
        ast = next_rule(ast)
    end
    return _
end

c_rl_g = function(_, i_cont_) return #_ <= 1 and {{_:sub(1, 1), i_cont_}} or {{_:sub(1, 1), i_cont_}, unpack(c_rl_g(_:sub(2, #_), i_cont_))} end

function cut_t(t, _, __)
    local s_ = {}
    for i=_, __ do
        table.insert(s_, t[i])
    end
    return s_
end

t_str_form  = function(s_, _, ...) return #s_ <= 1 and (#{...} == 0 and s_[1][1] or _[1]) or (_ and _[1] or "")..t_str_form(#{...} == 0 and s_ or {...}, unpack(#{...} == 0 and s_ or {...})) end

function get_context(s, _, ___)
    local context_ = {}
    for __=_, ___ do
        if (not find_car(context_,  s[__][2], (function(_, __) return _ == __ end))) then
            table.insert(context_, s[__][2])
        end
    end
    return context_
end

function get_rnames(s)
    local t = {}
    local p = 0
    local l = 1
    for i=1, #s do
        t[l] = (t[l] and t[l] or "")..(p >= 1 and not (p == 1 and s:sub(i, i) == lex[6]) and s:sub(i, i) or "")
        l = (p == 1 and s:sub(i, i) == lex[6] and l+1 or l)
        p = s:sub(i, i) == lex[5] and p+1 or s:sub(i, i) == lex[6] and p-1 or p
    end
    return t
end

function c_rul_struc(rule, _, e_)
    local x = {}
    local x_r = {{1, {}}}
    local struc_ = {}
	
	
    for i,t_ in pairs(is_s_context(rule, _)[1]) do
        if (#t_ > 0) then x[get_rnames(rule)[i]] = t_ table.insert(x_r[1][2], {get_rnames(rule)[i], t_}) end
    end
	
	for i,k in pairs(get_rnames(rule)) do
		if not x[k] then print(k.." não disponivel to "..lex[7]) table.insert(x_r[1][2], {k, lex[7]}) end
	 end

    table.insert(x_r[1], {})
    return t_str_form(inter_p(x_r, c_rl_g(e_, 1)))
end

function seek_r(r, i_, cont_x)
    local t = {}
    for i, __ in pairs(i_) do
        if (find_car(cont_x, __[2], (function(_, __) return _ <= (__+1) end))) then
            table.insert(t, __)
        end
    end
    table.sort(t, function(_, __) return _[2] > __[2] end)
    
   -- if (#t > 1) then error__(5, r) end
    return #t > 0 and (is_rcont(r) and {c_rul_struc(t[1][3], r, t[1][1]), t[1][2]}) or t[1] end

function c_cont(...)
    local n_t = {}
    for __,_ in pairs({...}) do
        for ____, ___ in pairs(_) do
			table.insert(n_t, ___)
        end
    end
    return n_t end

rew___ = function(stru_, re_, x, y) return c_cont(cut_t(stru_, 1, x-1), c_rl_g(re_[1], re_[2]), cut_t(stru_, y+1, #stru_)) end
cut___ = function(stru_, x, y) return c_cont(cut_t(stru_, 1, x-1), {}, cut_t(stru_, y+1, #stru_)) end

function exp__(ast, struct__, _, __)
    local cont = get_context(struct__, _, __)
    local _rl = get_rl(ast, t_str_form(cut_t(struct__, _, __) ))
    local m_stru_
    if (t_str_form(cut_t(struct__, _, __)) == lex[7]) then
		return {cut___(struct__, _, __), true}
	end
    
    if (not_empyth(_rl)) then
	    print(t_str_form(struct__), _rl[1][3], _rl[1][1])
        m_stru_ = seek_r(t_str_form(cut_t(struct__, _, __)), _rl, cont)
        if (m_stru_) then
            struct__ = rew___(struct__, m_stru_, _, __)
            return {struct__, true}
        end
    end

    return {struct__, false}
end

function inter_p(ast, struc___)

    local n = {unpack(ast)}
    local rules
    local n_struc = {struc___, true}
    local t
	
	if (#struc___ <= 0) then return c_rl_g(lex[7], 0) end
	
    while(not_empyth(n)) do
        rules = get_all_rule(n)
        for i,k in pairs(rules) do
            t = 0
            for i_, __ in pairs(rules) do
                if k[1] == __[1] then t = t+1 end
            end
            if (t > 1) then error__(5, k[1]) end
        end
        n = next_rule(n)
    end

    n_struc = (function(n_struc)
        for i=1, #n_struc[1] do
            for _=i, #n_struc[1] do
                n_struc = exp__(ast, n_struc[1], i, _)
                if (n_struc[2]) then return n_struc end
            end
        end
        return n_struc
    end) (n_struc)

    return n_struc[2] and inter_p(ast, n_struc[1]) or n_struc[1]
end

print_tabel = function(__) for k,i in pairs(__) do print(i[1].." "..i[2].." - "..i[3]) end end
function g_m()
    local s = arg ~= nil and arg[1] ~= nil and arg[1] or io.read()
    local c = s
    local g_fil = io.open (s..".gmt", "r")
    c = g_fil and g_fil:read("*all") or c
    for i,k in pairs(forb_lex) do
        c = string.gsub(c, string.char(k), " ")
    end
    local t_ = r_rules(c, {})
    if (#t_ <= 0) then error__(6) end
    local n = {unpack(t_)}
    local r = get_all_rule(t_)
    local struct_ = c_rl_g(init_rl(t_)[2], 0)
    if not pcall((function() print(t_str_form(inter_p(t_, struct_))) end)) then error__(7) end
    return true
end

g_m()
