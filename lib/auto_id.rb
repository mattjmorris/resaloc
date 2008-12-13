# Takes care of assigning a unique id to each object.
# To use, just call #assign_id(id).

module AutoId
  include Comparable

  @@last_auto_id = -1
  @@all_ids = []

  def <=>(other)
    self.id <=> other.id
  end

  private

  def assign_id(id)
    id = @@last_auto_id += 1
    raise ArgumentError, "#{self.class.name} object initialized with an id that has already been taken", caller if @@all_ids.include?(id)
    @@all_ids << id
    @id = id
  end

end