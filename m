Return-Path: <netdev+bounces-38259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E37B9DAC
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 59C8B28289C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11A26E28;
	Thu,  5 Oct 2023 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ8wdB+d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A43266DA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:53:45 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C981BC9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:53:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3248ac76acbso919840f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696514022; x=1697118822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xQAuG+IY5dvbzqhYj9yeiW4CIdcYaEt0ySD3qnwx8E=;
        b=iZ8wdB+dJ8RZ0zF16sDChbyRWfODR1fUxC3gkqfly+qfPhtbj8Inwmqyr0pBYQXAoK
         ZKinpQuEKf/nGsYIVFFqvEAdi3I85K8aDDJhIyaiU9Owo3BK4+bCp2C260vbrbUPT3Z8
         kKQjQnuxHaVxIHkUhU6ht9jg+k76zi5G+b8Ell+r+dG1dBRqiuU1UiQ6B49EpuYf3ugc
         FYQfhC8urjCg10ULGzbSGrsaA3tGLJY08rsd93iP0vgpqaJi6eZXd88RvtoPaGZAjg/h
         STtWucOmbVEDayRZmbnvHu4pT6m+iphPNPBsa0cs/KcUWaK43MywD2vmxT8aFkQNJg6Y
         lBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514022; x=1697118822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xQAuG+IY5dvbzqhYj9yeiW4CIdcYaEt0ySD3qnwx8E=;
        b=LInD5t/v4pZZgJIYWGwSJkPD2xb8WYwJNotsYVgF0b8FdqWuF7gLC4BeWtkuSEkt6F
         whbK8i+XKytvnUBDiQz5JEDmyTSeKyrTnUTnu8MUlVnl8L6SibJJxKvsKN4PXW32TXlo
         rddLa7mxc9g66xp/+qn7ePMNWGSBz5HGtBDpKZWjPmebhRGZ94cs8B2G07l5eLM/3WA/
         w6KOOX/2gDI3elQv6yFhpWTy1OeS+J6u+DNiksMAnnXTxsX/0vif6MZsp9gy6l0vbgZ5
         6BXBRpdiCMj+sIfg3Dgx3gefF0x29QqyZhJtYCAxLKF8/FTbUEhVvmhacrJX5VR7Covc
         RWww==
X-Gm-Message-State: AOJu0Yyl+4Kr8Ee7p+jcuofYUjWsIg7q4uE0NPntRSqe7Me+ludWwFHT
	7pe0wpFWqerK7waot3zGpLopJ5mlQVld7Q==
X-Google-Smtp-Source: AGHT+IGeq3pz8EKi1wZ/d5euS2mOfiaUQc3d4girD4IsYtN82boB7IcWhlKP6l8md5jO56gsY3jAXg==
X-Received: by 2002:a5d:6a8e:0:b0:323:36f1:c256 with SMTP id s14-20020a5d6a8e000000b0032336f1c256mr4808820wru.11.1696514022410;
        Thu, 05 Oct 2023 06:53:42 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00327df8fcbd9sm1867041wrx.9.2023.10.05.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:53:42 -0700 (PDT)
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
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v4 6/6] ptp: add testptp mask test
Date: Thu,  5 Oct 2023 15:53:16 +0200
Message-Id: <85bfc30fb60bc4e1d98fd8ea7f694c66172e9d5d.1696511486.git.reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696511486.git.reibax@gmail.com>
References: <cover.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
v2:
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
2.34.1


