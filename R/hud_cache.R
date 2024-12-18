# File adapted from the tigris package:
# https://github.com/walkerke/tigris/blob/master/R/helpers.R

#' @import R.cache

#' @name hud_set_cache_dir
#' @title Set RHUD Cache Directory
#' @description Set the caching directory to store data retrieved using the
#' rhud API calls. By default, rhud uses a non-persistent temporary directory
#' given for an R session. However, it is possible that a user might want
#' to save their queried data in a custom location which is persistent.
#' This function allows users to set the cache directory. The user can also
#' store the preferred path in the .RProfile so that rhud will remember the set
#' preference directory throughout sessions. Make sure the path is valid and
#' and is not in a sensitive location.
#'
#' Windows users: please note that you'll need to use double-backslashes or
#' forward slashes when specifying your cache directory's path in R.
#'
#' * This will create a folder called rhud_cache in specified path
#'
#' * If setting a new directory, the previous cache will not be cleaned. In
#'   a future update there will be a garbage collection option.
#'
#' @param path A character vector of length one specifying the full path to
#'  the desired cache directory. Only one can be
#'  set at a time. If no path is specified, it will use the temp directory
#'  for R. The temp directory is not persistent.
#' @param in_wkdir A logical to determine if to store the path as environment
#'   variable in the working
#'   directory .Rprofile so rhud will cache to this specified path.
#' @param in_home A logical to determine if to store the path as environment
#'   variable in the HOME directory
#'   .Rprofile so rhud will cache to this specified path.
#' @seealso
#' * [rhud::hud_get_cache_dir()]
#' * [rhud::hud_set_cache_dir()]
#' * [rhud::hud_clear_cache()]
#' @export
hud_set_cache_dir <- function(path,
                              in_wkdir = FALSE,
                              in_home = FALSE
                              ) {

  # Set for the rhud cache path in the current session.

  # TODO: First check for valid path formatting by regex

  if (missing(path)) {
    path <- paste(tempdir(), "//rhud_cache", sep = "")
    message("* Missing path, will set to the working session temp directory.")
  } else {
    path <- paste(path, "//rhud_cache", sep = "")
  }

  if (!is.character(path) || length(path) != 1) {
    stop(paste("Make sure argument key is of type",
               "character and is of vector length 1",
               sep = ""), call. = FALSE)
  }


  if (!is.logical(in_wkdir) ||
     !is.logical(in_home) ||
     length(in_wkdir) != 1  ||
     length(in_home) != 1) {
    stop("Make sure argument in_wkdir and in_home are of type logical.",
         call. = FALSE)
  }

  Sys.setenv("RHUD_CACHE_DIR" = path)
  suppressWarnings(R.cache::setCacheRootPath(path))
  message("* Setting the RHUD_CACHE_DIR variable for the working session.")

  if (in_wkdir) {

    # Set the cache path in the Rprofile working direct. If not made, make
    # one and set.
    if (any(list.files(all.files = TRUE) == ".Rprofile")) {
      # Check the file if it contains a call to set cache path, regex for it.
      rprof <- readLines("./.Rprofile")

      all_occur <- grep("^Sys\\.setenv\\(\"RHUD_CACHE_DIR\" = \".*\"\\)",
                        rprof)

      if (any(all_occur))  {

        message(paste("* It looks like your .RProfile contains another",
                      "definition of the RHUD_CACHE_DIR. ",
                      "Do file.edit(\".Rprofile\") ",
                      "to take a look at it.",
                      sep = ""))

      }

      message("* Writing the RHUD_CACHE_DIR in working directory .Rprofile!\n")
      writeLines(paste(paste(rprof, collapse = "\n"),
                       "\nSys.setenv(\"RHUD_CACHE_DIR\" = \"", path, "\")\n",
                       sep = ""),
                 ".Rprofile")
    } else {
      file.create(".Rprofile")
      writeLines(paste("\nSys.setenv(\"RHUD_CACHE_DIR\" = \"", path, "\")\n",
                       sep = ""),
                 ".Rprofile")

      message("* Writing the RHUD_CACHE_DIR in working directory .Rprofile!\n")
    }

  }


  if (in_home) {
    # Set the cache path in the HOME direct
    # Make system call to get home directory for this user.
    # Make the file here.
    if (any(list.files(file.path(Sys.getenv("HOME")),
                       all.files = TRUE) == ".Rprofile")) {
      # Check the file if it contains a call to cache path, regex for it.

      rprof <- readLines("~/.Rprofile")

      all_occur <- grep("^Sys\\.setenv\\(\"RHUD_CACHE_DIR\" = \".*\"\\)",
                        rprof)


      if (any(all_occur))  {

        message(paste("* It looks like your .RProfile contains another",
                      "definition of RHUD_CACHE_DIR. ",
                      "Do file.edit(\".Rprofile\") ",
                      "to take a look at it.",
                      sep = ""))

      }

      message("* Writing the RHUD_CACHE_DIR in HOME directory .Rprofile!")
      writeLines(paste(paste(rprof, collapse = "\n"),
                       "\nSys.setenv(\"RHUD_CACHE_DIR\" = \"", path, "\")\n",
                       sep = ""),
                 "~/.Rprofile")
    } else {
      file.create("~/.Rprofile")
      writeLines(paste("\nSys.setenv(\"RHUD_CACHE_DIR\" = \"", path, "\")\n",
                       sep = ""),
                 "~/.Rprofile")
      message("* Writing the RHUD_CACHE_DIR in HOME directory .Rprofile!")
    }
  }
}



#' @name hud_get_cache_dir
#' @title Get RHUD Cache Directory
#' @description Get the path rhud is using to store cached files.
#' @returns A character vector with path to cached files. If none is set,
#'   will default to R temp session directory
#' @export
#' @seealso
#' * [rhud::hud_get_cache_dir()]
#' * [rhud::hud_set_cache_dir()]
#' * [rhud::hud_clear_cache()]
#' @returns A character vector stores in the RHUD_CACHE_DIR system environment
#'   variable.
#' @examples
#' \dontrun{
#' hud_get_cache_dir()
#'
#' }
hud_get_cache_dir <- function() {
  Sys.getenv("RHUD_CACHE_DIR")
}


#' @name hud_clear_cache
#' @title Clear RHUD Cache Directory
#' @description Remove cached data from the caching directory that is used to
#' store data retrieved using the rhud API calls. By default, rhud uses a
#' non-persistent temporary directory given for an R session, but a user might
#' have set another directory to use.
#' @export
#' @seealso
#' * [rhud::hud_get_cache_dir()]
#' * [rhud::hud_set_cache_dir()]
#' * [rhud::hud_clear_cache()]
#' @examples
#' \dontrun{
#'
#' hud_clear_cache()
#'
#' }
hud_clear_cache <- function() {

  if (Sys.getenv("RHUD_CACHE_DIR") == "" ||
      Sys.getenv("RHUD_CACHE_DIR") == "NULL") {
    R.cache::clearCache(paste(tempdir(), "//", "rhud_cache", sep = ""))
  } else {
    R.cache::clearCache(Sys.getenv("RHUD_CACHE_DIR"))
  }
}
