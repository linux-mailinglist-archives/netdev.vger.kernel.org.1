Return-Path: <netdev+bounces-30745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F79788CD5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE879281508
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975881773C;
	Fri, 25 Aug 2023 15:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1871772C
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:52:24 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FD10D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a88c422e23so699307b6e.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692978742; x=1693583542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSDSdR8lYA3CyRQ61SRbC2eytywvaKi5Vn+nvHm9A2c=;
        b=hg2OFDd47Rqlj2D71nbkoJZIg9dDiDyX0lU+Vc1qyDEkHx44lOjaaqNsSp7yRldN3K
         zd7zwi8Ql2TIxxGErHSK4mN5LYKPLd/bGy7rEDu+7Xe4MW62Bp4r7zl07u1Av0Dga0Kt
         MHRRIf3JM0REZ4yCAlhMkYySuzcTrM/xJuHKaup5ofNFfzMpbfQbOeABV5Em5kLcSvSB
         VFLm+Fuvc/26HlnEPJhEDhhW/Fv2iOAWe0lOMRpI8BuhmOzVcet0YOxLF+lAkrpfyyQD
         zLtrAXY1T+5MvCRVGdN2NsYGdGqiPCqa4mVPIBrc2SXb6u02puf6ZYnF4nPMEg2dAAYC
         L24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978742; x=1693583542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSDSdR8lYA3CyRQ61SRbC2eytywvaKi5Vn+nvHm9A2c=;
        b=lWu//Lh+NeFMkQPXbh0ECFugkpRKMzC+ac9rLnTHmWVf7ofyusQRy9ejehmKeKHoOp
         zG1Rm6gzKKhnQ9V9E2rv9DNGJDbu/Z7s+7e+yyFlfoPJOFG312/T5IFIo274naSCJqLE
         +1vXyD4oUNZ2wXLZBIYarTSOvQ53bbdU4WTMtJDnV2XR3JYkm9OQqRNJLLVCpOOYCvhN
         4kSUQPnZf00yIdkA7bX1TIvA+AVflRwGuBifIIDJ2UeJwB58+9AVEeGU5n8hzBLSkrlk
         XOiNMrqk5O+amzAk0XApFf/XaL6NgwFqEe7MS4NebunSAyi4YPHXYWE99fKq9sUyopJI
         1EGw==
X-Gm-Message-State: AOJu0Yx8rFsZ8elBAtIhJq/tJz1e13wb0bFJbQmSBddPowAPvrLsmsM+
	qY3G7RAzAE4rqBX4Clf0nCRRpIPrXRSKNjHVD78=
X-Google-Smtp-Source: AGHT+IH3/F8dAvDEYswKJMv6agnvVHJHJLBxK1nfbra75pWUfwYXdvHVk9EOiazCYQTFoQNNTMyP1g==
X-Received: by 2002:a05:6808:498:b0:3a8:4acf:d7d0 with SMTP id z24-20020a056808049800b003a84acfd7d0mr3221829oid.48.1692978742220;
        Fri, 25 Aug 2023 08:52:22 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:6001:c5a2:ad40:e52a])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003a88a9af01esm856678oib.49.2023.08.25.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:52:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] selftest/tc-testing: cls_u32: add tests for classid
Date: Fri, 25 Aug 2023 12:51:47 -0300
Message-Id: <20230825155148.659895-4-pctammela@mojatatu.com>
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

As discussed in '3044b16e7c6f', cls_u32 was handling the use of classid
incorrectly. Add a test to check if it's conforming to the correct
behaviour.

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


