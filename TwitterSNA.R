#install.packages("igraph")
#install.packages("network") 
#install.packages("sna")
#install.packages("ndtv")
# OWN MAIN REF --- 
# https://rstudio-pubs-static.s3.amazonaws.com/107167_28714fdd899a475cb6d07c1c31502a10.html
#
#
nodes <- read.csv("C:/____DSI/05_MAY_/Amazon_Ankita_SNA/NodesNJ.csv", header=T, as.is=T)
#edges <- read.csv("C:/____DSI/05_MAY_/Amazon_Ankita_SNA/DEMO_EDGE.csv", header=T, as.is=T)
edges <- read.csv("C:/____DSI/05_MAY_/Amazon_Ankita_SNA/SNA_NJ22JULY.csv", header=T, as.is=T)
#
head(nodes)
tail(nodes)
head(edges)
tail(edges)
nrow(nodes); length(unique(nodes$Name))
nrow(edges); nrow(unique(edges[,c("from", "to")]))
#
library(igraph)

net <- graph.data.frame(edges, nodes, directed=T)
net

# Error --- Error in graph.data.frame(edges, nodes, directed = T) : 
# Error ---  Some vertex names in edge list are not listed in vertex data frame
#
# https://github.com/nicolewhite/neo4j-alchemy-cluster/issues/2
#
plot(net)
#
net <- simplify(net, remove.multiple = F, remove.loops = T)
plot(net)
#
plot(net, edge.arrow.size=.09)
#
#install.packages("extrafont")
#library(extrafont)

# Import system fonts - may take a while, so DO NOT run this during the workshop.
#font_import() 
#fonts() # See what font families are available to you now.
#loadfonts(device = "win") # use device = "pdf" for pdf plot output.
#
plot(net, vertex.size=20,edge.arrow.size=.09,edge.curved=.1)
#
# Vertex Colors basis Tenure:
## # # # # # # # # #  # # # # # # # # # # # # # # # # # # #  
#
# FAIL -- colrs<- c("tomato", "gold","gray50")
# FAIL -- V(net)$color <- colrs[V(net)$Tenure]
#
# FAIL -- colrs<- c("tomato", "gold","gray50", "blue")
# FAIL -- V(net)$color <- colrs[V(net)$Tenure]
#
# Warning message:
#   In vattrs[[name]][index] <- value :
#   number of items to replace is not a multiple of replacement length
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#
# Compute node degrees (#links) and  use that to set node size: : OK 
# Seems this is OutDegree --- How Many Edges Going out of a NODE
#
deg <- degree(net, mode="all")
deg
V(net)$size <- deg/2
#
# Vertex size with - Intr_Count : OK 
V(net)$size <- V(net)$Intr_Count
#
plot(net,edge.arrow.size=.09,edge.curved=.1)
#
# Vertex size with - Tot_Wt: OK 
V(net)$size <- V(net)$Tot_Wt/3
#
plot(net,edge.arrow.size=.09,edge.curved=.1)
#
#
# Set edge width based on weight: OK 
#
E(net)$width <- E(net)$weight/2
#
V(net)$color <- "tomato"
E(net)$edge.color <- "gray80"
E(net)$width <- 1+E(net)$weight/6
plot(net,edge.arrow.size=.05,edge.curved=.1)
#
# TBD -- Need to remove all ZERO Values from Weight -- E(net)$weight <- E(net)$weight[!0]
#
#

plot(net, vertex.size=20,edge.arrow.size=.09,edge.curved=.1)
