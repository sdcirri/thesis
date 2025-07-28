
function DayLoop(nn: TradingNN, env: TradingPlatform):
  ho ← nn.guess_today_ho()
  if budget > 0 and ho >= earn_target then
    buyprice ← env.get_current_price()  // open
    amt ← budget / buyprice             // invest entire budget
    buy(buyprice, amt)
  endif
  sellprice ← e^ho * buyprice           // e^(ln(h/o))*o = h
  current_price ← env.get_current_price()
  while (current_price < sellprice) and (current_time < '23:59') do
    wait()
    current_price ← env.get_current_price()
    if current_price >= sellprice then
      sell(current_price, total_assets)
    endif
  endwhile
  close ← env.get_current_price()
  if total_assets > 0 and close >= buyprice * earn_target then
    sell(close, total_assets)
  endif
  // End of trading day, unsold assets will be held overnight

