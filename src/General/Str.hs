{-# LANGUAGE PatternGuards #-}

-- | ByteString wrappers which don't require special imports and are all UTF8 safe 
module General.Str(
    Str, strPack, strUnpack, strReadFile, strSplitInfix, strNull, strConcat, strStripPrefix, strStripSuffix, strTrimStart, strUnlines, strUnwords,
    LStr, lstrPack, lstrUnpack, lstrLines, lstrToChunks, lstrFromChunks, lstrToStr
    ) where

import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.UTF8 as US
import qualified Data.ByteString.Lazy.Char8 as LBS
import qualified Data.ByteString.Lazy.UTF8 as LUS
import Data.Char


type Str = BS.ByteString

type LStr = LBS.ByteString


strPack :: String -> Str
strPack = US.fromString

strUnpack :: Str -> String
strUnpack = US.toString

strReadFile :: FilePath -> IO Str
strReadFile = BS.readFile

strSplitInfix :: Str -> Str -> Maybe (Str, Str)
strSplitInfix needle haystack
    | (a,b) <- BS.breakSubstring needle haystack
    , not $ BS.null b
    = Just (a, BS.drop (BS.length needle) b)
strSplitInfix _ _ = Nothing

strNull :: Str -> Bool
strNull = BS.null

strConcat :: [Str] -> Str
strConcat = BS.concat

strStripPrefix :: Str -> Str -> Maybe Str
strStripPrefix needle x
    | BS.isPrefixOf needle x = Just $ BS.drop (BS.length needle) x
    | otherwise = Nothing

strStripSuffix :: Str -> Str -> Maybe Str
strStripSuffix needle x
    | BS.isSuffixOf needle x = Just $ BS.take (BS.length x - BS.length needle) x
    | otherwise = Nothing

strTrimStart :: Str -> Str
strTrimStart = BS.dropWhile isSpace

strUnlines :: [Str] -> Str
strUnlines = BS.unlines

strUnwords :: [Str] -> Str
strUnwords = BS.unwords

lstrLines :: LStr -> [LStr]
lstrLines = LBS.lines

lstrToChunks :: LStr -> [Str]
lstrToChunks = LBS.toChunks

lstrToStr :: LStr -> Str
lstrToStr = BS.concat . LBS.toChunks

lstrFromChunks :: [Str] -> LStr
lstrFromChunks = LBS.fromChunks

lstrUnpack :: LStr -> String
lstrUnpack = LUS.toString

lstrPack :: String -> LStr
lstrPack = LUS.fromString
