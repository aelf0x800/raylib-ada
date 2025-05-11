with Ada.Characters.Latin_1;
with Interfaces.C;
with Interfaces.C.Strings;
with System;

package Raylib is
   use Ada.Characters.Latin_1;
   use Interfaces.C;
   use Interfaces.C.Strings;
   use System;

   Version_Major : int    := 5;
   Version_Minor : int    := 5;
   Version_Patch : int    := 0;
   Version       : String := "5.5";

   --//////////////////////////////////////////////////////////////////////////
   -- Enumerators Definition
   --//////////////////////////////////////////////////////////////////////////
   -- TODO : ConfigFlags
   -- TODO : TraceLogLevel

   -- Keyboard keys (US keyboard layout)
   -- NOTE : Use Get_Key_Pressed () to allow redefining required keys for alternative layouts
   type Keyboard_Key is
      (Key_Nul,
       -- Android key buttons
       Key_Back, Key_Menu, Key_Volume_Up, Key_Volume_Down,
       -- Space key
       Key_Space,
       -- Alphanumeric keys
       Key_Apostrophe, Key_Comma, Key_Minus, Key_Period, Key_Slash, Key_Zero, 
       Key_One, Key_Two, Key_Three, Key_Four, Key_Five, Key_Six, Key_Seven, 
       Key_Eight, Key_Nine, Key_Semi_Colon, Key_Equal, Key_A, Key_B, Key_C, 
       Key_D, Key_E, Key_F, Key_G, Key_H, Key_I, Key_J, Key_K, Key_L, Key_M, 
       Key_N, Key_O, Key_P, Key_Q, Key_R, Key_S, Key_T, Key_U, Key_V, Key_W, 
       Key_X, Key_Y, Key_Z, Key_Left_Bracket, Key_Backslash, Key_Right_Bracket,
       Key_Grave,
       -- Function keys
       Key_Escape, Key_Enter, Key_Tab, Key_Backspace, Key_Insert, Key_Delete, 
       Key_Right, Key_Left, Key_Down, Key_Up, Key_Page_Up, Key_Page_Down, 
       Key_Home_Key, Key_End_Key, Key_Caps_Lock, Key_Scroll_Lock, Key_Num_Lock, 
       Key_Print_Screen, Key_Pause, Key_F1, Key_F2, Key_F3, Key_F4, Key_F5, 
       Key_F6, Key_F7, Key_F8, Key_F9, Key_F10, Key_F11, Key_F12, 
       -- Keypad keys
       Key_Key_Pad_0, Key_Key_Pad_1, Key_Key_Pad_2, Key_Key_Pad_3, 
       Key_Key_Pad_4, Key_Key_Pad_5, Key_Key_Pad_6, Key_Key_Pad_7, 
       Key_Key_Pad_8, Key_Key_Pad_9, Key_Key_Pad_Decimal, Key_Key_Pad_Divide, 
       Key_Key_Pad_Multiply, Key_Key_Pad_Subtract, Key_Key_Pad_Add,
       Key_Key_Pad_Enter, Key_Key_Pad_Equal,
       -- Modifier keys
       Key_Left_Shift, Key_Left_Control, Key_Left_Alt, Key_Left_Super, 
       Key_Right_Shift, Key_Right_Control, Key_Right_Alt, Key_Right_Super, 
       Key_KB_Menu) 
      with Convention => C;
   
   for Keyboard_Key use
      (Key_Nul   => 0, 
       -- Android key buttons
       Key_Back        => 4,
       Key_Menu        => 5,
       Key_Volume_Up   => 24,
       Key_Volume_Down => 25,
       -- Space key
       Key_Space => 32,
       -- Alphanumeric keys
       Key_Apostrophe    => 39,
       Key_Comma         => 44,
       Key_Minus         => 45,
       Key_Period        => 46,
       Key_Slash         => 47,
       Key_Zero          => 48,
       Key_One           => 49,
       Key_Two           => 50,
       Key_Three         => 51,
       Key_Four          => 52,
       Key_Five          => 53,
       Key_Six           => 54,
       Key_Seven         => 55,
       Key_Eight         => 56,
       Key_Nine          => 57,
       Key_Semi_Colon    => 59,
       Key_Equal         => 61,
       Key_A             => 65,
       Key_B             => 66,
       Key_C             => 67,
       Key_D             => 68,
       Key_E             => 69,
       Key_F             => 70,
       Key_G             => 71,
       Key_H             => 72,
       Key_I             => 73,
       Key_J             => 74,
       Key_K             => 75,
       Key_L             => 76,
       Key_M             => 77,
       Key_N             => 78,
       Key_O             => 79,
       Key_P             => 80,
       Key_Q             => 81,
       Key_R             => 82,
       Key_S             => 83,
       Key_T             => 84,
       Key_U             => 85,
       Key_V             => 86,
       Key_W             => 87,
       Key_X             => 88,
       Key_Y             => 89,
       Key_Z             => 90,
       Key_Left_Bracket  => 91,
       Key_Backslash     => 92,
       Key_Right_Bracket => 93,
       Key_Grave         => 96,
       -- Function keys
       Key_Escape       => 256,
       Key_Enter        => 257,
       Key_Tab          => 258,
       Key_Backspace    => 259,
       Key_Insert       => 260,
       Key_Delete       => 261,
       Key_Right        => 262,
       Key_Left         => 263,
       Key_Down         => 264,
       Key_Up           => 265,
       Key_Page_Up      => 266,
       Key_Page_Down    => 267,
       Key_Home_Key     => 268,
       Key_End_Key      => 269,
       Key_Caps_Lock    => 280,
       Key_Scroll_Lock  => 281,
       Key_Num_Lock     => 282,
       Key_Print_Screen => 283,
       Key_Pause        => 284,
       Key_F1           => 290,
       Key_F2           => 291,
       Key_F3           => 292,
       Key_F4           => 293,
       Key_F5           => 294,
       Key_F6           => 295,
       Key_F7           => 296,
       Key_F8           => 297,
       Key_F9           => 298,
       Key_F10          => 299,
       Key_F11          => 300,
       Key_F12          => 301,
       -- Keypad keys
       Key_Key_Pad_0        => 320,
       Key_Key_Pad_1        => 321,
       Key_Key_Pad_2        => 322,
       Key_Key_Pad_3        => 323,
       Key_Key_Pad_4        => 324,
       Key_Key_Pad_5        => 325,
       Key_Key_Pad_6        => 326,
       Key_Key_Pad_7        => 327,
       Key_Key_Pad_8        => 328,
       Key_Key_Pad_9        => 329,
       Key_Key_Pad_Decimal  => 330,
       Key_Key_Pad_Divide   => 331,
       Key_Key_Pad_Multiply => 332,
       Key_Key_Pad_Subtract => 333,
       Key_Key_Pad_Add      => 334,
       Key_Key_Pad_Enter    => 335,
       Key_Key_Pad_Equal    => 336,
       -- Modifier keys
       Key_Left_Shift    => 340,
       Key_Left_Control  => 341,
       Key_Left_Alt      => 342,
       Key_Left_Super    => 343,
       Key_Right_Shift   => 344,
       Key_Right_Control => 345,
       Key_Right_Alt     => 346,
       Key_Right_Super   => 347,
       Key_KB_Menu       => 348);

   -- Mouse button
   type Mouse_Button is
      (Mouse_Button_Left,
       Mouse_Button_Right,
       Mouse_Button_Middle,
       Mouse_Button_Side,
       Mouse_Button_Extra,
       Mouse_Button_Forward,
       Mouse_Button_Back)
      with Convention => C;

   -- Mouse cursor
   type Mouse_Cursor is
      (Mouse_Cursor_Default,
       Mouse_Cursor_Arrow,
       Mouse_Cursor_I_Beam,
       Mouse_Cursor_Crosshair,
       Mouse_Cursor_Pointing_Hand,
       Mouse_Cursor_Resize_EW,
       Mouse_Cursor_Resize_NS,
       Mouse_Cursor_Resize_NWSE,
       Mouse_Cursor_Resize_NESW,
       Mouse_Cursor_Resize_All,
       Mouse_Cursor_Not_Allowed)
      with Convention => C;

   -- Gamepad buttons
   type Gamepad_Button is
      (Gamepad_Button_Unknown,
       Gamepad_Button_Left_Face_Up,
       Gamepad_Button_Left_Face_Right,
       Gamepad_Button_Left_Face_Down,
       Gamepad_Button_Left_Face_Left,
       Gamepad_Button_Right_Face_Up,
       Gamepad_Button_Right_Face_Right,
       Gamepad_Button_Right_Face_Down,
       Gamepad_Button_Right_Face_Left,
       Gamepad_Button_Left_Trigger_1,
       Gamepad_Button_Left_Trigger_2,
       Gamepad_Button_Right_Trigger_1,
       Gamepad_Button_Right_Trigger_2,
       Gamepad_Button_MIDDLE_Left,
       Gamepad_Button_MIDDLE,
       Gamepad_Button_MIDDLE_Right,
       Gamepad_Button_Left_Thumb,
       Gamepad_Button_Right_Thumb)
      with Convention => C;

   -- Gamepad axis
   type Gamepad_Axis is
      (Gamepad_Axis_Left_X,
       Gamepad_Axis_Left_Y,
       Gamepad_Axis_Right_X,
       Gamepad_Axis_Right_Y,
       Gamepad_Axis_Left_Trigger,
       Gamepad_Axis_Right_Trigger)
      with Convention => C;

   -- TODO : MaterialMapIndex
   -- TODO : ShaderLocationIndex
   -- TODO : ShaderUniformDataType
   -- TODO : ShaderAttributeDataType
   -- TODO : PixelFormat
   -- TODO : TextureFilter
   -- TODO : TextureWrap
   -- TODO : CubemapLayout
   -- TODO : FontType
   -- TODO : BlendMode
   -- TODO : Gesture
   -- TODO : CameraMode
   -- TODO : CameraProjection
   -- TODO : NPatchLayout
   
   --//////////////////////////////////////////////////////////////////////////
   -- Structures Definition
   --//////////////////////////////////////////////////////////////////////////
   -- Vector2, 2 components
   type Vector2 is record
      X, Y : Float; -- Vector X and Y components
   end record
      with Convention => C_Pass_By_Copy;

   -- Vector3, 3 components
   type Vector3 is record
      X, Y, Z : Float; -- Vector X, Y and Z components
   end record
      with Convention => C_Pass_By_Copy;

   -- Vector4, 4 components
   type Vector4 is record
      X, Y, Z, W : Float; -- Vector X, Y, Z and W components
   end record
      with Convention => C_Pass_By_Copy;

   -- Quaternion, 4 components (Vector4 alias)
   type Quaternion is new Vector4;

   -- Matrix, 4x4 components, column major, OpenGL style, right-handed
   type Matrix is record
      M0, M4, M8, M12  : Float; -- Matrix first row (4 components)
      M1, M5, M9, M13  : Float; -- Matrix second row (4 components)
      M2, M6, M10, M14 : Float; -- Matrix third row (4 conponents)
      M3, M7, M11, M15 : Float; -- Matrix fourth row (4 conponents)
   end record
      with Convention => C_Pass_By_Copy;

   -- Color, 4 components, R8G8B8A8 (32-bit)
   type Color is record
      R, G, B, A : unsigned_char; -- Color red, green, blue and alpha values
   end record
      with Convention => C_Pass_By_Copy;

   -- Rectangle, 4 components
   type Rectangle is record
      X, Y          : Float; -- Rectangle top-left corner X and Y position
      Width, Height : Float; -- Rectangle width and height
   end record
      with Convention => C_Pass_By_Copy;

   -- Image, pixel data stored in CPU memory (RAM)
   type Image is record
      Data          : System.Address; -- Image raw data
      Width, Height : int;            -- Image base width and height
      Mipmaps       : int;            -- Mipmap levels, 1 by default
      Format        : int;            -- Data format (PixelFormat type)
   end record
      with Convention => C_Pass_By_Copy;

   -- Texture_2D, tex data stored in GPU memory (VRAM)
   type Texture_2D is record
      ID            : unsigned; -- OpenGL texture ID
      Width, Height : int;      -- Texture base width and height
      Mipmaps       : int;      -- Mipmap levels, 1 by default
      Format        : int;      -- Data format (PixelFormat type)
   end record
      with Convention => C_Pass_By_Copy;

   -- Render_Texture_2D, FBO for texture rendering
   type Render_Texture_2D is record
      ID      : unsigned;   -- OpenGL framebuffer object ID
      Texture : Texture_2D; -- Color buffer attachment texture
      Depth   : Texture_2D; -- Depth buffer attachment texture
   end record
      with Convention => C_Pass_By_Copy;

   -- NPatch_Info, n-patch layout info
   type NPatch_Info is record
      Source                   : Rectangle; -- Texture source rectangle
      Left, Top, Right, Bottom : int;       -- Character border offsets
      Layout                   : int;       -- Layout of the n-patch : 3x3, 1x3 or 3x1
   end record
      with Convention => C_Pass_By_Copy;

   -- Glyph_Info, font characters glyphs info
   type Glyph_Info is record
      Value            : int;   -- Character value (Unicode)
      OffsetX, OffsetY : int;   -- Character X and Y offset when drawing
      AdvanceX         : int;   -- Charcater advance position X
      Img              : Image; -- Character image data
   end record
      with Convention => C_Pass_By_Copy;

   -- Font, font texture and Glyph_Info array data
   type Font is record
      BaseSize     : int;               -- Base size (default chars height)
      GlyphCount   : int;               -- Number of glyph characters
      GlyphPadding : int;               -- Padding around the glyph characters
      Texture      : Texture_2D;        -- Texture atlas containing the glyphs
      Rectangles   : access Rectangle;  -- Rectangles in texture for the glyphs
      Glyphs       : access Glyph_Info; -- Glyphs info data
   end record
      with Convention => C_Pass_By_Copy;

   -- Camera3D, defines position and orientation in 3D space
   type Camera3D is record
      Position   : Vector3; -- Camera position
      Target     : Vector3; -- Camera target it looks-at
      Up         : Vector3; -- Camera up vector (rotation over its axis)
      Fov_Y      : Float;   -- Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthohtaphic
      Projection : int;     -- Camera projection : CameraProjection.Perspective or CameraProjection.Orthographic
   end record
      with Convention => C_Pass_By_Copy;

   -- Camera_2D, defines position and orientation in 2D space
   type Camera_2D is record
      Offset   : Vector2; -- Camera offset (displacement from target)
      Target   : Vector2; -- Camera target (rotation and zoom origin)
      Rotation : Float;   -- Camera rotation in degrees
      Zoom     : Float;   -- Camera zoom (scaling), should be 1.0f by default
   end record
      with Convention => C_Pass_By_Copy;

   -- Mesh, vertex data and VAO/VBO
   type Mesh is record
      Vertex_Count   : int; -- Number of verticies stored in arrays
      Triangle_Count : int; -- Number of triangles stored (indexed or not)

      -- Vertex attributes data
      Verticies       : access Float;         -- Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
      Texture_Coords  : access Float;         -- Vertex texture coordinates (UV - 2 components per vertex (shader-location = 1)
      Texture_Coords2 : access Float;         -- Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
      Normals         : access Float;         -- Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
      Tangents        : access Float;         -- Vertex tangents (XYZW - 4 components per vertex) (shader-location = 3)
      Colors          : access unsigned_char; -- Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
      Indicies        : access unsigned_char; -- Vertex indicies (in case vertex data comes indexed)

      -- Animation vertex data
      Anim_Verticies : access Float;         -- Animated vertex positions (after bones transformations)
      Anim_Normals   : access Float;         -- Animated normals (after bones transformations)
      Bone_IDs       : access unsigned_char; -- Vertex bone IDs, max 255 bone IDs, up to 4 bones influence by vertex (skinning) (shader-location = 6)
      Bone_Weights   : access Float;         -- Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
      Bone_Matricies : access Matrix;        -- Bones animated transformations matricies
      Bone_Count     : int;                  -- Number of bones

      -- OpenGL identifiers
      VAO_ID : unsigned; -- OpenGL Vertex Array Object ID
      VBO_ID : unsigned; -- OpenGL Vertex Buffer Objects ID (default vertex data)
   end record
      with Convention => C_Pass_By_Copy;

   -- Shader
   type Shader is record
      ID   : unsigned;   -- Shader program ID
      Locs : access int; -- Shader locations array
   end record
      with Convention => C_Pass_By_Copy;

   -- Material_Map
   type Material_Map is record
      Texture : Texture_2D; -- Material map texture
      Colr    : Color;      -- Material map color
      Value   : Float;      -- Material map value
   end record
      with Convention => C_Pass_By_Copy;

   -- Material, includes shader and maps
   type Material_Params is Array (0 .. 2) of Float;
   type Material is record
      Shadr  : Shader;              -- Material shader
      Maps   : access Material_Map; -- Material maps array
      Params : Material_Params;     -- Material generic parameters (if required)
   end record
      with Convention => C_Pass_By_Copy;

   -- Transform, vertex transformation data
   type Transform is record
      Translation : Vector3;    -- Translation
      Rotation    : Quaternion; -- Rotation
      Scale       : Vector3;    -- Scale
   end record 
      with Convention => C_Pass_By_Copy;

   -- Bone_Info, skeletal animation bone
   type Bone_Info_Name is Array (0 .. 31) of char;
   type Bone_Info is record 
      Name   : Bone_Info_Name; -- Bone name
      Parent : int;            -- Bone parent
   end record 
      with Convention => C_Pass_By_Copy;

   -- Model, meshes, materials and animation data
   type Model is record 
      Matrix : Transform;  -- Local transformation matrix

      Mesh_Count     : int;             -- Number of meshes
      Material_Count : int;             -- Number of materials
      Meshes         : access Mesh;     -- Meshes array
      Materials      : access Material; -- Materials array
      Mesh_Material  : int;             -- Mesh material number

      -- Animation data
      Bone_Count : int;              -- Number of bones
      Bones      : access Bone_Info; -- Bones information (skeleton)
      Bind_Pose  : access Transform; -- Bones base transformation (pose)
   end record 
      with Convention => C_Pass_By_Copy;

   -- Model_Animation
   type Model_Animation_Name is Array (0 .. 31) of char;
   type Model_Animation is record 
      Bone_Count  : int;                  -- Number of bones
      Frame_Count : int;                  -- Number of animation frames
      Bones       : access Bone_Info;     -- Bones information (skeleton)
      Name        : Model_Animation_Name; -- Animation name
   end record 
      with Convention => C_Pass_By_Copy;

   -- Ray, ray for raycasting
   type Ray is record 
      Position  : Vector3; -- Ray position (origin)
      Direction : Vector3; -- Ray direction (normalized)
   end record 
      with Convention => C_Pass_By_Copy;

   -- TODO : Ray_Collision

   -- Bounding_Box
   type Bounding_Box is record 
      Min : Vector3; -- Minimum vertex box-corner
      Max : Vector3; -- Maximum vertex box-corner
   end record 
      with Convention => C_Pass_By_Copy;

   -- Wave, audio wave data
   type Wave is record 
      Frame_Count : unsigned;       -- Total number of frames (considering channels)
      Sample_Rate : unsigned;       -- Frequency (samples per second)
      Sample_Size : unsigned;       -- Bit depth (bits per sample): 8, 16, 32 (24 not supported) 
      Channels    : unsigned;       -- Number of channels (1-mono, 2-stereo, ...)
      Data        : System.Address; -- Buffer data pointer
   end record 
      with Convention => C_Pass_By_Copy;

   -- Audio_Stream, custom audio stream
   type Audio_Stream is record 
      Buffer    : System.Address; -- Pointer to internal data used by the audio system
      Processor : System.Address; -- Pointer to internal data processor, useful for audio effects
      
      Sample_Rate : unsigned; -- Frequency (samples per second)
      Sample_Size : unsigned; -- Bit depth (bits per sample): 8, 16, 32 (24 not supported) 
      Channels    : unsigned; -- Number of channels (1-mono, 2-stereo, ...)
   end record 
      with Convention => C_Pass_By_Copy;

   -- Sound
   type Sound is record
      Stream      : Audio_Stream; -- Audio stream
      Frame_Count : unsigned;     -- Total number of frames (considering channels)
   end record
      with Convention => C_Pass_By_Copy;

   -- Music, audio stream, anything longer than ~10 seconds should be streamed
   type Music is record 
      Stream      : Audio_Stream; -- Audio stream
      Frame_Count : unsigned;     -- Total number of frames (considering channels)
      -- TODO : looping bool          -- Music looping enable

      Ctx_Type : int;            -- Type of music context (audio filetype)
      Ctx_Data : System.Address; -- Audio context data, depends on type
   end record 
      with Convention => C_Pass_By_Copy;

   -- TODO : VrDeviceConfig
   -- TODO : VrStereoConfig

   -- File path list
   type File_Path_List is record 
      Capacity : unsigned;         -- Filepaths max entrires
      Count    : unsigned;         -- Filepaths entries count
      Paths    : access chars_ptr; -- Filepaths entries
   end record 
      with Convention => C_Pass_By_Copy;

   -- Automation event
   type Automation_Event_Params is Array (0 .. 3) of int;
   type Automation_Event is record 
      Frame      : unsigned;                -- Event frame
      Event_Type : unsigned;                -- Event type (Automation_Event_type)
      Params     : Automation_Event_Params; -- Event parameters (if any)
   end record 
      with Convention => C_Pass_By_Copy;

   -- Automation event list
   type Automation_Event_List is record 
      Capacity : unsigned;                -- Event max entries (MAX_AUTOMATION_EVENTS)
      Count    : unsigned;                -- Event entries count
      Events   : access Automation_Event; -- Event entries
   end record 
      with Convention => C_Pass_By_Copy;
   
   --//////////////////////////////////////////////////////////////////////////
   -- Predefined color constants
   --//////////////////////////////////////////////////////////////////////////
   Light_Gray  : constant Color := (200, 200, 200, 255);
   Gray        : constant Color := (130, 130, 130, 255);
   Dark_Gray   : constant Color := (80, 80, 80, 255);
   Yellow      : constant Color := (253, 249, 0, 255);
   Gold        : constant Color := (255, 203, 0, 255);
   Orange      : constant Color := (255, 161, 0, 255);
   Pink        : constant Color := (255, 109, 194, 255);
   Red         : constant Color := (230, 41, 55, 255);
   Maroon      : constant Color := (190, 33, 55, 255);
   Green       : constant Color := (0, 228, 48, 255);
   Lime        : constant Color := (0, 158, 47, 255);
   Dark_Green  : constant Color := (0, 117, 44, 255);
   Sky_Blue    : constant Color := (102, 191, 255, 255);
   Blue        : constant Color := (0, 121, 241, 255);
   Dark_Blue   : constant Color := (0, 82, 172, 255);
   Purple      : constant Color := (200, 122, 255, 255);
   Violet      : constant Color := (135, 60, 190, 255);
   Dark_Purple : constant Color := (112, 31, 126, 255);
   Beige       : constant Color := (211, 176, 131, 255);
   Brown       : constant Color := (127, 106, 79, 255);
   Dark_Brown  : constant Color := (76, 63, 47, 255);

   White     : constant Color := (255, 255, 255, 255);
   Black     : constant Color := (0, 0, 0, 255);
   Blank     : constant Color := (0, 0, 0, 0);
   Magenta   : constant Color := (255, 0, 255, 255);
   Ray_White : constant Color := (245, 245, 245, 255);

   --//////////////////////////////////////////////////////////////////////////
   -- Window-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Initialize window and OpenGL context
   procedure Init_Window (Width, Height : int; Title : String);
   -- Close window and unload OpenGL context
   procedure Close_Window
      with 
         Import        => true,
         Convention    => C,
         External_Name => "CloseWindow";
   -- Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
   function Window_Should_Close return Boolean;
   -- Check if window has been initialized successfully
   function Is_Window_Ready return Boolean;
   -- Check if window is currently fullscreen
   function Is_Window_Fullscreen return Boolean;
   -- Check if window is currently hidden
   function Is_Window_Hidden return Boolean;
   -- Check if window is currently minimized
   function Is_Window_Minimized return Boolean;
   -- Check if window is currently maximized
   function Is_Window_Maximized return Boolean;
   -- Check if window is currently focused
   function Is_Window_Focused return Boolean;
   -- Check if window has been resized last frame
   function Is_Window_Resized return Boolean;
   -- Check if one specific window flag is enabled
   function Is_Window_State (Flag : unsigned) return Boolean;
   -- Set window configuration state using flags
   procedure Set_Window_State (Flags : unsigned) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowState";
   -- Clear window configuration state flags
   procedure Clear_Window_State (Flags : unsigned) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "ClearWindowState";
   -- Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
   procedure Toggle_Fullscreen 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "ToggleFullscreen";
   -- Toggle window state: borderless windowed, resizes window to match monitor resolution
   procedure Toggle_Borderless_Windowed 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "ToggleBorderlessWindowed";
   -- Set window state: maximized, if resizable
   procedure Maximize_Window
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "MaximiseWindow";
   -- Set window state: minimized, if resizable
   procedure Minimize_Window
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "MinimizeWindow";
   -- Set window state: not minimized/maximized
   procedure Restore_Window
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "RestoreWindow";
   -- Set icon for window (single image, RGBA 32bit)
   procedure Set_Window_Icon (Img : Image) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowIcon";
   -- Set icon for window (multiple images, RGBA 32bit)
   procedure Set_Window_Icons (Imgs : access Image; Count : int) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowIcons";
   -- Set title for window
   procedure Set_Window_Title (Title : String);
   -- Set window position on screen
   procedure Set_Window_Position (X, Y : int)
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowPosition";
   -- Set monitor for the current window
   procedure Set_Window_Monitor (Monitor : int) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowMonitor";
   -- Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
   procedure Set_Window_Min_Size (Width, Height : int) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowMinSize";
   -- Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
   procedure Set_Window_Max_Size (Width, Height : int) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowMaxSize";
   -- Set window dimensions
   procedure Set_Window_Size (Width, Height : int) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowSize";
   -- Set window opacity [0.0f..1.0f]
   procedure Set_Window_Opacity (Opacity : float) 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowOpacity";
   -- Set window focused
   procedure Set_Window_Focused 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "SetWindowFocused";
   -- Get native window handle
   function Get_Window_Handle return System.Address
      with 
         Import        => true,
         Convention    => C,
         External_Name => "GetWindowHandle";
   -- Get current screen width
   function Get_Screen_Width return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetScreenWidth";
   -- Get current screen height
   function Get_Screen_Height return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetScreenHeight";
   -- Get current render width (it considers HiDPI)
   function Get_Render_Width return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetRenderWidth";
   -- Get current render height (it considers HiDPI)
   function Get_Render_Height return int 
      with 
         Import        => true,
         Convention    => C, 
         External_Name => "GetRenderWidth";
   -- Get number of connected monitors
   function Get_Monitor_Count return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorCount";
   -- Get current monitor where window is placed
   function Get_Current_Monitor return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetCurrentMonitor";
   -- Get specified monitor position  
   function Get_Monitor_Position(Monitor : int) return Vector2
      with 
         Import        => true,
         Convention    => C,
         External_Name => "GetMonitiorPosition";
   -- Get specified monitor width (current video mode used by monitor)
   function Get_Monitor_Width (Monitor : int) return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorWidth";
   -- Get specified monitor height (current video mode used by monitor) return int
   function Get_Monitor_Height (Monitor : int) return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorHeight";
   -- Get specified monitor physical width in millimetres
   function Get_Monitor_Physical_Width (Monitor : int) return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorPhysicalWidth";
   -- Get specified monitor physical height in millimetres
   function Get_Monitor_Physical_Height (Monitor : int) return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorPhysicalHeight";
   -- Get specified monitor refresh rate
   function Get_Monitor_Refresh_Rate (Monitor : int) return int 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetMonitorRefreshRate";
   -- Get window position XY on monitor
   function Get_Window_Position return Vector2 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetWindowPosition";
   -- Get window scale DPI factor
   function Get_Window_Scale_DPI return Vector2 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "GetWindowScaleDPI";
   -- Get the human-readable, UTF-8 encoded name of the specified monitor
   function Get_Monitor_Name (Monitor : int) return String;   
   -- Set clipboard text content
   procedure Set_Clipboard_Text (Text : String);
   -- Get clipboard text content
   function Get_Clipboard_Text return String;
   -- Get clipboard image content
   function Get_Clipboard_Image return Image
      with 
         Import        => true,
         Convention    => C,
         External_Name => "GetClipboardImage";
   -- Enable waiting for events on EndDrawing(), no automatic event polling
   procedure Enable_Event_Waiting 
      with 
         Import        => true,
         Convention    => C,
         External_Name => "EnableEventWaiting";
   -- Disable waiting for events on EndDrawing(), automatic events polling
   procedure Disable_Event_Waiting 
      with 
         Import        => true,
         Convention    => C,
         External_Name => "DisableEventWaiting";

   --//////////////////////////////////////////////////////////////////////////
   -- Cursor-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Shows cursor
   procedure Show_Cursor 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "ShowCursor";
   -- Hides cursor
   procedure Hide_Cursor 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "HideCursor";
   -- Check if cursor is not visible
   function Is_Cursor_Hidden return Boolean;
   -- Enables cursor (unlock cursor)
   procedure Enable_Cursor 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "EnableCursor";
   -- Disables cursor (lock cursor)
   procedure Disable_Cursor 
      with 
         Import        => true, 
         Convention    => C, 
         External_Name => "DisableCursor";
   -- Check if cursor is on the screen
   function Is_Cursor_On_Screen return Boolean;
 
   --//////////////////////////////////////////////////////////////////////////
   --  TODO :VR stereo config functions and procedures for VR simulator
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- Shader management functions and procedures
   -- NOTE: Shader functionality is not available on OpenGL 1.1
   --//////////////////////////////////////////////////////////////////////////
   -- Load shader from files and bind default locations
   function Load_Shader (Vs_File_Name, Fs_File_Name : String) return Shader;
   -- Load shader from code strings and bind default locations
   function Load_Shader_From_Memory (Vs_Code, Fs_Code : String) return Shader;
   -- Check if a shader is valid (loaded on GPU)
   function Is_Shader_Valid (Shadr : Shader) return Boolean;
   -- Get shader uniform location
   function Get_Shader_Location
      (Shadr : Shader; Uniform_Name : String) return int;
   -- Get shader attribute location
   function Get_Shader_Location_Attrib 
      (Shadr : shader; Attrib_Name : String) return int;
   -- Set shader uniform value
   procedure Set_Shader_Value 
      (Shadr        : Shader; 
       Loc_Index    : int; 
       Value        : System.Address; 
       Uniform_Type : int)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetShaderValue";
   -- Set shader uniform value vector
   procedure Set_Shader_Value_V
      (Shadr               : shader; 
       Loc_Index           : int; 
       Value               : System.Address;
       Uniform_Type, Count : int)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetShaderValueV";
   -- Set shader uniform value (matrix 4x4)
   procedure Set_Shader_Value_Matrix 
      (Shadr : Shader; Loc_Index : int; Mat : Matrix)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetShaderValueMatrix";
   -- Set shader uniform value for texture (sampler2d)
   procedure Set_Shader_Value_Texture 
      (Shadr : Shader; Loc_Index : int; Texture : Texture_2D)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetShaderValueTexture";
   -- Unload shader from GPU memory (VRAM)
   procedure Unload_Shader (Shadr : shader)
      with
         Import        => true,
         Convention    => C,
         External_Name => "UnloadShader";

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Screen-space-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- Timing-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Set target FPS (maximum)
   procedure Set_Target_FPS (FPS : int)
      with 
         Import        => true,
         Convention    => C,
         External_Name => "SetTargetFPS";
   -- Get time in seconds for last frame drawn (delta time)
   function Get_Frame_Time return Float
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetFrameTime";
   -- Get time elapsed since InitWindow()
   function Get_Time return Double
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTime";
   -- Get current FPS
   function Get_FPS return int
      with 
         Import        => true,
         Convention    => C,
         External_Name => "GetFPS";

   --//////////////////////////////////////////////////////////////////////////
   -- Custom frame control procedures
   -- NOTE: Those functions are intended for advanced users that want full 
   --       control over the frame processing. By default EndDrawing() does 
   --       this job: draws everything + SwapScreenBuffer() + 
   --       manage frame timing + PollInputEvents(). To avoid that behaviour 
   --       and control frame processes manually, enable in config.h: 
   --       SUPPORT_CUSTOM_FRAME_CONTROL
   --//////////////////////////////////////////////////////////////////////////
   -- Swap back buffer with front buffer (screen drawing)
   procedure Swap_Screen_Buffer
      with
         Import        => true,
         Convention    => C,
         External_Name => "SwapScreenBuffer";
   -- Register all input events
   procedure Poll_Input_Events
      with
         Import        => true,
         Convention    => C,
         External_Name => "PollInputEvents";
   -- Wait for some time (halt program execution)
   procedure Wait_Time (Seconds : Double)
      with
         Import        => true,
         Convention    => C,
         External_Name => "WaitTime";

   --//////////////////////////////////////////////////////////////////////////
   -- Random values generation functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Set the seed for the random number generator
   procedure Set_Random_Seed (Seed : unsigned)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetRandomSeed";
   -- Get a random value between min and max (both included)
   function Get_Random_Value (Min, Max : int) return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetRandomValue";
   -- Load random values sequence, no values repeated
   function Load_Random_Sequence 
      (Count : unsigned; Min, Max : int) return access int
      with
         Import        => true,
         Convention    => C,
         External_Name => "LoadRandomSequence";
   -- Unload random values sequence
   procedure Unload_Random_Sequence (Sequence : access int)
      with
         Import        => true,
         Convention    => C,
         External_Name => "UnloadRandomSequence";

   --//////////////////////////////////////////////////////////////////////////
   -- Misc. procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Takes a screenshot of current screen (filename extension defines format)
   procedure Take_Screenshot (File_Name : String);
   -- Setup init configuration flags (view FLAGS)
   procedure Set_Config_Flags (Flags : unsigned)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetConfigFlags";
   -- Open URL with default system browser (if available)
   procedure Open_URL (URL : String);

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Maybe do the utils procedures
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Set custom callbacks
   -- WARNING : Callbacks setup is intended for advanced users
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Files management functions and procedures
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : File system functions and procedures
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Compression/Encoding functionality
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Automation events functionality
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- Input handling functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Input-related functions: keyboard
   -- Check if a key has been pressed once
   function Is_Key_Pressed (Key : Keyboard_Key) return Boolean;
   -- Check if a key has been pressed again
   function Is_Key_Pressed_Repeat (Key : Keyboard_Key) return Boolean;
   -- Check if a key is being pressed
   function Is_Key_Down (Key : Keyboard_Key) return Boolean;
   -- Check if a key has been released once
   function Is_Key_Released (Key : Keyboard_Key) return Boolean;
   -- Check if a key is NOT being pressed
   function Is_Key_Up (Key : Keyboard_Key) return Boolean;
   -- Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
   function Get_Key_Pressed return Keyboard_Key
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetKeyPressed";
   -- Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
   function Get_Char_Pressed return Wide_Character;
   -- Set a custom key to exit program (default is ESC)
   procedure Set_Exit_Key (Key : Keyboard_Key)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetExitKey";

   -- Input-related functions: gamepads
   -- Check if a gamepad is available
   function Is_Gamepad_Available (Gamepad : int) return Boolean;
   -- Get gamepad internal name id
   function Get_Gamepad_Name (Gamepad : int) return String;
   -- Check if a gamepad button has been pressed once
   function Is_Gamepad_Button_Pressed 
      (Gamepad : int; Button : Gamepad_Button) return Boolean;
   -- Check if a gamepad button is being pressed
   function Is_Gamepad_Button_Down
      (Gamepad : int; Button : Gamepad_Button) return Boolean;
   -- Check if a gamepad button has been released once
   function Is_Gamepad_Button_Released 
      (Gamepad : int; Button : Gamepad_Button) return Boolean;
   -- Check if a gamepad button is NOT being pressed
   function Is_Gamepad_Button_Up 
      (Gamepad : int; Button : Gamepad_Button) return Boolean;
   -- Get the last gamepad button pressed
   function Get_Gamepad_Button_Pressed return Gamepad_Button
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetGamepadButtonPressed";
   -- Get gamepad axis count for a gamepad
   function Get_Gamepad_Axis_Count (Gamepad : int) return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetGamepadAxisCount";
   -- Get axis movement value for a gamepad axis
   function GetGamepadAxisMovement
      (Gamepad : int; Axis : Gamepad_Axis) return Float
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetGamepadAxisMovement";
   -- Set internal gamepad mappings (SDL_GameControllerDB)
   function Set_Gamepad_Mappings (Mappings : String) return int;
   -- Set gamepad vibration for both motors (duration in seconds)
   procedure Set_Gamepad_Vibration 
      (Gamepad : int; Left_Motor, Right_Motor, Duration : Float)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetGamepadVibration";

   -- Input-related functions: mouse
   -- Check if a mouse button has been pressed once
   function Is_Mouse_Button_Pressed (Button : Mouse_Button) return Boolean;
   -- Check if a mouse button is being pressed
   function Is_Mouse_Button_Down (Button : Mouse_Button) return Boolean;
   -- Check if a mouse button has been released once
   function Is_Mouse_Button_Released (Button : Mouse_Button) return Boolean;
   -- Check if a mouse button is NOT being pressed
   function Is_Mouse_Button_Up (Button : Mouse_Button) return Boolean;
   -- Get mouse position X
   function Get_Mouse_X return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMouseX";
   -- Get mouse position Y
   function Get_Mouse_Y return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMouseY";
   -- Get mouse position XY
   function Get_Mouse_Position return Vector2
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMousePosition";
   -- Get mouse delta between frames
   function Get_Mouse_Delta return Vector2
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMouseDelta";
   -- Set mouse position XY
   procedure Set_Mouse_Position (X, Y : int)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetMousePosition";
   -- Set mouse offset
   procedure Set_Mouse_Offset (Offset_X, Offset_Y : int)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetMouseOffset";
   -- Set mouse scaling
   procedure Set_Mouse_Scale (Scale_X, Scale_Y : Float)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetMouseScale";
   -- Get mouse wheel movement for X or Y, whichever is larger
   function Get_Mouse_Wheel_Move return Float
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMouseWheelMove";
   -- Get mouse wheel movement for both X and Y
   function Get_Mouse_Wheel_Move_V return Vector2
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetMouseWheelMoveV";
   -- Set mouse cursor
   procedure Set_Mouse_Cursor (Cursor : Mouse_Cursor)
      with
         Import        => true,
         Convention    => C,
         External_Name => "SetMouseCursor";

   -- Input-related functions: touch
   -- Get touch position X for touch point 0 (relative to screen size)
   function Get_Touch_X return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTouchX";
   -- Get touch position Y for touch point 0 (relative to screen size)
   function Get_Touch_Y return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTouchY";
   -- Get touch position XY for a touch point index (relative to screen size)
   function Get_Touch_Position (Index : int) return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTouchPosition";
   -- Get touch point identifier for given index 
   function Get_Touch_Point_Id (Index : int) return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTouchPointId";
   -- Get number of touch points
   function Get_Touch_Point_Count return int
      with
         Import        => true,
         Convention    => C,
         External_Name => "GetTouchPointCount";

   --//////////////////////////////////////////////////////////////////////////
   -- TODO : Gestures and Touch handling functions and procedures (module : rgestures)
   --//////////////////////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////////////////////
   -- Drawing-related functions and procedures
   --//////////////////////////////////////////////////////////////////////////
   -- Set background color (framebuffer clear color)
   procedure Clear_Background (Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "ClearBackground";
   -- Setup the canvas (framebuffer) to start drawing
   procedure Begin_Drawing
      with
         Import        => true,
         Convention    => C,
         External_Name => "BeginDrawing";
   -- End drawing and swap buffers (double buffering)
   procedure End_Drawing
      with
         Import        => true,
         Convention    => C,
         External_Name => "EndDrawing";
   -- Begin 2D mode with a custom camera (2D)
   procedure Begin_2D_Mode (Camera : Camera_2D)
      with
         Import        => true,
         Convention    => C,
         External_Name => "BeginMode2D";
   -- End 2D mode with custom camera
   procedure End_2D_Mode
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "EndMode2D";
   -- Begin 3D mode with a custom camera (3D)
   procedure Begin_3D_Mode (Camera : Camera3D)
      with
         Import        => true,
         Convention    => C,
         External_Name => "BeginMode3D";
   -- End 3D mode with custom camera
   procedure End_3D_Mode
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "EndMode3D";
   -- Begin drawing to render texture
   procedure Begin_Texture_Mode (Target : Render_Texture_2D) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "StartTextureMode";
   -- End drawing to render texture
   procedure End_Texture_Mode 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "EndTextureMode";
   -- Begin blending mode (alpha, addictive, multiplied, subtract, custom)
   procedure Begin_Blend_Mode (Mode : int) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "BeginBlendMode";
   -- End blending mode (reset to default : alpha blending)
   procedure End_Blend_Mode 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "EndBlendMode";
   -- Begin scissor mode (define screen area for following drawing)
   procedure Begin_Scissor_Mode (X, Y, Width, Height : int) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "BeginScissorMode";
   -- End scissor mode
   procedure End_Scissor_Mode 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "EndScissorMode";
   -- TODO : LoadVrStereoConfig
   -- TODO : UnloadVrStereoConfig
   
   --//////////////////////////////////////////////////////////////////////////
   -- Basic shapes Drawing functions (Module : shapes)
   --//////////////////////////////////////////////////////////////////////////
   -- Draw a pixel using geometry (Can be slow, use with care)
   procedure Draw_Pixel (X, Y : int; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawPixel";
   -- Draw a pixel using geometry (Vector version) (Can be slow, use with care)
   procedure Draw_Pixel_V (V : Vector2; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "Draw_Pixel_V";
   -- Draw a line
   procedure Draw_Line (Start_X, Start_Y, End_X, End_Y : int; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawLine";
   -- Draw a line (using GL lines)
   procedure Draw_Line_V (Start_Pos, End_Pos : Vector2; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawLineV";
   -- Draw a line (using triangles/quads)
   procedure Draw_Line_Ex 
     (Start_Pos, End_Pos : Vector2; Thick : Float; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawLineEx";
   -- Draw lines sequence (using GL lines)
   procedure Draw_Line_Strip 
     (Points : access Vector2; Point_Count : int; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawLineStrip";
   -- Draw a line segment cubic-bezier in-out interpolation
   procedure Draw_Line_Bezier 
     (Start_Pos, End_Pos : Vector2; Thick : Float; Col : Color)
      with
         Import        => true,
         Convention    => C,
         External_Name => "DrawLineBezier";
   -- Draw a color-filled circle
   procedure Draw_Circle 
      (Center_X, Center_Y : int; Radius : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircle";
   -- Draw a piece of a circle
   procedure Draw_Circle_Sector 
      (Center                         : Vector2; 
       Radius, Start_Angle, End_Angle : Float; 
       Segments                       : int; 
       Col                            : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleSector";
   -- Draw circle sector outline
   procedure Draw_Circle_Sector_Lines 
      (Center                         : Vector2; 
       Radius, Start_Angle, End_Angle : Float; 
       Segments                       : int; 
       Col                            : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleSectorLines";
   -- Draw gradient-filled circle
   procedure Draw_Circle_Gradient 
      (Center_X, Center_Y : int; 
       Radius             : Float; 
       Inner, Outer       : Color)
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleGradient";
   -- Draw color-filled circle (Vector version)
   procedure Draw_Circle_V (Center : Vector2; Radius : Float; Col : Color)
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleV";
   -- Draw circle outline
   procedure Draw_Circle_Lines 
      (Center_X, Center_Y : int; Radius : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleLines";
   -- Draw circle outline (Vector version)
   procedure Draw_Circle_Lines_V 
      (Center : Vector2; Radius : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawCircleLinesV";
   -- Draw ellipse
   procedure Draw_Ellipse 
      (Center_X, Center_Y : int; Radius_H, Radius_V : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawEllipse";
   -- Draw ellipse outline
   procedure Draw_Ellipse_Lines 
      (Center_X, Center_Y : int; Radius_H, Radius_V : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawEllipseLines";
   -- Draw ring
   procedure Draw_Ring 
      (Center                     : Vector2; 
       Inner_Radius, Outer_Radius : Float;
       Start_Angle, End_Angle     : Float; 
       Segments                   : int; 
       Col                        : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRing";
   -- Draw ring outline
   procedure Draw_Ring_Lines 
      (Center                     : Vector2; 
       Inner_Radius, Outer_Radius : Float;
       Start_Angle, End_Angle     : Float; 
       Segments                   : int; 
       Col                        : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRingLines";
   -- Draw a color-filled rectangle
   procedure Draw_Rectangle (Pos_X, Pos_Y, Width, Height : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangle";
   -- Draw a color-filled rectangle (Vector version)
   procedure Draw_Rectangle_V (Position, Size : Vector2; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleV";
   -- Draw a color-filled rectangle
   procedure Draw_Rectangle_Rec (Rec : Rectangle; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleRec";
   -- Draw a color-filled rectangle with pro parameters
   procedure Draw_Rectangle_Pro 
      (Rec : Rectangle; Origin : Vector2; Rotation : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectanglePro";
   -- Draw a vertical-gradient-filled rectangle
   procedure Draw_Rectangle_Gradient_V 
      (Pos_X, Pos_Y, Width, Height : int; Top, Bottom : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleGradientV";
   -- Draw a horizontal-gradient-filled rectangle
   procedure Draw_Rectangle_Gradient_H 
      (Pos_X, Pos_Y, Width, Height : int; Left, Right : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleGradientH";
   -- Draw a gradient-filled rectangle with custom vertex colors)
   procedure Draw_Rectangle_Gradient_Ex 
      (Rec : Rectangle; Top_Left, Bottom_Left, Top_Right, Bottom_Right : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleGradientEx";
   -- Draw rectangle outline 
   procedure Draw_Rectangle_Lines 
      (Pos_X, Pos_Y, Width, Height : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleLines";
   -- Draw rectangle outline with extended parameters
   procedure Draw_Rectangle_Lines_Ex 
      (Rec : Rectangle; Line_Thick : Float; Col : Color)
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleLinesEx";
   -- Draw rectangle with rounded edges
   procedure Draw_Rectangle_Rounded 
      (Rec : Rectangle; Roundness : Float; Segments  : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleRounded";
   -- Draw rectangle lines with rounded edges
   procedure Draw_Rectangle_Rounded_Lines 
      (Rec : Rectangle; Roundness : Float; Segments : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleRoundedLines";
   -- Draw rectangle with rounded edges outline
   procedure Draw_Rectangle_Rounded_Lines_Ex 
      (Rec        : Rectangle;
       Roundness  : Float; 
       Segments   : int; 
       Line_Thick : Float; 
       C          : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawRectangleRoundedLinesEx";
   -- Draw a color-filled triangle (vertex in counter-clockwise order!)
   procedure Draw_Triangle (V1, V2, V3 : Vector2; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawTriangle";
   -- Draw triangle outline (vertex in counter-clockwise order!)
   procedure Draw_Triangle_Lines (V1, V2, V3 : Vector2; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawTriangleLines";
   -- Draw a triangle fan defined by points (first vertex is the center)
   procedure Draw_Triangle_Fan 
      (Points : access Vector2; Point_Count : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawTriangleFan";
   -- Draw a triangle strip defined by points
   procedure Draw_Triangle_Strip 
      (Points : access Vector2; Point_Count : int; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawTriangleStrip";
   -- Draw a regular polygon (Vector version)
   procedure Draw_Poly 
      (Center : Vector2; Sides : int; Radius, Rotation : Float; Col : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawPoly";
   -- Draw a polygon outline of n sides
   procedure Draw_Poly_Lines 
      (Center : Vector2; Sides : int; Radius, Rotation : Float; Col : Color) 
      with
         Import        => true,
         Convention    => C, 
         External_Name => "DrawPolyLines";
   -- Draw a polygon outline of n sides with extended parameters
   procedure Draw_Poly_Lines_Ex 
      (Center                       : Vector2; 
       Sides                        : int; 
       Radius, Rotation, Line_Thick : Float; 
       Col                          : Color) 
      with
         Import        => true, 
         Convention    => C, 
         External_Name => "DrawPolyLinesEx";
      
      --///////////////////////////////////////////////////////////////////////
      -- Spline segment point evaluation functions, for a given t[0.0f .. 1.0f]
      --///////////////////////////////////////////////////////////////////////
      -- Get (evaluate) spline point: Linear
      function Get_Spline_Point_Linear (Start_Pos, End_Pos : Vector2; T : Float) return Vector2 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "GetSplinePointLinear";
      -- Get (evaluate) spline point: B-Spline
      function Get_Spline_Point_Basis (P1, P2, P3, P4 : Vector2; T : Float) return Vector2 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "GetSplinePointBasis";
      -- Get (evaluate) spline point: Catmull-Rom
      function Get_Spline_Point_Catmull_Rom (P1, P2, P3, P4 : Vector2; T : Float) return Vector2 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "GetSplinePointCatmullRom";
      -- Get (evaluate) spline point: Quadratic Bezier
      function Get_Spline_Point_Bezier_Quad (P1, C2, P3 : Vector2; T : Float) return Vector2 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "GetSplinePointBezierQuad";
      -- Get (evaluate) spline point: Cubic Bezier
      function Get_Spline_Point_Bezier_Cubic (P1, C2, C3, P4 : Vector2; T : Float) return Vector2 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "GetSplinePointBezierCubic";

      --///////////////////////////////////////////////////////////////////////
      -- Basic shapes collision detection functions
      --///////////////////////////////////////////////////////////////////////
      -- TODO : CheckCollisionRecs
      -- TODO : CheckCollisionCircles
      -- TODO : CheckCollisionCircleRec
      -- TODO : CheckCollisionCircleLine
      -- TODO : CheckCollisionPointRec
      -- TODO : CheckCollisionPointCircle
      -- TODO : CheckCollisionPointTriangle
      -- TODO : CheckCollisionPointLine
      -- TODO : CheckCollisionPointPoly
      -- TODO : CheckCollisionLines
      -- TODO : GetCollisionRec

   package Input is 
   end Input;

   package Textures is
      --///////////////////////////////////////////////////////////////////////
      -- Image loading functions
      -- NOTE: These functions do not require GPU access
      --///////////////////////////////////////////////////////////////////////
      -- Load image from file into CPU memory (RAM)
      function Load_Image (File_Name : String) return Image;
      -- Load image from RAW file data
      function Load_Image_Raw 
         (File_Name : String; Width, Height, Format, Header_Size : int) return Image;
      -- Load image sequence from file (frames appended to image.data)
      function Load_Image_Anim (File_Name : String; Frames : access int) return Image;
      -- Load image sequence from memory buffer      
      function Load_Image_Anim_From_Memory 
         (File_Type : String; 
          File_Data : access unsigned_char; 
          Data_Size : int; 
          Frames : access int) return Image; 
      -- Load image from memory buffer, fileType refers to extension: i.e. '.png'
      function Load_Image_From_Memory 
         (File_Type : String; File_Data : access unsigned_char; Data_Size : int) return Image;
      -- Load image from GPU texture data
      function Load_Image_From_Texture_2D(Texture : Texture_2D) return Image
         with 
            Import        => true,
            Convention    => C,
            External_Name => "LoadImageFromTexture";
      -- Load image from screen buffer and (screenshot)
      function Load_Image_From_Screen return Image
         with 
            Import        => true,
            Convention    => C,
            External_Name => "LoadImageFromScreen";
      -- Check if an image is valid (data and parameters)
      function Is_Image_Valid(Img : Image) return Boolean;
      -- Unload image from CPU memory (RAM)
      procedure Unload_Image (Img : Image)
         with 
            Import        => true,
            Convention    => C,
            External_Name => "UnloadImage";
      -- Export image data to file, returns true on success
      function Export_Image (Img : Image; File_Name : String) return Boolean;
      -- Export image to memory buffer
      function Export_Image_To_Memory (Img : Image; File_Type : String; File_Size : access int) return access unsigned_char;
      -- Export image as code file defining an array of bytes, returns true on success
      function Export_Image_As_Code (Img : Image; File_Name : String) return Boolean;

      --///////////////////////////////////////////////////////////////////////
      -- Image generation functions
      --///////////////////////////////////////////////////////////////////////
      -- TODO : Image GenImageColor(int width, int height, Color color);                                 // Generate image: plain color
      -- TODO : Image GenImageGradientLinear(int width, int height, int direction, Color start, Color end);      // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
      -- TODO : Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);     // Generate image: radial gradient
      -- TODO : Image GenImageGradientSquare(int width, int height, float density, Color inner, Color outer);     // Generate image: square gradient
      -- TODO : Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);   // Generate image: checked
      -- TODO : Image GenImageWhiteNoise(int width, int height, float factor);                            // Generate image: white noise
      -- TODO : Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);         // Generate image: perlin noise
      -- TODO : Image GenImageCellular(int width, int height, int tileSize);                              // Generate image: cellular algorithm, bigger tileSize means bigger cells
      -- TODO : Image GenImageText(int width, int height, const char *text);                              // Generate image: grayscale image from text data

      --///////////////////////////////////////////////////////////////////////
      -- Image manipulation functions
      --///////////////////////////////////////////////////////////////////////
      -- TODO : Image ImageCopy(Image image);                                                     // Create an image duplicate (useful for transformations)
      -- TODO : Image ImageFromImage(Image image, Rectangle rec);                                      // Create an image from another image piece
      -- TODO : Image ImageFromChannel(Image image, int selectedChannel);                                // Create an image from a selected channel of another image (GRAYSCALE)
      -- TODO : Image ImageText(const char *text, int fontSize, Color color);                             // Create an image from text (default font)
      -- TODO : Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);       // Create an image from text (custom sprite font)
      -- TODO : void ImageFormat(Image *image, int newFormat);                                        // Convert image data to desired format
      -- TODO : void ImageToPOT(Image *image, Color fill);                                           // Convert image to POT (power-of-two)
      -- TODO : void ImageCrop(Image *image, Rectangle crop);                                         // Crop an image to a defined rectangle
      -- TODO : void ImageAlphaCrop(Image *image, float threshold);                                    // Crop image depending on alpha value
      -- TODO : void ImageAlphaClear(Image *image, Color color, float threshold);                          // Clear alpha channel to desired color
      -- TODO : void ImageAlphaMask(Image *image, Image alphaMask);                                    // Apply alpha mask to image
      -- TODO : void ImageAlphaPremultiply(Image *image);                                            // Premultiply alpha channel
      -- TODO : void ImageBlurGaussian(Image *image, int blurSize);                                    // Apply Gaussian blur using a box blur approximation
      -- TODO : void ImageKernelConvolution(Image *image, const float *kernel, int kernelSize);               // Apply custom square convolution kernel to image
      -- TODO : void ImageResize(Image *image, int newWidth, int newHeight);                              // Resize image (Bicubic scaling algorithm)
      -- TODO : void ImageResizeNN(Image *image, int newWidth,int newHeight);                             // Resize image (Nearest-Neighbor scaling algorithm)
      -- TODO : void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill); // Resize canvas and fill with color
      -- TODO : void ImageMipmaps(Image *image);                                                   // Compute all mipmap levels for a provided image
      -- TODO : void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                     // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
      -- TODO : void ImageFlipVertical(Image *image);                                               // Flip image vertically
      -- TODO : void ImageFlipHorizontal(Image *image);                                             // Flip image horizontally
      -- TODO : void ImageRotate(Image *image, int degrees);                                          // Rotate image by input angle in degrees (-359 to 359)
      -- TODO : void ImageRotateCW(Image *image);                                                  // Rotate image clockwise 90deg
      -- TODO : void ImageRotateCCW(Image *image);                                                 // Rotate image counter-clockwise 90deg
      -- TODO : void ImageColorTint(Image *image, Color color);                                       // Modify image color: tint
      -- TODO : void ImageColorInvert(Image *image);                                                // Modify image color: invert
      -- TODO : void ImageColorGrayscale(Image *image);                                             // Modify image color: grayscale
      -- TODO : void ImageColorContrast(Image *image, float contrast);                                  // Modify image color: contrast (-100 to 100)
      -- TODO : void ImageColorBrightness(Image *image, int brightness);                                 // Modify image color: brightness (-255 to 255)
      -- TODO : void ImageColorReplace(Image *image, Color color, Color replace);                          // Modify image color: replace color
      -- TODO : Color *LoadImageColors(Image image);                                                // Load color data from image as a Color array (RGBA - 32bit)
      -- TODO : Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);                   // Load colors palette from image as a Color array (RGBA - 32bit)
      -- TODO : void UnloadImageColors(Color *colors);                                              // Unload color data loaded with LoadImageColors()
      -- TODO : void UnloadImagePalette(Color *colors);                                             // Unload colors palette loaded with LoadImagePalette()
      -- TODO : Rectangle GetImageAlphaBorder(Image image, float threshold);                              // Get image alpha border rectangle
      -- TODO : Color GetImageColor(Image image, int x, int y);                                       // Get image pixel color at (x, y) position

      --///////////////////////////////////////////////////////////////////////
      -- Image drawing functions
      -- NOTE: Image software-rendering functions (CPU)
      --///////////////////////////////////////////////////////////////////////
      -- TODO : void ImageClearBackground(Image *dst, Color color);                                    // Clear image background with given color
      -- TODO : void ImageDrawPixel(Image *dst, int posX, int posY, Color color);                          // Draw pixel within an image
      -- TODO : void ImageDrawPixelV(Image *dst, Vector2 position, Color color);                           // Draw pixel within an image (Vector version)
      -- TODO : void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color); // Draw line within an image
      -- TODO : void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);                    // Draw line within an image (Vector version)
      -- TODO : void ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color);           // Draw a line defining thickness within an image
      -- TODO : void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);            // Draw a filled circle within an image
      -- TODO : void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);                  // Draw a filled circle within an image (Vector version)
      -- TODO : void ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color);        // Draw circle outline within an image
      -- TODO : void ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color);               // Draw circle outline within an image (Vector version)
      -- TODO : void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);      // Draw rectangle within an image
      -- TODO : void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);             // Draw rectangle within an image (Vector version)
      -- TODO : void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);                        // Draw rectangle within an image
      -- TODO : void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);               // Draw rectangle lines within an image
      -- TODO : void ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);            // Draw triangle within an image
      -- TODO : void ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3); // Draw triangle with interpolated colors within an image
      -- TODO : void ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);        // Draw triangle outline within an image
      -- TODO : void ImageDrawTriangleFan(Image *dst, Vector2 *points, int pointCount, Color color);            // Draw a triangle fan defined by points within an image (first vertex is the center)
      -- TODO : void ImageDrawTriangleStrip(Image *dst, Vector2 *points, int pointCount, Color color);          // Draw a triangle strip defined by points within an image
      -- TODO : void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);          // Draw a source image within a destination image (tint applied to source)
      -- TODO : void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);   // Draw text (using default font) within an image (destination)
      -- TODO : void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text (custom sprite font) within an image (destination)

      --///////////////////////////////////////////////////////////////////////
      -- Texture loading functions
      -- NOTE: These functions require GPU access
      --///////////////////////////////////////////////////////////////////////
      -- TODO : Texture_2D LoadTexture(const char *fileName);                                          // Load texture from file into GPU memory (VRAM)
      -- Load texture from image data
      function Load_Texture_2D_From_Image(Img : Image) return Texture_2D
         with 
            Import        => true,
            Convention    => C,
            External_Name => "LoadTextureFromImage";
      -- TODO : TextureCubemap LoadTextureCubemap(Image image, int layout);                              // Load cubemap from image, multiple image cubemap layouts supported
      -- TODO : RenderTexture_2D LoadRenderTexture(int width, int height);                                // Load texture for rendering (framebuffer)
      -- TODO : bool IsTextureValid(Texture_2D texture);                                             // Check if a texture is valid (loaded in GPU)
      -- TODO : void UnloadTexture(Texture_2D texture);                                              // Unload texture from GPU memory (VRAM)
      -- TODO : bool IsRenderTextureValid(RenderTexture_2D target);                                     // Check if a render texture is valid (loaded in GPU)
      -- TODO : void UnloadRenderTexture(RenderTexture_2D target);                                      // Unload render texture from GPU memory (VRAM)
      -- TODO : void UpdateTexture(Texture_2D texture, const void *pixels);                               // Update GPU texture with new data
      -- TODO : void UpdateTextureRec(Texture_2D texture, Rectangle rec, const void *pixels);                  // Update GPU texture rectangle with new data

      --///////////////////////////////////////////////////////////////////////
      -- Texture configuration functions
      --///////////////////////////////////////////////////////////////////////
      -- Generate GPU mipmaps for a texture
      procedure Gen_Texture_Mipmaps (Texture : access Texture_2D) 
         with
            Import        => true, 
            Convention    => C,
            External_Name => "GenTextureMipmaps";
      -- Set texture scaling filter mode
      procedure Set_Texture_Filter (Texture : Texture_2D; Filter : int) 
         with
            Import        => true, 
            Convention    => C, 
            External_Name => "SetTextureFilter";
      -- Set texture wrapping mode
      procedure Set_Texture_Wrap (Texture : Texture_2D; Wrap : int) 
         with
            Import        => true, 
             Convention   => C, 
            External_Name => "SetTextureWrap";

      --///////////////////////////////////////////////////////////////////////
      -- Texture drawing functions
      --///////////////////////////////////////////////////////////////////////
      -- Draw a Texture_2D
      procedure Draw_Texture (Texture : Texture_2D; Pos_X, Pos_Y : int; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTexture";
      -- Draw a Texture_2D with position defined as Vector2
      procedure Draw_Texture_V (Texture : Texture_2D; Position : Vector2; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTextureV";
      -- Draw a Texture_2D with extended parameters
      procedure Draw_Texture_Ex (Texture : Texture_2D; Position : Vector2; Rotation, Scale : Float; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTextureEx";
      -- Draw a part of a texture defined by a rectangle
      procedure Draw_Texture_Rec (Texture : Texture_2D; Source : Rectangle; Position : Vector2; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTextureRec";
      -- Draw a part of a texture defined by a rectangle with 'pro' parameters
      procedure Draw_Texture_Pro (Texture : Texture_2D; Source, Dest : Rectangle; Origin : Vector2; Rotation : Float; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTexturePro";
      -- Draws a texture (or part of it) that stretches or shrinks nicely
      procedure Draw_Texture_NPatch (Texture : Texture_2D; Info : NPatch_Info; Dest : Rectangle; Origin : Vector2; Rotation : Float; Tint : Color) 
         with 
            Import        => True, 
            Convention    => C, 
            External_Name => "DrawTextureNPatch";

      --///////////////////////////////////////////////////////////////////////
      -- Color/pixel related functions
      --///////////////////////////////////////////////////////////////////////
      -- TODO : bool ColorIsEqual(Color col1, Color col2);                     // Check if two colors are equal
      -- TODO : Color Fade(Color color, float alpha);                         // Get color with alpha applied, alpha goes from 0.0f to 1.0f
      -- TODO : int ColorToInt(Color color);                                // Get hexadecimal value for a Color (0xRRGGBBAA)
      -- TODO : Vector4 ColorNormalize(Color color);                          // Get Color normalized as float [0..1]
      -- TODO : Color ColorFromNormalized(Vector4 normalized);                  // Get Color from normalized values [0..1]
      -- TODO : Vector3 ColorToHSV(Color color);                             // Get HSV values for a Color, hue [0..360], saturation/value [0..1]
      -- TODO : Color ColorFromHSV(float hue, float saturation, float value);       // Get a Color from HSV values, hue [0..360], saturation/value [0..1]
      -- TODO : Color ColorTint(Color color, Color tint);                      // Get color multiplied with another color
      -- TODO : Color ColorBrightness(Color color, float factor);                // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
      -- TODO : Color ColorContrast(Color color, float contrast);                // Get color with contrast correction, contrast values between -1.0f and 1.0f
      -- TODO : Color ColorAlpha(Color color, float alpha);                     // Get color with alpha applied, alpha goes from 0.0f to 1.0f
      -- TODO : Color ColorAlphaBlend(Color dst, Color src, Color tint);           // Get src alpha-blended into dst color with tint
      -- TODO : Color ColorLerp(Color color1, Color color2, float factor);         // Get color lerp interpolation between two colors, factor [0.0f..1.0f]
      -- TODO : Color GetColor(unsigned int hexValue);                        // Get Color structure from hexadecimal value
      -- TODO : Color GetPixelColor(void *srcPtr, int format);                  // Get Color from a source pixel pointer of certain format
      -- TODO : void SetPixelColor(void *dstPtr, Color color, int format);         // Set color formatted into destination pixel pointer
      -- TODO : int GetPixelDataSize(int width, int height, int format);           // Get pixel data size in bytes for certain format
   end Textures;

   package Timing is
      -- Set target FPS (maximum)
      procedure Set_Target_FPS (FPS : int)
         with 
            Import        => true,
            Convention    => C,
            External_Name => "SetTargetFPS";
      -- Get time in seconds for last frame drawn (delta time)
      function Get_Frame_Time return Float
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetFrameTime";
      -- Get time elapsed since InitWindow()
      function Get_Time return Double
         with
            Import        => true,
            Convention    => C,
            External_Name => "GetTime";
      -- Get current FPS
      function Get_FPS return int
         with 
            Import        => true,
            Convention    => C,
            External_Name => "GetFPS";
   end Timing;
end Raylib;
