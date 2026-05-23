-- Hyprland 0.55 Lua configuration.
-- Legacy hyprlang files are kept for compatibility, but this file is the
-- config Hyprland 0.55+ loads by default.

local terminal = [[uwsm-app -- xdg-terminal-exec]]
local browser = [[omarchy-launch-browser]]

local function read_theme_var(name, fallback)
	local path = os.getenv("HOME") .. "/.config/omarchy/current/theme/hyprland.conf"
	local file = io.open(path, "r")
	if not file then
		return fallback
	end

	for line in file:lines() do
		local value = line:match("^%s*%$" .. name .. "%s*=%s*(.-)%s*$")
		if value and value ~= "" then
			file:close()
			return value
		end
	end

	file:close()
	return fallback
end

local active_border_color = read_theme_var("activeBorderColor", "rgba(33ccffee) rgba(00ff99ee) 45deg")
local inactive_border_color = read_theme_var("inactiveBorderColor", "rgba(595959aa)")

local function bind(keys, dispatcher, description, opts)
	opts = opts or {}
	if description then
		opts.description = description
	end
	return hl.bind(keys, dispatcher, opts)
end

local function bind_exec(keys, description, command, opts)
	return bind(keys, hl.dsp.exec_cmd(command), description, opts)
end

local function dispatch_many(...)
	local dispatchers = { ... }
	return function()
		for _, dispatcher in ipairs(dispatchers) do
			hl.dispatch(dispatcher)
		end
	end
end

-- Monitors -------------------------------------------------------------------
hl.env("GDK_SCALE", "auto")
hl.monitor({ output = "", mode = "2160x1440@60", position = "auto", scale = "1" })

-- Environment ----------------------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCOMPOSEFILE", "~/.XCompose")
hl.env("HYPRCURSOR_THEME", "WinSur-dark-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "WinSur-dark-cursors")
hl.env("XCURSOR_SIZE", "24")

-- Options --------------------------------------------------------------------
hl.config({
	render = {
		cm_enabled = false,
	},

	cursor = {
		hide_on_key_press = true,
		no_hardware_cursors = true,
		warp_on_change_workspace = 1,
	},

	xwayland = {
		force_zero_scaling = true,
	},

	ecosystem = {
		no_update_news = true,
	},

	general = {
		resize_on_border = true,
		layout = "scrolling",
		gaps_out = 5,
		gaps_in = 5,
		hover_icon_on_border = true,
		border_size = 1,
		allow_tearing = false,
		col = {
			active_border = active_border_color,
			inactive_border = inactive_border_color,
		},
	},

	decoration = {
		rounding = 15,
		rounding_power = 4,
		active_opacity = 1,
		inactive_opacity = 1,
		shadow = {
			enabled = false,
			range = 22,
			render_power = 2,
			color = "rgba(01010190)",
		},
		blur = {
			enabled = true,
			size = 9,
			passes = 5,
			ignore_opacity = true,
			xray = false,
			new_optimizations = true,
			contrast = 1.2,
			brightness = 0.8,
			special = true,
		},
	},

	group = {
		col = {
			border_active = active_border_color,
			border_inactive = inactive_border_color,
			border_locked_active = active_border_color,
			border_locked_inactive = inactive_border_color,
		},
		groupbar = {
			font_size = 12,
			font_family = "monospace",
			font_weight_active = "ultraheavy",
			font_weight_inactive = "normal",
			indicator_height = 0,
			indicator_gap = 5,
			height = 22,
			gaps_in = 5,
			gaps_out = 0,
			text_color = "rgb(ffffff)",
			text_color_inactive = "rgba(ffffff90)",
			col = {
				active = "rgba(00000040)",
				inactive = "rgba(00000020)",
			},
			gradients = true,
			gradient_rounding = 0,
			gradient_round_only_edges = false,
		},
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape,compose:menu",
		kb_rules = "",
		follow_mouse = 1,
		repeat_rate = 40,
		repeat_delay = 600,
		numlock_by_default = true,
		sensitivity = 0.30,
		touchpad = {
			natural_scroll = false,
			clickfinger_behavior = true,
			scroll_factor = 0.4,
			disable_while_typing = true,
		},
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},

	master = {
		new_status = "master",
	},

	scrolling = {
		column_width = 0.95,
		fullscreen_on_one_column = false,
		focus_fit_method = 0,
		follow_focus = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_scale_notification = true,
		focus_on_activate = true,
		anr_missed_pings = 3,
		on_focus_under_fullscreen = 1,
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},

	binds = {
		hide_special_on_workspace_change = true,
	},
})

-- Animations -----------------------------------------------------------------
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "smooth", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 2, bezier = "smooth", style = "slidefadevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "smooth", style = "slidefadevert" })

-- Autostart ------------------------------------------------------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm-app -- hypridle")
	hl.exec_cmd("uwsm-app -- mako")
	hl.exec_cmd("! omarchy-toggle-enabled waybar-off && uwsm-app -- waybar")
	hl.exec_cmd("uwsm-app -- fcitx5 --disable notificationitem")
	hl.exec_cmd("uwsm-app -- swaybg -i ~/.config/omarchy/current/background -m fill")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("omarchy-first-run")
	hl.exec_cmd("omarchy-powerprofiles-init")
	hl.exec_cmd("uwsm-app -- omarchy-hyprland-monitor-watch")
	hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("sleep 2 && omarchy-hook post-boot")
	hl.exec_cmd("nwg-dock-hyprland -i 48 -nolauncher -mb 10 -mt 2 -w 15 -d -hd 0 -hdd 20")
	-- hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("vicinae server")
end)

-- Window rules ---------------------------------------------------------------
hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = ".*" }, tag = "+default-opacity" })
hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({ match = { class = "^(1[p|P]assword)$" }, no_screen_share = true, tag = "+floating-window" })
hl.window_rule({ match = { class = "^(Bitwarden)$" }, no_screen_share = true, tag = "+floating-window" })
hl.window_rule({
	match = { class = "chrome-nngceckbapebfimnlniiiahkandclblb-Default" },
	no_screen_share = true,
	tag = "+floating-window",
})

hl.window_rule({
	match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser|[mM]icrosoft-edge|Vivaldi-stable|helium)" },
	tag = "+chromium-based-browser",
})
hl.window_rule({ match = { class = "([fF]irefox|zen|librewolf)" }, tag = "+firefox-based-browser" })
hl.window_rule({ match = { tag = "chromium-based-browser" }, tag = "-default-opacity" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, tag = "-default-opacity" })
hl.window_rule({
	match = { class = "(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)" },
	tag = "-chromium-based-browser",
})
hl.window_rule({
	match = { class = "(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)" },
	tag = "-default-opacity",
})
hl.window_rule({ match = { tag = "chromium-based-browser" }, tile = true })
hl.window_rule({ match = { tag = "chromium-based-browser" }, opacity = "1.0 0.97" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "1.0 0.97" })
hl.window_rule({ match = { title = ".*is sharing.*" }, workspace = "special silent" })

hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.window_rule({ name = "jetbrains-focus", match = { class = "^(jetbrains-.*)$" }, no_follow_mouse = true })
hl.window_rule({ match = { class = "(Share|localsend)" }, float = true, center = true, size = { 1100, 700 } })
hl.window_rule({ name = "geforce", match = { class = "GeForceNOW" }, idle_inhibit = "fullscreen" })
hl.window_rule({
	name = "moonlight",
	match = { class = "com.moonlight_stream.Moonlight" },
	fullscreen = true,
	idle_inhibit = "fullscreen",
})

hl.window_rule({ match = { title = "(Picture.?in.?[Pp]icture)" }, tag = "+pip" })
hl.window_rule({ match = { tag = "pip" }, tag = "-default-opacity" })
hl.window_rule({
	match = { tag = "pip" },
	float = true,
	pin = true,
	size = { 600, 338 },
	keep_aspect_ratio = true,
	border_size = 0,
	opacity = "1 1",
	move = { "monitor_w-window_w-40", "monitor_h*0.04" },
})

hl.window_rule({ match = { class = "qemu" }, tag = "-default-opacity", opacity = "1 1" })
hl.window_rule({
	match = { class = "com.libretro.RetroArch" },
	fullscreen = true,
	tag = "-default-opacity",
	opacity = "1 1",
	idle_inhibit = "fullscreen",
})
hl.window_rule({ match = { class = "steam" }, float = true, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "steam", title = "Steam" }, center = true, size = { 1100, 700 } })
hl.window_rule({ match = { class = "steam.*" }, tag = "-default-opacity", opacity = "1 1" })
hl.window_rule({ match = { class = "steam", title = "Friends List" }, size = { 460, 800 } })

hl.window_rule({ match = { tag = "floating-window" }, float = true, center = true, size = { 875, 600 } })
hl.window_rule({
	match = {
		class = "(org.omarchy.bluetui|org.omarchy.impala|org.omarchy.wiremix|org.omarchy.btop|org.omarchy.terminal|org.omarchy.bash|org.codeberg.dnkl.foot|org.gnome.NautilusPreviewer|org.gnome.Evince|com.gabm.satty|Omarchy|About|TUI.float|imv|mpv)",
	},
	tag = "+floating-window",
})
hl.window_rule({
	match = {
		class = "(xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus)",
		title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
	},
	tag = "+floating-window",
})
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
hl.window_rule({ match = { class = "org.omarchy.screensaver" }, fullscreen = true, float = true, animation = "slide" })
hl.window_rule({
	match = {
		class = "^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$",
	},
	tag = "-default-opacity",
	opacity = "1 1",
})
hl.window_rule({ match = { tag = "pop" }, rounding = 8 })
hl.window_rule({ match = { tag = "noidle" }, idle_inhibit = "always" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, focus_on_activate = false })
hl.window_rule({ match = { class = "(Alacritty|kitty|com.mitchellh.ghostty|foot)" }, tag = "+terminal" })
hl.window_rule({ match = { tag = "terminal" }, tag = "-default-opacity", opacity = "0.97 0.9" })
hl.window_rule({ match = { class = "^Typora$", title = "^Print$" }, float = true, center = true })
hl.layer_rule({ match = { namespace = "walker" }, no_anim = true })
hl.window_rule({
	match = { title = "WebcamOverlay" },
	float = true,
	pin = true,
	no_initial_focus = true,
	no_dim = true,
	move = { "monitor_w-window_w-40", "monitor_h-window_h-40" },
})

hl.window_rule({
	name = "all-opaque-no-blur",
	match = { class = ".*" },
	opaque = true,
	no_blur = true,
	opacity = "1.0 override 1.0 override",
})
hl.window_rule({ match = { class = "(Alacritty|kitty)" }, scroll_touchpad = 1.5 })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, scroll_touchpad = 0.2 })
hl.window_rule({ match = { class = "localsend" }, size = { 1100, 700 } })
hl.window_rule({ match = { class = "org.gnome.Evince" }, size = { 1100, 700 } })
hl.window_rule({ name = "scrcpy-size", match = { class = "^(scrcpy)$" }, float = true })
hl.window_rule({
	name = "gtk-portal",
	match = { class = "^(xdg-desktop-portal-gtk)$" },
	float = true,
	size = { "monitor_w/2", "monitor_h/2" },
})
hl.window_rule({ name = "hyprland-share-picker-float", match = { class = "^(hyprland-share-picker)$" }, float = true })
hl.window_rule({ name = "scratchpad-blur", match = { workspace = "special:scratchpad" }, no_blur = false })
hl.window_rule({ name = "tile-localsend", match = { class = "^(localsend)$" }, float = false, tile = true })
hl.window_rule({ match = { class = "(foot|footclient)" }, tag = "+terminal" })
hl.window_rule({ match = { tag = "default-opacity" }, opacity = "0.97 0.9" })

hl.layer_rule({ name = "hyprlock-no-anim", match = { namespace = "hyprlock" }, no_anim = true })
hl.layer_rule({ name = "dock-animation", match = { namespace = "nwg-dock" }, animation = "popin 80%" })
hl.layer_rule({ name = "vicinae-animation", match = { namespace = "vicinae" }, animation = "popin 80%" })

-- Keybindings ----------------------------------------------------------------
bind_exec(
	"XF86AudioRaiseVolume",
	"Volume up",
	"omarchy-swayosd-client --output-volume raise",
	{ locked = true, repeating = true }
)
bind_exec(
	"XF86AudioLowerVolume",
	"Volume down",
	"omarchy-swayosd-client --output-volume lower",
	{ locked = true, repeating = true }
)
bind_exec(
	"XF86AudioMute",
	"Mute",
	"omarchy-swayosd-client --output-volume mute-toggle",
	{ locked = true, repeating = true }
)
bind_exec("XF86AudioMicMute", "Mute microphone", "omarchy-audio-input-mute", { locked = true, repeating = true })
bind_exec("XF86MonBrightnessUp", "Brightness up", "omarchy-brightness-display +5%", { locked = true, repeating = true })
bind_exec(
	"XF86MonBrightnessDown",
	"Brightness down",
	"omarchy-brightness-display 5%-",
	{ locked = true, repeating = true }
)
bind_exec(
	"SHIFT + XF86MonBrightnessUp",
	"Brightness maximum",
	"omarchy-brightness-display 100%",
	{ locked = true, repeating = true }
)
bind_exec(
	"SHIFT + XF86MonBrightnessDown",
	"Brightness minimum",
	"omarchy-brightness-display 1%",
	{ locked = true, repeating = true }
)
bind_exec(
	"XF86KbdBrightnessUp",
	"Keyboard brightness up",
	"omarchy-brightness-keyboard up",
	{ locked = true, repeating = true }
)
bind_exec(
	"XF86KbdBrightnessDown",
	"Keyboard brightness down",
	"omarchy-brightness-keyboard down",
	{ locked = true, repeating = true }
)
bind_exec("XF86KbdLightOnOff", "Keyboard backlight cycle", "omarchy-brightness-keyboard cycle", { locked = true })
bind_exec("XF86TouchpadToggle", "Toggle touchpad", "omarchy-toggle-touchpad", { locked = true })
bind_exec("XF86TouchpadOn", "Enable touchpad", "omarchy-toggle-touchpad on", { locked = true })
bind_exec("XF86TouchpadOff", "Disable touchpad", "omarchy-toggle-touchpad off", { locked = true })
bind_exec(
	"ALT + XF86AudioRaiseVolume",
	"Volume up precise",
	"omarchy-swayosd-client --output-volume +1",
	{ locked = true, repeating = true }
)
bind_exec(
	"ALT + XF86AudioLowerVolume",
	"Volume down precise",
	"omarchy-swayosd-client --output-volume -1",
	{ locked = true, repeating = true }
)
bind_exec(
	"ALT + XF86MonBrightnessUp",
	"Brightness up precise",
	"omarchy-brightness-display +1%",
	{ locked = true, repeating = true }
)
bind_exec(
	"ALT + XF86MonBrightnessDown",
	"Brightness down precise",
	"omarchy-brightness-display 1%-",
	{ locked = true, repeating = true }
)
bind_exec("XF86AudioNext", "Next track", "omarchy-swayosd-client --playerctl next", { locked = true })
bind_exec("XF86AudioPause", "Pause", "omarchy-swayosd-client --playerctl play-pause", { locked = true })
bind_exec("XF86AudioPlay", "Play", "omarchy-swayosd-client --playerctl play-pause", { locked = true })
bind_exec("XF86AudioPrev", "Previous track", "omarchy-swayosd-client --playerctl previous", { locked = true })
bind_exec("SUPER + XF86AudioMute", "Switch audio output", "omarchy-audio-output-switch", { locked = true })

bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert", window = "activewindow" }), "Universal copy")
bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert", window = "activewindow" }), "Universal paste")
bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X", window = "activewindow" }), "Universal cut")
bind_exec("SUPER + CTRL + V", "Clipboard manager", "omarchy-launch-walker -m clipboard")

bind("SUPER + W", hl.dsp.window.close(), "Close window")
bind_exec("CTRL + ALT + DELETE", "Close all windows", "omarchy-hyprland-window-close-all")
bind("SUPER + J", hl.dsp.layout("togglesplit"), "Toggle window split")
bind("SUPER + P", hl.dsp.window.pseudo(), "Pseudo window")
bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), "Toggle window floating/tiling")
bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), "Full screen")
bind(
	"SUPER + CTRL + F",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }),
	"Tiled full screen"
)
bind("SUPER + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), "Full width")
bind_exec("SUPER + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")
bind_exec("SUPER + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }), "Focus on left window")
bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }), "Focus on right window")
bind("SUPER + UP", hl.dsp.focus({ direction = "u" }), "Focus on above window")
bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }), "Focus on below window")

for i = 1, 10 do
	local keycode = "code:" .. (i + 9)
	bind("SUPER + " .. keycode, hl.dsp.focus({ workspace = i }), "Switch to workspace " .. i)
	bind("SUPER + SHIFT + " .. keycode, hl.dsp.window.move({ workspace = i }), "Move window to workspace " .. i)
	bind(
		"SUPER + SHIFT + ALT + " .. keycode,
		hl.dsp.window.move({ workspace = i }),
		"Move window silently to workspace " .. i
	)
	bind(
		"SUPER + CTRL + SHIFT + " .. keycode,
		hl.dsp.layout("movecoltoworkspace " .. i),
		"Move column to workspace " .. i
	)
end

bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"), "Toggle scratchpad")
bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }), "Move window to scratchpad")
bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")
bind("SUPER + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }), "Former workspace")
bind("SUPER + SHIFT + ALT + LEFT", hl.dsp.workspace.move({ monitor = "l" }), "Move workspace to left monitor")
bind("SUPER + SHIFT + ALT + RIGHT", hl.dsp.workspace.move({ monitor = "r" }), "Move workspace to right monitor")
bind("SUPER + SHIFT + ALT + UP", hl.dsp.workspace.move({ monitor = "u" }), "Move workspace to up monitor")
bind("SUPER + SHIFT + ALT + DOWN", hl.dsp.workspace.move({ monitor = "d" }), "Move workspace to down monitor")
bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }), "Swap window to the left")
bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }), "Swap window to the right")
bind("SUPER + SHIFT + UP", hl.dsp.window.swap({ direction = "u" }), "Swap window up")
bind("SUPER + SHIFT + DOWN", hl.dsp.window.swap({ direction = "d" }), "Swap window down")
bind("ALT + TAB", dispatch_many(hl.dsp.window.cycle_next(), hl.dsp.window.bring_to_top()), "Focus on next window")
bind(
	"ALT + SHIFT + TAB",
	dispatch_many(hl.dsp.window.cycle_next({ next = false }), hl.dsp.window.bring_to_top()),
	"Focus on previous window"
)
bind("CTRL + ALT + TAB", hl.dsp.focus({ monitor = "+1" }), "Focus on next monitor")
bind("CTRL + ALT + SHIFT + TAB", hl.dsp.focus({ monitor = "-1" }), "Focus on previous monitor")
bind("SUPER + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), "Expand window left")
bind("SUPER + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), "Shrink window left")
bind("SUPER + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), "Shrink window up")
bind("SUPER + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), "Expand window down")
bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Scroll active workspace forward")
bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "Scroll active workspace backward")
bind("SUPER + mouse:272", hl.dsp.window.drag(), "Move window", { mouse = true })
bind("SUPER + mouse:273", hl.dsp.window.resize(), "Resize window", { mouse = true })
bind("SUPER + G", hl.dsp.group.toggle(), "Toggle window grouping")
bind("SUPER + ALT + G", hl.dsp.window.move({ out_of_group = true }), "Move active window out of group")
bind("SUPER + ALT + LEFT", hl.dsp.window.move({ into_group = "l" }), "Move window to group on left")
bind("SUPER + ALT + RIGHT", hl.dsp.window.move({ into_group = "r" }), "Move window to group on right")
bind("SUPER + ALT + UP", hl.dsp.window.move({ into_group = "u" }), "Move window to group on top")
bind("SUPER + ALT + DOWN", hl.dsp.window.move({ into_group = "d" }), "Move window to group on bottom")
bind("SUPER + ALT + TAB", hl.dsp.group.next(), "Next window in group")
bind("SUPER + ALT + SHIFT + TAB", hl.dsp.group.prev(), "Previous window in group")
bind("SUPER + CTRL + LEFT", hl.dsp.group.prev(), "Move grouped window focus left")
bind("SUPER + CTRL + RIGHT", hl.dsp.group.next(), "Move grouped window focus right")
bind("SUPER + ALT + mouse_down", hl.dsp.group.next(), "Next window in group")
bind("SUPER + ALT + mouse_up", hl.dsp.group.prev(), "Previous window in group")
for i = 1, 5 do
	bind("SUPER + ALT + code:" .. (i + 9), hl.dsp.group.active({ index = i }), "Switch to group window " .. i)
end
bind_exec("SUPER + code:61", "Cycle monitor scaling", "omarchy-hyprland-monitor-scaling-cycle")
bind_exec(
	"SUPER + ALT + code:61",
	"Cycle monitor scaling backwards",
	"omarchy-hyprland-monitor-scaling-cycle --reverse"
)

bind_exec("SUPER + SPACE", "Launch apps", "omarchy-launch-walker")
bind_exec("SUPER + CTRL + E", "Emoji picker", "omarchy-launch-walker -m symbols")
bind_exec("SUPER + CTRL + C", "Capture menu", "omarchy-menu capture")
bind_exec("SUPER + CTRL + O", "Toggle menu", "omarchy-menu toggle")
bind_exec("SUPER + CTRL + H", "Hardware menu", "omarchy-menu hardware")
bind_exec("SUPER + ALT + SPACE", "Omarchy menu", "omarchy-menu")
bind_exec("SUPER + SHIFT + code:201", "Omarchy menu", "omarchy-menu")
bind_exec("SUPER + ESCAPE", "System menu", "omarchy-menu system")
bind_exec("XF86PowerOff", "Power menu", "omarchy-menu system", { locked = true })
bind_exec("SUPER + K", "Show key bindings", "omarchy-menu-keybindings")
bind_exec("XF86Calculator", "Calculator", "gnome-calculator")
bind_exec("SUPER + SHIFT + SPACE", "Toggle top bar", "omarchy-toggle-waybar")
bind_exec("SUPER + CTRL + SPACE", "Theme background menu", "omarchy-menu background")
bind_exec("SUPER + SHIFT + CTRL + SPACE", "Theme menu", "omarchy-menu theme")
bind_exec("SUPER + BACKSPACE", "Toggle window transparency", "omarchy-hyprland-window-transparency-toggle")
bind_exec("SUPER + SHIFT + BACKSPACE", "Toggle window gaps", "omarchy-hyprland-window-gaps-toggle")
bind_exec(
	"SUPER + CTRL + BACKSPACE",
	"Toggle single-window square aspect",
	"omarchy-hyprland-window-single-square-aspect-toggle"
)
bind_exec("SUPER + COMMA", "Dismiss last notification", "makoctl dismiss")
bind_exec("SUPER + SHIFT + COMMA", "Dismiss all notifications", "makoctl dismiss --all")
bind_exec("SUPER + CTRL + COMMA", "Toggle silencing notifications", "omarchy-toggle-notification-silencing")
bind_exec("SUPER + ALT + COMMA", "Invoke last notification", "makoctl invoke")
bind_exec("SUPER + SHIFT + ALT + COMMA", "Restore last notification", "makoctl restore")
bind_exec("SUPER + CTRL + I", "Toggle locking on idle", "omarchy-toggle-idle")
bind_exec("SUPER + CTRL + N", "Toggle nightlight", "omarchy-toggle-nightlight")
bind_exec("SUPER + CTRL + Delete", "Toggle laptop display", "omarchy-hyprland-monitor-internal toggle")
bind_exec(
	"SUPER + CTRL + ALT + Delete",
	"Toggle laptop display mirroring",
	"omarchy-hyprland-monitor-internal-mirror toggle"
)
bind_exec(
	"switch:on:Lid Switch",
	nil,
	"omarchy-hw-external-monitors && omarchy-hyprland-monitor-internal off",
	{ locked = true }
)
bind_exec("switch:off:Lid Switch", nil, "omarchy-hyprland-monitor-internal on", { locked = true })
bind_exec("PRINT", "Screenshot", "omarchy-capture-screenshot")
bind_exec("ALT + PRINT", "Screenrecording", "omarchy-menu screenrecord")
bind_exec("SUPER + PRINT", "Color picker", "pkill hyprpicker || hyprpicker -a")
bind_exec("SUPER + CTRL + PRINT", "Extract text (OCR) from screenshot", "omarchy-capture-text-extraction")
bind_exec("SUPER + CTRL + S", "Share", "omarchy-menu share")
bind_exec("SUPER + CTRL + PERIOD", "Transcode", "omarchy-transcode")
bind_exec("SUPER + CTRL + R", "Set reminder", "omarchy-menu reminder-set")
bind_exec("SUPER + CTRL + ALT + R", "Show reminders", "omarchy-reminder show")
bind_exec("SUPER + SHIFT + CTRL + R", "Clear reminders", "omarchy-reminder clear")
bind_exec(
	"SUPER + CTRL + ALT + T",
	"Show time",
	[[notify-send -u low "    $(date +"%A %H:%M  ·  %d %B %Y  ·  Week %V")"]]
)
bind_exec("SUPER + CTRL + ALT + B", "Show battery remaining", [[notify-send -u low "$(omarchy-battery-status)"]])
bind_exec("SUPER + CTRL + ALT + W", "Show weather", [[notify-send -u low "$(omarchy-weather-status)"]])
bind_exec("SUPER + CTRL + A", "Audio controls", "omarchy-launch-audio")
bind_exec("SUPER + CTRL + B", "Bluetooth controls", "omarchy-launch-bluetooth")
bind_exec("SUPER + CTRL + W", "Wifi controls", "omarchy-launch-wifi")
bind_exec("SUPER + CTRL + T", "Activity", "omarchy-launch-tui btop")
bind_exec("SUPER + CTRL + X", "Toggle dictation", "voxtype record toggle")
bind_exec("F9", "Start dictation (push-to-talk)", "voxtype record start")
bind_exec("F9", "Stop dictation (push-to-talk)", "voxtype record stop", { release = true })
bind_exec(
	"SUPER + CTRL + Z",
	"Zoom in",
	"hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float + 1')"
)
bind_exec("SUPER + CTRL + ALT + Z", "Reset zoom", "hyprctl keyword cursor:zoom_factor 1")
bind_exec("SUPER + CTRL + L", "Lock system", "omarchy-system-lock")

-- User overrides -------------------------------------------------------------
bind_exec("SUPER + ALT + RETURN", "Terminal", terminal .. [[ --dir="$(omarchy-cmd-terminal-cwd)"]])
bind_exec("SUPER + RETURN", "Tmux", [[uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new]])
bind_exec("SUPER + SHIFT + RETURN", "Browser", "omarchy-launch-browser")
bind_exec("SUPER + SHIFT + B", "Browser", browser)
bind_exec("SUPER + SHIFT + F", "File manager", "uwsm-app -- nautilus --new-window")
bind_exec(
	"SUPER + ALT + SHIFT + F",
	"File manager (cwd)",
	[[uwsm-app -- nautilus --new-window "$(omarchy-cmd-terminal-cwd)"]]
)
bind_exec("SUPER + SHIFT + M", "Music", "omarchy-launch-or-focus spotify")
bind_exec("SUPER + SHIFT + N", "Editor", "omarchy-launch-editor")
bind_exec("SUPER + SHIFT + V", "Discord", "vesktop")
bind_exec("SUPER + SHIFT + O", "Obsidian", [[omarchy-launch-or-focus "^obsidian$" "uwsm-app -- obsidian"]])

bind_exec("SUPER + D", nil, "$(omarchy-restart-nwg-dock)")
-- bind_exec("SUPER + grave", "Window switch", "vicinae vicinae://launch/wm/switch-windows")
--
-- hl.unbind("SUPER + SPACE")
-- bind_exec("SUPER + SPACE", nil, "vicinae toggle")
-- hl.unbind("SUPER + ALT + SPACE")
-- bind_exec("SUPER + ALT + SPACE", nil, "vicinae vicinae://launch/@codingcodax/store.vicinae.omarchy-menu/index")
-- hl.unbind("SUPER + CTRL + E")
-- bind_exec("SUPER + CTRL + E", "Emoji picker", "vicinae vicinae://launch/core/search-emojis")
-- hl.unbind("SUPER + ESCAPE")
-- bind_exec(
-- 	"SUPER + ESCAPE",
-- 	"Power profiles",
-- 	"vicinae vicinae://launch/@botkooper/store.vicinae.power-profile/power-profile"
-- )
-- hl.unbind("SUPER + CTRL + A")
-- bind_exec(
-- 	"SUPER + CTRL + A",
-- 	"Audio controls",
-- 	"vicinae vicinae://launch/@rastsislaux/store.vicinae.pulseaudio/pulseaudio"
-- )
-- hl.unbind("SUPER + CTRL + W")
-- bind_exec(
-- 	"SUPER + CTRL + W",
-- 	"Wifi controls",
-- 	"vicinae vicinae://launch/@dagimg-dot/store.vicinae.wifi-commander/scan-wifi"
-- )
-- hl.unbind("SUPER + CTRL + B")
-- bind_exec("SUPER + CTRL + B", "Bluetooth", "vicinae vicinae://extensions/Gelei/bluetooth")
-- hl.unbind("SUPER + CTRL + V")
-- bind_exec("SUPER + CTRL + V", "Clipboard", "vicinae vicinae://launch/clipboard/history")
-- hl.unbind("XF86PowerOff")
-- bind_exec(
-- 	"XF86PowerOff",
-- 	"Power menu",
-- 	"vicinae vicinae://launch/@codingcodax/store.vicinae.omarchy-menu/system",
-- 	{ locked = true }
-- )

hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
bind("SUPER + LEFT", hl.dsp.layout("focus l"), "Move window focus left")
bind("SUPER + RIGHT", hl.dsp.layout("focus r"), "Move window focus right")
bind("SUPER + UP", hl.dsp.layout("focus u"), "Move window focus up")
bind("SUPER + DOWN", hl.dsp.layout("focus d"), "Move window focus down")

hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + RIGHT")
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + DOWN")
bind("SUPER + SHIFT + LEFT", hl.dsp.layout("movewindowto l"), "Move window left")
bind("SUPER + SHIFT + RIGHT", hl.dsp.layout("movewindowto r"), "Move window right")
bind("SUPER + SHIFT + UP", hl.dsp.layout("movewindowto u"), "Move window up")
bind("SUPER + SHIFT + DOWN", hl.dsp.layout("movewindowto d"), "Move window down")

hl.unbind("SUPER + code:20")
hl.unbind("SUPER + code:21")
hl.unbind("SUPER + SHIFT + code:20")
hl.unbind("SUPER + SHIFT + code:21")
bind("SUPER + code:20", hl.dsp.layout("colresize -0.05"), "Shrink column")
bind("SUPER + code:21", hl.dsp.layout("colresize +0.05"), "Expand column")
bind("SUPER + SHIFT + code:20", hl.dsp.layout("colresize -conf"), "Previous preset width")
bind("SUPER + SHIFT + code:21", hl.dsp.layout("colresize +conf"), "Next preset width")
bind("SUPER + SHIFT + G", hl.dsp.layout("togglefit"), "Toggle fit/center mode")

hl.unbind("SUPER + P")
hl.unbind("SUPER + J")
bind("SUPER + P", hl.dsp.layout("promote"), "Promote window to new column")
bind("SUPER + J", hl.dsp.layout("fit active"), "Fit active column")
bind("SUPER + CTRL + SHIFT + LEFT", hl.dsp.layout("swapcol l"), "Swap column left")
bind("SUPER + CTRL + SHIFT + RIGHT", hl.dsp.layout("swapcol r"), "Swap column right")
bind("SUPER + bracketleft", hl.dsp.layout("move -col"), "Scroll layout left")
bind("SUPER + bracketright", hl.dsp.layout("move +col"), "Scroll layout right")

-- Trackpad gestures ----------------------------------------------------------
hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "left",
	action = function()
		hl.dispatch(hl.dsp.layout("move -col"))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "right",
	action = function()
		hl.dispatch(hl.dsp.layout("move +col"))
	end,
})
hl.gesture({ fingers = 4, direction = "up", action = "special", workspace_name = "scratchpad" })
hl.gesture({ fingers = 4, direction = "down", action = "special", workspace_name = "scratchpad" })
