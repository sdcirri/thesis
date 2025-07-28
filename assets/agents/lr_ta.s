
function DayLoop(win: array, env: TradingPlatform):
  LinearRegression.fit(win)
  exp_close ← LinearRegression.predict(win.length+1)
  if budget > 0 and exp_close >= lr_threshold then
    buyprice ← env.get_current_price()  // open
    amt ← budget / buyprice             // invest entire budget
    buy(buyprice, amt)
  endif
  current_price ← env.get_current_price()
  while (current_price / buyprice < earn_target)
      and (current_time < '23:59') do
    wait()
    current_price ← env.get_current_price()
    if current_price >= earn_target then
      sell(current_price, total_assets)
    endif
  endwhile
  // End of trading day, unsold assets will be held overnight

