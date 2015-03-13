//
//  eBook.h
//  iTunesSearch
//
//  Created by Fernando Lucheti on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface eBook : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *tipo;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *autor;
@property (nonatomic, strong) NSString *urlImagem;
@property (nonatomic, strong) NSString *descricao;

@end
