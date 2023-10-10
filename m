Return-Path: <netdev+bounces-39582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD257BFF83
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7481C20BAC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632B1DFC5;
	Tue, 10 Oct 2023 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FCQfx9sU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B21428E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:44:07 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF34B6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:44:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1033085966b.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696949042; x=1697553842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8j7Zr/R9tLiQtURg5XOgTT0C5ad2/qZUZc6ItwXYFHY=;
        b=FCQfx9sUJb54h4CKYTgdTbuBS0kA6nuLypTWtLqx9Wy+CXjm4LGBaP/2T2GN2+uhcA
         cIRUssD2RTsuWPNeEdI1Hj/IXlmpu5ZI/uxO23kjsccxiDbfFicO/5gNK0KVE806T5tF
         f1dD4L7P8N9zk4aI1HjLMWTyuIO9VHdEYzziQ3kJDZ3iyUKAKWN5/mHa25VlCEDIKRV4
         h3yl/8qS8s6uL9/H6ezVG3EvyrVZJgXJLaDU48vb1m117sGxWhUGirQ4x3ha7G4i81IV
         qXrHx8QvI+5/6zoUvdaRpUhA4x8di+ec8R3I43ZKn+nMUfYy67GNOCLG6a5+Tgu6eixo
         0DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949042; x=1697553842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j7Zr/R9tLiQtURg5XOgTT0C5ad2/qZUZc6ItwXYFHY=;
        b=HmwJRaY7u111/2jue3kL+ezZ8LwgQsABkcuuUXZUNkmfz584siTGd0KLzJRV5iX6x/
         zTwSa2LsshK5KcefmHA0rKEaWzS8E3r8/ThgAV9lSIUXgrs5bs5UGz4UO17sQmRxfCw6
         fe58l+obkelofaBUB5ZqoLbBUXpmcNUiylk4JE0fpAS0pbqCbGfa92DLRfbu/q0DsGoV
         TuHT4X1AXMtoMrMt7UnCTHUnDa2EMAnIprCUOqI0X3P+Xgp13PhjtDW9gEJeCT+k+xwU
         P4JOXrBFmbKq2YLhrIRcCixr99lCk+A6/Z/F7PQKNtr9Y+3nWJSRLRT+kScaPeTP/eYR
         fUeA==
X-Gm-Message-State: AOJu0Yz9PPWLzaiI3iazE7BLVtz6+mVyA4fPfFHk4rPUqojRfa6TtTyn
	WIeA26BHBcCntKa3W0dv5FtX7lj2gKC2OFKTNu4=
X-Google-Smtp-Source: AGHT+IFTNQ2fnNorUyp5clsnNygUQyxd0TyIcQb4r+pDJCjJSVzNOWBKpOkGnnY+cQYIZv4ugNcfQA==
X-Received: by 2002:a17:906:154:b0:9a9:f2fd:2a2b with SMTP id 20-20020a170906015400b009a9f2fd2a2bmr14156360ejh.73.1696949042619;
        Tue, 10 Oct 2023 07:44:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709066d0e00b00991d54db2acsm8511033ejr.44.2023.10.10.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:44:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	shuah@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org
Subject: [patch net-next] selftests: netdevsim: use suitable existing dummy file for flash test
Date: Tue, 10 Oct 2023 16:44:00 +0200
Message-ID: <20231010144400.211191-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

The file name used in flash test was "dummy" because at the time test
was written, drivers were responsible for file request and as netdevsim
didn't do that, name was unused. However, the file load request is
now done in devlink code and therefore the file has to exist.
Use first random file from /lib/firmware for this purpose.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 7f7d20f22207..46e20b13473c 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -31,36 +31,43 @@ devlink_wait()
 
 fw_flash_test()
 {
+	DUMMYFILE=$(find /lib/firmware -maxdepth 1 -type f  -printf '%f\n' |head -1)
 	RET=0
 
-	devlink dev flash $DL_HANDLE file dummy
+	if [ -z "$DUMMYFILE" ]
+	then
+		echo "SKIP: unable to find suitable dummy firmware file"
+		return
+	fi
+
+	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates on"
 
-	devlink dev flash $DL_HANDLE file dummy component fw.mgmt
+	devlink dev flash $DL_HANDLE file $DUMMYFILE component fw.mgmt
 	check_err $? "Failed to flash with component attribute"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite settings
 	check_fail $? "Flash with overwrite settings should be rejected"
 
 	echo "1"> $DEBUGFS_DIR/fw_update_overwrite_mask
 	check_err $? "Failed to change allowed overwrite mask"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite settings
 	check_err $? "Failed to flash with settings overwrite enabled"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite identifiers
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite identifiers
 	check_fail $? "Flash with overwrite settings should be identifiers"
 
 	echo "3"> $DEBUGFS_DIR/fw_update_overwrite_mask
 	check_err $? "Failed to change allowed overwrite mask"
 
-	devlink dev flash $DL_HANDLE file dummy overwrite identifiers overwrite settings
+	devlink dev flash $DL_HANDLE file $DUMMYFILE overwrite identifiers overwrite settings
 	check_err $? "Failed to flash with settings and identifiers overwrite enabled"
 
 	echo "n"> $DEBUGFS_DIR/fw_update_status
 	check_err $? "Failed to disable status updates"
 
-	devlink dev flash $DL_HANDLE file dummy
+	devlink dev flash $DL_HANDLE file $DUMMYFILE
 	check_err $? "Failed to flash with status updates off"
 
 	log_test "fw flash test"
-- 
2.41.0


