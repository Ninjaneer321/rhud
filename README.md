
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hudr

<!-- badges: start -->

[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R-CMD-check](https://github.com/etam4260/hudr/workflows/R-CMD-check/badge.svg)](https://github.com/etam4260/hudr/actions)
[![Codecov test
coverage](https://codecov.io/gh/etam4260/hudr/branch/main/graph/badge.svg)](https://codecov.io/gh/etam4260/hudr?branch=main)
[![cran
version](https://www.r-pkg.org/badges/version/hudr)](https://cran.r-project.org/package=hudr)
[![cran
checks](https://cranchecks.info/badges/worst/hudr)](https://cranchecks.info/pkgs/hudr)
[![rstudio mirror
downloads](https://cranlogs.r-pkg.org/badges/hudr?color=C9A115)](https://github.com/r-hub/cranlogs.app)
<!-- badges: end -->

<img src="https://github.com/etam4260/hudr/blob/main/man/figures/HUD.jpg?raw=true" width="1250" height="200"/>

This package contains an interface to the US Department of Housing and
Urban Development datasets within R. The goal of this project is to
provide an easy to use interface to access various open source APIs
provided by HUD.

HUD has two main websites for gaining access to various different
datasets: HUD User and Exchange.

HUD User: <https://www.huduser.gov/portal/datasets> HUD Exchange:
<https://www.hudexchange.info/programs/drgr/>

“HUD User is an information source containing reports and reference
documents for the U.S. Department of Housing and Urban Development. HUD
USER was established by the HUD’s Office of Policy Development and
Research in 1978.”

HUD User maintains an API to gain access to their data. However, their
API system can be rather confusing and provides their information in
JSON format rather than a dataframe like object. Although there exist
file downloadables, R users may want to be able to extract specific bits
of the data into memory.

“The Department of Housing and Urban Development has a website known as
HUD Exchange which is a comprehensive online platform that provides
tools, resources, and contact information for the organizations and
individuals that partner with HUD. These often include nonprofit groups
and state and municipal governments, but also include borrowers,
lenders, and brokers involved in HUD’s multifamily loan programs”

The DRGR Disaster Recovery Grant Reporting System which HUD Exchange
uses to supply public data does not have an active API for retrieving
information. However, there does exist datasets freely available online
which can be directly downloadable into R. This package provides the
ability to directly get such data.

## Available Data

The APIs and datasets which this library interfaces with:

1.  HUD User

    API Based:

    -   Crosswalk
    -   Fair Markets Rent
    -   Income Limits
    -   Comprehensive Housing and Affordability Strategy

    File Based:

    -   Neighborhood Stabilization Program
    -   Low-Income Housing Tax Credit
    -   Annual Adjustment Factors (AAFs)
    -   Difficult Development Areas (DDA)
    -   Homeowner Assistance Fund (HAF) Income Limits
    -   50th percentile (or median)
    -   Housing Affordability Data System (HADS)
    -   Components of Inventory Change (CINCH) report
    -   Point-In-Time (PIT) count
    -   Housing Inventory Count (HIC)
    -   HOME Investment Partnerships Program (HOME) and Housing Trust
    -   Fund (HTF) Homeownership Value Limits
    -   Multifamily Tax Subsidy Projects (MTSP) Income Limits
    -   Utility Allowance Factors (UAFs)
    -   Renewal Funding Inflation Factors
    -   Small Area Fair Market Rents (SAFMRs)
    -   Assisted Housing: Local and Global

2.  HUD Exchange

    -   Community Development Block Grant - Disaster Recovery

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etam4260/hudr")
```

For more details on how to setup and utilize this package. Please go to
<https://etam4260.github.io/hudr/>. Select ‘Setup’ in the navigation
bar.

## Contributors

-   Emmet Tam(<https://github.com/etam4260>)

## Disclaimers

-   License: MIT
-   To get citation information for hudr in R, type citation(package =
    ‘hudr’)
-   This interface uses the HUD User Data API but is not endorsed or
    certified by HUD User.
-   The limit on the maximum number of API calls is 1200 queries a min.
-   This is a WIP so please report any issues or bugs to:
    <https://github.com/etam4260/hudr/issues>
-   This is open source, so please fork and introduce some pull
    requests!
