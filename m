Return-Path: <netdev+bounces-40172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC57C6075
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8786F1C20973
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837512E74;
	Wed, 11 Oct 2023 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpDJ6cBE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65837D50B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:40:19 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4FCB8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405497850dbso4290745e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064015; x=1697668815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udUJrXKMN6awb+8Gzc1UqEAcMJV7VS83x6Mg+K4d1jA=;
        b=mpDJ6cBE2G+PdkDC4xphEUGSalsKge+vy+nde5d2IZO7Ll04mtys0I/TQIfTNLvkOB
         ylpNVJPERCljZ6Bu6xlzLulxxi7BGu5D3rVK6Hfe1oBm57XPtXO+R19Uly5SRwSQeQti
         //ocKxIpLgCaDugvIDj87VavF5AX4yFuXYag2TsHrTAfS9qPMCcxpoJ8TgeeNwi9inRp
         +WBLn60V5xmmRHP7MB4p6uvlWK9ZDYPDReBA007sBWM/RyiowU9+mJGOauej2Y8gvJUA
         OZHuafAHFhII7iU5AY6uK0FgWIo98qUB1L1obnO/ROKi7KUQKeHdEdeIUEPmLxSSUxEs
         jIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064015; x=1697668815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udUJrXKMN6awb+8Gzc1UqEAcMJV7VS83x6Mg+K4d1jA=;
        b=SrXwAfUGUu1Mt71Xkc8cE8CizlGmsI/sXT5qiW/kUFkDkwyOetih4d/bvrz6It4JP9
         zc6gqRAgm3dV5t1OBXyNUv0itN4l+i/lftv30DZIfuNvvp47Z90AgBO3lEBkvpWdsuEe
         2XUUc+htfov5L6GEO6Ju0NqudSvQL9qQ86lxTG5+LXC7BWFfBdRlLDx2d17JEHBh6JnG
         /GuF5+JO1lcdNFVkgjjIDSI+GNiSjHApJLNWG+saJVfm7gBx8KW38mCUWglNT4DouWLm
         i79ProHINgTJeUXjmTumbC/0tTwhG0l6fkAd3RddcM3fahrLxB0renooqn7YqYVuSigr
         bYUQ==
X-Gm-Message-State: AOJu0YwNwrLUVx9tEJz2YIOfFfiPJVD+xe7Kwx6VGWcqENxbcJspmVI1
	/XDbpPvRtn1H11zn+2f54r6DYlwUWCnUQA==
X-Google-Smtp-Source: AGHT+IE0yPSwAuccZID52xR4JbETJAy6p9PBBnL+QhGMoj81+X3uSaHaSte/uBKMFE5e8nFiGq1NBg==
X-Received: by 2002:a05:600c:2054:b0:3fe:687a:abb8 with SMTP id p20-20020a05600c205400b003fe687aabb8mr19986033wmg.7.1697064015293;
        Wed, 11 Oct 2023 15:40:15 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b00405442edc69sm19964031wmr.14.2023.10.11.15.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:40:15 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	tglx@linutronix.de,
	jstultz@google.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	kuba@kernel.org
Subject: [PATCH net-next v6 6/6] ptp: add testptp mask test
Date: Thu, 12 Oct 2023 00:39:58 +0200
Message-Id: <68d1d50ded418863007959bdfa5fef405bd28d29.1697062274.git.reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1697062274.git.reibax@gmail.com>
References: <cover.1697062274.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add option to test timestamp event queue mask manipulation in testptp.

Option -F allows the user to specify a single channel that will be
applied on the mask filter via IOCTL.

The test program will maintain the file open until user input is
received.

This allows checking the effect of the IOCTL in debugfs.

eg:

Console 1:
```
Channel 12 exclusively enabled. Check on debugfs.
Press any key to continue
```

Console 2:
```
0x00000000 0x00000001 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
0x00000000 0x00000000 0x00000000 0x00000000
```

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v2: https://lore.kernel.org/netdev/85bfc30fb60bc4e1d98fd8ea7f694c66172e9d5d.1696511486.git.reibax@gmail.com/
  - split from previous patch that combined more changes
  - make more secure and simple: mask is only applied to the testptp
    instance. Use debugfs to verify effects.
v1: https://lore.kernel.org/netdev/20230928133544.3642650-4-reibax@gmail.com/
---
 tools/testing/selftests/ptp/testptp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c9f6cca4feb4..011252fe238c 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -121,6 +121,7 @@ static void usage(char *progname)
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
 		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
+		" -F chan    Enable single channel mask and keep device open for debugfs verification.\n"
 		" -g         get the ptp clock time\n"
 		" -h         prints this message\n"
 		" -i val     index for event/trigger\n"
@@ -187,6 +188,7 @@ int main(int argc, char *argv[])
 	int pps = -1;
 	int seconds = 0;
 	int settime = 0;
+	int channel = -1;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -196,7 +198,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -210,6 +212,9 @@ int main(int argc, char *argv[])
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
+		case 'F':
+			channel = atoi(optarg);
+			break;
 		case 'g':
 			gettime = 1;
 			break;
@@ -604,6 +609,18 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (channel >= 0) {
+		if (ioctl(fd, PTP_MASK_CLEAR_ALL)) {
+			perror("PTP_MASK_CLEAR_ALL");
+		} else if (ioctl(fd, PTP_MASK_EN_SINGLE, (unsigned int *)&channel)) {
+			perror("PTP_MASK_EN_SINGLE");
+		} else {
+			printf("Channel %d exclusively enabled. Check on debugfs.\n", channel);
+			printf("Press any key to continue\n.");
+			getchar();
+		}
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.30.2


