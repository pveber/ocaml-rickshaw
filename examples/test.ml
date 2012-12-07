let (>>=) = Lwt.bind
module Html = Dom_html
let js = Js.string
let document = Html.window##document

let body =
  Js.Opt.get 
    (document##getElementById(js"ml-chart"))
    (fun () -> assert false)

let series = 
  [| 
    { Rickshaw.color = "#000000" ;
      name = "f" ;
      data = Array.init 20 (fun i -> float_of_int i, float_of_int (Random.int 10 + 2)) }
  |]

let main () =
  let g = Rickshaw.Graph.make ~renderer:`line ~width:400 ~height:400 body series in
  let axis = Rickshaw.Graph.Axis.Time.make g in
  g##render () ;
  axis##render ()

let _ = Html.window##onload <- Html.handler (fun _ -> main () ; Js._false)


















