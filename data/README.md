Data files for **O'Leary et al. (2020), "Effects of estuary-wide seagrass loss on fish populations"**, in the journal *Estuaries and Coasts*. 

- `seine_fish_data.csv` contains IDs, lengths, estimated weights, and trophic levels for individual fish collected in beach seine samples: 
  
  - `seine_id`: unique identifier for each seine sample
  - `site_name`: Site where seine was conducted. Windy Cove (back bay) or Colemans (fore bay).
  - `date`, `year`, & `time`: Time information for each seine. Start time is **HH:MM AM/PM**, date is **MM/DD/YYYY**.
  - `lat` & `long`: Latitude and longitude of seine sample in decimal degrees.
  - `distance`: Distance seine was dragged along the benthos.
  - `common_name`, `genus` & `species`: Species identifiers for each individual fish caught in seine.
  - `length_mm`: Total length of fish in mm.
  - `weight_g`: Body mass of fish in grams, estimated using length-to-weight conversion factors from FishBase.
  - `trophic_level`: Estimated trophic level of fish gathered from FishBase.
- `seine_fishbase_data.csv` contains species-level information on each unique species collected in the seines, including length-to-weight conversion factors and trophic level estimates.
  
  - `Species`: Genus and species
  
  - `lw_a` & `lw_b`: Coefficients for length to weight conversion. Weight in grams is given by: 
    $$
    W_\text{g} = a + (L_{\text{mm}} \times 10)^b
    $$
  
  - `lw_level`: Source for length-to-weight conversion coefficients - either from data for the species, or estimated based on nearest neighbors.
  
  - `lw_type`: Type of length assumed by coefficients - all are total length.
  
  - `trophic_level`: Estimated trophic level.
  
  - `trophic_level_se`: Standard error of trophic level estimate.
  
  - `trophic_level_type`: Source for trophic level information, e.g. from species-level diet studies of from model estimates based on nearest relatives.
  
  - `trophic_level_ref`: Reference for trophic level estimates, if relevant.
- `trawl_fish_counts.csv` contains abundance data for each survey sample. For each unique species in the dataset, the number of individuals of that species is given for each trawl survey. Zeros were added for species that were not observed in a given trawl, making it convenient to transform this data to wide format for calculating dissimilarity matrices and running analyses.
  
  - `Year`, `Season`, & `Date`: Time information for each trawl. Date is **MM/DD/YYYY**. Trawls conducted in 2006 and 2007 are considered pre-eelgrass decline; trawls conducted in 2016 and 2017 are considered post-eelgrass decline. Season is either fall or summer.
  - `TrawlType`: Type of trawl used for survey (beam trawl or otter trawl). Beam trawls were used in the intertidal flats, otter trawls were used in the channel.
  - `Site`: Site identifier. There are three unique sites in the channel and four in the intertidal flats (but only three were used in analysis, site beam 3 was discarded because it was not surveyed in the pre-decline period).
  - `Replicate`: The replicate number for the given trawl type, period (pre-decline or post-decline), and season (fall or summer). The replicate is not a unique identifier for the sample unless these other variables are considered.
  - `Genus` & `Species`: Genus and species of fish.
  - `Count`: Number of individuals of the given species found in the sample.
- `trawl_fish_lengths.csv` contains length and weight data for each fish recorded in each trawl survey. Trawls which did not record any individuals do not appear in this dataset. When using these data to compute biomass-per-trawl, it is necessary to add back in zeros for trawls that do not appear in this dataset but do appear in `trawl_fish_counts.csv`.
  
  - `Year`, `Season`, & `Date`:  Time information for each trawl. Date is **MM/DD/YYYY**. Trawls conducted in 2006 and 2007 are considered pre-eelgrass decline; trawls conducted in 2016 and 2017 are considered post-eelgrass decline. Season is either fall or summer.
  - `CollectorNames`: Names of data collectors. Surveys in the pre-decline period were conducted by John Stephens and others, surveys in the post-decline period were conducted by Jennifer O'Leary, John Stephens, and others.
  - `TrawlType`: Type of trawl used for survey (beam trawl or otter trawl). Beam trawls were used in the intertidal flats, otter trawls were used in the channel.
  - `Site`: Site identifier. There are three unique sites in the channel and four in the intertidal flats (but only three were used in analysis, site beam 3 was discarded because it was not surveyed in the pre-decline period).
  - `Replicate`: The replicate number for the given trawl type, period (pre-decline or post-decline), and season (fall or summer). The replicate is not a unique identifier for the sample unless these other variables are considered.
  - `Common_name`, `Genus`, & `Species`: Species identifiers for each individual fish caught in trawl.
  - `Length_mm`: Total length of the individual fish, in mm.
  - `weight_g`: Mass of the fish estimated using length-to-weight conversion factors from FishBase, in grams.
  - `trophic_level`: Estimated trophic level of the fish, from FishBase. There is one unique estimate for each species. 
- `trawl_fishbase_data.csv` contains species-level information on each unique species collected in the trawl surveys, including length-to-weight conversion factors and trophic level estimates.
  
  - `sciname`: Genus and species.
  
  - `a` & `b`: Coefficients for length to weight conversion. Weight in grams is given by: 
    $$
        W_\text{g} = a + (L_{\text{mm}} \times 10)^b
    $$
  
  - `trophic_level`: Estimated trophic level.
  
  - `trophic_level_se`: Standard error of trophic level estimate.
  
  - `LW_Notes`: Notes on length-to-weight conversion factor. Unless otherwise stated, conversion factors are from studies on the species, and not a model estimate.
  
  - `Troph_Notes`: Notes on trophic level estimate. Unless otherwise stated, trophic level data are from diet studies, and not estimates based on closest relatives.
- `trawl_information.csv` contains metadata for trawls conducted in the study. Because of irregularities and missing values in the metadata given for the pre-decline period, not all trawls in the pre-decline period have metadata, and some latitude and longitude data from the pre-decline may not be correct as it needed to be coerced to a standard format, and the format that some latitude and longitude values were given in was ambiguous. Not all trawls recorded in this dataset were included in the analysis; for example, there were spring surveys in the pre-decline period but only data from fall and summer was analyzed.
  
  - `Period`, `Year`, `Season`, & `Date`: Time information for the trawl survey. Trawls conducted in 2006 and 2007 are considered pre-eelgrass decline; trawls conducted in 2016 and 2017 are considered post-eelgrass decline. Date is given as mm/dd/yyyy.
  - `time_start` & `time_end`: Start and end time for each trawl. Time format is **YYYY-MM-DD HH:MM:SS TZ**; all times are given in Pacific Daylight Time (PDT).
  - `lat_start`, `long_start`, `lat_end`, & `long_end`: Start and end coordinates for each trawl. Coordinates are given in decimal degrees.
  - `trawl_length_min`: Length of the trawl in minutes. May have been recorded by collector or calculated based on difference between recorded start and stop time.
  - `depth_m`: For pre-decline surveys, only one depth value was recorded; it is given in this column. For post-decline surveys, start depth, end depth, minimum depth, and maximum depth were recorded, and this column contains the mean of the start and end depth. Depth is in meters.
  - `depth_start` & `depth_end`: For post-decline surveys, the start and end depth in meters.
  - `depth_min` & `depth_max`:  For post-decline surveys, the minimum and maximum depth in meters.
  - `tow_direction`: For post-decline surveys, the recorded direction of the tow. This data has not been standardized and is given as recorded.
  - `boat_speed`: For post-decline surveys, boat speed in knots.
  - `collectors`: Names of data collectors. Surveys in the pre-decline period were conducted by John Stephens and others, surveys in the post-decline period were conducted by Jennifer O'Leary, John Stephens, and others.