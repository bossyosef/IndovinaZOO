var to = gon.to;
var timeoutstatico = gon.tos;
var id = gon.id;
var nq = gon.nq;
var risposta_corretta;
var livello;
var animale1;
var animale2;
var verso;
var animale1name;
var animale2name;
var timerID;
var timeriniziato = 0;

$(document).ready ( function ()
{
  /*Se siamo nel primo quiz, allora il DB client viene cancellato, viene creato un nuovo
   *db client che viene popolato con i dati di ogni quiz della partita e si assegnano alle
   *variabili globali i valori che servono alle altre funzioni.*/
  
  if (id == 1)
  {
	var deleterequest = indexedDB.deleteDatabase("game");
	console.log("db cancellato");
	
	deleterequest.onsuccess = function(e)
	{
	  var openrequest = indexedDB.open("game",id);
	  console.log("db aperto.");
	  
	  openrequest.onupgradeneeded = function(ev)
	  {
		console.log("entrato onupgradeneeded");
		
		var db = ev.target.result;
		var store = db.createObjectStore("quizzes", {keyPath: "number"});
		
		for(var i=0;i<nq;i++)
		{
		  store.put({number: i+1, quiz_id: gon.quiz_arr[i].id, level: gon.quiz_arr[i].level ,animal1: gon.animali_arr[i][0].image.url, animal2: gon.animali_arr[i][1].image.url, solution: gon.soluzioni_arr[i].cry.url, user_response: "", score: ""});
		}
		
		risposta_corretta = getAnimalName(gon.soluzioni_arr[0].cry.url);
		livello = gon.quiz_arr[0].level;
		animale1 = gon.animali_arr[0][0].image.url;
		animale2 = gon.animali_arr[0][1].image.url;
		verso = gon.soluzioni_arr[0].cry.url;
		animale1name = getAnimalName(animale1);
		animale2name = getAnimalName(animale2);
		createQuizObjects();
		
		console.log("uscito onupgradeneeded");
	  }
	  
	  openrequest.onsuccess = function(eve)
	  {
		console.log("entrato on success");
		
		var db = eve.target.result;
		db.close();
		
		console.log("uscito onsuccess");
	  }
	  
	  openrequest.onerror = function(even)
	  {
		console.log("entrato onerror");
		console.log(openrequest.errorCode);
	  }
	}
	
	deleterequest.onerror = function(event)
	{
	  console.log("entrato onerror delete");
	  console.log(deleterequest.errorCode);
	}
  } else
  {
	/*Se siamo in un quiz diverso dal primo allora si prendono solo i valori necessari per le
	 *altre funzioni.*/
	
	var openrequest = indexedDB.open("game");
	console.log("db aperto");
	
	openrequest.onsuccess = function(e)
	{
	  console.log("entrato on success");
	  
	  var db = e.target.result;
	  var tx = db.transaction(["quizzes"],"readonly");
	  var store = tx.objectStore("quizzes");
	  
	  var getrequest = store.get(id);
	  
	  getrequest.onsuccess = function(ev)
	  {
		var risultati = getrequest.result;
		risposta_corretta = getAnimalName(risultati.solution);
		livello = risultati.level;
		animale1 = risultati.animal1;
		animale2 = risultati.animal2;
		verso = risultati.solution;
		animale1name = getAnimalName(animale1);
		animale2name = getAnimalName(animale2);
		db.close();
		createQuizObjects();
		
		console.log("uscito onsuccess");
	  }
	  
	  getrequest.onerror = function(event)
	  {
		console.log("entrato onerror get");
		console.log(getrequest.errorCode);
	  }
	}
  }
});

function getAnimalName(fullPath) 
{
  /*Questa funzione ricava il nome di un animale, capitalizzato correttamente, dal path
   *dell'immagine o del verso.*/
  
  filename = fullPath.replace(/^.*[\\\/]/, '');
  name = filename.split(".")[0];
  return name.charAt(0).toUpperCase() + name.slice(1);
}

function audio_el(v)
{
  /*Questa funzione crea un elemento html audio che contiene il verso dell'animale
   *che costituisce la risposta corretta a partire dal path del verso.*/
  
  var audio = document.createElement("audio");
  audio.id = "verso";
  audio.preload = "auto";
  audio.src = v;
  return audio;
}

function image_el(a)
{
  /*Questa funzione crea un elemento html img che contiene l'immagine di un animale
   *del quiz a partire dal path dell'immagine.*/
  
  var img = document.createElement("img");
  var temp;
  img.src = a;
  temp = getAnimalName(a);
  img.alt = temp;
  img.title = temp
  img.className = "img-rounded";
  var att = document.createAttribute("onclick");
  att.value = "scelta('"+ temp + "')";
  img.setAttributeNode(att);
  return img;
}

function createQuizObjects()
{
  /*Questa funzione popola il div principale della pagina con il verso dell'animale
   *da indovinare e le immagini dei due animali possibili.*/
  
  var div = document.getElementById("elementiquiz");
  div.appendChild(audio_el(verso));
  div.appendChild(image_el(animale1));
  div.appendChild(image_el(animale2));
}

function storeQuiz(ur,s)
{
  /*Questa funzione aggiorna il DB client con la risposta dell'utente e il punteggio che
   *l'utente ha ottenuto in questo quiz. Se è andato tutto bene chiama quizdopo().*/
  
  var request = indexedDB.open("game");
  console.log("db aperto.");
  
  request.onsuccess = function(e) 
  {
	console.log("entrato onsuccess.");
	
	var db = e.target.result;
	var tx = db.transaction(["quizzes"],"readwrite");
	var store = tx.objectStore("quizzes");
	var getrequest = store.get(id);
	
	getrequest.onsuccess = function(ev)
	{
	  var risultati = ev.target.result;
	  risultati.user_response = ur;
	  risultati.score = s;
	  var putresult = store.put(risultati);
	  db.close();
	  
	  quizdopo();
	}
  }
  
  request.onerror = function(e)
  {
	console.log("entrato onerror.");
	console.log(request.errorCode);
  }
}

function update()
{
  /*Questa funzione viene chiamata ogni 1000 millisecondi da setInterval e
   *aggiorna l'utente su quanto tempo rimane per rispondere. Se il timer arriva
   *a 0 allora chiama timeout().*/
  
  to = to - 1;
  
  if (to != 0) 
  {
	document.getElementById("barra_avanzamento").value = (to*10)/timeoutstatico;
	document.getElementById("valore_avanzamento").textContent = Math.ceil(to/100)+"s";
  } else 
  {
	timeout();
	document.getElementById("barra_avanzamento").value = to;
	document.getElementById("valore_avanzamento").textContent = "SCADUTO";
  }
}

function inizia()
{
  /*Questa funzione viene chiamata quanto l'utente vuole iniziare il quiz, riproduce
   *l'audio del verso e fa partire il conto alla rovescia.*/
  
  if (timeriniziato == 0)
  {
	timeriniziato = 1;
	var audio = document.getElementById("verso");
	audio.play();
	timerID = setInterval("update()", 10);
  }
  document.getElementById("salta").style.display= "inline";
}

function scelta(animale)
{
  /*Questa funzione viene chiamata quando l'utente clicca sull'immagine di un animale.
   *Pausa l'audio e se la risposta è corretta calcola il punteggio e chiama storeQuiz,
   *altrimenti chiama storeQuiz con punteggio 0. In ogni caso stampa a video una stringa.*/
  
  if (timeriniziato == 1)
  {
	timeriniziato = 2;
	clearInterval(timerID);
	var audioe = document.getElementById("verso");
	audioe.pause();
	
	if (animale == "_skip") {
	  var punteggio = 0;
	  document.getElementById("risultato").textContent = "Domanda saltata! La risposta esatta era " + risposta_corretta + "! Non hai guadagnato alcun punto.";
	  animale = "";
	}
	else {
		  if (animale == risposta_corretta)
		  {
			var modificatore = livello/2+0.5; 
			var punteggio = Math.ceil((to/(timeoutstatico*100))*10);
			punteggio *= modificatore;
			punteggio = Math.ceil(punteggio);
			
			document.getElementById("risultato").textContent = "Risposta esatta! Il tuo punteggio è " + punteggio + ".";
		  } else
		  {
			var punteggio = Math.ceil(-6/livello);
			
			document.getElementById("risultato").textContent = "No! La risposta esatta era " + risposta_corretta + "! Il tuo punteggio è "+punteggio+".";
		  }
	}
	storeQuiz(animale,punteggio);
  }
}

function timeout()
{
  /*Questa funzione blocca il timer, avverte l'utente che è scaduto il tempo e
   *chiama storeQuiz con punteggio 0.*/
  
  timeriniziato = 2;
  clearInterval(timerID);
  document.getElementById("risultato").textContent = "Il tempo è scaduto! La risposta esatta era " + risposta_corretta + "! Il tuo punteggio è 0.";
  storeQuiz("",0);
}

function quizdopo()
{
  /*Questa funzione mostra il submit per la form corretta, prossimoquiz se non ha
   *ancora finito, altrimenti finequiz.*/
  
  var tag;
  if ((id == nq) || (nq == 1)) 
  {
	tag = document.getElementById("finequiztag");
	tag.style.display = "inline";
  }
  else
  {
	tag = document.getElementById("prossimoquiztag");
	tag.style.display = "inline";
  }
}