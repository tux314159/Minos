{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Home
  ( getHomeR,
    postHomeR,
  )
where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

-- Define our data that will be used for creating the form.
data FileForm = FileForm
  { fileInfo :: FileInfo,
    fileDescription :: Text
  }

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes.yesodroutes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
  (formWidget, formEnctype) <- generateFormPost sampleForm
  let submission = Nothing :: Maybe FileForm
      handlerName = "getHomeR" :: Text

  defaultLayout $ do
    aDomId <- newIdent
    setTitle "Minos"
    $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = undefined

sampleForm :: Form FileForm
sampleForm =
  renderBootstrap3 BootstrapBasicForm $
    FileForm
      <$> fileAFormReq "Choose a file"
      <*> areq textField textSettings Nothing
  where
    -- Add attributes like the placeholder and CSS classes.
    textSettings =
      FieldSettings
        { fsLabel = "What's on the file?",
          fsTooltip = Nothing,
          fsId = Nothing,
          fsName = Nothing,
          fsAttrs =
            [ ("class", "form-control"),
              ("placeholder", "File description")
            ]
        }

commentIds :: (Text, Text, Text)
commentIds = ("js-commentForm", "js-createCommentTextarea", "js-commentList")
