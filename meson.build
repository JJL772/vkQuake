project('vkquake', ['c','cpp'],
	version: '1.0',
	license : ['GPL-2.0-only'],
	meson_version : '>= 0.50.0',
	default_options : [ 
		'warning_level=1', 
		'buildtype=debugoptimized',
		'cpp_std=c++20',
		'c_std=gnu11' ]
)

#
# Compiler flags
#
platform_args = []
ld_args = []

if ['linux','gnu','freebsd'].contains(host_machine.system())
	platform_args += [
		'-Wno-trigraphs',
		'-Wno-unused-function',
		'-DLINUX'
	]
	ld_args += [
		'-lc',
		'-lm'
	]
	if get_option('buildtype') == 'release'
		platform_args += ['-O3', '-DNDEBUG']
	else
		platform_args += ['-Og', '-D_DEBUG']
	endif
else
	ld_args += [
		'-mwindows',
		'-static-libgcc',
		'-lws2_32',
		'-lc',
		'-lm'
	]
	platform_args += [
		'-Wno-trigraphs',
		'-D_WIN32_WINNT=0x0501'
	]
	if get_option('buildtype') == 'release'
		platform_args += ['-O2', '-DNDEBUG']
	else
		platform_args += ['-g', '-Og', '-D_DEBUG']
	endif
endif

#
# Dependencies
#
deps = []
defines = []

sdl2_dep = dependency('sdl2')
vulkan_dep = dependency('vulkan')

vorbis_dep = dependency('vorbis', required: false)
flac_dep = dependency('flac', required: false)
mpg123_dep = dependency('mpg123', required: false)
opus_dep = dependency('opusfile', required: false)
vorbisdec_dep = dependency('vorbisdec', required: false)
mikmod_dep = dependency('mikmod', required: false)
modplug_dep = dependency('modplug', required: false)
xmp_dep = dependency('xmp', required: false)
umx_dep = dependency('umx', required: false)

deps += [vulkan_dep, sdl2_dep]

if vorbis_dep.found() and vorbisdec_dep.found() and get_option('vorbis')
	defines += ['-DUSE_CODEC_VORBIS']
	deps += [vorbis_dep, vorbisdec_dep]
endif

if flac_dep.found() and get_option('flac')
	defines += ['-DUSE_CODEC_FLAC']
	deps += [flac_dep]
endif

if mpg123_dep.found() and get_option('mp3')
	defines += ['-DUSE_CODEC_MP3']
	deps += [mpg123_dep]
endif

if get_option('wave')
	defines += ['-DUSE_CODEC_WAVE']
endif

if opus_dep.found() and get_option('opus')
	defines += ['-DUSE_CODEC_OPUS']
	deps += [opus_dep]
endif

if mikmod_dep.found() and get_option('mikmod')
	defines += ['-DUSE_CODEC_MIKMOD']
	deps += [mikmod_dep]
endif

if modplug_dep.found() and get_option('modplug')
	defines += ['-DUSE_CODEC_MODPLUG']
	deps += [modplug_dep]
endif

if xmp_dep.found() and get_option('xmp')
	defines += ['-DUSE_CODEC_XMP']
	deps += [xmp_dep]
endif

if umx_dep.found() and get_option('umx')
	deps += [umx_dep]
	defines += ['-DUSE_CODEC_UMX']
endif

#
# Sources
#

shaders = [
	'Shaders/Compiled/Release/alias_alphatest.frag.c',
	'Shaders/Compiled/Release/alias.frag.c',
	'Shaders/Compiled/Release/alias.vert.c',
	'Shaders/Compiled/Release/basic_alphatest.frag.c',
	'Shaders/Compiled/Release/basic_notex.frag.c',
	'Shaders/Compiled/Release/basic.frag.c',
	'Shaders/Compiled/Release/basic.vert.c',
	'Shaders/Compiled/Release/cs_tex_warp.comp.c',
	'Shaders/Compiled/Release/postprocess.frag.c',
	'Shaders/Compiled/Release/postprocess.vert.c',
	'Shaders/Compiled/Release/screen_effects_8bit_scale_sops.comp.c',
	'Shaders/Compiled/Release/screen_effects_8bit_scale.comp.c',
	'Shaders/Compiled/Release/screen_effects_8bit.comp.c',
	'Shaders/Compiled/Release/screen_effects_10bit_scale.comp.c',
	'Shaders/Compiled/Release/screen_effects_10bit_scale_sops.comp.c',
	'Shaders/Compiled/Release/screen_effects_10bit.comp.c',
	'Shaders/Compiled/Release/showtris.frag.c',
	'Shaders/Compiled/Release/showtris.vert.c',
	'Shaders/Compiled/Release/sky_box.frag.c',
	'Shaders/Compiled/Release/sky_layer.vert.c',
	'Shaders/Compiled/Release/sky_layer.frag.c',
	'Shaders/Compiled/Release/update_lightmap.comp.c',
	'Shaders/Compiled/Release/world.frag.c',
	'Shaders/Compiled/Release/world.vert.c',
]

src_win = [
	'Quake/net_win.c',
	'Quake/net_wins.c',
	'Quake/net_wipx.c',
	'Quake/pl_win.c',
	'Quake/sys_sdl_win.c',
]

src_posix = [
	'Quake/net_bsd.c',
	'Quake/net_udp.c',
	'Quake/pl_linux.c',
	'Quake/sys_sdl_unix.c',
]

src = [
	'Quake/bgmusic.c',
	'Quake/cd_sdl.c',
	'Quake/cfgfile.c',
	'Quake/chase.c',
	'Quake/cl_demo.c',
	'Quake/cl_input.c',
	'Quake/cl_main.c',
	'Quake/cl_parse.c',
	'Quake/cl_tent.c',
	'Quake/cmd.c',
	'Quake/common.c',
	'Quake/console.c',
	'Quake/crc.c',
	'Quake/cvar.c',
	'Quake/gl_draw.c',
	'Quake/gl_fog.c',
	'Quake/gl_heap.c',
	'Quake/gl_mesh.c',
	'Quake/gl_model.c',
	'Quake/gl_refrag.c',
	'Quake/gl_rlight.c',
	'Quake/gl_rmain.c',
	'Quake/gl_rmisc.c',
	'Quake/gl_screen.c',
	'Quake/gl_sky.c',
	'Quake/gl_texmgr.c',
	'Quake/gl_vidsdl.c',
	'Quake/gl_warp.c',
	'Quake/host_cmd.c',
	'Quake/host.c',
	'Quake/image.c',
	'Quake/in_sdl.c',
	'Quake/keys.c',
	'Quake/main_sdl.c',
	'Quake/mathlib.c',
	'Quake/mdfour.c',
	'Quake/menu.c',
	'Quake/miniz.c',
	'Quake/net_loop.c',
	'Quake/net_dgrm.c',
	'Quake/net_main.c',
	'Quake/palette.c',
	'Quake/pr_cmds.c',
	'Quake/pr_edict.c',
	'Quake/pr_exec.c',
	'Quake/pr_ext.c',
	'Quake/r_alias.c',
	'Quake/r_brush.c',
	'Quake/r_part_fte.c',
	'Quake/r_part.c',
	'Quake/r_sprite.c',
	'Quake/r_world.c',
	'Quake/sbar.c',
	'Quake/snd_codec.c',
	'Quake/snd_dma.c',
	'Quake/snd_flac.c',
	'Quake/snd_mem.c',
	'Quake/snd_mikmod.c',
	'Quake/snd_mix.c',
	'Quake/snd_modplug.c',
	'Quake/snd_mp3.c',
	'Quake/snd_mp3tag.c',
	'Quake/snd_opus.c',
	'Quake/snd_umx.c',
	'Quake/snd_sdl.c',
	'Quake/snd_vorbis.c',
	'Quake/snd_wave.c',
	'Quake/snd_xmp.c',
	'Quake/strlcat.c',
	'Quake/strlcpy.c',
	'Quake/sv_main.c',
	'Quake/sv_move.c',
	'Quake/sv_phys.c',
	'Quake/sv_user.c',
	'Quake/tasks.c',
	'Quake/view.c',
	'Quake/wad.c',
	'Quake/world.c',
	'Quake/zone.c',
]

src += shaders

# Platform specific sources
if ['linux','gnu','freebsd'].contains(host_machine.system())
	src += src_posix
else
	src += src_win
endif

project_args = platform_args
project_args += defines

add_project_arguments(project_args, language: ['c','cpp'])
add_project_link_arguments(ld_args, language: ['c', 'cpp'])

vkquake = executable('vkquake',
	sources: src,
	name_suffix: target_machine.cpu_family(),
	dependencies: deps,
	install: true,
	install_dir: ''
)