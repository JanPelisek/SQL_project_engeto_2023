# Dostupnost základních potravin široké veřejnosti
Finální projekt Datové Akademie Engeto
## Zadání projektu
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.
## Popis datových sad
Data pocházejí z portálu otevřených dat České republiky

**[Primární tabulka](/primary_table.sql) -** obsahuje data mezd (pro přepočtený počet zaměstnanců na plný úvazek) a cen základních potravin mezi roky 2006 - 2018.

**[Sekundární tabulka](/secondary_table.sql) -** obsahuje data HDP, Gini koeficientů a populace evropských států mezi roky 2006 - 2018.

## Výzkumné otázky

- **Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

|year|industry_branch_name|avg_payroll_value|previous_payroll|is_rising|
|----|--------------------|-----------------|----------------|---------|
|2009|Zemědělství, lesnictví, rybářství|17645|17764|0|
|2009|Těžba a dobývání|28361|29273|0|
|2009|Ubytování, stravování a pohostinství|12334|12472|0|
|2009|Činnosti v oblasti nemovitostí|20706|20790|0|
|2010|Vzdělávání|23023|23416|0|
|2010|Profesní, vědecké a technické činnosti|31602|31791|0|
|2010|Veřejná správa a obrana; povinné sociální zabezpečení|26944|27035|0|
|2011|Ubytování, stravování a pohostinství|13131|13205|0|
|2011|Doprava a skladování|23062|23063|0|
|2011|Veřejná správa a obrana; povinné sociální zabezpečení|26331|26944|0|
|2011|Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu|40202|40296|0|
|2013|Kulturní, zábavní a rekreační činnosti|20511|20808|0|
|2013|Těžba a dobývání|31487|32540|0|
|2013|Administrativní a podpůrné činnosti|16829|17041|0|
|2013|Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu|40762|42657|0|
|2013|Činnosti v oblasti nemovitostí|22152|22553|0|
|2013|Peněžnictví a pojišťovnictví|46317|50801|0|
|2013|Velkoobchod a maloobchod; opravy a údržba motorových vozidel|23130|23324|0|
|2013|Zásobování vodou; činnosti související s odpady a sanacemi|23616|23718|0|
|2013|Profesní, vědecké a technické činnosti|31825|32817|0|
|2013|Informační a komunikační činnosti|46155|46641|0|
|2013|Stavebnictví|22379|22850|0|
|2014|Těžba a dobývání|31302|31487|0|
|2015|Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu|40453|41094|0|
|2016|Těžba a dobývání|31626|31809|0|

   - [Datový podklad](/q1.sql)

- **Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

|year|product_name|avg_price_value|price_unit|avg_payroll|units_per_payroll|
|----|------------|---------------|----------|-----------|-----------------|
|2006|Chléb konzumní kmínový|16.12|kg|21165.32|1312.99 kg|
|2006|Mléko polotučné pasterované|14.44|l|21165.32|1465.74 l|
|2018|Chléb konzumní kmínový|24.24|kg|33091.63|1365.17 kg|
|2018|Mléko polotučné pasterované|19.82|l|33091.63|1669.61 l|

  - [Datový podklad](/q2.sql)
    
- **Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

|product_name|perc_narust_final|
|------------|-----------------|
|Cukr krystalový|-1.92|
|Rajská jablka červená kulatá|-0.74|
|Banány žluté|0.81|
|Vepřová pečeně s kostí|0.99|
|Přírodní minerální voda uhličitá|1.02|
|Šunkový salám|1.85|
|Jablka konzumní|2.01|
|Pečivo pšeničné bílé|2.2|
|Hovězí maso zadní bez kosti|2.53|
|Kapr živý|2.6|
|Jakostní víno bílé|2.7|
|Pivo výčepní, světlé, lahvové|2.85|
|Eidamská cihla|2.92|
|Mléko polotučné pasterované|2.98|
|Rostlinný roztíratelný tuk|3.23|
|Kuřata kuchaná celá|3.38|
|Pomeranče|3.6|
|Jogurt bílý netučný|3.95|
|Chléb konzumní kmínový|3.97|
|Konzumní brambory|4.18|
|Rýže loupaná dlouhozrnná|5.0|
|Mrkev|5.23|
|Pšeničná mouka hladká|5.24|
|Těstoviny vaječné|5.26|
|Vejce slepičí čerstvá|5.56|
|Máslo|6.68|
|Papriky|7.29|


  - [Datový podklad](/q3.sql)
    
- **Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

|year|avg_pay_rise|avg_price_rise|difference|
|----|------------|--------------|----------|
|2009|2.84|-6.59|9.43|
|2013|-0.78|6.01|6.79|
|2018|7.88|2.41|5.47|
|2016|3.93|-1.41|5.34|
|2012|2.61|7.47|4.86|
|2015|2.90|-0.69|3.59|
|2014|2.55|-0.62|3.17|
|2011|2.33|4.84|2.51|
|2007|6.91|9.26|2.35|
|2008|7.08|8.92|1.84|
|2017|6.40|7.06|0.66|
|2010|2.15|1.52|0.63|


  - [Datový podklad](q4.sql)
    
- **Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**
![image](https://github.com/JanPelisek/SQL_project_engeto_2023/assets/52496899/2a2e2364-2bc6-49e4-bc32-985d4fea9f88)
  - [Datový podklad](q5.sql)
