# **slagCASS**

This package is a suite of statistical analyses and visualizations for user-input compositional data. It was developed for evaluating chemical relationships between iron slag samples based on the methodologies outlined in Stetkiewicz (2016). The current version of slagCASS integrates D3 functionality for Principal Componenet Analysis (PCA), and future iterations will continue to incorporate further JavaScript modification.

Heirarchical Cluster Analysis (HCA) is done using `dendextend`, and PCA is performed using the "robpca" function from `rospca`, which is based on the robust PCA model proposed by [Hubert et al](http://dx.doi.org/10.1198/004017004000000563) in `pcaHubert`.

## Setup

You'll need to convert your spreadsheet into .CSV format before uploading it.
* Data will be imported as-is, so each column and row should have a logical title to make analysis and organization easier. 
* For optimal usage, make sure the oxide names of your dataframe are capitalized (i.e. 'FeO', 'SiO2', etc.) - some of the analyses have presets that use these titles. 
* If you intend to use the PCA or Correlation Matrix functions, you will need to remove any string vectors prior to those analyses. This can be done in the Modified Data tab.

**Please note:**

Dendrogram branch coloring based on *k*-means clustering in not possible yet for centroid and median methods.

## Acknowledgments

Like all open-source programs, this package builds off several existing codes and credit goes to each respective `r` package developer. In particular, [SparseData's Clustering package](https://github.com/sparsedata/cluster-analysis) was immensely helpful in developing this interface, and [Julien Barnier's](https://github.com/juba) excellent `scatterD3` package has enabled much of the interactivity for this package.

## Citation

If you've found this package useful, please cite it in your research as follows:

<span style="font-variant:small-caps;">Stetkiewicz, S.</span>, (2017). Slag Compositional Analysis & Statistics Suite (slagCASS). https://github.com/ScottStetkiewicz/CASS

## References:

<span style="font-variant:small-caps;">Stetkiewicz, S.</span>, (2016). *Iron Age Iron Production in Britain and the Near Continent: Compositional Analyses and Smelting "Systems"*. Unpublished PhD Thesis, University of Edinburgh.
