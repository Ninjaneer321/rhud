#' @name %z_in_trt%
#' @title Zip Addresses in Tract Addresses?
#' @description To use this function, the HUD_KEY system environment variable
#'   must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given zip code(s) and tract(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even though their boundaries intersect the queried geoids(rhs). This is
#'   likely because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter parameter
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with tract(s)
#' @param tract The tract(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the tract(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 71052 %z_in_trt% 22031950600
#'
#' }
`%z_in_trt%` <- function(zip, tract) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  # These results will get cached, but might want to make it save to
  # pkg environment and not depend on automated caching.
  args <- hud_rec_cw_yr()

  # Need to validate tract..
  cleaned <- cw_input_check_cleansing(primary_geoid = "tract",
                                      secondary_geoid = "zip",
                                      query = tract, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  tract <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(tract) != 11)) {
    stop("\nInputted tract(s) are not all of length 11.", call. = FALSE)
  }

  res <- c()

  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_tract,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(tract))) {
      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}



#' @name %z_in_cty%
#' @title Zip Addresses in County Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given zip code(s) and county(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with county(s)
#' @param county The county(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the county(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 71052 %z_in_cty% 22031
#'
#' }
`%z_in_cty%` <- function(zip, county) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "county",
                                      secondary_geoid = "zip",
                                      query = county, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  county <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(county) != 5)) {
    stop("\nInputted county(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_county,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                  )

    if (any(queried %in% as.character(county))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %z_in_cbsa%
#' @title  Zip Addresses in CBSA Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given a zip code(s) and a cbsa(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with cbsa(s)
#' @param cbsa The cbsa(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the cbsa(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 71052 %z_in_cbsa% 43340
#'
#' }
`%z_in_cbsa%` <- function(zip, cbsa) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }


  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "cbsa",
                                      secondary_geoid = "zip",
                                      query = cbsa, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  cbsa <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key


  if (any(nchar(cbsa) != 5)) {
    stop("\nInputted cbsa(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_cbsa,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(cbsa))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %z_in_cbsadiv%
#' @title  Zip Addresses in CBSAdiv Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given zip code(s) and cbsadiv(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with cbsadiv(s)
#' @param cbsadiv The cbsadiv(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the cbsadiv(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' "03884" %z_in_cbsadiv% 40484
#'
#' }
`%z_in_cbsadiv%` <- function(zip, cbsadiv) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "cbsadiv",
                                      secondary_geoid = "zip",
                                      query = cbsadiv, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  cbsadiv <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(cbsadiv) != 5)) {
    stop("\nInputted cbsadiv(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_cbsadiv,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(cbsadiv))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %z_in_ctysb%
#' @title Zip Addresses in Countysub Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given zip code(s) and a countysub(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with countysub(s)
#' @param countysub The countysub(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the countysub(s) specified, then TRUE is
#'   returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 71052 %z_in_ctysb% 2203194756
#'
#' }
`%z_in_ctysb%` <- function(zip, countysub) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }


  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "countysub",
                                      secondary_geoid = "zip",
                                      query = countysub, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  countysub <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(countysub) != 10)) {
    stop("\nInputted countysub(s) are not all of length 10.", call. = FALSE)
  }


  res <- c()
  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_countysub,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(countysub))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %z_in_cd%
#' @title Zip Addresses in Congressional District Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given zip code(s) and congressional district(s), determine if
#'   they overlap using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param zip The zip(s) to determine overlap with a congressional district(s)
#' @param cd The congressional district(s) to determine overlap with zip(s)
#' @returns If zip(s) exist in the cd(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 71052 %z_in_cd% 2204
#'
#' }
`%z_in_cd%` <- function(zip, cd) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "cd",
                                      secondary_geoid = "zip",
                                      query = cd, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  cd <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(cd) != 4)) {
    stop("\nInputted cd(s) are not all of length 4.", call. = FALSE)
  }


  res <- c()
  for (i in seq_len(length(zip))) {

    queried <- geo_is_infix_query_and_get_warnings(query = zip[i],
                                                   f = hud_cw_zip_cd,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "zip",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(cd))) {

      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}






#' @name %trt_in_z%
#' @title Tract Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given tract(s) and zip code(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param tract The tract(s) to determine overlap with zip(s)
#' @param zip The zip(s) to determine overlap with tract(s)
#' @returns If tract(s) exist in the zip(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 22031950600 %trt_in_z% 71052
#'
#' }
`%trt_in_z%` <- function(tract, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "tract",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(tract))) {

    queried <- geo_is_infix_query_and_get_warnings(query = tract[i],
                                                   f = hud_cw_tract_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "tract",
                                                   key = key
                                                   )


    if (any(queried %in% as.character(zip))) {
      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}



#' @name %cty_in_z%
#' @title County Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given county(s) and zip(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param county The county(s) to determine overlap with zip(s).
#' @param zip The zip(s) to determine overlap with county(s).
#' @returns If county(s) exist in the zip(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 22031 %cty_in_z% 71052
#'
#' }
`%cty_in_z%` <- function(county, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()


  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "county",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(county))) {

    queried <- geo_is_infix_query_and_get_warnings(query = county[i],
                                                   f = hud_cw_county_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "county",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(zip))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}



#' @name %cbsa_in_z%
#' @title CBSA Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given cbsa(s) and zip(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param cbsa The cbsa(s) to determine overlap with zip(s).
#' @param zip The zip(s) to determine overlap with cbsa(s).
#' @returns If cbsa(s) exist in the zip(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 43340 %cbsa_in_z% 71052
#'
#' }
`%cbsa_in_z%` <- function(cbsa, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()


  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "cbsa",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(cbsa))) {

    queried <- geo_is_infix_query_and_get_warnings(query = cbsa[i],
                                                   f = hud_cw_cbsa_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "cbsa",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(zip))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %cbsadiv_in_z%
#' @title CBSAdiv Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given cbsadiv(s) and zip(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param cbsadiv The cbsadiv(s) to determine overlap with zip(s).
#' @param zip The zip(s) to determine overlap with cbsadiv(s).
#' @returns If cbsadiv(s) exist in the zip(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' "03884" %z_in_cbsadiv% 40484
#'
#' }
`%cbsadiv_in_z%` <- function(cbsadiv, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }


  args <- hud_rec_cw_yr()

  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "cbsadiv",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key

  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(cbsadiv))) {

    queried <- geo_is_infix_query_and_get_warnings(query = cbsadiv[i],
                                                   f = hud_cw_cbsadiv_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "cbsadiv",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(zip))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}


#' @name %cd_in_z%
#' @title Congressional District Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given congressional district(s) and a zip(s), determine if they
#'   overlap using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param cd The cd(s) to determine overlap with zip(s).
#' @param zip The zip(s). to determine overlap with cd(s).
#' @returns If cd(s) exist in the zip(s) specified, then TRUE is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 2204 %cd_in_z% 71052
#'
#' }
`%cd_in_z%` <- function(cd, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()


  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "cd",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key


  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(cd))) {

    queried <- geo_is_infix_query_and_get_warnings(query = cd[i],
                                                   f = hud_cw_cd_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "cd",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(zip))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}



#' @name %ctysb_in_z%
#' @title Countysub Addresses in Zip Addresses?
#' @description To use this function, the HUD_KEY system environment
#'   variable must be set first: use hud_set_key("the_key") to do this.
#'
#'   Given countysub(s) and zip(s), determine if they overlap
#'   using the crosswalk files. Overlap will be described if
#'   any residential, business, other, or total addresses reside in both.
#'
#'   This means that it is possible that certain geoids(lhs) are not counted
#'   even
#'   though their boundaries intersect the queried geoids(rhs). This is likely
#'   because addresses do not lie in their intersecting region.
#'
#'   Infix operators default to most recent year and quarter of which the
#'   crosswalk files are available. For modifying the year and quarter
#'   parameter,
#'   take a look at their non-infix versions.
#'
#' @param countysub The countysub(s) to determine overlap with zip(s).
#' @param zip The zip(s). to determine overlap with countysub(s).
#' @returns If countysub(s) exist in the zip(s) specified, then TRUE
#'   is returned.
#' @export
#' @examples
#' \dontrun{
#'
#' 2203194756 %ctysb_in_z% 71052
#'
#' }
`%ctysb_in_z%` <- function(countysub, zip) {

  if (Sys.getenv("HUD_KEY") == "") {
    stop(paste("Make sure to set the HUD_KEY environment",
               "variable before rhud using infix operators."))
  }

  args <- hud_rec_cw_yr()


  cleaned <- cw_input_check_cleansing(primary_geoid = "zip",
                                      secondary_geoid = "countysub",
                                      query = zip, year = args$year,
                                      quarter = args$quarter,
                                      Sys.getenv("HUD_KEY"))

  zip <- cleaned$query
  year <- cleaned$year
  quarter <- cleaned$quarter
  key <- cleaned$key


  if (any(nchar(zip) != 5)) {
    stop("\nInputted zip(s) are not all of length 5.", call. = FALSE)
  }

  res <- c()
  for (i in seq_len(length(countysub))) {

    queried <- geo_is_infix_query_and_get_warnings(query = countysub[i],
                                                   f = hud_cw_countysub_zip,
                                                   year = year,
                                                   quarter = quarter,
                                                   querytype = "countysub",
                                                   key = key
                                                   )

    if (any(queried %in% as.character(zip))) {


      res <- c(res, TRUE)
    } else {
      res <- c(res, FALSE)
    }
  }

  res
}



#' @name geo_is_infix_query_and_get_warnings
#' @title US Geographic Identifier in US Geographic Identifier Query and Warn
#' @description Giving a geoid to query for, make sure to call the core
#'   hud_cw() functions to get the crosswalk output
#'   but intercept it to make custom warning messages.
#' @param query The geoids to query for crosswalk
#' @param f The function used query the crosswalk files.
#' @param year The year to query for.
#' @param quarter The quarter to query for.
#' @param querytype The geoid user is querying for.
#' @param key The HUD USER API Key.
#'    1) zip
#'    2) tract
#'    3) cbsa
#'    4) cd
#'    5) cbsadiv
#'    6) countsub
#'    7) county
#' @noRd
#' @noMd
geo_is_infix_query_and_get_warnings <- function(query,
                                                f,
                                                year,
                                                quarter,
                                                querytype,
                                                key
                                                ) {

  res <- c()
  tryCatch({

      res <- suppressMessages(f(query,
               minimal = TRUE,
               year = year,
               quarter = quarter,
               key = key
               ))
    },
    error = function(cond) {
      stop(cond$message, call. = FALSE)
    },
    warning = function(cond) {
      # Might be more efficient to save the errored geoids when used instead
      # of having to regex it...
      warning(paste("\nThe ", querytype, " ", query, " inputted is not valid.",
                    " No data was found for year: ", year, " and quarter: ",
                    quarter,
                    sep = ""
              ), call. = FALSE)
    }
  )
  res
}
