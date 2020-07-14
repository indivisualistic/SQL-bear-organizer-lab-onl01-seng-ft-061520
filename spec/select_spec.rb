describe 'querying the bears table' do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_create_file
    @sql_runner.execute_data
  end
  after do
    File.open('lib/sql', 'w'){ |f| f.truncate(0) }
  end

  it 'selects all of the female bears and returns their name and age' do
    "SELECT name, age FROM bears WHERE gender = 'F';"
  end

  it 'selects all of the bears names and orders them in alphabetical order' do
    "SELECT name FROM bears ORDER BY name";

  end

  it 'selects all of the bears names and ages that are alive and order them from youngest to oldest' do
    "SELECT name, age FROM bears WHERE alive = 1 ORDER BY age ASC;" 
  end

  it 'selects the oldest bear and returns their name and age' do
    "SELECT name, age FROM bears ORDER BY age DESC LIMIT 1;"
  end

  it 'selects the youngest bear and returns their name and age' do
    "SELECT name, age FROM bears ORDER BY age ASC LIMIT 1;"
  end

  it 'selects the most prominent color and returns it with its count' do
    "SELECT color, COUNT(color) FROM bears GROUP BY color ORDER BY COUNT(*) DESC LIMIT 1;"
  end

  it 'counts the number of bears with goofy temperaments' do
    "SELECT COUNT(temperament) FROM bears WHERE temperament = 'goofy';"
  end

  it 'selects the bear that killed Tim' do
    "SELECT * FROM bears WHERE name IS NULL;"
  end
end
