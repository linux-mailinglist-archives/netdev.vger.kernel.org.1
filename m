Return-Path: <netdev+bounces-59951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF37481CD8F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E442A1C2130C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9BD2554E;
	Fri, 22 Dec 2023 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sLojr7lN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723728DB9
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-204520717b3so303048fac.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703266169; x=1703870969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yK8w4D9q9h+4zcpBo7jGy1OpU0oyfdJVEALOxCqfbJA=;
        b=sLojr7lN3yQK9RV8KpLSiHV+ke+0zJiObXZnI5AqNWsAV7VuUz/NrTPSy21GQXsiVs
         OZ+BDX5XRYVPX8EfZ/Koq3iH1JsiR5QXBBO7kKmjWEQo62AWazX04OQ05GhPGEmy4Xih
         4vY8zztOR9+GnnheYyBrPVh776CODm5luXkpUWxJJOIzCHCE5TYI4HdOpOHc7W5FQhWn
         LE0je5ut5tYWloKYlMC2YzgqvOWqYpHVTjAofRrHjOhVGnXNXImDzcqVeKp7RKtQf1YL
         M7hlN2jzEEoCxqQxA2cjaUq2rdDzrKK0o1v0UvEqX3GCTWUroQX41AZgc1+Cx2p1MzRP
         kt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266169; x=1703870969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yK8w4D9q9h+4zcpBo7jGy1OpU0oyfdJVEALOxCqfbJA=;
        b=OypoqlVLiMmV5+nu5sz4trWZEw7SFBf5fPH3rVIl/68aursOMifoIIPhqdJ5/2Wpx5
         kBs1C1dBRsLiHwUPf+/PPfEuBstWhD09I+JoeIX67xkelzEgd5opiiaNYLf9+zTEfsjd
         ZpamjfUNBJLElkEV6pWIewdAr7DgWb+dI+S728KPdrWYvYABAnpzs++yeeUu1zf9B+QS
         vh6vwCWR8kDJxWTs8SrwDWZaDrEnljw3e0m0s7ZObMnOpNJZMoNopgx8IBq6GHT8ALcX
         MymZaDGWt4NX8B7ezKabcFJX+2kl3fWTfX+NEfa1uXibmyOs2mX1nBrYknWEkdZuInYJ
         Eemg==
X-Gm-Message-State: AOJu0YxsZBNBuXoLuS4A9/vpJiTw2cFkgXbuV2lrhrkA4sFQfijUW3Q1
	qgXO8+A5R2hV2KJr0S211wjhWP7ae246bG5p6CSC8z/7MzW2GQ==
X-Google-Smtp-Source: AGHT+IHcBQPSeFOQykFyy/FvQtCW9YSQjA7w87VHTcDNnysE7vlanFRsNKfyZdy0tse8aCJJVCIPjQ==
X-Received: by 2002:a05:6870:3283:b0:203:f0b0:8f60 with SMTP id q3-20020a056870328300b00203f0b08f60mr1985114oac.2.1703266169176;
        Fri, 22 Dec 2023 09:29:29 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j6-20020a632306000000b005c621e0de25sm3819346pgj.71.2023.12.22.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:29:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] configure: drop test for ATM
Date: Fri, 22 Dec 2023 09:29:06 -0800
Message-ID: <20231222172919.12610-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ATM qdisc was removed by:
commit 8a20feb6388f ("tc: drop support for ATM qdisc")
but configure check was not removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 configure | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/configure b/configure
index eb689341d17d..488c5f880962 100755
--- a/configure
+++ b/configure
@@ -26,26 +26,6 @@ check_toolchain()
     echo "YACC:=${YACC}" >>$CONFIG
 }
 
-check_atm()
-{
-    cat >$TMPDIR/atmtest.c <<EOF
-#include <atm.h>
-int main(int argc, char **argv) {
-	struct atm_qos qos;
-	(void) text2qos("aal5,ubr:sdu=9180,rx:none",&qos,0);
-	return 0;
-}
-EOF
-
-    if $CC -I$INCLUDE -o $TMPDIR/atmtest $TMPDIR/atmtest.c -latm >/dev/null 2>&1; then
-	echo "TC_CONFIG_ATM:=y" >>$CONFIG
-	echo yes
-    else
-	echo no
-    fi
-    rm -f $TMPDIR/atmtest.c $TMPDIR/atmtest
-}
-
 check_xtables()
 {
 	if ! ${PKG_CONFIG} xtables --exists; then
@@ -616,9 +596,6 @@ check_toolchain
 
 echo "TC schedulers"
 
-echo -n " ATM	"
-check_atm
-
 check_xtables
 if ! grep -q TC_CONFIG_NO_XT $CONFIG; then
 	echo -n " IPT	"
-- 
2.43.0


