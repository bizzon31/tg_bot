# ## Создание и удаление таблиц
# :primary_key, :string, :text, :integer, :bigint, :float, :decimal, :numeric, :datetime, 
# :time, :date, :binary, :blob, :boolean.
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: './test_tb.db')

# class CreateUserTable < ActiveRecord::Migration[5.2]
#   def change
#     create_table :users do |table|
#       table.string :surename
#       table.string :middlename
#       table.string :nickname
#       table.integer :age
#       table.timestamps
#     end
#   end
# end

class CreateUserTable < ActiveRecord::Migration[5.2]
  def up
    # unless ActiveRecord::Base.connection.table_exists?(:users)
      create_table :users do |table|
        table.string :name
        table.string :surename
        table.string :middlename
        table.string :nickname
        table.integer :age
        table.timestamps
      end
    # end
  end

  def down
    if ActiveRecord::Base.connection.table_exists?(:users)
      drop_table :users
    end
  end
end

# Create the table
CreateUserTable.migrate(:up)

# Drop the table
# CreateUserTable.migrate(:down)
 

class User < ActiveRecord::Base
end

User.create(name: 'John Leon', age: 90)
