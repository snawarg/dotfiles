hl.on("hyprland.start", function()
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("swaync")

  local function awww_has_wallpaper()
    local handle = io.popen("find " ..os.getenv("HOME") .. "/.cache/awww -type f | head -1")
    if not handle then return false end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
  end

  if not awww_has_wallpaper() then
    hl.exec_cmd("sleep 1 && awww img " .. os.getenv("HOME") .. "/.config/wallpapers/dark-purple-cyberpunk.jpg")
  end
end)
