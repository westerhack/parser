exit
[
  :'=', get,
  l,
    :x,
    :true,
  r,
  call,

  :'disp', get,
  l,
    :'switch', get,
    l,
      :x, get,
      l,
        :'=', get,
        l,
          :true,
          l, :"it's true!", r,
        r,
        call,

        :'=', get,
        l,
          :false,
          l, :"it's false!", r,
        r,
        call,
      r,
    r,
    call,
  r,
  call,
]



[
  :switch, get,
  l,
    :cmp, get,
    l,
      num(2),
      num(3),
    r, call,

    l,
      :'=', get,
      l,
        :<,
        :a,
      r, call,
    r,

  r, call,

]

[
  :'=', get,
  l,
    :whilst,
    l,

      :switch, get,
      l,
        :cmp, get,
        l,
          :x, get,
          num(10),
        r, call,

        l,
          :'=', get,
          l, 
            :<,
            l,
              :disp, get,
              l,
                :x, get,
              r, call,
            r,
          r, call,

          :'=', get,
          l, 
            :==,
            :'',
          r, call,
        r,

      r, call,
      l,
        :y,
      r, call,
    r,
  r, call,

  :whilst, get,
  l,
    :'=', get,
    l,
      :x,
      num(9),
    r, call,
  r, call,
]



[
 :'=', get,
  l,
    :x,
    num(3),
  r, call,

  l,
    :'disp', get,
    l,
      :+, get,
      l, 
        :'x is: ',
        :x, get,
      r, call,
    r, call,
    :'+', get,
    l,
      :x, get,
      num(2),
    r, call,
  r,
  l,
    :'=', get,
    l,
      :'x',
      :+, get,
      l,
        :'x', get,
        num(4),
      r, call,
    r, call,
  r, call,
  :'disp', get,
  l, :x, get,
  r, call,
]

[
  *set(:whilst,
    *arr(
      *run_id(:switch,
        *run_id(:cmp, *get(:x), num(10)),
        *arr(
          *set(:<, *arr(
            *run_id( :disp, *get(:x) ),
            *run_id(:whilst, *set(:x, *run_id(:+, *get(:x), num(1)))),
            )),
          *set(DEFAULT, *arr),
        )
      ),
      *arr, CALL,
      *get(:x),
    )),

  *run_id(:whilst,  *set(:x, num(0)))
]