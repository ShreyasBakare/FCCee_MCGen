!
! File: Pythia_LHEinput.cmd 
!
! This file contains commands to be read in for a Pythia8 run.
! Lines not beginning with a letter or digit are comments.
! Names are case-insensitive  -  but spellings-sensitive!
! Adjusted from Pythia example: main42.cmnd

! 1) Settings that will be used in a main program.
Main:numberOfEvents = 10000          ! number of events to generate
Main:timesAllowErrors = 11        ! abort run after this many flawed events

! 2) Settings related to output in init(), next() and stat() functions.
Init:showChangedSettings = on      ! list changed settings
Init:showAllSettings = off         ! list all settings
Init:showChangedParticleData = on  ! list changed particle data
Init:showAllParticleData = off     ! list all particle data
Next:numberCount = 1000            ! print message every n events
Next:numberShowLHA = 10             ! print LHA information n times
Next:numberShowInfo = 10            ! print event information n times
Next:numberShowProcess = 10         ! print process record n times
Next:numberShowEvent = 10           ! print event record n times
Stat:showPartonLevel = off         ! additional statistics on MPI
Stat:showProcessLevel = off         ! additional statistics on MPI

! 4) Read-in Les Houches Event file - alternative beam and process selection.
Beams:frameType = 4                      ! read info from a LHEF
Beams:LHEF = DalitzDecay_MS/Events/run_01_decayed_1/unweighted_events.lhe ! the LHEF to read from

! Z decays leptonically (in pythia8)
23:onMode = off
23:onIfAny = 11 13
