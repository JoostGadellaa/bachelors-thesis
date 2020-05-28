# A Networked Evolutionary Trust Game for the Sharing Economy


#### Joost Gadellaa
#### Utrecht University
#### Bachelor Thesis
#### Economics and Business Economics



## Abstract

In the sharing economy, trust is of higher importance than in regular B2C
interactions because there is no transfer of ownership and transactions sometimes
take place in private space. Chica et al. (2017) developed an evolutionary trust game
to unveil occurring dynamics and explain how trust could evolve in the sharing
economy. This thesis adds the variable of network structure for the network of
possible interactions to their model. Using agent-based modelling, the model is ran
on networks with varying levels of community structure, systematically varying
average degree, the community connectedness and game payoffs. We find negative
correlations for degree and it is suggested that having more isolated communities has
a positive effect on trust, but this is highly dependent on the reward for cooperating.
Chica et al. (2017) showed strong interdependence between players of different
strategies and found a strong influence of payoffs on the dynamics. The current
research shows that a strong interaction with network structure should also be
considered. The presented findings progress the field of evolutionary game theory, by
learning from a specific application. Furthermore, findings also suggest that sharing
economy platforms could enhance trust by emphasising or creating communities,
depending on the risk and how clear benefits are to users.

_Keywords_ : sharing economy, trust, evolutionary game theory, agent-based
modelling, simulation, network structure, community structure

## A Networked Evolutionary Trust Game for the Sharing Economy

For a long time, ownership was one of the fundamental constructs of
economics. Although shared consumption is as old as humankind (Belk, 2014), the
internet has removed barriers for bringing providers and consumers together in the
so-called sharing economy. It is estimated that by 2025, the global market size will
reach $335 billion (Lieberman, 2015). Despite this, the concept of the sharing
economy is not a homogeneous concept. It has been argued that the term is a
misnomer (Eckhardt & Bardhi, 2015) and different kinds of C2C transactions with a
social element have been labelled as sharing economy, causing inconsistency in the
literature (Habibi, Kim, & Laroche, 2016). In this paper, the following definition by
ter Hurne, Ronteltap, Corten, & Buskens (2017), will be used: “[The sharing economy
is] an economic model based on sharing under-utilised assets between peers without
the transfer of ownership, ranging from spaces, to skills, to stuff, for monetary or
non‐monetary benefits via an online mediated platform.”

The fact that transactions occur between peers, and that there is no transfer
of ownership make it require a considerable amount of trust (McNight & Chervany,
2001; Botsman 2012), and the ability to create and maintain trust is often identified
as one of the critical factors for a sharing platform’s success (Ufford, 2015; Strader &
Ramaswami, 2002). To examine the role, moderators and antecedents of trust in the
sharing economy, various methods have been used in the past. Mainly survey data,
but also case studies, econometric analysis, field interviews and experiments are
employed (Gefen, Benbasat, & Pavlou, 2014), each with their own limitations.

Chica, Chiong, Adam, Damas & Teubner (2017) were the first to introduce
the usage of evolutionary game theory (EGT) in an agent-based model (ABM) to
explore system dynamics and population end states for the spread of trust in the
sharing economy. They simulated virtual agents having sharing economy interactions
and showed that trust can be formed when benefits are high enough, except if the
ratio of trusting and trustworthy players is low from the start. Even when the reward
values are low, a situation of trust can still emerge as long as the starting population
included enough trusting and trustworthy players. This methodology of combining


EGT with ABM is relatively new to the field of economics, and gives new
possibilities: ABM can generate amounts of data, with exact control over ‘treatments’
simply impossible with experiments, and the fact that a simulation has to be
programmed requires the research to be very precise about assumptions. However,
Chica et al. (2017) limited the agents in the reach of their interactions by putting
them on an empirically observed email network. It is unknown to what extent the
specificities of that network could have influenced results. This thesis will build upon
their model and methods by adding network structure as a model variable, and
creating software which allows for visual inspection of the network over the course of
the simulation. The simulation will be run multiple times, on different network
structures, while keeping the number of nodes constant, extending this application of
EGT on the sharing economy.

This paper’s scientific contribution will thereby be twofold. Firstly, it
contributes to the development of a theoretical framework using EGT and ABM
combined with aspects from network science. Although the perspective from network
science has previously been used in the context of the sharing economy to explain the
spread of information (e.g. Buskens, 1998; Frey, Buskens, & Corten, 2019), research
on how the network structure affects emergence of trust in isolation of reputation and
communication is relatively new. In this line of theoretical research, all the other
methods of enhancing trust are omitted, and the only ‘motivation’ for fictional
players are the payoffs a trusting or trustworthy strategy can bring them. Developing
this experimental application to the sharing economy could advance the method as a
whole.

Secondly, because the game design is tailored to the sharing economy, this
research might result in new insights for sharing economy platforms on how to
enhance the aspect of trust that is influenced by network structure. Although there is
little data available, it can be theorised platforms have different networks of possible
and occurring connections. Determinants of structure could include selection based
on geography (e.g., in the case of tool or other small asset sharing), field of interest
(e.g., book swapping), sharing a destination (e.g., ride or home sharing), or homogeneity effects within the network as shown by Schor, Fitzmaurice, Carfagna,
Attwood-Charles, & Poteat (2016). Testing the effects of network structure on trust
in isolation of other means could help explain why trust spreads differently on
different platforms. Besides explanatory power, knowing about the extent to which
the spread and stability of trust are influenced by network structure could possibly
be used by platforms to enhance it.

To resemble a structure created by the selection and homogeneity described
above, this research will use networks with a community structure, a common
characteristic of networks (Girvan & Newman, 2002; Fortunato, 2010; Porter,
Onnela, & Mucha 2009). A community structure was also observed in the email-
network used by Chica et al. (2017) as foundation for their model (Guimera, Danon,
Diaz-Guilera, Giralt, & Arenas, 2003). In this structure, nodes are primarily
connected to peers in the same community, creating different highly clustered
communities, while a smaller part of the edges is in between communities.^1 There are
two reasons why this structure is particularly useful as a concept. Firstly, it is
relatively simple to comprehend and apply to the real world. Homophily and other
causes of clustering can be theorised or observed by an outsider without knowing the
exact network structure; the concept of linkage between them is also relatively easy
to grasp. The second reason is scalability. Because the number of edges changed from
intra-community to inter-community is a relative concept, unravelled dynamics could
possible apply to different scales. This ratio of edges changed will be referred to as
the variable ‘rewiring’ throughout this paper.

The research will proceed as follows. In section II, some theoretical
background and related work will be presented, followed by the technical details of
the model in section III. Section IV presents the setup of the experiments and their
results. Finally, conclusions are presented in section V, followed by some limitations,
implications, and possible directions for future research.

(^1) In the network science literature, an individual is referred to as a ‘node’. In game theory context the
individual is referred to as a ‘player’, while in the context of simulations it is often called an ‘agent’.
These refer to the same thing. A connection between two nodes is an ‘edge’.


### Background and Motivation

#### Trust in the Sharing Economy

As stated in the introduction, trust is a critical factor for the sharing economy.
Participants need to be sure that transaction partners do not behave
opportunistically and deviate from the agreement made. Because there is no transfer
of ownership, providers risk damage or misuse of their assets. Consumers, on the
other hand, usually do not have an established seller or governing institution to fall
back to in case the asset is not as promised. This uncertainty makes the effects and
likelihood of opportunism in C2C transactions more severe than in traditional B2C
interactions. Additionally, when a transaction involves co-usage (e.g., ride sharing,
renting out part of your house/couch), its quality is dependent on the experience
with the provider, adding an extra level of complexity, and more need for a trust
relationship between provider and consumer (Karlsson & Kemperman, 2017).

Common ways for platforms to create and maintain trust include binary or
scalar ratings (Teubner et al. 2017; Zervas et al. 2015), subsequent reviews about the
transaction (Abramova et al. 2015; Bridges and Vásquez 2016), host self-disclosure
by means of personal descriptions and pictures (Ma et al. 2017; Tussyadiah 2016; Ert
et al. 2016; Fagerstrøm et al. 2017; Teubner et al. 2014), or more formal measures
like insurance and identity verification.

However, even in the absence of these measures, trust and cooperation can
emerge. In the last two decades, the search for models accounting for complex
cooperation behaviour in social, economic and biological systems has inspired a new
body of interdisciplinary research that uses the methods of EGT (Smith & Price,
1973; Smith, 1998). EGT acknowledges the fact that the outcome of a system is more
than the sum of pairwise interactions; it dismisses the assumption of rationality and
introduces the concepts of a player population and player fitness. Fitness in this
context means the sum of payoffs for an individual received during games. In EGT,
successful behaviour spreads throughout the population by evolution, which is not
(necessarily) rational decision making. The evolution rule often entails that players
with unsuccessful strategies, and therefore a low fitness, die off, and get replaced by players with high fitness. The framework can also be used to simulate learning in an
unchanging population, as is done in the presented sharing economy model.

An insight from EGT very much applicable to this model, is that when
strategy distributions change, the relative fitness of the remaining strategies may also
change. The fitness landscape is not static, but it also evolves as the distribution of
strategies changes (Izquierdo, Izquierdo, & Sandholm, in press). On its own, this does
imply that Pareto-optimal strategies, which benefit the whole population (in this
model, being a trusting or trustworthy participant of the sharing economy), will
necessarily survive. Cooperating with another player has a risk, and being
opportunistic is often the best strategy in an isolated game, so a situation of trust
can be highly unstable, and a single player with an opportunistic strategy can make
the whole population move to a situation of distrust (Abbass, Greenwood, & Petraki,
2016). In order to explain how a situation of trust and cooperation can still emerge,
the topology of the community is considered.

#### Structure as a Solution

As explained above, it has become clear that in zero-dimensional systems,
where every player can interact with every other player, cooperation does seldom
emerge without any other incentives. This is why the network structure of
interactions should be considered. This idea already started with Nowak and May
(1992), who were the first to depart from well-mixed populations, and put simulated
agents playing prisoner-dilemma (PD) games in a two-dimensional space, where each
agent could only interact with eight direct neighbours. A phenomenon that became
visible is that the success of cooperative strategies often originated in the corners of
the space, suggesting some protection from the network can be beneficial. Since the
first exploration on a 2D grid, the emergence of network science as a discipline has
provided tools for further research, and it has become clear that being embedded in a
network structure of some sort can lead natural selection to select cooperative
behaviour in game theoretic models (Rand, Arbesman, & Christakis, 2011).


Some more expectations can be inferred from closely related research.
Simulations from Buskens & Snijders (2016), show that more centralisation^2 and less
segmentation increases payoffs in 2x2 coordination games in a limited part of the
reward space. Together with PD games, coordination games are the classic
abstraction used when talking about cooperation in a network structure (e.g., Ellison,
1993; Anderlini & Ianni, 1996). A characteristic of the coordination game is that
success is mostly dependent on the speed with which signals can propagate
throughout the network. This is why models with Small-World characteristics^3 are
successful: they display a shorter average path length and more synchronisability
(Watts and Strogatz, 1998; Watts, 1999). Both centralisation and degree^4 can
contribute to this, see Cassar (2007) for an overview of experimental evidence.

For social dilemmas, the speed with which signals or behaviour can travel
through the network might not be the only determinant of success. Various
theoretical approximations and simulations about the influence of network structure
on PD games have been carried out. Abramson & Kuperman (2001) varied a
structure from a regular ring lattice^5 to a completely random network and found a
positive relationship between the amount of rewiring towards randomness and the
number of defectors. Santos & Pacheco (2005) simulated snowdrift (SD) and PD
games, in which they found the first game to be significantly more successful on a
regular lattice than in a more random network. It is when expectations are inferred
for the sharing economy trust model that the main issue for this kind of research is
encountered: there is no mathematical framework to compare games, nor enough
ways to quantify network structure to approach these problems as an exact science.
Dynamics that occur in PD or SD games cannot be directly translated to the trust
game that is used as an abstraction for the sharing economy.

More complex game simulations that include the concept of individually placed trust instead of simultaneous cooperation like PD and SD games were carried out by Chica, Chiong, Kirley, & Ishibuchi (2018). They use an N-player trust game, closely resembling a public good game. Their first finding, in line with Abbass et al. (2016), is that strategies of trust never survive in an unstructured population. Since an untrustworthy player can interact with anybody, their distrust will spread quickly. Conversely, sparsely connected structures are better for the promotion of trust via social diversity in smaller clusters, in line with ideas from Santos, Santos, & Pacheco (2008). Both these sources use games with different strategy setups, that seem more dependent on the local neighbourhood than the simpler 2-player trust games used for the sharing economy, still, the idea that sparsely connected clusters increase performance is insightful for our application.

(^2) The existence of nodes that are situated on a lot of all possible shortest paths between nodes
(^3) Small World networks are a specific type of network structure with a high clustering, but a low
average path length, as first recognised and described by Watts & Strogatz (1998)
(^4) The number of edges a node has
(^5) A regular network with the highest possible clustering for each node, but also an high average path
length (Watts & Strogatz, 1998)

#### Community Structure

This research will use community structure as a starting point for variations in
the network. This idea is found in research from various disciplines, but not often in
the context of social dilemmas and trust. Fang, Lee, & Schilling (2010) introduced
the concept of community structure, and the rewiring between communities as
community connectedness, to explain why some companies are good at fostering
innovation. They present the subgroups as shelters for ideas, enabling them to
survive and show their success, rather than being extinguished through fierce
competition in the population as a whole. In biology, there are similar reasons to
believe a community structure can benefit cooperation. Theoretical and
computational works by Nowak and May (1992; 1993) and Nowak, Bonhoeffer, &
May (1994) predict and show behaviour where cooperators and defectors coexist in
clusters in the same network.

Prior to Chica et al. (2017), little research went into the specific dynamics
producing these end states, which they showed to be dependent on the payoffs and
starting distributions. It is difficult to draw expectations from other research because
little research combines varying degree, structure and payoffs within the same
simulation, while it could be suspected that these influence each other. This paper


might be the first to vary these three factors at the same time. Additionally, a
graphical user interface (GUI) makes it possible to explore the dynamics in even
more detail, by observing them in two-dimensional space, making more intuitive
understanding of observed results possible.

### The Networked Sharing Economy Model
The influence of the network structure of possible connections will be explored
using agent-based modelling (ABM), where agents are programmed to behave within
the framework of Evolutionary Game Theory (EGT). The simulation will run in
NetLogo, a modelling environment especially built for exploring behaviour in complex
systems using an agent-based approach. The basic premise of the simulation is as
follows: a constant population of agents with pure strategies are matched based on the
existence of a direct link within a network to play a trust game. After a certain
number of games, agents will revise their strategy, comparing their payoffs to those of
agents around them.

The details of the model as below are described mostly theoretically. Further
practical and technical details can be found in Appendix 1 and the simulation’s source
code (available upon request).

#### Game Definitions and Payoffs

Since this paper builds upon the first application of EGT for the Sharing Economy
by Chica et al. (2017), the game definitions of the trust game will be the same. This
social dilemma is characterised by a payoff structure in which the cooperative, Pareto-
optimal, combination is unstable because each individual could gain a higher or less
risky payoff when they choose a selfish alternative. The Provider is the trustor, while
the consumer is the trustee. The strategies and their real-world explanation for each
player are as follows:

- TP: a trusting provider who delivers an asset as agreed upon.
- UP: an untrusting provider who does not deliver, causing a small negative
payoff for the consumer and a small positive payoff for themselves.
- TC: a trustworthy consumer who uses the asset decently.
- UC: an untrustworthy consumer, who misuses the asset, e.g., by damaging
or stealing it, causing damage to the owner and a high payoff for themselves.

Table 1 #TODO

_Payoffs in the Sharing Economy Trust Game_

_Note._ When players interact with an agent with the same role (i.e., provider or
consumer), no transaction takes place, and the added payoff is 0.
*By definition, the minimum and maximum rewards are 21 and 39 respectively,
because of the game’s definition by Chica et al. (2017)

Different payoffs likely change the evolutionary dynamics via the ‘difficulty’ or
temptation to defect in the game (Chica et al., 2017; Chica et al. 2018), so the
reward for cooperation will be one of the variables in the model. The reward value R
will be varied covering this games’ easy (39, 36), moderate (33, 30, 27) and hard (24,
21) spectrum, as identified by Chica et al. (2017).

It should be noted, however, that the non-sequential play and lack of
communication make the game designed by Chica et. al. (2017) different from most
trust games in the literature, so comparison to other trust games should be done with
care. Further justification can be found in their paper.

#### Strategy Update

Agents adjust their strategies simultaneously after 50 games via an algorithm
that simulates evolution. For this, the proportional imitation rule (Helbing, 1992) will
be used. This update heuristic is in line with the idea of bounded rationality and
incomplete information for an agent since it considers limited memory, and
knowledge only about the payoffs of direct network neighbours (Schlag, 1996).
During the strategy update procedure, an agent will first randomly select a


Providers Consumers #TODO
TC UC
TP R, R* -20, 40
UP 10, -10 10, -


neighbour to compare their strategy and payoffs during the previous rounds. If the
selected neighbour had a higher total payoff, the revising agent copies the selected
agent’s strategy with a certain probability. This probability is equal to the difference
between their payoffs in the previous 50 games, divided by the maximum
theoretically possible difference (in these scenarios this is the difference between 50 *
R and 50 * -20). The arbitrary structure of 50 games before reconsidering the
strategy will be used for comparability with the trust experiment using EGT by
Chica et al. (2017).

#### Generating the Networks

Although some data is available on network structures of occurred
transactions on sharing economy platforms (e.g., Teubner 2018), it is of limited use,
since this paper is about the network of possible connections, as opposed to the
transactions that have occurred in the past. Besides that, the network data in the
literature is often from Airbnb, which has a more traditional provider-consumer
structure (Cox 2017; Wired 2017). This structure is, although not precluded,
inconsistent with the definition of sharing economy used here. Because of this, this
research will use theoretical approximations of real-world networks.

For this paper, a custom algorithm for generating networks with a community
structure was programmed. First, it assigns every node a ‘community’ and randomly
picks the required nodes within the same community to connect. It is important to
note that this random assignment of community is entirely independent of all other
randomnesses in the model, like which edges are rewired or which initial strategy is
assigned to a node. After the edges within the community have been formed, each
edge will be rewired to a random node with the required probability determined by
the level of community connectedness. When connectedness equals one, the result is a
completely random network. In all other cases, the algorithm will result in a network
with community structure, as can be detected with the conventional Girvan &
Newman (2002) algorithm.


_Figure 1._ Example network layouts coloured by community with rewiring probability
0.04 (left) and 0.4 (right) and average degree 4 (top) and 14 (bottom).

### Experiments and Results
All results were obtained from simulations with a population of 512 agents,
spread across 16 communities. Preliminary testing and analysis showed that this
network size is large enough to ensure reasonable robustness and representative
results at any combination of variables while being small enough to compute all
simulations within the available timeframe.


This paper focusses on effects of average degree (D) and the amount of intra-
community edges rewired to be inter-community after the initial communities have
been set up (P). This value of P covers the concept of community connectedness. No
available quantification of this concept of connectedness includes a scale, but in these
experiments, a continuous range of network structures is created by varying the
probability of rewiring edges between 0.01 and 1, creating a continuous range from
communities connected to each other with a minimal amount of inter-community
edges to a completely random network.

#### Experimental Setup

For each network, ‘success’ will be measured by summing all the payoffs
gained during the simulation. A network that sustainably supports cooperation will
gain high payoffs for a long time, while payoffs in a network with little trust present
will quickly reach a state of low payoffs, or no transactions at all. From Chica et al.,
it is known that dynamics within this trust game can be vastly different for different
payoff ratios. Because of this, the reward value (R) will be varied in interaction with
the degree and rewiring, covering this games’ easy (39, 36), moderate (33, 30, 27)
and hard (24, 21) spectrum, as identified by them in their 2007 paper.

During preliminary testing, it was discovered that payoffs are most sensitive to
rewiring when rewiring is low, so an exponential scale was chosen, testing relatively
more values close to 0. Degree was started at 2 and tested up until 22 in steps of 2.
Although this is not the limit of the variable space in which simulations end
successful, an arbitrary limit had to be chosen. This leads to the following
combination of variables: Reward (R) is varied [21, 24, 27, 30, 33, 36, 39], degree (D):
[2, 4, 6, 8, 10, 12, 16, 18, 20, 22] and rewiring (P): [0.01, 0.02, 0.04, 0.05, 0.08, 0.1,
0.2, 0.4, 0.5, 0.8, 1] for a total of 770 possible combinations.

Because of randomness in the assignment of communities, rewiring of links
and strategy evaluation, the simulation is non-deterministic. To approach the mean
value for average total payoffs, every combination is repeated for at least 32
independent runs. With a very regular desktop PC, this took multiple days of non-
stop simulations to compute, but with further code optimisation and access to a high


performance computing cluster optimised for these kinds of calculations, the time
could be a fraction of that.

#### Analysis of the Results

First, some general remarks about the dynamics will be presented.
Particularly on the ‘balancing effect’ that occurs in this game, presented by Chica et
al. (2017). Thereafter, some specific areas in the tables of results will be highlighted,
and further interpreted by looking at the details of some specific runs. This
‘anecdotal’ evidence is difficult to quantify but is in line with the exploratory nature
of this research.

##### Remarks on dynamics.
The balancing effect seems to be present to a certain extent at almost all variable combinations. This general pattern can be
summarised as follows: at first, players with a UC strategy profit from their
opportunistic behaviour, making their strategy spread. As a ‘response’ to this, UP
players, a safe and risk-less strategy not affected by UC^6 , become a substantial group
within the population, driving out TP and TC, but most importantly UC. Agents
with strategy UC cannot profit from agents with strategy UP. When a particular
distribution (the flipping point is highly dependent on payoffs) is reached, TP and
TC slowly regain ground. The playing field is now less risky with UC mostly or
entirely gone. TP only forms a small risk to them, and they profit highly from the
presence of each other. This balancing effect can be observed both at the community
level or for the whole network at the same time when it is more connected.

Agents switching to an UP strategy could be interpreted as not partaking in
the network’s sharing economy at all; they are not risking to provide their asset and
pick a certain but low payoff. At the micro level, we can see why this is a neutral
context for TP and TC to spread. TP’s influences are not affected by UP because
they are both providers, and a TC can on average handle two to four times more
UC’s than TC’s in order to still have a non-negative payoff. Another important fact is that TC and TP’s payoffs are equal after a successful transaction, ensuring one
does not become too much more successful in the network than the other, while in
‘hostile’ situations TP has slightly higher average payoffs than TC, spreading slightly
more quickly, thereby creating a more favourable context for TC.

_Figure 2._ An example run that clearly contains the balancing dynamic as described
by Chica et al. (2017) (D = 8, P = 0.01, R = 27).

However, looking at some of the runs in detail, it is observed that below 27
the success is dependent on complete absence of UC-players in the network. Because
of the chosen strategy update rule, a strategy can never reoccur after having gone
‘extinct’. This is good for the spread of trust, but problematic for drawing
implications, since it could make the simulation end in a state that would
immediately collapse when a single untrustworthy agent would be re-introduced.
Only when R >= 27 some simulations end in situations of high payoffs for the
network without the complete absence of UC players. This same rule also gives issues
in some highly connected and dense structures, but then because TC (or TP)
completely disappears from the network before the strategy distribution is ‘friendly’
enough for them to flourish. This shows that the update rule chosen by Chica et. al.
(2017) might not be suitable in a certain part of the reward space. A possible
solution for this will be discussed in section V.

In general, community structure, compared to complete randomness and other
structures (not covered in tables) spread the risk of a run, as a portfolio of different gambles. Even in low payoffs, one community can develop a situation of trust, which
will always spread as long as other communities are neutral enough. Neutral in this
context means having a majority of UP players, which TP and TC do not lead
significant losses against. Community structure can also protect the network: if one
community has an ‘outbreak’ of opportunism, depending on the other factors, it can
be ‘dealt with’ within the community, i.e, walk through the Balancing effect on a
small scale, while not influencing the rest of the network.

_Figure 3._ An example network visualisation in which the effect of community
separation is visible (D = 8, P = 0.05, R = 30, time-step = 250).


_Figure 4._ Observed average payoffs for a specific combination of degree D (y-axis)
and rewiring P (x-axis), grouped in blocks by reward value (value in upper-left
corner of each block). The reported numbers are the average payoffs of all agents
together (in millions), over at least 32 runs, coloured relative to the other results
with the same reward R (left) or relative to all results (right).

(^6) Throughout this research, players with a certain strategy will be referred to by the name of their
strategy. Keep in mind, however, that it is not the strategy that evolves, but the players who ‘decide’
to use a strategy or not, based on its relative success.

##### Analysis of end states.
Observed average payoffs for a specific combination of degree D (y-axis) and rewiring P (x-axis), grouped in blocks by reward value
(upper-left corner of each block). The reported numbers are the average payoffs of all
agents together (in millions), over at least 32 runs, coloured relative to the other
results with the same reward R (left) or relative to all results (right).

In figure 4, the observed average payoffs for a specific combination of degree D
(Y-axis) and rewiring P (X-axis) are shown, grouped in blocks by reward value. The
reported numbers are coloured relative to the other results with the same value for R
(left) or relative to all results (right). Higher average payoffs indicate a network had
many agents with TC and TP strategies trading with each other. End states with a
degree of 2 were omitted because the network was too often split up in multiple
networks by rewiring. Networks splitting was also an issue at D = 4, where total
payoffs are lower because disconnected agents did not always have a trading partner.
This is most clearly visible in the tables when the reward is equal to 39.

In the tables, especially the right-hand table where colour is relative to all
achieved payoffs, patterns related to the three variables can be visually identified: In
all reward spaces, degree seems to have a negative correlation with the total average
payoff. Secondly, a negative correlation to the level of rewiring can be distinguished,
most clearly in the moderate-high reward areas. Thirdly, higher rewards expectedly
led to higher payoffs, but at R = 39 the interaction with degree and rewiring
suddenly changes, as is visible in the left-hand column of tables. The last part of this
analysis will dive into these three patterns in more detail.

Looking at the role of degree in more detail, we see a consistent effect at the
level of the individual agent. A high value for D makes it harder for trustworthy
behaviour to survive in thesimulations. As soon as an UC is able to reach one or
more TP’s, their opportunistic behaviour can quickly spread. A lower number of
edges means UC’s cannot spread as effective, and have a higher likelihood of being
stopped somewhere either by ‘running into’ a group of UP’s, or by not being able to
spread to a node because it is highly successful in its trade with other trusting and
trustworthy agents.


The effect of rewiring seems to depend highly on the value of R, i.e., how
‘hard’ the game is. For low rewards, higher connectedness makes for quicker
extinctions, which is the only way to success (if UC goes extinct) or failure (when TC
or TP goes extinct) for this area of variables. In figure 5, two runs with the same
setup conditions are shown, to illustrate the two only occurring courses of a
simulation in this variable space. The complete dependence on the extinction of UC
is a risky dynamic for reaching a situation of complete trust, but apparently, it is not
influenced much by the structural specifics, mostly just the randomness in the initial
placement of strategies and the element of chance in the strategy selection. This area
should not be considered for real-world implications since this extinction-dependency
might be very unrealistic.

_Figure 5._ The two occurring courses of a simulation in the low reward-space (D = 16,
P = 0.01, R = 24).


_Figure 6._ The visible chaos in moderate reward values for three different amounts of
rewiring from low to high (D = 16, P = 0.01 (top) 0.1 (middle) 1 (bottom), R = 24).


For medium values of R, the situations become more chaotic, and rewiring
seems to increase this chaos. The network does not go through the balancing effect as
a whole since some communities can be thriving purely based on higher payoffs if the
amount of trust is high from the start by random assignment. Because higher
rewards make complete extinction of UC no longer a necessity, communities can have
successful interactions before the rest of the network does. Balancing happens locally,
which makes the structure more important. This clear distinction for medium
rewards might explain some of the results observed by Chica et al. (2017) around an
R of 27, where end states seemed to be inconsistent with other trends. When
communities are not very connected, they will find a stable situation on their own,
often by complete extinction of UC. The fact that communities change independent
of others is visible in the top pattern in fig. 6, where fluctuations are in steps of
1/16th of the Y axis, corresponding to one or more communities at a time. When a
community is thriving, the low connectedness makes for a protected situation where
opportunistic behaviour cannot reach the community. In more connected
communities, UC’s from a single community can repeatedly spread towards other
communities. This, combined with the fact that communities started to thrive before
UC went extinct, causes continuous fluctuations in strategies across the network.

In the situation of high rewards, the effect of rewiring becomes more
predictable. The ‘easy’ nature of the game causes the payoffs gained by trusting and
trustworthy behaviour to be the primary driver of success, without much need for the
balancing dynamic for the whole network. Less rewiring benefits the development of
trust by making individual communities ‘find’ the quickest way to success for them.
It seems as though the separation of the network makes this more efficient because
each community goes through the dynamic that is relevant for their initial
distribution of strategies: sometimes a quick balancing dynamic, or a slower decrease
of opportunistic behaviour via higher payoffs gained by TP and TC if possible.
Because the network does not have to do this as a whole, it is quicker.


_Figure 7._ A typical simulation run in with high rewards, with only a small balancing
dynamic visible, and an equilibrium with UC agents present (D = 16, P = 0.1, R =
36).

A seemingly strange pattern is observed when looking at the table for R = 39
in the left-hand column, where payoffs are coloured relative to the other average
payoffs with the same reward. The pattern seems to have ‘flipped’ on the rewiring
axis, compared to the tables for other reward values.^7 When observing the right-hand
version, it can be seen that these differences are minimal, and not noticeable relative
to other reward values. Looking at some simulations in more detail, the following
explanation can be found: both reasoning about extinction or protection by the
community do not apply here. The game is in favour of agents with a strategies of
trust to the point that the only important thing is how fast these strategies can
spread. Confirming to dynamics described in the very first paper on small-world
networks by Watts & Strogatz (1998), signal propagation is quicker on networks
approaching random networks.

(^7) The low payoffs at D = 4 are because of parts of the network disconnecting when rewired, as
mentioned at the beginning of this section.

### Concluding Remarks and Future Work
This paper built upon the novel evolutionary trust game from Chica et al.
(2017) by adding the dimension of network structure, specifically average degree and
connectedness between communities in a community network. It has become clear that the network structure can have substantial effects on the success of a sharing
economy network. Additionally, it was found that the rewards in the game do not
only influence end states, but also influence dynamics and the effect of other
variables. Clearly, this type of exploration cannot be done with many variables kept
constant. Because of the strong interactions between variables, exact quantification of
interaction is necessary. The latter is currently impossible because of the lack of
mathematical frameworks in this area.

The presented sharing economy trust model consists of 512 agents, arranged in
16 communities, where the degree and amount of edges rewired from inter-
community to a random agent were systematically varied together with the reward
for cooperation in the trust game. Each agent could choose to be a provider or
consumer and to be trusting/trustworthy or not, evaluating every 50 games,
simulating the evolution of chosen strategies over time.

These computational experiments suggested that more isolated communities
could be a safe place to start the formation of trusting behaviour. It possibly also
prevents opportunistic behaviour from spreading to the rest of the network quickly.
In line with previous research on social dilemma-games, a higher number of
individual connections makes an agent more vulnerable to opportunism, thereby
decreasing the total payoffs for the network when the average degree is higher.
Looking at the effect of community connectedness, it was discovered that the
simulation is especially sensitive to the amount of rewiring in the lower rewiring
values. The effects of this variable turned out to be highly dependent on the chosen
reward in the trust game. As expected, higher rewards in the trust game create
resilience to opportunistic behaviour, independent of other variables.

The balancing effect discovered by Chica et al. (2017) was present in many of
the simulations and was essential to the development of successful interactions when
rewards were low. This occurrence of the dynamic does, however, create the
unrealistic situation of complete extinction of strategies, which deteriorates their
game’s real-world application value. This problem became visible because of the
visual user-interface available in this paper’s simulation.


Although the value of this application to the sharing economy is mainly in the
advancement of knowledge about the used theoretical frameworks by finding their
limitations in these situations, some of the results could be extrapolated to findings
relevant for sharing economy platforms. Firstly, it is important for platforms to know
how ‘hard’ their interactions are. In the case that transactions are high in risk, it
could be beneficial to limit the amount of different people an individual can interact
with at first. When the benefits of a platform are obvious, and risks are low, the
platform could benefit from bringing together people who wouldn’t normally do so,
to effectively create bridges in the network. Secondly, this research suggests that
fostering the community structure of a platform could be beneficial. Often, platforms
serve a user with multiple possible providers to have a transaction with, and a
‘recommender system’ decides which options to show you first (Grbovic, 2017). Since
recommendation algorithms include deliberate choices by the platform, it can be used
to influence the structure of the occurring transactions network. Another possibility
is explicitly highlighting characteristics of the underlying network structure to the
user (e.g., friends in common, others you both had a transaction with), to increase
the level of trust, like Airbnb is already doing (Airbnb 2011).

This thesis is part of the balance that has to be found between developing
theoretical frameworks on the one hand, while applications on the other hand do not
have to wait until the theory is fully mature, so they can drive the theory forward.
Especially agent-based simulations with a GUI, like the one used here, can have a big
educational value. This does, however, mean that some limitations have to be
considered when interpreting the results. For network structure, it is unknown what
actual networks of possible interactions look like, or how they relate to the
observable networks of occurring transactions. The number of transactions of agents
might very well follow a power-law distribution in terms of weight or centrality
(Teubner, 2017). Other network structures could also include a more rigid distinction
between players who can provide an asset and those who cannot, or the possibility
for players to create or delete links between them, creating a dynamic graph (Rand,
Arbesman, & Christakis, 2011). These options can be considered for future research.


Considering the other components of the game, the chosen game structure and
evolution rule might not be the best abstract representation of reality. This paper’s
findings highlight a major issue with the proportional imitation rule: the fact that
strategies can completely disappear from the simulated world, a very unrealistic
situation. There exists a trade-off between simplicity and realism, but a simple way
to address this issue would be the introduction of noise to the simulation: a small
chance of random mutation for each agent. Other alternatives that can be considered
include evaluation rules in which agents memorise previous payoffs and strategies,
either increasing knowledge about their past state or the network as a whole.

This thesis also presented a unique way of reporting data in a
multidimensional behaviour-space, using heat maps to find areas of interest in an
abundance of data. With the computing power of current consumer hardware, ABM
provides a way to generate amounts of data previously impossible without high-
performance computing clusters (and therefore seldom viable). This requires new
ways of interpreting and visualising results. Future possibilities for this kind of
research include generating data including even more variables. Artificial intelligence
and other methods from so-called ‘big data’ research could be used to find patterns
and dynamics. Taking this even further, simulation as a method could be developed
into a complete representation of both micro- and macroeconomics, creating a form
of Agent-Based Computational Economics (Tesfatsion, 2002).



## References

Abbass, H., Greenwood, G., & Petraki, E. (2016). The N-Player Trust Game and its
Replicator Dynamics. IEEE Transactions on Evolutionary Computation,
20(3), 470–474. https://doi.org/10.1109/TEVC.2015.2484840

Abramova, O., Shavanova, T., Fuhrer, A., Krasnova, H., & Buxmann, P. (2015, May
28). Understanding the Sharing Economy: The Role of Response To Negative
Reviews in the Peer-to-Peer Accommodation Sharing Network. Retrieved from
https://www.researchgate.net/publication/277597462

Abramson, G., & Kuperman, M. (2001). Social games in a social network. Physical
Review E, 63(3), 030901. https://doi.org/10.1103/PhysRevE.63.030901

Airbnb. (2019). What is the Social Connections feature? Retrieved 23 June 2019,
from Airbnb website: https://www.airbnb.com/help/article/198/what-is-the-
social-connections-feature

Anderlini, L., & Ianni, A. (1996). Path Dependence and Learning from Neighbors.
Games and Economic Behavior, 13(2), 141–177. https://doi.org/10.1006/
game.1996.0032

Belk, R. (2014). You are what you can access: Sharing and collaborative consumption
online. Journal of Business Research, 67(8), 1595–1600. https://doi.org/
10.1016/j.jbusres.2013.10.001

Botsman, R. (2012). The currency of the new economy is trust. Retrieved from
https://www.ted.com/talks/
rachel_botsman_the_currency_of_the_new_economy_is_trust

Bridges, J., & Vásquez, C. (2018). If nearly all Airbnb reviews are positive, does that
make them meaningless? Current Issues in Tourism, 21(18), 2057–2075.
https://doi.org/10.1080/13683500.2016.1267113

Buskens, V. (1998). The social structure of trust. Social Networks, 20(3), 265–289.
https://doi.org/10.1016/S0378-8733(98)00005-7


Buskens, V., & Snijders, C. (2016). Effects of Network Characteristics on Reaching
the Payoff-Dominant Equilibrium in Coordination Games: A Simulation study.
Dynamic Games and Applications, 6(4), 477–494. https://doi.org/10.1007/
s13235-015-0144-4

Cassar, A. (2007). Coordination and cooperation in local, random and small world
networks: Experimental evidence. Games Econ. Behav. Retrieved from
https://doi.org/10.1016/j.geb.2006.03.008

Chica, M., Chiong, R., Adam, M. T. P., Damas, S., & Teubner, T. (2017). An
evolutionary trust game for the sharing economy. 2017 IEEE Congress on
Evolutionary Computation (CEC), 2510–2517. https://doi.org/10.1109/CEC.
2017.7969610

Chica, M., Chiong, R., Kirley, M., & Ishibuchi, H. (2018). A Networked ${N}$ -
Player Trust Game and Its Evolutionary Dynamics. IEEE Transactions on
Evolutionary Computation, 22(6), 866–878. https://doi.org/10.1109/TEVC.
2017.2769081

Cox, M. (2019). Inside Airbnb. Adding data to the debate. Retrieved 13 June 2019,
from Inside Airbnb website: [http://insideairbnb.com](http://insideairbnb.com)

Eckhardt, G. M., & Bardhi, F. (2015). The Sharing Economy Isn’t About Sharing at
All. Harvard Business Review. Retrieved from https://hbr.org/2015/01/the-
sharing-economy-isnt-about-sharing-at-all

Ellison, G. (1993). Learning, Local Interaction, and Coordination. Econometrica,
61(5), 1047. https://doi.org/10.2307/2951493

Ert, E., Fleischer, A., & Magen, N. (2016). Trust and reputation in the sharing
economy: The role of personal photos in Airbnb. Tourism Management, 55,
62–73. https://doi.org/10.1016/j.tourman.2016.01.013

Fang, C., Lee, J., & Schilling, M. A. (2010). Balancing Exploration and Exploitation
Through Structural Design: The Isolation of Subgroups and Organizational
Learning. Organization Science, 21(3), 625–642. https://doi.org/10.1287/orsc.
1090.0468


Fortunato, S. (2010). Community detection in graphs. Physics Reports, 486(3), 75–

174. https://doi.org/10.1016/j.physrep.2009.11.002

Frey, V., Buskens, V., & Corten, R. (2019). Investments in and returns on network
embeddedness: An experiment with trust games. Social Networks, 56, 81–92.
https://doi.org/10.1016/j.socnet.2018.07.006

Gefen, D., Benbasat, I., & Pavlou, P. A. (2008). A Research Agenda for Trust in
Online Environments. Journal of Management Information Systems, 24(4),
275–286. Retrieved from JSTOR.

Girvan, M., & Newman, M. E. J. (2002). Community structure in social and
biological networks. Proceedings of the National Academy of Sciences, 99(12),
7821–7826. https://doi.org/10.1073/pnas.122653799

Goes, P. B. (2013). Editor’s Comments: Information Systems Research and
Behavioral Economics. MIS Q., 37(3), iii–viii.

Grbovic, M. (2017). Search Ranking And Personalization at Airbnb. Proceedings of
the Eleventh ACM Conference on Recommender Systems, 339–340. https://
doi.org/10.1145/3109859.3109920

Guimera, R., Danon, L., Diaz-Guilera, A., Giralt, F., & Arenas, A. (2003). Self-
similar community structure in organisations. Physical Review E, 68(6),

065103. https://doi.org/10.1103/PhysRevE.68.065103

Habibi, M. R., Kim, A., & Laroche, M. (2016). From Sharing to Exchange: An
Extended Framework of Dual Modes of Collaborative Nonownership
Consumption. Journal of the Association for Consumer Research, 1(2), 277–

294. https://doi.org/10.1086/684685

Helbing, D. (1992). Interrelations between Stochastic Equations for Systems with
Pair Interactions. Physica A: Statistical Mechanics and Its Applications,
181(1–2), 29–52. https://doi.org/10.1016/0378-4371(92)90195-V

Izquierdo, L. R., Izquierdo, S. S., & Sandholm, W. H. (2018). An Introduction to
ABED: Agent-Based Simulation of Evolutionary Game Dynamics. 58.


Izquierdo, L. R., Izquierdo, S. S., & Sandholm, W. H. (in press). Agent-Based
Evolutionary Game Dynamics. Retrieved from https://wisc.pb.unizin.org/
agent-based-evolutionary-game-dynamics/

Karlsson, L., Kemperman, A., & Dolnicar, S. (2017). May I sleep in your bed?
Getting permission to book. Annals of Tourism Research, 62, 1–12. https://
doi.org/10.1016/j.annals.2016.10.002

Katz, M. (2017). A Lone Data Whiz Is Fighting Airbnb — and Winning. Wired.
Retrieved from https://www.wired.com/2017/02/a-lone-data-whiz-is-fighting-
airbnb-and-winning/

Lieberman, M. (2015). PWC Consumer Intelligence Series: The Sharing Economy (p.
30). Retrieved from PricewaterhouseCoopers website: https://www.pwc.com/
us/en/technology/publications/assets/pwc-consumer-intelligence-series-the-
sharing-economy.pdf

Ma, X., Hancock, J. T., Lim Mingjie, K., & Naaman, M. (2017). Self-Disclosure and
Perceived Trustworthiness of Airbnb Host Profiles. Proceedings of the 2017
ACM Conference on Computer Supported Cooperative Work and Social
Computing - CSCW ’17, 2397–2409. https://doi.org/10.1145/2998181.2998269

McKnight, D. H., & Chervany, N. L. (2001). What Trust Means in E-Commerce
Customer Relationships: An Interdisciplinary Conceptual Typology.
International Journal of Electronic Commerce, 6(2), 35–59. Retrieved from
JSTOR.

Nowak, M. A., Bonhoeffer, S., & May, R. M. (1994). More spatial games.
International Journal of Bifurcation and Chaos, 04(01), 33–56. https://
doi.org/10.1142/S0218127494000046

Nowak, M. A., & May, R. M. (1992). Evolutionary games and spatial chaos. Nature,
359(6398), 826–829. https://doi.org/10.1038/359826a0

Nowak, M. A., & May, R. M. (1993). The spatial dilemmas of evolution.
International Journal of Bifurcation and Chaos, 03(01), 35–78. https://
doi.org/10.1142/S0218127493000040


Pinsonneault, A., & Kraemer, K. L. (1993). Survey Research Methodology in
Management Information Systems: An Assessment. Journal of Management
Information Systems, 10(2), 75–105. Retrieved from JSTOR.

Porter, M. A., Onnela, J.-P., & Mucha, P. J. (2009). Communities in Networks.
ArXiv:0902.3788 [Cond-Mat, Physics:Nlin, Physics:Physics, Stat]. Retrieved
from [http://arxiv.org/abs/0902.3788](http://arxiv.org/abs/0902.3788)

Rand, D. G., Arbesman, S., & Christakis, N. A. (2011). Dynamic social networks
promote cooperation in experiments with humans. Proceedings of the National
Academy of Sciences, 108(48), 19193–19198. https://doi.org/10.1073/pnas.
1108243108

Santos, F. C., & Pacheco, J. M. (2005). Scale-Free Networks Provide a Unifying
Framework for the Emergence of Cooperation. Physical Review Letters, 95(9),

098104. https://doi.org/10.1103/PhysRevLett.95.098104

Santos, Francisco C., Santos, M. D., & Pacheco, J. M. (2008). Social diversity
promotes the emergence of cooperation in public goods games. Nature,
454(7201), 213–216. https://doi.org/10.1038/nature06940

Schlag, K. H. (1998). Why Imitate, and If So, How?: A Boundedly Rational
Approach to Multi-armed Bandits. Journal of Economic Theory, 78(1), 130–

156. https://doi.org/10.1006/jeth.1997.2347

Schor, J. B., Fitzmaurice, C., Carfagna, L. B., Attwood-Charles, W., & Poteat, E. D.
(2016). Paradoxes of openness and distinction in the sharing economy. Poetics,
54, 66–81. https://doi.org/10.1016/j.poetic.2015.11.001

Smith, J. Maynard, & Price, G. R. (1973). The Logic of Animal Conflict. Nature,
246(5427), 15. https://doi.org/10.1038/246015a0

Smith, John Maynard. (1998). The origin of altruism. Nature, 393(6686), 639.
https://doi.org/10.1038/31383


Strader, T. J., & Ramaswami, S. N. (2002). The value of seller trustworthiness in
C2C online markets. Communications of the ACM, 45(12), 45–49. https://
doi.org/10.1145/585597.585600

ter Huurne, M., Ronteltap, A., Corten, R., & Buskens, V. (2017). Antecedents of
trust in the sharing economy: A systematic review. Journal of Consumer
Behaviour, 16(6), 485–498. https://doi.org/10.1002/cb.1667

Tesfatsion, L. (2002). Agent-Based Computational Economics: Growing Economies
From the Bottom Up. Artificial Life, 8(1), 55–82. https://doi.org/
10.1162/106454602753694765

Teubner, T. (2018). The web of host–guest connections on Airbnb: A network
perspective. Journal of Systems and Information Technology, 20(3), 262–277.
https://doi.org/10.1108/JSIT-11-2017-0104

Teubner, T., & Adam, M. T. P. (2014, December). Understanding Resource Sharing
in C2C Platforms: The Role of Picture Humanization. 10. Auckland, New
Zealand.

Teubner, T., Hawlitschek, F., & Dann, D. (2017). Price Determinants on Airbnb:
How Reputation Pays Off in the Sharing Economy. Journal of Self-Governance
and Management Economics, 5(4), 53. https://doi.org/10.22381/JSME5420173

Tussyadiah, I. P. (2016). Strategic Self-presentation in the Sharing Economy:
Implications for Host Branding. In A. Inversini & R. Schegg (Eds.),
Information and Communication Technologies in Tourism 2016 (pp. 695–708).
https://doi.org/10.1007/978-3-319-28231-2_50

Ufford, S. (2015, February 10). The Future Of The Sharing Economy Depends On
Trust. Retrieved 23 June 2019, from Forbes website: https://www.forbes.com/
sites/theyec/2015/02/10/the-future-of-the-sharing-economy-depends-on-trust/

Watts, D. J. (1999). Networks, Dynamics, and the Small‐World Phenomenon.
American Journal of Sociology, 105(2), 493–527. https://doi.org/
10.1086/210318


Watts, D. J., & Strogatz, S. H. (1998b). Collective dynamics of ‘small-world’
networks. Nature, 393(6684), 440. https://doi.org/10.1038/30918

Zervas, G., Proserpio, D., & Byers, J. (2015). A First Look at Online Reputation on
Airbnb, Where Every Stay is Above Average. SSRN Electronic Journal.
https://doi.org/10.2139/ssrn.2554500


```
Appendix A
```
The structure of the simulation and some of the specificities are from the
ABED-1pop framework (Izquierdo, Izquierdo, & Sandholm, 2018), published under
the GNU General Public License. The network statistics and layout procedures are
from a code snippet sent by Luis R. Izquierdo, whom I would like to thank for his
encouragement and helpful directions at the start of my programming endeavour.
Many of the methods and my general ability to program in NetLogo came from the
book “Agent-Based Evolutionary Game Dynamics” by Izquierdo, Izquierdo, &
Sandholm (in press). The code is specific to its application, and readability was often
prioritised over flexibility. No warranty of merchantability or fitness for a particular
purpose is implied.

```
The GUI is further explained below:
A. The network settings. Only community structure is used in this paper, but
some of NetLogo’s build in structures like the Small-World network are also
available. With sliders, he number of nodes, the average degree and the
probability for rewiring can be changed.
B. Community settings. Including the number of communities and whether or
not they should always be connected. This optional procedure makes sure all the
communities have at least one link to another community, even when the
community connectedness is zero. This is used in all the simulations in this paper,
to present results about one single network and prevent changes in network size
across variations of the other variables. This does, however, rewire additional
edges, resulting in an increase in intra-community edges corresponding to an
increase of the effective connectedness between 0.0002 and 0.004 for the presented
experimental setup.
C. Payoff settings. Reward can be varied with a slider, all other payoffs can
also manually be adjusted in the 4x4 array.
```

_Figure 7._ An overview of the GUI developed and used for this paper’s simulations.

```
D. Network actions. Setup sets the initial network up in a basic layout, which
can be further adjusted by ‘relaxing’ the network or manually by dragging and
dropping nodes. The relax-network procedure makes nodes move according to
their amount of edges and how far the connected nodes are away, creating an
organic looking layout.
```

E. Simulation actions. To start the situation continuously or watch it step by
step. A simulation can also be reset without changing the network. The ‘exit-
code’ reports if a network has reached a stable state (no-trust or only-trust).
While gathering of data, a simulation was only run for 16 more steps after
reaching a stable state to save time. 16 more steps was found to be enough to
estimate the payoffs for the rest of the simulation, since they merely fluctuating
around a mean after an equilibrium has been reached.

F. The main visualisation. Nodes have a colour and label corresponding to
their strategy, all visually updated after every strategy evaluation. This is what
made this program unique, and enabled in depth visual inspection of occurring
dynamics. With the ‘say-cheese’ procedure, nodes can be coloured by community,
and put agains a white background, better for taking screenshots.

G.Reporters of strategy quantity and payoffs gained. The upper graph
reports the presence of strategies, the bottom one does the same, but in a clearer
stacked bar chart. Payoffs during a round and cumulative payoffs are reported to
see changes in ‘success’ over time. All graphs automatically adjust their scale to
fit the data or can have fixed dimensions to export screenshots.

H. Reporters about the network structure. This includes the actual degree,
degree distribution, clustering coefficient, wether or not a network was split up
and the total number of links. Statistics about the nodes reached within one or
more degrees of separation can be seen by adjusting the link radius for which the
statistics are calculated.
