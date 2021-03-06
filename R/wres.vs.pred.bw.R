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

## Added by Justin Wilkins
## 20/10/2005



#' Box-and-whisker plot of weighted residuals vs population predictions for
#' Xpose 4
#' 
#' This creates a box and whisker plot of weighted residuals (WRES) vs
#' population predictions (PRED), and is a specific function in Xpose 4.  It is
#' a wrapper encapsulating arguments to the \code{xpose.plot.bw} function. Most
#' of the options take their default values from xpose.data object but may be
#' overridden by supplying them as arguments.
#' 
#' This creates a box and whisker plot of weighted residuals (WRES) vs
#' population predictions (PRED), and is a specific function in Xpose 4.  It is
#' a wrapper encapsulating arguments to the \code{xpose.plot.bw} function. Most
#' of the options take their default values from xpose.data object but may be
#' overridden by supplying them as arguments.
#' 
#' A wide array of extra options controlling bwplots are available. See
#' \code{\link{xpose.plot.bw}} and \code{\link{xpose.panel.bw}} for details.
#' 
#' @param object An xpose.data object.
#' @param \dots Other arguments passed to \code{link{xpose.plot.bw}}.
#' @return Returns a box-and-whisker plot of WRES vs PRED.
#' @author E. Niclas Jonsson, Mats Karlsson, Andrew Hooker & Justin Wilkins
#' @seealso \code{\link{xpose.plot.bw}}, \code{\link{xpose.panel.bw}},
#' \code{\link[lattice]{bwplot}}, \code{\link{xpose.prefs-class}},
#' \code{\link{xpose.data-class}}
#' @keywords methods
#' @examples
#' ## Here we load the example xpose database 
#' xpdb <- simpraz.xpdb
#' 
#' wres.vs.pred.bw(xpdb)
#' 
#' 
#' @export wres.vs.pred.bw
#' @family specific functions 
"wres.vs.pred.bw" <-
  function(object,
           #main = NULL,
           #xlb  = NULL,
           #ylb  = NULL,
           #onlyfirst=FALSE,
           #inclZeroWRES=FALSE,
           #subset=xsubset(object),
           #mirror=FALSE,
           #seed  = NULL,
           #bins  = 10,
           #samp  = NULL,
           ...) {

    ## check for arguments in function
    if(is.null(check.vars(c("wres","pred"),
                          object,silent=FALSE))) {      
      return()
    }
    xplot <- xpose.plot.bw(xvardef("wres",object),
                           xvardef("pred",object),
                           #xlb = xlb,
                           #ylb = ylb,
                                        #scales=list(cex=0.5,tck=0.5),
                           #aspect="fill",
                                  object,#main=list(main,cex=0.7),
                           #main = main,
                           #bins=bins,
                           #ids=FALSE,
                           binvar = xvardef("idv",object),
                                        #xvar = xvardef("wres",object),
                           #subset=subset,
                           ...)


      return(xplot)
    }
