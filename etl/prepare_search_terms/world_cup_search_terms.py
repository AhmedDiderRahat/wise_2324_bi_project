import csv
import json
from prepare_search_terms import * 


if __name__ == '__main__':
    
    SEARCH_TERM_LANGUAGES_FILE = 'etl/world_cup_search_terms/search_term_langs.json'
    OUTPUT_SEARCH_TERMS = 'data/materialized_view_data/wc_search_terms.csv'

    LANGUAGES = [
        'global',
        'en',
        'de',
        #'fr',
        #'es',
        #'pt',
        #'it',
        #'nl'
    ]
    
    OPTIONS = {
        'insert_letter': False,
        'missing_letter': True,
        'reverse_letter': True,
        'wrong_letter': True
    }
    
    with open(SEARCH_TERM_LANGUAGES_FILE, mode='r') as file:
        data_dict = json.loads(file.read())
        
    search_terms = create_search_terms(data_dict, languages=LANGUAGES, options=OPTIONS)
    with open(OUTPUT_SEARCH_TERMS, mode='w', newline='\n', encoding='UTF-8') as file:
        writer = csv.writer(file, doublequote=True)
        for term in search_terms:  
            writer.writerow([term])
