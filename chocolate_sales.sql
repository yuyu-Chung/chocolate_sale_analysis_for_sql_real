
use practice_1;

select* from practice_1.chocolate_sales;

With `Super Star Sales list` as
(select `Sales Person`, 
count(`Sales Person`) as sold_count,  
sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount 
from  practice_1.chocolate_sales
group by `Sales Person`
order by `sold_amount` desc)
select* from `Super Star Sales list`;

select `Country` from practice_1.chocolate_sales
where `Sales Person` = "Ches Bonnell";

With  `Top Country sold chocolate list`AS
(select `Country`, 
count(`Country`) as sold_country_count,
sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount
from  practice_1.chocolate_sales
group by `Country`
order by `sold_amount` desc)
select* from  `Top Country sold chocolate list`;
 
select* from practice_1.chocolate_sales;

With  `Best sold product list`AS
(select `Product`, 
count(`Product`) as sold_product_count,
sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount
from  practice_1.chocolate_sales
group by `Product`
order by `sold_amount` desc)
select* from  `Best sold product list`;


With 
    `Super Star Sales list` as
        (select `Sales Person`, 
		     count(`Sales Person`) as total_sold_count,  
             sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as total_sold_amount 
		 from  practice_1.chocolate_sales
         group by `Sales Person`),
    `Who Where What is the best sold list`AS
         (select `Sales Person`, 
              `Country`,
              `Product`,
              #count(`Sales Person`) as sold_person_count,
              #count(`Country`) as sold_country_count,
              #count(`Product`) as sold_product_count,
              sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount
          from  practice_1.chocolate_sales
          group by `Sales Person`, `Country`, `Product`),
ranked as
          (select*, 
                      ROW_NUMBER() OVER (partition by `Sales Person`
																  ORDER BY `sold_amount` desc) AS rn
            from  `Who Where What is the best sold list`)
select r.* , ss.total_sold_count, ss.total_sold_amount,  sold_amount/ss.total_sold_amount as ratio
from ranked r
inner join `Super Star Sales list` ss on r.`Sales Person` =  ss.`Sales Person`
 where rn=1
 order by total_sold_amount desc;
 
 
 With 
       `Top Country sold chocolate list` 
        AS (select Country, 
							count(Country) as total_sold_country_count, 
                            sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as total_sold_country_amount 
				from practice_1.chocolate_sales 
                group by Country),
		`Who Where What is the best sold list`
        AS (select `Sales Person`, 
                            Country, 
                            Product, 
                            #count(Sales Person) as sold_person_count, 
                            #count(Country) as sold_country_count, 
                            #count(Product) as sold_product_count, 
                            sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount 
				from practice_1.chocolate_sales 
                group by `Sales Person`, Country, Product), 
		ranked as 
				(select*, 
                            ROW_NUMBER() OVER (partition by Country 
                                                                        ORDER BY sold_amount desc) AS rn
				 from  `Who Where What is the best sold list`)
		select r.* , cc.total_sold_country_count, cc.total_sold_country_amount, sold_amount/cc.total_sold_country_amount as ratio 
        from ranked r 
        inner join `Top Country sold chocolate list` cc on r.Country = cc.Country 
        where rn=1 
        order by total_sold_country_amount desc;



With 
       `Best sold product list`AS
           (select `Product`, 
                         count(`Product`) as sold_product_count,
                         sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as total_sold_product_amount
			from  practice_1.chocolate_sales
            group by `Product`),
		`Who Where What is the best sold list`AS 
            (select `Sales Person`, 
                            Country, 
                            Product, 
                            #count(Sales Person) as sold_person_count, 
                            #count(Country) as sold_country_count, 
                            #count(Product) as sold_product_count, 
                            sum(cast(replace(replace(Amount, "$", ""), ",", "") as decimal(10, 2))) as sold_amount 
			from practice_1.chocolate_sales 
			group by `Sales Person`, Country, Product), 
		ranked as 
				(select*, 
                            ROW_NUMBER() OVER (partition by Product 
                                                                        ORDER BY sold_amount desc) AS rn
				 from  `Who Where What is the best sold list`)
		select r.* , pp.sold_product_count, pp.total_sold_product_amount, sold_amount/pp.total_sold_product_amount as ratio 
        from ranked r 
        inner join `Best sold product list` pp on r.Product = pp.Product 
        where rn=1 
        order by total_sold_product_amount desc;