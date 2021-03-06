class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, as: :commentable
  has_many :movies
  has_many :votes, as: :voteable
  has_many :reviews

  validates :username, :email, :access_level, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, on: :create, message: "Must be valid email format(example: example@gmail.com)" }

  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 6 }



end
