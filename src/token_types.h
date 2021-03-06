#ifndef TOKEN_TYPES_H
#define TOKEN_TYPES_H

#include "libpostal.h"

// Doing these as #defines so we can duplicate the values exactly in Python


#define END LIBPOSTAL_TOKEN_TYPE_END

#define WORD LIBPOSTAL_TOKEN_TYPE_WORD
#define ABBREVIATION LIBPOSTAL_TOKEN_TYPE_ABBREVIATION
#define IDEOGRAPHIC_CHAR LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_CHAR
#define HANGUL_SYLLABLE LIBPOSTAL_TOKEN_TYPE_HANGUL_SYLLABLE
#define ACRONYM LIBPOSTAL_TOKEN_TYPE_ACRONYM
#define PHRASE LIBPOSTAL_TOKEN_TYPE_PHRASE

#define EMAIL LIBPOSTAL_TOKEN_TYPE_EMAIL
#define URL LIBPOSTAL_TOKEN_TYPE_URL
#define US_PHONE LIBPOSTAL_TOKEN_TYPE_US_PHONE
#define INTL_PHONE LIBPOSTAL_TOKEN_TYPE_INTL_PHONE

#define NUMERIC LIBPOSTAL_TOKEN_TYPE_NUMERIC
#define ORDINAL LIBPOSTAL_TOKEN_TYPE_ORDINAL
#define ROMAN_NUMERAL LIBPOSTAL_TOKEN_TYPE_ROMAN_NUMERAL
#define IDEOGRAPHIC_NUMBER LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_NUMBER

#define PERIOD LIBPOSTAL_TOKEN_TYPE_PERIOD
#define EXCLAMATION LIBPOSTAL_TOKEN_TYPE_EXCLAMATION
#define QUESTION_MARK LIBPOSTAL_TOKEN_TYPE_QUESTION_MARK
#define COMMA LIBPOSTAL_TOKEN_TYPE_COMMA
#define COLON LIBPOSTAL_TOKEN_TYPE_COLON
#define SEMICOLON LIBPOSTAL_TOKEN_TYPE_SEMICOLON
#define PLUS LIBPOSTAL_TOKEN_TYPE_PLUS
#define AMPERSAND LIBPOSTAL_TOKEN_TYPE_AMPERSAND
#define AT_SIGN LIBPOSTAL_TOKEN_TYPE_AT_SIGN
#define POUND LIBPOSTAL_TOKEN_TYPE_POUND
#define ELLIPSIS LIBPOSTAL_TOKEN_TYPE_ELLIPSIS
#define DASH LIBPOSTAL_TOKEN_TYPE_DASH
#define BREAKING_DASH LIBPOSTAL_TOKEN_TYPE_BREAKING_DASH
#define HYPHEN LIBPOSTAL_TOKEN_TYPE_HYPHEN
#define PUNCT_OPEN LIBPOSTAL_TOKEN_TYPE_PUNCT_OPEN
#define PUNCT_CLOSE LIBPOSTAL_TOKEN_TYPE_PUNCT_CLOSE
#define DOUBLE_QUOTE LIBPOSTAL_TOKEN_TYPE_DOUBLE_QUOTE
#define SINGLE_QUOTE LIBPOSTAL_TOKEN_TYPE_SINGLE_QUOTE
#define OPEN_QUOTE LIBPOSTAL_TOKEN_TYPE_OPEN_QUOTE
#define CLOSE_QUOTE LIBPOSTAL_TOKEN_TYPE_CLOSE_QUOTE
#define SLASH LIBPOSTAL_TOKEN_TYPE_SLASH
#define BACKSLASH LIBPOSTAL_TOKEN_TYPE_BACKSLASH
#define GREATER_THAN LIBPOSTAL_TOKEN_TYPE_GREATER_THAN
#define LESS_THAN LIBPOSTAL_TOKEN_TYPE_LESS_THAN

#define OTHER LIBPOSTAL_TOKEN_TYPE_OTHER
#define WHITESPACE LIBPOSTAL_TOKEN_TYPE_WHITESPACE
#define NEWLINE LIBPOSTAL_TOKEN_TYPE_NEWLINE

#define INVALID_CHAR LIBPOSTAL_TOKEN_TYPE_INVALID_CHAR


#define is_word_token(type) ((type) == WORD || (type) == ABBREVIATION || (type) == ACRONYM || (type) == IDEOGRAPHIC_CHAR || (type) == HANGUL_SYLLABLE)

#define is_ideographic(type) ((type) == IDEOGRAPHIC_CHAR || (type) == HANGUL_SYLLABLE || (type) == IDEOGRAPHIC_NUMBER)

#define is_numeric_token(type) ((type) == NUMERIC || (type) == IDEOGRAPHIC_NUMBER)

#define is_punctuation(type) ((type) >= PERIOD && (type) < OTHER)

#define is_special_punctuation(type) ((type) == AMPERSAND || (type) == PLUS || (type) == POUND)

#define is_special_token(type) ((type) == EMAIL || (type) == URL || (type) == US_PHONE || (type) == INTL_PHONE)

#define is_whitespace(type) ((type) == WHITESPACE)

#endif
