import csv
import pandas as pd
from prepare_search_terms import *

def lower_all_object_columns_of_df(df: pd.DataFrame):
    string_columns = df.select_dtypes(include='object').columns
    df[string_columns] = df[string_columns].apply(lambda x: x.str.lower().str.strip())

if __name__ == '__main__':
    
    OUTPUT_SEARCH_TERMS = 'data/materialized_view_data/player_search_terms.csv'
    
    OPTIONS = {
        'insert_letter': False,
        'missing_letter': True,
        'reverse_letter': True,
        'wrong_letter': True
    }
    
    world_cup_players = pd.read_csv("./data/input_data/world_cup_players.csv",
                            usecols=['MatchID', 'Player Name'], encoding='UTF-8')
    
    world_cup_matches = pd.read_csv("./data/input_data/world_cup_matches.csv",
                            usecols=['MatchID', 'Year'], encoding='UTF-8')
    
    lower_all_object_columns_of_df(world_cup_players)
    lower_all_object_columns_of_df(world_cup_matches)
    
    merged_matches_players = pd.merge(world_cup_matches, world_cup_players, on='MatchID')
    players_2006 = merged_matches_players[merged_matches_players['Year'] == 2006].copy()
    
    players_2006['Player Name'] = players_2006['Player Name'].replace(['uma�a m.', 'bola�os c.', 'nu�ez v.', 'c�ceres', 'acu�a', 'ca�iza',
       'nu�ez', 'caba�as', 'alvb�ge', 'k�llstr�m', 'allb�ck',
       'jo�o ricardo', 'andr� macanga', 'akw�', 'sim�o', 'z� kalanga',
       'loc�', 'lam�', 'fl�vio', 'm�rio', 'zuberb�hler', 'l�cio', 'kak�',
       'z� roberto', 'luis�o', 'ca�izares'], ['umaña M.', 'bolaños C.', 'nuñez V.', 'céceres', 'acuña', 'cañiza',
 'nuñez', 'cabañas', 'alvbäge', 'källström', 'allbäck',
 'joão ricardo', 'andrè macanga', 'akwá', 'simão', 'zé kalanga',
 'locó', 'lamá', 'flávio', 'mário', 'zuberbühler', 'lúcio', 'kaká',
 'zé roberto', 'luisão', 'cañizares'])
    
    player_names={'names': players_2006['Player Name'].tolist()}

    search_terms = create_search_terms(player_names, languages={'names'}, options=OPTIONS)
    with open(OUTPUT_SEARCH_TERMS, mode='w', newline='\n', encoding='UTF-8') as file:
        writer = csv.writer(file, doublequote=True)
        for term in search_terms:  
            writer.writerow([term])
