## MC event generation e+ e- → z h @ 240GeV using MadGraph5_aMC@NLO, where (h → l⁺ l⁻ a) and (z → all all) using MadSpin

---

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

## 2. Event Generation

```
mg5_aMC proc_card.dat
cp -f run_card.dat madspin_card.dat DalitzDecay_MS/Cards/.
DalitzDecay_MS/bin/generate_events -f
```

---

### Output Behavior

- Generates all 10,000 events.
- Takes time of O(hour)

---

### Note:
-   HC_NLO_X0_UFO stores mu+/- as m+/-, thus we have redefined l+/- in madspin_card.dat