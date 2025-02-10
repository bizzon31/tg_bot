require 'ollama-ai'

client = Ollama.new(
    credentials: { 
        address: 'http://localhost:11434',
        
    },
  options: { server_sent_events: true }
)
result = client.chat(
  { model: 'llama3.2',
    messages: [
      { role: 'user', content: 'Hi! My name is Purple.' },
      { role: 'assistant',
        content: 'Hi, Purple!' },
      { role: 'user', content: "What's my name?" }
    ] }
) do |event, raw|
  puts event
end

