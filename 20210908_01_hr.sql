SELECT USER
FROM DUAL;
--==>> HR

/*
--※ 참고

1. 관계(relationship, relation)
    - 모든 엔트리(entry)는 단일값을 가진다.
    - 각 열(column)은 유일한 이름을 가지며, 순서는 무의미하다.
    - 테이블의 모든 행(row = 튜플 = tuple)은 동일하지 않으며 순서는 무의미하다.

2. 속성(attribute)
    - 테이블의 열(column)을 나타낸다.
    - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
    - 일반 파일(file)의 항목(아이템 = item = 필드 = field)에 해당한다.
    - 엔티티(entity)의 특성과 상태를 기술
    - 속성(attribute)의 이름은 모두 달라야 한다.
    
3. 튜플(tuple = 엔티티 = entity)
    - 테이블의 행(row)
    - 연관된 몇 개의 속성으로 구성
    - 개념 정보 단위
    - 일반 파일(file)의 레코드(record)에 해당한다.
    - 튜플 변수(tuple variable)
        : 튜플(tuple)을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수

4. 도메인(domain)
    - 각 속성(attribute)이 가질 수 있도록 허용된 값들의 집합
    - 속성명과 도메인명이 반드시 동일할 필요는 없음
    - 모든 릴레이션에서 모든 속성들의 도메인은 원자적(atomic)이어야 함.
    - 원자적 도메인
        : 도메인의 원소가 더 이상 나누어질 수 없는 단일체일 때를 나타냄.

5. 릴레이션(relation)
    - 파일 시스템에서 파일과 같은 개념
    - 중복된 튜플(tuple = entity = 엔티티)을 포함하지 않는다.
        → 모두 상이함(튜플의 유일성)
    - 릴레이션 = 튜플(엔티티 = entity)의 집합. 따라서 튜플의 순서는 무의미하다.
    - 속성(attribute) 간에는 순서가 없다.
*/

--■■■ 무결성(Integrity) ■■■--
/*
1. 무결성에는 개체 무결성(Entity Integrity)
              참조 무결성(Relational Integrity)
              도메인 무결성(Domain Integrity) 이 있다.

2. 개체 무결성
   개체 무결성은 릴레이션에서 저장되는 튜플(tuple)의
   유일성을 보장하기 위한 제약조건이다.

3. 참조 무결성
   참조 무결성은 릴레이션 간의 데이터 일관성을
   보장하기 위한 제약조건이다.

4. 도메인 무결성  (→ 데이터 타입)
   도메인 무결성은 허용 가능한 값의 범위를
   지정하기 위한 제약조건이다.
   
5. 제약조건의 종류   

    - PRIMARY KEY(PK:P) → 부모 테이블의 참조받는 컬럼 → 기본키, 식별자
      해당 컬럼의 갑은 반드시 존재해야 하며, 유일해야 한다.
      (UNIQUE 와 NOT NULL 이 결합된 형태)
      
    - FOREIGN KEY(FK:F:R) → 자식 테이블의 참조하는 컬럼 → 외부키, 외래키, 참조키
      해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와 
      일치하거나 NULL 을 가진다.
      
    - UNIQUE(UK:U)
      테이블 내에서 해당 컬럼의 값은 항상 유일해야 한다.
      
    - NOT NULL(NN:CK:C)
      해당 컬럼은 NULL 을 포함할 수 없다.
      
    - CHECK(CK:C)
      해당 컬럼에서 저장 가능한 데이터의 값의 범위나 조건을 지정한다.
*/

--------------------------------------------------------------------------------

--■■■ PRIMARY KEY ■■■--
/*
1. 테이블에 대한 기본 키를 생성한다.

2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
   기본 키는 테이블 당 최대 하나만 존재한다.
   그러나 반드시 하나의 컬럼으로만 구성되는 것은 아니다.
   NULL일 수 없고, 이미 테이블에 존재하고 있는 데이터를 
   다시 입력할 수 없도록 처리된다.
   UNIQUE INDEX 가 자동으로 생성된다. (오라클이 자체적으로 만든다.)
   
3. 형식 및 구조   
① 컬럼 레벨의 형식
컬럼명 데이터 타입 [CONSTRAINT CONSTRAINT명] PRIMARY KEY[(컬럼명, ...)]

② 테이블 레벨의 형식 (←추천)
컬럼명 데이터 타입
, 컬럼명 데이터 타입
, CONSTRAINT CONSTRAINT명 PRIMARY KEY(컬럼명[, ...])

4. CONSTRAINT 추가 시 CONSTRAINT 명을 생략하면
   오라클 서버가 자동적으로 CONSTRAINT 명을 부여하게 된다.
   일반적으로 CONSTRAINT 명은 『테이블명_컬럼명_CONSTRAINT약어』
   형식으로 기술한다.
*/

















