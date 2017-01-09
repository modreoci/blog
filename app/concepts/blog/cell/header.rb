module Blog::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end

  class Header < Trailblazer::Cell
    include Tyrant
    def show_post
      return model.show_post
    end
    
    def post
      return Post.find(model.show_id) if show_post
    end
    
    def title
      if show_post
        return post.title
      else
        return "TRB Blog"
      end
    end

    def subtitle
      if show_post
        return post.subtitle
      else
        return "A Blog implemented with TRB/Dry-validation/Formular"
      end
    end


    def container
      if show_post
        return "post-heading"
      else
        return "site-heading"
      end
    end

    def image
      if show_post
        return '/assets/post-bg.jpg'
      else
        return '/assets/home-bg.jpg'
      end
    end

    def dec
      if show_post
        return ''
      else
        return 'small'
      end
    end
    
    def author
      if show_post
        if post.user_id != nil and tyrant.current_user != nil and tyrant.current_user.email == User.find(model.user_id).email
          link_to post.author, user_path(post.user_id)
        else
          return post.author
        end
      else
        return ""
      end   
    end

    def time
      post.created_at if show_post
    end


  end
end