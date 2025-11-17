############################################################
# mall: Performs row-wise NLP tasks (like sentiment or classification) 
#       across data frame text columns
# ---------------------------------------------------------
# Demonstrates:
#   1) llm_sentiment()
#   2) llm_classify()
#   3) llm_extract()
#   4) llm_summarize()
#   5) llm_translate()
#   6) llm_verify()
#
# Backend:
#   - ellmer::chat_openai()
#   - mall::llm_use(chat)
#
# Prereqs:
#   - OPENAI_API_KEY set in .Renviron (or similar)
############################################################

library(ellmer)
library(mall)
library(dplyr)

############################################################
# 0. Configure LLM backend via ellmer + mall::llm_use()
############################################################

chat <- chat_openai(
  model = "gpt-4o-mini",  # or "gpt-4.1-mini", etc.
  system_prompt = "You are a helpful assistant for analyzing short text reviews
  and NLP task."
)

# Tell mall to use this chat object for all llm_* calls
llm_use(chat, .silent = TRUE)

############################################################
# 1. Load example data
############################################################

data("reviews", package = "mall")
# 'reviews' has a column called `review`
print(reviews)

############################################################
# 2. SENTIMENT ANALYSIS: llm_sentiment()
############################################################

reviews_sent <- llm_sentiment(
  .data    = reviews,
  col      = review,
  # default options = c("positive", "negative", "neutral")
  pred_name = "sentiment"
)

print(reviews_sent)

############################################################
# 3. CLASSIFICATION: llm_classify()
#    Example: classify each review as appliance vs computer
############################################################

reviews_class <- llm_classify(
  .data     = reviews_sent,
  col       = review,
  labels    = c("appliance", "computer"),
  pred_name = "prod_type"
)

print(reviews_class)

############################################################
# 4. EXTRACTION: llm_extract()
#    Example: extract product and feelings into separate columns
############################################################

reviews_extract <- llm_extract(
  .data       = reviews_class,
  col         = review,
  labels      = c("product", "feelings"),
  expand_cols = TRUE       # create separate columns per label
  # pred_name = ".extract" # not needed when expand_cols = TRUE
)

print(reviews_extract)

############################################################
# 5. SUMMARIZATION: llm_summarize()
#    Example: short 10-word summary of each review
############################################################

reviews_summary <- llm_summarize(
  .data          = reviews_extract,
  col            = review,
  max_words      = 10,
  pred_name      = "summary",
  additional_prompt = ""   # optional extra instruction
)

print(reviews_summary)

############################################################
# 6. TRANSLATION: llm_translate()
#    Example: translate each review into French
############################################################

reviews_translated <- llm_translate(
  .data          = reviews_summary,
  col            = review,
  language       = "french",
  pred_name      = "review_fr",
  additional_prompt = ""
)

print(reviews_translated)

############################################################
# 7. VERIFICATION: llm_verify()
#    Example: "Is the customer happy?" -> yes / no
############################################################

reviews_verified <- llm_verify(
  .data          = reviews_translated,
  col            = review,
  what           = "is the customer happy",
  yes_no         = c("yes", "no"),   # values to return
  pred_name      = "is_happy",
  additional_prompt = ""
)

print(reviews_verified)
