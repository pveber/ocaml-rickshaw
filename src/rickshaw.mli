type graph = private < render : unit Js.meth ; .. > 
type serie = {
  name : string ;
  color : string ;
  data : (float * float) array
}

module Graph : sig
  val make :
    renderer:[`line | `area | `stack | `bar | `scatterplot] ->
    width:int -> height:int -> #Dom_html.element Js.t ->
    serie array ->
    graph Js.t

  type legend = private < .. >

  module Legend : sig
    val make : 
      graph Js.t -> 
      #Dom_html.element Js.t ->
      legend Js.t
  end

  type axis = private < render : unit Js.meth ; .. >

  module Axis : sig
    type time = private < render : unit Js.meth ; .. >

    module Time : sig
      val make : graph Js.t -> time Js.t
    end
  end
end

