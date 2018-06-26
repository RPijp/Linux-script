# Linux-script
Eindopdracht linux

De opdracht

Voor deze eindopdracht dien je in de Azure omgeving het volgende via een script te realiseren (Saltstack):

- Zet een hoofdserver op die de volgende functionaliteiten biedt:
  - Centrale logservice
	- Monitoring service
	- Overleg met de docent welke logservice en welke monitor je gaat aanbieden
	- Saltstack master
	- Docker en Kubernetes master.
	
- Realiseer twee servers die dienst doen als Docker worker voor Kubernetes. De servers moeten ingericht worden via Saltstack. Bij het opstarten van de VM mag je een script meegeven zodat Saltstack minion services wordt geïnstalleerd. De VM’s moet hun system log naar de log servers sturen en gemonitord wordt door de monitor service.
Op de Docker containers moet d.m.v. Saltstack een Wordpress installatie opgezet worden.

Alle scripts (en vooral de voortgang hierin) dienen op een git-repository te worden opgeslagen. De scripts moet eigen werk zijn. Indien je scripts gebruikt die je op het internet hebt gevonden dan krijg je per script een ½ punt aftrek. Hierbij dien je wel de bron vermeldt te hebben. Indien er plagiaat wordt geconstateerd zal de opdracht niet beoordeeld worden en de constatering bij de examencommissie gemeld worden.

Op Blackboard staat een beoordelingsmodel voor deze opdracht.
