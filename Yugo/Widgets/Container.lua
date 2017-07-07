
function Container(name)
    local self = Frame(name)

    local name = name

    local config = {
        frame = self.get(),
        layout = 'vertical'
    }

    local content = {}
    local content_positions = {}

    local active_content = {}

    local base_set = self.set
    function self.set(...)
        table.setter(config, ...)
        base_set(config.frame)
    end

    local base_set = self.get
    function self.get()

        return table.copy(config)
    end


    function self.add_child(key, object)
        print('adding to container', key)
        object.set('frame', 'parent', name)
        object.set('frame', 'moveable', false)

        local pos = #content + 1
        table.insert(content, pos, object)
        table.insert(active_content, pos, key)
        content_positions[key] = pos

    end

    function self.get_child(key)
        return content[ content_positions[key]]
    end

    function self.get_childs()
        return content
    end

    function self.hide_child(key)
        local child = content[ content_positions[key] ]
        child.set('frame', 'enabled', false)
        active_content[ content_positions[key] ] = nil
    end

    local base_apply = self.apply
    function self.apply()
        if config.layout == 'vertical' then
            local childWidth = config.frame.width / #active_content
            local childHeight = config.frame.height
            local count = 1
            for k, v in pairs(active_content) do

                v.set('frame', 'width', childWidth)
                v.set('frame', 'height', childHeight)
                v.set('frame', 'anchors', {
                    {
                        this = 'TOPLEFT',
                        that = 'TOPLEFT',
                        to = name,
                        x = (childWidth * count) - childWidth,
                        y = 0
                    }
                })
                v.apply()

                count = count + 1
            end
        elseif config.layout == 'horizontal' then
            local childWidth = config.frame.width
            local childHeight = config.frame.height / #active_content
            local count = 1
            for k, v in pairs(active_content) do
                v.set('frame', 'width', childWidth)
                v.set('frame', 'height', childHeight)
                v.set('frame', 'anchors', {
                    {
                        this = 'TOPLEFT',
                        that = 'TOPLEFT',
                        to = name,
                        x = 0,
                        y = (childHeight * count) - childHeight,
                    }
                })
                v.apply()

                count = count + 1
            end

        end


        base_apply()
    end


    local base_print_config = self.print_config
    function self.print_config()
        for k, v in pairs(content) do
            local c = v.get()
            print_r(c.frame)
        end

    end

    -- defaults

    return self
end
