class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, invitable
  devise :invitable, :database_authenticatable, :registerable, :lockable, :timeoutable, 
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  validates :username, presence: true
  #validates_uniqueness_of :username, presence: true
  
  # Virtual attribute for authenticating by either user_id or email
  # This is in addition to a real persisted field like 'user_id'
  attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["username = :value OR email = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
  
  def send_devise_notification(notification, *args)
    #devise_mailer.send(notification, self, *args).deliver_later
    devise_mailer.send(notification, self, *args).deliver_now
  end
end
