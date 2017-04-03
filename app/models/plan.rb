class Plan < ActiveRecord::Base
    has_many :payments
end
