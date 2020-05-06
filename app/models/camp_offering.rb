class CampOffering < ActiveRecord::Base

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  CURRENT_YEAR = 6

  YEARS = %w(2014 2015 2016 2017 2018 2019 2020 2021 2022) # year 0 is 2014

  OFFERING_TIMES = ["All Day","AM","PM",
                    "9-10AM & 1-2PM EST",
                    "10-11AM & 2-3PM EST",
                    "11-12PM & 3-4PM EST",
                    "9-10:30AM EST",
                    "10:30-12PM EST",
                    "1-2:30PM EST",
                    "2:30-4:00PM EST"]

  OFFERING_WEEKS = {
                            1 => {
                                    :start => Date.new(2020,6,1),
                                    :end => Date.new(2020,6,5)
                            },
                            2 => {
                                    :start => Date.new(2020,6,8),
                                    :end => Date.new(2020,6,12)
                            },
                            3 => {
                                    :start => Date.new(2020,6,15),
                                    :end => Date.new(2020,6,19)
                            },
                            4 => {
                                    :start => Date.new(2020,6,22),
                                    :end => Date.new(2020,6,26)
                            },
                            5 => {
                                    :start => Date.new(2020,7,6),
                                    :end => Date.new(2020,7,10)
                            },
                            6 => {
                                    :start => Date.new(2020,7,13),
                                    :end => Date.new(2019,7,17)
                            },
                            7 => {
                                    :start => Date.new(2019,7,20),
                                    :end => Date.new(2019,7,24)
                            },
                            8 => {
                                    :start => Date.new(2019,7,27),
                                    :end => Date.new(2019,7,31)
                            },
                            9 => {
                                    :start => Date.new(2019,8,3),
                                    :end => Date.new(2019,8,7)
                            }
    }

  def self.accessible_attributes
   ["assistant", "camp_id", "end_date", 'location_id', "start_date", "teacher", "classroom", "time", "week", "hidden", "year", "extended_care"]
  end

  def name
    if camp
      camp.title + " " + "(Ages: #{camp.age})"
    end
  end

  def extended_care_name
    camp.title
  end

  def select_name
    # camp.title + ": " + location.name + ", " + time + " (Start Date: #{start_date.strftime('%b, %d')})"
    camp.title + ": " + location.name + ", " + time + " #{CampOffering::OFFERING_WEEKS[week][:start].strftime("%b %d")}"
  end

  def confirmation_name
    if location.id != 7
      camp.title + ": " + location.name + ", " + convert_time + " (Start Date: #{CampOffering::OFFERING_WEEKS[week][:start].strftime("%b %d")})"
    else
      camp.title + " (Online): " + " #{CampOffering::OFFERING_WEEKS[week][:start].strftime("%b %d")} - #{CampOffering::OFFERING_WEEKS[week][:end].strftime("%b %d")} from " + time
    end
  end

  def edit_name
    camp.title + " " + location.name + " Week: " + week.to_s + " " + time
  end

  def convert_time
    case time
      when "AM" then "9:00AM - 12:00PM"
      when "PM" then "1:00PM - 4:00PM"
      # this only works if Extended Care is the ONLY All Day camp
      when "All Day" then "8:30AM - 9:00AM and 4:00PM - 4:30pm"
    end
  end

  def students
    students = Array.new
    registrations.each do |r|
      students << "#{r.student_first_name} #{r.student_last_name}"
    end
    students
  end

  def self.by_week(location, week, year)
    where("location_id=? AND week=? AND year=?", location, week, year)
  end

  def self.by_week_and_classroom(location, week, year, classroom)
    where("location_id=? AND week=? AND year=? AND classroom=?", location, week, year, classroom)
  end

  def self.extended_care(location, week, year)
    where("location_id=? AND week=? AND year=? AND extended_care = ?", location, week, year, true)
  end

  def price
    camp.price if camp
  end

  def open_spots
    if camp && camp.capacity < 1
      0
    elsif camp && camp.capacity >= 1
      camp.capacity - registrations.count
    else
      "no capacity"
    end
  end

  def at_capacity?
    if open_spots == "no capacity"
      true
    else
      open_spots <= 0 ? true : false
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp_offering = find_by_id(row["id"]) || new
      camp_offering.attributes = row.to_hash.slice(*accessible_attributes)
      begin
        camp_offering.save!
      rescue ActiveRecord::RecordInvalid => e
        false
      end
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |camp_offering|
        csv << camp_offering.attributes.values_at(*column_names)
      end
    end
  end
end
