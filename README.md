# prolog-isolation-checker

Should you be self-isolating right now? You could check using the government's
website\*, but that would be boring - check by seeing if Prolog can satisfy the
fact that you should be self-isolating.

\* jokes aside, please do use the
[government's
website](https://www.nhs.uk/conditions/coronavirus-covid-19/self-isolation-and-treatment/when-to-self-isolate-and-what-to-do).
This tool is for entertainment only and is probably broken, I
haven't written any Prolog since university.

## Usage

You'll need to have Prolog installed. If you use nix, just run `nix-shell` in
the root of the repo.

```
$ swipl should_i_isolate.pl
```

Then enter `should_isolate(your_name).`, and Prolog will try and prove your
query. Example run:

```
?- should_isolate(james).
Has james got a high temperature (above 38 degrees celsius)? [y/n]
Has james got a continuous cough (coughing a lot for more than an hour, or 3 or more coughing episodes in the last 24 hours)? [y/n]
Has james lost their taste? [y/n]
Has james experienced any change in their taste? [y/n]
Has james tested positive for coronavirus within the last 10 days? [y/n]
Does james live with other people? [y/n]
Is james in a childcare or support bubble? [y/n]
Has anyone in james's bubble got a high temperature (above 38 degrees celsius)?  [y/n]
Has anyone in james's bubble got a continuous cough (coughing a lot for more than an hour, or 3 or more coughing episodes in the last 24 hours)? [y/n]
Has anyone in james's bubble lost their taste? [y/n]
Has anyone in james's bubble experienced any change in their taste? [y/n]
Has james been in close contact with the symptomatic person since 48 hours before their symptoms started? [y/n]
Has anyone in james's bubble tested positive for coronavirus within the last 10 days? [y/n]
Has james been in close contact with the positive person since 48 hours before their test was performed? [y/n]
true
```
