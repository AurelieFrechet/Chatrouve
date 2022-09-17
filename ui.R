f7Page(
  options = list(
    theme = c("ios", "md", "auto", "aurora"),
    dark = FALSE,
    filled = FALSE,
    color = "#fff700",
    touch = list(
      tapHold = TRUE,
      tapHoldDelay = 750,
      iosTouchRipple = FALSE
    ),
    iosTranslucentBars = FALSE,
    navbar = list(
      iosCenterTitle = TRUE,
      hideNavOnPageScroll = TRUE
    ),
    toolbar = list(
      hideNavOnPageScroll = FALSE
    ),
    pullToRefresh = FALSE
  ),
  
  title = "ChatTrouvé",
  f7TabLayout(
    navbar = f7Navbar(
      title    = "ChatTrouvé",
      hairline = TRUE,
      shadow   = TRUE
    ),
    
    f7Tabs(
      animated = TRUE,
      #swipeable = TRUE,
      f7Tab(
        tabName = "Accueil",
        icon    = f7Icon("paw"),
        active  = TRUE
        
      ),
      f7Tab(
        tabName = "Chats",
        icon    = f7Icon("cat"),
        active  = FALSE
      )
    )
  )
)