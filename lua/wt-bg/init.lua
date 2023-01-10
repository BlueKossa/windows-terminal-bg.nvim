local WtBg = {}


function WtBg:setup(opts)
    local options = opts or {}
    self.options = options
end

local function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

function WtBg:change_setting(pattern, new_setting)

    local file = io.open(self.options.terminal_conf, "r")
    if file == nil then return end
    local content = file:read("*all")

    file:close()
    local new_content = string.gsub(content, pattern, new_setting)

    file = io.open(self.options.terminal_conf, "w")
    if file == nil then return end
    file:write(new_content)
    file:close()
end

function WtBg:set_background(bg)
    print("Setting background to " .. bg)
    if bg == nil then
        print("No background specified")
        return
    end
    local bg_path = self.options.bg_path .. bg .. ".jpg"
    local extension = ".jpg"
    if file_exists(bg_path) == false then
        print("Background does not exist")
        bg_path = self.options.bg_path .. bg .. ".png"
        extension = ".png"
        if file_exists(bg_path) == false then
            print("Background does not exist")
            return
        end
    elseif file_exists(self.options.terminal_conf) == false then
        print("Terminal config does not exist")
        return
    end
    local pattern = '"backgroundImage": "([^"]+)"'
    local content = '"backgroundImage": "' .. self.options.windows_bg_path .. bg .. extension .. '"'
    self:change_setting(pattern, content)

    print("Background set to " .. bg)
end

function WtBg:set_opacity(opacity)
    if opacity == nil then
        print("No opacity specified")
        return
    end

    local opacity_num = tonumber(opacity)
    if opacity_num == nil then
        print("Opacity is not a number")
        return
    end
    local opacity_float = opacity_num / 100
    if opacity_float < 0 or opacity_float > 1 then
        print("Opacity is not between 0 and 100%")
        return
    end

    if file_exists(self.options.terminal_conf) == false then
        print("Terminal config does not exist")
        return
    end
    local pattern = '"backgroundImageOpacity": (%d+%.?%d*)'
    local content = '"backgroundImageOpacity": ' .. opacity_float
    self:change_setting(pattern, content)

    print("Opacity set to " .. opacity_num .. "%")

end

return WtBg
