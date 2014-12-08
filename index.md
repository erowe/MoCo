---
title       : Montgomery County Maryland
subtitle    : Visualizing Traffic Enforcement
author      : Ethan 
job         : Coursera Data Science
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [quiz, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
github:
  user: erowe
  repo: MoCoPres
--- 
## Welcome 

- Montgomery County Maryland exists along the northwest border of Washington, D.C. USA

- It is home to approximately 1,000,000 residents*

- Residents are spread across 491.25 square miles*

- Montgomery County has an open data project (https://data.montgomerycountymd.gov/)

- They have hundreds of thousands of entries for traffic violations since January 2012


```r
  df <- read.csv(file = 'Traffic_Violations_Truncated.csv')
  nrow(df)
```

```
## [1] 549022
```

Source: http://quickfacts.census.gov/qfd/states/24/24031.html</p>

--- &radio .quiz
## Quiz

Would you like to know about this application?

1. _Yes_
2. No

*** .hint 
Of course you want to learn more...

*** .explanation 
The answer is "Yes."

---
## The application
1. The application is hosted at: https://erowe.shinyapps.io/MoCoTraffiicPlotter

2. This application displays traffic stops in the Montgomery County Maryland area over the last two years

3. The user has the ability to truncate the dataset to display where traffic stops occurred during fixed hours of the day and if they were alcohol related

<img src = "app.png">


---
## Why use this application?
1. Maybe you want to compare this to other open data projects

2. It stimulates your mind to wonder why certain areas have a higher concentration of activity

3. Maybe you want to convince your friend / co-worker / child not to stay out late

4. It might make you a more cautious driver while traveling in the area