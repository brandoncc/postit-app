class User < ActiveRecord::Base
  include SluggableBrandon

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }, on: :create

  sluggable_column :username
  before_save :generate_slug!

  def two_factor?
    !self.phone.blank?
  end

  def generate_pin!
    self.pin = rand(10 ** 6)
    self.save
  end

  def remove_pin!
    self.pin = nil
    self.save
  end

  def send_pin_to_twilio
    # put your own credentials here
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_SECRET_KEY']

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new account_sid, auth_token

    client.account.messages.create({
                                        :from => ENV['TWILIO_PHONE_NUMBER'],
                                        :to => self.phone,
                                        :body => "Here is your two-factor pin from Brandon's PostIt app: #{self.pin}.",
                                   })
  end
end
