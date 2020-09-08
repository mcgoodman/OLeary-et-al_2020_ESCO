
## Cluster Bootstrap Standard Deviations -------------------------------

### Function takes a grouped data frame of clustered data
### Splits data frame by groups, and estimates standard deviation
### of response by two-stage cluster bootstrap

library("doSNOW")
library("doParallel")
library("foreach")

run_cluster_bootstrap <- function(data, x, cluster_var, reps) {
  
  clusters = unique(data[[quo_name(cluster_var)]])
  group_mean = mean(data[[quo_name(x)]], na.rm = TRUE)

  sample_means <-
  foreach(i=seq(reps), .packages = "dplyr", .combine = "c") %dopar% {
    clust_sample = sample(clusters, size = length(clusters), replace = TRUE)
    
    data_sample = lapply(clust_sample, function(x) which(data[[quo_name(cluster_var)]] == x))
    data_sample = data[unlist(data_sample),]
    data_sample = data_sample[sample(seq(nrow(data_sample)), size = nrow(data_sample), replace = TRUE),]
    
    mean(data_sample[[quo_name(x)]], na.rm = TRUE)
  }
  
  group_sd = sd(sample_means)
  
  return(data.frame(unique(dplyr::select(data, -one_of(c(quo_name(cluster_var), quo_name(x))))), 
                    mean = group_mean, sd = group_sd,
                    upper = group_mean + group_sd, 
                    lower = group_mean - group_sd))
}

cluster_bootstrap <- function(data, x, cluster_var, reps = 10000) {
  x <- enquo(x)
  cluster_var <- enquo(cluster_var)
  
  cl <- makeCluster(detectCores())
  registerDoParallel(cl)
  
  clusterCall(cl, function(x) .libPaths(x), .libPaths())
  
  data %<>% 
    dplyr::select(!!cluster_var, !!x) %>% 
    do(run_cluster_bootstrap(., x, cluster_var, reps)) %>% 
    ungroup()
  
  stopCluster(cl)
  
  data
}

