#Trend365

##General Assembly WDI June 2014

##Overview

Does the media play favorites? Is it liberal? Conservative? Are journalists coddling leaders they should be holding accountable?
Trend365 offers you unprecedented article-by-article analysis answering just these questions. We've parsed the news and brought underlying sentiment to light, representing positive and negative coverage with vibrant bar graphs.
Are topics you care about getting a fair shake? [See for yourself](http://nyt-sentiment.herokuapp.com/ "See for yourself").

Trend365 is a web application that allows users to enter search terms and see related New York Times articles along with a graph visualization that displays negative and positive sentiment trends relating to those keywords.

Trend365 was developed for a group project for the April 2014 Web Development Immersive course at General Assembly. It was developed over a two-day sprint to model the agile software development process.

##Technologies Used
* Ruby 2.1.1
* Rails 4.1.1
* PostgreSQL Database
* Authentication & Authorization using [Sorcery](https://github.com/NoamB/sorcery "Sorcery")
* [New York Times API](http://developer.nytimes.com/docs/read/article_search_api_v2 "New York Times API"), [Alchemy API](http://www.alchemyapi.com/api/keyword/sentiment.html "Alchemy API") & [HTTParty](https://github.com/jnunemaker/httparty "HTTParty")
* Front-end design using [Sass Rails](https://github.com/rails/sass-rails "Sass") & [Bootstrap](http://getbootstrap.com/ "Bootstrap")
* Data visualization using [D3](http://d3js.org/ "D3") & [NVD3](http://nvd3.org/ "NVD3")

##User Stories Completed
* User (logged out) can see a homepage featuring company information
* User can see positive/negative correlation of top 5 keywords within article
* User can do a basic search of articles from any page
* User can sign up, log in, and log out
* User should automatically be logged in when they sign up
* User can edit account info
* User can see search results
* User (logged in) can see unique homepage listing favorited articles
* User can do a basic search of articles from any page
* User can see keyword analysis of article from raw text
* User can save articles from search to their favorites
* A user can click on an article and be redirected to that specific page
* User can delete favorited articles
* User can view a favorited article with keyword analysis
* User can e-mail articles
* User should be able to visit website (deployed)
* User should get feedback on invalid login
* User should be able to search for nothing and get an error
* User can view site on different devices and it will look pretty


##Production
Explore Trend 365 for yourself on [Heroku](http://nyt-sentiment.herokuapp.com/)

##Backlog
A full list of user stories can be found by looking at [this Pivotal Tracker](https://www.pivotaltracker.com/s/projects/1100676 "Pivotal Tracker")

##Created by:
* [Adam Barrett](www.github.com/ab75173 "Adam Barrett")
* [Salil Doshi](www.github.com/4S1D2 "Salil Doshi")
* [Parker Hart](www.github.com/parkerhart "Parker Hart")
* [Richard Hessler](www.github.com/richessler "Richard Hessler")
* [Mary Hipp](www.github.com/maryhipp "Mary Hipp")
* [Yi-Hsiao Liu](www.github.com/yihsiaol "Yi-Hsiao Liu")
* [JoElla Straley](www.github.com/joellastraley "JoElla Straley")


