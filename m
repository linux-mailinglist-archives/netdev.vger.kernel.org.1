Return-Path: <netdev+bounces-58425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9781655D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 04:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B1E1F218A3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 03:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE06D2109;
	Mon, 18 Dec 2023 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpWUNTKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221863A3
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77f50307a1fso240565385a.3
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 19:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702870261; x=1703475061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFrAKCAiKFfHo96CvIQLvO0xldHM21llhte03Wt9/VM=;
        b=JpWUNTKe9UhJrOHHxn744frxzKi/ssOrCCF/j7lGfi8y/NBsY3IhfDpOO7e06J3iik
         xKvtye4E/EoKzQAV/u4ay7TmkmwWl8v3Mvt7ts/TdxwRRZKhLVj9E7bXivuJl8W2y6hF
         2zW1TmxcRqgOhkgYB7lhKeUIj2NnbHEZaLuEmGtMjGnwBLoMj+anNelyUxj1ex+rz+BG
         8pYbis5BkLoLLNAtndB4Kn9thzRiiUHr7n/QMvEWOsvAZ0LRYAZY/uTFGioibzbUseFo
         0Qf7ro+PYWLuY4z+/8XrLCjpznBXqyoqTsgr32skOyUhyZ+lPKjQ08YTUzzKyenK+DYo
         t2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702870261; x=1703475061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFrAKCAiKFfHo96CvIQLvO0xldHM21llhte03Wt9/VM=;
        b=p7RVKbtwCLPfIVAZnMzHrknmFHGYOsM+hGcTxRf57KiqRUPLiwBUIjYVV1VzeJ341x
         7ahi/Ve8CObe9bsz6C4zqQ3OAwacmlBDBlfzwHPq8uWo/CWPrKxqMbWKa9OEpr05ARMS
         cOLiRqYVcT4sZw6bDmhJ9qFSlmeFmQ/qLliIKDBX+MdIr4ZhNxN3wDLvrap70PEjCysH
         f3LpexHXkBWBgliXCnAJREHUwFKDeM+QwodX/n8OE0FthEQED9fQkB2Er65iU/yR9NNY
         4cgqUAyTwNyFzbxQjd3nMHELbrpGgMBZEsFao+3m+YjQd0ELaWEDmOzEP9w8uRRG0a4L
         0G2Q==
X-Gm-Message-State: AOJu0YxF5iVlhH5Pb1vOE7cztdUXDEAtpIbNPZryLR/TiWLOynDDlBa2
	2tchMGUgQsHccChcn6Li8L/ub2UzogM=
X-Google-Smtp-Source: AGHT+IGxtNiKkrTwsW3Lx/3awPMlMm+g9k+i3ppJpj0dher7Elu0COu+qpGpS0q7ZlBtoNOvwnREHQ==
X-Received: by 2002:a05:620a:11a6:b0:780:dde7:43d7 with SMTP id c6-20020a05620a11a600b00780dde743d7mr2363486qkk.59.1702870261351;
        Sun, 17 Dec 2023 19:31:01 -0800 (PST)
Received: from acleverhostname.attlocal.net (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id y123-20020a253281000000b00dbd01cd9208sm2099897yby.52.2023.12.17.19.31.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:31:00 -0800 (PST)
From: Eli Schwartz <eschwartz93@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH iproute2 1/2] configure: avoid un-recommended command substitution form
Date: Sun, 17 Dec 2023 22:30:52 -0500
Message-ID: <20231218033056.629260-1-eschwartz93@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of backticks to surround commands instead of "$(cmd)" is a
legacy of the oldest pre-POSIX shells. It is confusing, unreliable, and
hard to read. Its use is not recommended in new programs.

See: http://mywiki.wooledge.org/BashFAQ/082
---
 configure | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index eb689341..19845f3c 100755
--- a/configure
+++ b/configure
@@ -270,8 +270,8 @@ check_elf()
 	echo "HAVE_ELF:=y" >>$CONFIG
 	echo "yes"
 
-	echo 'CFLAGS += -DHAVE_ELF' `${PKG_CONFIG} libelf --cflags` >> $CONFIG
-	echo 'LDLIBS += ' `${PKG_CONFIG} libelf --libs` >>$CONFIG
+	echo 'CFLAGS += -DHAVE_ELF' "$(${PKG_CONFIG} libelf --cflags)" >> $CONFIG
+	echo 'LDLIBS += ' "$(${PKG_CONFIG} libelf --libs)" >>$CONFIG
     else
 	echo "no"
     fi
@@ -389,8 +389,8 @@ check_selinux()
 		echo "HAVE_SELINUX:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'LDLIBS +=' `${PKG_CONFIG} --libs libselinux` >>$CONFIG
-		echo 'CFLAGS += -DHAVE_SELINUX' `${PKG_CONFIG} --cflags libselinux` >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libselinux)" >>$CONFIG
+		echo 'CFLAGS += -DHAVE_SELINUX' "$(${PKG_CONFIG} --cflags libselinux)" >>$CONFIG
 	else
 		echo "no"
 	fi
@@ -402,8 +402,8 @@ check_tirpc()
 		echo "HAVE_RPC:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'LDLIBS +=' `${PKG_CONFIG} --libs libtirpc` >>$CONFIG
-		echo 'CFLAGS += -DHAVE_RPC' `${PKG_CONFIG} --cflags libtirpc` >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libtirpc)" >>$CONFIG
+		echo 'CFLAGS += -DHAVE_RPC' "$(${PKG_CONFIG} --cflags libtirpc)" >>$CONFIG
 	else
 		echo "no"
 	fi
@@ -415,8 +415,8 @@ check_mnl()
 		echo "HAVE_MNL:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'CFLAGS += -DHAVE_LIBMNL' `${PKG_CONFIG} libmnl --cflags` >>$CONFIG
-		echo 'LDLIBS +=' `${PKG_CONFIG} libmnl --libs` >> $CONFIG
+		echo 'CFLAGS += -DHAVE_LIBMNL' "$(${PKG_CONFIG} libmnl --cflags)" >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} libmnl --libs)" >> $CONFIG
 	else
 		echo "no"
 	fi
@@ -456,8 +456,8 @@ EOF
 	echo "no"
     else
 	if ${PKG_CONFIG} libbsd --exists; then
-		echo 'CFLAGS += -DHAVE_LIBBSD' `${PKG_CONFIG} libbsd --cflags` >>$CONFIG
-		echo 'LDLIBS +=' `${PKG_CONFIG} libbsd --libs` >> $CONFIG
+		echo 'CFLAGS += -DHAVE_LIBBSD' "$(${PKG_CONFIG} libbsd --cflags)" >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} libbsd --libs)" >> $CONFIG
 		echo "no"
 	else
 		echo 'CFLAGS += -DNEED_STRLCPY' >>$CONFIG
@@ -473,8 +473,8 @@ check_cap()
 		echo "HAVE_CAP:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'CFLAGS += -DHAVE_LIBCAP' `${PKG_CONFIG} libcap --cflags` >>$CONFIG
-		echo 'LDLIBS +=' `${PKG_CONFIG} libcap --libs` >> $CONFIG
+		echo 'CFLAGS += -DHAVE_LIBCAP' "$(${PKG_CONFIG} libcap --cflags)" >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} libcap --libs)" >> $CONFIG
 	else
 		echo "no"
 	fi
-- 
2.41.0


