% vi: ft=prolog

% https://www.nhs.uk/conditions/coronavirus-covid-19/self-isolation-and-treatment/when-to-self-isolate-and-what-to-do
%
%%% Self-isolate immediately if:
%%% 
%%% 1. you have any symptoms of coronavirus (a high temperature, a new, continuous cough or a loss or change to your sense of smell or taste)
%%% 2. you've tested positive for coronavirus – this means you have coronavirus
%%% 3. someone you live with has symptoms or tested positive
%%% 4. someone in your childcare or support bubble has symptoms and you’ve been in close contact with them since their symptoms started or during the 48 hours before they started
%%% 5. someone in your childcare or support bubble tested positive and you’ve been in close contact with them since they had the test or in the 48 hours before their test
%%% 6. you've been told you've been in contact with someone who tested positive – find out what to do if you're told to self-isolate by NHS Test and Trace or the NHS COVID-19 app
%%% 7. you have arrived in England from abroad (not including Ireland, the Channel Islands, the Isle of Man or other parts of the UK) – see GOV.UK: how to quarantine when you arrive in England

ask_question(P, Question) :- format(Question, P),
                             write(' [y/n] '),
                             get_single_char(Code),
                             nl,
                             char_code(Char, Code),
                             Char = 'y'.

tested_positive(P)                        :- ask_question(P, 'Has ~w tested positive for coronavirus within the last 10 days?').


has_continuous_cough(P)                   :- ask_question(P, 'Has ~w got a continuous cough (coughing a lot for more than an hour, or 3 or more coughing episodes in the last 24 hours)?').
lost_taste(P)                             :- ask_question(P, 'Has ~w lost their taste?').
altered_taste(P)                          :- ask_question(P, 'Has ~w experienced any change in their taste?').

has_high_temperature(P)                   :- ask_question(P, 'Has ~w got a high temperature (above 38 degrees celsius)?').

lives_with_others(P)                      :- ask_question(P, 'Does ~w live with other people?').

in_bubble(P)                              :- ask_question(P, 'Is ~w in a childcare or support bubble?').

contact_with_symptomatic_bubble_member(P) :- ask_question(P, 'Has ~w been in close contact with the symptomatic person since 48 hours before their symptoms started?').
contact_with_positive_bubble_member(P)    :- ask_question(P, 'Has ~w been in close contact with the positive person since 48 hours before their test was performed?').

contacted_by_test_and_trace(P)            :- ask_question(P, 'Has ~w been told they\'ve been in contact with a positive person by NHS Test and Trace or the NHS COVID-19 app within the last 10 days?').

arrived_from_abroad_recently(P)           :- ask_question(P, 'Has ~w arrived in England from abroad in the last 10 days?').
has_negative_test_to_release_result(P)    :- ask_question(P, 'Has ~w receieved a negative result through the Test to Release scheme?').

has_symptoms(Person)   :- has_high_temperature(Person); has_continuous_cough(Person); lost_taste(Person); altered_taste(Person).

should_isolate(Person) :- has_symptoms(Person);
                          tested_positive(Person);
                          (
                              lives_with_others(Person),
                              format(atom(LivingWithPeople), 'anyone living with ~w', Person),
                              (
                                  has_symptoms(LivingWithPeople);
                                  tested_positive(LivingWithPeople)
                              )
                          );
                          (
                              in_bubble(Person),
                              format(atom(BubblePeople), 'anyone in ~w\'s bubble', Person),
                              (
                                  (
                                      has_symptoms(BubblePeople),
                                      contact_with_symptomatic_bubble_member(Person)
                                  );
                                  (
                                      tested_positive(BubblePeople),
                                      contact_with_positive_bubble_member(Person)
                                  )
                              )
                          );
                          contacted_by_test_and_trace(Person);
                          (
                              arrived_from_abroad_recently(Person),
                              \+ has_negative_test_to_release_result(Person)
                          ).
