---- ######### Bar Chart Implementation    ############   ------

---- Look Up Table - Data Insertion 


---- Provider Hypothesis - Data Insertion
INSERT INTO interactive_maps_uat.provider_Hypothesis(id, yearid, reporting_optionid, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum)
values(1, 5, 1, 1, 'YES','NO', 264631, 1094961, 19.46, 80.54, 1359592);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, yearid, reporting_optionid, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum)
values(1, 5, 1, 2, 'YES','NO', 30744, 1328848, 2.26, 97.74, 1359592);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, yearid, reporting_optionid, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum)
values(1, 5, 1, 3, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, yearid, reporting_optionid, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum)
values(1, 5, 1, 4, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592);

---- Line Chart Releated  -------

---- CLAIMS  -----  Mental Health HPSA Percentage  (Base Year to OY3)
INSERT INTO interactive_maps_uat.provider_Hypothesis(id, year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, provider_percent)
values(5, 1, 1, 1, 'YES','NO', 264631, 1094961, 19.46, 80.54, 1359592,17.26);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, provider_percent)
values(6, 2, 1, 1, 'YES','NO', 30744, 1328848, 2.26, 97.74, 1359592,19.45);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, provider_percent)
values(7, 3, 1, 1, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592,20.17);

INSERT INTO interactive_maps_uat.provider_Hypothesis(id, year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, provider_percent)
values(8, 4, 1, 1, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592,19.50);


---- EHR  -----  Mental Health HPSA Percentage  (Base Year to OY3)
INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 1, 2, 1, 'YES','NO', 264631, 1094961, 19.46, 80.54, 1359592,19.38);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 2, 2, 1, 'YES','NO', 30744, 1328848, 2.26, 97.74, 1359592,24.69);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 3, 2, 1, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592,20.86);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 4, 2, 1, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592,21.07);


---- Registry  -----  Mental Health HPSA Percentage  (Base Year to OY3)
INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 1, 3, 1, 'YES','NO', 264631, 1094961, 19.46, 80.54, 1359592,21.09);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 2, 3, 1, 'YES','NO', 30744, 1328848, 2.26, 97.74, 1359592,19.56);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 3, 3, 1, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592,23.23);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 4, 3, 1, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592,22.11);


---- GPROWI  -----  Mental Health HPSA Percentage  (Base Year to OY3)

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 2, 4, 1, 'YES','NO', 30744, 1328848, 2.26, 97.74, 1359592,16.22);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 3, 4, 1, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592,18.52);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 4, 4, 1, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592,20.07);


---- QCDR  -----  Mental Health HPSA Percentage  (Base Year to OY3)

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 3, 5, 1, 'YES','NO', 143519, 1216073, 10.56, 89.44, 1359592,13.51);

INSERT INTO interactive_maps_uat.provider_Hypothesis( year_id, reporting_option_id, parameter_id, yes_value, no_value, yes_count, no_count, yes_percent, no_percent, total_sum, rp_percent)
values( 4, 5, 1, 'YES','NO', 1234423, 125169, 90.79, 9.21, 1359592,15.55);

