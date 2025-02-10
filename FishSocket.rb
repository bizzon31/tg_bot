require 'telegram/bot'
require './library/mac-shake'
require './library/database.rb'
require './modules/listener'
require './modules/security'
require './modules/standart_messages'
require './modules/response'

# Entry point class
class FishSocket
    include Database
    def initialize
        super
        # Initialize BD
        Database.setup
        # Establishing webhook via @gem telegram/bot, using API-KEY
        Telegram::Bot::Client.run(TelegramOrientedInfo::API_KEY) do |bot|
            # Start time variable, for exclude message what was sends before bot starts
            startbottime = Time.now.to_i
            # Active socket listener
            bot.listen do |update|
                
                if update.is_a?(Telegram::Bot::Types::Message) && update.text
                    message = update
                    puts "Получено сообщение: #{message.text}" # Логируем текст сообщения
                    
                    if message.chat.type == 'group' || message.chat.type == 'supergroup'
                        # Processing the new income message    #if that message sent after bot run.
                        Listener.catch_new_message(message,bot) 
                    end
                    
                elsif update.is_a?(Telegram::Bot::Types::ChatMemberUpdated)
                    # Обработка событий обновления участников
                    puts "Кто-то изменил свой статус в группе!"
                else
                    # Игнорируем другие типы обновлений
                    puts "Получено обновление, не являющееся текстовым сообщением."
                end
            end

        end
    end
end
# Bot start
FishSocket.new