class Capybara::Driver::Webkit
  class Node < Capybara::Driver::Node
    def text
      invoke "text"
    end

    def [](name)
      invoke "attribute", name
    end

    def value
      invoke "value"
    end

    def set(value)
      invoke "set", value
    end

    def select_option
      raise NotImplementedError
    end

    def unselect_option
      raise NotImplementedError
    end

    def click
      invoke "click"
    end

    def drag_to(element)
      trigger('mousedown')
      element.trigger('mousemove')
      element.trigger('mouseup')
    end

    def tag_name
      invoke "tagName"
    end

    def visible?
      invoke("visible") == "true"
    end

    def path
      raise NotSupportedByDriverError
    end

    def trigger(event)
      invoke "trigger", event
    end

    def find(xpath)
      invoke("findWithin", xpath).split(',').map do |native|
        self.class.new(driver, native)
      end
    end

    def invoke(name, *args)
      browser.command "Node", name, native, *args
    end

    def browser
      driver.browser
    end
  end
end
