Return-Path: <netdev+bounces-38928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078337BD109
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6571C20B61
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55589347A1;
	Sun,  8 Oct 2023 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWDpc/uF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A74341AF
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 22:49:43 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1FECA
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:49:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso39156605e9.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696805380; x=1697410180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udUJrXKMN6awb+8Gzc1UqEAcMJV7VS83x6Mg+K4d1jA=;
        b=AWDpc/uFSAy5bHIRNo0kTN2pNhgGIGQcDLAGUVnE0mXkQYVJWLL1I88amiC64bbqL0
         NL/y9UC81A7AKTbV/JGqCbEw7liKUQRL/atW9t2NVUX60UODz9mIusXdg1i2z96BbiUQ
         GkCV4kujHOulcraq0EunJHOASib4fyDR87VakCK9W+CzlGveCBnDui6msxdDNKi5Eutp
         GvNAk+5OTSIZIPPBYjyBMJOG6K7V4pcQT9MZbfbAD/YIX6lgusUiNHhLn98QaKgbQRyz
         dUpGOstxe7UKKhgUciRUH0poO+31REAqKWzsao+rqWg5hSPFgEFaqrU2Fv3bPFIihtc9
         mdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805380; x=1697410180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udUJrXKMN6awb+8Gzc1UqEAcMJV7VS83x6Mg+K4d1jA=;
        b=gv1bkstaWKxk/y3oO0mZdAOFEDCooUaZTOUOGYGjY55UciSI4akSaG+Re5sHsS6Iri
         t2OgP46WE3h02RrDKVrEue600EIE0pxvnkJAK/V1ZrcF1QK/uT6QAv75vg0tQvjnsE7L
         BZuU2pYkGDhuZs4fwJc6aGLN7fVk2XO2hvNpROxoFF+PtQ1SMVfoOw5K4bFFBqbpzsIN
         ykZ8NHtZOVZmpXsURi7IfLv0UkrMRKuYU9b10hBhex8CxqKUx+T/WDGdoFYBLcOrj6BQ
         mhoC9iI6P4odrROyCNXBt9rCK5VTz9eHCEEg5v8fqQtonamwJHwT2ofkzzak31vwODck
         9knQ==
X-Gm-Message-State: AOJu0YyvvSiIbTin0gCNvEeFyp5u0G6ddRazBNPucD8r6Bk9Oai8ShoW
	XBz1Ipn0WHdpl8R9a1gFyiV6FuEzmj5mRw==
X-Google-Smtp-Source: AGHT+IE7ZYCsZP0d11dRnWftpWvNFGXshA5vn5NsvaxowFpdC21oLG9BhPDeU915doV+KJmjLmw/JA==
X-Received: by 2002:a7b:cd8e:0:b0:405:3a3d:6f53 with SMTP id y14-20020a7bcd8e000000b004053a3d6f53mr11874647wmj.3.1696805379692;
        Sun, 08 Oct 2023 15:49:39 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm11804891wmg.40.2023.10.08.15.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:49:39 -0700 (PDT)
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
	shuah@kernel.org
Subject: [PATCH net-next v5 6/6] ptp: add testptp mask test
Date: Mon,  9 Oct 2023 00:49:21 +0200
Message-Id: <3056b7800f0dae65a2128b09b5c8d6142fd8df11.1696804243.git.reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1696804243.git.reibax@gmail.com>
References: <cover.1696804243.git.reibax@gmail.com>
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


