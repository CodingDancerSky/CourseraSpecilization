import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.Array;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.regex.Pattern;

public class MP1 {
    Random generator;
    String userName;
    String inputFileName;
    String delimiters = " \t,;.?!-:@[](){}_*/";
    String[] stopWordsArray = {"i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours",
            "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its",
            "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that",
            "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having",
            "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while",
            "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before",
            "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again",
            "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each",
            "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than",
            "too", "very", "s", "t", "can", "will", "just", "don", "should", "now"};

    void initialRandomGenerator(String seed) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA");
        messageDigest.update(seed.toLowerCase().trim().getBytes());
        byte[] seedMD5 = messageDigest.digest();

        long longSeed = 0;
        for (int i = 0; i < seedMD5.length; i++) {
            longSeed += ((long) seedMD5[i] & 0xffL) << (8 * i);
        }

        this.generator = new Random(longSeed);
    }

    Integer[] getIndexes() throws NoSuchAlgorithmException {
        Integer n = 10000;
        Integer number_of_lines = 50000;
        Integer[] ret = new Integer[n];
        this.initialRandomGenerator(this.userName);
        for (int i = 0; i < n; i++) {
            ret[i] = generator.nextInt(number_of_lines);
        }
        return ret;
    }

    public MP1(String userName, String inputFileName) {
        this.userName = userName;
        this.inputFileName = inputFileName;
    }

    public String[] process() throws Exception {
      
        // read the file and store into List
        BufferedReader in = new BufferedReader(new FileReader(this.inputFileName));
        ArrayList<String> strings = new ArrayList<String>();
        String line;
        while((line = in.readLine()) != null)
        {
          strings.add(line);
        }
        in.close();
        
        // get the randomIndex
        Integer[] indexes = getIndexes();
        
        HashMap<String, Integer> wordFreqMap = new HashMap<String, Integer>();
        
        // count the word frequency
        for(int i: indexes) {
          String s = strings.get(i);
          String pattern = "[" + Pattern.quote(this.delimiters) + "]";
          String[] words = s.split(pattern);
          
          for(String w: words) {
            // make all the tokens lowercase and remove any tailing and leading spaces
            w = w.trim().toLowerCase();
//            System.out.println(i+"; "+s + w);

            // check the word exist in stopWordsArray
            if(!Arrays.asList(stopWordsArray).contains(w)) {
              if(wordFreqMap.containsKey(w)) {
                int freq = wordFreqMap.get(w);
                wordFreqMap.put(w, freq + 1);
              } else 
                wordFreqMap.put(w, 1);
            }
          }
                        
        }
        
        List<String> list = new ArrayList<String>(wordFreqMap.keySet());
//        System.out.println(list);
        // sort the word in deceasing order
        Collections.sort(list, new Comparator<String>() {
          @Override
          public int compare(String key1, String key2) {
           
            Integer val1 = (Integer) wordFreqMap.get(key1);
            Integer val2 = (Integer) wordFreqMap.get(key2);

            int diff = val2 - val1;
            if (diff == 0) {
              diff =  key1.compareTo(key2);
            }

             return diff;

          }
      });
        
        // Return the top 20 items from the sorted list as a String Array
        String[] ret = new String[20];
        int i = 0;
        list.remove(0);
        for( String k: list) {
//          System.out.println(k);
          ret[i++] = k;
          if(i == 20)
            break;
        }
              
        return ret;
    }
        
    
    public static void main(String[] args) throws Exception {
        if (args.length < 1){
            System.out.println("MP1 <User ID>");
        }
        else {
            String userName = args[0];
//            String inputFileName = "./input.txt";
            String inputFileName = "input.txt";
            MP1 mp = new MP1(userName, inputFileName);
            String[] topItems = mp.process();
//            System.out.println("------");

            for (String item: topItems){
                System.out.println(item);
            }
        }
    }
}

