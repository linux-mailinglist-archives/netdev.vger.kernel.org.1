Return-Path: <netdev+bounces-30744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5F788CD4
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A59F281701
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74F1772F;
	Fri, 25 Aug 2023 15:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5C1772C
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:52:20 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF610D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a9b41ffe11so268609b6e.2
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692978739; x=1693583539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKt5SyjNVCauUVIET/enhIq+pinooJIPlCEWGPfyFGw=;
        b=F0eWoihV4kxSTPfMyPAiiKolbuVxZokJ8cGKxWE+KnVHrrL+PmD3szBt1NZLE5sM7d
         AITjxwqMip4A9/T3ojqBVamJtQ32cCtYaqqh0wfN3uw6q82iEBdWTZUWZEmkSxK92qY9
         1rEO6Hitr8BKLZ5JvSCJmJZxUo+TpoUB7Wq/8UN0P55/TSZTYqTVs4IYT9vo/FYFCJLO
         sy5Q6PQoKvEi52Hdq/Aywnv3l7ukRififPT63p9H+6F+f/LSZkxSsOM5I44aoKtFQvgi
         Zm+v7Oqse5CF3PcbajOH04fbbnZhAcAn+5scwhM25cT5i2k2FkRGY9cgJKrbjPg0mY4H
         LnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978739; x=1693583539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKt5SyjNVCauUVIET/enhIq+pinooJIPlCEWGPfyFGw=;
        b=aSP4lwNMEVSzYNFo1Fwrpo9aV8uCPhbfOee579f85hfbWnhms8taNLTI/YbstwhbJg
         /A9+cHi58QTJdtweVIhfBeogJ8R+UI4Nwda25kyENbepeQtZ3UiYRW66cBK17BQPiBSG
         4BtoZy0ESIjPXyRaJQbB6i1iGdSYDx10HoCOvHbgEOYXZHstII+t27f3zo+2MclUs8YQ
         UlHYqHvg1HFYrcvn/+6XgRamAbNwvTjOFCldJgr9aaZ9FcQ9dcmyX3XbkJOWYguKl1Nn
         bdAzpOKiIiiun3JzU2Asr3UWK5Xj3PB0xgbg8i6R0D83SpgSUhcG+DcnIwxK11Rf557c
         oiaQ==
X-Gm-Message-State: AOJu0Yy+MQmA6Fg7x/+s3LuqC/rHIikD7LXop/PiTAJFY9+/rTMiln3q
	PhgcAYizl6YUI2SLiIGio0dtlpVY0MRWuNWGUnI=
X-Google-Smtp-Source: AGHT+IFPSOb3UTJOfy2UrEPW/TNWG5acTw0SVbyUeyXd94a+29uhIZFL8asL8Nz4gaY6kDG2V5chdg==
X-Received: by 2002:a05:6808:48e:b0:3a7:2693:3293 with SMTP id z14-20020a056808048e00b003a726933293mr3376628oid.16.1692978738916;
        Fri, 25 Aug 2023 08:52:18 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:6001:c5a2:ad40:e52a])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003a88a9af01esm856678oib.49.2023.08.25.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:52:18 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] selftest/tc-testing: cls_route: add tests for classid
Date: Fri, 25 Aug 2023 12:51:46 -0300
Message-Id: <20230825155148.659895-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825155148.659895-1-pctammela@mojatatu.com>
References: <20230825155148.659895-1-pctammela@mojatatu.com>
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

As discussed in 'b80b829e9e2c', cls_route was handling the use of classid
incorrectly. Add a test to check if it's conforming to the correct
behaviour.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/route.json    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 1f6f19f02997..8d8de8f65aef 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -177,5 +177,30 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "b042",
+        "name": "Try to delete class referenced by route after a replace",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC class add dev $DEV1 parent root classid 1 drr",
+            "$TC filter add dev $DEV1 parent 10: prio 1 route from 10 classid 10:1 action ok",
+            "$TC filter replace dev $DEV1 parent 10: prio 1 route from 5 classid 10:1 action drop"
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


