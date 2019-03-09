#computed weighted mean by a particular unit (same as "proc means data=____; by ___; weight ____; run;" in SAS)#
weighted.avg.by.month <- sapply(split(mydataset,mydataset$month), #divide the data by month (or individual or whatever)
                                     function(x) weighted.mean(x$variabletobeaveraged,w=x$weightingfactor)) #take the weighted 
                                                                                                             #mean in that subset
#
#this method is WAAAAAAAAAAY faster, by the way...
m <- aggregate.data.frame(list(D$variable*D$weight,D$weight), #sum up the weighted scores and the sum of the weights
                          list(D$individual),sum) #by each individual or invoice number or whatever
colnames(m) <- colnames(D)
m$weightedaverage <- m$variable/m$weight #weighted score divided by summed weights is the weighted average
#
#checking:
weighted.mean(x=D[which(D$individual=="A"),"x"],w=D[which(D$individual=="A"),"w"]) #built-in function for the 
                                                                                   #subsetted data (can do by a loop, but too slow)
#is equivalent to
sum(D[which(D$SEQN=="A"),"variable"]*D[which(D$individual=="A"),"weight"])/sum(D[which(D$individual=="A"),"weight"]) #weighted score 
