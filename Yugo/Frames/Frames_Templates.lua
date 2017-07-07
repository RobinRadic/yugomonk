local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
local Frames = Yugo:GetModule("Frames");

Frames.templates = {
	--------------------------
	---------- MAIN
	-----
	main = {
		inherits = false,
		y = 0,
		x = 0,
		height = 50,
		width = 250,
		scale = 1,
		level = 0,
		sub_level = 0,
		strata = "BACKGROUND",		
		parent = "UIParent",
		anchor = {
			this = "CENTER",
			that = "CENTER",
			to = "UIParent"
		},
		bg = {
			alpha = 1,
			texture = "Solid",
			insets = { b = 4, t = -4, l = 4, r = -4 },
			style = "SOLID",
			gradient = { a = 1, r = 1, g = 1, b = 1},
			blend = "BLEND",
			orientation = "HORIZONTAL",
			color = { a = 0.36, r = 0.33, g = 0.33, b = 0.33 }
		},
		border = {
			texture = "Yugo",
			color = { a = 1, r = 1, g = 1, b = 1 },
			size = 15
		},
	},
	--------------------------
	---------- INVISBLE
	-----
	invisible = {
		inherits = false,
		y = 0,
		x = 0,
		height = 50,
		width = 50,
		scale = 1,
		level = 0,
		sub_level = 0,
		strata = "BACKGROUND",		
		parent = "UIParent",
		anchor = {
			this = "CENTER",
			that = "CENTER",
			to = "UIParent"
		},
		bg = {
			alpha = 1,
			texture = "None",
			insets = { b = 0, t = 0, l = 0, r = 0 },
			style = "SOLID",
			gradient = { a = 1, r = 1, g = 1, b = 1},
			blend = "BLEND",
			orientation = "HORIZONTAL",
			color = { a = 0.36, r = 0.33, g = 0.33, b = 0.33 }
		},
		border = {
			texture = "None",
			color = { a = 1, r = 1, g = 1, b = 1 },
			size = 0
		},
	},
	--------------------------
	---------- ICON
	-----
	icon = {
		inherits = false,
		y = 0,
		x = 0,
		height = 50,
		width = 50,
		scale = 1,
		level = 0,
		sub_level = 0,
		strata = "BACKGROUND",		
		parent = UIParent,
		anchor = {
			this = "CENTER",
			that = "CENTER",
			to = UIParent
		},
		bg = {
			alpha = 1,
			texture = "None",
			insets = { b = 4, t = -4, l = 4, r = -4 },
			style = "SOLID",
			gradient = { a = 1, r = 1, g = 1, b = 1},
			blend = "BLEND",
			orientation = "HORIZONTAL",
			color = { a = 1, r = 1, g = 1, b = 1 }
		},
		border = {
			texture = "None",
			color = { a = 1, r = 1, g = 1, b = 1 },
			size = 0
		},	
	},
	barcontainer = {
		inherits = false,
		y = 0,
		x = 0,
		height = 50,
		width = 50,
		scale = 1,
		level = 0,
		sub_level = 0,
		strata = "BACKGROUND",		
		parent = "UIParent",
		anchor = {
			this = "CENTER",
			that = "CENTER",
			to = "UIParent"
		},
		bg = {
			alpha = 1,
			texture = "Solid",
			insets = { b = 0, t = 0, l = 0, r = 0 },
			style = "SOLID",
			gradient = { a = 1, r = 1, g = 1, b = 1},
			blend = "BLEND",
			orientation = "HORIZONTAL",
			color = { a = 1, r = 0.007, g = 0.007, b = 0.007 }
		},
		border = {
			texture = "None",
			color = { a = 1, r = 1, g = 1, b = 1 },
			size = 0
		},	
	},
	chibars = {
		inherits = "invisible",
		height = 22,
		width = 239
	},
	chi = {
		inherits = "barcontainer",
		height = 22,
		anchor = {
			to = "ChiBars"
		},
		bg = {
			gradient = { a = 1, r = 0, b = 0.58, g = 1},
			insets = { b = "4", t = -4, l = 4, r = -4 },
			color = { a = 1, r = 0, g = 0.18, b = 0.10 },
			style = "GRADIENT",
			orientation = "VERTICAL"
		},
		border = {
			size = 12,
			texture = "YugoChi"
		}
	},
	aggro = {
		inherits = "main",
		width = 480,
		height = 23,
		anchor = {
			this = "TOPLEFT",
			that = "BOTTOMLEFT"
		},
		border = {
			size = 12,
			color = { r = 0.05, g = 1, b = 0.03, a = 1 },
		},
		bg = {
			color = { a = 0.34, b = 0.03, g = 1, r = 0.05 }
		}	
	}
}