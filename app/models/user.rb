class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :shelf

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :timezone,:screenname
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(oauth_hash, signed_in_resource=nil)
    uid = oauth_hash['uid']
    #ap oauth_hash
    if user = User.find_by_uid_and_provider(uid, 'Facebook')
      user
    else
      user = User.create(:password => Devise.friendly_token[0,20], :uid => uid, :provider => 'Facebook', :email => oauth_hash['info']['email'], :name => oauth_hash['info']['name'], :timezone => oauth_hash['extra']['raw_info']['timezone'], :screenname => oauth_hash['info']['nickname'])
      user.save!

      # Send welcome email
      #UserMailer.welcome_email(user).deliver

      user
    end
  end

end
