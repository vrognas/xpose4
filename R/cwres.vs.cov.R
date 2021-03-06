# Xpose 4
# An R-based population pharmacokinetic/
# pharmacodynamic model building aid for NONMEM.
# Copyright (C) 1998-2004 E. Niclas Jonsson and Mats Karlsson.
# Copyright (C) 2005-2008 Andrew C. Hooker, Justin J. Wilkins, 
# Mats O. Karlsson and E. Niclas Jonsson.
# Copyright (C) 2009-2010 Andrew C. Hooker, Mats O. Karlsson and 
# E. Niclas Jonsson.

# This file is a part of Xpose 4.
# Xpose 4 is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program.  A copy can be cound in the R installation
# directory under \share\licenses. If not, see http://www.gnu.org/licenses/.



#' Conditional Weighted residuals (CWRES) plotted against covariates, for Xpose
#' 4
#' 
#' This creates a stack of plots of conditional weighted residuals (CWRES)
#' plotted against covariates, and is a specific function in Xpose 4. It is a
#' wrapper encapsulating arguments to the \code{xpose.plot.default} and
#' \code{xpose.plot.histogram} functions. Most of the options take their
#' default values from xpose.data object but may be overridden by supplying
#' them as arguments.
#' 
#' Each of the covariates in the Xpose data object, as specified in
#' \code{object@Prefs@Xvardef$Covariates}, is evaluated in turn, creating a
#' stack of plots.
#' 
#' Conditional weighted residuals (CWRES) require some extra steps to
#' calculate. See \code{\link{compute.cwres}} for details.
#' 
#' A wide array of extra options controlling xyplots and histograms are
#' available. See \code{\link{xpose.plot.default}} and
#' \code{\link{xpose.plot.histogram}} for details.
#' 
#' @param object An xpose.data object.
#' @param ylb A string giving the label for the y-axis. \code{NULL} if none.
#' @param smooth A \code{NULL} value indicates that no superposed line should
#' be added to the graph. If \code{TRUE} then a smooth of the data will be
#' superimposed.
#' @param type 1-character string giving the type of plot desired.  The
#' following values are possible, for details, see 'plot': '"p"' for points,
#' '"l"' for lines, '"o"' for over-plotted points and lines, '"b"', '"c"') for
#' (empty if '"c"') points joined by lines, '"s"' and '"S"' for stair steps and
#' '"h"' for histogram-like vertical lines.  Finally, '"n"' does not produce
#' any points or lines.
#' @param main The title of the plot.  If \code{"Default"} then a default title
#' is plotted. Otherwise the value should be a string like \code{"my title"} or
#' \code{NULL} for no plot title.  
#' @param \dots Other arguments passed to \code{link{xpose.plot.default}} or
#' \code{link{xpose.plot.histogram}}.
#' @return Returns a stack of xyplots and histograms of CWRES versus
#' covariates.
#' @author E. Niclas Jonsson, Mats Karlsson, Andrew Hooker & Justin Wilkins
#' @seealso \code{\link{xpose.plot.default}},
#' \code{\link{xpose.plot.histogram}}, \code{\link[lattice]{xyplot}},
#' \code{\link[lattice]{histogram}}, \code{\link{xpose.prefs-class}},
#' \code{\link{compute.cwres}}, \code{\link{xpose.data-class}}
#' @keywords methods
#' @examples
#' ## Here we load the example xpose database 
#' xpdb <- simpraz.xpdb
#' 
#' cwres.vs.cov(xpdb)
#' 
#' @export cwres.vs.cov
#' @family specific functions 

cwres.vs.cov <-
  function(object,
           #xlb  = NULL,
           ylb  = "CWRES",
           #onlyfirst=FALSE,
           #inclZeroWRES=FALSE,
           #subset=xsubset(object),
           # abline=c(0,1),
           smooth=TRUE,
           #abllwd=2,
           type="p",
           #mirror=FALSE,
           #seed  = NULL,
           #prompt = TRUE,
           main="Default",
           ...) {
    
    ## check for arguments in function
    if(is.null(check.vars(c("covariates","cwres"),
                          object,silent=FALSE))) {
      return()
    }
    
    ## create list for plots
    number.of.plots <- 0
    for (i in xvardef("covariates", object)) {
      number.of.plots <- number.of.plots + 1
    }
    plotList <- vector("list",number.of.plots)
    plot.num <- 0 # initialize plot number
    
    ## loop (covs)
    for (j in xvardef("covariates", object)) {
      
      xplot <- xpose.plot.default(j,
                                  xvardef("cwres",object),
                                  object,
                                  main=NULL,
                                  #xlb = xlb,
                                  ylb = ylb,
                                  #abline=abline,
                                  #abllwd=abllwd,
                                  smooth=smooth,
                                  type=type,
                                  #subset=subset,
                                  pass.plot.list=TRUE,
                                  ...)
      plot.num <- plot.num+1
      plotList[[plot.num]] <- xplot
    }
    
    
    default.plot.title <- paste(xlabel(xvardef("cwres",object),object),
                                " vs ",
                                "Covariates",
                                sep="")
    plotTitle <- xpose.multiple.plot.title(object=object,
                                           plot.text = default.plot.title,
                                           main=main,
                                           ...)
    obj <- xpose.multiple.plot(plotList,plotTitle,...)
    return(obj)
    
  }

