{-# LANGUAGE OverloadedStrings #-}
module ResumeStyles where
import Clay
import Clay.Common (baseline)
import Clay.Font
import Clay.FontFace
import Clay.Selector (selectorFromText)
import Clay.Elements
import Control.Monad
import Data.Text

zero = 0 :: Size LengthUnit

resetRules = do
  margin zero zero zero zero
  padding zero zero zero zero
  borderWidth zero
  fontSize (pct 100)
  verticalAlign vAlignBaseline

selectorsToReset =
  [ html
  , body
  , Clay.div
  , Clay.span
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
  , address
  , cite
  , code
  , del
  , dfn
  , Clay.Elements.em
  , img
  , ins
  , kbd
  , q
  , s
  , samp
  , Clay.small
  , strong
  , sub
  , sup
  , var
  , b
  , u
  , i
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

zeroMargin =
    margin zero zero zero zero

styleReset :: Css
styleReset = do
  forM_ selectorsToReset (? resetRules)
  forM_ selectorsToBlockify (? display block)
  body ? lineHeight (unitless 1)
  forM_ [ol, ul] (? do
    listStylePosition none
    listStyleImage none
    listStyleType none
    zeroMargin
    padding zero zero zero zero
                 )
  forM_ [blockquote, q] (? do
    before & do
      content none
    after & do
      content none
    )
  table ? do
    borderCollapse collapse
    borderSpacing zero

mainColor = "#222222"
generalFontSizeUnits = 11
generalFontSize = mm generalFontSizeUnits

sectionFontSize = mm (9.18)
subsectionFontSize = mm (6.36)



-- meta constants (e.g. for address, phone)
metaFontSize = mm (generalFontSizeUnits / 2);

-- list constants
listFontSize = mm (generalFontSizeUnits / 2);

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
  star ? do
    color mainColor
    fontFamily ["LibreBaskerville"] [serif]
  h1 ? do
    fontSize (mm 16)
    fontFamily ["ComputerModern"] [serif]
  h2 ?
    do
      fontSize sectionFontSize
      padding sectionFontSize zero zero zero
      zeroMargin
      borderBottom solid (px 1) "#024418"
      display inlineBlock
  h3 ?
    do
      fontSize subsectionFontSize
      padding subsectionFontSize zero (mm 2) zero
      zeroMargin
  li ? do
    listStyleType circleListStyle
    listStylePosition inside
    fontSize listFontSize
    lineHeight (unitless 1.4)
    marginLeft (mm 2)
  ".job__location" ? do
      fontSize (mm (generalFontSizeUnits / 2.2))
      fontStyle italic
  ".meta" ? do
    paddingBottom (mm 10)
  ".meta__row" ? do
      display block
      clear both
      lineHeight (unitless 1.2)
  forM_ leftMetas (? leftMetaStyles)
  forM_ rightMetas (? rightMetaStyles)
  forM_ (leftMetas ++ rightMetas) (? metaStyles)

stylesheet = render resumeStyles

printTheStyles :: IO ()
printTheStyles = do
  print stylesheet
