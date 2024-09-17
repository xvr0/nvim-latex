return {
	s("flatmap", t("flat_map = lambda f, xs: (y for ys in xs for y in f(ys))"))
, 
	s("numpy", t("import numpy as np"))
}
