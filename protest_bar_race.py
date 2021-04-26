import pandas as pd
import bar_chart_race as bcr

#filtered_attendees.csv  >>see event_type_analysis.r

df  = pd.read_csv("filtered_attendees.csv")
df.set_index("Date", inplace = True)
cumulative = df.cumsum(axis = 0)

def func(values, ranks):
    return values.quantile(0.9)
bcr.bar_chart_race(cumulative, steps_per_period = 20, 
                   period_length = 200, bar_kwargs = {'alpha':0.9},
                   perpendicular_bar_func = func, cmap='antique',
                   bar_label_size=7, tick_label_size=7, 
                   title='Protest Attendees Count by Event Types')
