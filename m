Return-Path: <netdev+bounces-60529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4A81FD29
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 07:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7C21F21F86
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9BC1FC9;
	Fri, 29 Dec 2023 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABsdOyn4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2C20FC
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc14c9d364so746724a34.0
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703829617; x=1704434417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkYxjG1FKeVgpTMCMNuZAHgN5eO/TALMDbDMrZWFcPY=;
        b=ABsdOyn45UVE3LR5uXzTXTEH5K5zWAsw0lO8g8sy/pwhUT6UPdXfWq++SbUUv5+qC2
         gKjKfAf0uVKFrUrniUU7ig0nXJ+tWE01P3n16GuZmE157razmHNZJi1nsdrnZL8L1Va/
         Gxy0mqNVPl8Wumw0PPym5/1wThWS5M8Ezw+qFiWjSGs9gWCtwwjJ6stS5BOYCv7Z+wJa
         4nbqCR8QPwJYmY+xYVXPZY+aq6PPQDkaPigAaOF6JwbJxmDMNEirRtoY0DCqco24jCFa
         mdx+Z+h/6do7Bs8WYCJOvvaQrY4AZkG5NnD1znSWkOuZhkXe9gjwlncV8ihHEZ/+sme5
         GAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703829617; x=1704434417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkYxjG1FKeVgpTMCMNuZAHgN5eO/TALMDbDMrZWFcPY=;
        b=W/A8EkKBAWJprwqb7JhSn81NuCYfIgjbqxXHKsmRg1HC3XhRkDE3YPpW6onhoThHuH
         DBLLVoaKdk9jFg02u0FnC9sPFvk0hk6yNHqrSLgNM28KxUjOZkR/HFKXvUds0iLpUGRt
         8bMq/u8QmclV2Gy1DthmYU5uRgEPKwchZO4+A7QC0SBNe7JF10n4W1sCy3CP0XHvdi/T
         VR0Cra4uqO4hHkyN2XqOCQVMyip7hh/M6kU/kdtiQ1+UaaPBQCV33rNqji05yJDIgruC
         +gX2kMcLVrGsmdGW01BcJ4wJ6OLjavna4/43rQY5ijJSdPDdEFCwNRG9rWIZrhbmvjtE
         wxrA==
X-Gm-Message-State: AOJu0Yyi0UlaGRtuPzaNu2GQR+mRaNGJJMLaMVbE6OY6IBygsNp+UwpT
	XoJ9C9JSZ5sJIY27c2dnyA6wySsttIE=
X-Google-Smtp-Source: AGHT+IEZXFtv5hDW7UB2KjNuAZB9oWuo4or3tHdAgRQGBGc2mX794W9Mm8cHdpIFKnGOiVxF1JPPPg==
X-Received: by 2002:a05:6830:11c4:b0:6dc:2ab:ca9c with SMTP id v4-20020a05683011c400b006dc02abca9cmr2653429otq.21.1703829616645;
        Thu, 28 Dec 2023 22:00:16 -0800 (PST)
Received: from acleverhostname.attlocal.net (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d6385000000b006dc0363d57csm769602otk.6.2023.12.28.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 22:00:15 -0800 (PST)
From: Eli Schwartz <eschwartz93@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org
Subject: [PATCH 2/2] configure: use the portable printf to suppress newlines in messages
Date: Fri, 29 Dec 2023 01:00:10 -0500
Message-ID: <20231229060013.2375774-2-eschwartz93@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229060013.2375774-1-eschwartz93@gmail.com>
References: <20231227164645.765f7891@hermes.local>
 <20231229060013.2375774-1-eschwartz93@gmail.com>
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

See: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
See: https://cfajohnson.com/shell/cus-faq.html#Q0b
Signed-off-by: Eli Schwartz <eschwartz93@gmail.com>
---
 configure | 215 +++++++++++++++++++++++++++---------------------------
 1 file changed, 109 insertions(+), 106 deletions(-)

diff --git a/configure b/configure
index 158e76e1..a2753f43 100755
--- a/configure
+++ b/configure
@@ -20,16 +20,18 @@ check_toolchain()
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
 
 check_xtables()
 {
 	if ! ${PKG_CONFIG} xtables --exists; then
-		echo "TC_CONFIG_NO_XT:=y" >>$CONFIG
+		printf '%s\n' "TC_CONFIG_NO_XT:=y" >>$CONFIG
 	fi
 }
 
@@ -57,8 +59,8 @@ EOF
 
     if $CC -I$INCLUDE $IPTC -o $TMPDIR/ipttest $TMPDIR/ipttest.c $IPTL \
 	$(${PKG_CONFIG} xtables --cflags --libs) -ldl >/dev/null 2>&1; then
-	echo "TC_CONFIG_XT:=y" >>$CONFIG
-	echo "using xtables"
+	printf '%s\n' "TC_CONFIG_XT:=y" >>$CONFIG
+	printf '%s\n' "using xtables"
     fi
     rm -f $TMPDIR/ipttest.c $TMPDIR/ipttest
 }
@@ -91,8 +93,8 @@ int main(int argc, char **argv) {
 EOF
 
     if $CC -I$INCLUDE $IPTC -o $TMPDIR/ipttest $TMPDIR/ipttest.c $IPTL -ldl >/dev/null 2>&1; then
-	echo "TC_CONFIG_XT_OLD:=y" >>$CONFIG
-	echo "using old xtables (no need for xt-internal.h)"
+	printf '%s\n' "TC_CONFIG_XT_OLD:=y" >>$CONFIG
+	printf '%s\n' "using old xtables (no need for xt-internal.h)"
     fi
     rm -f $TMPDIR/ipttest.c $TMPDIR/ipttest
 }
@@ -125,25 +127,24 @@ int main(int argc, char **argv) {
 
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
 
@@ -151,8 +152,8 @@ check_ipt_lib_dir()
 {
 	IPT_LIB_DIR=$(${PKG_CONFIG} --variable=xtlibdir xtables)
 	if [ -n "$IPT_LIB_DIR" ]; then
-		echo $IPT_LIB_DIR
-		echo "IPT_LIB_DIR:=$IPT_LIB_DIR" >> $CONFIG
+		printf '%s\n' "$IPT_LIB_DIR"
+		printf '%s\n' "IPT_LIB_DIR:=$IPT_LIB_DIR" >> $CONFIG
 		return
 	fi
 
@@ -160,13 +161,13 @@ check_ipt_lib_dir()
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
@@ -181,11 +182,11 @@ int main(int argc, char **argv)
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
@@ -206,10 +207,10 @@ int main(int argc, char **argv)
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
@@ -236,10 +237,10 @@ int main(void)
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
@@ -247,13 +248,13 @@ EOF
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
 
@@ -300,7 +301,7 @@ check_force_libbpf_on()
     # if set LIBBPF_FORCE=on but no libbpf support, just exist the config
     # process to make sure we don't build without libbpf.
     if [ "$LIBBPF_FORCE" = on ]; then
-        echo "	LIBBPF_FORCE=on set, but couldn't find a usable libbpf"
+        printf '%s\n' "	LIBBPF_FORCE=on set, but couldn't find a usable libbpf"
         exit 1
     fi
 }
@@ -309,12 +310,12 @@ check_libbpf()
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
@@ -336,69 +337,69 @@ check_libbpf()
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
 
@@ -414,10 +415,10 @@ int main(int argc, char **argv) {
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
@@ -433,15 +434,15 @@ int main(int argc, char **argv) {
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
@@ -450,13 +451,13 @@ EOF
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
 
@@ -464,16 +465,16 @@ check_color()
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
@@ -525,7 +526,7 @@ EOF
 }
 
 # Compat with the old INCLUDE path setting method.
-if [ $# -eq 1 ] && [ "$(echo $1 | cut -c 1)" != '-' ]; then
+if [ $# -eq 1 ] && [ "$(printf %s "$1" | cut -c 1)" != '-' ]; then
 	INCLUDE="$1"
 else
 	while [ "$#" -gt 0 ]; do
@@ -589,65 +590,67 @@ fi
 [ -z "$PREFIX" ] && usage 1
 [ -z "$LIBDIR" ] && usage 1
 
-echo "# Generated config based on" $INCLUDE >$CONFIG
+printf '%s\n' "# Generated config based on $INCLUDE" >$CONFIG
 quiet_config >> $CONFIG
 
 check_toolchain
 
-echo "TC schedulers"
+printf '%s\n' "TC schedulers"
 
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


