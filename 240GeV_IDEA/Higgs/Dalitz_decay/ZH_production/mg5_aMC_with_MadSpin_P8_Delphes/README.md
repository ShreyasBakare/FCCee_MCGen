# $e^+e^- \to Z H$ ($Z \to l^+ l^-$) ($H \to l^+ l^- \gamma$) at FCC-ee $\mathbf{\sqrt{s}}$ = ${240\ \text{GeV}}$ (IDEA FastSim)

## Overview

This repository '[mg5_aMC_with_MadSpin_P8_Delphes](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes)' contains the necessary instructions and files to generate Monte Carlo (MC) simulation samples of $\mathbf{e^+e^- \to Z H}$ production [using MadGraph5_aMC] at the Future Circular Collider $e^+e^-$ ($\mathbf{FCC-ee}$) with a center-of-mass energy of $\mathbf{240\ \text{GeV}}$, Where $H$ undergoes a Dalitz decay ($\mathbf{H \to l^+ l^- \gamma}$) [using MadSpin] and (for initial simplification and analysis framework development) $Z$ decays leptonically ($\mathbf{Z \to l^+ l^-}$) [Using Pythia8] with Fast Simulation of IDEA detector's response [Using Delphes].

### Note: 
* Complete process is divided into three steps
    1. LHEvents generation (MadGraph5_aMC + MadSpin)
    2. Hadronization and showering (Pythia8)
    3. Detector simulation (Delphes)
* First step produces $Z$ as a stable particle along with $l^+ l^- \gamma$. This $Z$ decays in the second step using Pythia8 (recommended for full SM fidelity)
* Here,  $l^{+/-} = e^{+/-}/\mu^{+/-}$


## 0. Setup
Make sure the following are prepared, if not already:

### 0.1 Download cards and config files:
```
# Download main cards
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/proc_card.dat
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/run_card.dat
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/madspin_card.dat

# Create directories
mkdir cards config 

# Download card configuration
cd cards
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/cards/p8_lhereader.cmd

# Download general configuration files
cd ../config
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/config/pythia.py
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/config/card_IDEA.tcl
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/config/edm4hep_IDEA.tcl

# Return to original directory
cd ..
``` 

### 0.2 loops_sm and heft Model `HC_NLO_X0_UFO` must be present in current working directory.

```
# 1. Download the tarballs (using the raw links)
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/loops_sm.tar.gz
wget https://raw.githubusercontent.com/ShreyasBakare/FCCee_MCGen/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin_P8_Delphes/HC_NLO_X0_UFO.tar.gz

# 2. Extract them
tar -xzvf loops_sm.tar.gz
tar -xzvf HC_NLO_X0_UFO.tar.gz
```
- More about the heft model: https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1
- This webpage is more than 10 years old and does not have the restriction we want to use, thus we get the latest version of the model from CMS gridpack. `/cvmfs/cms.cern.ch/phys_generator/gridpacks/UL/13TeV/madgraph/V5_2.6.5/HtoLLGamma/ZH125_012j_NLO_HtoElElGamma_slc7_amd64_gcc700_CMSSW_10_6_19_tarball.tar.xz`
- HC_NLO_X0_UFO stores mu+/- as m+/-, thus we have redefined l+/- in madspin_card.dat

### 0.3 Set up the environment for MadGraph5_aMC@NLO, MadSpin, Pythia8 and Delphes via Key4HEP stack:

```
source /cvmfs/sw.hsf.org/key4hep/setup.sh -r 2025-05-29
```
- `-r 2025-05-29` is currently the latest Key4HEP stack 


## 2. MadGraph5_aMC + MadSpin

```
mg5_aMC proc_card.dat
cp -f run_card.dat madspin_card.dat zh/Cards/.
zh/bin/generate_events -f
gunzip "zh/Events/run_01_decayed_1/unweighted_events.lhe.gz"
```

###  Output Behavior
- Generates all 10,000 events in a LHE file
- Takes time of O(hour)


## 3. Pythia8

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
k4run config/pythia.py -n 10000 --out.filename edm4hep_p8events.root --Pythia8.PythiaInterface.pythiacard p8_lhereader.cmd | tee edm4hep.log
```

## OR

## 3. Pythia8 + Delphes

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
DelphesPythia8_EDM4HEP config/card_IDEA.tcl config/edm4hep_IDEA.tcl p8_lhereader.cmd ZH_dalitz_edm4hep.root
```

### Output Behavior
- Generates a root file with all 10,000 edm4hep events out of 10,000 LHEvents


### Issue before using the correct restriction of the HEFT model
- Generates a root file with 8,207 edm4hep events out of 10,000 LHEvents
    - `1,793 Error in ProcessContainer::constructProcess: setting mass failed` (!!)
    - Tested for 2 samples : sample 1 uses above added MadSpin card (Z does not decay in MadSpin; decays later in Pythia8), sample 2 uses same MadSpin card just with the line  `decay z > l+ l-` uncommented (Z decays in MadSpin)
    - Here both samples 1 & 2 (Z decay - w/o madspin and - w madspin) face the same setting mass failed error with ~80% events pass through. ~20% don't : no visible pattern (!?)
- Takes time of O(5 minutes)

