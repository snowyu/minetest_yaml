-- yaml/init.lua

local MOD_NAME = minetest.get_current_modname()
local MOD_PATH = minetest.get_modpath(MOD_NAME) .. "/"
local WORLD_PATH = minetest.get_worldpath() .. "/"

-- export the global yaml object
yaml = rawget(_G, MOD_NAME)

if (not yaml) then
  yaml = {}
  local function defaults(t1, t2)
    if (not t2) then return t1 end
    if (not t1) then return t2 end
    for k,v in pairs(t2) do
      if type(v) == "table" then
        if type(t1[k] or false) == "table" then
          defaults(t1[k] or {}, t2[k] or {})
        else
          t1[k] = v
        end
      else
        if (t1[k] == nil or type(t1[k]) ~= type(t2[k])) then t1[k] = v end
      end
    end
    return t1
  end
  yaml.defaults = defaults

  local function readFile(filepath)
    local f = io.open(filepath, "rb")
    if f then
      local content = f:read("*all")
      f:close()
      return content
    end
  end

  local function writeFile(filepath, content)
    local f = io.open(filepath, "wb")
    if f then
      f:write(content)
      f:close()
      return true
    end
  end

  yaml = dofile(MOD_PATH .. "/yaml/yaml.lua")

  local function readYamlFile(filepath)
    local content = readFile(filepath)
    if content then
      local result = yaml.eval(content)
      return result
    end
  end
  yaml.readFile = readYamlFile

  local function readModConfig(filename, modPath)
    if modPath then
      if modPath:sub(-1) ~= "/" then modPath = modPath .. "/" end
      return readYamlFile(modPath .. filename)
    end
  end
  yaml.readModConfig = readModConfig

  local function readWorldConfig(filename)
    return readYamlFile(WORLD_PATH .. filename)
  end
  yaml.readWorldConfig = readWorldConfig

  yaml.readConfig = function(filename, modPath)
    local modConf = readModConfig(filename, modPath)
    local worldConf = readWorldConfig(filename)
    return defaults(worldConf, modConf)
  end

  local function writeYamlFile(filepath, content)
    content = yaml.dump(content)
    if content then
      local result = writeFile(filepath, content)
      return result
    end
  end
  yaml.writeFile = writeYamlFile

  local function writeModConfig(filename, content, modPath)
    if modPath then
      if modPath:sub(-1) ~= "/" then modPath = modPath .. "/" end
      return writeYamlFile(modPath .. filename, content)
    end
  end
  yaml.writeModConfig = writeModConfig

  local function writeWorldConfig(filename, content)
    return writeYamlFile(WORLD_PATH .. filename, content)
  end
  yaml.writeWorldConfig = writeWorldConfig
  yaml.writeConfig = writeWorldConfig

end

