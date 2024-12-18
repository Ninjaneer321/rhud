% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hud_decomp_crosswalk.R
\name{hud_cw_zip_countysub}
\alias{hud_cw_zip_countysub}
\title{Crosswalk Zip to Countysub}
\usage{
hud_cw_zip_countysub(
  zip,
  year = format(Sys.Date() - 365, "\%Y"),
  quarter = 1,
  minimal = FALSE,
  key = Sys.getenv("HUD_KEY"),
  to_tibble = getOption("rhud_use_tibble", FALSE)
)
}
\arguments{
\item{zip}{A character or numeric vector: 5 digit
(United States Postal Service) USPS zipcode
of the data to retrieve. E.g. 22031 for type
1 to 5 and 11 .}

\item{year}{A character or numeric vector: gets the year that this data
was recorded. Can specify multiple
years. Default is the previous year.}

\item{quarter}{A character or numeric vector: gets the quarter of the year
that this data was recorded.
Defaults to the first quarter of the year.}

\item{minimal}{A logical: return just the crosswalked geoids if TRUE.
Otherwise, return
all fields. This does not remove duplicates.}

\item{key}{A character vector of length one with the key obtained from HUD
(US Department of Housing and Urban Development)
USER website.}

\item{to_tibble}{A logical: if TRUE, return the data in a tibble format
rather than a data frame.}
}
\value{
This function returns a dataframe containing crosswalk data for
zip to countysub for all combinations of "zip", "year", and "quarter"
inputs.

These measurements include res-ratio, bus-ratio,
oth-ratio, tot-ratio. For more details on these measurements, visit
https://www.huduser.gov/portal/dataset/uspszip-api.html
}
\description{
This function queries the USPS Crosswalks API provided by US
Department of Housing and Urban Development (HUD USER).
This returns the crosswalk for
zip to countysub.
}
\examples{
\dontrun{

hud_cw_zip_countysub(zip = 35213, year = c('2019'), quarter = c('2'))

hud_cw_zip_countysub(zip = '35213', year = c('2019'), quarter = c('2'),
   minimal = TRUE)
}
}
\keyword{*}
\keyword{API}
\keyword{Crosswalks}
\keyword{[rhud::hud_cw()]}
\keyword{[rhud::hud_cw_cbsa_zip()]}
\keyword{[rhud::hud_cw_cbsadiv_zip()]}
\keyword{[rhud::hud_cw_cd_zip()]}
\keyword{[rhud::hud_cw_county_zip()]}
\keyword{[rhud::hud_cw_countysub_zip()]}
\keyword{[rhud::hud_cw_tract_zip()]}
\keyword{[rhud::hud_cw_zip_cbsa()]}
\keyword{[rhud::hud_cw_zip_cbsadiv()]}
\keyword{[rhud::hud_cw_zip_cd()]}
\keyword{[rhud::hud_cw_zip_county()]}
\keyword{[rhud::hud_cw_zip_countysub()]}
\keyword{[rhud::hud_cw_zip_tract()]}
