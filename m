Return-Path: <netdev+bounces-28861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15C781070
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986E01C21638
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FB4431;
	Fri, 18 Aug 2023 16:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F074430
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:16 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695C3AAE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:15 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56d455462c2so719424eaf.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376575; x=1692981375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0vTjezjoSM1DOz+TAXl0KH6KmFNNk+EeAzo4+1prqo=;
        b=uLol21rTJ8zlthRUBaFgSevYbtXZX4yet/tpiqR3VujKxBl1NPoRivqii8lOuyvFy7
         wheddWRh9mx2STYA6H2Uu42z6JUJHR8rsE8Jxy/VaFuYAp6mxBpKrpSjP9BweyXuimxv
         dQ8ARVDDTv4PFgVMGngMJ/PSFfQrZS+iW7mOOo3005yjZZji9TO6t0+KR8UugLONCmQi
         zx244mnRU84sMrD+ZEI+iBsTwbQNIvvaSslb692K263k5z3jfA/grnffV3JAxSG27b9p
         iTDZE9gCcY1nDxQGEZ7PontKn26ByXsN1GUgRd2GDUSXtfvNuYZ5N4Q1u5QUccu+cc6A
         J6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376575; x=1692981375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0vTjezjoSM1DOz+TAXl0KH6KmFNNk+EeAzo4+1prqo=;
        b=ihiExUR79FhnTYcaBvLJqfuUM/nhSQl457+LxpFshvdDBeJ6u1i1AQtAUwD4Qs/xRa
         1QSr+fdr53Jpffm4hMWbgUXI0jKDg9+b2gGuhtVl7X0NPJFXjZDOY0VE4bXT2TChcERG
         zKFmrnVoj/6P/HC6LM35ivCvUV8HIEI8kHdgYnxrr8e/szkxiXA7Qiy9SetRmTDRskk2
         F/f86jiwLPC/r16HOD1PF0ciIGHJRL/mt/aPcDCbZ0qoL4Q1pj/I1HPARe1inspaXffn
         +LxVhgCs9Agqt1Lnez/kUQMO27YVT9RFQL+fnJpfeS7JeQYa/AfgI7FQiaSF4Fm/S0nV
         XngQ==
X-Gm-Message-State: AOJu0Yxum+NLIXYsxoRLrURc1BDKvrUPiibqX7S/uiYL8TGrkZq1LKGW
	V1p2p93y/5oHhqbB5aUQDwMOy7I0f4iQZMcLm98=
X-Google-Smtp-Source: AGHT+IE7ZCRfbZQMn/peHeIwd+plzLAAyHhIZfAw1u0RDArOS+F7IgnuDa3uloNfabrFWwzlQhIh4A==
X-Received: by 2002:a4a:6f56:0:b0:56c:7428:4a35 with SMTP id i22-20020a4a6f56000000b0056c74284a35mr3403976oof.7.1692376574986;
        Fri, 18 Aug 2023 09:36:14 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:14 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] selftests/tc-testing: cls_fw: add tests for classid
Date: Fri, 18 Aug 2023 13:35:40 -0300
Message-Id: <20230818163544.351104-2-pctammela@mojatatu.com>
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

As discussed in '76e42ae83199', cls_fw was handling the use of classid
incorrectly. Add a few tests to check if it's conforming to the correct
behaviour.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/fw.json       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json b/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
index 742ebc34e15c..a9b071e1354b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/fw.json
@@ -1343,5 +1343,54 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "e470",
+        "name": "Try to delete class referenced by fw after a replace",
+        "category": [
+            "filter",
+            "fw"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC class add dev $DEV1 parent root classid 1 drr",
+            "$TC filter add dev $DEV1 parent 10: handle 1 prio 1 fw classid 10:1 action ok",
+            "$TC filter replace dev $DEV1 parent 10: handle 1 prio 1 fw classid 10:1 action drop"
+        ],
+        "cmdUnderTest": "$TC class delete dev $DEV1 parent 10: classid 10:1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DEV1",
+        "matchPattern": "class drr 10:1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
+    },
+    {
+        "id": "ec1a",
+        "name": "Replace fw classid with nil",
+        "category": [
+            "filter",
+            "fw"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC class add dev $DEV1 parent root classid 1 drr",
+            "$TC filter add dev $DEV1 parent 10: handle 1 prio 1 fw classid 10:1 action ok"
+        ],
+        "cmdUnderTest": "$TC filter replace dev $DEV1 parent 10: handle 1 prio 1 fw action drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent 10:",
+        "matchPattern": "fw chain 0 handle 0x1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.39.2


