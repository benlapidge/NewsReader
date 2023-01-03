# NewsReader
Swift Storyboard News app that uses NewsAPI

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
