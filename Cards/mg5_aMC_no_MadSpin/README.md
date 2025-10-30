## MC event generation e+ e- → z h (h → l⁺ l⁻ a) @ 240 GeV using MadGraph5_aMC@NLO (without using MadSpin)

---

## 1. Prerequisites

Make sure the following are prepared, if not already:

1. heft Model `HC_NLO_X0_UFO` must be present in current directory.

```
wget http://feynrules.irmp.ucl.ac.be/raw-attachment/wiki/HiggsCharacterisation/HC_NLO_X0_UFO.zip
unzip HC_NLO_X0_UFO.zip
```

2. Set up the environment for MadGraph5_aMC@NLO via Key4HEP:

```
source /cvmfs/sw.hsf.org/key4hep/setup.sh
```

3. Download MadGraph cards:
```
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/Cards/mg5_aMC_no_MadSpin/proc_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/blob/main/Cards/mg5_aMC_no_MadSpin/run_card.dat
``` 

---

## 2. Event Generation

```
mg5_aMC proc_card.dat
cp -f run_card.dat DalitzDecay/Cards/.
DalitzDecay_MS/bin/generate_events -f
```

---

## Output Behavior

- Generates ~448 out of 10000 events indicating phase-space integration difficulties typical of decays handled directly inside the main process. With a message like: 
```
INFO: fail to reach target 10000 failed to generate enough events.

Please follow one of the following suggestions to fix the issue:
- set in the run_card.dat ‘sde_strategy’ to 2
- set in the run_card.dat ‘hard_survey’ to 1 or 2
- reduce the number of requested events (if set too high)
- check that you do not have -integrable- singularity in your amplitude.
```

Therefore it's probably better to use MadGraph to `generate e+ e- > z h` and then MadSpin to decay the Higgs `h > l+ l- a` as shown in [https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin)