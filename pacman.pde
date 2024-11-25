int pacX, pacY; // 팩맨 위치
int pacSize = 40; // 팩맨 크기
int pacSpeed = 5; // 팩맨 속도
int direction = -1; // 팩맨 방향 (0: 오른쪽, 1: 아래, 2: 왼쪽, 3: 위)
boolean isMoving = false; // 팩맨 움직임 상태

int[][] grid; // 게임 보드
int rows = 10, cols = 10; // 보드 크기
int cellSize = 60; // 셀 크기
int score = 0; // 점수


void settings(){
    size(cols * cellSize, rows * cellSize);
}
void setup() {

  pacX = (cellSize / 2)*3;
  pacY = (cellSize / 2)*3;

  // 게임 보드 초기화
  grid = new int[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (i == 0 || j == 0 || i == rows - 1 || j == cols - 1) {
        grid[i][j] = 2; // 주변 벽
      } else {
        grid[i][j] = 1; // 점수 아이템
      }
    }
  }
  // 내부 벽 추가
  grid[3][3] = 2;
  grid[3][4] = 2;
  grid[4][3] = 2;
  grid[5][5] = 2;
}

void draw() {
  background(0);

  // 그리드 그리기
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int x = j * cellSize;
      int y = i * cellSize;

      if (grid[i][j] == 1) { // 점수 아이템
        fill(255, 255, 0);
        ellipse(x + cellSize / 2, y + cellSize / 2, 10, 10);
      } else if (grid[i][j] == 2) { // 벽
        fill(100, 100, 255);
        rect(x, y, cellSize, cellSize);
      }
    }
  }

  // 팩맨 이동
  if (isMoving) { // 움직임 상태일 때만 이동
    movePacman();
  }

  // 팩맨 그리기
  fill(255, 255, 0);
  arc(pacX, pacY, pacSize, pacSize, radians(30 + direction * 90), radians(330 + direction * 90));

  // 점수 표시
  fill(255);
  textSize(20);
  text("Score: " + score, 10, height - 10);
}

void movePacman() {
  int newX = pacX;
  int newY = pacY;

  if (direction == 0) newX += pacSpeed; // 오른쪽
  if (direction == 1) newY += pacSpeed; // 아래
  if (direction == 2) newX -= pacSpeed; // 왼쪽
  if (direction == 3) newY -= pacSpeed; // 위

  // 팩맨의 경계 박스 좌표 계산
  int gridXLeft = (newX - pacSize / 2) / cellSize;
  int gridXRight = (newX + pacSize / 2 - 1) / cellSize;
  int gridYTop = (newY - pacSize / 2) / cellSize;
  int gridYBottom = (newY + pacSize / 2 - 1) / cellSize;

  // 벽 충돌 체크
  if (gridXLeft >= 0 && gridXRight < cols && gridYTop >= 0 && gridYBottom < rows &&
      grid[gridYTop][gridXLeft] != 2 && grid[gridYTop][gridXRight] != 2 &&
      grid[gridYBottom][gridXLeft] != 2 && grid[gridYBottom][gridXRight] != 2) {
    pacX = newX;
    pacY = newY;

    // 점수 아이템 먹기
    int gridX = pacX / cellSize;
    int gridY = pacY / cellSize;
    if (grid[gridY][gridX] == 1) {
      grid[gridY][gridX] = 0;
      score++;
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) direction = 0; // 오른쪽
  if (keyCode == DOWN) direction = 1; // 아래
  if (keyCode == LEFT) direction = 2; // 왼쪽
  if (keyCode == UP) direction = 3; // 위
  isMoving = true; // 움직임 시작
}

void keyReleased() {
  isMoving = false; // 움직임 멈춤
}

//int pacX, pacY; // 팩맨 위치
//int pacSize = 50; // 팩맨 크기
//int pacSpeed = 5; // 팩맨 속도
//int direction = -1; // 팩맨 방향 (0: 오른쪽, 1: 아래, 2: 왼쪽, 3: 위)
//boolean isMoving = false; //팩맨 움직임 상태

//int[][] grid; // 게임 보드
//int rows = 10, cols = 10; // 보드 크기
//int cellSize = 60; // 셀 크기
//int score = 0; // 점수

//void settings(){
//  size(cols * cellSize, rows * cellSize);
//}


//void setup() {
//  pacX = cellSize / 2;
//  pacY = cellSize / 2;

//  // 게임 보드 초기화
//  grid = new int[rows][cols];
//  for (int i = 0; i < rows; i++) {
//    for (int j = 0; j < cols; j++) {
//      grid[i][j] = 1; // 점수 아이템 (1은 먹을 수 있음)
//    }
//  }
//  // 벽 배치 (2는 벽)
//  grid[3][3] = 2;
//  grid[3][4] = 2;
//  grid[4][3] = 2;
//  grid[5][5] = 2;
//}

//void draw() {
//  background(0);

//  // 그리드 그리기
//  for (int i = 0; i < rows; i++) {
//    for (int j = 0; j < cols; j++) {
//      int x = j * cellSize;
//      int y = i * cellSize;

//      if (grid[i][j] == 1) { // 점수 아이템
//        fill(255, 255, 0);
//        ellipse(x + cellSize / 2, y + cellSize / 2, 10, 10);
//      } else if (grid[i][j] == 2) { // 벽
//        fill(100, 100, 255);
//        rect(x, y, cellSize, cellSize);
//      }
//    }
//  }

//  // 팩맨 이동
//  if (isMoving) { // 움직임 상태일 때만 이동
//    movePacman();
//  }

//  // 팩맨 그리기
//  fill(255, 255, 0);
//  arc(pacX, pacY, pacSize, pacSize, radians(30 + direction * 90), radians(330 + direction * 90));

//  // 점수 표시
//  fill(255);
//  textSize(20);
//  text("Score: " + score, 10, height - 10);
//}

//void movePacman() {
//  int newX = pacX, newY = pacY;

//  if (direction == 0) newX += pacSpeed; // 오른쪽
//  if (direction == 1) newY += pacSpeed; // 아래
//  if (direction == 2) newX -= pacSpeed; // 왼쪽
//  if (direction == 3) newY -= pacSpeed; // 위

//  // 격자 위치 계산
//  int gridX = newX / cellSize;
//  int gridY = newY / cellSize;

//  // 벽 충돌 체크
//  if (gridX >= 0 && gridX < cols && gridY >= 0 && gridY < rows && grid[gridY][gridX] != 2) {
//    pacX = newX;
//    pacY = newY;

//    // 점수 아이템 먹기
//    if (grid[gridY][gridX] == 1) {
//      grid[gridY][gridX] = 0;
//      score++;
//    }
//  }
//}

//void keyPressed() {
//  if (keyCode == RIGHT) direction = 0; // 오른쪽
//  if (keyCode == DOWN) direction = 1; // 아래
//  if (keyCode == LEFT) direction = 2; // 왼쪽
//  if (keyCode == UP) direction = 3; // 위
//  isMoving = true; //움직임 시작
//}

//void keyReleased() {
//  isMoving = false; //움직임 멈춤
//}
