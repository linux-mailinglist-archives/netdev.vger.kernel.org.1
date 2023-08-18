Return-Path: <netdev+bounces-28862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C6781071
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19866282453
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E381B;
	Fri, 18 Aug 2023 16:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99B469E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:20 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E003AAE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9c9944da8so895836a34.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376578; x=1692981378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKt5SyjNVCauUVIET/enhIq+pinooJIPlCEWGPfyFGw=;
        b=ZVu+zbrwKsw/YHroybkX903AH5dct+W7VAusKKiTUVH3PzLzuFSIpdLnhz338lfMLu
         fIGFuLbxMsmlGxeji5auTcMpzptFcFs8Luzoh3MB/iG3NXz/AfDPlYazKocRPTKewFRX
         +EDY7REQvAGe358XbhK9Hr4NJBxSJlVfs9G27cUGYzrDS10wqHhcCnFnzafIseqqH63E
         FyF8xmHABw9Y3ZzxmUJOv2rdh3rT3OZKh5sjU0XkqzpfAYUJmglCZQ8jtXcIHMWQ45Wo
         FMu+7k5Y03xuHwDlitlannuRdwKy9yq3jo3jG1TGYHgrShzoJx7bh7///xPcvVxDjhSt
         NfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376578; x=1692981378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKt5SyjNVCauUVIET/enhIq+pinooJIPlCEWGPfyFGw=;
        b=ZVoWe6FHVKfDjTjoIfWeQYDsLynBjvlKkwu2skJlXgdb0u0vXzfbBaVyGfSaGtO0M2
         Yfe6t4TObKmHdZaEVnSuPHwvRHwdMhUr+PGykU6pFXmQYOELRHRCoN4XdBbISfIIqfVk
         vw78Pg0DdpKEM8jQkIH3arm1UQx1ubpwJ/J+v0M+1XsVf2UACXtMop6SgYYKSmdpmOVJ
         wsITjnrT4koMhjznice2CiBomCPwkCIalASvKWujSKBHHGrkXzeoZO/wA3v20FJTGn0b
         9p0n+BfgRZD4xxjlIyInYwUSHFhmwTR+ozGc23An2xgxFJF0LroOY41vZqTEWdL3vn0S
         ozWA==
X-Gm-Message-State: AOJu0Yxk0z2a8nWoFF9F8ixDLcB7yWK3duPrCoKj6yOt3gu9dqn1tuBF
	ff5dgNkJBLJGGz5su+CJ0FTvSgJFtsV1IgNTVgI=
X-Google-Smtp-Source: AGHT+IHZavZahAJuvVys5ESgkgyYVznTsYafEOFiWVDLwnpDertN86Kq7tjSHQ+Ik/eqO4o1lyMSeg==
X-Received: by 2002:a05:6870:14d4:b0:1bf:8c9a:9a2c with SMTP id l20-20020a05687014d400b001bf8c9a9a2cmr3693560oab.15.1692376578646;
        Fri, 18 Aug 2023 09:36:18 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:18 -0700 (PDT)
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
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 2/5] selftest/tc-testing: cls_route: add tests for classid
Date: Fri, 18 Aug 2023 13:35:41 -0300
Message-Id: <20230818163544.351104-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818163544.351104-1-pctammela@mojatatu.com>
References: <20230818163544.351104-1-pctammela@mojatatu.com>
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


