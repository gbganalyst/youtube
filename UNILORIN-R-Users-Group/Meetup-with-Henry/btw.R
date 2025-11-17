############################################################
#btw:Sends R objects (like data frames) as context to LLMs 
# so they can analyze or summarize them.

# ---------------------------------------------------------
# Goal:
#   Show practical examples of:
#     - btw: sending REAL R objects (data, models) to an LLM
#   using ellmer as the LLM interface.


#############################
# 0. SETUP
#############################

args(vitals::detect_match)


# install.packages("ellmer")
install.packages("btw")
install.packages("mcptools")

library(ellmer)
library(btw)
library(mcptools)

# Make sure your OpenAI (or other provider) API key is set:
# Sys.setenv(OPENAI_API_KEY = "your-key-here")  # or keep it in .Renviron

# Create a chat object with ellmer (OpenAI example)
chat <- btw_client(
  client = ellmer::chat_openai(
    system_prompt = "You are a friendly R tutor. 
                     Explain things clearly in simple language.",
    model = "gpt-4.1-mini"  # or "gpt-4o-mini" / another supported model
  )
)

btw(mtcars)      # describe a data frame
btw(stats::lm)   # describe a function
btw(ls())        # describe object names in the current environment

data("mtcars")  # ensure mtcars is in the environment

answer_mtcars <- chat$chat("
You are connected to my R session and can use your tools
(from the btw package) to inspect objects in my environment.

There is a data frame called 'mtcars'.

Please:
1) Tell me how many rows and columns it has.
2) Briefly describe 4 important variables.
3) Point out two interesting patterns or relationships you see.
Use clear, simple language suitable for someone new to R.")

print(answer_mtcars)

############################################################
# 3. btw + ellmer: LINEAR MODEL INTERPRETATION
############################################################

# Fit a simple regression model
model <- lm(mpg ~ wt + hp, data = mtcars)

# Now ask the LLM to inspect the object named 'model'
answer_model <- chat$chat("
You are connected to my R session and can use tools 
to inspect an object called 'model', which is a linear regression
fit in R.

Please:
1) Identify the response variable and the predictor variables.
2) Say which predictor has the strongest effect on mpg 
   (by absolute size of the coefficient).
3) Explain what the signs of the coefficients mean in plain English.
4) Mention one limitation or caveat of this simple model.

Keep your explanation friendly and easy to understand.
")

print(answer_model)

############################################################
# 4. btw + ellmer: DATA QUALITY CHECK
############################################################

# Make a tiny messy data frame
df <- data.frame(
  id    = 1:6,
  score = c(10, 12, NA, 14, 1000, 15),  # 1000 is suspicious
  group = c("A", "A", "B", "B", "B", NA)
)

# The object is called df in the environment.
# Ask the LLM to inspect it and comment on quality.
answer_quality <- chat$chat("
You are connected to my R session and can inspect an object 'df',
which is a small data frame.

Please:
1) Describe any data quality issues you see 
   (e.g., missing values, outliers, strange patterns).
2) Suggest 3 simple cleanup steps I could take in R.
3) Show small example R code snippets for those fixes.
")

print(answer_quality)


############################################################
# 2. mcptools: LETTING THE LLM "SEE" YOUR PROJECT
############################################################

library(ellmer)
library(mcptools)

ls("package:mcptools")
#“mcptools is the bridge between R and external AI tools via the Model Context Protocol. 
# It lets AI tools talk to your R sessions, and lets R talk to external tools like GitHub or Google Drive.”

############################################################
# mcptools_client_demo.R
# ---------------------------------------------------------
# Goal:
#   Show how mcptools lets R (via ellmer) call tools from
#   external MCP servers (e.g., GitHub).
#
# Prereqs:
#   - ~/.config/mcptools/config.json configured with a server
#     (e.g., a GitHub MCP server as in mcptools docs).
############################################################

library(ellmer)
library(mcptools)

# 1. Create a normal ellmer chat (OpenAI example)
chat <- chat_openai(
  system_prompt = "You are a helpful R assistant that can also use MCP tools.",
  model = "gpt-4.1-mini"
)

# 2. Load tools from configured MCP servers (e.g., GitHub, Confluence)
tools <- mcptools::mcp_tools()

# 3. Register these tools with the chat
chat$set_tools(tools)

# 4. Now ask a question that uses an external tool, e.g., GitHub
answer <- chat$chat("
Use your available tools to check open issues on the GitHub repo
'posit-dev/mcptools'. Summarize:
1) How many open issues there are, and
2) The titles of 3 recent ones.
If the GitHub tool isn't available, explain that instead.
")

print(answer)



