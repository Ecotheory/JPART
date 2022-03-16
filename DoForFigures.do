*===============================================================================*
*	Replication for Figures in "Data Manipulation through Patronage Networks"	*
*===============================================================================*
*select work path
	cd "/Users/yl/Desktop/replication" //mac
	
*********************************
*	Kernel Density: Figure 1-3	*
*********************************
*use data
	use "data/JPART",clear
	ren ln_SatelliteSO2 Satellite
	ren ln_OfficialSO2 Official
	
*== Figure 1: Kernel Density of SO2 Data in 2008 ==*
	twoway (kdensity Satellite if Connect==1, lcolor(navy) lwidth(medthick) lpattern(solid)) (kdensity Official if Connect==1, lcolor(navy) lwidth(medthick) lpattern(longdash)) (kdensity Satellite if Connect==0, lcolor(maroon) lpattern(solid)) (kdensity Official if Connect==0, lcolor(maroon) lpattern(longdash)) if year==2008, ylabel(, angle(horizontal) format(%7.1f)) title(Kernel Density of SO2 Data (2008), size(medlarge) margin(small)) scheme(s1color) xtitle("") legend(label(1 "Satellite Connect") label(2 "Official Connect") label(3 "Satellite No-connect") label(4 "Official No-connect"))
	graph export "result/Figure1.png", as(png) name("Graph") replace
	
*== Figure 2: Kernel Density of SO2 Data in 2012 ==*
	twoway (kdensity Satellite if Connect==1, lcolor(navy) lwidth(medthick) lpattern(solid)) (kdensity Official if Connect==1, lcolor(navy) lwidth(medthick) lpattern(longdash)) (kdensity Satellite if Connect==0, lcolor(maroon) lpattern(solid)) (kdensity Official if Connect==0, lcolor(maroon) lpattern(longdash)) if year==2012, ylabel(, angle(horizontal) format(%7.1f)) title(Kernel Density of SO2 Data (2012), size(medlarge) margin(small)) scheme(s1color) xtitle("") legend(label(1 "Satellite Connect") label(2 "Official Connect") label(3 "Satellite No-connect") label(4 "Official No-connect"))
	graph export "result/Figure2.png", as(png) name("Graph") replace
	
*==Figure 3: Kernel Density of SO2 Manipulation Data ==*
	histogram ln_ManipulationSO2, fcolor(none) lcolor(gray) normal title(Kernel Density of SO2 Manipulation Coefficient , size(medium) margin(small)) scheme(s1mono)
	graph export "result/Figure3.png", as(png) name("Graph") replace
	
*****************************************
*	City Leader’s Age Effect: Figure 4	*
*****************************************
*use data
	use "data/JPART",clear
*controls	
	gl eco ln_GDPper GDPgrowth Ratio_Second ln_Industry ln_Retail
	gl pop ln_Populatoin ln_Popdensity
	gl wea Temperature Precipitation Cloud
	xtset cityid year
	keep if year>=2005 & year<=2014 //years
*interaction term
	g CitysecAge2=CitysecAge^2
	g ConnectxCitysecAge=Connect*CitysecAge
	g ConnectxCitysecAge2=Connect*CitysecAge2
*== Figure 4: The Marginal Effects of Connection on Manipulation ==*
	reghdfe ln_ManipulationSO2  $eco $pop $wea Connect##c.CitysecAge##c.CitysecAge, ab(cityid year) cluster(cityid)
	margins, dydx(Connect) at (CitysecAge=(40(2)64))
	marginsplot, recast(line) plotopts(lcolor(black)) recastci(rline) ciopts(lpattern(dash) lcolor(black))  level(95)  scheme(s1mono) title(Average Marginal Effects of Connection with 95% CIs, size(medium)  margin(small)) ytitle(Effects on SO2 Manipulation Coefficient, size(medsmall)) xtitle(City Secretary Age, size(medsmall)) 
	graph export "/Users/yl/Desktop/replication/result/Figure4.png", as(png) name("Graph") replace
	
	
