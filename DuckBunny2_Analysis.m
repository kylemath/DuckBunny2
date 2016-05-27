clear variables
close all

Eating_data = Import_Eating('M:\Data\DuckBunny2\OData\DuckBunny2_Fall2015_Eating.xlsx');
Next_data = Import_Next('M:\Data\DuckBunny2\OData\DuckBunny2_Winter2016_Next.xlsx');

Eating_data.Q1 = Eating_data.q1a;
Eating_data.Q2 = Eating_data.q2a;
Eating_data.Q3 = Eating_data.q2b;
Eating_data.Q4 = Eating_data.q2c;
Eating_data.Q5 = Eating_data.q3a;

Next_data.Q1 = Next_data.q1a;
Next_data.Q2 = Next_data.q2a;
Next_data.Q3 = Next_data.q2b;
Next_data.Q4 = Next_data.q2c;
Next_data.Q5 = Next_data.q3a;

import_coding


Eating_data.Spont = Spont(strcmp(Cond,'Eating')==1);
Next_data.Spont = Spont(strcmp(Cond,'Next')==1);



%% Exp 1
fprintf(['In Exp. 1, a total of ' num2str(size(Eating_data,1)) ' students answered a series of questions in a web interface, as part of a general mass-testing survey associated with the introductory psychology research subject pool at the University of Alberta, Department of Psychology in the Fall semester of 2015. Students received credit for completion of the survey, gave informed consent prior to participation, and the survey study was approved as a whole by the internal Research Ethics Board of the University of Alberta. \n']);

%% Eating
%Q3
yesE3 = sum(Eating_data.Q3 == 1);
totalE3 = length(Eating_data.Q3(~(isnan(Eating_data.Q3))));
percent = round((yesE3 / totalE3) * 1000)/10; 
fprintf(['A large proportion of respondents could see matched interpretations when asked (Q3; ' num2str(yesE3) '/' num2str(totalE3) ' responses; ' num2str(percent) '%%). ']);


%Q2
yesE2 = sum(Eating_data.Spont == 1);
totalE2 = length(Eating_data.Q2) - sum(strcmp(Eating_data.Q2,''));
percent = round((yesE2/totalE2) * 1000)/10;
fprintf(['As in our past result, only a small proportion of subjects were coded as indicating, un-cued, that they spontaneously saw a duck next to a rabbit (Q2; ' num2str(yesE2) '/' num2str(totalE2) '; ' num2str(percent) '%%). ']); 

%Q4
yesE4 = sum(Eating_data.Q4 == 1);
totalE4 = length(Eating_data.Q4(~(isnan(Eating_data.Q4))));
percent = round((yesE4 / totalE4) * 1000)/10; 
fprintf(['When explicitly asked to try to see unmatched interpretations, the majority of participants were able to do so, which we refer to as seers (Q4; ' num2str(yesE4) '/' num2str(totalE4) '; ' num2str(percent) '%%). ']);
fprintf(['This value is very similar to the proportion of seers we found in our previous paper (62%%; Jensen & Mathewson, 2011). The ' num2str(totalE4-yesE4) ' remaining respondents, non-seers, were unable to see matched interpretations of the figures.  \n']);
% Next_data = Import_DuckBuny

%% Eating Imperative
%Q5
yesE5 = sum(Eating_data.Q5 == 1);
totalE5 = length(Eating_data.Q5(~(isnan(Eating_data.Q5))));
percent = round((yesE5 / totalE5) * 1000)/10; 
[h,p,chi2stat,df] = prop_test([yesE4 yesE5],[totalE4 totalE5],'false');
fprintf(['Providing the imperative phrase “duck eating the rabbit” increased the overall number of respondents who indicated they could see matched interpretations (Q5; ' ...
    num2str(yesE5) '/' num2str(totalE5) '; ' num2str(percent) '%%; ?2(' num2str(df) ') = ' num2str(round(chi2stat*100)/100) ', p = ' num2str(p) '). ']);

%%Q5|~Q4

q5skip = find(isnan(Eating_data.Q5) == 1);
q4no = find(Eating_data.Q4 == 2);
[C,q4i,q5i] = intersect(q4no,q5skip);
q4no(q4i) = []; %so only those that answer q5

yesE5E4 = length(find(Eating_data.Q5(q4no) == 1));
totalE5E4 = length(Eating_data.Q5(q4no));
percent = round((yesE5E4 / totalE5E4) * 1000)/10; 
fprintf(['Of the non-seers from Q4 who went on to respond to question 5, a large proportion were now able to see the matched interpretations (Q5|~Q4; ' num2str(yesE5E4) '/' num2str(totalE5E4) '; ' num2str(percent) '%%). ']);
fprintf(['Presenting the relational and spatial phrase seems to allow individuals who originally could not see matched interpretations to suddenly see two animals side by side. \n']);


%% Next phrase

%% Next% 

%first find people that already did Eating exp
[c, iEat, iNext] = intersect(Eating_data.stud_id,Next_data.stud_id);

fprintf(['In Exp. 2, a total of ' num2str(size(Next_data,1)) ' additional students answered a new series of questions, as part of a general mass-testing survey in the winter semester of 2016. '...
    'Of these, ' num2str(length(iNext)) ' had already completed Exp. 1 and there data was removed from all further analyses, leaving ' num2str(size(Next_data,1)-length(iNext)) ' remaining. Participants answered the same five questions through the web interface, while seeing the images in Figure 1 with the phrase “Use the following image to answer the questions below”. All questions were identical but for in Exp. 2, the imperative phrase presented red “Imagine the duck is next to the rabbit,” followed by an identical Q5) “Now can you see them as different figures at the same time?” (Yes vs. No). \n']);


Next_data(iNext,:) = [];

%% now questions
%Q3
yesN3 = sum(Next_data.Q3 == 1);
totalN3 = length(Next_data.Q3(~(isnan(Next_data.Q3))));
percent = round((yesN3 / totalN3) * 1000)/10; 
fprintf(['A large proportion of respondents could see matched interpretations when asked (Q3; ' num2str(yesN3) '/' num2str(totalN3) ' responses; ' num2str(percent) '%%). ']);


%Q2
yesN2 = sum(Next_data.Spont == 1);
totalN2 = length(Next_data.Q2) - sum(strcmp(Next_data.Q2,''));
percent = round((yesN2/totalN2) * 1000)/10;
fprintf(['Again, only a small proportion of subjects were coded as indicating, un-cued, that they spontaneously saw a duck next to a rabbit (Q2; ' num2str(yesN2) '/' num2str(totalN2) '; ' num2str(percent) '%%). ']); 

%Q4
yesN4 = sum(Next_data.Q4 == 1);
totalN4 = length(Next_data.Q4(~(isnan(Next_data.Q4))));
percent = round((yesN4 / totalN4) * 1000)/10; 
fprintf(['When explicitly asked to try to see unmatched interpretations, again there were a large proportion of seers (Q4; ' num2str(yesN4) '/' num2str(totalN4) '; ' num2str(percent) '%%). ']);
fprintf(['The ' num2str(totalN4-yesN4) ' remaining non-seers, were unable to see matched interpretations of the figures.  \n']);
% Next_data = Import_DuckBuny


%% Next Imperative
%Q5
yesN5 = sum(Next_data.Q5 == 1);
totalN5 = length(Next_data.Q5(~(isnan(Next_data.Q5))));
percent = round((yesN5 / totalN5) * 1000)/10; 
[h,p,chi2stat,df] = prop_test([yesN4 yesN5],[totalN4 totalN5],'false');
fprintf(['Providing the control phrase “duck next to the rabbit” increased the overall number of respondents who indicated they could see matched interpretations, but much less than in Exp. 1 (Q5; ' ...
    num2str(yesN5) '/' num2str(totalN5) '; ' num2str(percent) '%%; ?2(' num2str(df) ') = ' num2str(round(chi2stat*100)/100) ', p = ' num2str(round(p*1000)/1000) '). ']);

%%Q5|~Q4

q5skip = find(isnan(Next_data.Q5) == 1);
q4no = find(Next_data.Q4 == 2);
[C,q4i,q5i] = intersect(q4no,q5skip);
q4no(q4i) = []; %so only those that answer q5

yesN5N4 = length(find(Next_data.Q5(q4no) == 1));
totalN5N4 = length(Next_data.Q5(q4no));
percent = round((yesN5N4 / totalN5N4) * 1000)/10; 
fprintf(['Of the non-seers from Q4 who went on to respond to question 5, less than half were now able to see the matched interpretations (Q5|~Q4; ' num2str(yesN5N4) '/' num2str(totalN5N4) '; ' num2str(percent) '%%). \n']);

%% Compare

[h,p,chi2stat,df] = prop_test([yesE5E4 yesN5N4],[totalE5E4 totalN5N4],'false');
pE = yesE5E4/totalE5E4;
pN = yesN5N4/totalN5N4;
fprintf(['Comparing the results of Exp. 1 and 2 directly, we find that the imperative phrase “eating” was much more effective and allowing respondents to perceive unmatched interpretations than was that control phrase “next to”. '...
    'The proportion of non-seers in Exp 1 who went on to become seers (' num2str(yesE5E4) '/' num2str(totalE5E4) '; ' num2str(round(pE*1000)/10) ...
    '%%) was reliably larger than the proportion of new seers in Exp. 2 (' num2str(yesN5N4) '/' num2str(totalN5N4) '; ' num2str(round(pN*1000)/10) '%%; ?2(' num2str(df) ') = ' num2str(round(chi2stat*100)/100) ', p = ' num2str(round(p*1000)/1000) '). \n ']);


