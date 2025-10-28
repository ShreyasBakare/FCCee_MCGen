# e+ e- → Z H (H → l⁺ l⁻ a) Generation using MadGraph5_aMC@NLO (without using MadSpin)

This README explains how to generate the process  
e⁺ e⁻ → Z H (with H → l⁺ l⁻ a) **without using MadSpin** in MadGraph5_aMC@NLO.

---

## 1. Prerequisites

Make sure the following are prepared:

1. **Model:** `HC_NLO_X0_UFO` must be present in this directory.
You can curl it from https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1

2. source /cvmfs/sw.hsf.org/key4hep/setup.sh
This sets up the environment for MadGraph5_aMC@NLO via Key4HEP.

3. **Cards:**
Use the cards from:
[https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_no_MadSpin](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_no_MadSpin)

You will need both `proc_card.dat` and `run_card.dat` from this directory.

---

## 2. Process Generation

1. Run `mg5_aMC proc_card.dat`

2. Modify center-of-mass energy to 240 GeV in: DalitzDecay/Cards/run_card.dat
     120.0     = ebeam1  ! beam 1 total energy in GeV
     120.0     = ebeam2  ! beam 2 total energy in GeV

3. `mg5_aMC'

4. `launch DalitzDecay`

---

## Output Behavior

- ~448 events generated in 4–5 minutes.
- Indicates phase-space integration difficulties typical of decays handled directly inside the main process. Message like : 
```
INFO: fail to reach target 10000 failed to generate enough events.

Please follow one of the following suggestions to fix the issue:
- set in the run_card.dat ‘sde_strategy’ to 2
- set in the run_card.dat ‘hard_survey’ to 1 or 2
- reduce the number of requested events (if set too high)
- check that you do not have -integrable- singularity in your amplitude.
```

Therefore it's probably better to use MadGraph to `generate e+ e- > z h' and then MadSpin to decay the Higgs `h > l+ l- a` as shown in [https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin)