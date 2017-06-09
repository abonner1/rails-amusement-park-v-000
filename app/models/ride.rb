class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if !self.got_tickets? && !self.tall_enough?
      ["Sorry.", ticket_problem, height_problem].join(" ")
    elsif self.got_tickets? && !self.tall_enough?
      ["Sorry.", height_problem].join(" ")
    elsif !self.got_tickets? && self.tall_enough?
      ["Sorry.", ticket_problem].join(" ")
    else
      ride_the_ride
    end
  end

  def got_tickets?
    true if self.user.tickets >= self.attraction.tickets
  end

  def tall_enough?
    true if self.user.height >= self.attraction.min_height
  end

  def ticket_problem
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def height_problem
    "You are not tall enough to ride the #{self.attraction.name}."
  end

  def ride_the_ride
    self.user.tickets = self.user.tickets - self.attraction.tickets
    self.user.nausea = self.user.nausea + self.attraction.nausea_rating
    self.user.happiness = self.user.happiness + self.attraction.happiness_rating
    self.user.save

    "Thanks for riding the #{self.attraction.name}!"
  end

end
