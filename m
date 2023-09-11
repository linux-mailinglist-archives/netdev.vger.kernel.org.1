Return-Path: <netdev+bounces-32957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A279ABFC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66FC1C20973
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFE8C1F;
	Mon, 11 Sep 2023 22:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012718BFE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:12:39 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4034A6F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:12:09 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-64a0176b1easo30863826d6.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694469890; x=1695074690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdY4YC4aJGas0z16053mXqTDnRov5YqrsJzz/GcyDl4=;
        b=Jv/0jVWx3qrV+KpcZ8VHuEn6lfvDairPWXskDQSXP1XiBzvkaiD68wI58TbH5hV6bM
         NTpe6W64bdQDfwzYKJSmp+OSCu/ogYq+pXV6jFU0Ooa46+b8tnJjkiYRPHkjxTnNzvne
         z374pDyyM4S6twdwnLyRCrACT2W807FYw1ZeK3txRDEFP95xQIs45OFSAlk0xar+WH9b
         h+1RQHPH+Ov4XIV+kP7McC0U/caaP5MZHvkL3+HnGdmq54+63SVkeZ0iwqMAbt23hyTy
         Kvi+F3Vb1/eSKXqCaI+++yqUA4yhR6tBSXSiXe8EPWTAZ23bzuglP/lgbLf0dpj3Bhdp
         k+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694469890; x=1695074690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdY4YC4aJGas0z16053mXqTDnRov5YqrsJzz/GcyDl4=;
        b=SRELB6QfwfKqVLq0rMvyW/W+UGIn+3VURcrVToLs1iqPd0MRLk02MGH61/kJ7oVLjN
         kyywN+5P8SpbwjllJkoO5/UZlFfrwlgKEQ1AcnnU8YKEd35IGN/hDmdyA0As8hxcJ+vF
         wAYkkWBAwBPkAbrLNOlzElVF1U/fmIoVV1oxxKRY43p1mE9gGrlT1+4e/FFpO6JWitez
         knDBa7HjTDSzXPD74DIuwRhkSSY/zBULsH6nL7rbQCYvthi91y86I+feh86K8CzN64ev
         tLa8B1ihlTRjPs3vx1M7+VH4S5VdqUwhoqcdN3C9GhYJv+ctqR3gca2+dvV2JZzCBwtE
         2ifg==
X-Gm-Message-State: AOJu0YzFt/WKNZ9PcnxkCss/8anM/42KcIJEY4PGugSMsGnFBJkMR6T8
	4saF2n6/JtgfUwPnaFqGWlepxZRVWimz/0ffJsU=
X-Google-Smtp-Source: AGHT+IFx1Bq7WChHIoMItspZztW36XS7+DgaLdXH+4zRbbl+2qNQ2IMOS/BFz8VXoEoCoxxbt+Elnw==
X-Received: by 2002:a4a:dfdc:0:b0:571:2b86:2050 with SMTP id p28-20020a4adfdc000000b005712b862050mr11149039ood.7.1694469057095;
        Mon, 11 Sep 2023 14:50:57 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:accd:6e1c:69ae:3f11])
        by smtp.gmail.com with ESMTPSA id 3-20020a4a0603000000b0057635c1a4f2sm3776869ooj.25.2023.09.11.14.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:50:56 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 3/4] selftests/tc-testing: cls_u32: add tests for classid
Date: Mon, 11 Sep 2023 18:50:15 -0300
Message-Id: <20230911215016.1096644-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911215016.1096644-1-pctammela@mojatatu.com>
References: <20230911215016.1096644-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As discussed in '3044b16e7c6f', cls_u32 was handling the use of classid
incorrectly. Add a test to check if it's conforming to the correct
behaviour.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index bd64a4bf11ab..ddc7c355be0a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -247,5 +247,30 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "0c37",
+        "name": "Try to delete class referenced by u32 after a replace",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC class add dev $DEV1 parent root classid 1 drr",
+            "$TC filter add dev $DEV1 parent 10: prio 1 u32 match icmp type 1 0xff classid 10:1 action ok",
+            "$TC filter replace dev $DEV1 parent 10: prio 1 u32 match icmp type 1 0xff classid 10:1 action drop"
+        ],
+        "cmdUnderTest": "$TC class delete dev $DEV1 parent 10: classid 10:1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DEV1",
+        "matchPattern": "class drr 10:1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.39.2


