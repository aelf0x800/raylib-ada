with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
   package C renames Interfaces.C;

   --//////////////////////////////////////////////////////////////////////////
   -- Window-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Initialize window and OpenGL context
   procedure Init_Window (Width, Height : int; Title : String) is
      procedure C_Init_Window 
         (Width, Height : int; Title : C.Strings.chars_ptr)
         with 
            Import        => true,
            Convention    => C,
            External_Name => "InitWindow";
   
      C_Title : C.Strings.chars_ptr := C.Strings.New_String (Title);
   begin
      C_Init_Window (Width, Height, C_Title);
      Free (C_Title);
   end Init_Window;

   -- Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
   function Window_Should_Close return Boolean is
      function C_Window_Should_Close return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "WindowShouldClose";
   
      Result : Boolean := Boolean (C_Window_Should_Close);
   begin
      return Result;
   end Window_Should_Close;

    -- Check if window has been initialized successfully
   function Is_Window_Ready return Boolean is
      function C_Is_Window_Ready return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowReady";
   
      Result : Boolean := Boolean (C_Is_Window_Ready);
   begin
      return Result;
   end Is_Window_Ready;

   -- Check if window is currently fullscreen
   function Is_Window_Fullscreen return Boolean is
      function C_Is_Window_Fullscreen return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFullscreen";
   
      Result : Boolean := Boolean (C_Is_Window_Fullscreen);
   begin
      return Result;
   end Is_Window_Fullscreen;

   -- Check if window is currently hidden
   function Is_Window_Hidden return Boolean is
      function C_Is_Window_Hidden return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowHidden";
   
      Result : Boolean := Boolean (C_Is_Window_Hidden);
   begin
      return Result;
   end Is_Window_Hidden;

   -- Check if window is currently minimized
   function Is_Window_Minimized return Boolean is
      function C_Is_Window_Minimized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMinimized";
   
      Result : Boolean := Boolean (C_Is_Window_Minimized);
   begin
      return Result;
   end Is_Window_Minimized;

   -- Check if window is currently maximized
   function Is_Window_Maximized return Boolean is
      function C_Is_Window_Maximized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowMaximized";
   
      Result : Boolean := Boolean (C_Is_Window_Maximized);
   begin
      return Result;
   end Is_Window_Maximized;

   -- Check if window is currently focused
   function Is_Window_Focused return Boolean is
      function C_Is_Window_Focused return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowFocused";
   
      Result : Boolean := Boolean (C_Is_Window_Focused);
   begin
      return Result;
   end Is_Window_Focused;

   -- Check if window has been resized last frame
   function Is_Window_Resized return Boolean is
      function C_Is_Window_Resized return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowResized";
   
      Result : Boolean := Boolean (C_Is_Window_Resized);
   begin
      return Result;
   end Is_Window_Resized;

   -- Check if one specific window flag is enabled
   function Is_Window_State (Flag : unsigned) return Boolean is
      function C_Is_Window_State (Flag : unsigned) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsWindowState";
   
      Result : Boolean := Boolean (C_Is_Window_State (Flag));
   begin
      return Result;
   end Is_Window_State;

   -- Set title for window
   procedure Set_Window_Title (Title : String) is
      procedure C_Set_Window_Title (Title : C.Strings.chars_ptr)
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetWindowTitle";
 
      C_Title : C.Strings.chars_ptr := C.Strings.New_String (Title);
   begin
      C_Set_Window_Title (C_Title);
      Free (C_Title);
   end Set_Window_Title;

   -- Get the human-readable, UTF-8 encoded name of the specified monitor
   function Get_Monitor_Name (Monitor : int) return String is
      function C_Get_Monitor_Name (Monitor : int) return C.Strings.chars_ptr
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetMonitorName";
  
      C_Name : C.Strings.chars_ptr := C_Get_Monitor_Name (Monitor);
      Name   : String              := C.Strings.Value (C_Name);
   begin
      return Name;
   end Get_Monitor_Name;

   -- Set clipboard text content
   procedure Set_Clipboard_Text (Text : String) is
      procedure C_Set_Clipboard_Text (Text : C.Strings.chars_ptr)
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetClipboardText";

      C_Text : C.Strings.chars_ptr := C.Strings.New_String (Text);
   begin
      C_Set_Clipboard_Text (C_Text);
      Free (C_Text);
   end Set_Clipboard_Text;

   -- Get clipboard text content
   function Get_Clipboard_Text return String is
      function C_Get_Clipboard_Text return C.Strings.chars_ptr
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetClipboardText";

      C_Text : C.Strings.chars_ptr := C_Get_Clipboard_Text;
      Text   : String              := C.Strings.Value (C_Text);
   begin
      return Text;
   end Get_Clipboard_Text;

   --//////////////////////////////////////////////////////////////////////////
   -- Cursor-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Check if cursor is not visible
   function Is_Cursor_Hidden return Boolean is
      function C_Is_Cursor_Hidden return C.C_bool
      with
         Import        => true,
         Convention    => C,
         External_Name => "IsCursorHidden";
  
      Result : Boolean := Boolean (C_Is_Cursor_Hidden);
   begin
      return Result;
   end Is_Cursor_Hidden;
  
   -- Check if cursor is on the screen
   function Is_Cursor_On_Screen return Boolean is
      function C_Is_Cursor_On_Screen return C.C_bool
      with
         Import        => true,
         Convention    => C,
         External_Name => "IsCursorOnScreen";

      Result : Boolean := Boolean (C_Is_Cursor_On_Screen);
   begin
      return Result;
   end Is_Cursor_On_Screen;


   --//////////////////////////////////////////////////////////////////////////
   -- Shader management functions and procedures
   -- NOTE: Shader functionality is not available on OpenGL 1.1
   --//////////////////////////////////////////////////////////////////////////
   -- Load shader from files and bind default locations
   function Load_Shader (Vs_File_Name, Fs_File_Name : String) return Shader is
      function C_Load_Shader 
         (Vs_File_Name, Fs_File_Name : C.Strings.chars_ptr) return Shader 
         with
            Import        => true,
            Convention    => C,
            External_Name => "LoadShader";
  
      C_Vs_File_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Vs_File_Name);
      C_Fs_File_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Fs_File_Name);
      Shadr          : Shader              := 
         C_Load_Shader (C_Vs_File_Name, C_Fs_File_Name); 
   begin
      Free (C_Vs_File_Name);
      Free (C_Fs_File_Name);
      return Shadr;
   end Load_Shader;

   -- Load shader from code strings and bind default locations
   function Load_Shader_From_Memory 
      (Vs_Code, Fs_Code : String) return Shader 
   is
      function C_Load_Shader_From_Memory 
         (Vs_Code, Fs_Code : C.Strings.chars_ptr) return Shader 
         with
            Import        => true,
            Convention    => C,
            External_Name => "LoadShaderFromMemory";

      C_Vs_Code : C.Strings.chars_ptr := C.Strings.New_String (Vs_Code);
      C_Fs_Code : C.Strings.chars_ptr := C.Strings.New_String (Fs_Code);
      Shadr     : Shader              := 
         C_Load_Shader_From_Memory (C_Vs_Code, C_Fs_Code);
   begin
      Free (C_Vs_Code);
      Free (C_Fs_Code);
      return Shadr;
   end Load_Shader_From_Memory;

   function Is_Shader_Valid (Shadr : Shader) return Boolean is
      function C_Is_Shader_Valid (Shadr : Shader) return C.C_bool
         with 
            Import        => true,
            Convention    => C,
            External_Name => "IsShaderValid";
   
      Result : Boolean := Boolean (C_Is_Shader_Valid (Shadr));
   begin
      return Result;
   end Is_Shader_Valid;

   -- Get shader uniform location
   function Get_Shader_Location 
      (Shadr : Shader; Uniform_Name : String) return int
   is
      function C_Get_Shader_Location 
         (Shadr : Shader; Uniform_Name : C.Strings.chars_ptr) return int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetShaderLocation";

      C_Uniform_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Uniform_Name);
      Location       : int                 := 
         C_Get_Shader_Location (Shadr, C_Uniform_Name);
   begin
      Free (C_Uniform_Name);
      return Location;
   end Get_Shader_Location;

   -- Get shader attribute location
   function Get_Shader_Location_Attrib 
      (Shadr : shader; Attrib_Name : String) return int
   is
      function C_Get_Shader_Location_Attrib 
         (Shadr : shader; Attrib_Name : C.Strings.chars_ptr) return int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetShaderLocationAttrib";
      
      C_Attrib_Name : C.Strings.chars_ptr := 
         C.Strings.New_String (Attrib_Name);
      Location      : int                 := 
         C_Get_Shader_Location_Attrib (Shadr, C_Attrib_Name);
   begin
      Free (C_Attrib_Name);
      return Location;
   end Get_Shader_Location_Attrib;

   --//////////////////////////////////////////////////////////////////////////
   -- Misc. procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Takes a screenshot of current screen (filename extension defines format)
   procedure Take_Screenshot (File_Name : String) is
      procedure C_Take_Screenshot (File_Name : C.Strings.chars_ptr) 
      with
         Import        => true,
         Convention    => C,
         External_Name => "TakeScreenshot";

      C_File_Name : C.Strings.chars_ptr := C.Strings.New_String (File_Name);
   begin
      C_Take_Screenshot (C_File_Name);
      Free (C_File_Name);
   end Take_Screenshot;
   -- Open URL with default system browser (if available)
   procedure Open_URL (URL : String) is
      procedure C_Open_URL (URL : C.Strings.chars_ptr) 
      with
         Import        => true,
         Convention    => C,
         External_Name => "OpenURL";
 
      C_URL : C.Strings.chars_ptr := C.Strings.New_String (URL);
   begin
      C_Open_URL (C_URL);
      Free (C_URL);
   end Open_URL;

   --//////////////////////////////////////////////////////////////////////////
   -- Input handling functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Input-related functions: keyboard
   -- Check if a key has been pressed once
   function Is_Key_Pressed (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Pressed (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyPressed";

      Result : Boolean := Boolean (C_Is_Key_Pressed (Key));
   begin
      return Result;
   end Is_Key_Pressed;

   -- Check if a key has been pressed again
   function Is_Key_Pressed_Repeat (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Pressed_Repeat (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyPressedRepeat";

      Result : Boolean := Boolean (C_Is_Key_Pressed_Repeat (Key));
   begin
      return Result;
   end Is_Key_Pressed_Repeat;
   
   -- Check if a key is being pressed
   function Is_Key_Down (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Down (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyDown";

      Result : Boolean := Boolean (C_Is_Key_Down (Key));
   begin
      return Result;
   end Is_Key_Down;
   
   -- Check if a key has been released once
   function Is_Key_Released (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Released (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyReleased";

      Result : Boolean := Boolean (C_Is_Key_Released (Key));
   begin
      return Result;
   end Is_Key_Released;

   -- Check if a key is NOT being pressed
   function Is_Key_Up (Key : Keyboard_Key) return Boolean is
      function C_Is_Key_Up (Key : Keyboard_Key) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsKeyUp";

      Result : Boolean := Boolean (C_Is_Key_Up (Key));
   begin
      return Result;
   end Is_Key_Up;

   -- Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
   function Get_Char_Pressed return Wide_Character is
      function C_Get_Char_Pressed return int
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetCharPressed";

      --Wide_Char : Wide_Character := Wide_Character (C_Get_Char_Pressed);
   begin
      return 'X';
      --return Wide_Char;
   end Get_Char_Pressed;

   -- Input-related functions: gamepads
   -- Check if a gamepad is available
   function Is_Gamepad_Available (Gamepad : int) return Boolean is
      function C_Is_Gamepad_Available (Gamepad : int) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadAvailable";

      Result : Boolean := Boolean (C_Is_Gamepad_Available (Gamepad)); 
   begin
      return Result;
   end Is_Gamepad_Available;
   
   -- Get gamepad internal name id
   function Get_Gamepad_Name (Gamepad : int) return String is
      function C_Get_Gamepad_Name (Gamepad : int) return C.Strings.chars_ptr 
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetGamepadName";

      C_Gamepad_Name : C.Strings.chars_ptr := C_Get_Gamepad_Name (Gamepad);
      Gamepad_Name   : String              := C.Strings.Value (C_Gamepad_Name);
   begin
      return Gamepad_Name;
   end Get_Gamepad_Name;
   
   -- Check if a gamepad button has been pressed once
   function Is_Gamepad_Button_Pressed 
      (Gamepad : int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Pressed 
         (Gamepad : int; Button : Gamepad_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonPressed";

      Result : Boolean := 
         Boolean (C_Is_Gamepad_Button_Pressed (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Pressed;

   -- Check if a gamepad button is being pressed
   function Is_Gamepad_Button_Down
      (Gamepad : int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Down 
         (Gamepad : int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonDown";

      Result : Boolean := Boolean (C_Is_Gamepad_Button_Down (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Down;

   -- Check if a gamepad button has been released once
   function Is_Gamepad_Button_Released 
      (Gamepad : int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Released 
         (Gamepad : int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonReleased";

      Result : Boolean := 
         Boolean (C_Is_Gamepad_Button_Released (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Released;

   -- Check if a gamepad button is NOT being pressed
   function Is_Gamepad_Button_Up 
      (Gamepad : int; Button : Gamepad_Button) return Boolean is
      function C_Is_Gamepad_Button_Up 
         (Gamepad : int; Button : Gamepad_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsGamepadButtonUp";

      Result : Boolean := Boolean (C_Is_Gamepad_Button_Up (Gamepad, Button));
   begin
      return Result;
   end Is_Gamepad_Button_Up;

   -- Set internal gamepad mappings (SDL_GameControllerDB)
   function Set_Gamepad_Mappings (Mappings : String) return int is
      function C_Set_Gamepad_Mappings 
         (Mappings : C.Strings.chars_ptr) return int 
         with
            Import        => true,
            Convention    => C,
            External_Name => "SetGamepadMappings";

      C_Mappings : C.Strings.chars_ptr := C.Strings.New_String (Mappings);
      Result     : int                 := C_Set_Gamepad_Mappings (C_Mappings);
   begin
      Free (C_Mappings);
      return Result;
   end Set_Gamepad_Mappings;

   -- Input-related functions: mouse
   -- Check if a mouse button has been pressed once
   function Is_Mouse_Button_Pressed (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Pressed 
         (Button : Mouse_Button) return C.C_bool
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonPressed";

      Result : Boolean := Boolean (C_Is_Mouse_Button_Pressed (Button));
   begin
      return Result;
   end Is_Mouse_Button_Pressed;

   -- Check if a mouse button is being pressed
   function Is_Mouse_Button_Down (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Down (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonDown";

      Result : Boolean := Boolean (C_Is_Mouse_Button_Down (Button));
   begin
      return Result;
   end Is_Mouse_Button_Down;

   -- Check if a mouse button has been released once
   function Is_Mouse_Button_Released (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Released 
         (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonReleased";

      Result : Boolean := Boolean (C_Is_Mouse_Button_Released (Button));
   begin
      return Result;
   end Is_Mouse_Button_Released;

   -- Check if a mouse button is NOT being pressed
   function Is_Mouse_Button_Up (Button : Mouse_Button) return Boolean is
      function C_Is_Mouse_Button_Up (Button : Mouse_Button) return C.C_bool 
         with
            Import        => true,
            Convention    => C,
            External_Name => "IsMouseButtonUp";

      Result : Boolean := Boolean (C_Is_Mouse_Button_Up (Button));
   begin
      return Result;
   end Is_Mouse_Button_Up;


   package body Textures is
        --/////////////////////////////////////////////////////////////////////////////
        -- Image loading functions
        -- NOTE: These functions do not require GPU access
        --/////////////////////////////////////////////////////////////////////////////
        -- Load image from file into CPU memory (RAM)
        function Load_Image (File_Name : String) return Image 
        is
            function LoadImage (File_Name : chars_ptr) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImage";

            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImage (C_File_Name);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image;
    
        -- Load image from RAW file data
        function Load_Image_Raw (File_Name : String; Width, Height, Format, Header_Size : int) return Image 
        is
            function LoadImageRaw (File_Name : chars_ptr; Width, Height, Format, Header_Size : int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageRaw";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageRaw (C_File_Name, Width, Height, Format, Header_Size);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Raw;
        
        -- Load image sequence from file (frames appended to image.data)
        function Load_Image_Anim (File_Name : String; Frames : access int) return Image is
            function LoadImageAnim (File_Name : chars_ptr; Frames : access int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageAnim";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageAnim (C_File_Name, Frames);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Anim;

        -- Load image sequence from memory buffer        
        function Load_Image_Anim_From_Memory 
            (File_Type : String; 
             File_Data : access unsigned_char; 
             Data_Size : int; 
             Frames : access int) return Image is
            function LoadImageAnimFromMemory 
                (File_Type : chars_ptr; 
                 File_Data : access unsigned_char; 
                 Data_Size : int; 
                 Frames : access int) return Image
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageAnimFromMemory";
   
            C_File_Type : chars_ptr := New_String (File_Type);
            Img         : Image     := LoadImageAnimFromMemory (C_File_Type, File_Data, Data_Size, Frames);
        begin
            Free (C_File_Type);
            return Img;
        end Load_Image_Anim_From_Memory;

        -- Load image from memory buffer, fileType refers to extension: i.e. '.png'
        function Load_Image_From_Memory (File_Type : String; File_Data : access unsigned_char; Data_Size : int) return Image is
            function LoadImageFromMemory (File_Type : chars_ptr; File_Data : access unsigned_char; Data_Size : int) return Image 
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "LoadImageFromMemory";

            C_File_Type : chars_ptr := New_String (File_Type);
            Img         : Image     := LoadImageFromMemory (C_File_Type, File_Data, Data_Size);
        begin
            Free (C_File_Type);
            return Img;
        end Load_Image_From_Memory;

        -- Check if an image is valid (data and parameters)
        function Is_Image_Valid (Img : Image) return Boolean is
            function IsImageValid (Img : Image) return C.C_bool
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "IsImageValid";

            Result : Boolean := Boolean (IsImageValid (Img));
        begin
            return Result;
        end Is_Image_Valid;

        -- Export image data to file, returns true on success
        function Export_Image (Img : Image; File_Name : String) return Boolean is
            function ExportImage (Img : Image; File_Name : chars_ptr) return C.C_bool
                with 
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImage";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Result      : Boolean   := Boolean (ExportImage (Img, C_File_Name));
        begin
            Free (C_File_Name);
            return Result;
        end Export_Image;

        -- Export image to memory buffer
        function Export_Image_To_Memory (Img : Image; File_Type : String; File_Size : access int) return access unsigned_char is
            function ExportImageToMemory (Img : Image; File_Type : chars_ptr; File_Size : access int) return access unsigned_char
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImageToMemory";

            C_File_Type : chars_ptr            := New_String (File_Type);
            Result      : access unsigned_char := ExportImageToMemory (Img, C_File_Type, File_Size);
        begin
            Free (C_File_Type);
            return Result;
        end Export_Image_To_Memory;

        -- Export image as code file defining an array of bytes, returns true on success
        function Export_Image_As_Code (Img : Image; File_Name : String) return Boolean is
            function ExportImageAsCode (Img : Image; File_Name : chars_ptr) return C.C_bool
                with
                    Import        => true,
                    Convention    => C,
                    External_Name => "ExportImageAsCode";

            C_File_Name : chars_ptr := New_String (File_Name);
            Result      : Boolean   := Boolean (ExportImageAsCode (Img, C_File_Name));
        begin
            Free (C_File_Name);
            return Result;
        end Export_Image_As_Code;
    end Textures;
end Raylib;
