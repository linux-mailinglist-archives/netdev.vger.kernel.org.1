Return-Path: <netdev+bounces-41967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AEA7CC75D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856451F2329F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2744491;
	Tue, 17 Oct 2023 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KBn2cpfc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CB450C4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:23:28 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D13B6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso3127318b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697556207; x=1698161007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9CwzI+ACqRx84i2/bsXQF1NPIQ4DAJ5JBlM0qarbUg=;
        b=KBn2cpfcHQFp91LTY+h5cAERyCwQMM0h0E+TON8F2+uOXIqiKQOho/3T74Xc8Wbm6c
         6vnknOphauFIPnQq1Vj02I+PuQKaXeiJDgaAg0nrs8vRy7APrL9BlZ5ZjmSmInTMlQ4x
         Re5WEwTulMcRrgp2OLclPVG+Ow+47xBPy8YnRj1prsikvQd18zLiKYIf2yMzQyWPgccc
         AGFcs4vFYavpn7Ral6NRwyZO8W7kg5HWywA+29ZJkgxe0XUI9nBgd6DUgabW1Al6p/8B
         Tg7Y5CBOWtE6Q0atc/1E8VbAcw9nBRxtE/N2RZfy7VYaFkII2f8dnr9ciHl0OcjBHX9d
         fsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556207; x=1698161007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9CwzI+ACqRx84i2/bsXQF1NPIQ4DAJ5JBlM0qarbUg=;
        b=kY5FzVqI9KQniCyb66tDV0UaxAj32ZnxLsEOVYs3oGvw6bNmNWHR/dzm6WJM6W+RJa
         TaoiwVmtXFV1ovlcyejvc7wbFOogIjqUshu34efAojRIRjZCx8Linu4kFo63VQaNTjJO
         uySehOvT21gLlw88u408x+JrKh5ODt9ait1hE6LtgAdOhW3ivU0AnarB5uPf7X3R0MiG
         Bg0UeWalo4xH5gZIsTVE2MM8KgLoNxTMU0YmADM+wJX0SVYQDTLUXs3SFQEblY0RTWQy
         TObE8DcgWSokA33jGvdvQLi7xcBWvOb4V6xAEW7o9/Nc4i1BeRRuNwxOfxxosfkA+2V6
         h0XA==
X-Gm-Message-State: AOJu0YwUJ9kIpFL5URIMHNYNY1FRI0fzylQ18DdZ8uGT1QYtQRtOxtFN
	gRNASZYL4YUvYbGRLtl0honBoI5F9XfPtmhSsPXsbg==
X-Google-Smtp-Source: AGHT+IFMmK6Jm24nPUg9XntIiei7bIs+9IyaA1AIlkitgN5dTN8Jdgt+XzU/9p5fzWfuDJSjI3YZLg==
X-Received: by 2002:a05:6a21:617:b0:16b:f71d:1b82 with SMTP id ll23-20020a056a21061700b0016bf71d1b82mr2234521pzb.34.1697556206956;
        Tue, 17 Oct 2023 08:23:26 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:8ef5:7647:6178:de4e])
        by smtp.gmail.com with ESMTPSA id u191-20020a6385c8000000b005b6f075da0dsm8749pgd.25.2023.10.17.08.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:23:26 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 2/2] selftests: tc-testing: move auxiliary scripts to a dedicated folder
Date: Tue, 17 Oct 2023 12:23:09 -0300
Message-Id: <20231017152309.3196320-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017152309.3196320-1-pctammela@mojatatu.com>
References: <20231017152309.3196320-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some taprio tests need auxiliary scripts to wait for workqueue events to
process. Move them to a dedicated folder in order to package them for
the kselftests tarball.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/Makefile               | 2 +-
 .../tc-testing/{ => scripts}/taprio_wait_for_admin.sh     | 0
 .../selftests/tc-testing/tc-tests/qdiscs/taprio.json      | 8 ++++----
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/tc-testing/{ => scripts}/taprio_wait_for_admin.sh (100%)

diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
index 3c4b7fa05075..b1fa2e177e2f 100644
--- a/tools/testing/selftests/tc-testing/Makefile
+++ b/tools/testing/selftests/tc-testing/Makefile
@@ -28,4 +28,4 @@ $(OUTPUT)/%.o: %.c
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 
 TEST_PROGS += ./tdc.sh
-TEST_FILES := tdc*.py Tdc*.py plugins plugin-lib tc-tests
+TEST_FILES := tdc*.py Tdc*.py plugins plugin-lib tc-tests scripts
diff --git a/tools/testing/selftests/tc-testing/taprio_wait_for_admin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
similarity index 100%
rename from tools/testing/selftests/tc-testing/taprio_wait_for_admin.sh
rename to tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 0599635c4bc6..2d603ef2e375 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -170,11 +170,11 @@
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI",
-            "./taprio_wait_for_admin.sh $TC $ETH"
+            "./scripts/taprio_wait_for_admin.sh $TC $ETH"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $ETH parent 8001:7 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 200 sched-entry S ff 20000000 clockid CLOCK_TAI",
         "expExitCode": "2",
-        "verifyCmd": "bash -c \"./taprio_wait_for_admin.sh $TC $ETH && $TC -j qdisc show dev $ETH root | jq '.[].options.base_time'\"",
+        "verifyCmd": "bash -c \"./scripts/taprio_wait_for_admin.sh $TC $ETH && $TC -j qdisc show dev $ETH root | jq '.[].options.base_time'\"",
         "matchPattern": "0",
         "matchCount": "1",
         "teardown": [
@@ -195,11 +195,11 @@
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2",
-            "./taprio_wait_for_admin.sh $TC $ETH"
+            "./scripts/taprio_wait_for_admin.sh $TC $ETH"
         ],
         "cmdUnderTest": "$TC qdisc replace dev $ETH parent 8001:7 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 200 sched-entry S ff 20000000 flags 0x2",
         "expExitCode": "2",
-        "verifyCmd": "bash -c \"./taprio_wait_for_admin.sh $TC $ETH && $TC -j qdisc show dev $ETH root | jq '.[].options.base_time'\"",
+        "verifyCmd": "bash -c \"./scripts/taprio_wait_for_admin.sh $TC $ETH && $TC -j qdisc show dev $ETH root | jq '.[].options.base_time'\"",
         "matchPattern": "0",
         "matchCount": "1",
         "teardown": [
-- 
2.39.2


