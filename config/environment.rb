# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mycoachpractice::Application.initialize!

ENV["GACC_EMAIL"] = "info@mycoachpractice.com"
ENV["GACC_PASS"]  = "kpgarrod"
