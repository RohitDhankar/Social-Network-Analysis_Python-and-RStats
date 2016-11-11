#install.packages('igraph')
#install.packages('network') 
#install.packages('sna')
#install.packages('ndtv')
#install.packages('visNetwork')
#
require('igraph')
require('network') 
#require('sna')
#require('ndtv')
#require('visNetwork')
#
nodes <- read.csv("NODES_KK.csv", header=T, as.is=T)
links <- read.csv("EDGES_KK.csv", header=T, as.is=T)
head(nodes)
head(links)
nrow(nodes); length(unique(nodes$id))
nrow(links); nrow(unique(links[,c("from", "to")]))
#
links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
head(links)
colnames(links)[4] <- "weight"
rownames(links) <- NULL
#
head(links)
#
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
net
#
#E(net)       # The edges of the "net" object
#V(net)       # The vertices of the "net" object
#E(net)$type  # Edge attribute "type"
#V(net)$media # Vertex attribute "media"

# Find nodes and edges by attribute:
# (that returns oblects of type vertex sequence/edge sequence)
#V(net)[media=="BBC"]
E(net)[type=="mention"]

# You can also examine the network matrix directly:
#net[1,]
#net[5,7]
#
# Get an edge list or a matrix:
IMX=as_edgelist(net, names=T) # Incidence Matrix Getting Created 
IMX # TBD Add Weights 
IMXX  = as.matrix(IMX) # IMXX is a Regular Non Sparse Matrix 
write.csv(IMXX, file = "Incidence_Matrix.csv", row.names = TRUE)
#
AMX=as_adjacency_matrix(net, attr="weight") # adjacency_matrix Getting Created 
AMX # AMX is a dgcMatrix or Sparse Matrix 
AMXX  = as.matrix(AMX) # AMXX is a Regular Non Sparse Matrix 
write.csv(AMXX, file = "Adj_Matrix.csv", row.names = TRUE)
#
#
# Or data frames describing nodes and edges:
as_data_frame(net, what="edges")  # TBD --- Get this DF into CSV 
as_data_frame(net, what="vertices") # TBD --- Get this DF into CSV 
#
plot(net) # not a pretty picture!
#
net <- simplify(net, remove.multiple = F, remove.loops = T) 
#
plot(net, edge.arrow.size=.4,vertex.label=NA)
#
# Plot with curved edges (edge.curved=.1) and reduce arrow size:
# Note that using curved edges will allow you to see multiple links
# between two nodes (e.g. links going in either direction, or multiplex links)
plot(net, edge.arrow.size=.4, edge.curved=.1)
# Set edge color to light gray, the node & border color to orange 
# Replace the vertex label with the node names stored in "media"
plot(net, edge.arrow.size=.2, edge.color="orange",
     vertex.color="orange", vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")
#
# Generate colors based on media type:
net
colrs <- c("gray50", "tomato", "gold")
#V(net)$color <- colrs[V(net)$media.type]
V(net)$color <- colrs[V(net)$weight]
plot(net, edge.curved=.5)

# Compute node degrees (#links) and use that to set node size:
deg <- degree(net, mode="all")
V(net)$size <- deg*3
V(net)$size <- weight
# We could also use the audience size value:
V(net)$size <- V(net)$audience.size*0.6

# The labels are currently node IDs.
# Setting them to NA will render no labels:
V(net)$label <- NA

# Set edge width based on weight:
E(net)$width <- E(net)$weight/6

#change arrow size and edge color:
E(net)$arrow.size <- .2
E(net)$edge.color <- "gray80"
E(net)$width <- 1+E(net)$weight/12
plot(net) 
#
plot(net, edge.color="orange", vertex.color="gray50")
#
plot(net) 
legend(x=-1.5, y=-1.1, c("Newspaper","Television", "Online News"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)
#
#
plot(net, vertex.shape="none", vertex.label=V(net)$name, 
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="orange")
#
edge.start <- ends(net, es=E(net), names=F)[,1]
edge.col <- V(net)$color[edge.start]

plot(net, edge.color=edge.col, edge.curved=.1)
#
#
layouts <- grep("^layout_", ls("package:igraph"), value=TRUE)[-1] 
# Remove layouts that do not apply to our graph.
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama|tree", layouts)]

par(mfrow=c(3,3), mar=c(1,1,1,1))
for (layout in layouts) {
  print(layout)
  l <- do.call(layout, list(net)) 
  plot(net, edge.arrow.mode=0, layout=l, main=layout) }