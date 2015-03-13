//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Filme.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "eBook.h"
#import "Podcast.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    termo = [termo stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie&limit=10", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setTipo:[item objectForKey:@"kind"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}

- (NSArray *)buscarMusicas:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    termo = [termo stringByReplacingOccurrencesOfString: @" " withString:@"%20"];

    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music&limit=10", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options: NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Musica *musica = [[Musica alloc] init];
        [musica setNome:[item objectForKey:@"trackName"]];
        [musica setArtista:[item objectForKey:@"artistName"]];
        [musica setGenero:[item objectForKey:@"primaryGenreName"]];
        [musica setTipo:[item objectForKey:@"kind"]];
        [musicas addObject:musica];
        [musicas addObject:musica];
    }
    
    return musicas;
}
- (NSArray *)buscareBook:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    termo = [termo stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=ebook&limit=10", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options: NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setTipo:[item objectForKey:@"kind"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}
- (NSArray *)buscarPodcast:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    termo = [termo stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast&limit=10", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options: NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setTipo:[item objectForKey:@"kind"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}



#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
