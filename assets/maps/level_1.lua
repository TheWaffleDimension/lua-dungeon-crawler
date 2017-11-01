return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
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
      name = "tiles_s",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      image = "../../../Episode 8/assets/images/tiles_s.png",
      imagewidth = 50,
      imageheight = 16,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 3,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "foreground",
      x = 0,
      y = 0,
      width = 64,
      height = 64,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["solid"] = "0"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJztwTEBAAAAwqD1T20MH6AAAAAAAAAAAAAAAAAAAACAtwFAAAAB"
    },
    {
      type = "tilelayer",
      name = "tiles-bg",
      x = 0,
      y = 0,
      width = 64,
      height = 64,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["solid"] = "0"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJzt0ssKgCAQQNGh/v+f2wTBoGX0znNgdipeNAIAnjXM0yv9/+4fY2nME9FHf2ne3l96q7U1NbX+MZ3xpNr/3NO/Z1/pjDu13Lv0Vln+z0fmTluttb+atex7Y3/Lvc/qP3L+VfT33Q8AAAAAAAAAAAAAwDdMwHkCQA=="
    },
    {
      type = "tilelayer",
      name = "tiles-solid",
      x = 0,
      y = 0,
      width = 64,
      height = 64,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["solid"] = "1"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJzt01EKgCAQBUDL+985+oulLETScgYWEmHbh5oSAD0toWazXnzPYob88Y4f65g5vz9adyPnPzuv0n6NUfLfZd3F9xnXV3e8pFf+mrO7y//0X199/3G+1vPKPzb5y+vW/Ufzp/y5slr0eNofAAAAAAAAAAAAAICUNgA7AOo="
    }
  }
}
