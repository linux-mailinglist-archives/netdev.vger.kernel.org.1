Return-Path: <netdev+bounces-60528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7376781FD28
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 07:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20D2281B59
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766620FE;
	Fri, 29 Dec 2023 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ+iUp1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA120E1
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-20503dc09adso572927fac.2
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703829615; x=1704434415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0FpBXKsD3w5W/h9+4rsi0kZLhofRVZj8qKaJUQDu0w=;
        b=YQ+iUp1g71K1tOOzWISQiaeDCxFS9VJtrLpVQlrGIMVdKSug6PCDqj4zlJD8oX9FM/
         c0tOZR6xIs9JpZDqXghUFsxHvrekkXzOO1JY4IZ1AQ6ibpQzsjZNzn/C8McWyGe13scR
         jDMT5kKvxw4mSAoM2SXVywt5L27/jvJQBjnjrbA9VAkb3ImihQ7rBofEDZpWOlknOKTY
         p4Xw/Tx+CG4/WZ778xsomWv9h95xTapDNlki2/76Kk3TY/JOUnZ8d23c8bOmsCHbyDA2
         TwkyHCzFZXs6yjcs86522uXeT9LzKwPeQ22xjZSWpe32mURMq1XwQC+k5lrIhdfMO2Eb
         X4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703829615; x=1704434415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0FpBXKsD3w5W/h9+4rsi0kZLhofRVZj8qKaJUQDu0w=;
        b=LeVzKsNTTAHvohvRXU8Qbskf7VBOWl4eNe40eHYoBMK+Mz5Z8oeVoYTygG5NkOirCO
         Ssmr9XeDSxm4GjYlsUCyqxxA7wXK47trFnxPU83Yr10WziLPJHIeK8N8B7GyX3mrxqP2
         xqc5XS8DCLX1XpeY2tzKsb6AIdDVJA9i6tlRjkEs1TtDosyjAowWWQBPSpwea1u4i1uy
         K4VSIiXkeOda2hAJcx0p9D+M+eZcJVIW5YLVkLfkanDQrbUhqQEY16t81yKIu1woNeAB
         7DFiQH0AlkKh59oHMafMW7z25rZw+59vkYPjswcCMN/kxnSK58PY4PNOFAiDZkblndEQ
         FaSQ==
X-Gm-Message-State: AOJu0YzB4/E+VfmYYRhTY1xSQ+JKLroK6hKlpHumox/a56KV14gtP5Wl
	4D8F5DhJvIsbU6A2sCCmuWetQZocahw=
X-Google-Smtp-Source: AGHT+IEZNyIekOxgTaNTEty7aEko4wU5AYrDWycfF3Gv4mIzjy3OsloJbLzJXKOw1in9eFIhflZx/w==
X-Received: by 2002:a05:6870:8dc8:b0:204:45d7:2e86 with SMTP id lq8-20020a0568708dc800b0020445d72e86mr15277729oab.110.1703829614973;
        Thu, 28 Dec 2023 22:00:14 -0800 (PST)
Received: from acleverhostname.attlocal.net (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d6385000000b006dc0363d57csm769602otk.6.2023.12.28.22.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 22:00:14 -0800 (PST)
From: Eli Schwartz <eschwartz93@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org
Subject: [PATCH 1/2] configure: avoid un-recommended command substitution form
Date: Fri, 29 Dec 2023 01:00:09 -0500
Message-ID: <20231229060013.2375774-1-eschwartz93@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227164645.765f7891@hermes.local>
References: <20231227164645.765f7891@hermes.local>
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
Signed-off-by: Eli Schwartz <eschwartz93@gmail.com>
---
 configure | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 488c5f88..158e76e1 100755
--- a/configure
+++ b/configure
@@ -250,8 +250,8 @@ check_elf()
 	echo "HAVE_ELF:=y" >>$CONFIG
 	echo "yes"
 
-	echo 'CFLAGS += -DHAVE_ELF' `${PKG_CONFIG} libelf --cflags` >> $CONFIG
-	echo 'LDLIBS += ' `${PKG_CONFIG} libelf --libs` >>$CONFIG
+	echo 'CFLAGS += -DHAVE_ELF' "$(${PKG_CONFIG} libelf --cflags)" >> $CONFIG
+	echo 'LDLIBS += ' "$(${PKG_CONFIG} libelf --libs)" >>$CONFIG
     else
 	echo "no"
     fi
@@ -369,8 +369,8 @@ check_selinux()
 		echo "HAVE_SELINUX:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'LDLIBS +=' `${PKG_CONFIG} --libs libselinux` >>$CONFIG
-		echo 'CFLAGS += -DHAVE_SELINUX' `${PKG_CONFIG} --cflags libselinux` >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libselinux)" >>$CONFIG
+		echo 'CFLAGS += -DHAVE_SELINUX' "$(${PKG_CONFIG} --cflags libselinux)" >>$CONFIG
 	else
 		echo "no"
 	fi
@@ -382,8 +382,8 @@ check_tirpc()
 		echo "HAVE_RPC:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'LDLIBS +=' `${PKG_CONFIG} --libs libtirpc` >>$CONFIG
-		echo 'CFLAGS += -DHAVE_RPC' `${PKG_CONFIG} --cflags libtirpc` >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} --libs libtirpc)" >>$CONFIG
+		echo 'CFLAGS += -DHAVE_RPC' "$(${PKG_CONFIG} --cflags libtirpc)" >>$CONFIG
 	else
 		echo "no"
 	fi
@@ -395,8 +395,8 @@ check_mnl()
 		echo "HAVE_MNL:=y" >>$CONFIG
 		echo "yes"
 
-		echo 'CFLAGS += -DHAVE_LIBMNL' `${PKG_CONFIG} libmnl --cflags` >>$CONFIG
-		echo 'LDLIBS +=' `${PKG_CONFIG} libmnl --libs` >> $CONFIG
+		echo 'CFLAGS += -DHAVE_LIBMNL' "$(${PKG_CONFIG} libmnl --cflags)" >>$CONFIG
+		echo 'LDLIBS +=' "$(${PKG_CONFIG} libmnl --libs)" >> $CONFIG
 	else
 		echo "no"
 	fi
@@ -436,8 +436,8 @@ EOF
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
@@ -453,8 +453,8 @@ check_cap()
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


