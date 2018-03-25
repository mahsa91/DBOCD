**********About**********
================================
Here is the code for finding overlapping communities in static and dynamic networks.

Currently, our implementation can be used for static and dynamic networks and is written in Matlab.

DBOCD implements the complete algorithm and produces samples from communities of links 
and importance of nodes in communities which are named with (G) and (beta).


**********Disclaimer*********
=============================
If you find a bug, please send a bug report to mghorbani@ce.sharif.edu including if necessary the input file and the parameters that caused the bug.
You can also send me any comment or suggestion about the program.



**********DBOCD Folder**********
================================
The main script is "main_DBOCD_scbysc". It contains a sample for running DBOCD on a data with 7 snapshots.
If you want to use the default values for parameters, you can only change the data address and run main_DBOCD_scbysc.m


***** Input Data ******
=========================
Dynamic data should contains 4 variables:
1) SW which is a N*N (N is the number of all nodes in all the snapshots) and includes all nodes and edges over all time snapshot, 
   nodes that are not in a snapshot have no edges.
2) cellW which is a N_t*N_t (N_t is the number of nodes in snapshot t), which includes adjacency matrix of network in time t
3) trueCom which contains N_t cells and each cell contains the true community number of cell. trueCom is just needed for generalized NMI computing, so it is not neccessary.


***** Parameters ******
=========================
The main function is setParameter_scbysc, which is as follow:
setParameter_scbysc(SW, cellW, T1, T2,Gnum_pre, A_b_pre, cal1,cal2, theta, alpha, myGamma)
SW is a N*N (N is the number of all nodes in all the snapshots) which includes all nodes and edges over every time snapshot, nodes that are not in a snapshot have no edges.
SW is important to find common edges in two adjacent snapshots.

cellW is a N_t*N_t (N_t is the number of nodes in snapshot t), which includes adjacency matrix of network in time t

T1 = Number of generated samples in the first snapshot
T2 = Number of generated samples in all snapshots except the first one

Gnum_pre = The output of Gnum in the previous snapshot (Gnum = the variable contains the edge community number)
A_b_pre = SW in the previous snapshot
Gnum_pre and A_b_pre should be empty for the first snapshot

cal1 = The number of samples in the first snapshot should be calculated for finding best sample (default = T1/2)
cal2 = The number of samples in all snapshots except the first one should be calculated for finding best sample (default = T2/4)

theta = The threshold for changing soft member to hard membership (default = [0.4, 0.5, 0.6])
alpha = The hyper-parameter of CRP (default = 0.1)
myGamma = The hyper-parameter for node memberships in communities (default = 0.1 for all nodes)


***** Thanks ******
=========================
The "gnmi" function is now written by me. Thanks to "Erwan Le Martelot" for the useful function. It is included to make the project easy to run.
The function is related to "Kert?sz; Detecting the overlapping and hierarchical community structure in complex networks, New Journal of Physics, 2009)" paper.









