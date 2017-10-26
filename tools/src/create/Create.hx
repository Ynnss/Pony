package create;

import types.ProjectType;

class Create {

	private static inline var outputDir:String = 'bin/';
	private static inline var outputFile:String = 'app';

	public static function run(args:Array<String>):Void {

		var type:ProjectType = null;
		if (args.length > 0) for (t in ProjectType.createAll()) {
			if (t.getName().toLowerCase() == args[0].toLowerCase()) {
				type = t;
				break;
			}
		}

		var name:String = type != null ? args[1] : args[0];

		if (sys.FileSystem.exists(Utils.MAIN_FILE)) Utils.error(Utils.MAIN_FILE + ' exists');
				
		var project = new Project(name);

		if (type != null) switch type {
			case ProjectType.Server: create.targets.Server.set(project);
			case ProjectType.JS: create.targets.JS.set(project);
			case ProjectType.Pixi: create.targets.Pixi.set(project);
			case ProjectType.Node: create.targets.Node.set(project);
		}

		Utils.savePonyProject(project.result());

		var main = project.getMain();

		var ponycmd:String = 'build';
		if (type != null) switch type {
			case ProjectType.JS, ProjectType.Pixi:
				Utils.createEmptyMainFile(main);
			case ProjectType.Node:
				ponycmd = 'run';
				Utils.createEmptyMainFile(main);
			case _:
		}
		if (project.build.active) {
			var cfgfile = project.build.gethx('Config');
			if (!sys.FileSystem.exists(cfgfile))
				sys.io.File.saveContent(cfgfile, 'class Config implements pony.magic.PonyConfig {}');
		}

		create.ides.VSCode.create(ponycmd);
		create.ides.HaxeDevelop.create(name, main, project.getLibs(), project.getCps(), ponycmd);
	}



}