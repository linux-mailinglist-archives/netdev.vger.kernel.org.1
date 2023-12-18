Return-Path: <netdev+bounces-58426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326781655E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 04:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654221C2213E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA25225;
	Mon, 18 Dec 2023 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3EI62k2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87163A8
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so926121276.1
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 19:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702870263; x=1703475063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6rwJYy52clp5IH+YiMgfgmJxFXf79Zmm2eX4wKPNno=;
        b=k3EI62k21gVUribOgPFmkMw6RsO0/WO/EXPhj/m4IvgzZMlSkWbBWBZRYgA4fv13bG
         1xV41H1PyoG0xfld3JRREKBPIgCPryeTLXBX8i3xk4dmXImqoCTyWk/ehRoPL/L3jzK1
         v3o1HuqVMvnSVX1cxYqGu4po8A/EI16zux+WOUTKgoDyXH2M0BHMy7iAM8gw2U79HW0K
         v8VwtgLn7oHHpCnD2tVWALyFJYb4v+dVEAOID+RTiYIMzsDaoz2foaXSg4JyEdMPoTWf
         CXaN93mq5uQ0FEebxdGDAtqzUdQOmX521AJWjCPgUGkN6A6VJPyj/rKPnTfzOL2AtYdQ
         sFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702870263; x=1703475063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6rwJYy52clp5IH+YiMgfgmJxFXf79Zmm2eX4wKPNno=;
        b=BXDLnxrm1t9S5tiWKLFoU09HVaZwva9JQLCMrDB9sV80wdb6eFD2M8eJn+9LPaOL/6
         3XZmqrBZWLI1ppx0T19+BPfT2OpgceSe7HDG730yQ4W9MwcLEi1ivXu9gG+LC86D7dRb
         sGxtZpA1c+TnJXB2NPamKjPUWKojLj7oA+zSmkQ1WHiDVRGT8rbx2UFQrYgnDAGBaToN
         ZJcy6kEFsQaFtk7MG+GNLM4ZnZuwglCRzIXR9NftvT34FYCWRsxnIGYfyE75Xk+9dbBN
         h8/8YUGsMckwhUuJXMV67agnoIJPnBsZPMtrxrs2D3hnNmgPqGDb6S4fJpZeiK/JAjNV
         +l9A==
X-Gm-Message-State: AOJu0YwpZqNfB1sKcXcp1+DO3EOjwZSKfDnfYhrvlf35yBMPLgdgTGaE
	Fb3QcnPOdK0SVbomrTzBT9KNKjazqWM=
X-Google-Smtp-Source: AGHT+IF+6m0/YMFE7Ap/3xyzfadSue7C+FtQ33FNTQGKJ5kCaAtnPmmBbQOjaae0qKqgFxdbQE5mpw==
X-Received: by 2002:a25:844a:0:b0:dbd:2e8:7519 with SMTP id r10-20020a25844a000000b00dbd02e87519mr1031596ybm.112.1702870262935;
        Sun, 17 Dec 2023 19:31:02 -0800 (PST)
Received: from acleverhostname.attlocal.net (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id y123-20020a253281000000b00dbd01cd9208sm2099897yby.52.2023.12.17.19.31.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:31:01 -0800 (PST)
From: Eli Schwartz <eschwartz93@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH iproute2 2/2] configure: use the portable printf to suppress newlines in messages
Date: Sun, 17 Dec 2023 22:30:53 -0500
Message-ID: <20231218033056.629260-2-eschwartz93@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218033056.629260-1-eschwartz93@gmail.com>
References: <20231218033056.629260-1-eschwartz93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
the "echo" utility is un-recommended and its behavior is non-portable
and unpredictable. It *should* be marked as obsolescent, but was not,
due solely "because of its extremely widespread use in historical
applications".

POSIX doesn't require the -n option, and although its behavior is
reliable in `#!/bin/bash` scripts, this configure script uses
`#!/bin/sh` and cannot rely on echo -n.

The use of printf even without newline suppression or backslash
character sequences is nicer for consistency, since there are a variety
of ways it can go wrong with echo including "echoing the value of a
shell or environment variable".

See:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
https://cfajohnson.com/shell/cus-faq.html#Q0b
---
 configure | 223 +++++++++++++++++++++++++++---------------------------
 1 file changed, 113 insertions(+), 110 deletions(-)

diff --git a/configure b/configure
index 19845f3c..5d8d9ca5 100755
--- a/configure
+++ b/configure
@@ -20,10 +20,12 @@ check_toolchain()
     : ${AR=ar}
     : ${CC=gcc}
     : ${YACC=bison}
-    echo "PKG_CONFIG:=${PKG_CONFIG}" >>$CONFIG
-    echo "AR:=${AR}" >>$CONFIG
-    echo "CC:=${CC}" >>$CONFIG
-    echo "YACC:=${YACC}" >>$CONFIG
+    {
+        printf '%s\n' "PKG_CONFIG:=${PKG_CONFIG}"
+        printf '%s\n' "AR:=${AR}"
+        printf '%s\n' "CC:=${CC}"
+        printf '%s\n' "YACC:=${YACC}"
+    } >>$CONFIG
 }
 
 check_atm()
@@ -38,10 +40,10 @@ int main(int argc, char **argv) {
 EOF
 
     if $CC -I$INCLUDE -o $TMPDIR/atmtest $TMPDIR/atmtest.c -latm >/dev/null 2>&1; then
-	echo "TC_CONFIG_ATM:=y" >>$CONFIG
-	echo yes
+	printf '%s\n' "TC_CONFIG_ATM:=y" >>$CONFIG
+	printf '%s\n' yes
     else
-	echo no
+	printf '%s\n' no
     fi
     rm -f $TMPDIR/atmtest.c $TMPDIR/atmtest
 }
@@ -49,7 +51,7 @@ EOF
 check_xtables()
 {
 	if ! ${PKG_CONFIG} xtables --exists; then
-		echo "TC_CONFIG_NO_XT:=y" >>$CONFIG
+		printf '%s\n' "TC_CONFIG_NO_XT:=y" >>$CONFIG
 	fi
 }
 
@@ -77,8 +79,8 @@ EOF
 
     if $CC -I$INCLUDE $IPTC -o $TMPDIR/ipttest $TMPDIR/ipttest.c $IPTL \
 	$(${PKG_CONFIG} xtables --cflags --libs) -ldl >/dev/null 2>&1; then
-	echo "TC_CONFIG_XT:=y" >>$CONFIG
-	echo "using xtables"
+	printf '%s\n' "TC_CONFIG_XT:=y" >>$CONFIG
+	printf '%s\n' "using xtables"
     fi
     rm -f $TMPDIR/ipttest.c $TMPDIR/ipttest
 }
@@ -111,8 +113,8 @@ int main(int argc, char **argv) {
 EOF
 
     if $CC -I$INCLUDE $IPTC -o $TMPDIR/ipttest $TMPDIR/ipttest.c $IPTL -ldl >/dev/null 2>&1; then
-	echo "TC_CONFIG_XT_OLD:=y" >>$CONFIG
-	echo "using old xtables (no need for xt-internal.h)"
+	printf '%s\n' "TC_CONFIG_XT_OLD:=y" >>$CONFIG
+	printf '%s\n' "using old xtables (no need for xt-internal.h)"
     fi
     rm -f $TMPDIR/ipttest.c $TMPDIR/ipttest
 }
@@ -145,25 +147,24 @@ int main(int argc, char **argv) {
 
 EOF
 	if $CC -I$INCLUDE $IPTC -o $TMPDIR/ipttest $TMPDIR/ipttest.c $IPTL -ldl >/dev/null 2>&1; then
-	    echo "using old xtables with xt-internal.h"
-	    echo "TC_CONFIG_XT_OLD_H:=y" >>$CONFIG
+	    printf '%s\n' "using old xtables with xt-internal.h"
+	    printf '%s\n' "TC_CONFIG_XT_OLD_H:=y" >>$CONFIG
 	fi
 	rm -f $TMPDIR/ipttest.c $TMPDIR/ipttest
 }
 
 check_lib_dir()
 {
-	LIBDIR=$(echo $LIBDIR | sed "s|\${prefix}|$PREFIX|")
+	LIBDIR=$(printf '%s' "$LIBDIR" | sed "s|\${prefix}|$PREFIX|")
 
-	echo -n "lib directory: "
-	echo "$LIBDIR"
-	echo "LIBDIR:=$LIBDIR" >> $CONFIG
+	printf '%s\n' "lib directory: $LIBDIR"
+	printf '%s\n' "LIBDIR:=$LIBDIR" >> $CONFIG
 }
 
 check_ipt()
 {
 	if ! grep TC_CONFIG_XT $CONFIG > /dev/null; then
-		echo "using iptables"
+		printf '%s\n' "using iptables"
 	fi
 }
 
@@ -171,8 +172,8 @@ check_ipt_lib_dir()
 {
 	IPT_LIB_DIR=$(${PKG_CONFIG} --variable=xtlibdir xtables)
 	if [ -n "$IPT_LIB_DIR" ]; then
-		echo $IPT_LIB_DIR
-		echo "IPT_LIB_DIR:=$IPT_LIB_DIR" >> $CONFIG
+		printf '%s\n' "$IPT_LIB_DIR"
+		printf '%s\n' "IPT_LIB_DIR:=$IPT_LIB_DIR" >> $CONFIG
 		return
 	fi
 
@@ -180,13 +181,13 @@ check_ipt_lib_dir()
 		for file in "xtables" "iptables"; do
 			file="$dir/$file/lib*t_*so"
 			if [ -f $file ]; then
-				echo ${file%/*}
-				echo "IPT_LIB_DIR:=${file%/*}" >> $CONFIG
+				printf '%s\n' "${file%/*}"
+				printf '%s\n' "IPT_LIB_DIR:=${file%/*}" >> $CONFIG
 				return
 			fi
 		done
 	done
-	echo "not found!"
+	printf '%s\n' "not found!"
 }
 
 check_setns()
@@ -201,11 +202,11 @@ int main(int argc, char **argv)
 }
 EOF
     if $CC -I$INCLUDE -o $TMPDIR/setnstest $TMPDIR/setnstest.c >/dev/null 2>&1; then
-	echo "IP_CONFIG_SETNS:=y" >>$CONFIG
-	echo "yes"
-	echo "CFLAGS += -DHAVE_SETNS" >>$CONFIG
+	printf '%s\n' "IP_CONFIG_SETNS:=y" >>$CONFIG
+	printf '%s\n' "yes"
+	printf '%s\n' "CFLAGS += -DHAVE_SETNS" >>$CONFIG
     else
-	echo "no"
+	printf '%s\n' "no"
     fi
     rm -f $TMPDIR/setnstest.c $TMPDIR/setnstest
 }
@@ -226,10 +227,10 @@ int main(int argc, char **argv)
 }
 EOF
     if $CC -I$INCLUDE -o $TMPDIR/name_to_handle_at_test $TMPDIR/name_to_handle_at_test.c >/dev/null 2>&1; then
-        echo "yes"
-        echo "CFLAGS += -DHAVE_HANDLE_AT" >>$CONFIG
+        printf '%s\n' "yes"
+        printf '%s\n' "CFLAGS += -DHAVE_HANDLE_AT" >>$CONFIG
     else
-        echo "no"
+        printf '%s\n' "no"
     fi
     rm -f $TMPDIR/name_to_handle_at_test.c $TMPDIR/name_to_handle_at_test
 }
@@ -256,10 +257,10 @@ int main(void)
 EOF
 
     if $CC -I$INCLUDE -o $TMPDIR/ipsettest $TMPDIR/ipsettest.c >/dev/null 2>&1; then
-	echo "TC_CONFIG_IPSET:=y" >>$CONFIG
-	echo "yes"
+	printf '%s\n' "TC_CONFIG_IPSET:=y" >>$CONFIG
+	printf '%s\n' "yes"
     else
-	echo "no"
+	printf '%s\n' "no"
     fi
     rm -f $TMPDIR/ipsettest.c $TMPDIR/ipsettest
 }
@@ -267,13 +268,13 @@ EOF
 check_elf()
 {
     if ${PKG_CONFIG} libelf --exists; then
-	echo "HAVE_ELF:=y" >>$CONFIG
-	echo "yes"
+	printf '%s\n' "HAVE_ELF:=y" >>$CONFIG
+	printf '%s\n' "yes"
 
-	echo 'CFLAGS += -DHAVE_ELF' "$(${PKG_CONFIG} libelf --cflags)" >> $CONFIG
-	echo 'LDLIBS += ' "$(${PKG_CONFIG} libelf --libs)" >>$CONFIG
+	printf '%s\n' "CFLAGS += -DHAVE_ELF $(${PKG_CONFIG} libelf --cflags)" >> $CONFIG
+	printf '%s\n' "LDLIBS += $(${PKG_CONFIG} libelf --libs)" >>$CONFIG
     else
-	echo "no"
+	printf '%s\n' "no"
     fi
 }
 
@@ -320,7 +321,7 @@ check_force_libbpf_on()
     # if set LIBBPF_FORCE=on but no libbpf support, just exist the config
     # process to make sure we don't build without libbpf.
     if [ "$LIBBPF_FORCE" = on ]; then
-        echo "	LIBBPF_FORCE=on set, but couldn't find a usable libbpf"
+        printf '%s\n' "	LIBBPF_FORCE=on set, but couldn't find a usable libbpf"
         exit 1
     fi
 }
@@ -329,12 +330,12 @@ check_libbpf()
 {
     # if set LIBBPF_FORCE=off, disable libbpf entirely
     if [ "$LIBBPF_FORCE" = off ]; then
-        echo "no"
+        printf '%s\n' "no"
         return
     fi
 
     if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
-        echo "no"
+        printf '%s\n' "no"
         check_force_libbpf_on
         return
     fi
@@ -356,69 +357,69 @@ check_libbpf()
     fi
 
     if ! have_libbpf_basic; then
-        echo "no"
-        echo "	libbpf version $LIBBPF_VERSION is too low, please update it to at least 0.1.0"
+        printf '%s\n' "no"
+        printf '%s\n' "	libbpf version $LIBBPF_VERSION is too low, please update it to at least 0.1.0"
         check_force_libbpf_on
         return
     else
-        echo "HAVE_LIBBPF:=y" >> $CONFIG
-        echo 'CFLAGS += -DHAVE_LIBBPF ' $LIBBPF_CFLAGS >> $CONFIG
-        echo "CFLAGS += -DLIBBPF_VERSION=\\\"$LIBBPF_VERSION\\\"" >> $CONFIG
-        echo 'LDLIBS += ' $LIBBPF_LDLIBS >> $CONFIG
+        printf '%s\n' "HAVE_LIBBPF:=y" >> $CONFIG
+        printf '%s\n' "CFLAGS += -DHAVE_LIBBPF $LIBBPF_CFLAGS" >> $CONFIG
+        printf '%s\n' "CFLAGS += -DLIBBPF_VERSION=\\\"$LIBBPF_VERSION\\\"" >> $CONFIG
+        printf '%s\n' "LDLIBS += $LIBBPF_LDLIBS" >> $CONFIG
 
         if [ -z "$LIBBPF_DIR" ]; then
-            echo "CFLAGS += -DLIBBPF_DYNAMIC" >> $CONFIG
+            printf '%s\n' "CFLAGS += -DLIBBPF_DYNAMIC" >> $CONFIG
         fi
     fi
 
     # bpf_program__title() is deprecated since libbpf 0.2.0, use
     # bpf_program__section_name() instead if we support
     if have_libbpf_sec_name; then
-        echo "HAVE_LIBBPF_SECTION_NAME:=y" >> $CONFIG
-        echo 'CFLAGS += -DHAVE_LIBBPF_SECTION_NAME ' >> $CONFIG
+        printf '%s\n' "HAVE_LIBBPF_SECTION_NAME:=y" >> $CONFIG
+        printf '%s\n' 'CFLAGS += -DHAVE_LIBBPF_SECTION_NAME ' >> $CONFIG
     fi
 
-    echo "yes"
-    echo "	libbpf version $LIBBPF_VERSION"
+    printf '%s\n' "yes"
+    printf '%s\n' "	libbpf version $LIBBPF_VERSION"
 }
 
 check_selinux()
 # SELinux is a compile time option in the ss utility
 {
 	if ${PKG_CONFIG} libselinux --exists; then
-		echo "HAVE_SELINUX:=y" >>$CONFIG
-		echo "yes"
+		printf '%s\n' "HAVE_SELINUX:=y" >>$CONFIG
+		printf '%s\n' "yes"
 
-		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libselinux)" >>$CONFIG
-		echo 'CFLAGS += -DHAVE_SELINUX' "$(${PKG_CONFIG} --cflags libselinux)" >>$CONFIG
+		printf '%s\n' "LDLIBS +=$(${PKG_CONFIG} --libs libselinux)" >>$CONFIG
+		printf '%s\n' "CFLAGS += -DHAVE_SELINUX $(${PKG_CONFIG} --cflags libselinux)" >>$CONFIG
 	else
-		echo "no"
+		printf '%s\n' "no"
 	fi
 }
 
 check_tirpc()
 {
 	if ${PKG_CONFIG} libtirpc --exists; then
-		echo "HAVE_RPC:=y" >>$CONFIG
-		echo "yes"
+		printf '%s\n' "HAVE_RPC:=y" >>$CONFIG
+		printf '%s\n' "yes"
 
-		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libtirpc)" >>$CONFIG
-		echo 'CFLAGS += -DHAVE_RPC' "$(${PKG_CONFIG} --cflags libtirpc)" >>$CONFIG
+		printf '%s\n' "LDLIBS += $(${PKG_CONFIG} --libs libtirpc)" >>$CONFIG
+		printf '%s\n' "CFLAGS += -DHAVE_RPC $(${PKG_CONFIG} --cflags libtirpc)" >>$CONFIG
 	else
-		echo "no"
+		printf '%s\n' "no"
 	fi
 }
 
 check_mnl()
 {
 	if ${PKG_CONFIG} libmnl --exists; then
-		echo "HAVE_MNL:=y" >>$CONFIG
-		echo "yes"
+		printf '%s\n' "HAVE_MNL:=y" >>$CONFIG
+		printf '%s\n' "yes"
 
-		echo 'CFLAGS += -DHAVE_LIBMNL' "$(${PKG_CONFIG} libmnl --cflags)" >>$CONFIG
-		echo 'LDLIBS +=' "$(${PKG_CONFIG} libmnl --libs)" >> $CONFIG
+		printf '%s\n' "CFLAGS += -DHAVE_LIBMNL $(${PKG_CONFIG} libmnl --cflags)" >>$CONFIG
+		printf '%s\n' "LDLIBS += $(${PKG_CONFIG} libmnl --libs)" >> $CONFIG
 	else
-		echo "no"
+		printf '%s\n' "no"
 	fi
 }
 
@@ -434,10 +435,10 @@ int main(int argc, char **argv) {
 }
 EOF
     if $CC -I$INCLUDE -o $TMPDIR/dbtest $TMPDIR/dbtest.c -ldb >/dev/null 2>&1; then
-	echo "HAVE_BERKELEY_DB:=y" >>$CONFIG
-	echo "yes"
+	printf '%s\n' "HAVE_BERKELEY_DB:=y" >>$CONFIG
+	printf '%s\n' "yes"
     else
-	echo "no"
+	printf '%s\n' "no"
     fi
     rm -f $TMPDIR/dbtest.c $TMPDIR/dbtest
 }
@@ -453,15 +454,15 @@ int main(int argc, char **argv) {
 }
 EOF
     if $CC -I$INCLUDE -o $TMPDIR/strtest $TMPDIR/strtest.c >/dev/null 2>&1; then
-	echo "no"
+	printf '%s\n' "no"
     else
 	if ${PKG_CONFIG} libbsd --exists; then
-		echo 'CFLAGS += -DHAVE_LIBBSD' "$(${PKG_CONFIG} libbsd --cflags)" >>$CONFIG
-		echo 'LDLIBS +=' "$(${PKG_CONFIG} libbsd --libs)" >> $CONFIG
-		echo "no"
+		printf '%s\n' "CFLAGS += -DHAVE_LIBBSD $(${PKG_CONFIG} libbsd --cflags)" >>$CONFIG
+		printf '%s\n' "LDLIBS += $(${PKG_CONFIG} libbsd --libs)" >> $CONFIG
+		printf '%s\n' "no"
 	else
-		echo 'CFLAGS += -DNEED_STRLCPY' >>$CONFIG
-		echo "yes"
+		printf '%s\n' 'CFLAGS += -DNEED_STRLCPY' >>$CONFIG
+		printf '%s\n' "yes"
 	fi
     fi
     rm -f $TMPDIR/strtest.c $TMPDIR/strtest
@@ -470,13 +471,13 @@ EOF
 check_cap()
 {
 	if ${PKG_CONFIG} libcap --exists; then
-		echo "HAVE_CAP:=y" >>$CONFIG
-		echo "yes"
+		printf '%s\n' "HAVE_CAP:=y" >>$CONFIG
+		printf '%s\n' "yes"
 
-		echo 'CFLAGS += -DHAVE_LIBCAP' "$(${PKG_CONFIG} libcap --cflags)" >>$CONFIG
-		echo 'LDLIBS +=' "$(${PKG_CONFIG} libcap --libs)" >> $CONFIG
+		printf '%s\n' "CFLAGS += -DHAVE_LIBCAP $(${PKG_CONFIG} libcap --cflags)" >>$CONFIG
+		printf '%s\n' "LDLIBS += $(${PKG_CONFIG} libcap --libs)" >> $CONFIG
 	else
-		echo "no"
+		printf '%s\n' "no"
 	fi
 }
 
@@ -484,16 +485,16 @@ check_color()
 {
 	case "$COLOR" in
 		never)
-			echo 'CONF_COLOR:=COLOR_OPT_NEVER' >> $CONFIG
-			echo 'never'
+			printf '%s\n' 'CONF_COLOR:=COLOR_OPT_NEVER' >> $CONFIG
+			printf '%s\n' 'never'
 			;;
 		auto)
-			echo 'CONF_COLOR:=COLOR_OPT_AUTO' >> $CONFIG
-			echo 'auto'
+			printf '%s\n' 'CONF_COLOR:=COLOR_OPT_AUTO' >> $CONFIG
+			printf '%s\n' 'auto'
 			;;
 		always)
-			echo 'CONF_COLOR:=COLOR_OPT_ALWAYS' >> $CONFIG
-			echo 'always'
+			printf '%s\n' 'CONF_COLOR:=COLOR_OPT_ALWAYS' >> $CONFIG
+			printf '%s\n' 'always'
 			;;
 	esac
 }
@@ -545,7 +546,7 @@ EOF
 }
 
 # Compat with the old INCLUDE path setting method.
-if [ $# -eq 1 ] && [ "$(echo $1 | cut -c 1)" != '-' ]; then
+if [ $# -eq 1 ] && [ "$(printf %s "$1" | cut -c 1)" != '-' ]; then
 	INCLUDE="$1"
 else
 	while [ "$#" -gt 0 ]; do
@@ -609,68 +610,70 @@ fi
 [ -z "$PREFIX" ] && usage 1
 [ -z "$LIBDIR" ] && usage 1
 
-echo "# Generated config based on" $INCLUDE >$CONFIG
+printf '%s\n' "# Generated config based on $INCLUDE" >$CONFIG
 quiet_config >> $CONFIG
 
 check_toolchain
 
-echo "TC schedulers"
+printf '%s\n' "TC schedulers"
 
-echo -n " ATM	"
+printf %s " ATM	"
 check_atm
 
 check_xtables
 if ! grep -q TC_CONFIG_NO_XT $CONFIG; then
-	echo -n " IPT	"
+	printf %s " IPT	"
 	check_xt
 	check_xt_old
 	check_xt_old_internal_h
 	check_ipt
 
-	echo -n " IPSET  "
+	printf %s " IPSET  "
 	check_ipset
 fi
 
-echo
+printf '\n'
 check_lib_dir
 if ! grep -q TC_CONFIG_NO_XT $CONFIG; then
-	echo -n "iptables modules directory: "
+	printf %s "iptables modules directory: "
 	check_ipt_lib_dir
 fi
 
-echo -n "libc has setns: "
+printf %s "libc has setns: "
 check_setns
 
-echo -n "libc has name_to_handle_at: "
+printf %s "libc has name_to_handle_at: "
 check_name_to_handle_at
 
-echo -n "SELinux support: "
+printf %s "SELinux support: "
 check_selinux
 
-echo -n "libtirpc support: "
+printf %s "libtirpc support: "
 check_tirpc
 
-echo -n "libbpf support: "
+printf %s "libbpf support: "
 check_libbpf
 
-echo -n "ELF support: "
+printf %s "ELF support: "
 check_elf
 
-echo -n "libmnl support: "
+printf %s "libmnl support: "
 check_mnl
 
-echo -n "Berkeley DB: "
+printf %s "Berkeley DB: "
 check_berkeley_db
 
-echo -n "need for strlcpy: "
+printf %s "need for strlcpy: "
 check_strlcpy
 
-echo -n "libcap support: "
+printf %s "libcap support: "
 check_cap
 
-echo -n "color output: "
+printf %s "color output: "
 check_color
 
-echo >> $CONFIG
-echo "%.o: %.c" >> $CONFIG
-echo '	$(QUIET_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<' >> $CONFIG
+{
+	printf '\n'
+	printf '%s\n' "%.o: %.c"
+	printf '%s\n' '	$(QUIET_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<'
+} >> $CONFIG
-- 
2.41.0


