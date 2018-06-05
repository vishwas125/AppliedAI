(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.FuzzyMain)
(import nrc.fuzzy.jess.*)
(load-package nrc.fuzzy.jess.FuzzyFunctions)


;global variables declaration
(defglobal ?*distance* = (new FuzzyVariable "distance" 0.0 1000.0 "miles"))
(defglobal ?*numberofdays* = (new FuzzyVariable "numberofdays" 0 10.0 "number"))
(defglobal ?*numberofpeople* = (new FuzzyVariable "numberofpeople" 0 20.0 "number"))

(defglobal ?*foodpriority* = (new FuzzyVariable "foodpriority" 0.0 10.0 "level"))
(defglobal ?*travelpriority* = (new FuzzyVariable "travelpriority" 0.0 10.0 "level"))
(defglobal ?*accomodationpriority* = (new FuzzyVariable "accomodationpriority" 0.0 10.0 "level"))
(defglobal ?*budget* = (new FuzzyVariable "budget" 0.0 1000.0 "dollars"))


(defglobal ?*dist* = "")
(defglobal ?*days* = "")
(defglobal ?*people* = "")
(defglobal ?*travel* = "")
(defglobal ?*food* = "")
(defglobal ?*accomodation* = "")




(defrule init
    (declare (salience 110))
    =>
    
	(printout t "----------------------------------------" crlf)
 	(printout t "Enter distance priority: 1.Short 2.Medium 3.Long (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*dist* "low")
    else(if (= ?temp 2) then 
        (bind ?*dist* "medium")
            else(bind ?*dist* "high")))
    
  	(printout t "Enter number of days: 1.Small 2.Medium 3.Large (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*days* "low")
    else(if (= ?temp 2) then 
        (bind ?*days* "medium")
            else(bind ?*days* "high")))
    
    (printout t "Enter food priority: 1.Low 2.Medium 3.High (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*food* "low")
    else(if (= ?temp 2) then 
        (bind ?*food* "medium")
            else(bind ?*food* "high")))
    
    
    
    
      (printout t "Enter travel priority: 1.Low 2.Medium 3.High (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*travel* "low")
    else(if (= ?temp 2) then 
        (bind ?*travel* "medium")
            else(bind ?*travel* "high")))
    
        
    
   (printout t "Enter group of people: 1.Small 2.Medium 3.Large (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*people* "low")
    else(if (= ?temp 2) then 
        (bind ?*people* "medium")
            else(bind ?*people* "high")))
        
            
      (printout t "Enter accomodation priority: 1.Low 2.Medium 3.High (Enter choice value):" crlf)
    (bind ?temp (read)) 
    (if (= ?temp 1) then 
        (bind ?*accomodation* "low")
    else(if (= ?temp 2) then 
        (bind ?*accomodation* "medium")
            else(bind ?*accomodation* "high")))
  )



(defrule initialize-fuzzy-variables
    (declare (salience 100))
    =>

    (printout t crlf)
    (printout t "==============Data initialization  and assertion================" crlf)
    (printout t "Initializing the distance" crlf)
 	(?*distance* addTerm "low" (new ZFuzzySet 0 250))
	(?*distance* addTerm "medium" (new TriangleFuzzySet 450 180))
    (?*distance* addTerm "high" (new SFuzzySet 650 1000))
    
      
    (printout t "Initializing numberofdays" crlf)
 	(?*numberofdays* addTerm "low" (new ZFuzzySet 0 2))
	(?*numberofdays* addTerm "medium" (new TriangleFuzzySet 5 3))
    (?*numberofdays* addTerm "high" (new SFuzzySet 7 10))
    (call ?*numberofdays* addTerm "extremelyhigh" "extremely high")


    (printout t "Initializing numberofpeople" crlf)
 	(?*numberofpeople* addTerm "low" (new ZFuzzySet 1 5))
	(?*numberofpeople* addTerm "medium" (new TriangleFuzzySet 11 7))
    (?*numberofpeople* addTerm "high" (new SFuzzySet 15 20))


    (printout t "Initializing foodpriority" crlf)
 	(?*foodpriority* addTerm "low" (new ZFuzzySet 1 4))
	(?*foodpriority* addTerm "medium" (new TriangleFuzzySet 6 2))
    (?*foodpriority* addTerm "high" (new SFuzzySet 7 10))

    
    (printout t "Initializing travelpriority" crlf)
 	(?*travelpriority* addTerm "low" (new ZFuzzySet 1 4))
	(?*travelpriority* addTerm "medium" (new TriangleFuzzySet 6 2))
    (?*travelpriority* addTerm "high" (new SFuzzySet 7 10))
	      
    
    
    (printout t "Initializing accomodationpriority" crlf)
 	(?*accomodationpriority* addTerm "low" (new ZFuzzySet 1 4))
	(?*accomodationpriority* addTerm "medium" (new TriangleFuzzySet 6 2))
    (?*accomodationpriority* addTerm "high" (new SFuzzySet 7 10))
	     
         

	 (printout t "Initializing budget" crlf)
 	(?*budget* addTerm "low" (new ZFuzzySet 200 355))
	(?*budget* addTerm "medium" (new TriangleFuzzySet 500 260))
    (?*budget* addTerm "high" (new SFuzzySet 550 1000))
	
    
    
    
    ;asserting  the user data. 
    (printout t "*********************************************" crlf) 
    (printout t "Asserting the data given by the user. . . . . . . . " crlf)   
 	(assert (distance (new FuzzyValue ?*distance* ?*dist*)))
  	(assert (people (new FuzzyValue ?*numberofpeople* ?*people*)))
	(assert (days (new FuzzyValue ?*numberofdays* ?*days*)))
    (assert (foodpriority (new FuzzyValue ?*foodpriority* ?*food*)))
	(assert (travelpriority (new FuzzyValue ?*travelpriority* ?*travel*)))
	(assert (accomodationpriority (new FuzzyValue ?*accomodationpriority* ?*accomodation*)))
    )



;rule 2
(defrule distance-Low
    (declare (salience 3))
    (distance ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly low")))
    (printout t "Triggering rule 2 for low distance: " (?t momentDefuzzify) crlf)
)
;rule 3
(defrule distance-Medium
    (declare (salience 2))
    (distance ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly high")))
    (printout t "Triggering rule 3 for medium distance: " (?t momentDefuzzify) crlf)
    )
;Rule 4 
(defrule distance-High
        (declare (salience 1))
    (distance ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "very high")))
    (printout t "Triggering rule 4 for high distance: " (?t momentDefuzzify) crlf)    
    )
    

    
;rule 5
(defrule numpeople-Low
    (declare (salience 1))
    (people ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly medium")))
    (printout t "Triggering rule 5 for less number of people: " (?t momentDefuzzify) crlf)
)


;rule 6
(defrule numpeople-medium
    (declare (salience 2))
    (people ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly high")))
    (printout t "Triggering rule 6 for medium number of people: " (?t momentDefuzzify) crlf)
)

;rule 7
(defrule numpeople-high
    (declare (salience 1))
    (people ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "very high")))
    (printout t "Triggering rule 7 for high number of people : " (?t momentDefuzzify) crlf)
)
   
    
;rule 8
(defrule numdays-high
    (declare (salience 1))
    (days ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly high")))
    (printout t "Triggering rule 8 for high number of days: " (?t momentDefuzzify) crlf)
)
  
    
;rule 9
(defrule numdays-medium
    (declare (salience 1))
    (days ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "medium")))
    (printout t "Triggering rule 9 for medium number of days: " (?t momentDefuzzify) crlf)
)       

;rule 10
(defrule numdays-low
    (declare (salience 1))
    (days ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly medium")))
    (printout t "Triggering rule 10 for less number of days: " (?t momentDefuzzify) crlf)
)  
    
    
;rule 11
(defrule foodpriority-high
    (declare (salience 1))
    (foodpriority ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "high")))
    (printout t "Triggering rule 11 for high foodpriority: " (?t momentDefuzzify) crlf)
)
  
    
;rule 12
(defrule foodpriority-medium
    (declare (salience 1))
    (foodpriority ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "medium")))
    (printout t "Triggering rule 12 for medium foodpriority: " (?t momentDefuzzify) crlf)
)       

;rule 13
(defrule foodpriority-low
    (declare (salience 1))
    (foodpriority ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "very low")))
    (printout t "Triggering rule 13 for low foodpriority: " (?t momentDefuzzify) crlf)
)     
    
    
;rule 14
(defrule travelpriority-high
    (declare (salience 1))
    (travelpriority ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "very high")))
    (printout t "Triggering rule 14 for high travel priority: " (?t momentDefuzzify) crlf)
)
  
    
;rule 15
(defrule travelpriority-medium
    (declare (salience 1))
    (travelpriority ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly high")))
    (printout t "Triggering rule 15 for medium travel priority: " (?t momentDefuzzify) crlf)
)       

;rule 16
(defrule travelpriority-low
    (declare (salience 1))
    (travelpriority ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "slightly medium")))
    (printout t "Triggering rule 16 for low travel priority: " (?t momentDefuzzify) crlf)
)      
    
    
;rule 17
(defrule accomodationpriority-high
    (declare (salience 1))
    (accomodationpriority ?t&:(fuzzy-match ?t "high"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "extremely high")))
    (printout t "Triggering rule 17 for high accomodationpriority: " (?t momentDefuzzify) crlf)
)
  
    
;rule 18
(defrule accomodationpriority-medium
    (declare (salience 1))
    (accomodationpriority ?t&:(fuzzy-match ?t "medium"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "high")))
    (printout t "Triggering rule 18 for medium accomodationpriority: " (?t momentDefuzzify) crlf)
)       

;rule 19
(defrule accomodationpriority-low
    (declare (salience 1))
    (accomodationpriority ?t&:(fuzzy-match ?t "low"))
      =>
    (assert (budget (new FuzzyValue ?*budget* "medium")))
    (printout t "Triggering rule 19 for low accomodationpriority: " (?t momentDefuzzify) crlf)

)

(defrule welcome
(declare (salience 120))   
    =>
    (printout t "                                    " crlf)
    (printout t "----------------------------------------------- " crlf)
    (printout t "Welcome to Travel budget estimator! " crlf)
    (printout t "Please enter the following details and we'll estimate your trip's budget. " crlf)
    
    
)

;rule for printing
(defrule print-results
    (declare (salience -100))
    (budget ?cs)
    =>
    (printout t crlf)
   (printout t " ======================Analysis and result====================" crlf)
    
    (printout t crlf)  
    (printout t "Approx. Budget: " (?cs momentDefuzzify) crlf)
     (printout t "This estimation is based on a few general assumptions. " crlf)   
     (printout t "Thank you for using travel budget estimator. " crlf)    
)

(reset)
(run)


