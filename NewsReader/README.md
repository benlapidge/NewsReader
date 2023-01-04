#  D4T4 Celebrus Task

## Dev notes
NewsAPI restricts its api response based on geographic location. In the UK, the "description" field is unavailable, and "total articles" always returns 0 regardless of actual count. In this case, the speech synthesiser will read the title of the article aloud. Use of a VPN to spoof location permits access to the description field, and in this case, the speech synthesiser will read the description aloud.


## Task Headline:
Allow me to search for today's news about any topic I wish and present a short description of it for me or show me the news.

## Task Detail:
Create an iOS application with 2 screens. On the first screen we would like to see an input field with a "Find" button. If the user types anything in that input field and taps the Find button then do an API query to newsapi.org. We would like to see all the news from the world where:
1. the keyword from the input field is in the article's title
2. the news published on the given date
3. the article is written in English language

Below the search section, display these news title in a table view with two buttons on each table view cell. One of the button should read me the short description of the news while the other should show a new full screen with a web view in it and open the article. Make sure the HTTP API query runs asynchronously and does not affect the user experience.

## Hints:
1. newsapi.org offers a free API access up to 1000 queries/day after a quick registration.
2. Documentation to the API: <https://newsapi.org/docs/endpoints/everything>
3. You can do API tests with Postman easily
4. To read text to the user you can use the iOS Speech Synthesis API: <https://developer.apple.com/documentation/avfoundation/speech_synthesis>

Please tell us what is your estimated completion timeframe and we can arrange our next discussion accordingly.

Through this task we will be able to measure:

1. Problem understanding skills
2. Capability of stand-alone working
2. Understanding documentation
3. Coding quality
4. iOS API handling skills
5. HTTP API handling skills
6. JSON parsing skills
7. WebView handling skills
8. Multi-threaded programming skills

I look forward to seeing your completed test.

