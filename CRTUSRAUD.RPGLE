  ctl-opt DEBUG DATEDIT(*DMY) DATFMT(*EUR);                                
  /////////////////////////////////////////////////////////////////////////
  //                     MNI SERVICES                                      
  //   ======================================================              
  //                                                                       
  //  Program     :   CRTUSRAUD                                            
  //  Description :   Run CHGUSRAUD command on user creation               
  //  Author      :   David Shears                                         
  //  Create Date :   2021/10/21                                           
  //  Notes       :                                                        
  /////////////////////////////////////////////////////////////////////////
  // Amendment Record                                                      
  // Log No :   Date   :Pgmr: Description of change.                       
  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  // Declare procedure for incoming information                            
  dcl-pr CRTUSRAUD ExtPgm('CRTUSRAUD');                                    
      NewUsrInfo char(38) const;                                           
  end-pr;                                                                  
    dcl-pi CRTUSRAUD;                                              
      NewUsrInfo char(38) const;                                 
  end-pi;                                                        
  // Declare procedure for QcmdExc call                          
  dcl-pr Execute ExtPgm('QCMDEXC');                              
      Command char(500) const Options(*varsize);                 
      CommandLength Packed(15:5) const;                          
  end-pr;                                                        
  // Declare datastructure for breaking down the info            
  dcl-ds NewUsrSub;                                              
    ExtPntName CHAR(20);                                         
    ExtPntFmt CHAR(8);                                           
    CrtUsrNam CHAR(10);                                          
  end-ds;                                                        
  // Declare Qcmd and QCmdLen for usage below                    
  dcl-s CommandString char(200);                                 
  // Bring in the information                                    
    NewUsrSub = NewUsrInfo;                                      
  // Build variables for Qcmdexec call                           
  CommandString = 'CHGUSRAUD USRPRF(' + %trimr(CrtUsrNam) + ')' +
    ' AUDLVL(''*CREATE'' ''*DELETE'' ''*JOBDTA'')';              
  Execute(%trimr(CommandString) : %len(%trimr(CommandString)));
  // Now we can end                                            
  Return;                                                      
