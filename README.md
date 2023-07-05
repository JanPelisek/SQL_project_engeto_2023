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
| year  | industry_branch_name                                         | avg_payroll_value | previous_payroll | is_rising |
| ----- | ------------------------------------------------------------ | ----------------- | ---------------  | --------  |
| 2,013 | Administrativní a podpůrné činnosti                          | 16,829            | 17,041           | 0         |
| 2,009 | Činnosti v oblasti nemovitostí                               | 20,706            | 20,790           | 0         |
| 2,013 | Činnosti v oblasti nemovitostí                               | 22,152            | 22,553           | 0         |
| 2,011 | Doprava a skladování                                         | 23,062            | 23,063           | 0         |
| 2,013 | Informační a komunikační činnosti                            | 46,155            | 46,641           | 0         |
| 2,013 | Kulturní, zábavní a rekreační činnosti                       | 20,511            | 20,808           | 0         |
| 2,013 | Peněžnictví a pojišťovnictví                                 | 46,317            | 50,801           | 0         |
| 2,010 | Profesní, vědecké a technické činnosti                       | 31,602            | 31,791           | 0         |
| 2,013 | Profesní, vědecké a technické činnosti                       | 31,825            | 32,817           | 0         |
| 2,013 | Stavebnictví                                                 | 22,379            | 22,850           | 0         |
| 2,009 | Těžba a dobývání                                             | 28,361            | 29,273           | 0         |
| 2,013 | Těžba a dobývání                                             | 31,487            | 32,540           | 0         |
| 2,014 | Těžba a dobývání                                             | 31,302            | 31,487           | 0         |
| 2,016 | Těžba a dobývání                                             | 31,626            | 31,809           | 0         |
| 2,009 | Ubytování, stravování a pohostinství                         | 12,334            | 12,472           | 0         |
| 2,011 | Ubytování, stravování a pohostinství                         | 13,131            |  13,205          | 0         |
| 2,013 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | 23,130            | 23,324           | 0         |
| 2,010 | Veřejná správa a obrana; povinné sociální zabezpečení        | 26,944            | 27,035           | 0         |
| 2,011 | Veřejná správa a obrana; povinné sociální zabezpečení        | 26,331            | 26,944           | 0         |
| 2,011 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu  | 40,202            | 40,296           | 0         |
| 2,013 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu  | 40,762            | 42,657           | 0         |
| 2,015 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu  | 40,453            | 41,094           | 0         |
| 2,010 | Vzdělávání                                                   | 23,023            | 23,416           | 0         |
| 2,013 | Zásobování vodou; činnosti související s odpady a sanacemi   | 23,616            | 23,718           | 0         |
| 2,009 | Zemědělství, lesnictví, rybářství                            | 17,645            | 17,764           | 0         |
  - [Datový podklad](/q2.sql)
- **Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
  - [Řešení](/q3.sql)
- **Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
  - [Řešení](q4.sql)
- **Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**
![image](https://github.com/JanPelisek/SQL_project_engeto_2023/assets/52496899/2a2e2364-2bc6-49e4-bc32-985d4fea9f88)
  - [Datový podklad](q5.sql)
