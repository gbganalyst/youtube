library(shiny)
library(ellmer)
library(shinychat)

# 1. Create ellmer LLM client
client <- chat_openai(
  model = "gpt-4o-mini",
  system_prompt = "You are a friendly assistant inside this Shiny app."
)

# 2. Launch the chatbot app
chat_app(client)

