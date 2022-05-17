
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rhud <img src='man/figures/logo.png' align="right" width="139"/>

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R-CMD-check](https://github.com/etam4260/rhud/workflows/R-CMD-check/badge.svg)](https://github.com/etam4260/rhud/actions)
[![Codecov test
coverage](https://codecov.io/gh/etam4260/rhud/branch/main/graph/badge.svg)](https://codecov.io/gh/etam4260/rhud?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/etam4260/rhud/badge/main)](https://www.codefactor.io/repository/github/etam4260/rhud/overview/main)
[![Status at rOpenSci Software Peer
Review](https://badges.ropensci.org/524_status.svg)](https://github.com/ropensci/software-review/issues/524)
<br/> <br/> [![devel
version](https://img.shields.io/badge/devel%20version-0.2.0.9000-yellow)]()

<!-- badges: end -->

## Housing and Urban Development in R

-   This interface uses the HUD User Data API but is not endorsed or
    certified by HUD User.

The goal of this project is to provide an easy-to-use interface to
access various open-source APIs provided by the U.S Housing and Urban
Development. These include the USPS Crosswalk Files, Fair Markets Rent,
Income Limits, and Comprehensive Housing and Affordability Strategy.
Although HUD does provide datasets for other programs, they are
currently not supported by an API.

Please read
<https://www.huduser.gov/portal/dataset/api-terms-of-service.html> for
all terms of service.

According to HUD USER:

All services, which utilize or access the API, should display the
following notice prominently within the application: “This product uses
the HUD User Data API but is not endorsed or certified by HUD User.” You
may use the HUD User name in order to identify the source of API content
subject to these rules. You may not use the HUD User name, or the like
to imply endorsement of any product, service, or entity, not-for-profit,
commercial or otherwise.

## HUD User: <https://www.huduser.gov/portal/datasets>

According to (HUD User Home Page \| HUD USER), HUD User is a U.S.
Department of Housing and Urban Development information source that
includes reports and reference documents. HUD USER was founded in 1978
by the Department of Housing and Urban Development’s Office of Policy
Development and Research.

HUD User maintains an API to gain access to their data. However, their
API system can be confusing and provides their information in JSON
format rather than a data-frame like object. Although there exist file
downloadables, R users may want to be able to extract specific bits of
the data into memory.

## Citation

Please cite this package using:

Tam, E., Reilly, A., & Ghaedi, H. (2022). rhud: A R interface for
accessing HUD  
      (US Department of Housing and Urban Development) APIs (Version
0.2.0.9000). <https://github.com/etam4260/rhud>

## Available Data

The APIs and datasets which this library interfaces are listed below.
The HUD also provide miscellaneous supplemental APIs under them.

1.  HUD User

    -   USPS Crosswalk
        (<https://www.huduser.gov/portal/dataset/uspszip-api.html>)
    -   Fair Markets Rent
        (<https://www.huduser.gov/portal/dataset/fmr-api.html>)
        -   Small Areas Fair Markets Rent
        -   List States
        -   List Small Areas
    -   Income Limits
        (<https://www.huduser.gov/portal/dataset/fmr-api.html>)
    -   Comprehensive Housing and Affordability Strategy
        (<https://www.huduser.gov/portal/dataset/chas-api.html>)
        -   List Counties in State
        -   List MCDs in State
        -   List All Cities in State

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etam4260/rhud")
```

For more details on how to setup and utilize this package. Please go to
<https://etam4260.github.io/rhud/>. Select \[Setup\] in the navigation
bar.

## Contributors

-   Emmet Tam(<https://github.com/etam4260>)\[<emmet_tam@yahoo.com>\]
-   Allison Reilly()\[<areilly2@umd.edu>\]
-   Hamed Ghaedi()\[<hghaedi@terpmail.umd.edu>\]

## Disclaimers

-   License: GPL >= 2

-   To get citation information for rhud in R, type citation(package =
    ‘rhud’)

-   This interface uses the HUD User Data API but is not endorsed or
    certified by HUD User.

-   The limit on the maximum number of API calls is 1200 queries a min.
    Each function call does not correspond to a single API call!

-   This is a WIP so please report any issues or bugs to:
    <https://github.com/etam4260/rhud/issues>

-   This is open source, so please fork and introduce some pull
    requests!

## References

HUD User Home Page: HUD USER. HUD User Home Page \| HUD USER. (n.d.).
Retrieved  
        February 24, 2022, from
<https://www.huduser.gov/portal/home.html>
