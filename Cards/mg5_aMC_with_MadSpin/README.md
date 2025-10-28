# e+ e- → Z H Generation using MadGraph5_aMC@NLO and (H → l⁺ l⁻ a) using MadSpin

---

## 1. Prerequisites

Make sure the following are prepared:

1. heft Model `HC_NLO_X0_UFO` must be present in this directory.
You can get it from https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1

2. `source /cvmfs/sw.hsf.org/key4hep/setup.sh`

This sets up the environment for MadGraph5_aMC@NLO via Key4HEP.

3. Cards:

Use the cards from:

[https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin](https://github.com/ShreyasBakare/FCCee_MCGen/tree/main/Cards/mg5_aMC_with_MadSpin)

You will need `proc_card.dat` and `madspin_card.dat` from this directory.

---

## 2. Process Generation

1. Run `mg5_aMC proc_card.dat`

2. Modify center-of-mass energy to 240 GeV in: DalitzDecay_MS/Cards/run_card.dat

120.0     = ebeam1  ! beam 1 total energy in GeV

120.0     = ebeam2  ! beam 2 total energy in GeV

3. Copy `madspin_card.dat` to DalitzDecay_MS/Cards

4. `mg5_aMC`

5. `launch DalitzDecay_MS`

---

## Output Behavior

- Generates all 10,000 events.
- Took much longer O(hour)