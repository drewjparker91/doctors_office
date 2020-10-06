class Doctor
  attr_reader :id
  attr_accessor :name, :specialty

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  def ==(doctor_to_compare)
    if doctor_to_compare != nil
      (self.name() == doctor_to_compare.name()) && (self.specialty() == doctor_to_compare.specialty() && self.id() == doctor_to_compare.id())
    else
      false
    end
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id = album.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :id => id}))
    end
    doctors
  end

  def self.save
    result = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM doctors *;")
  end

  def self.find( id)
    doctor = DB.exec("SELECT * FROM doctors WHERE id = #{id};").first()
    if doctor
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      id = doctor.fetch("id").to_i
      Doctor.new({:name => name, specialty => :specialty, :id => id})
    else
      nil
    end
  end

  def update (name, specialty)
    @name = name
    @specialty = specialty
    DB.exec("UPDATE doctors SET name = '#{@name}', specialty = '#{@specialty}' WHERE id = #{@id};")
  end
  
  def delete
    DB.exec("DELETE FROM doctors WHERE id = #{@id};")
    DB.exec("DELETE FROM patients WHERE patients_id = #{@id};")
  end

  def patients
    Patient.find_by_doctor(self.id)
  end
end