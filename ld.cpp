#include <iostream>
#include <vector>

#include <Sequence/SimParams.hpp>
#include <Sequence/SimData.hpp>
#include <Sequence/PolySIM.hpp>
#include <Sequence/Recombination.hpp>
using namespace std;

int main(int argc, char *argv[]) {
  static_cast<void>(argc), static_cast<void>(argv);

  Sequence::SimParams p;
  cin >> p;
  Sequence::SimData d();

  // K. Thorton does this; not sure why as it's much slower
  std::ios_base::sync_with_stdio(true); 

  int rv, sim=0;
  cout << "sim\tpos_i\tpos_j\trsq\tD\tDprime" << endl;
  while( (rv = d.fromfile(stdin)) != EOF ) {
    vector<Sequence::PairwiseLDstats> recomb_stats;
    recomb_stats = Sequence::Recombination::Disequilibrium(&d);

    // output table of r^2 and positions
    for (unsigned i=0; i < recomb_stats.size(); ++i) {
      cout << sim << "\t" << recomb_stats[i].i << "\t" 
	   << recomb_stats[i].j << "\t" 
	   << recomb_stats[i].rsq << "\t" 
	   << recomb_stats[i].D << << "\t" 
	   << recomb_stats[i].Dprime << endl;
    }
    ++sim;
  }
  return 0;
}
