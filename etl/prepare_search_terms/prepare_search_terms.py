# some functions are inspired by https://github.com/ncouture/TypoGenerator/blob/master/typogenerator.py
LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"

def _missing_letter(s: str) -> list:
    typo_words = []
    for i in range(1, len(s) + 1):
        typo_words.append(s[:i - 1] + s[i:])
    return typo_words


def _insert_letter(s: str) -> list:
    typo_words = []
    for i in range(0, len(s) + 1):
        typo_words += [s[:i] + char + s[i:] for char in LETTERS]
    return typo_words


def _wrong_letter(s: str) -> list:
    typo_words = []
    for i in range(0, len(s)):
        typo_words += [s[:i] + char + s[i + 1:] for char in LETTERS]
    return typo_words


def _reverse_letter(s: str) -> list:
    typo_words = []
    for i in range(0, len(s) - 1):
        typo_words.append(s[:i] + s[i+1] + s[i] + s[i + 2:])
    return typo_words

def _apply_typos(terms: list[str], insert_letter=False,
                     missing_letter=False,
                     reverse_letter=False,
                     wrong_letter=False) -> set:
    typo_functions = {
        'insert_letter': _insert_letter,
        'missing_letter': _missing_letter,
        'reverse_letter': _reverse_letter,
        'wrong_letter': _wrong_letter
    }
    
    local_dict = locals()
    typo_funcs = [v for k, v in typo_functions.items() if k in local_dict and local_dict[k]]
    terms_with_typos = set()
    for term in terms:
        words = term.lower().split(" ")
        for i, word in enumerate(words):
            for func in typo_funcs:
                typo_words = func(word) + [word]
                terms_with_typos.update([_words_list_to_term(words[:i]) \
                                         + (" " if i > 0 else "") \
                                         + typo_word \
                                         + (" " if i < len(words) - 1 else "") \
                                         + _words_list_to_term(words[i + 1:]) for typo_word in typo_words])
        
    return terms_with_typos

def _words_list_to_term(words: list) -> str:
    return ' '.join(words)


def create_search_terms(language_dict: dict, languages: set, options: set = {}) -> set:
    filtered_dict = {k: v for k, v in language_dict.items() if k in languages}
    search_terms = set()

    for data in filtered_dict.values():
        curr_typos = _apply_typos(data, **options)
        search_terms.update(curr_typos)
        
    return search_terms
