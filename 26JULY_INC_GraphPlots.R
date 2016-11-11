require('igraph')
require('network') 
require('intergraph')

#install.packages('intergraph')
#library('intergraph')
#library(network)


# Creating the First Network from - INFO_All
# Weighted Adjacency Matrix 
# Names input on rows n columns now same 
# 
#dat2=read.csv(file.choose(),header=TRUE,row.names=1,check.names=FALSE) # read .csv file

#INFO<- read.csv("C:/____DSI/05_MAY_/Amazon_Ankita_SNA/INFO_All_2.csv")


#
# IMP -- While Importing data --- row.names=1, stringsAsFactors=FALSE
#
#
M_All<- read.csv("C:/____DSI/05_MAY_/Amazon_Ankita_SNA/Amazon_SNA/AM_McKQuarterly.csv", row.names=1, stringsAsFactors=FALSE)

#PROB_All <- read.csv("C:/Users/Rohit/Desktop/NA_R/ADJP.csv", row.names=1,header=T, as.is=T)
#
# INFO All can be Mentions 
# PROBLEM SOLVING ALL can be Re Tweets 
#
m3=as.matrix(M_All)
#m2=as.matrix(PROB_All)

# Dimensions  - 1:32 , 1:33 IS OK 
#
net=graph.adjacency(m3,mode="directed",weighted=TRUE,diag=FALSE) # Mode="directed" , Diag = FALSE, ignores 0's in Diag - also - Weighted=TRUE
#net1=graph.adjacency(m2,mode="directed",weighted=TRUE,diag=FALSE) # Mode="directed" , Diag = FALSE, ignores 0's in Diag - also - Weighted=TRUE
#net
summary(net)
#summary(net1)
#E(net)$weight
plot(net,edge.arrow.size=.09,edge.curved=.1)
#plot(net1,edge.arrow.size=.09,edge.curved=.1)
#
# Compute node degrees (#links) and use that to set node size: : OK 
#
deg <- igraph::degree(net, mode="all") # Using - igraph::degree , to OverRule SNA Package Degree Func.
deg
#
#deg1 <- igraph::degree(net1, mode="all")
#deg1
#class(net1)
class(net)
#

# example of converting objects between classes 'network' and 'igraph'
# needs packages igraph and network attached
#if( require(network) & require(igraph) )
#{
# convert to class "network"
#gg <- asNetwork(net)
# check if they are the same
# (dropping some attributes)
#all.equal( get.edgelist(net),
#           structure(as.matrix(gg, "edgelist"), n=NULL, vnames=NULL))
#netcompare(net, gg)
#}


# Set edge color based on:  Which Source Vertex - the Edge Starts from. 
#edge.start <- get.edges(gg, 1:ecount(gg))[,1]
#edge.start <- get.edges(net, 1:ecount(net))[,1]
#edge.start1 <- get.edges(net1, 1:ecount(net1))[,1]
# edge.start
#edge.col <- V(net)$color[edge.start]
#edge.col1 <- V(net1)$color[edge.start]
#
# # E is for EDGE Parameters 
# Set edge Width and Color based on weight: OK 
# 
E(net)$width <- E(net)$weight/10
plot(net,edge.arrow.size=.09,edge.curved=.1)

#E(net1)$width <- E(net1)$weight/2

#E(net)$color <- E(net)$weight/2 # OK - this is EDGE COlor Option 1 
#E(net)$color <- edge.col # OK - this is EDGE COlor Option 2
#E(net1)$color <- edge.col1 # OK - this is EDGE COlor Option 2
#
V(net)$color <- deg/2
V(net)$frame.color = "red"
V(net)$label.cex = .50
V(net)$label.color = rgb(0,0,.2,.5)
V(net)$size <- deg/1
plot(net,edge.arrow.size=.11,edge.curved=.3)



#
#par(mfrow=c(1,2),  mar=c(0,0,0,0))
#dev.off() # To Turn Off The par--- Multiple Graphs 
plot(net,vertex.size=10,edge.arrow.size=.05,edge.curved=.2,main="McKQuarterly Twitter Network",margin=0,frame="TRUE")
#plot(net1,edge.arrow.size=.09,edge.curved=.1,main="Problem Solving",margin=0,frame="TRUE")

#
# plot.igraph(net,vertex.label=V(net)$name,vertex.label.family="Arial Black",edge.arrow.size=.09,edge.width=E(net)$weight,layout=layout.fruchterman.reingold)
#
# 3D Plots with - rgl 
#
library("rgl")
rglplot(net) # using - library("rgl")
#

