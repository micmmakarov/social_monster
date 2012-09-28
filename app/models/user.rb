class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name


  def self.oauth_user(fb_me, access_code)
    fb_id, fb_name, fb_email = fb_me["id"], fb_me["name"], fb_me["email"]
    user = User.find_by_uid(fb_id)
    unless user
      user = User.new(name: fb_name, email: fb_email, password: Devise.friendly_token[0,20])
      user.uid = fb_id
      user.access_code = access_code
      user.save!
    else
      user.access_code = access_code
      user.save!
    end

    user
  end


end
