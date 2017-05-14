class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  belongs_to :plan 
  attr_accessor :stipre_card_token
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: srtipe_card_token)
      self.stripe_customer_token = customer_id
      save!
    end
  end
  
end
