module ApplicationHelper
  def profile_img(user)
    if user.avatar?
      image_tag(user.avatar, alt: user.name)
    else
      if user.provider == 'facebook' || user.provider == 'twitter'
        image_url = user.image_url
      else
        image_url = 'no_image.png'
      end
      image_tag(image_url, alt: user.name)
    end
  end
end
