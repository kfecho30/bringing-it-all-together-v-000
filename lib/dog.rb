class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(name:, breed:, id:nil)
    @name = name
    @breed = breed
    @id = id
  end

  def save(name, breed)
    dog = Dog.new(name, breed)
    DB[:conn].execute("INSERT INTO dogs (name, breed) VALUES (?, ?);", name, breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid FROM dogs;")
    dog
  end




  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS dogs;
    SQL

    DB[:conn].execute(sql)
  end
end
