# Minetest YAML Config Library Mod

## Usage

```lua
local MOD_NAME = minetest.get_current_modname()
-- load config from file,
-- first load the my-config.yml file in mod directory as default settings
-- then try to load from world directory:
-- the filename in the world folder is MOD_NAME .. "_my-config.yml"
local settings = yaml.readConfig(MOD_NAME, "my-config.yml")
-- save the config file to world directory
-- the default filename is "config.yml"
-- the filename in the world folder is MOD_NAME .. "_" .."config.yml"
yaml.writeConfig(settings)
```

## API

* yaml.readConfig(modName, filename = "config.yml")
  * first load the file in mod directory as default settings
  * then load from world directory
  * merge the settings at last
* yaml.writeConfig(settings, filename = "config.yml", modName)
  * save the config file to the world directory
* yaml.readYamlFile(filepath)
  * read a YAML format file
* yaml.readModConfig(filename, modName)
* yaml.readWorldConfig(filename)
* yaml.writeYamlFile(filepath, content)
* yaml.writeModConfig(filename, content, modName)
* yaml.writeWorldConfig(content, filename)
* yaml.defaults(target, default)
  * merge the default to the target table
* yaml.readFile(filepath)
  * read whole file
  * return content if successful
* yaml.writeFile(filepath)
  * return true if successful
