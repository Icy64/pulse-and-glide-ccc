classdef vehicleClass
   properties (Access = public)
      currentSpeed = 0.0;
      userSetSpeed = 0.0;

      clutchConnectedState = 0;

      HighRange = 0.0;
      LowRange = 0.0;

      

      currentGear = 1;
      maxGear = 6;

      throttleValve = 0.0;
      throttleValveMax = 0.7;

      iSDoubleClutch = 1;
      clutch_A_State_AND_NOT_B_State = 1
      %%^this just means that if the clutch is on the A pair (odd clutchs)
      %%then it is not configured to even clutch

      cruiseSpeedRangeMatrix = [0.0,24.0,1;25.0,30.0,2; 30.0,40.0,3;40.0,55.0,4;55.0,65.0,5;65.0,300.0,6] 
      

      %% how the array should be made = minspeed,maxspeed,gear

   end
   methods
       %%what does cruise output? it just sets the speed and other class
       %%properties relevant
       function result = cruise(obj)
               %%obj.currentSpeed
               %%obj.currentGear
         %%find what gear first to be on
         
         
             if obj.userSetSpeed < obj.cruiseSpeedRangeMatrix(2,1)
                 obj.currentGear = 1;
                 obj.clutch_A_State_AND_NOT_B_State = 1;
             elseif obj.userSetSpeed < obj.cruiseSpeedRangeMatrix(3,1)
                 obj.currentGear = 2;
                 obj.clutch_A_State_AND_NOT_B_State = 0;
             elseif obj.userSetSpeed < obj.cruiseSpeedRangeMatrix(4,1)
                 obj.currentGear = 3;
                 obj.clutch_A_State_AND_NOT_B_State = 1;
             elseif obj.userSetSpeed < obj.cruiseSpeedRangeMatrix(5,1)
                 obj.currentGear = 4;
                 obj.clutch_A_State_AND_NOT_B_State = 0;
             elseif obj.userSetSpeed < obj.cruiseSpeedRangeMatrix(6,1)
                 obj.currentGear = 5;
                 obj.clutch_A_State_AND_NOT_B_State = 1;
             else
                 obj.currentGear = 6;
                 obj.clutch_A_State_AND_NOT_B_State = 0;
             end
          %%deterimine cruise speed range
         obj.HighRange = obj.userSetSpeed + 2;
         obj.LowRange = obj.userSetSpeed - 2;
        
         %%determine whether to speed up or slow down
         if obj.currentSpeed <= obj.LowRange
            obj.throttleValve = 0.7;
            obj.clutchConnectedState = 1;
            while obj.currentSpeed < obj.HighRange
                addedSpeed = 0.2;
                obj.currentSpeed = obj.currentSpeed + addedSpeed; 
               
            end
            

         else
             %%speed slows down due to power loss
             %% put for demonstration purposes the action speed decay is a complex calculation
             lossOfSpeed = 0.01;
             obj.currentSpeed = obj.currentSpeed - lossOfSpeed;
             obj.clutchConnectedState = 0;
             %pause(.05);
         end

         result = obj
           
        return
        end
   end
end