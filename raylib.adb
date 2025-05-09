with Interfaces.C;
with Interfaces.C.Strings;

package body Raylib is
    use Interfaces.C;
    use Interfaces.C.Strings;

    package body Window is
        procedure Init (Width, Height : int; Title : String) is
            procedure InitWindow (Width, Height : int; Title : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "InitWindow";
            
            C_Title : chars_ptr := New_String (Title);
        begin
            InitWindow (Width, Height, C_Title);
            Free (C_Title);
        end Init;

        function Should_Close return Boolean is
            function WindowShouldClose return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "WindowShouldClose";
        
            Result : Boolean := Boolean (WindowShouldClose);
        begin
            return Result;
        end Should_Close;

         -- Check if window has been initialized successfully
        function Is_Ready return Boolean is
            function IsWindowReady return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowReady";
        
            Result : Boolean := Boolean (IsWindowReady);
        begin
            return Result;
        end Is_Ready;

        -- Check if window is currently fullscreen
        function Is_Fullscreen return Boolean is
            function IsWindowFullscreen return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowFullscreen";
        
            Result : Boolean := Boolean (IsWindowFullscreen);
        begin
            return Result;
        end Is_Fullscreen;

        -- Check if window is currently hidden
        function Is_Hidden return Boolean is
            function IsWindowHidden return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowHidden";
        
            Result : Boolean := Boolean (IsWindowHidden);
        begin
            return Result;
        end Is_Hidden;

        -- Check if window is currently minimized
        function Is_Minimized return Boolean is
            function IsWindowMinimized return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowMinimized";
        
            Result : Boolean := Boolean (IsWindowMinimized);
        begin
            return Result;
        end Is_Minimized;

        -- Check if window is currently maximized
        function Is_Maximized return Boolean is
            function IsWindowMaximized return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowMaximized";
        
            Result : Boolean := Boolean (IsWindowMaximized);
        begin
            return Result;
        end Is_Maximized;

        -- Check if window is currently focused
        function Is_Focused return Boolean is
            function IsWindowFocused return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowFocused";
        
            Result : Boolean := Boolean (IsWindowFocused);
        begin
            return Result;
        end Is_Focused;


        -- Check if window has been resized last frame
        function Is_Resized return Boolean is
            function IsWindowResized return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowResized";
        
            Result : Boolean := Boolean (IsWindowResized);
        begin
            return Result;
        end Is_Resized;

        -- Check if one specific window flag is enabled
        function Is_State (Flag : unsigned) return Boolean is
            function IsWindowState (Flag : unsigned) return C_bool
                with Import        => true,
                     Convention    => C,
                     External_Name => "IsWindowState";
        
            Result : Boolean := Boolean (IsWindowState (Flag));
        begin
            return Result;
        end Is_State;

        -- Set title for window
        procedure Set_Title (Title : String) is
            procedure SetWindowTitle (Title : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "SetWindowTitle";

            C_Title : chars_ptr := New_String (Title);
        begin
            SetWindowTitle (C_Title);
            Free (C_Title);
        end Set_Title;

        -- Set clipboard text content
        procedure Set_Clipboard_Text (Text : String) is
            procedure SetClipboardText (Text : chars_ptr)
                with Import        => true,
                     Convention    => C,
                     External_Name => "SetClipboardText";

            C_Text : chars_ptr := New_String (Text);
        begin
            SetClipboardText (C_Text);
            Free (C_Text);
        end Set_Clipboard_Text;
    end Window;

    package body Textures is
        --/////////////////////////////////////////////////////////////////////////////
        -- Image loading functions
        -- NOTE: These functions do not require GPU access
        --/////////////////////////////////////////////////////////////////////////////
        -- Load image from file into CPU memory (RAM)
        function Load_Image (File_Name : String) 
            return Image 
        is
            function LoadImage (File_Name : chars_ptr) return Image
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImage";

            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImage (C_File_Name);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image;
    
        -- Load image from RAW file data
        function Load_Image_Raw (File_Name : String; Width, Height, Format, Header_Size : int) 
            return Image 
        is
            function LoadImageRaw (File_Name : chars_ptr; Width, Height, Format, Header_Size : int) return Image
                with Import        => true,
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
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImageAnim";
            
            C_File_Name : chars_ptr := New_String (File_Name);
            Img         : Image     := LoadImageAnim (C_File_Name, Frames);
        begin
            Free (C_File_Name);
            return Img;
        end Load_Image_Anim;

        -- Load image sequence from memory buffer        
        function Load_Image_Anim_From_Memory (File_Type : String; File_Data : access unsigned_char; Data_Size : int; Frames : access int) return Image is
            function LoadImageAnimFromMemory (File_Type : chars_ptr; File_Data : access unsigned_char; Data_Size : int; Frames : access int) return Image
                with Import        => true,
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
                with Import        => true,
                     Convention    => C,
                     External_Name => "LoadImageFromMemory";

            C_File_Type : chars_ptr := New_String (File_Type);
            Img         : Image     := LoadImageFromMemory (C_File_Type, File_Data, Data_Size);
        begin
            Free (C_File_Type);
            return Img;
        end Load_Image_From_Memory;
    end Textures;
end Raylib;
