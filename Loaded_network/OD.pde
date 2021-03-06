class OD
{
    PVector p, nearestIntersection;
    String nearestIntersectionID;
    
    
    
//    void findNearestIntersection(HashMap<String, StreetSegment> streets)
//    {
//        /*
//            Confusingly, this actually derives the *start* of the nearest *segment*
//        */
//        float minDistance = 500;
//        for(String s: streets.keySet())
//        {
//            float dist = PVector.dist(p, streets.get(s).screenPoints.get(0));
//            if(dist<minDistance)
//            {
//                nearestIntersectionID = s;
//                minDistance = dist;
//                nearestIntersection = streets.get(s).screenPoints.get(0);
//            }
//        }
//    }
    
    void findNearestIntersection(HashMap<String, Intersection> intz)
    {
        /*
            Derives intersection from intersections
            These two methods aren't really compatible
        */
        float minDistance = 50000;
        for(String s: intz.keySet())
        {
            float dist = PVector.dist(p, intz.get(s).p);
            if(dist<minDistance)
            {
                nearestIntersectionID = s;
                minDistance = dist;
                nearestIntersection = intz.get(s).p;
                
            }
        }
    }
    
    void display()
    {
        //fill(0,255,200);
        noFill();
        ellipse(p.x, p.y, 20, 20);
        line(p.x, p.y, nearestIntersection.x, nearestIntersection.y);
        if(frameCount<2) intersections.get(nearestIntersectionID).isOD = true;
        //text(nearestIntersectionID, nearestIntersection.x, nearestIntersection.y);
        
        //ellipse(nearestIntersection.x, nearestIntersection.y, 10, 10);
    }
    
}


void drawWeights()
{
    for(String s:weight.keySet())
    {
        for(String t: weight.get(s).keySet())
        {
          
            float w = weight.get(s).get(t);
            if(abs(w)>0)
            {
                
                strokeWeight(maxThickness*weight.get(s).get(t)/maxWeight);
                stroke(0, maxStroke*weight.get(s).get(t)/maxWeight);
                
                
                PVector o = posns.get(s).p;
                PVector d = posns.get(t).p;
                if(o!=null && d!=null) {
                  //line(o.x, o.y, d.x, d.y);
                   if(s.equals(t))
                   {
                       ellipse(o.x, o.y, 10,10);
                   }
                   else
                   {
                     bline(o,d);
                   }
                }
            }
        }
    }
}

void bline(PVector oh, PVector dee)
{
    PVector diff = PVector.sub(dee, oh);
    float angle = diff.heading();
   
    
    pushMatrix();
      translate(oh.x, oh.y);
      rotate(angle);
      //line(0,0,diff.mag(),0);
      
      float d = diff.mag();
      bezier(0.0,0.0, (1-curviness)*d, curviness*d, d, curviness*d, d, 0);
    popMatrix();
}
