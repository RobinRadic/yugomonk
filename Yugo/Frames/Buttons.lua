local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
Yugo.Buttons = {}

local SML = LibStub("LibSharedMedia-3.0")

Yugo.Buttons.templates = {
	close = {
		inherits = false,
		template = "UIPanelCloseButton",
		anchor = {
			this = "TOPRIGHT",
			that = "TOPRIGHT",
			to = UIParent,
			offsets = {
				x = 0,
				y = 0
			}
		},
		x = 0,
		y = 0,
		parent = UIParent,
		height = 30,
		width = 30,
		textures = false
	},
	lock = {
		inherits = "close",
		textures = {
			disabled = "Interface\\BUTTONS\\LockButton-Locked-Up.blp",
			normal = "Interface\\BUTTONS\\LockButton-UnLocked-Up.blp",
			pushed = "Interface\\BUTTONS\\LockButton-Unlocked-Down.blp",
			highlight = false
		}
	},
	info = {
		inherits = "close",
		template = "UIPanelInfoButton",
		anchor = {
			this = "TOPLEFT",
			that = "TOPLEFT"
		}
	},
	default = {
		inherits = false,
		template = "UIPanelButtonTemplate",
		font = "Yugo",
		fontsize = 11,
		anchor = {
			this = "CENTER",
			that = "CENTER",
			to = UIParent,
			offsets = {
				x = 0,
				y = 0
			}
		},
		x = 0,
		y = 0,
		parent = UIParent,
		height = 20,
		width = 30,
		textures = false

	}
}

function Yugo.Buttons:GetTemplate(name)
	local template = Yugo:table_copy(Yugo.Buttons.templates[name])
	if template.inherits ~= false then
		local parent = Yugo:table_copy(Yugo.Buttons.templates[template.inherits])
		template = Yugo:merge(parent, template)
	end
	return template
end

function Yugo.Buttons:Create(name, template)
	print("buttoncreate", template)

	local button = CreateFrame("Button", name, template.parent, template.template)
	local mt = getmetatable(button)

	mt.__index.Init = function(self, o)
		print(o.parent, o.template, o.anchor.this, o.anchor.to, o.anchor.that, o.width, o.height)
		self:SetPoint(o.anchor.this, o.anchor.to, o.anchor.that, o.anchor.offsets.x, o.anchor.offsets.y)
		self:SetWidth(o.width)
		self:SetHeight(o.height)	
		if o.font then
		local fontString = self:GetFontString()
		fontString:SetFont(  SML:Fetch("font", o.font), o.fontsize)	
		end
	end

	mt.__index.SetTextures = function(self, textures)
		print("Setting textures for zeh button")
		if textures.disabled then
			self:SetDisabledTexture(textures.disabled)
		end
		if textures.normal then
			self:SetNormalTexture(textures.normal)
		end
		if textures.pushed then
			self:SetPushedTexture(textures.pushed)
		end
		if textures.highlight then
			self:SetHighlightTexture(textures.highlight)
		end
	end

	button:Init(template)
	print(template.textures)
	if template.textures ~= false then
		button:SetTextures(template.textures)
	end
	return button
end