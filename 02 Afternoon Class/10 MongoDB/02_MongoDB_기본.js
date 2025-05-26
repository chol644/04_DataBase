// tutorial 데이터베이스 선택
const db = db.getSiblingDB("tutorial");

// users 컬렉션에 username이 smith인 문서를 저장
db.users.insertOne({username: "smith"});

// users 컬렉션에 username이 jones인 문서를 저장
db.users.insertOne({username: "jones"});

// 앞에서 저장한 모든 문서를 출력
db.users.find().forEach(doc => printjson(doc));

// 앞에서 저장한 문서 중 하나만 출력
printjson(db.users.findOne());

// users 컬렉션에서 username이 "jones"인 문서를 찾아서 출력하세요.
db.users.find({"username": "jones"})

// users 컬렉션에서 username이 "jones" 또는 "smith"인 문서를 찾아서 출력하세요.
db.users.find({
    $or: [
        {username: "jones"},
        {username: "smith"}
    ]
})

// users 컬렉션에서 username이 smith인 문서에 country 키가 Canada 가 되도록 수정하세요.
db.users.updateOne({username: "smith"}, {$set: {country: "Canada"}});

// 앞의 문서가 올바르게 수정되었는지 확인하세요.
printjson(db.users.findOne({username: "smith"}));

// users 컬렉션에서 username이 smith인 문서를 {country: "Canada"}로 대체하고 확인하세요.
db.users.replaceOne(
    {username: "smith"},
    {country: "Canada"}
);

// users 컬렉션에서 country가 Canada인 문서를 {username: "smith", country: "Canada"}로
// 대체하고 확인하세요.
db.users.replaceOne(
    {country: "Canada"},
    {username: "smith", country: "Canada"}
);

// users 컬렉션에서 username이 smith인 문서에서 country 키를 삭제하고,
// 삭제 여부를 확인하세요.
const updateResult = db.users.updateOne(
    {username: "smith"},       // 조건
    {$unset: {country: ""}}  // country 필드 제거
);
printjson(db.users.findOne({username: "smith"}));

// 데이터베이스 전체 목록을 출력하세요
printjson(db.adminCommand('listDatabases'));

// 현재 사용 중인 데이터베이스의 컬렉션 목록을 출력하세요.
printjson(db.getCollectionNames());

// 현재 사용 중인 데이터베이스와 users 컬렉션의 상태를 출력하세요
printjson(db.getName());
printjson(db.users.stats());

// users 컬렉션에서 username이 smith인 문서를 삭제하고, 삭제여부를 확인하세요.
const deleteSmithResult = db.users.deleteOne({username: "smith"});
printjson(deleteSmithResult);

// users 컬렉션의 모든 문서를 삭제하고, 삭제 여부를 확인하세요.
const deleteAllResult = db.users.deleteMany({});
printjson(deleteAllResult);

// users 컬렉션을 삭제하세요.
const dropResult = db.users.drop();
printjson(dropResult);

// 다음 형태의 문서 20,000건을 추가하세요.
//  num: 순번 (0부터 시작)
//  name: '스마트폰 ' + 순번
for (let i = 0; i < 200000; i++) {
    db.numbers.insert({num: i}, {name: "스마트폰 " + i});
}

// product 컬렉션의 전체 문서수를 출력하세요
db.numbers.count()

// product 컬렉션의 문서를 num의 내림 차순으로 정렬하여 출력하세요
db.product.find().sort({ num: -1 }).forEach(doc => printjson(doc));

// product 컬렉션의 문서를 num의 내림 차순으로 정렬하여 상위 10건을 출력하세요.
db.product.find().sort({ num: -1 }).limit(10).forEach(doc => printjson(doc));

// product 컬렉션의 문서를 num의 내림 차순으로 정렬한 상태에서 다음을 처리하세요.
db.product.find()
    .sort({ num: -1 })
    .skip(50)
    .limit(10)
    .forEach(doc => printjson(doc));

// product 컬렉션에서 num이 15미만 이거나 19995 초과인 것을 출력하세요.
db.product.find({
    $or: [
        { num: { $lt: 15 } },
        { num: { $gt: 19995 } }
    ]
}).forEach(doc => printjson(doc));

// product 컬렉션에서 name이 '스마트폰 10', '스마트폰 100', '스마트폰 1000' 중에 하나이면 출력하세요.
db.product.find({
    name: { $in: ["스마트폰 10", "스마트폰 100", "스마트폰 1000"] }
}).forEach(doc => printjson(doc));

// product 컬렉션에서 num이 5보다 작은 문서를 출력하는데, name만 출력하세요.
// (_id 출력하면 안됨)
db.product.find(
    { num: { $lt: 5 } },
    { _id: 0, name: 1 }
).forEach(doc => printjson(doc));