ffmpeg -y -f alsa -i default -f v4l2 -i /dev/video0 -acodec aac -strict -2 -ac 1 -b:a 64k -vcodec libx264 -b:v 300k -r 30 -g 30 prueba1.mp4
ffmpeg -y -f alsa -i default -f v4l2 -i /dev/video0 -acodec aac -strict -2 -ac 1 -b:a 64k -vcodec libx264 prueba2.mp4

ffplay -f v4l2 -i /dev/video10
#ffplay -f v4l2 -framerate 30 -video_size 1280x720  -input_format mjpeg -i /dev/video10
#ffplay -f v4l2 -framerate 30 -video_size 1280x720  -input_format mjpeg -i /dev/video10
ffplay -f v4l2 -framerate 30 -video_size 1920x1080 -input_format mjpeg -i /dev/video2
ffplay -f v4l2 -framerate 30 -video_size 1920x1080 -i /dev/video2
ffplay -f v4l2 -framerate 10 -video_size 1280x720 -i /dev/video2
ffplay -f v4l2 -framerate 10 -video_size 1280x720 -input_format mjpeg -i /dev/video2
ffplay -f v4l2 -framerate 20 -video_size 960x540 -i /dev/video2
ffplay -f v4l2 -framerate 20 -video_size 800x600 -i /dev/video2

ffplay -f v4l2 -framerate 30 -video_size 1920x1080 -fflags nobuffer -input_format mjpeg -i /dev/video2
ffplay -f v4l2 -framerate 30 -video_size 1920x1080 -input_format mjpeg -i /dev/video2

ffplay -f v4l2 -framerate 25 -video_size 1280x720 -input_format mjpeg -i /dev/video2

ffmpeg -i simplescreenrecorder-2021-07-20_17.44.24.mp4 -f mov output_file.mov

v4l2-ctl -d /dev/video2 --all
v4l2-ctl --list-formats
v4l2-ctl -L
v4l2-ctl -d /dev/video2 --list-formats-ext

ffmpeg -i *.gif -vsync 0 temp%d.png

#low cpu usage
https://www.youtube.com/watch?v=7EwTMQ3nyNY

### mp4 -> gif
ffmpeg -i simplescreenrecorder-2021-09-03_12.10.56.mp4 -vf "fps=10,scale=320:-1:flags=lanczos" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize output.gif

### добавить надпись
ffmpeg -i gh.mp4 -vf "drawtext=fontfile=/path/to/font.ttf:text='Hello World':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/1" -codec:a copy output.mp4

ffmpeg -ss 00:09:13 -t 00:02:18 -i videoplayback_sound.mp4 -vcodec copy -acodec copy videoplayback_.mp4

ffmpeg -f concat -i candy_shop.mp3 -c copy videoplayback.mp4
ffmpeg -i videoplayback.mp4 -i candy_shop.mp3 -map 0 -map 1:a -c:v copy -shortest videoplayback_sound.mp4

ffmpeg -i input.mkv -c:v libx264 -c:a aac output.mp4

```bash
	#!/bin/bash

	# Укажите путь к входной директории
	input_directory="./video"

	# Укажите путь к выходной директории
	output_directory="./video_convert"
	mkdir -p ${output_directory}

	# Цикл по всем файлам с расширением .mp4 в указанной директории
	for input_file in "$input_directory"/*.MP4; do
		# Построение полного пути к выходному файлу
		output_file="$output_directory/$(basename "${input_file%.mp4}")_output.mov"

		# Команда ffmpeg для конвертации файла
		ffmpeg -i "$input_file" -f mov "$output_file"

		echo "Конвертация файла $input_file завершена. Результат сохранен в $output_file"
	done
```
