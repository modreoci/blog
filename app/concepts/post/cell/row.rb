module Post::Cell

  class Row < Trailblazer::Cell
    include ActionView::Helpers::JavaScriptHelper

    def show
      render :row
    end

    def item

    end

    def type
      options[:type]
    end

    def label
      #maybe add number after subtitle just for the label getting from the position
      labels = {
        :subtitle => "Subtitle 2",
        :body => "Body"
      }

      labels[options[:type]]
    end

    def append
      %{ $("#next").replaceWith("#{j(show)}") }
    end

  end

end