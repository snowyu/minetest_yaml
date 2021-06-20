# Minetest YAML Config Library Mod

[![ContentDB](https://content.minetest.net/packages/snowyu/yaml/shields/title/)](https://content.minetest.net/packages/snowyu/yaml/)

Sample YAML Config Format:

```yaml
# totalPlayTime unit is minute
totalPlayTime: 30
# Whether skip the question which has already be answered correctly.
skipAnswered: 1
# checkInterval unit is seconds
checkInterval: 10
# idleInterval unit is minute
idleInterval: 1
quiz: # question list
  - id: favorColor
    title: "What's my favor color?"
    answer: red
  - id: theYear
  - title: "What's the year?"
    answer: 2021
```

## Usage

```lua
local MOD_NAME = minetest.get_current_modname()
-- load config from file,
-- first load the my-config.yml file in mod directory as default settings
-- then try to load from world directory:
-- the filename in the world folder is MOD_NAME .. "_my-config.yml"
local settings = yaml.readConfig(MOD_NAME, "my-config.yml")
-- save the config file to world directory
-- the default filename is "config.yml" if filename not exists
-- the filename in the world folder is MOD_NAME .. "_" .."my_config.yml"
yaml.writeConfig(settings, "my-config.yml")# totalPlayTime unit is minute
```

## API

* yaml.readConfig(modName, filename = "config.yml")
  * first load the yaml file in mod directory as default settings
  * then load file from world directory
  * return merge the two settings together at last
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
  * return target
* yaml.readFile(filepath)
  * read whole file
  * return content if successful
* yaml.writeFile(filepath, content)
  * return true if successful

Using the [lua-yaml](https://github.com/exosite/lua-yaml) as yaml parser.
