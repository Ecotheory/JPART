*===============================================================================*
*	Replication for Tables in "Data Manipulation through Patronage Networks"	*
*===============================================================================*
*install command
	ssc install sum2docx, replace
	ssc install reg2docx, replace
*select work path
	cd "/Users/yl/Desktop/replication" //mac

*************************
*	Summary: Table 1	*
*************************
*== Table 1: Summary Statistics ==*
	use "data/JPART",clear
	keep if year>=2005 & year<=2014 //years
	sum2docx Connect ln_ManipulationSO2 ln_SatelliteSO2 ln_OfficialSO2 ln_GDPper GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Populatoin ln_Popdensity Temperature Precipitation Cloud using "result/Tables.docx", replace stats(N mean(%9.2f) sd(%9.2f) min(%9.2f) max(%9.2f)) title("Table 1: Summary Statistics")	
	*PM2.5
	use "data/JPART",clear
	keep if year>=2014 & year<=2015 //years
	sum2docx ln_ManipulationPM25 ln_SatellitePM25 ln_OfficialPM25 using "result/Tables.docx", append stats(N mean(%9.2f) sd(%9.2f) min(%9.2f) max(%9.2f)) title("Table 1: Summary Statistics (PM2.5)")	
	
*********************************************
*	Regression Result: Table 2-4; Table 6-8	*
*********************************************
*use data
	use "data/JPART",clear
*controls	
	gl eco ln_GDPper GDPgrowth Ratio_Second ln_Industry ln_Retail
	gl pop ln_Populatoin ln_Popdensity
	gl wea Temperature Precipitation Cloud
	xtset cityid year
	keep if year>=2005 & year<=2014 //years
*just for ouput	
	g cfe=(cityid==131000)
	g yfe=(year==2005)
	g ypfe=(cityid==132000)
	
*== Table 2: Baseline Results for SO2 Data Manipulation ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_SatelliteSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m7: reghdfe ln_OfficialSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m8: reghdfe ln_OfficialSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m9: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/Tables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 2: Baseline Results for SO2 Data Manipulation")
	
*== Table 3: The Impact of Connections to Provincial Environmental Administrators ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_SatelliteSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_OfficialSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Year FE=yfe" "City FE=cfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 3: The Impact of Connections to Provincial Environmental Administrators on Data Manipulation")
	
*== Table 4: The Impact of Age Effect ==*
	g CitysecAge2=CitysecAge^2
	g ConnectxCitysecAge=Connect*CitysecAge
	g ConnectxCitysecAge2=Connect*CitysecAge2
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Year FE=yfe" "City FE=cfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 4: The Impact of Age Effect")
	
*== Table 6: Personal Characteristic Effect ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Year FE=yfe" "City FE=cfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 6: Personal Characteristic Effect")
	
*== Table 7: Robustness Test of High Dimension FE ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Year FE=yfe" "City FE=cfe" "Province×Year FE=ypfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 7: Robustness Test of High FE")
	
*== Table 8: Other Types of Connections ==*
	ren (Work_Connect School_Connect Hometown_Connect) (work school hometown)
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	eststo m7: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m8: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m9: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Year FE=yfe" "City FE=cfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 8: Other Types of Connections")
	
*************************************
*	Regression Result: Table 5		*
*************************************
*use data
	use "data/JPART",clear
*controls	
	gl eco ln_GDPper GDPgrowth Ratio_Second ln_Industry ln_Retail
	gl pop ln_Populatoin ln_Popdensity
	gl wea Temperature Precipitation Cloud
	xtset cityid year
	keep if year>=2014 & year<=2015 //years
*just for ouput	
	g pfe=(cityid==130000)
	
*== Table 5: Robustness Test by PM2.5 ==*	
	eststo m1: reghdfe ln_ManipulationPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m2: reghdfe ln_SatellitePM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m3: reghdfe ln_OfficialPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	reg2docx m1 m2 m3 using "result/Tables.docx", append indicate("Economic Controls=ln_GDPper" "Population Controls=ln_Populatoin" "Weather Controls=Temperature" "Province FE=pfe") drop(GDPgrowth Ratio_Second ln_Industry ln_Retail ln_Popdensity Precipitation Cloud _cons) scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table 5: Robustness Test by PM2.5")
	
	
	
