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
  Sequence::SimData d(p.totsam());

  // K. Thorton does this; not sure why as it's much slower
  std::ios_base::sync_with_stdio(true); 

  int rv, sim=0;
  cout << "sim\tpos_i\tpos_j\trsq\tD" << endl;
  while( (rv = d.fromfile(stdin)) != EOF ) {
    vector<vector<double> > recomb_stats;
    recomb_stats = Sequence::Recombination::Disequilibrium(&d);

    // output table of r^2 and positions
    for (unsigned i=0; i < recomb_stats.size(); ++i) {
      cout << sim << "\t" << recomb_stats[i][0] << "\t" 
	   << recomb_stats[i][1] << "\t" 
	   << recomb_stats[i][2] << "\t" 
	   << recomb_stats[i][3] << endl;
    }
    ++sim;
  }
  return 0;
}
