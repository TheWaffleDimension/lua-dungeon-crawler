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
  properties = {
    ["map_id"] = 0
  },
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
        width = 10,
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
      data = "eJztz9EJwCAQRMEzggmo/berRRxCkhnY/30lIq6k1Xiftncn7Tn8PYN+/fr169ev/3/9fW8kbR7+DgAAAAAAAAAAAAAAAPBlC3CmBgU="
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
      data = "eJztz6ENAEAIBEHaov/G3mNAfIJgJjl/G8FEbh9Ypv82/TfUzmwGAAAAAAAAAAAAAAAAAMBfD+uxAx8="
    }
  }
}
