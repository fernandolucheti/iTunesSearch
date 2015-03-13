//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "DetailViewController.h"
#import "Filme.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "eBook.h"
#import "Podcast.h"

@interface TableViewController () {
    NSArray *filmes;
    NSArray *musicas;
    NSArray *podcasts;
    NSArray *eBooks;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    
    //iTunesManager *itunes = [iTunesManager sharedInstance];
    //midias = [itunes buscarMidias:@"Apple"];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    switch (section) {
        case 0:
            count = [filmes count];
            break;
        case 1:
            count = [musicas count];
            break;
        case 2:
            count = [eBooks count];
            break;
        case 3:
            count = [podcasts count];
            break;
        default:
            break;
    }
    return count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detail = [[DetailViewController alloc] init];
    [detail.nome setText:@"chacal"];
    [self.navigationController pushViewController:detail animated:YES];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    
    Filme* filme;
    Musica* musica;
    eBook* ebook;
    Podcast* podcast;
    

    switch (indexPath.section) {
        case 0:

            filme = [filmes objectAtIndex:indexPath.row];
            [celula.nome setText:filme.nome];
            [celula.tipo setText:filme.tipo];
            [celula.tipoFilme setText:filme.genero];
            break;
        case 1:
            musica = [musicas objectAtIndex:indexPath.row];
            [celula.nome setText:musica.nome];
            [celula.tipo setText:musica.tipo];
            [celula.tipoFilme setText:musica.genero];
            
            break;
        case 2:
            ebook = [eBooks objectAtIndex:indexPath.row];
            [celula.nome setText:ebook.nome];
            [celula.tipo setText:ebook.tipo];
            [celula.tipoFilme setText:ebook.genero];
            
            break;
        case 3:

            podcast = [podcasts objectAtIndex:indexPath.row];
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:podcast.tipo];

            
            break;
            
        default:
            break;
    }

    
    return celula;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString* titulo;
    switch (section) {
        case 0:
            titulo = @"Filmes";
            break;
        case 1:
            titulo = @"Musicas";
            break;
        
        case 2:
            titulo = @"eBooks";
            break;
        case 3:
            titulo = @"Podcasts";
            break;
            
        default:
            break;
    }
    return titulo;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - searchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    filmes = [itunes buscarMidias:searchBar.text];
    musicas = [itunes buscarMusicas:searchBar.text];
    eBooks = [itunes buscareBook:searchBar.text];
    podcasts = [itunes buscarPodcast:searchBar.text];
    [self.tableview reloadData];
}


@end
