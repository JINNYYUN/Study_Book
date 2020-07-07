
public class powerSet {
    public static void main(String[] args) {
        char[] data = {'a', 'b', 'c'};
        boolean[] flag = new boolean[data.length];

        powerSet(data, flag, 0);
    }

    static void powerSet(char[] data, boolean[] flag, int n) {
        //basecase (공집합인 경우)
        if (n == data.length) {
            printData(data, flag);
            return;
        }

        //포함을 시키는 경우 
        flag[n] =true;
        powerSet(data, flag, n + 1);

        //포함을 시키지 않는 경우
        flag[n] = false;
        powerSet(data, flag, n + 1);
    }

    static void printData(char[] data, boolean[] flag) {
        for (int i = 0; i < flag.length; i++) {
            if (flag[i]) {
                System.out.print( data[i] + "\t");
            }
        }
        System.out.println();
    }
}
