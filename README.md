# MVA
This project consists of several Mean value analysis (MVA) algorithms implemented in MATLAB.

As an efficient solution for performance evaluation, MVA algorithms can be adopted for a variety of queueieng networks. For example, single-class or multi-class networks, closed or open networks. 

The original MVA algorithm for load-dependent queues suffers from numerical instability issue. To address this issue, we proposed the following two MVA algorithms for single-class closed queueing networks with load-dependent queues. Note that the multi-class version was also proposed in our publication (https://doi.org/10.1007/978-3-319-92378-9_2), but it was not implemented in this project.

1. SMVA --- numerically stable MVA

2. A-SMVA --- alternative SMVA

For the detailed description and discussion of these two algorithms, please refer to our publication. If you used SMVA or ASMVA approaches in your academic publication, please cite it as follows:

```
@Inbook{Zhang2019,
author="Zhang, Lei
and Down, Douglas G.",
editor="Puliafito, Antonio
and Trivedi, Kishor S.",
title="SMVA: A Stable Mean Value Analysis Algorithm for Closed Systems with Load-Dependent Queues",
bookTitle="Systems Modeling: Methodologies and Tools",
year="2019",
publisher="Springer International Publishing",
address="Cham",
pages="11--28",
isbn="978-3-319-92378-9",
doi="10.1007/978-3-319-92378-9_2",
url="https://doi.org/10.1007/978-3-319-92378-9_2"
}
```
