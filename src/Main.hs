{-# LANGUAGE OverloadedStrings #-}
module Main where
  
import Data.Text.IO
import Data.Text.Lazy
import Text.Pandoc.App as P

import ResumeStyles (stylesheet)
styleSheetPath = "./in/neallred.css"
myOpts =
  let
    Opt optTabStop optPreserveTabs optStandalone optReader optWriter optTableOfContents optBaseHeaderLevel optTemplate optVariables optMetadata optMetadataFile optOutputFile optInputFiles optNumberSections optNumberOffset optSectionDivs optIncremental optSelfContained optHtmlQTags optHighlightStyle optSyntaxDefinitions optTopLevelDivision optHTMLMathMethod optAbbreviations optReferenceDoc optEpubSubdirectory optEpubMetadata optEpubFonts optEpubChapterLevel optEpubCoverImage optTOCDepth optDumpArgs optIgnoreArgs optVerbosity optTrace optLogFile optFailIfWarnings optReferenceLinks optReferenceLocation optDpi optWrapText optColumns optFilters optEmailObfuscation optIdentifierPrefix optStripEmptyParagraphs optIndentedCodeClasses optDataDir optCiteMethod optListings optPdfEngine optPdfEngineArgs optSlideLevel optSetextHeaders optAscii optDefaultImageExtension optExtractMedia optTrackChanges optFileScope optTitlePrefix optCss optIpynbOutput optIncludeBeforeBody optIncludeAfterBody optIncludeInHeader optResourcePath optRequestHeaders optEol optStripComments = P.defaultOpts
    in
      P.Opt { optTabStop = optTabStop 
                     , optPreserveTabs = False
                     , optStandalone = True
                     , optReader = Just "markdown"
                     , optWriter = Just "html5"
                     , optTableOfContents = optTableOfContents
                     , optBaseHeaderLevel = optBaseHeaderLevel
                     , optTemplate = optTemplate
                     , optVariables = [ ("margin-top", "12mm")
                     , ("margin-right", "12mm")
                     , ("margin-bottom", "12mm")
                     , ("margin-left", "12mm")
                     , ("papersize", "letter")
                     ]
                     , optMetadata = [("pagetitle", "Nathaniel Allred resume")]
                     , optMetadataFile = optMetadataFile
                     , optOutputFile = Just "./out/neallred.pdf"
                     , optInputFiles = ["./in/neallred.md"]
                     , optNumberSections = optNumberSections
                     , optNumberOffset = optNumberOffset
                     , optSectionDivs = optSectionDivs
                     , optIncremental = optIncremental
                     , optSelfContained = optSelfContained
                     , optHtmlQTags = optHtmlQTags
                     , optHighlightStyle = optHighlightStyle
                     , optSyntaxDefinitions = optSyntaxDefinitions
                     , optTopLevelDivision = optTopLevelDivision
                     , optHTMLMathMethod = optHTMLMathMethod
                     , optAbbreviations = optAbbreviations
                     , optReferenceDoc = optReferenceDoc
                     , optEpubSubdirectory = optEpubSubdirectory
                     , optEpubMetadata = optEpubMetadata
                     , optEpubFonts = optEpubFonts
                     , optEpubChapterLevel = optEpubChapterLevel
                     , optEpubCoverImage = optEpubCoverImage
                     , optTOCDepth = optTOCDepth
                     , optDumpArgs = optDumpArgs
                     , optIgnoreArgs = optIgnoreArgs
                     , optVerbosity = optVerbosity
                     , optTrace = optTrace
                     , optLogFile = optLogFile
                     , optFailIfWarnings  = optFailIfWarnings 
                     , optReferenceLinks = optReferenceLinks
                     , optReferenceLocation = optReferenceLocation
                     , optDpi = optDpi
                     , optWrapText = optWrapText
                     , optColumns = optColumns
                     , optFilters = optFilters
                     , optEmailObfuscation = optEmailObfuscation
                     , optIdentifierPrefix = optIdentifierPrefix
                     , optStripEmptyParagraphs = True
                     , optIndentedCodeClasses = optIndentedCodeClasses
                     , optDataDir = optDataDir
                     , optCiteMethod = optCiteMethod
                     , optListings = optListings
                     , optPdfEngine = Just "wkhtmltopdf"
                     , optPdfEngineArgs = optPdfEngineArgs
                     , optSlideLevel = optSlideLevel
                     , optSetextHeaders = optSetextHeaders
                     , optAscii = optAscii
                     , optDefaultImageExtension = optDefaultImageExtension
                     , optExtractMedia = optExtractMedia
                     , optTrackChanges = optTrackChanges
                     , optFileScope = optFileScope
                     , optTitlePrefix = optTitlePrefix
                     , optCss = [styleSheetPath]
                     , optIpynbOutput = optIpynbOutput
                     , optIncludeBeforeBody = optIncludeBeforeBody
                     , optIncludeAfterBody = optIncludeAfterBody
                     , optIncludeInHeader = optIncludeInHeader
                     , optResourcePath = optResourcePath
                     , optRequestHeaders = optRequestHeaders
                     , optEol = LF
                     , optStripComments = True
                     }


main :: IO ()
main = do
  Prelude.putStrLn ("Compiling stylesheet and writing to `" ++ styleSheetPath ++ "` ...")
  Data.Text.IO.writeFile styleSheetPath (Data.Text.Lazy.toStrict stylesheet)
  Prelude.putStrLn "Converting resume to pdf..."
  P.convertWithOpts myOpts
