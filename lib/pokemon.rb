
class Pokemon

attr_accessor :name, :type, :db, :id, :hp

  def initialize(props = {})
    @name = props[:name]
    @type = props[:type]
    @db  = props[:db]
    @id = props[:id]
    @hp = props[:hp]
  end

  # def initialize(name:, type:, db:, id:, hp: nil)
  #   @name = name
  #   @type = type
  #   @db = db
  #   @id = id
  #   @hp = hp
  # end

  def self.save(name,type,db)
    sql = <<-SQL
    INSERT INTO pokemon(name, type) VALUES (?,?);
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = id;
    SQL
    arr = db.execute(sql)
    new_pokemon = Pokemon.new(id:arr[0][0], name: arr[0][1], type: arr[0][2], db: db, hp:arr[0][3])
    new_pokemon
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
      UPDATE pokemon SET hp = #{new_hp} WHERE id = #{self.id};
    SQL
    db.execute(sql)
  end

end
