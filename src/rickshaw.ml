open Js

let js = Js.string

type serie = {
  name : string ;
  color : string ;
  data : (float * float) array
}

class type graph = object
  method render : unit Js.meth
end

module Graph = struct
  class type point = object
    method x : float t writeonly_prop
    method y : float t writeonly_prop
  end

  let point ~x ~y =
    let r : point t = Js.Unsafe.obj [||] in
    r##x <- float x ;
    r##y <- float y ;
    r

  class type serie = object
    method color : js_string t writeonly_prop
    method data : point js_array t writeonly_prop
    method name : js_string t writeonly_prop
  end

  let serie s = 
    let r = Js.Unsafe.obj [||] in
    r##color <- js s.color ;
    r##data <- array (Array.map (fun (x,y) -> point ~x ~y) s.data) ;
    r##name <- js s.name ;
    r

  class type graph_argument = object
    method element : #Dom_html.element t writeonly_prop
    method width  : int t writeonly_prop
    method height : int t writeonly_prop
    method renderer : js_string t writeonly_prop
    method series : serie js_array t writeonly_prop
  end

  let string_of_renderer = function
  | `line -> "line"
  | `bar -> "bar"
  | `scatterplot -> "scatterplot"
  | `stack -> "stack"
  | `area -> "area"

  let graph_constr = Js.Unsafe.variable "Rickshaw.Graph"

  let make ~renderer ~width ~height elt series =
    let arg = Js.Unsafe.obj [||] in
    arg##element <- elt ;
    arg##width <- width ;
    arg##height <- height ;
    arg##renderer <- js (string_of_renderer renderer) ;
    arg##series <- array (Array.map serie series) ;
    Firebug.console##log(arg) ;
    jsnew graph_constr(arg)

  class type legend = object
    method render : unit Js.meth
  end

  module Legend = struct
    let make _ _ = assert false
  end

  class type axis = object
    method render : unit Js.meth
  end

  module Axis = struct
    class type time = object
      method render : unit Js.meth
    end

    module Time = struct
      class type argument = object
        method graph : graph Js.t writeonly_prop
      end

      let constructor = Js.Unsafe.variable "Rickshaw.Graph.Axis.Time"
      let make g =
        let arg = Js.Unsafe.obj [||] in
        arg##graph <- g ;
        jsnew constructor(arg)
    end
  end
end
