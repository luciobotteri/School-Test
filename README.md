# School Test Project

## Descrizione
Questa applicazione iOS è stata sviluppata utilizzando SwiftUI e mira a fornire una soluzione digitale per la gestione delle informazioni di una scuola. L'app consente agli utenti di visualizzare e gestire dettagli relativi a classi, studenti e professori.

## Caratteristiche
- **Gestione Classi:** Visualizzazione e modifica delle informazioni sulle classi, inclusi studenti e professori associati.
- **Gestione Studenti:** Aggiunta, modifica e visualizzazione dei dettagli degli studenti.
- **Gestione Professori:** Aggiunta, modifica e visualizzazione dei dettagli dei professori.

## Struttura del Progetto
- **Model:** Definisce i modelli di dati per le aule, gli studenti e i professori.
- **View:** Contiene la UI per visualizzare e modificare i dati.
- **ViewModel:** Gestisce la logica dell'applicazione e interagisce con il backend.
- **NetworkManager:** Gestisce le chiamate di rete per interagire con il backend API.

## Tecnologie Utilizzate
- **SwiftUI:** Per la creazione dell'interfaccia utente.
- **Async/Await:** Per la gestione asincrona delle chiamate di rete.
- **MVVM Architecture:** Per una struttura del codice chiara e manutenibile.
- **Dependency Injection:** Iniezione delle dipendenze per fornire il `ViewModel` alle views. Questo approccio migliora la modularità e supporta un flusso di dati più pulito e gestibile.

## Come Iniziare
1. Clona il repository.
2. Apri il progetto in Xcode.
3. Se necessario, cambia l'API Key all'interno del Network Manager.
4. Esegui il progetto per visualizzarlo in un simulatore o dispositivo iOS.

## Note Aggiuntive
- L'app è stata scritta in inglese ed è stata localizzata parzialmente in italiano.
- Dispositivi di test utilizzati: iPhone 15 (fisico), iPhone 12 e iPhone SE di seconda generazione (simulatore).
- L'app supporta light e dark mode.
- Per motivi di tempo non è stata implementata la persistenza dei dati.
- Versione di Xcode utilizzata per lo sviluppo: 15.1
- Per la sincronizzazione dei dati manuale è possibile utilizzare il pull to refresh.
