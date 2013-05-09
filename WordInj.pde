
public class WordInj extends Word {
  
 public WordInj(String _w, String _pos) {
    super(_w, _pos);
 }

 public void render(int x, int y) {
  textFont(font, 55);
 
  text(word, x, y);
 } 
  
}
