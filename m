Return-Path: <netdev+bounces-16151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4274B956
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB512813CF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD017AC9;
	Fri,  7 Jul 2023 22:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEB17FE4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:01:29 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37CBB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:01:28 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b73c2b6dcfso1919077a34.2
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688767288; x=1691359288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMIZsHa3uwMa+8crvw6UUPjFIn6xo4rxqJ9Ra4LvEew=;
        b=KYLAAhr1eXMMAxZt45HPy+O4nWNB2iqa4EJakiB6yxWai5puFyqupfTPXfOjx0gs3o
         l3gWIK4iTknH63QL/TeWCj0rUUyF+63Y9zWF4iR7Vqr+5jJK/NlaAozNgMwtVhcOtfW+
         buyCIvwARFlQW6hoLeiVHZnFPWditkcgSBDijx7hiWAUc7MM5G6zyjR9QfS0NhMje1i0
         2AYCcneveBUNmsZD4qYIYpBH+bo6dnxHry6y+3pvl650BBgiiq3x7LeFweVty13mHA1C
         FaKZd+N4mkhAAYbVMcAXb1tI2j8f3pQwWqWMbN7RK+mhXOPGuy5LCqzDP80t9f2AU87i
         cyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767288; x=1691359288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMIZsHa3uwMa+8crvw6UUPjFIn6xo4rxqJ9Ra4LvEew=;
        b=SfsOfVmzHsR+XI8jcm+t25m9b8nGnnhGswri+DIzt4+avUJRxCnPraBJsU8lWrFnGr
         GDd4U3jWAjWnviJUNAX0imW+PKwR2K+5jszraPybcmEgB7qxfRaGSFatRR8YAJbQTJa5
         xgo3lSXh2mwELxdGwTf2zUBSRh/hHFLOi2hOUHk1LPN1M6I6H7CnTFGsOIqoyj8Pwvet
         rF37vFv+Ll4gWawSHp70T90KtgpaRHaqftW7lUofZPjAgm2OlNoS+/DgrmflU9HFR0tM
         BehsjxBI40UvGj1O+zUj1Pgim2kbvyh7U5J0yzqjLfChuN9NI7MFisOuwXV1NNEMRHK1
         3HVg==
X-Gm-Message-State: ABy/qLbH9MRS+yAhP1ixfX7CwBrZx4kpSQsgr82w1fOj+fBcYwQnmHBh
	UcCcYNt1njBX0pS+6ROIyTdXV6pdOMyxwVdJLVg=
X-Google-Smtp-Source: APBJJlELgLA+foXY/WKoAqLnXWSITLlRHiNz2ovIAVkmx46rS0/phC40G9eBIw9d0hu7EYoyN2tngQ==
X-Received: by 2002:a9d:7d82:0:b0:6b8:68ac:f7f1 with SMTP id j2-20020a9d7d82000000b006b868acf7f1mr5275832otn.8.1688767288203;
        Fri, 07 Jul 2023 15:01:28 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:9dd1:feea:c9a4:7223])
        by smtp.gmail.com with ESMTPSA id p9-20020a9d76c9000000b006b45be2fdc2sm2055533otl.65.2023.07.07.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:01:28 -0700 (PDT)
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
	simon.horman@corigine.com,
	paolo.valente@unimore.it,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v2 2/4] selftests: tc-testing: add tests for qfq mtu sanity check
Date: Fri,  7 Jul 2023 18:59:58 -0300
Message-Id: <20230707220000.461410-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707220000.461410-1-pctammela@mojatatu.com>
References: <20230707220000.461410-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QFQ only supports a certain bound of MTU size so make sure
we check for this requirement in the tests.

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/qfq.json       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
index 147899a868d3..965da7622dac 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
@@ -213,5 +213,53 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP link del dev $DUMMY type dummy"
         ]
+    },
+    {
+        "id": "85ee",
+        "name": "QFQ with big MTU",
+        "category": [
+            "qdisc",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$IP link set dev $DUMMY mtu 2147483647 || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root qfq"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class qfq 1:",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "ddfa",
+        "name": "QFQ with small MTU",
+        "category": [
+            "qdisc",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$IP link set dev $DUMMY mtu 256 || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root qfq"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class qfq 1:",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link del dev $DUMMY type dummy"
+        ]
     }
 ]
-- 
2.39.2


