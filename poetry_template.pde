
import java.util.*;

List<Word> words;

PFont font = createFont("Papyrus", 20);
PFont font2 = createFont("times", 16);
/*
ADJ:quick,brown,agile
NOUN:fox,dog,person
VERB:jump,bark
*/


void setup() {
  size(500,550,P3D);  
  background(0,0,33);
  for(int i = 0; i<100; i++){
    int xi = (int) random(500);
    int yi = (int) random(550);
    int hi = (int) random(200);
    int wi = (int) random(70);
    int bl = (int) random(200);
    int tr = (int) random(160);
    fill(0,0,bl,tr);
    rect(xi,yi,hi,wi);
  }
  /*
  rotateX(radians(-1));
  rotateY(radians(-5));
  
  for(int i = 0; i<49; i++){
    int xi = (int) random(200);
    int yi = (int) random(200);
    int hi = (int) random(40);
    noStroke();
    fill(170,75);
    ellipse(300+xi,400+yi,hi,hi);
  }
  
  
  rotateX(radians(1));
  rotateY(radians(5));
 */ 
  Map<String, List<String>> wordMap = loadInWords("words.txt"); 
  
  /*
  for (String k : wordMap.keySet()) {
   // println("key = " + k); 
  
    List<String> values = wordMap.get(k);
  
    for (String v : values) {
     // println("\tvalue = " + v);
    }   
  }
  */
  
  words = parseGrammar(wordMap, "grammar.txt");
}


/*** 
  Loads in a text file indicating words assoicated with parts of speech, parses it, 
  and returns a Map of each part of speech and its assoicated List of words.
  Assumes each line looks like:

    POS:word1,word2,...,wordN
***/  
Map<String, List<String>> loadInWords(String filename) {
  
  Map<String, List<String>> m = new HashMap<String, List<String>>();
  
  String[] lines = loadStrings(filename);
  
  for (int i = 0 ; i < lines.length; i++) {
    //println(lines[i]);
    String[] chop = split(lines[i], ':');
    
    String POS = chop[0];
    String wordsStr = chop[1];
    //println("\tLEFT SIDE = " + POS);
    //println("\tRIGHT SIDE = " + wordsStr + "\n");
    
    String[] wordsArr = split(wordsStr, ','); //split right side into an array of Strings
    List<String> wordsList = Arrays.asList(wordsArr); //turns array into a List
    
    
   
    for (String tmpStr : wordsList) {
      //println("\t\tword="+tmpStr);
    }
    
    
    m.put(POS, wordsList);
  }
  
  return m;
}


/***
  Reads through a text file of parts of speech and looks through a Map m for a random word 
  that corresponds to each part of speech. Returns a populated List of Word objects, where
  each type of Word has its own render() method.
***/

List<Word> parseGrammar( Map<String, List<String>> m, String filename) {
  
  List<Word> ws = new ArrayList<Word>();
  // TO DO - 
  // 1. Load in Strings from "grammar.txt" and loop through each line.
  String[] lines = loadStrings(filename);
  
  
  for(String line : lines) {
    //println(line); 
    
    String[] posArr = line.split(" ");
    List<String> posList = Arrays.asList(posArr); //turns array into a List
    
    for (String p : posList) {
      //println("\t" + p);
      
      List<String> listOfWords = m.get(p);
      
      int randNum = (int) random(0,listOfWords.size());
       
      String randomWord = listOfWords.get( randNum );
      println("\t\t" + randomWord);
      
      Word w;
      if (p.equals("NN")) {
        w = new WordNoun(randomWord, p);
      } else if(p.equals("RB")){
        w = new WordVerb(randomWord, p);
      }else if(p.equals("VBD")){
        w = new WordVerb(randomWord, p);
        }else if(p.equals("VBN")){
        w = new WordVerb(randomWord, p);
        }else if(p.equals("VBZ")){
        w = new WordVerb(randomWord, p);
        }else if(p.equals("UH")){
        w = new WordInj(randomWord, p);
      } else {
        w = new Word(randomWord, p);
      }
      
      ws.add(w);
      
    }
  }
  
  
  // 2. For each POS in the line, get the associated List of words from Map m.
  // 3. Choose a random word from the list.
  // 4. Place this word in a List that we will read from in the draw() loop. 
  
  return ws;
 }




void draw() {
  smooth();
  rotateX(radians(1));
  rotateY(radians(5));
  /*
   rect(10,41,450,2);
   rect(10,45,450,2); 
   rect(400,33,2,300);  
   rect(404,20,2,360);
   rect(408,24,2,278);
   rect(412,28,2,45);
   rect(416,32,2,30);
   rect(420,35,2,25);
   rect(424,38,2,20);
   rect(428,35,2,25);
   rect(432,32,2,30);
   rect(436,28,2,45);
   rect(440,24,2,278);
  */
  
  
  
  translate(0,-50);
  noStroke();
  
 
  fill(10,2);
   rect(20,70,500,550); 
      
   int pX = 100;
   int pY = 20;
translate(0,50);
   fill(200,100);
   for (Word w : words) {
     w.render(pX, pY);
     
     int sw = (int)textWidth(w.word);
     pX += sw;
     
     if (pX > width-250) {
       pX = 10;
       pY += 20;
     }
   }
}
  
