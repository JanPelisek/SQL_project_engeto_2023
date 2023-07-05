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
  - [Řešení](/q1.sql)
 
  
- **Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
  - [Řešení](/q2.sql)
- **Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
  - [Řešení](/q3.sql)
- **Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
  - [Řešení](q4.sql)
- **Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**
  - [Řešení](q5.sql)
 
  - ![image](https://github.com/JanPelisek/SQL_project_engeto_2023/assets/52496899/9b5c0ce6-c10a-44e1-b1be-0b57b96ff4de)

 
