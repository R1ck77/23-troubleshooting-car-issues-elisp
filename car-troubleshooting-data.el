
(defconst car-troubleshooting-data
  '("Is the car silent when you turn the key?"
    ("Are the battery terminal corroded?"
     "Clean terminals and try starting again."
     "Replace cables and try again.")
    ("Does the car make a clicking noise?"
     "Replace the battery."
     ("Does the car crank up but fail to start?"
      "Check spark plug connections."
      ("Does the engine start and then die?"
       ("Does your car have fuel Injection?"
        "Check to ensure the choke is opening and closing."
        "Get it in for service.")))))
  "Expert knowledge about car fixing")

(provide 'car-troubleshooting-data)
