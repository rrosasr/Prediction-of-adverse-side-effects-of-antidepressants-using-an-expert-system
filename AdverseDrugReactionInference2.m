clc
clear

% Create a figure window
fig = uifigure('Name', 'Antidepressant Side Effect Prediction');

% Add input boxes for sex, age, antidepressant, and other drugs
sexLabel = uilabel(fig, 'Text', 'Sex:', 'Position', [50, 300, 100, 22]);
sexInput = uidropdown(fig, 'Items', {'Female', 'Male'}, 'Position', [250, 300, 100, 22]);

ageLabel = uilabel(fig, 'Text', 'Age:', 'Position', [50, 250, 100, 22]);
ageInput = uieditfield(fig, 'Position', [250, 250, 100, 22]);

antidepressantLabel = uilabel(fig, 'Text', 'Type of Antidepressant:', 'Position', [50, 200, 150, 22]);
antidepressantInput = uidropdown(fig, 'Items', {'SSRI', 'SNRI', 'TCA', 'MAOI', 'SM' , 'AD'}, 'Position', [250, 200, 100, 22]);

otherDrugsLabel = uilabel(fig, 'Text', 'Taking Other Drugs:', 'Position', [50, 150, 150, 22]);
otherDrugsInput = uidropdown(fig, 'Items', {'No', 'Yes'}, 'Position', [250, 150, 100, 22]);

% Add a button to submit the inputs
submitButton = uibutton(fig, 'push', 'Text', 'Submit', 'Position', [150, 100, 100, 30],...
    'ButtonPushedFcn', @(btn,event) submitCallback(sexInput.Value, str2double(ageInput.Value),...
    antidepressantInput.Value, otherDrugsInput.Value));
delete(gcf);

% Callback function for the submit button
function submitCallback(sex, age, antidepressant, otherDrugs)
    % Assign values based on user input
    if strcmp(sex, 'Female')
        x = 0;
    else
        x = 1;
    end

    y = age;
    if y < 0 || y > 120
    % Display an error message window
    errordlg('Error: Invalid value of age', 'Input Error');
    error('Input Error');
else
    disp('Loading...');
    end

    switch antidepressant
        case 'SSRI'
            z = 0;
        case 'SNRI'
            z = 1;
        case 'TCA'
            z = 2;
        case 'MAOI'
            z = 3;
        case 'SM'
            z = 4;
        case 'AD'
            z = 5;
    end

    if strcmp(otherDrugs, 'No')
        w = 0;
    else
        w = 1;
    end

    % Display the assigned values
    disp(['x (Sex): ', num2str(x)]);
    disp(['y (Age): ', num2str(y)]);
    disp(['z (Antidepressant): ', num2str(z)]);
    disp(['w (Taking Other Drugs): ', num2str(w)]);

% Define the total number of steps for loading
totalSteps = 100;

% Create a waitbar window
h = waitbar(0, 'Loading...');

% Loop to simulate loading progress
for i = 1:totalSteps
    % Perform some operation here (simulating progress)
    pause(0.05); % Simulate work by pausing for 0.1 second
    
    % Update the waitbar
    waitbar(i / totalSteps, h, sprintf('Loading... %d%%', round(i / totalSteps * 100)));
end

% Close the waitbar window
close(h);

% Once loading is complete, you can continue with your main code here
disp('Loading complete!');

    % Rules
    P1 = min([muc(y), musnri(z), mun(w)]);
    P2 = min([muc(y), mussri(z), mun(w)]);
    P3 = min([muc(y), musnri(z), muy(w)]);
    P4 = min([muc(y), mussri(z), muy(w)]);

    P5 = min([mut(y), max(musnri(z), mussri(z)), mun(w)]);
    P6 = min([mut(y), max(musnri(z), mussri(z)), muy(w)]);

    P7 = min([mua(y), max(musnri(z), mussri(z)), mun(w)]);
    P8 = min([mua(y), max(musnri(z), mussri(z)), muy(w)]);
    P9 = min([mua(y), max(mutca(z), mumaoi(z)), mun(w)]);
    P10 = min([mua(y), max(mutca(z), mumaoi(z)), muy(w)]);

    P11 = min([mue(y), musnri(z), mun(w)]);
    P12 = min([mue(y), mutca(z), mun(w)]);
    P13 = min([mue(y), musnri(z), muy(w)]);
    P14 = min([mue(y), mutca(z), muy(w)]);

    P16 = min([muc(y), musm(z), mun(w)]);
    P17 = min([muc(y), muad(z), mun(w)]);
    P18 = min([muc(y), musm(z), muy(w)]);
    P19 = min([muc(y), muad(z), muy(w)]);

    P20 = min([mut(y), max(musm(z), muad(z)), mun(w)]);
    P21 = min([mut(y), max(musm(z), muad(z)), muy(w)]);

    P22 = min([mua(y), musm(z), mun(w)]);
    P23 = min([mua(y), musm(z), muy(w)]);
    P24 = min([mua(y), muad(z), mun(w)]);
    P25 = min([mua(y), muad(z), muy(w)]);

    P26 = min([mue(y), musm(z), mun(w)]);
    P27 = min([mue(y), muad(z), mun(w)]);
    P28 = min([mue(y), musm(z), muy(w)]);
    P29 = min([mue(y), muad(z), muy(w)]);

    P15 = min([1 - P1, 1 - P2, 1 - P3, 1 - P4, 1 - P5, 1 - P6, 1 - P7, 1 - P8, 1 - P9, 1 - P10, 1 - P11, 1 - P12, 1 - P13, 1 - P14, 1 - P16, 1 - P17, 1 - P18, 1 - P19, 1 - P20, 1 - P21, 1 - P22, 1 - P23, 1 - P24, 1 - P25, 1 - P26, 1 - P27, 1 - P28, 1 - P29]);


    % Relation of the risk result with the rules for Serotonin Syndrome
    if muw(x)
        mu1 = max([P1, P11, P15]);
        mu2 = max([P2, P12, P16, P17, P20, P21]);
        mu3 = max([P4, P3, P5, P7, P9, P13, P14, P18, P19, P22, P24]);
        mu4 = max([P6, P8, P10, P23, P25, P26, P27, P28, P29]);
    elseif mum(x)
        mu1 = max([P1, P11, P15]);
        mu2 = max([P2, P3, P12, P14, P16, P17, P20, P21]);
        mu3 = max([P4, P7, P13, P18, P19, P22, P24, P25]);
        mu4 = max([P5, P6, P8, P9, P10, P23, P26, P28, P27, P29]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk Serotonin Syndrome
    RSS = ((mu2 + 2 * mu3 + 3 * mu4) / (mu1 + mu2 + mu3 + mu4))
    disp('For Serotonin Syndrome');
    if  (0 <= RSS) &&  (RSS <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RSS) && (RSS <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RSS) && (RSS <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RSS) && (RSS <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end
    
    % Relation of the risk result with the rules for Nausea
    if muw(x)
        mu5 = max(P15);
        mu6 = max([P5, P6, P12,P14]);
        mu7 = max([P1, P2, 93, P4, P9, P11, P13, P16, P20, P17, P19, P22, P23, P24, P25]);
        mu8 = max([P7, P8, P10, P18, P21, P26, P27, P28, P29]);
    elseif mum(x)
        mu5 = max(P15);
        mu6 = max([P5, P6, P9, P10, P12, P14, P16, P20, P17, P19, P22, P23, P24, P25]);
        mu7 = max([P1, P2, P3, P4, P11, P13, P18, P21, P26, P27, P28, P29]);
        mu8 = max([P7, P8]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk Nausea
    RN = ((mu6 + 2 * mu7 + 3 * mu8) / (mu5 + mu6 + mu7 + mu8))
    disp('For Nausea');
    if  (0 <= RN) &&  (RN <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RN) && (RN <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RN) && (RN <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RN) && (RN <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end
% Relation of the risk result with the rules for Suicidal Thoughts
    if muw(x)
        mu9 = max([P1, P3,P13,P14, P15]);
        mu10 = max([P2, P4, P5, P6, P9, P10, P11, P12, P22, P23, P26, P27, P28, P29]);
        mu11 = max([P7, P8, P16, P17, P18, P19, P24, P25]);
        mu12 = max([P20, P21]);
    elseif mum(x)
        mu9 = max(P15);
        mu10 = max([P1, P2, P3, P4,P11, P12, P13, P14, P22, P23, P26, P27, P28, P29]);
        mu11 = max([P5, P6, P7, P8, P16, P17, P18, P19, P24, P25]);
        mu12 = max([P9, P10, P20, P21]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk Suicidal Thoughts
    RST = ((mu10 + 2 * mu11 + 3 * mu12) / (mu9 + mu10 + mu11 + mu12))
    disp('For Suicidal Ideation');
    if  (0 <= RST) &&  (RST <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RST) && (RST <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RST) && (RST <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RST) && (RST <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end

% Relation of the risk result with the rules for Drowsiness and Somnolence
    if muw(x)
        mu13 = max(P15);
        mu14 = max([P1, P4, P5, P7, P10,P12]);
        mu15 = max([P2,P3,P6,P8, P9, P11, P14, P20, P21, P22, P23, P24, P25]);
        mu16 = max([P4, P10, P13, P26, P27, P28, P29]);
    elseif mum(x)
        mu13 = max(P15);
        mu14 = max([P5, P6, P7, P8, P12, P22, P23, P24, P25]);
        mu15 = max([P1, P2, P9, P11, P14, P20, P21, P16, P17, P26, P27, P28, 29]);
        mu16 = max([P3, P4, P10, P13, P18, P19]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk for Drowsiness and Somnolence
    RDS = ((mu14 + 2 * mu15 + 3 * mu16) / (mu13 + mu14 + mu15 + mu16))
    disp('For Somnolence');
    if  (0 <= RDS) &&  (RDS <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RDS) && (RDS <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RDS) && (RDS <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RDS) && (RDS <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end

    % Relation of the risk result with the rules for Stomach Issues
    if muw(x)
        mu17 = max(P15);
        mu18 = max([P7,P8,P9,P10, P20, P21, P22, P23, P24, P25]);
        mu19 = max([P5, P6,P11,P12, P13, P14]);
        mu20 = max([P1, P2, P3, P4, P16, P17, P18, P19, P26, P27, P28, P29]);
    elseif mum(x)
        mu17 = max([P7, P8, P9, P10, P15]);
        mu18 = max([P5, P6, P11, P12, P13, P14, P20, P21, P22, P23, P24, P25]);
        mu19 = max([P1, P2, P3, P4, P16, P17, P18, P19, P26, P27, P28, P29]);
        mu20 = max(0);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk for Stomach Issues
    RSI = ((mu18 + 2 * mu19 + 3 * mu20) / (mu17 + mu18 + mu19 + mu20))
    disp('For Gastrointestinal Symptoms');
    if  (0 <= RSI) &&  (RSI <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RSI) && (RSI <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RSI) && (RSI <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RSI) && (RSI <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end

% Relation of the risk result with the rules for Sexual Disorders
    if muw(x)
        mu21 = max([P1,P2,P3,P4,P15,P16,P17,P18,P19]);
        mu22 = max([P5, P6, P12, P14,P26,P27,P28,P29]);
        mu23 = max([P9, P10, P11, P13,P22,P23,P24,P25]);
        mu24 = max([P7,P8,P20,P21]);
    elseif mum(x)
        mu21 = max([P1,P2,P3,P4,P15,P16,P17,P18,P19]);
        mu22 = max([P1, P2, P3, P4,P11, P12, P13, P14,P26,P27,P28,P29]);
        mu23 = max([P5, P6, P9, P10]);
        mu24 = max([P7, P8,P20,P21,P22,P23,P24,P25]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

% Calculation of the risk Sexual Disorders
    RSD = ((mu22 + 2 * mu23 + 3 * mu24) / (mu21 + mu22 + mu23 + mu24))
    disp('For Sexual Disorders');
    if  (0 <= RSD) &&  (RSD <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RSD) && (RSD <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RSD) && (RSD <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RSD) && (RSD <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end

% Relation of the risk result with the rules for Hepatobiliary Disorders
    if muw(x)
        mu25 = max(P15);
        mu26 = max([P1, P2,P3, P4, P5, P6, P7, P8, P16,P17,P18,P19,P20,P21]);
        mu27 = max([P9, P10,P22,P23,P24,P25]);
        mu28 = max([P11, P12, P13, P14,P26,P27,P28,P29]);
    elseif mum(x)
        mu25 = max(P15);
        mu26 = max([P1, P2, P3, P4,P16,P17,P18,P19,P20,P21]);
        mu27 = max([P5, P6, P7, P8,P22,P23,P24,P25]);
        mu28 = max([P9, P10,P11, P12, P13, P14,P26,P27,P28,P29]);
    else
        error('Invalid value of x. It must be either 0 or 1.');
    end

    % Calculation of the risk Hepatobiliary Disorders
    RHB = ((mu26 + 2 * mu27 + 3 * mu28) / (mu25 + mu26 + mu27 + mu28))
    disp('For Hepatobiliary Disorders');
    if  (0 <= RHB) &&  (RHB <= 0.5)
        disp('There is no risk');
    elseif (0.6 <= RHB) && (RHB <= 1.5)
        disp('Low Risk');
    elseif (1.6 <= RHB) && (RHB <= 2.5)
        disp('Medium Risk');
    elseif (2.6 <= RHB) && (RHB <= 3.5)
        disp('High Risk');
    else
        disp('Invalid risk level');
    end

% Define risk levels and corresponding colors
risk_levels = {'No Risk', 'Low Risk', 'Medium Risk', 'High Risk'};
colors = {'w', 'g', 'y', 'r'};
risk_values = [0, 0.5, 1.5, 2.5, 3.5];

% Create a new figure
figure;

% Plot RSS
subplot(2, 4, 1);
idx = find(risk_values <= RSS, 1, 'last');
bar(1, RSS, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Serotonin\nSyndrome'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RN
subplot(2, 4, 2);
idx = find(risk_values <= RN, 1, 'last');
bar(1, RN, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title('Nausea');
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RST
subplot(2, 4, 3);
idx = find(risk_values <= RST, 1, 'last');
bar(1, RST, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Suicidal\nIdeation'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RDS
subplot(2, 4, 4);
idx = find(risk_values <= RDS, 1, 'last');
bar(1, RDS, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Somnolence'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RSI
subplot(2, 4, 5);
idx = find(risk_values <= RSI, 1, 'last');
bar(1, RSI, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Gastrointestinal\nSymptoms'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RSD
subplot(2, 4, 6);
idx = find(risk_values <= RSD, 1, 'last');
bar(1, RSD, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Sexual \nDisorders'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Plot RHB
subplot(2, 4, 7);
idx = find(risk_values <= RHB, 1, 'last');
bar(1, RHB, 'FaceColor', colors{idx}, 'EdgeColor', 'none');
title(sprintf('Hepatobiliary \nDisorders'));
set(gca, 'UserData', risk_levels{idx});
set(gca, 'ButtonDownFcn', @mouseover);
ylim([0 3.5]); % Set y-axis limits

% Function to display mouseover text
function mouseover(src, event)
    text = get(src, 'UserData');
    disp(text);
end
% Define risk levels and corresponding messages
risk_levels = {'No Risk', 'Low Risk', 'Medium Risk', 'High Risk'};
messages = {'There is no risk', 'Low Risk', 'Medium Risk', 'High Risk'};
risk_values = [0, 0.5, 1.5, 2.5, 3.5];

% Find the risk level for each quantity
rss_idx = find(risk_values <= RSS, 1, 'last');
rn_idx = find(risk_values <= RN, 1, 'last');
rst_idx = find(risk_values <= RST, 1, 'last');
rds_idx = find(risk_values <= RDS, 1, 'last');
rsi_idx = find(risk_values <= RSI, 1, 'last');
rsd_idx = find(risk_values <= RSD, 1, 'last');
rhb_idx = find(risk_values <= RHB, 1, 'last');

% Create messages for each quantity
rss_message = messages{rss_idx};
rn_message = messages{rn_idx};
rst_message = messages{rst_idx};
rds_message = messages{rds_idx};
rsi_message = messages{rsi_idx};
rsd_message = messages{rsd_idx};
rhb_message = messages{rhb_idx};

% Construct the message for the pop-up window
popup_message = {['Serotonin Syndrome Risk: ', rss_message], ...
    ['Nausea Risk: ', rn_message], ...
    ['Suicidal Ideation Risk: ', rst_message],...
     ['Somnolence Risk: ', rds_message],...
     ['Gastrointestinal Symptoms Risk: ', rsi_message],...
     ['Sexual Disorders Risk: ', rsd_message],...
     ['Hepatobiliary Disorders Risk: ', rhb_message]}


% Display the pop-up window
msgbox(popup_message, 'Risk Assessment');
end

%when patient is a woman
function m = muw(x)
    if (x == 0)
        m = 1;
    else
        m = 0;
    end
end

%When patient is a man
function m = mum(x)
    if (x == 1)
        m = 1;
    else
        m = 0;
    end
end

% When the patient is a child
function m = muc(y)
    if (y < 9)
        m = 1;
    elseif (y < 12)
        m = -(y - 12) / 3;
    else
        m = 0;
    end
end

% When patient is an adolescent
function m = mut(y)
    if ((9 < y) && (y < 12))
        m = (y - 9) / 3;
    elseif ((12 <= y) && (y <= 15))
        m = 1;
    elseif ((15 < y) && (y < 18))
        m = -(y - 18) / 3;
    else
        m = 0;
    end
end

% When patient is an adult
function m = mua(y)
    if ((15 < y) && (y < 18))
        m = (y - 15) / 3;
    elseif ((18 <= y) && (y <= 60))
        m = 1;
    elseif ((60 < y) && (y < 65))
        m = -(y - 65) / 5;
    else
        m = 0;
    end
end

% When patient is an elderly
function m = mue(y)
    if (y < 60)
        m = 0;
    elseif (y < 65)
        m = (y - 60) / 5;
    else
        m = 1;
    end
end

% When patient takes SSRI
function m = mussri(z)
    if (z == 0)
        m = 1;
    else
        m = 0;
    end
end

% When patient takes SNRI
function m = musnri(z)
    if (z == 1)
        m = 1;
    else
        m = 0;
    end
end

% When patient takes TCA
function m = mutca(z)
    if (z == 2)
        m = 1;
    else
        m = 0;
    end
end

% When patient takes MAOI
function m = mumaoi(z)
    if (z == 3)
        m = 1;
    else
        m = 0;
    end
end

% When patient takes SM
function m = musm(z)
    if (z == 4)
        m = 1;
    else
        m = 0;
    end
end

% When patient takes AD
function m = muad(z)
    if (z == 5)
        m = 1;
    else
        m = 0;
    end
end

% If the patient takes another drug
function m = muy(w)
    if (w == 1)
        m = 1;
    else
        m = 0;
    end
end

% If the patient doesn't take another drug
function m = mun(w)
    if (w == 0)
        m = 1;
    else
        m = 0;
    end
end