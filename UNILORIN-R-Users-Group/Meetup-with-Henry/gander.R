######################################################

#Compare with Copilot first 

library(ggplot2)

data("stackoverflow", package = "modeldata")

stackoverflow 

# plot salary vs years coded 


#####################################################


# Using Gander

# Follow the steps 
# Install ellmer 
#Install Gander and ensure it shows that glue to be 1.8.0
#install.packages("gander")
#library(gander)
#search()
#ls("package:gander")
# Delete glue locally from win-library R folder and re-install 
#install.packages("glue")
#packageVersion("glue")

# Create a shortcut

#Now lets use Gander

library(ellmer)

options(
  .gander_chat = ellmer::chat_openai(
    "You are a helpful R and statistics assistant. 
     Explain things simply and suggest clean R code.",
    model = "gpt-4o-mini"   # or another model you have access to
  )
)

#Why Gander is better 
#1. Gander understands your R environment — Copilot does not
#2. Gander integrates directly with RStudio/Positron as an Addin
#3. Gander supports R tools like chores, buggy, ensure (copilot does not)
    #It treats R like generic text, not an integrated IDE workspace.
#4. You choose the LLM in Gander (OpenAI, Claude, Gemini, Mistral)


#Other Gander Examples

#Example 1
messy_fun <- function(x){
  y = x*2
  for(i in 1:length(y)){y[i] = y[i] + 1}
  return(y)
}


#Ask: “Refactor this function into clean tidyverse style, add comments, and simplify it.”

# Example 2

library(dplyr)

result <- iris %>%
  filter(Species != "setosa") %>%
  group_by(Species) %>%
  summarise(mean_sepal = mean(Sepal.Length))

#Ask: “Explain this code step-by-step in simple English so a beginner can understand it.”

#Write a function 