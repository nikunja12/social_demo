class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook,:linkedin,:google_oauth2]

   def self.new_with_session(params, session)
       super.tap do |user|
           if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
             user.email = data["email"] if user.email.blank?
           end
        end
    end


    def self.from_omniauth(auth)
         where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
         user.email = auth.info.email
         user.password = Devise.friendly_token[0,20]
          user.name = auth.info.name # assuming the user model has a name
          user.image = auth.info.image # assuming the user model has an image
        end
    end

    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
     # byebug
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create( image: data["image"],
         email: data["email"], provider: access_token.provider,
         password: Devise.friendly_token[0,20]
      )
    end
    #user.confirmed_at = Time.zone.now
    user.save
    user
  end

    def self.connect_to_linkedin(auth, signed_in_resource=nil) 
      # byebug
        user = User.where(:provider => auth.provider, :uid => auth.uid).first
        if user
           return user 
        else
           registered_user = User.where(:email => auth.info.email).first
             if registered_user 
                 return registered_user 
              else 
                  user = User.create(name:auth.info.first_name, provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20])
                end 
        end 
    end


end
