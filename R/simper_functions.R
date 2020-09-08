
filter_sp <- function(data) data[, names(which(colSums(data) > 0))]

format_simper <- function(simper_data) {
  simper_data <- simper_data %>% 
    rownames_to_column("Species") %>% 
    mutate(contrib = NA)
  
  for (i in seq(nrow(simper_data))) {
    if (i == 1) {
      simper_data$contrib[i] = simper_data$cumsum[i]
    } else {
      simper_data$contrib[i] = simper_data$cumsum[i] - 
        simper_data$cumsum[i - 1]
    }
  }
  
  simper_data <- simper_data %>% 
    mutate(n = nrow(.)) %>% 
    filter(contrib > 1/nrow(.)) %>% 
    dplyr::select(-contrib) %>% 
    mutate_if(is.numeric, round, digits = 2)
  
  simper_data
}

sum_seine_abundance <- function(df, species, group) {
  df <- df[, c("site_name", "seagrass_unvegetated", "year", species)] %>% 
    gather_("species", "density", gather_cols = species) %>% 
    group_by_(group, "species") %>% 
    summarize(mean = mean(density), 
              se = sd(density)/sqrt(n()), 
              upper = mean + se, 
              lower = mean - se) %>% 
    mutate(lower = ifelse(lower < 0, 0, lower),
           species = gsub(" ", "\n", species)) %>% 
    ungroup()
  
  for (i in seq(nrow(df))) {if (df$mean[i] == 0) {df$mean[i] <- df$se[i] <- df$upper[i] <- df$lower[i] <- NA}}
  
  df
}

plot_seine_abundance <- function(df, group) {
  
  limits = c(0, 1.1*max(df$upper, na.rm = TRUE))
  
  df %>%
    ggplot(aes_string("species", "mean", fill = group)) + 
    geom_bar(stat = "identity", position = position_dodge(),
             color = "black", size  = 1) + 
    geom_errorbar(aes(ymin = lower, ymax = upper), 
                  width = 0.4, size = 1,
                  position = position_dodge(width = 0.9)) + 
    scale_fill_manual(values = c("grey80", "grey60")) +
    scale_y_continuous(expand = c(0,0), limits = limits) +
    theme_trawls +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_text(size = 12, face = "italic"), 
          axis.ticks.x = element_blank()) + 
    ylab(expression(paste("Density (m"^{-1}, ")")))
}

sum_abundance <- function(df, species, group, reps = 10000) {
  df <- df[, c("Period", "Season", "Year", "Site", species)] %>% 
    gather_("species", "count", gather_cols = species) %>% 
    group_by_(.dots = group, "species") %>% 
    cluster_bootstrap(count, Site, reps) %>% 
    mutate(lower = ifelse(lower < 0, 0, lower),
           species = gsub(" ", "\n", species)) %>% 
    ungroup()
  
  for (i in seq(nrow(df))) {
    if (df$mean[i] == 0) {
      df$mean[i]  = NA
      df$sd[i]    = NA
      df$upper[i] = NA
      df$lower[i] = NA
    }
  }
  
  df
}

plot_abundance <- function(df, group) {
  limits = c(0, 1.1*max(df$upper, na.rm = TRUE))
  
  df %>%
    ggplot(aes_string("species", "mean", fill = group)) + 
    geom_bar(stat = "identity", position = position_dodge(),
             color = "black", size  = 1) + 
    geom_errorbar(aes(ymin = lower, ymax = upper), 
                  width = 0.4, size = 1,
                  position = position_dodge(width = 0.9)) + 
    scale_fill_manual(values = c("grey80", "grey50")) +
    scale_y_continuous(expand = c(0,0), limits = limits) +
    theme_trawls +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_text(face = "italic"), 
          axis.ticks.x = element_blank()) + 
    ylab("Abundance (Count/Trawl)")
}