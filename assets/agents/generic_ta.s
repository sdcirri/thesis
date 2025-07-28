
function DayLoop(env: TradingPlatform):
  if should_buy() then                  // logic depends from agent
    buyprice ← env.get_current_price()  // open
    amt ← how_much_to_buy(buyprice)
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

