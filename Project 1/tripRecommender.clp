(clear)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Trip Recommendation System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module MAIN
(deftemplate input
  (slot info)
  (slot rettype)
  (slot category))

(deftemplate output
  (slot category)
  (slot info))
  
(deftemplate place
	(slot place-name)
  (slot number-of-days )
  (slot place-category )
  (slot place-distance )
  (slot number-of-attractions )  )

(deftemplate place-not-found
	(slot flag(default 0))
)  

(deffacts info-data
  "The data is input from the user."
  (input (category number-of-days) (rettype number)
            (info "Please select the maximum trip duration(in days) - (eg: 2):
			1. 1
			2. 2
			3. 5
			4. 7		
			"))
	(input (category place-category) (rettype string)
            (info "Please select the trip type -  (eg: Trekking):
			1. Trekking
			2. Scenic
			3. Religious	
			"))
	(input (category place-distance) (rettype number)
            (info "Please select the maximum distance you wish to travel(in kms) - (eg: 300):
			1. 100
			2. 300
			3. 500
			4. 750
			"))
	(input (category number-of-attractions) (rettype number)
            (info "Specify the maximum number of attractions you wish to visit - (eg: 5):
			1. 3
			2. 5
			3. 10
          		4. 20
			"))	
  		)


(deffacts places-data
	"The data about the places in and around Karnataka, India"
;;Trekking places	
(place (place-name "Savandurga") (number-of-days 1) (place-category "Trekking") (place-distance 100)(number-of-attractions 3))
(place (place-name "Makalidurga") (number-of-days 1) (place-category "Trekking") (place-distance 100)(number-of-attractions 3))
(place (place-name "Z-Point, Kemmangundi") (number-of-days 2) (place-category "Trekking") (place-distance 300)(number-of-attractions 5))
(place (place-name "Kumara Parvata") (number-of-days 2) (place-category "Trekking") (place-distance 300)(number-of-attractions 3))
(place (place-name "Mullayanagiri") (number-of-days 3) (place-category "Trekking") (place-distance 300)(number-of-attractions 10))
(place (place-name "Lonavala") (number-of-days 5) (place-category "Trekking") (place-distance 750)(number-of-attractions 5))

;;Scenic places
(place (place-name "Shivanasamudra") (number-of-days 1) (place-category "Scenic") (place-distance 100)(number-of-attractions 3))
(place (place-name "Art of Living International") (number-of-days 1) (place-category "Scenic") (place-distance 100)(number-of-attractions 5))
(place (place-name "Chikmagaluru") (number-of-days 5) (place-category "Scenic") (place-distance 300)(number-of-attractions 3))
(place (place-name "Gandikota") (number-of-days 2) (place-category "Scenic") (place-distance 300)(number-of-attractions 5))

;;Religious places
(place (place-name "Gaali Anjaneya Temple, Bengaluru") (number-of-days 1) (place-category "Religious") (place-distance 100)(number-of-attractions 3))
(place (place-name "Talakadu") (number-of-days 1) (place-category "Religious") (place-distance 100)(number-of-attractions 5))
(place (place-name "Malai Mahadeshwara Betta") (number-of-days 1) (place-category "Religious") (place-distance 300)(number-of-attractions 3))
(place (place-name "Sringeri") (number-of-days 7) (place-category "Religious") (place-distance 500)(number-of-attractions 15))
(place (place-name "Mantralaya") (number-of-days 2) (place-category "Religious") (place-distance 300)(number-of-attractions 10))
(place (place-name "Tirupati") (number-of-days 2) (place-category "Religious") (place-distance 300)(number-of-attractions 5))

)	

0
;;;;;;;;;;; On selection
(defrule list-places

	(output (category ?number-of-days)(info ?i))
	(output (category ?place-category) (info ?ipc))
	(output (category ?place-distance) (info ?id))
	(output (category ?number-of-attractions) (info ?ia))
	?flag-fact <-(place-not-found (flag ?f&:(or (eq ?f 1) (eq ?f 2))))
	?place <-(place (place-name ?fn) 	
			(number-of-days ?fh&:(eq ?fh ?i)) 
			(place-category ?fc&:(eq (str-compare ?fc  ?ipc) 0)) 
			(place-distance ?r&:(eq ?r  ?id))
			(number-of-attractions ?mi&:(eq ?mi ?ia)))
	=>
	(display-places ?fn ?fh ?fc ?r ?mi )
	(retract ?place)

	(modify ?flag-fact (flag 2))
)

(deffunction get-distance (?param)
	(if (eq ?param 1)then 
        (return 100))
    else (if (eq ?param 2) then
        (return 300))
    else (if (eq ?param 3) then 
        (return 500))
    else (if (eq ?param 4) then
        (return 750))
	else (return 1000)
)

(deffunction get-category (?param)
	(if (eq ?param 1)then 
        (return Trekking))
    else (if (eq ?param 2) then
        (return Scenic))
	else (return Religious)
)

(deffunction get-number-of-days (?param)
	(if (eq ?param 1)then 
        (return 1))
    else (if (eq ?param 2) then
        (return 2))
    else (if (eq ?param 3) then 
        (return 5))
	else (return 7)
)

(deffunction get-attractions (?param)
	(if (eq ?param 1)then 
        (return 3))
    else (if (eq ?param 2) then
        (return 5))
	else (return 10)
)


;;;;;;;;;;; No places can be found
(defrule no-places-found
	(place-not-found (flag 1))
	=>
	(printout t "--------------------------------------------" crlf)
	(printout t "--------------------------------------------" crlf)
    
	(printout t 
	"Sorry. We dont have any places based on the inputs entered by you.
	Please try again with different inputs." crlf)
	
	(printout t "--------------------------------------------" crlf)
    (printout t "--------------------------------------------" crlf)
    
    
)

;;;;;;;;;;; Exit message
(defrule exit-recommender
    (place-not-found (flag 1))
	=>
	(printout t 
	"Thank you for using our recommender system." crlf)
	
	
)

(deffunction display-places (?fn ?fh ?fc ?r ?mi)
	(printout t "--------------------------------------------" crlf)
	(printout t "--------------------------------------------" crlf)
	(display-place "Place Name" ?fn )
	(display-place "Number of days" ?fh )
	(display-place "Place Category" ?fc )
	(display-place "Max Distance" ?r )
	(display-place "Number of attractions" ?mi )
	(printout t "--------------------------------------------" crlf)
    (printout t "--------------------------------------------" crlf)
	
	(return)
)

(deffunction display-place (?param ?value)
	(printout t (str-cat ?param ": " ?value) crlf )
	(return)
)


;;;;;;;;;; Module read-input ;;;;;;;;;;;;;;;;;;;;;;


(defmodule read-input)
(deffunction get-input (?q ?category)
  "Print a question and return the input"
  (bind ?input "")
  (while (not (is-of-type ?input ?category)) do
         (printout t ?q " ")
         (bind ?input (read)))
  (return ?input))

(deffunction is-of-type (?input ?type)
  "Check that the input has the right form"
  (if (eq ?type number) then
           (return (numberp ?input))
    else (return (> (str-length ?input) 0))))
   
(defrule read-input::ask-question-by-id
  "Given the identifier of a question, ask it and assert the answer"
  (declare (auto-focus TRUE))
  (MAIN::input (category ?id) (info ?text) (rettype ?type))
  (not (MAIN::output (category ?id)))
  ?ask <- (MAIN::read-input  ?id)
  =>
  (bind ?output (get-input ?text ?type))
  (assert (output (category ?id) (info ?output)))
  (retract ?ask)
  (return)
)

;;;;;;;;;;;;; Module boot ;;;;;;;;;;;;;;;;;;;

  
(defmodule boot)
	(defrule welcome-user
	=>
	(printout t crlf crlf crlf crlf)
	(printout t crlf "***************************************************************************" crlf)
	(printout t "----------------------TRIP RECOMMENDATION SYSTEM---------------------------" crlf)
	(printout t "***************************************************************************" crlf crlf)
	
	(printout t "Welcome to the Trip Recommendation System." crlf)
	(printout t "Please give us some data." crlf)
	(printout t "We'll recommend a few places which you can visit in and around Karnataka, India." crlf)
	
	(printout t crlf "***************************************************************************" crlf)
	(printout t "***************************************************************************" crlf crlf)
)


;;;;;;;;;;;;; Module shoot ;;;;;;;;;;;;;;;;;;;

(defmodule shoot)
	(defrule input-number-of-days
		(declare (salience 100))
		=>
		(assert (read-input number-of-days)))

	(defrule input-place-category
		(declare (salience 99))
		=>
		(assert (read-input place-category)))

	(defrule input-place-distance
		(declare (salience 98))
		=>
		(assert (read-input place-distance)))

	(defrule input-number-of-attractions
		(declare (salience 97))
		=>
		(assert (read-input number-of-attractions))
		(assert(place-not-found (flag 1))))

;;;;;;;;;;;Test;;;;;;;;;;;;;;;;

(deffunction bootstrap()
;(watch all)
  (reset)
  (focus boot shoot)
  (run)
)
(bootstrap)


