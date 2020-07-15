package recursion;
/*프로그래머스 N-Queen*/
/*백트레킹, 재귀*/
public class NQueensProgrammers {
	static int answer = 0;
	static int N =0;	//체스의 크기
	static int cols[];	//퀸의 좌표
	
	public static boolean check(int level) {
		for(int i=0; i<level; i++) {
			//같은 열에 있는지 확인 > 같은 열에 있으면 false
			if(cols[i]==cols[level]) {
				return false;
			}
			//대각선에 있는지 확인 	> 대각선에 있으면 false
			else if((level-i)==Math.abs(cols[level]-cols[i])) {
				return false;
			}
		}
		//조건에 성립하면 true
		return true;
	}
	
	public static boolean queen(int level) {
		//여왕 위치 조건에 맞는지 확인하는 함수
		if(!check(level)) {
			return false;
		}
		//여왕 조건에 성립하고, level == N이면(퀸이 모두 정돈 되어있는 경우) > 최종 결과
		else if(level==N-1) {
			answer++;
			return true;
		}
		//어떤 노드에 도달했는데 꽝도 아니고, 최종적인 답도 아닌 경우
		//그 노드의 자식 노드를 검사 > 재귀함수를 호출
		for(int i=0; i<N; i++) {
			cols[level+1] = i; //퀸의 위치를 저장하고,
			queen(level+1);
		}
		return false;
	}
	
	public static int solution(int n) {
		N = n;
		cols= new int[n]; //퀸 좌표 확인용
		
		//queen(0); //0레벨 검사
		for(int i=0; i<n; i++) {
			cols[0] = i;
			queen(0);
		}
		System.out.println(answer);
        return answer;
    }
	
	public static void main(String[] args) {
		//Solution s = new Solution();
		
		solution(8);
	}
}
