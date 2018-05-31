//
//  TRCitiesService.m
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

#import "TRCitiesService.h"
#import "TRCityModel.h"

@interface TRCitiesService()

@property (strong, nonatomic) NSArray<TRCityModel *> *citiesStorage;

@end

@implementation TRCitiesService

- (instancetype)init
{
    self = [super init];

    if (self) {
        TRCityModel *rostovModel = [[TRCityModel alloc] init];
        rostovModel.uid = 0;
        rostovModel.name = @"Ростов-на-Дону";
        rostovModel.image = [UIImage imageNamed:@"Rostov"];
        rostovModel.detailInformation = @"Ростов-на-Дону (в разговорной речи часто — Ростов) — крупнейший город на юге Российской Федерации, административный центр Южного федерального округа и Ростовской области. Основан по грамоте императрицы Елизаветы Петровны от 15 декабря 1749 года.\n\nНаселение 1 125 299 человек (2017), это десятый по численности населения город России. В пределах Ростовской агломерации проживает свыше 2,16 млн человек (четвёртая по численности агломерация страны).";

        TRCityModel *moscowModel = [[TRCityModel alloc] init];
        moscowModel.uid = 1;
        moscowModel.name = @"Москва";
        moscowModel.image = [UIImage imageNamed:@"Moscow"];
        moscowModel.detailInformation = @"Москвa — столица Российской Федерации, город федерального значения, административный центр Центрального федерального округа и центр Московской области, в состав которой не входит.\n\nКрупнейший по численности населения город России и её субъект — 12 506 468 чел. (2018), самый населённый из городов, полностью расположенных в Европе, входит в первую десятку городов мира по численности населения. Центр Московской городской агломерации.";

        TRCityModel *petersburgModel = [[TRCityModel alloc] init];
        petersburgModel.uid = 2;
        petersburgModel.name = @"Санкт-Петербург";
        petersburgModel.image = [UIImage imageNamed:@"StPetersburg"];
        petersburgModel.detailInformation = @"Санкт-Петербург (с 18 [31] августа 1914 года до 26 января 1924 года — Петроград, с 26 января 1924 года до 6 сентября 1991 года — Ленинград) — второй по численности населения город России. Город федерального значения. Административный центр Северо-Западного федерального округа и Ленинградской области. Основан 16 (27) мая 1703 года Петром I. В 1712—1918 годах столица Российского государства.";

        TRCityModel *samaraModel = [[TRCityModel alloc] init];
        samaraModel.uid = 3;
        samaraModel.name = @"Самара";
        samaraModel.image = [UIImage imageNamed:@"Samara"];
        samaraModel.detailInformation = @"Самара — город в Среднем Поволжье России, центр Поволжского экономического района и Самарской области, образует городской округ Самара. Город трудовой и боевой славы (2016).\n\nНаселение — 1 169 719 чел. (2017), девятый по численности населения город России. В пределах агломерации (третьей по численности населения в России) проживает свыше 2,7 млн человек.";

        TRCityModel *novgorodModel = [[TRCityModel alloc] init];
        novgorodModel.uid = 4;
        novgorodModel.name = @"Нижний Новгород";
        novgorodModel.image = [UIImage imageNamed:@"NNovgorod"];
        novgorodModel.detailInformation = @"Нижний Новгород (в разговорной речи часто — Нижний, с 1932 по 1990 год — Горький) — город в центральной России, административный центр Приволжского федерального округа и Нижегородской области. Крупнейший по численности населения город в Приволжском федеральном округе и на реке Волге. Основан, предположительно, 4 февраля 1221 года владимирским князем Юрием Всеволодовичем.";

        TRCityModel *sochiModel = [[TRCityModel alloc] init];
        sochiModel.uid = 5;
        sochiModel.name = @"Сочи";
        sochiModel.image = [UIImage imageNamed:@"Sochi"];
        sochiModel.detailInformation = @"Сочи — город в России, расположен на северо-восточном побережье Чёрного моря (Черноморское побережье России) в Краснодарском крае, на расстоянии 1700 км от Москвы.\n\nСочи — крупнейший курортный город России, важный транспортный узел, а также крупный экономический и культурный центр черноморского побережья России.";

        self.citiesStorage = @[moscowModel, petersburgModel, rostovModel, novgorodModel, samaraModel, sochiModel];
    }

    return self;
}

#pragma mark - TRCitiesServiceProtocol

- (void)fetchCitiesWithCompletion:(void (^)(NSArray<TRCityModel *> *cities))completion {
    completion(self.citiesStorage);
}

- (void)fetchCityWithId:(NSInteger)cityId completion:(void (^)(TRCityModel *city))completion {
    NSInteger index = [self.citiesStorage indexOfObjectPassingTest:^BOOL(TRCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return obj.uid == cityId;
    }];

    completion(self.citiesStorage[index]);
}

@end
