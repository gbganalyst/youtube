library(shiny)
library(ellmer)
library(btw)
library(mall)
library(dplyr)

# ===============================
# 1. ELLMER CLIENT
# ===============================
chat <- chat_openai(
  model = "gpt-4o-mini",
  system_prompt = "You are a helpful assistant for data analysts."
)

# Use ellmer as the default LLM for mall
llm_use(chat)

# Wrap mtcars for LLM access
mtcars_ctx <- btw(mtcars)

# ===============================
# 2. UI
# ===============================
ui <- fluidPage(
  titlePanel("AI Data Assistant (ellmer + btw + mall + shiny)"),
  
  tabsetPanel(
    tabPanel("Chatbot",
             textInput("chat_input", "Ask the AI anything:", width = "100%"),
             actionButton("chat_btn", "Send"),
             br(), br(),
             verbatimTextOutput("chat_output")
    ),
    
    tabPanel("Ask About Data (btw)",
             textInput("data_input", "Ask about mtcars:", width = "100%"),
             actionButton("data_btn", "Ask"),
             br(), br(),
             verbatimTextOutput("data_output")
    ),
    
    tabPanel("Sentiment (mall)",
             textInput("sent_input", "Enter a sentence:", width = "100%"),
             actionButton("sent_btn", "Analyze"),
             br(), br(),
             verbatimTextOutput("sent_output")
    )
  )
)

# ===============================
# 3. SERVER
# ===============================
server <- function(input, output, session) {
  
  # -------- 3A. Chatbot Panel --------
  observeEvent(input$chat_btn, {
    req(input$chat_input)
    
    answer <- chat$chat(
      prompt = input$chat_input
    )
    
    output$chat_output <- renderText(answer)
  })
  
  # -------- 3B. Ask About Data Panel --------
  observeEvent(input$data_btn, {
    req(input$data_input)
    
    answer <- chat$chat(
      prompt = input$data_input,
      mtcars = mtcars_ctx        # <= this gives context to LLM
    )
    
    output$data_output <- renderText(answer)
  })
  
  # -------- 3C. Sentiment Panel (mall) --------
  observeEvent(input$sent_btn, {
    req(input$sent_input)
    
    df <- tibble(text = input$sent_input)
    
    result <- llm_sentiment(
      df,
      text,
      pred_name = "sentiment"
    )
    
    output$sent_output <- renderPrint(result)
  })
}

# ===============================
# 4. Run App
# ===============================
shinyApp(ui, server)
