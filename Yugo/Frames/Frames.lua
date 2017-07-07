local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
local Frames = Yugo:NewModule("Frames");

local default_backdrop = {bgFile = "",edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = {left = 0,right = 0,top = 0,bottom = 0}}
local l_None = "None"


function Frames:GetTemplate(name)
	local template = table.copy(Frames.templates[name])
	if template.inherits ~= false then
		local parent = table.copy(Frames.templates[template.inherits])
		template = table.extend(parent, template)
	end
	return template
end

function Frames:AddTemplate(name, template)
	Frames.templates[name] = template
end


function Frames:Create(name)
	Frames[name] = CreateFrame("Frame", name, UIParent)
	local frame = Frames[name]
	frame.name = name
	frame.mouseMove = false
	frame.buttonCount = 0
	frame.bg = frame:CreateTexture(name .. "_BG", "PARENT")
	frame:SetScript("OnEvent",nil)
	frame:SetScript("OnUpdate",nil)
	frame:SetScript("OnShow",nil)
	frame:SetScript("OnHide",nil)
	frame:SetScript("OnEnter",nil)
	frame:SetScript("OnLeave",nil)
	frame:SetScript("OnSizeChanged",nil)
	frame:SetScript("OnReceiveDrag",nil)
	frame:SetScript("OnMouseUp",nil)
	frame:SetScript("OnMouseDown",nil)
	frame.bg:SetTexture(0.1,0.1,0.1,0.8)
	frame:SetFrameStrata("BACKGROUND")
	frame.bg:ClearAllPoints()
	frame.bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	frame.bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0);
	frame:ClearAllPoints()
	frame:SetBackdrop(default_backdrop)
	--frame:SetPoint("CENTER",UIParent,"CENTER",0,0)
	frame.scripts_loaded = false
	frame.missing_parent_at_load = false
	frame.missing_anchor_at_load = false
	frame.layoutDirectionFrom = "LEFT"
	frame.layoutDirectionTo = "RIGHT"
    frame.template = false

    frame.options = {}
	
	local mt = getmetatable(frame)


    --------------------------
    --------- ApplyOptions
    ------
	mt.__index.ApplyOptions = function(self)
        self:SetParent(self.options.parent)
        local parent = self.options.parent
		self:ClearAllPoints()

		-- Percentage size support
		if strmatch(self.options.width, "%d+%.?%d*%%") then
			local pWidth = parent:GetWidth()
			local fWidth = strmatch(self.options.width, "%d+%.?%d*")
			self:SetWidth(pWidth * (fWidth / (100.0)))
		elseif strmatch(self.options.width, "%d+") then
			local pWidth = strmatch(self.options.width,"%d+")
			self:SetWidth(pWidth)
		end
		if strmatch(self.options.height, "%d+%.?%d*%%") then
			local pHeight = parent:GetHeight()
			local fHeight = strmatch(self.options.height, "%d+%.?%d*")
			self:SetHeight(pHeight * (fHeight / (100.0)))
		elseif strmatch(self.options.height, "%d+") then
			local pHeight = strmatch(self.options.height,"%d+")
			self:SetHeight(pHeight)
		end
		if self.options.scale then
			self:SetScale(self.options.scale)
		end
		local scale = self:GetScale()

        self:SetPoint(self.options.anchor.this, self.options.anchor.to, self.options.anchor.that, self.options.x, self.options.y)
		
		if self.options.level < 0 then
			self.options.level = 0
		end
		self:SetFrameLevel(self.options.level)
		self:SetFrameStrata(self.options.strata)
		self:SetTexture()
    end


	--------------------------
	--------- SetTexture
	------
	mt.__index.SetTexture = function(self, texture)

		if not texture then
			texture = self.options.bg.texture
        end

		self.bg:SetTexCoord(0,1,0,1)
		local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = self.bg:GetTexCoord()
		self.bg:SetBlendMode(self.options.bg.blend)
		self.bg:SetAlpha(self.options.bg.alpha)

		local alpha_override = self.options.bg.alpha
		if self.options.bg.style == "SOLID" then
			self.bg:SetGradientAlpha(self.options.bg.orientation, self.options.bg.color.r, self.options.bg.color.g, self.options.bg.color.b,min(self.options.bg.color.a,alpha_override), self.options.bg.color.r, self.options.bg.color.g, self.options.bg.color.b,min(self.options.bg.color.a,alpha_override))
			self.bg:SetTexture(self.options.bg.color.r, self.options.bg.color.g, self.options.bg.color.b,min(self.options.bg.color.a,alpha_override))
		elseif self.options.bg.style == "GRADIENT" then
			self.bg:SetGradientAlpha(self.options.bg.orientation, self.options.bg.color.r, self.options.bg.color.g, self.options.bg.color.b,min(self.options.bg.color.a,alpha_override), self.options.bg.gradient.r, self.options.bg.gradient.g, self.options.bg.gradient.b,min(self.options.bg.gradient.a,alpha_override))
			self.bg:SetTexture(1,1,1,1)
		end

		if texture and strlen(texture) > 0 then
			local path = Yugo:FetchArt(texture,"background")
			self.bg:SetTexture(path)
			if texture == "None" then
				self.bg:SetTexture(nil)
			end
		end

		if self.options.border.texture and strlen(self.options.border.texture) > 0 and self.options.border.texture ~= "None" then
			local path = Yugo:FetchArt(self.options.border.texture,"border")
		end
		if self.options.tiling then
			self.bg:SetTexture(nil)
			self:SetBackdrop({	bgFile = Yugo:FetchArt(self.options.bg.texture,"background"),edgeFile = Yugo:FetchArt(self.options.border_texture,"border"),edgeSize = self.options.border_edgeSize,tile = true,tileSize = self.options.tileSize,insets = {left = self.options.bg.insets.l,right = self.options.bg.insets.r,top = self.options.bg.insets.t,bottom = self.options.bg.insets.b}})
		
			-- check direction
			if self.options.vert_tile then
				self.bg:SetHorizTile(false)
				self.bg:SetVertTile(true)
			end
			if self.options.horz_tile then
				self.bg:SetHorizTile(true)
				self.bg:SetVertTile(false)
			end
		
		else
			self:SetBackdrop({	bgFile = "",edgeFile = Yugo:FetchArt(self.options.border.texture,"border"),edgeSize = self.options.border.size,tile = false,tileSize = 0,insets = {left = 0,right = 0,	top = 0,bottom = 0}})
		end

		self:SetBackdropColor(self.options.bg.color.r, self.options.bg.color.g, self.options.bg.color.b, self.options.bg.color.a)
		self:SetBackdropBorderColor(self.options.border.color.r, self.options.border.color.g, self.options.border.color.b, self.options.border.color.a)
		self.bg:ClearAllPoints()
		self.bg:SetPoint("TOPLEFT", self, "TOPLEFT", self.options.bg.insets.l, self.options.bg.insets.t);
		self.bg:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", self.options.bg.insets.r, self.options.bg.insets.b);

		self:SetFrameLevel(self.options.level)
		self:SetFrameStrata(self.options.strata)
		self.bg:SetDrawLayer("BACKGROUND", self.options.sub_level)
	end

	--------------------------
	--------- setMouseMove 
	------
	mt.__index.SetMouseMove = function(self, value)
		self.mouseMove = value
		self:SetMovable(value)
		self:EnableMouse(value)
		if value == true then
			self:SetScript("OnMouseDown", function() self:StartMoving() end)
			self:SetScript("OnMouseUp", function() self:StopMovingOrSizing() end)
			self:SetScript("OnDragStop", function() self:StopMovingOrSizing() end)
		else
			self:SetScript("OnMouseDown", function() end)
			self:SetScript("OnMouseUp", function() end)
			self:SetScript("OnDragStop", function() end)
		end
	end

	mt.__index.GetMouseMove = function(self)
		return self.mouseMove
	end

	mt.__index.AddButton = function(self, type, o)
		if not o then o = {} end
		if type == "close" then
			local template = table.extend(Buttons:GetTemplate("close"), o)
			template.anchor.to = self --UIPanelInfoButton
			template.parent = self
			frame["CloseButton"] = Buttons:Create(self.name .. "_CloseButton", template)
		elseif type == "info" then
			local template = table.extend(Buttons:GetTemplate("info"), o)
			frame["InfoButton"] = Buttons:Create(self.name .. "_InfoButton", template)
		elseif type == "lock" then
			local template = table.extend(Buttons:GetTemplate("lock"), o)
			template.anchor.to = self --UIPanelInfoButton
			template.parent = self
			frame["LockButton"] = Buttons:Create(self.name .. "_LockButton", template)
			frame["LockButton"]:SetScript("OnClick", function()
				if self:GetMouseMove() == true then
					frame["LockButton"]:SetNormalTexture(template.textures.disabled)
					self:SetMouseMove(false)
				else
					frame["LockButton"]:SetNormalTexture(template.textures.normal)
					self:SetMouseMove(true)
				end
			end)
			self:SetMouseMove(true)
		else
			local template = table.extend(Buttons:GetTemplate("default"), o)
			template.anchor.to = self --UIPanelInfoButton
			template.parent = self
			frame[o.name] = Buttons:Create(self.name .. "_" .. o.name, template)
		end
	end

	mt.__index.AddTitle = function(self, title)
		
		self.TitleText = self:CreateFontString(self.name .. "_Title", "OVERLAY", "GameFontHighlightSmall")
		self.TitleText:SetFont( Yugo.SML:Fetch("font", "Yugo"), 13)
		self.TitleText:SetPoint("TOPLEFT", self ,"TOPLEFT", 17, -7)
		self.TitleText:SetText(title)

	end
	return frame
end