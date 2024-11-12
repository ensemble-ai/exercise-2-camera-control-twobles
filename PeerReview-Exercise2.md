# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Andrew Tran
* *email:* ahhtran@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
There is a 5 by 5 cross in the center of the screen that is centered on the vessel. 

___
### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Although the player is able to move inside the box and is able to autoscroll with the camera, the vessel itself pokes outside of the boxes boundaries. This can be avoided by taking into account the vessel's weight and height, which can be given by doing target.WIDTH or target.HEIGHT. 

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Once the vessel uses the rocket speed up feature, the camera and vessel are way too far away, breaking past the leash's limits. Also, it sometimes bugs and the vessel is locked onto the center of the cross instead of moving in the desired direction. It quickly does fix itself though after a couple of seconds by moving in the desired direction. 

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The rocket speed up feature breaks past the maximum distance of the leash between the camera and the vessel. There is also a bug where the vessel teleports closer to the cross first, if it is at leash distance, before the camera catchup plays into effect making it look like the camera is catching up twice. And I think the vessel is supposed to be able to move around smoothly in a circle just like stage 3, but instead it seems like it could only make 45 degree turns. 

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel goes outside of the boxes boundaries when it uses the speed up feature, which isn't supposed to happen. And the vessel itself pokes outside of the boxes boundaries which can be fixed by taking into account the vessel's width and height. For this you can use what I said above in stage 2 or look at push_box.gd where there is an example of how to use the vessel's width and height. After relooking at your code, it seems you did try to implement this, but got the signs mixed up. It is somewhat working if you switched the addition and subtraction signs of the following [code](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/speed_up.gd#L47-L50). Along with that, subtracting it by the camera position and box width/height would fix it. 
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
There aren't much infractions except maybe including the [type of the variable](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L77) might be helpful to code readers so they won't have to guess the [type](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L40). An example of inferred types is [here](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#inferred-types) on the style guide. 

#### Style Guide Exemplars ####
There were many exemplars including having the [correct code order](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L4-L17), export variables coming first, then public, then private variables. Snake case for all variables was excellent as well. Also, didn't omit leading or trailing zeroes in float variables. Correct [boolean](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L45) usage for operators and plenty of whitespace to make the code easy to read! 


___
#### Put style guide infractures ####
[Type of variable should be listed for easy readability](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L77) 
___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
Do more code commits in Github in order to save your code in case you want to revert back to an older version because of a big mistake. 

Comment more in your code so it helps the reader follow along. 

#### Best Practices Exemplars ####
Good [variable naming](https://github.com/ensemble-ai/exercise-2-camera-control-twobles/blob/19b97ed47d30c7e605f22bd4c1759a67ddf0eaf5/Obscura/scripts/camera_controllers/look_ahead.gd#L74-L77) that helps the reader follow along and understand what is it being used for. 

Functions are not too insanely long, making it easier to read. 
