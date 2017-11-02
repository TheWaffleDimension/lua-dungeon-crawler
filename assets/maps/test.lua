return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 64,
  height = 64,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../images/tiles.png",
      imagewidth = 96,
      imageheight = 224,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 65,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "main",
      x = 0,
      y = 0,
      width = 64,
      height = 64,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = false
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJztz0EKgAAMA8GqoIL6/+/aR4QedAZyz1ZB1dJbQ9uGvyfsvSO0c/h7gn79+vXr16//f/1X7w7tGf4OAAAAAAAAAAAAAAAAX/UCN9IGBQ=="
    },
    {
      type = "tilelayer",
      name = "solid",
      x = 0,
      y = 0,
      width = 64,
      height = 64,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJztz6ENAEAIBEHaov/G3mNAfIJgJjl/GwFM5faBZfpv039D7cxmAAAAAAAAAAAAAAAAAMA/D5ZnAx8="
    }
  }
}
