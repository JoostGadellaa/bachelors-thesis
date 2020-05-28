;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A Networked Evolutionairy Trust Game for the Sharing Economy                                          ;;;
;;;                                                                                                       ;;;
;;; This simulation is part of the thesis for my Bachelor's degree in Economics and Business Economics    ;;;
;;; at Utrecht University. The game is based on a paper by Chica, Chiong, Adam, Damas, & Teubner (2017).  ;;;
;;; The structure of the simulation, and some of the specificities are from ABED-1pop (Izquierdo,         ;;;
;;; Izquierdo, & Sandholm, 2018), which is avalable under the GNU General Public License version 3. The   ;;;
;;; network statistics and layout procedures are from a code snippet send to me by Luis R. Izquierdo.     ;;;
;;; I would not have been able to write the other methods and learn NetLogo without the book "Agent-Based ;;;
;;; Evolutionary Game Dynamics" by Izquierdo, Izquierdo, & Sandholm (in press).                           ;;;
;;;                                                                                                       ;;;
;;; This program is not meant to be distributed, and will only be shared for the pupose of verifying my   ;;;
;;; results. The code is specific to its application, and readability was often prioritised over          ;;;
;;; flexibility. I do not imply any warranty of merchantability or fitness for a particular purpose.      ;;;
;;;                                                                                                       ;;;
;;; Contact information:                                                                                  ;;;
;;; Joost Gadellaa                                                                                        ;;;
;;; j.f.gadellaa@students.uu.nl                                                                           ;;;
;;; joost@gadellaa.net                                                                                    ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extensions [nw]

globals [
  ;; network globals
  n-of-links
  avg-nbrs-within-radius
  avg-clustering-coefficient
  size-of-greatest-component

  ;; game globals
  payoff-matrix
  strategy-names
  strategy-colours
  max-payoff-difference
  sum-of-payoffs
  total-payoffs
  walking-average-payoff
  countdown
  exit-code
]

breed [nodes node]

nodes-own [
  strategy
  payoff
  community
  ratio-intra-edges
]

links-own [
  rewired?
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Scenarios and coloring for demonstration ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to say-cheese
  ask patches [set pcolor white]
  ask links [set color black]
  ask nodes [set label ""]
  ask nodes [set color 15 + 10 * (community mod 8 + 1)]
end

to demonstration-general-dynamic-portfolio
  set avg-degree 8
  set prob-rewiring 0.05
  set Reward 30
  setup
end

to demonstration-too-much-reinforcement
  set avg-degree 18
  set prob-rewiring 0.05
  set Reward 30
  setup
end

to demonstration-rewiring-low
  set avg-degree 8
  set prob-rewiring 0.8
  set Reward 24
  setup
end

to demonstration-rewiring-medium
  set avg-degree 8
  set prob-rewiring 0.8
  set Reward 30
  setup
end

to demonstration-rewiring-high
  set avg-degree 8
  set prob-rewiring 0.8
  set Reward 36
  setup
end

to demonstration-random
  set avg-degree one-of [4 6 8 10 12 14 16 18 20]
  set prob-rewiring one-of [0.01 0.02 0.04 0.05 0.08 0.1 0.2 0.4 0.5 0.8 1]
  set Reward one-of [21 24 27 30 33 36 39]
  setup
end

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all

  build-initial-network
  do-plots
  compute-clustering-coefficient
  compute-intra-edges

  reset-simulation
  relax-network
end

to reset-simulation
  update-reward
  set payoff-matrix read-from-string payoffs
  let min-payoff -20 * revision-frequency
  let max-payoff 40 * revision-frequency
  set max-payoff-difference (max-payoff + 999999) - (min-payoff + 999999)
  set strategy-names ["TP" "UP" "TC" "UC"]
  set strategy-colours [15 95 55 115]
  ask nodes [mutate]

  set sum-of-payoffs 0
  set total-payoffs 0
  set walking-average-payoff 0
  set exit-code ""
  set countdown 16
  reset-ticks
end

to build-initial-network
  set-default-shape nodes "circle"
  build-network
  set n-of-links count links
end

to build-network
  if network-model = "small-world" [
    nw:generate-watts-strogatz nodes links n-of-nodes (avg-degree / 2) prob-rewiring
  ]
  if network-model = "community" [
    generate-community
  ]
end

to generate-community
  ;; create nodes with a community and space them out
  create-nodes n-of-nodes [
    set community (who mod n-of-communities) + 1
    set heading community * 360 / n-of-communities
    fd max-pxcor - 1
  ]

  ;; create links within the communities for each turtle
  let i 0
  while [i < n-of-nodes] [
    let this-community (i mod n-of-communities) + 1
    let goal avg-degree / 2
    let j 0
    while [j < goal] [
      let new-neighbor one-of nodes with [community = this-community and not (who = i) and not in-link-neighbor? node i]
      if new-neighbor != nobody [
        make-edge node i new-neighbor
      ]
      set j j + 1
    ]
    set i i + 1
  ]

  ;; always connect networks?
  if always-connect-communities? [
    connect-communities
  ]

  ;; randomly rewire
  ask nodes [
    let start-degree count my-links
    ask my-links [
      if random-float 1 < prob-rewiring [die]
    ]
    while [count my-links < start-degree] [
      make-new-friend
    ]
  ]
end

to make-new-friend
  let me who
  let new-neighbor one-of nodes with [not (who = me) and not in-link-neighbor? node me]
  if new-neighbor != nobody [
    create-link-with new-neighbor
  ]
end

to make-edge [node1 node2]
  ask node1 [create-link-with node2]
end

to connect-communities
  let i 1
  while [i <= n-of-communities] [
    let node1 one-of nodes with [community = i]
    let node2 one-of nodes with [community = (i mod n-of-communities) + 1]
    ask node1 [ask one-of my-links [die]]
    make-edge node1 node2
    set i i + 1
  ]
end

to update-reward
  set payoffs (word "[[  0   0  " reward  " -20 ]\n [  0   0  10  10 ]\n [ " reward " -10   0   0 ]\n [ 40 -10   0   0 ]]")
  set payoff-matrix read-from-string payoffs
end

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Running Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

to go

  if (count nodes with [strategy = 1] = 0) or (count nodes with [strategy = 3] = 0) [
    set exit-code "no trust"
    set countdown countdown - 1
    if (countdown <= 0 and stop-when-done?) [stop]
  ]

  if (count nodes with [strategy = 2] = 0) and (count nodes with [strategy = 4] = 0) [
    set exit-code "only trust"
    set countdown countdown - 1
    if (countdown <= 0 and stop-when-done?) [stop]
  ]

  let i 0
  ask nodes [set payoff 0]
  while [i < revision-frequency][
    ask nodes [play-game]
    set i i + 1
  ]
  ask nodes [revise-strategy]
  set sum-of-payoffs sum [payoff] of nodes
  set total-payoffs total-payoffs + sum-of-payoffs
  set walking-average-payoff floor ((15 * walking-average-payoff + sum-of-payoffs) / 16)
  tick
end

to play-game
  let mate one-of link-neighbors
  if mate != nobody [set payoff payoff + item ([(strategy - 1)] of mate) (item (strategy - 1) payoff-matrix)]
end

to revise-strategy
  let observed-node one-of link-neighbors
  if observed-node != nobody [
    let alter-payoff [payoff] of observed-node
    if alter-payoff > payoff [
      let probability (alter-payoff - payoff) / max-payoff-difference
      if random-float 1.0 < probability [
        set strategy ([strategy] of observed-node)
        update-color-and-label
        set label (item (strategy - 1) strategy-names)
      ]
    ]
  ]
  if random-float 1.0 < noise [mutate]
end

to mutate
  set strategy (random 4 + 1)
  update-color-and-label
  set payoff 0
end

to update-color-and-label
  set label (item (strategy - 1) strategy-names)
  set color (item (strategy - 1) strategy-colours)
end

;;;;;;;;;;;;;;;;;;;;;;;;;;     ;;;;;;;;;;;;;;
;;; Network Statistics ;;; and ;;; Layout ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;     ;;;;;;;;;;;;;;

to compute-clustering-coefficient
  set avg-clustering-coefficient mean [ nw:clustering-coefficient ] of turtles
end

to compute-intra-edges
  ask nodes [
    let my-community community
    if count link-neighbors != 0 [
      set ratio-intra-edges (count link-neighbors with [community = my-community] / count link-neighbors)
    ]
  ]
end

to plot-accessibility
  let steps link-radius
  if link-radius = "Infinity" [set steps n-of-nodes]
  let n-of-nbrs-of-each-player [count nw:turtles-in-radius steps - 1] of nodes
  let max-n-of-nbrs-of-each-player max n-of-nbrs-of-each-player
  set-current-plot "Neighbors within link-radius"
  set-plot-x-range 0 (max-n-of-nbrs-of-each-player + 1)  ;; + 1 to make room for the width of the last bar
  histogram n-of-nbrs-of-each-player
  set avg-nbrs-within-radius mean n-of-nbrs-of-each-player
end

to compute-size-of-greatest-component
  set size-of-greatest-component max map count nw:weak-component-clusters
end

to relax-network
  ;; the number 3 here is arbitrary; more repetitions slows down the
  ;; model, but too few gives poor layouts
  repeat 3 [
    ;; the more nodes we have to fit into the same amount of space,
    ;; the smaller the inputs to layout-spring we'll need to use
    let factor sqrt count nodes
    ;; numbers here are arbitrarily chosen for pleasing appearance
    layout-spring (nodes with [any? link-neighbors]) links (1 / factor) (7 / factor) (3 / factor)
    display  ;; for smooth animation
  ]
  ;; don't bump the links of the world
  let x-offset max [xcor] of nodes + min [xcor] of nodes
  let y-offset max [ycor] of nodes + min [ycor] of nodes
  ;; big jumps look funny, so only adjust a little each time
  set x-offset limit-magnitude x-offset 0.1
  set y-offset limit-magnitude y-offset 0.1
  ask nodes [ setxy (xcor - x-offset / 2) (ycor - y-offset / 2) ]
end

to-report limit-magnitude [number limit]
  if number > limit [ report limit ]
  if number < (- limit) [ report (- limit) ]
  report number
end

to do-plots
  plot-accessibility
  compute-size-of-greatest-component
end

to drag-and-drop
  if mouse-down? [
    let candidate min-one-of nodes [distancexy mouse-xcor mouse-ycor]
    if [distancexy mouse-xcor mouse-ycor] of candidate < 1 [
      ;; The WATCH primitive puts a "halo" around the watched turtle.
      watch candidate
      while [mouse-down?] [
        ;; If we don't force the view to update, the user won't
        ;; be able to see the turtle moving around.
        display
        ;; The SUBJECT primitive reports the turtle being watched.
        ask subject [ setxy mouse-xcor mouse-ycor ]
      ]
      ;; Undoes the effects of WATCH.  Can be abbreviated RP.
      reset-perspective
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
189
8
872
692
-1
-1
13.78
1
10
1
1
1
0
0
0
1
-24
24
-24
24
1
1
1
ticks
30.0

SLIDER
6
78
181
111
n-of-nodes
n-of-nodes
2
1024
512.0
1
1
NIL
HORIZONTAL

BUTTON
7
418
180
451
NIL
relax-network
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
463
699
572
744
link-radius
link-radius
1 2 3 4 5 10 20 "Infinity"
0

PLOT
4
549
182
794
Neighbors within link-radius
# of reachable neighbors
# of players
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" ""

MONITOR
189
699
345
744
Avg. nbrs within radius
avg-nbrs-within-radius
2
1
11

MONITOR
351
699
456
744
Clustering coeff.
avg-clustering-coefficient
2
1
11

MONITOR
190
749
346
794
Size of largest component
size-of-greatest-component
0
1
11

CHOOSER
6
27
181
72
network-model
network-model
"small-world" "community"
1

MONITOR
352
749
455
794
NIL
n-of-links
0
1
11

BUTTON
7
377
180
410
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
6
118
181
151
avg-degree
avg-degree
4
20
8.0
2
1
NIL
HORIZONTAL

SLIDER
6
157
182
190
prob-rewiring
prob-rewiring
0
1
0.01
0.01
1
NIL
HORIZONTAL

BUTTON
7
460
181
494
drag-and-drop
drag-and-drop
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
462
750
571
794
Update
plot-accessibility
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
879
459
934
492
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
879
276
1054
309
revision-frequency
revision-frequency
0
500
50.0
1
1
NIL
HORIZONTAL

INPUTBOX
878
27
1050
132
payoffs
[[  0   0  36 -20 ]\n [  0   0  10  10 ]\n [ 36 -10   0   0 ]\n [ 40 -10   0   0 ]]
1
1
String (reporter)

BUTTON
945
459
1050
492
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1060
352
1639
689
strategy distribution
NIL
NIL
0.0
1250.0
0.0
512.0
false
true
"" ""
PENS
"TP" 1.0 1 -2674135 true "" "plot n-of-nodes"
"UP" 1.0 1 -13791810 true "" "plot (count nodes with [strategy = 2] + count nodes with [strategy = 3] + count nodes with [strategy = 4])"
"TC" 1.0 1 -10899396 true "" "plot (count nodes with [strategy = 3] + count nodes with [strategy = 4])"
"UC" 1.0 1 -8630108 true "" "plot count nodes with [strategy = 4]"

SLIDER
879
317
1054
350
noise
noise
0
0.1
0.0
0.0001
1
NIL
HORIZONTAL

TEXTBOX
8
10
158
28
Network Settings:
11
0.0
1

TEXTBOX
8
226
158
244
Community Settings
11
0.0
1

SLIDER
7
243
179
276
n-of-communities
n-of-communities
0
(n-of-nodes / 16)
16.0
1
1
NIL
HORIZONTAL

SWITCH
7
285
181
318
always-connect-communities?
always-connect-communities?
0
1
-1000

BUTTON
879
416
1051
449
NIL
reset-simulation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
878
141
1050
174
Reward
Reward
21
39
36.0
1
1
NIL
HORIZONTAL

BUTTON
878
184
1049
217
NIL
update-reward\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
879
503
1050
584
NIL
exit-code
17
1
20

TEXTBOX
8
356
145
374
Network Actions\n
11
0.0
1

TEXTBOX
880
258
1030
276
Evolution Settings
11
0.0
1

TEXTBOX
878
10
1028
28
Payoff Settings\n
11
0.0
1

TEXTBOX
882
395
1032
413
Simulation Actions
11
0.0
1

MONITOR
880
644
1050
689
NIL
walking-average-payoff
17
1
11

MONITOR
1000
592
1050
637
NIL
countdown
17
1
11

PLOT
1060
13
1639
174
strategy counts
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"TP" 1.0 0 -2674135 true "" "plot count turtles with [strategy = 1]"
"UP" 1.0 0 -13791810 true "" "plot count turtles with [strategy = 2]"
"TC" 1.0 0 -10899396 true "" "plot count turtles with [strategy = 3]"
"UC" 1.0 0 -8630108 true "" "plot count turtles with [strategy = 4]"

SWITCH
881
598
994
631
stop-when-done?
stop-when-done?
1
1
-1000

PLOT
1362
188
1639
338
total cumulative payoffs
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot total-payoffs"

PLOT
1061
187
1351
337
total payoffs this round
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot sum-of-payoffs"

BUTTON
698
727
876
760
NIL
demonstration-random
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment Poging 2" repetitions="8" sequentialRunOrder="false" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="5000"/>
    <metric>count turtles with [strategy = 1]</metric>
    <metric>count turtles with [strategy = 2]</metric>
    <metric>count turtles with [strategy = 3]</metric>
    <metric>count turtles with [strategy = 4]</metric>
    <metric>exit-code</metric>
    <metric>n-of-links</metric>
    <metric>avg-clustering-coefficient</metric>
    <metric>total-payoffs</metric>
    <metric>walking-average-payoff</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="n-of-communities">
      <value value="16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="revision-frequency">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="n-of-nodes">
      <value value="512"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-rewiring">
      <value value="0.01"/>
      <value value="0.02"/>
      <value value="0.04"/>
      <value value="0.05"/>
      <value value="0.08"/>
      <value value="0.1"/>
      <value value="0.2"/>
      <value value="0.4"/>
      <value value="0.5"/>
      <value value="0.8"/>
      <value value="1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="avg-degree" first="4" step="2" last="22"/>
    <enumeratedValueSet variable="always-connect-communities?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="network-model">
      <value value="&quot;community&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="link-radius">
      <value value="1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="Reward" first="21" step="3" last="39"/>
    <enumeratedValueSet variable="noise">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stop-when-done?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="mean-path-length" repetitions="2" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1"/>
    <metric>mean-path-length</metric>
    <enumeratedValueSet variable="n-of-communities">
      <value value="16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="revision-frequency">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="n-of-nodes">
      <value value="512"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-rewiring">
      <value value="0.01"/>
      <value value="0.02"/>
      <value value="0.04"/>
      <value value="0.05"/>
      <value value="0.08"/>
      <value value="0.1"/>
      <value value="0.2"/>
      <value value="0.4"/>
      <value value="0.5"/>
      <value value="0.8"/>
      <value value="1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="avg-degree" first="4" step="2" last="20"/>
    <enumeratedValueSet variable="always-connect-communities?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="network-model">
      <value value="&quot;community&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="link-radius">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Reward">
      <value value="21"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="noise">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stop-when-done?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment Poging 22 aanvullingen" repetitions="22" sequentialRunOrder="false" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="5000"/>
    <metric>count turtles with [strategy = 1]</metric>
    <metric>count turtles with [strategy = 2]</metric>
    <metric>count turtles with [strategy = 3]</metric>
    <metric>count turtles with [strategy = 4]</metric>
    <metric>exit-code</metric>
    <metric>n-of-links</metric>
    <metric>avg-clustering-coefficient</metric>
    <metric>total-payoffs</metric>
    <metric>walking-average-payoff</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="n-of-communities">
      <value value="16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="revision-frequency">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="n-of-nodes">
      <value value="512"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-rewiring">
      <value value="0.01"/>
      <value value="0.02"/>
      <value value="0.04"/>
      <value value="0.05"/>
      <value value="0.08"/>
      <value value="0.1"/>
      <value value="0.2"/>
      <value value="0.4"/>
      <value value="0.5"/>
      <value value="0.8"/>
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg-degree">
      <value value="22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="always-connect-communities?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="network-model">
      <value value="&quot;community&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="link-radius">
      <value value="1"/>
    </enumeratedValueSet>
    <steppedValueSet variable="Reward" first="21" step="3" last="39"/>
    <enumeratedValueSet variable="noise">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stop-when-done?">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
