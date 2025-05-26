// 심화1
// tutorial 데이터베이스 선택
const db = db.getSiblingDB("tutorial");
// 1. users 컬렉션에 username이 smith, jones인 문서 추가
db.users.insertMany([
    {username: "smith"},
    {username: "jones"}
]);

// 2. smith 문서를 다음과 같이 수정
db.users.updateOne(
    {username: "smith"},
    {
        $set: {
            favorites: {
                cities: ["Chicago", "Cheyenne"],
                movies: [
                    "Casablanca", "For a Few Dollars More", "The Sting"
                ]
            }
        }
    }
);

// 3. jones 문서를 다음과 같이 수정
db.users.updateOne(
    {username: "jones"},
    {
        $set: {
            favorites: {
                movies: ["Casablanca", "Rocky"]
            }
        }
    }
);

// 4. Casablanca 영화를 좋아하는 사용자 찾기
db.users.find({
    "favorites.movies": "Casablanca"
}).forEach(doc => printjson(doc));

// 5. Casablanca 좋아하는 사용자에게 'The Maltese Falcon' 영화 추가 (중복 없이)
db.users.updateMany(
    {"favorites.movies": "Casablanca"},
    {
        $addToSet: {"favorites.movies": "The Maltese Falcon"}
    }
);

// 확인 출력
db.users.find({
    "favorites.movies": {$in: ["Casablanca", "The Maltese Falcon"]}
}).forEach(doc => printjson(doc));

// 심화2
// 1. numbers 컬렉션에 20,000개 문서 생성
const db = db.getSiblingDB("test");
let docs = [];
for (let i = 0; i < 20000; i++) {
    docs.push({ num: i });
    if (docs.length === 1000) {
        db.numbers.insertMany(docs);
        docs = [];
    }
}
if (docs.length > 0) db.numbers.insertMany(docs);

// 2. numbers 컬렉션의 문서 개수 출력
print(db.numbers.countDocuments());

// 3. num이 20 이상 25 이하인 문서 출력
db.numbers.find({ num: { $gte: 20, $lte: 25 } }).forEach(doc => printjson(doc));

// 4. 위 쿼리의 실행 통계 출력
db.numbers.find({ num: { $gte: 20, $lte: 25 } }).explain("executionStats");

// 5. num 필드에 인덱스 생성
db.numbers.createIndex({ num: 1 });

// 6. 생성된 인덱스 정보 출력
printjson(db.numbers.getIndexes());

// 7. 인덱스가 있을 때 동일한 쿼리의 실행 통계 출력
db.numbers.find({ num: { $gte: 20, $lte: 25 } }).explain("executionStats");
