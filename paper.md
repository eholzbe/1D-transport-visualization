# Visualization of Solute Transport in 1D Free and Porous Media Flow

Ekkehard Holzbecher

*German Univ. of Technology in Oman (GUtech)*

In the real world environment flow of fluids is mostly 3-dimensional (3D), but there are various situations in which a 1D perception is convenient. Neglecting all velocity variations, flow in rivers, canals, pipes and other conduits may be described by a single average velocity. Column experiments in laboratories are designed to reduce the complexity of flow fields and allow the use of a single velocity value. In blood vessels flow is mainly 1D. Aside from hydrodynamics the concept of 1D flow is appropriate in certain situations of aerodynamics.  Also concerning fracture and groundwater flow in the sub-surface the 1D view is often allowed abstracting from all existing heterogeneities. In literature this is often referred to as the plug flow model.
The migration of a solute or a dissolved substance in a flowing fluid is determined by several processes. Some of these are of physical, others are of chemical, biochemical, geochemical or biogeochemical nature. The processes that govern the fate of an individual species can be grouped in four basic classes: 
* Advection
* Diffusion/dispersion
* Decay / degradation
* Sorption
 
Altogether these determine the transport of a solute or dissolved chemical specie in a fluid. Mathematically this is expressed in a differential equation for the concentration c of the species:

![Equation 1](Eqn1.gif)                                   (1)

with parameters *R*, *D*, *v* and *λ*. *x* and *t* denote the space and time. Each of the four parameters is related to one of the processes mentioned above. *v* is the velocity that determines advective flux. *D* is the diffusivity that describes diffusive and more general dispersive processes. *λ* is the decay constant describing linear decay or degradation processes. *R* is the retardation factor which emerges from fast ad- and desorption processes. In rivers and streams retardation is also caused by the exchange with retention zones (Marion et al. 2008).    
Concerning the source of the species two basic scenarios have to be distinguished. In one there is an initial concentration that is locally elevated; in the other there is a permanent leaking into the fluid. For 1D flow these are the instantaneous plane source and the constant inflow model cases.    
The instantaneous plane source model is based on the assumption that the initial concentration is infinitely high and located in a single point. While this is physically not possible, mathematically it allows the derivation of an analytical expression for *c* at times *t*>0 after introduction of the specie in the fluid and positions x>0 downstream from the original source:  

![Equation 2](Eqn2.gif)    (2)

According to Häfner et al. (1992) the solution was first derived by Angermann in 1989. *M*<sub>0</sub> is the total mass introduced at time *t*=0 at position *x*=0 put into an environment in which the concerned species was not present before. 
In the other generic scenario it is assumed that there is inflow with a constant concentration 

![Equation 3](Eqn3.gif)    (3)

*c<sub>in</sub>* denotes the concentration at the inflow position *x*=0. The solution was derived by van Genuchten (1981) for a general decay term –*μc* in equation (1). Following Wexler (1992) we use here *μ=λR*. This is based on the assumption that the degradation process is active in the dissolved and in the adsorbed state (Holzbecher 2017).   
The 1D transport simulator software visualizes the spatial and temporal development of a species concentration under the combined influence of all four processes and for both of the source scenarios. A first version was presented by Holzbecher in the textbook ‘Environmental Modeling – using MATLAB’ in 2007 and than extended in the second edition (Holzbecher 2012). Some crucial problems with the numerical implementation of the book versions are overcome as described by Holzbecher (2015).    
The simulator allows the input of the basic parameters in a graphical user interface. In addition to the four process parameters values for the length of the visualized system and the considered time period have to be specified.  Figure 1 depicts the GUI. The GUI also enables the choice of the source model.

![Figure 1](Fig1.png)
#### Figure 1: The Graphical User Interface of the 1D transport Simulator
The output is initiated at pressing the ‘Run’ button. It shows concentration profiles and breakthrough curves in two panels. The result for the instantaneous source model with default parameters is given in Figure 2. 

![Figure 2](Fig2.png)
#### Figure 2: Output for the default instantaneous source model
As a real system that is represented by this simulator model one may imagine a column in a laboratory of 1 m length. A fluid is flowing within the column with a velocity of 1 cm/min. The diffusivity is 1 cm<sup>2</sup>/min. An experiment in the column is run over a time period of 100 min. 
The upper figure shows concentration profiles, i.e. the concentration distribution in a column at 10 time instants during the experiment. The lower figure depicts breakthrough curves, i.e. the concentration development measured at ten sensors equidistantly located along the column. 
The colouring of the curves allows an easy connection between the two figures. Colours are connected with time periods, as given in the legend. The first time period is related to the blue colour, in which the breakthrough curve at the first sensor is steeply rising. The profile at the end of the ‘blue’ period is depicted in the upper figure in the very colour. What follows is a ‘light blue’ period, shown by a colour change of the breakthrough curves. The profile at the end of this period is depicted in light blue in the profile figure. 
The colours help to understand the connection between profile and breakthrough curves. At the observation points at the end of the coloured time periods the same values can be recognized in both figures. In the shown example at the end of ‘blue’ period the concentration at the first downstream sensor is around 0.09, which can be taken from the green curve in the profile figure and from the first breakthrough curve changing colour from blue to light blue. At the same position at the end of the ‘light blue’ period a value of 0.02 for c can be identified in both figures.   
The simulator provides easy visual evaluation of the influence of parameter changes. The example in Figure 3 shows the effect of velocity. The left sub-plots show profile and breakthrough output for the default constant inflow case. On the right the corresponding figures are shown, delivered by the software for an increased velocity *v*=2! The fluid is flowing faster through the 1D system. Thus the profile curves move to the right, while the breakthrough curves are shifted to the left.

![Figure 3a](Fig3a.png)
![Figure 3b](Fig3b.png)
#### Figure 3: Output for the default constant inflow model compared with the case of doubled velocity 
For the default parameter setting (*D*=1, *v*=1, *λ*=0, *R*=1) only the processes of diffusion and advection are considered. Using the transport simulator the additional effect of decay, degradation and sorption processes can be studied. Here two examples are selected for demonstration.  Figure 4 depicts the output when decay is added to the default case with constant inflow. In the profile curves a constant decline of the front maximum can be observed. This is also nicely visualized in the breakthrough curves, which with increasing downstream position reach lower stationary values.  

![Figure 4](Fig4.png)
#### Figure 4: Output for the default constant inflow model with additional degradation 
Figure 5 deals with a situation in which sorption processes are involved. Here they induce a retardation *R*=2. The effect on the concentration distributions can be studied using the simulator. In comparison with the default shown on the left side of Figure 3 profiles are shifted to the left, breakthrough curves to the right.  

![Figure 5](Fig5.png)
#### Figure 5: Output for the default constant inflow model with additional retardation 
Concerning the physical units the program leaves the choice of length and time units to the user. In the GUI the letter T is used for an arbitrary time unit, the letter L for an arbitrary length unit. The user may choose these freely, but has to follow the choice by entering parameter values. For example: is the length unit is cm and the time unit min, the velocity value has to be given in cm/min, as indicated below the input field. Correspondingly the user has to stick with the T and L choice entering other parameter values. Only the retardation as dimensionless parameter is independent of the unit choice.      
 The 1D transport simulator can be used in many of the above mentioned situations of 1D flow. Using previous knowledge or educated guesses concerning the few parameters the calculated concentration distributions can be of help in various respects. It may serve for the prediction of the spreading of a contaminant. Arrival times can be obtained. It can be checked if concentrations are above a critical limit at arrival. For lab or field experiments researchers obtain hints about the placement of sensors. 
Due to its minimal design and user-friendly implementation the 1D transport simulator is extremely useful teaching transport processes in fields of hydro- and aerodynamics as well as in porous media flow.            
## References 
* Häfner, Frieder, Dietrich Sames, Hans-Dieter Voigt. 1992. “Wärme- und Stofftransport”. Springer Publ., Berlin. https://doi:10.1007/978-3-662-00982-6
* Holzbecher, Ekkehard. 2012. “Environmental Modeling – using MATLAB”, Springer Publ., Heidelberg (2nd ed.). https://doi:10.1007/978-3-642-22042-5 
* Holzbecher, Ekkehard, 2015. “Improved Evaluation of Analytical Solutions of the 1D Transport Equation”, Addendum to Holzbecher, 2012. “Environmental Modeling – using MATLAB”. https://www.researchgate.net/publication/281898072_Improved_Evaluation_of_Analytical_Solutions_of_the_1D_Transport_Equation
* Holzbecher, Ekkehard 2017. “Generalizing the concept of retardation factors”. Toxicological & Environmental Chemistry 9(7-8): 1096-1116. https://doi:10.1080/02772248.2016.1241881
* Marion, Andrea, Mattia Zaramella, Andrea Bottacin-Busolin 2008. “Solute transport in rivers with multiple storage zones: the STIR model”, Water Resources Research 44, W10406. https://doi:10.1029/2008WR007037
* van Genuchten, Martinus Th. 1981. “Analytical solutions for chemical transport with simultaneous adsorption, zero-order production and first-order decay”. J. of Hydrology 49: 213-233. https://doi:10.1016/0022-1694(81)90214-6
* Wexler, Eliezer J. 1992.  “Analytical solutions for one-, two-, and three-dimensional solute transport in groundwater systems with uniform flow”. Techniques of Water-Resources Investigations of the United States Geological Survey, Book 3, Chapter B7. https://pubs.er.usgs.gov/publication/twri03B7
