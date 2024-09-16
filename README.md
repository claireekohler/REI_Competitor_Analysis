# REI COMPETITOR ANALYSIS

## BACKGROUND & OVERVIEW

### A small shoe business is conducting competitor research focused on REI to identify which shoes are most popular and the reasons behind their success. As the business prepares to open in the same neighborhood as REI, they are eager to compete with this retail giant. This early-stage analysis aims to determine what factors drive shoe popularity and whether variables such as price correlate with customer ratings. To gather insights, an API was used to scrape REI's website, collecting data on women's running shoes.


## DATA STRUCTURE 

### The data was normalized from a staging table, with ratings and features split into separate tables to enable easier analysis. The key metrics guiding their initial exploratory analysis were the number of ratings/reviews and the average rating out of 5. They focused specifically on shoes with a high rating of 4 stars or more, coupled with a substantial review count of over 1,000. Emphasizing a sample size above 1,000 aimed to minimize bias and provide a more accurate reflection of the shoe's overall rating.

<img width="445" alt="Screenshot 2024-09-15 at 17 40 45" src="https://github.com/user-attachments/assets/a69c7217-60d6-4794-9fed-43575cd20a3b">


## EXECUTIVE SUMMARY

### The top five highly rated shoes with the highest review count were the following in the snip below:

<img width="679" alt="Screenshot 2024-09-15 at 16 55 03" src="https://github.com/user-attachments/assets/4c78fcd9-68f8-489c-be72-f5eae7461d56">

### One out of five shoe brands analyzed was Adidas, with the remaining majority being HOKA. No correlation was found between price and rating. The key features contributing to the high ratings of these shoes were the sole height and rounded heel, as further detailed below.

### *The full dashboard can be visible [here](https://public.tableau.com/app/profile/claire.kohler/viz/Competitoranalysis_17259320149230/REIHighestRatedShoes).

## INSIGHTS DEEP DIVE

### The standout feature of the HOKA Bondi-8 is its “Late-Stage Meta-Rocker profile,” characterized by a thicker sole and rounded heel. A key aspect of HOKA’s brand is its rocker-style shoes, which come in either toe or heel-to-toe rocker designs, each serving different purposes but with the common goal of reducing foot pain from conditions like arthritis or plantar fasciitis. The HOKA Clifton 9 features a reflective heel panel to reduce weight and increase stack height by 3 mm. With HOKA consistently outpacing other brands in ratings, it’s evident they are REI’s top competitor in running shoes.

## RECOMMENDATIONS

### Further research on HOKA and their shoes is recommended. HOKA is known for designing shoes that prioritize stability, comfort, and efficiency. Analyzing the “Meta-Rocker profile” in more detail will provide a deeper understanding of this highly rated feature and its contribution to the brand’s success.

## ASSUMPTIONS

### 1. The scraped data accurately reflects all available shoe products on the retail website at the time of scraping. No critical product information was omitted during the scraping process.
### 2. Customer ratings and reviews on the website are representative and not manipulated or biased (e.g., fake reviews).
### 3. The number of ratings and reviews collected for each shoe is large enough to be reliable for drawing conclusions.
### 4. The product categories, such as “women’s running shoes,” are correctly labeled by the website and were accurately scraped during the process.
### 5. The product features (e.g., sole height, weight, materials) were consistently reported for all shoes, and no key features were omitted.

