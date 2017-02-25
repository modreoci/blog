require_dependency 'post/operation/new'

class Post::Create < Trailblazer::Operation
  step Nested(::Post::New)
  step Contract::Validate()
  step Contract::Persist()
  step :update_items!
  step :notify!

  def update_items!(options, model:, **)
    model[:content] = []
    for i in 0..(options["contract.default"].items.size)-1 do 
      if options["contract.default"].items[i].model.subtitle != nil or options["contract.default"].items[i].model.body != nil
        model[:content] << options["contract.default"].items[i].model if options["contract.default"].items[i].model.subtitle != nil 
      else
        options["contract.default"].items[i].model.destroy
      end
    end
    model.save
  end

  def notify!(options, model:, **)
    Notification::Post.({}, "post" => model, "type" => "create")
  end
end
