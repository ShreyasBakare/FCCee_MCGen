## MC event generation e+ e- → z h @ 240GeV using MadGraph5_aMC@NLO, where (h → l⁺ l⁻ a) and (z → all all) using MadSpin

---

[
    edit: 

So there are two samples I generate:

sample 1 uses above added madspin card
            (Z decays in madspin)

sample 2 uses exact same madspin card just the line `decay z > all all` removed. 
            (Z does not decay in madspin; decays later in pythia)

Here both samples 1 & 2 (Z decay - w/ madspin and - w/o madspin) face the same `setting mass failed` error when passed through 3. Pythia or 3. Pythia + Delphes. 

~80% events pass through. ~20% don't : no visible pattern (!?)

]

## 1. Prerequisites

Make sure the following are prepared, if not already:

1. heft Model `HC_NLO_X0_UFO` must be present in current directory.

```
wget http://feynrules.irmp.ucl.ac.be/raw-attachment/wiki/HiggsCharacterisation/HC_NLO_X0_UFO.zip
unzip HC_NLO_X0_UFO.zip
```

More about the model: https://cp3.irmp.ucl.ac.be/projects/feynrules/wiki/HiggsCharacterisation#no1

2. Set up the environment for MadGraph5_aMC@NLO via Key4HEP:

```
source /cvmfs/sw.hsf.org/key4hep/setup.sh
```

3. Download MadGraph cards:
```
wget https://github.com/ShreyasBakare/FCCee_MCGen/raw/main/Cards/mg5_aMC_with_MadSpin/proc_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/raw/main/Cards/mg5_aMC_with_MadSpin/run_card.dat
wget https://github.com/ShreyasBakare/FCCee_MCGen/raw/main/Cards/mg5_aMC_with_MadSpin/madspin_card.dat
``` 

---

## 2. LH Event Generation

```
mg5_aMC proc_card.dat
cp -f run_card.dat madspin_card.dat DalitzDecay_MS/Cards/.
DalitzDecay_MS/bin/generate_events -f
```


---

## 3. Pythia

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
k4run config/pythia.py -n 10000 --out.filename edm4hep_p8events.root --Pythia8.PythiaInterface.pythiacard p8_lhereader.cmd | tee edm4hep.log
```
OR
---

## 3. Pythia + Delphes

```
cp DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ZH_mg5_dalitz.lhe
DelphesPythia8_EDM4HEP config/card_IDEA.tcl config/edm4hep_IDEA.tcl p8_lhereader.cmd ZH_dalitz_edm4hep.root
```


---

### Output Behavior

- Generates all 10,000 events.
- Takes time of O(13 hour)

---

### Note:
-   HC_NLO_X0_UFO stores mu+/- as m+/-, thus we have redefined l+/- in madspin_card.dat