{-# LANGUAGE OverloadedStrings #-}
module ResumeStyles where
import Clay
import Clay.Common (baseline)
import Clay.Font
import Clay.Selector (selectorFromText)
import Control.Monad
import Data.Text

zero = 0 :: Size LengthUnit

resetRules = do
  margin zero zero zero zero
  padding zero zero zero zero
  borderWidth zero
  fontSize (pct 100)
--	font Clay.Font.inherit
  verticalAlign vAlignBaseline

selectorsToReset =
  [ html
  , body
  , Clay.div
  , Clay.span
  -- , applet
  , object
  , iframe
  , h1
  , h2
  , h3
  , h4
  , h5
  , h6
  , p
  , blockquote
  , pre
  , a
  , abbr
  -- , acronym
  , address
  -- , big
  , cite
  , code
  , del
  , dfn
  -- , em
  , img
  , ins
  , kbd
  , q
  , s
  , samp
  , Clay.small
  -- , strike
  , strong
  , sub
  , sup
  -- , tt
  , var
  , b
  , u
  , i
  -- , center
  , dl
  , dt
  , dd
  , ol
  , ul
  , li
  , fieldset
  , form
  , label
  , legend
  , table
  , Clay.caption
  , tbody
  , tfoot
  , thead
  , tr
  , th
  , td
  , article
  , aside
  , canvas
  , details
  , embed
  , figure
  , figcaption
  , footer
  , header
  , hgroup
  , Clay.menu
  , nav
  , output
  , ruby
  , section
  , summary
  , time
  , mark
  , audio
  , video
  ]

selectorsToBlockify =
  [ article
  , aside
  , details
  , figcaption
  , figure
  , footer
  , header
  , hgroup
  , Clay.menu
  , nav
  , section
  ]

styleReset :: Css
styleReset = do
  forM_ selectorsToReset (? resetRules)
  forM_ selectorsToBlockify (? display block)
  body ? lineHeight (unitless 1)
  forM_ [ol, ul] (? do
    listStylePosition none
    listStyleImage none
                 )
  -- forM_ [blockquote, q] (? quotes none)
  forM_ [blockquote, q] (? do
    before & do
      content none
    after & do
      content none
    )
  table ? do
    borderCollapse collapse
    borderSpacing zero
--  input (|=) "type" "checkbox" ? margin (0  :: Size LengthUnit)
--  input (|=) "type" "submit"  and disabled... ? color black

mainColor = "#222222"
generalFontSizeUnits = 11
generalFontSize = mm generalFontSizeUnits
titleBorder = border solid (mm 1) "#024418"
spacingScalar = 2.2

sectionFontSize = mm (18 / spacingScalar)
sectionPadding =
    padding sectionFontSize zero sectionFontSize zero

sectionMargin =
    margin sectionFontSize zero sectionFontSize zero

subsectionFontSize = mm (14 / spacingScalar)
subsectionPadding =
    padding subsectionFontSize zero subsectionFontSize zero

subsectionMargin =
    margin subsectionFontSize zero subsectionFontSize zero

nameSize = mm 25
nameFontStyle = italic
nameFontWeight = bold

colorBlue = "#0000ff"

-- meta constants (e.g. for address, phone)
metaFontSize = generalFontSize;

-- list constants
listFontSize = generalFontSize;

addMetaBlock el = selectorFromText (".meta__" <> el)
leftMetas = Prelude.map addMetaBlock ["address", "city", "github"]
rightMetas = Prelude.map addMetaBlock ["phone", "email", "stackoverflow"]

metaStyles = do
  fontSize metaFontSize

leftMetaStyles = do
  textAlign (alignSide sideLeft)
  float floatLeft

rightMetaStyles = do
  textAlign (alignSide sideRight)
  float floatRight

resumeStyles :: Css
resumeStyles =  do
  styleReset
  star ? color mainColor
  h1 ? do
    fontSize nameSize
    fontStyle nameFontStyle
    fontWeight nameFontWeight
  h2 ?
    do
      fontSize sectionFontSize
      sectionPadding
      sectionMargin
  h3 ?
    do
      fontSize subsectionFontSize
      subsectionPadding
      subsectionMargin
  p ? color colorBlue -- really? blue?
  li ? do
    -- listStyleShape circle
    listStylePosition inside
    fontSize listFontSize
    lineHeight (unitless 1.4)
    marginLeft (mm 2)
  ".job__location" ? do
      fontSize (mm (generalFontSizeUnits + 1))
      fontStyle italic
  ".meta" ? do
    paddingBottom (mm 15)
  ".meta__row" ? do
      display block
      clear both
      lineHeight (unitless 1.2)
  forM_ leftMetas (? leftMetaStyles)
  forM_ rightMetas (? rightMetaStyles)
  forM_ (leftMetas ++ rightMetas) (? metaStyles)

--stylesheet :: Text
stylesheet = render resumeStyles

printTheStyles :: IO ()
printTheStyles = do
  print stylesheet
