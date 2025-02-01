require 'telegram/bot'
require 'dotenv'

Dotenv.load # Загружаем переменные окружения

token = ENV['TELEGRAM_BOT_TOKEN']
unless token
  puts "Ошибка: Токен бота не найден. Проверьте файл .env."
  exit
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |update|
    # puts "Получено обновление: #{update.inspect}" # Логируем обновление

    # Проверяем, что обновление содержит сообщение
    if update.is_a?(Telegram::Bot::Types::Message) && update.text
      message = update
      puts "Получено сообщение: #{message.text}" # Логируем текст сообщения

      if message.chat.type == 'group' || message.chat.type == 'supergroup'
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}!")
        when '/help'
          bot.api.send_message(chat_id: message.chat.id, text: "Я простой чат бот. Вот что я могу:\n/start - начать общение\n/help - показать помощь #{message.from.first_name}!")
        when '/test'
          bot.api.send_message(chat_id: message.chat.id, text: "Привет, это тест!")
        else
        #   bot.api.send_message(chat_id: message.chat.id, text: "Я не понимаю эту команду. Попробуйте /help")
        end
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