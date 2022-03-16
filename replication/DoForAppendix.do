*===============================================================================================*
*	Replication for Online Appendix Tables in "Data Manipulation through Patronage Networks"	*
*===============================================================================================*
*install command
	ssc install sum2docx, replace
	ssc install reg2docx, replace
*select work path
	cd "/Users/yl/Desktop/replication" //mac

*********************************************************************
*	Regression Tables with All Variables (Table A2-A4; Table A6-A8)	*
*********************************************************************
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
	
*== Table A1: Baseline Results (All Variables, Standard Errors) ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_SatelliteSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m7: reghdfe ln_OfficialSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m8: reghdfe ln_OfficialSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m9: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/AppendixTables.docx", replace indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A1: Baseline Results (All Variables, Standard Errors)")
	
*== Table A2: Baseline Results (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_SatelliteSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m7: reghdfe ln_OfficialSO2 yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m8: reghdfe ln_OfficialSO2 $eco yfe cfe Connect, absorb(cityid year) cluster(cityid)
	eststo m9: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A2: Baseline Results (All Variables, p-values)")
	
	
*== Table A3-1: The Impact of Connections to Provincial Environmental Administrators (All Variables, Standard Errors) ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_SatelliteSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_OfficialSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A3-1: The Impact of Connections to Provincial Environmental Administrators (All Variables, Standard Errors)")
	
*== Table A3-2: The Impact of Connections to Provincial Environmental Administrators (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_SatelliteSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_OfficialSO2 yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect_Csec_Environ, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A3-2: The Impact of Connections to Provincial Environmental Administrators (All Variables, p-values)")
	
	
*== Table A4-1: The Impact of Age Effect (All Variables, Standard Errors) ==*
	g CitysecAge2=CitysecAge^2
	g ConnectxCitysecAge=Connect*CitysecAge
	g ConnectxCitysecAge2=Connect*CitysecAge2
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A4-1: The Impact of Age Effect (All Variables, Standard Errors)") order(Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2)
	
*== Table A4-2: The Impact of Age Effect (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2,absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A4-2: The Impact of Age Effect (All Variables, p-values)") order(Connect CitysecAge CitysecAge2 ConnectxCitysecAge ConnectxCitysecAge2)
	
	
*== Table A6-1: Robustness Test by PM2.5 (All Variables, Standard Errors) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A6-1: Personal Characteristic Effect (All Variables, Standard Errors)") order(Connect)
	
*== Table A6-2: Robustness Test by PM2.5 (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe Connect Edu_Bachelor Exp_University Exp_Central Exp_Youth Exp_County Exp_Enterprise Exp_Finance, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A6-2: Personal Characteristic Effect (All Variables, p-values)") order(Connect)
	
	
*== Table A7-1: Robustness Test of High Dimension FE (All Variables, Standard Errors) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe" "Province×Year FE=ypfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A7-1: Robustness Test of High Dimension FE (All Variables, Standard Errors)") order(Connect)
	
*== Table A7-2: Robustness Test of High Dimension FE (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m2: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	eststo m3: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe ypfe Connect, absorb(cityid year provid##year) cluster(cityid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe" "Province×Year FE=ypfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A7-2: Robustness Test of High Dimension FE (All Variables, p-values") order(Connect)
	
	
*== Table A8-1: Other Types of Connections (All Variables, Standard Errors) ==*
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
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A8-1: Other Types of Connections (All Variables, Standard Errors)") 
	
*== Table A8-2: Other Types of Connections (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m2: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m3: reghdfe ln_ManipulationSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	eststo m4: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m5: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m6: reghdfe ln_SatelliteSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	eststo m7: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe work, absorb(cityid year) cluster(cityid)
	eststo m8: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe school, absorb(cityid year) cluster(cityid)
	eststo m9: reghdfe ln_OfficialSO2 $eco $pop $wea yfe cfe hometown, absorb(cityid year) cluster(cityid)
	reg2docx m1 m2 m3 m4 m5 m6 m7 m8 m9 using "result/AppendixTables.docx", append indicate("Year FE=yfe" "City FE=cfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A8-2: Other Types of Connections (All Variables, p-values)") 
	
	
*****************************************************
*	Regression Result with All Variables (Table A5)	*
*****************************************************
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
	
*== Table A5-1: Robustness Test by PM2.5 (All Variables, Standard Errors) ==*
	eststo m1: reghdfe ln_ManipulationPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m2: reghdfe ln_SatellitePM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m3: reghdfe ln_OfficialPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Province FE=pfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) se(%7.3f) title("Table A5-1: Robustness Test by PM2.5 (All Variables, Standard Errors)") order(Connect)
	
*== Table A5-2: Robustness Test by PM2.5 (All Variables, p-values) ==*
	eststo m1: reghdfe ln_ManipulationPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m2: reghdfe ln_SatellitePM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	eststo m3: reghdfe ln_OfficialPM25 $eco $pop $wea Connect pfe, absorb(provid) cluster(provid)
	reg2docx m1 m2 m3 using "result/AppendixTables.docx", append indicate("Province FE=pfe") drop() scalars(r2_a(%9.3f) N_clust N) b(%9.3f) p(%7.3f) title("Table A5-2: Robustness Test by PM2.5 (All Variables, p-values)") order(Connect)
	
	
	
