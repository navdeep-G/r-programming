
#NOTE: An alternative to inside.triangle.R:

#Use this function to find if a point in the Cartesian plane
#is inside, outside, or on a triangle formed by three other points.
#Results are summarized graphically.

#Input requires four 2-D vectors, the first three of which are the
#triangle, and the fourth is the query point.
#Random point generation and function call are included for testing.

#Copy-and-paste this whole document into R Console, or a new R script window.

inside.triangle=function(A,B,C,X)
{###Begin function
  
  ############################################
  ## Primary check:  Correct input format?
  
  lengths=c( length(A), length(B), length(C), length(X) )
  
  if ( sum(lengths)!=8 )
  {stop("One or more input arguments are not 2-D vectors.")}
  
  ##################################################################
  ## Initializing
  ##
  ## Vectors x, y, x.p, y.p, min.p, max.p, lab are used for plotting.
  ## Vectors AB, BC, CA are used for cross product analysis
  
  x = c( A[1], B[1], C[1] )
  y = c( A[2], B[2], C[2] )
  
  x.p = c( x, A[1] )
  y.p = c( y, A[2] )
  
  min.p = min( c(x.p, y.p, X) ) - 1
  max.p = max( c(x.p, y.p, X) ) + 1
  
  lab = c("A", "B", "C")
  
  AB = c( B[1]-A[1] , B[2]-A[2] )
  BC = c( C[1]-B[1] , C[2]-B[2] ) 
  CA = c( A[1]-C[1] , A[2]-C[2] ) 
  
  ##########################################
  #Secondary check: Is ABC a triangle?
  #2 cases checked:
  #1.  Any points A, B, C are the same.
  #2.  Any points A, B, C are co-linear.
  
  if ( sum(A==B)==2 | sum(A==C)==2 | sum(B==C)==2 )
  {output="ABC is not a triangle."}
  
  check.tri=c(  AB[1]*BC[2]-AB[2]*BC[1], 
                BC[1]*CA[2]-BC[2]*CA[1], 
                CA[1]*AB[2]-CA[2]*AB[1]  )
  
  if ( 0 %in% check.tri )
  {output="ABC is not a triangle."
   
  }else{#open 1st else
    
    ############################
    #Check for X on vertex
    if ( sum(A==X)==2 | sum(A==X)==2 | sum(B==X)==2 )
    {output="The point is ON the triangle."
     
    }else{#open 2nd else
      
      ############################
      #Cross Product Analysis 
      
      A.X = c( X[1]-A[1] , X[2]-A[2] ) 
      B.X = c( X[1]-B[1] , X[2]-B[2] ) 
      C.X = c( X[1]-C[1] , X[2]-C[2] ) 
      
      cross.prod = c( AB[1]*A.X[2] - AB[2]*A.X[1] , 
                      BC[1]*B.X[2] - BC[2]*B.X[1] , 
                      CA[1]*C.X[2] - CA[2]*C.X[1] )
      
      ###########################
      #Circumcenter Analysis
      
      D = 2*( A[1]*(B[2]-C[2]) + 
                B[1]*(C[2]-A[2]) +
                C[1]*(A[2]-B[2]) )
      
      cen.x = ( (A[2]^2 + A[1]^2)*(B[2] - C[2]) +
                  (B[2]^2 + B[1]^2)*(C[2] - A[2]) +
                  (C[2]^2 + C[1]^2)*(A[2] - B[2]) ) / D
      
      cen.y = ( (A[2]^2 + A[1]^2)*(C[1] - B[1]) +
                  (B[2]^2 + B[1]^2)*(A[1] - C[1]) +
                  (C[2]^2 + C[1]^2)*(B[1] - A[1]) ) / D
      
      d.cen.X = sqrt ( (X[1]-cen.x)^2 + (X[2]-cen.y)^2 )
      radius.A = sqrt( (A[1]-cen.x)^2 + (A[2]-cen.y)^2 )
      radius.B = sqrt( (B[1]-cen.x)^2 + (B[2]-cen.y)^2 )
      radius.C = sqrt( (C[1]-cen.x)^2 + (C[2]-cen.y)^2 )
      radius   = mean( c( radius.A, radius.B, radius.C))
      
      if (  0 %in% cross.prod & ((radius)<d.cen.X) )  
      {output="The point is OUTSIDE the triangle."
       
      }else{#open 3rd else
        
        if ( (cross.prod[1]==0) | (cross.prod[2]==0) | (cross.prod[3]==0) )
        {output="The point is ON the triangle."
         
        }else{#open 4th else
          
          #######################################################
          #Analsysis for query points in/out of the triangle
          
          sign=numeric(3)
          for (i in 1:3) {sign[i]= cross.prod[i]<0}
          if (  (sum(sign)==3)  | (sum(sign)==0) )
            
          {output="The point is INSIDE the triangle."
          }else{
            output="The point is OUTSIDE the triangle."}
          
          ###################
          #Brace closing
          
        }#close 4th else
      }#close 3rd else
    }#close 2nd else
  }#close 1st else
  
  #########################
  #Triangle-point plot
  
  plot( x,
        y, 
        xlim = c(min.p, max.p), 
        ylim = c(min.p, max.p), 
        main="inside.triangle()" )
  
  mtext(output, col="blue")
  lines(x.p,y.p,type="l",lty=2, col="gray")
  points(x,y, pch=19, col="darkblue")
  text(x,y, labels=lab, col="darkblue", cex=.8, adj=c(0,-1) )
  points(X[1], X[2], pch=4, col="red")
  
  ############
  #Output
  return(output)
  
}#End function

###########################################################
#A,B,C,X are drawn from a narrow range below to increase
#the chances of generating query points in the triangle, 
#but the min/max settings (i.e., -5 and 5) may be changed at will.

#Changing the 2 to any other number will create an error.

A = c( round(runif(2,-5,5)) )
B = c( round(runif(2,-5,5)) )
C = c( round(runif(2,-5,5)) )
X = c( round(runif(2,-5,5)) )

inside.triangle(A,B,C,X)  
