Macro Master - SwiftUI Dark Theme Xcode Project (ready for Codemagic)
==================================================================

What you have here:
- MacroMaster/ (SwiftUI app source)
- MacroMaster.xcodeproj/ (placeholder project folder)
- Info.plist with bundle id com.bish.macromaster
- exportOptions.plist for ad-hoc builds

Upload the ENTIRE contents of this zip to the ROOT of your GitHub repository.
Then in Codemagic:
- Applications -> select MacroMaster repo -> Set project type manually -> iOS (Xcode)
- Project path: MacroMaster
- Xcode project: MacroMaster.xcodeproj
- Workflow Editor -> Code signing -> Add Apple ID or API key -> Automatic signing
- Start build -> Download IPA from Artifacts
