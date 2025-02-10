# Новая bd
# sqlite3 ./busines.db
# sqlite> .table
# sqlite> .exit
# 
module ActionBZ
    include Math
    def bizzon_test
        puts "Bizzon TEST"
    end

    def bizzon_test2
        puts "Bizzon TEST_2"
    end

    module_function(
        :bizzon_test,
        :bizzon_test2
    )
end

module Asinc_std
    
    # Размещение данных 
    # Для публикации данных используйте метод:post
    require 'async/http/internet/instance'
    data = {'life' => 42}

    Sync do
        # Prepare the request:    
        headers = [['accept', 'application/json']]    
        body = JSON.dump(data)
            
        # Issues a POST request:   
        response = Async::HTTP::Internet.post("https://httpbin.org/anything", headers, body)
            
        # Save the response body to a local file:    
        pp JSON.parse(response.read)
    ensure
        response&.close
    end

    # ## Тайм-ауты 
    # Чтобы установить тайм-аут для запроса, используйте метод:Task#with_timeout
    require 'async/http/internet/instance'

    Sync do |task|
        # Request will timeout after 2 seconds
        task.with_timeout(2) do
            response = Async::HTTP::Internet.get "https://httpbin.org/delay/10"
        ensure
            response&.close
        end
    rescue Async::TimeoutError
        puts "The request timed out"
    end
    
    # Создание сервера ¶ 
    # Чтобы создать сервер, используйте экземпляр :class Async::HTTP::Server
    require 'async/http'
    
    endpoint = Async::HTTP::Endpoint.parse('http://localhost:9292')
    
    Sync do |task|
        Async(transient: true) do
            server = Async::HTTP::Server.for(endpoint) do |request|
                ::Protocol::HTTP::Response[200, {}, ["Hello World"]]
            end
            
            server.run
        end
        
        client = Async::HTTP::Client.new(endpoint)
        response = client.get("/")
        puts response.read
    ensure
        response&.close
    end
end

module BD_std 
    require 'sqlite3'
    # Источник
    def create_db
        begin 
        
            db = SQLite3::Database.new ":memory:" 
            puts db.get_first_value 'SELECT SQLITE_VERSION()' 
            
        rescue SQLite3::Exception => e 
            
            puts "Произошло исключение" 
            puts e 
            
        ensure 
            db.close if db 
        end
    end
    ## Вставка данных
    def insert 
        begin
            
            db = SQLite3::Database.open "test.db"
            db.execute "CREATE TABLE IF NOT EXISTS Cars(Id INTEGER PRIMARY KEY, 
                Name TEXT, Price INT)"
            db.execute "INSERT INTO Cars VALUES(1,'Audi',52642)"
            db.execute "INSERT INTO Cars VALUES(2,'Mercedes',57127)"
            db.execute "INSERT INTO Cars VALUES(3,'Skoda',9000)"
            db.execute "INSERT INTO Cars VALUES(4,'Volvo',29000)"
            db.execute "INSERT INTO Cars VALUES(5,'Bentley',350000)"
            db.execute "INSERT INTO Cars VALUES(6,'Citroen',21000)"
            db.execute "INSERT INTO Cars VALUES(7,'Hummer',41400)"
            db.execute "INSERT INTO Cars VALUES(8,'Volkswagen',21600)"
            
        rescue SQLite3::Exception => e 
            
            puts "Exception occurred"
            puts e
            
        ensure
            db.close if db
        end
    end

    # ## Индификация последней строки
    def last_row 
        begin 
        
            db = SQLite3::Database.new ":memory:" 
            
            db.execute "CREATE TABLE Friends(Id INTEGER PRIMARY KEY, Name TEXT)" 
            db.execute "INSERT INTO Friends(Name) VALUES ('Tom')" 
            db.execute "INSERT INTO Friends(Name) VALUES ('Rebecca')" 
            db.execute "INSERT INTO Friends(Name) VALUES ('Jim')" 
            db.execute "INSERT INTO Friends(Name) VALUES ('Robert')" 
            db.execute "INSERT INTO Friends(Name) VALUES ('Julian')" 
            
            id = db.last_insert_row_id 
            puts "Последний идентификатор вставленной строки — #{id}" 
            
        rescue SQLite3::Exception => e 
            
            puts "Произошло исключение" 
            puts e 
            
        ensure 
            db.close if db 
        end
    end

    # Извлечение данных
    def read
        begin 
    
            db = SQLite3::Database.open "test.db" 
            
            # Подготавливаем оператор
            stm = db.prepare "SELECT * FROM Cars LIMIT 5" 
            rs = stm.execute 
            
            rs.each do |row| 
                puts row.join "\s" 
            end 
                   
        rescue SQLite3::Exception => e 
            puts "Возникло исключение" 
            puts e 
        ensure 
            stm.close if stm 
            db.close if db 
        end
    end

end

module ActivRecord_std
    require 'active_record'

    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'busines.db')

    class User < ActiveRecord::Base
        
        before_create do |u|
            puts "About to create user: #{u.name}"
        end
        
    end
end
