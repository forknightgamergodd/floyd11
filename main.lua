--functions diagram https://lucid.app/lucidchart/933552db-bb7c-46f5-ba18-aaa16e2f9e44/edit?invitationId=inv_3a6c9d6b-fb14-4e01-8435-cf33c2a56d4d
coce = io.open("main.floyd11"):read("*a")

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function run(coc, prevariables, sendbackvariables, destroyprevariables)
    local definingvariables = false
    local canting = false
    local cantingnum = 0
    local variables = prevariables
    local functions = {}
    local output =''
    
    for i, v in pairs(split(tostring(coc),"\n")) do
        for ivvvvv, vvvvvvvv in pairs(variables) do
        end
        line = v
        function replaceVariables(line)
            line = line:gsub("var:(%a+)", function(varname)
                return variables[varname] or ""
            end)
            
            line = line:gsub("math:(.-)", function(expression)
                return load("return " .. expression)() or ""
            end)
            line = line:gsub("rand:(%d+),(%d+)", function(min, max)
                return math.random(tonumber(min), tonumber(max)) or ""
            end)
            
            return line
        end
        if i == 1 and line == 'i' and definingvariables == false then
            definingvariables = true
        end
        if definingvariables == false and canting == true then
            if split(line, ">")[1] == "breathe" then
                if split(line, ">")[2] == "p" then
                    local parts = variables[split(line, ">")[3]]
                    output = output .. parts
                end
                if split(line, ">")[2] == "11" then
                    if split(line, ">")[3] == nil then
                        os.execute("start https://www.youtube.com/watch?v=St7ny38gLp4")
                    else
                        os.execute("start "..split(line, ">")[3])
                    end
                end
                if split(line, ">")[2] == "pc" then
                    local parts = split(line, ">")
                    output = output .. replaceVariables( table.concat(parts, " ", 3))
                end
                if split(line, ">")[2] == "extofficer" then
                    prevars = variables
                    local filelocation = variables[split(line, ">")[3]]
                    for iv, vi in pairs(split(line, ">")) do
                        if iv > 3 then
                            
                        else
                            prevars["extvar"..(vi)] = replaceVariables( tostring (split(line, ">")[iv+1] ))
                            iv= iv +2
                        end
                    end
                    local file = io.open(filelocation, "r")
                    if file then
                        local fileContents = file:read("*a")
                        file:close()
                        variables = run(fileContents, prevars, true, true)
                    end

                end
                if split(line, ">")[2] == "varinput" then
                    local name = split(line, ">")[3]
                    local parts = split(line, ">")
                    local gfd = table.concat(parts, " ", 4)
                    io.write(replaceVariables(gfd))
                    local e = io.read()
                    local nval = e
                    variables[name] = nval
                end
            elseif split(line, ">")[1] == "varchange" then
                local name = split(line, ">")[2]
                local parts = split(line, ">")
                local nval = table.concat(parts, " ", 3)
                variables[name] = replaceVariables(nval)
            end

            if split(line, "/.-")[1] == "floydif" then
                local condition = replaceVariables(split(line, "/.-")[2])
                local parts = split(line, "/.-")
                local ifcode = string.gsub(table.concat(parts, " ", 3), "||@", "\n")
                if load("return " .. condition)() then
                    print(ifcode)
                    variables = run( ifcode, variables, true, false)
                end
            end
            
            
                
        elseif definingvariables == true and i ~= 1 then
            if line == 'cant' then
                definingvariables = false
                canting = true
            else
                line = replaceVariables(line)
                local parts = split(line, " ")
                variables[parts[1]] = table.concat(parts, " ", 2)
            end
        end
    end
    if destroyprevariables == true then
        for idfgodfg, vgfhushodsrfg in pairs(variables) do
            if string.match(vgfhushodsrfg, "^extvar") then
                variables[vgfhushodsrfg] = nil
            end
        end
    end
    print(output)
    if sendbackvariables == true then
        return variables
    end
end

run(coce, {['sample']='Hello Floyd Cant breath :p'}, false, false)
