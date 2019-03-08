# Combinatorial Sequence Coverage Measurement (CSCM)
This is a command line tool for counting t-way permutations of sequences in a given matrix. The tool is intended to be used by software testers who wish to measure the combinatorial coverage of existing event sequence test suites. Although existing combinatorial coverage measurement tools exist, this is the first that measures the coverage of event sequences! 

#### Features
* Measures *t*-way coverage of event sequences in a given matrix
* Outputs the missing *t*-way sequences to a file
   * this could be useful for updating existing test suites with missing event permutations
* Can be executed on multiple processors for increased performance
* Developed in the Haskell programming language 

#### Other uses of CSCM
Sequence covering arrays are a useful test suite for finding bugs caused by some order of event execution [1] [2] [3] [4] [5] [6].  Applications of SCAs have included GUI testing [4], ﬁlesystem testing [3], automotive control systems [5] and other real-time applications [7]. Researchers who develop SCA generation algorithms could use CSCM as a utility for measuring the (*t+1*)-way coverage of the generated SCA.

For example, suppose the following 3-way sequence covering array of 26 events is generated:


| | | | | | | | | | | | | | | | | | | | | | | | | | |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|
|z|y|x|w|v|u|t|s|r|q|p|o|n|m|l|k|j|i|h|g|f|e|d|c|b|a|
|r|n|k|t|d|s|f|l|g|y|z|b|h|o|v|c|x|a|w|i|u|m|e|p|q|j|
|j|q|p|e|m|u|i|w|a|x|c|v|o|h|b|z|y|g|l|f|s|d|t|k|n|r|
|w|o|u|h|f|c|p|n|y|i|j|s|g|k|r|b|t|e|q|m|a|z|d|x|l|v|
|v|l|x|d|z|a|m|q|e|t|b|r|k|g|s|j|i|y|n|p|c|f|h|u|o|w|
|m|b|i|f|x|t|s|n|l|z|a|u|w|j|d|p|k|o|c|v|q|y|r|h|e|g|
|g|e|h|r|y|q|v|c|o|k|p|d|j|w|u|a|z|l|n|s|t|x|f|i|b|m|
|o|a|k|g|n|v|i|b|y|t|x|e|w|d|f|l|h|z|q|r|j|u|p|s|c|m|
|m|c|s|p|u|j|r|q|z|h|l|f|d|w|e|x|t|y|b|i|v|n|g|k|a|o|
|l|p|s|a|i|c|y|m|v|o|d|g|e|n|z|r|b|k|h|f|j|q|x|u|t|w|
|w|t|u|x|q|j|f|h|k|b|r|z|n|e|g|d|o|v|m|y|c|i|a|s|p|l|
|w|k|h|e|x|t|f|l|c|s|p|v|a|g|o|q|y|u|j|m|i|z|n|b|d|r|
|r|d|b|n|z|i|m|j|u|y|q|o|g|a|v|p|s|c|l|f|t|x|e|h|k|w|
|l|c|t|z|h|y|k|f|n|e|u|m|b|g|q|x|r|a|s|i|v|w|p|d|j|o|
|o|j|d|p|w|v|i|s|a|r|x|q|g|b|m|u|e|n|f|k|y|h|z|t|c|l|
|u|g|x|b|p|h|f|w|m|o|e|s|a|r|l|c|k|y|q|z|n|d|v|i|j|t|
|t|j|i|v|d|n|z|q|y|k|c|l|r|a|s|e|o|m|w|f|h|p|b|x|g|u|
|n|k|e|o|p|c|q|w|b|x|s|y|h|v|f|t|d|j|u|i|r|l|z|a|m|g|
|g|m|a|z|l|r|i|u|j|d|t|f|v|h|y|s|x|b|w|q|c|p|o|e|k|n|
|g|b|k|l|c|w|q|v|f|s|r|m|o|t|n|i|j|x|p|a|e|u|h|y|d|z|
|z|d|y|h|u|e|a|p|x|j|i|n|t|o|m|r|s|f|v|q|w|c|l|k|b|g|
|y|t|f|i|o|w|m|h|k|b|s|x|u|g|d|c|z|a|l|p|r|e|v|j|q|n|
|n|q|j|v|e|r|p|l|a|z|c|d|g|u|x|s|b|k|h|m|w|o|i|f|t|y|
|s|e|f|x|k|t|m|i|l|j|a|r|n|g|c|y|b|p|d|o|q|u|v|h|z|w|
|w|z|h|v|u|q|o|d|p|b|y|c|g|n|r|a|j|l|i|m|t|k|x|f|e|s|

This sequence covering array covers 100% of the 3-way permutations of events (*a,b,...,z*). There are 15,600 3-way permutations of events, which are covered in only 26 events! However, it may not be sufficient to gauge the effectiveness of an SCA by its *t*-way coverage. Instead, we might be interested in its (*t+1*)-way coverage. The above SCA only covers 70.44% of 4-way permutations of events. Note: there are 358,800 4-way permutations of events, and this SCA covers 252,770 of them! 

### Usage of CSCM in Research

Garn, et al. used CSCM for event sequence coverage validation in their work on fingerprinting browsers using combinatorial sequence testing. *Presented at HOTSOS 2019* 

This tool was developed during my undergraduate thesis work at Texas A&M University: "Black-box Testing Mobile Applications Using Sequence Covering Arrays"

### References

[1] D. R. Kuhn, J. M. Higdon, J. F. Lawrence, R. N. Kacker, and Y. Lei, “Combinatorial methods for event sequence testing,” 2010, preprint. Available at http://csrc.nist.gov/groups/SNS/acts/documents/event-seq101008.pdf

[2] Kuhn, D. R., Higdon, J. M., Lawrence, J. F., Kacker, R. N., & Lei,Y. (2012, April). Combinatorial methods for event sequence testing. In Software Testing, Veriﬁcation and Validation (ICST), 2012 IEEE Fifth International Conference on (pp. 601-609). IEEE.

[3] Farchi, E., Segall, I., Tzoref-Brill, R., & Zlotnick, A. (2014, March). Combinatorial testing with order requirements. In Software Testing, Veriﬁcation and Validation Workshops (ICSTW), 2014 IEEE Seventh International Conference on (pp. 118-127). IEEE.

[4] Mayo, Quentin, Ryan Michaels, and Renee Bryce. "Test suite reductionby combinatorial-based coverage of event sequences." Software Testing,Veriﬁcation and Validation Workshops (ICSTW), 2014 IEEE Seventh International Conference on. IEEE, 2014.

[5] Dhadyalla, G., Kumari, N., & Snell, T. (2014, March). Combinatorial testing for an automotive hybrid electric vehicle control system: acase study. In Software Testing, Veriﬁcation and Validation Workshops(ICSTW), 2014 IEEE Seventh International Conference on (pp. 51-57).IEEE.

[6] Z. B. Ratliff. 2018. Black-box Testing Mobile Applications Using Sequence Covering Arrays. (2018). undergraduate thesis, Texas A&M University

[7] Bhargavi, S. B., & Suma, V. (2017, February). An analysis of suitable CTD model for applications. In Innovative Mechanisms for Industry Applications (ICIMIA), 2017 International Conference on (pp. 766-769).IEEE.
