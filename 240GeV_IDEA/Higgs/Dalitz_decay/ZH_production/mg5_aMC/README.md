# $e^+e^- \to Z H$ ($H \to l^+ l^- \gamma$) at FCC-ee $\mathbf{\sqrt{s}}$ = ${240\ \text{GeV}}$ Only MadGraph5_aMC@NLO (Higgs decay without using MadSpin)

## Overview

This repository '[mg5_aMC](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC' contains the necessary instructions and files to generate Monte Carlo (MC) simulation samples of $\mathbf{e^+e^- \to Z H \to l^+ l^- l^+ l^- \gamma }$ production [using MadGraph5_aMC] at the Future Circular Collider $e^+e^-$ ($\mathbf{FCC-ee}$) with a center-of-mass energy of $\mathbf{240\ \text{GeV}}$. Here I did not use MadSpin or Pythia or Delphes.

## 0. Setup

Make sure the following are prepared, if not already:

### 0.1 heft Model `HC_NLO_X0_UFO` must be present in current directory.
```
wget http://feynrules.irmp.ucl.ac.be/raw-attachment/wiki/HiggsCharacterisation/HC_NLO_X0_UFO.zip
unzip HC_NLO_X0_UFO.zip
```
More about the model: https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1

### 0.2 Set up the environment for MadGraph5_aMC@NLO via Key4HEP:
```
source /cvmfs/sw.hsf.org/key4hep/setup.sh -r 2025-05-29
```
- `-r 2025-05-29` is currently the latest Key4HEP stack 

### 0.3 Download MadGraph cards:
```
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC/proc_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC/run_card.dat
``` 

## 1. LHEvents Generation
```
mg5_aMC proc_card.dat
cp -f run_card.dat DalitzDecay/Cards/.
DalitzDecay_MS/bin/generate_events -f
```

### Output Behavior
- Generates ~448 out of 10000 events indicating phase-space integration difficulties typical of decays handled directly inside the main process. With a message like: 
```
INFO: fail to reach target 10000 failed to generate enough events.

Please follow one of the following suggestions to fix the issue:
- set in the run_card.dat ‘sde_strategy’ to 2
- set in the run_card.dat ‘hard_survey’ to 1 or 2
- reduce the number of requested events (if set too high)
- check that you do not have -integrable- singularity in your amplitude.
```

Therefore it's probably better to use MadGraph to `generate e+ e- > z h` and then MadSpin to decay the Higgs `h > l+ l- a` as shown in [mg5_aMC_with_MadSpin_P8_Delphes](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes)