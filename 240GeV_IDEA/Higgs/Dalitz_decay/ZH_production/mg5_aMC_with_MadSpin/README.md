# $e^+e^- \to Z H$ ($H \to l^+ l^- \gamma$) at FCC-ee $\mathbf{\sqrt{s}}$ = ${240\ \text{GeV}}$ (IDEA FastSim)

## Overview

This repository contains the necessary instructions and files to generate Monte Carlo (MC) simulation samples of $\mathbf{e^+e^- \to Z H}$ production [using MadGraph5_aMC] at the Future Circular Collider $e^+e^-$ ($\mathbf{FCC-ee}$) with a center-of-mass energy of $\mathbf{240\ \text{GeV}}$, Where $H$ undergoes a Dalitz decay ($\mathbf{H \to l^+ l^- \gamma}$) [using MadSpin] and (for initial simplification and analysis framework development) $Z$ decays leptonically ($\mathbf{Z \to l^+ l^-}$) [Using Pythia8] with Fast Simulation of IDEA detector's response [Using Delphes].

### Note: 
* Complete process is divided into three steps
    1. LHEvents generation (MadGraph5_aMC + MadSpin)
    2. Hadronization and showering (Pythia8)
    3. Detector simulation (Delphes)
* First step produces $Z$ as a stable particle along with $l^+ l^- and \gamma$. This $Z$ decays in the second step using Pythia8 (recommended for full SM fidelity)
* Here,  $l^{+/-} = e^{+/-}/\mu^{+/-}$


## 0. Setup
Make sure the following are prepared, if not already:

### i. Download cards and config files:
```
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/proc_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/run_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/madspin_card.dat
mkdir cards config ; cd cards
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/cards/p8_lhereader.cmd
cd ../config
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/config/pythia.py
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/config/card_IDEA.tcl
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/240GeV_IDEA/Higgs/Dalitz_decay/ZH_production/mg5_aMC_with_MadSpin/config/edm4hep_IDEA.tcl
cd ..
``` 

### ii. heft Model `HC_NLO_X0_UFO` must be present in current working directory.

```
wget http://feynrules.irmp.ucl.ac.be/raw-attachment/wiki/HiggsCharacterisation/HC_NLO_X0_UFO.zip
unzip HC_NLO_X0_UFO.zip
```
More about the model: https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1
-   HC_NLO_X0_UFO stores mu+/- as m+/-, thus we have redefined l+/- in madspin_card.dat

### iii. Set up the environment for MadGraph5_aMC@NLO, MadSpin, Pythia8 and Delphes via Key4HEP stack:

```
source /cvmfs/sw.hsf.org/key4hep/setup.sh -r 2025-05-29
```
`-r 2025-05-29` is currently the latest Key4HEP stack 


## 2. MadGraph5_aMC + MadSpin

```
mg5_aMC proc_card.dat
cp -f run_card.dat madspin_card.dat DalitzDecay_MS/Cards/.
DalitzDecay_MS/bin/generate_events -f
```

####  Output Behavior
- Generates all 10,000 events in a LHE file
- Takes time of O(13 hours)


## 3. Pythia

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
k4run config/pythia.py -n 10000 --out.filename edm4hep_p8events.root --Pythia8.PythiaInterface.pythiacard p8_lhereader.cmd | tee edm4hep.log
```

## OR

## 3. Pythia + Delphes

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
DelphesPythia8_EDM4HEP config/card_IDEA.tcl config/edm4hep_IDEA.tcl p8_lhereader.cmd ZH_dalitz_edm4hep.root
```

### Output Behavior
- Generates a root file with 8,207 edm4hep events out of 10,000 LHEvents
    - `1,793 Error in ProcessContainer::constructProcess: setting mass failed` (!!)
    - Tested for 2 samples : sample 1 uses above added MadSpin card (Z does not decay in MadSpin; decays later in Pythia8), sample 2 uses same MadSpin card just with the line  `decay z > l+ l-` uncommented (Z decays in MadSpin)
    - Here both samples 1 & 2 (Z decay - w/o madspin and - w madspin) face the same setting mass failed error with ~80% events pass through. ~20% don't : no visible pattern (!?)
- Takes time of O(5 minutes)

