Return-Path: <netdev+bounces-16965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6374F989
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33782819F2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CF1EA99;
	Tue, 11 Jul 2023 21:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A71ED24
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:01:25 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8B10EF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3a8d21208so5363276b6e.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109284; x=1691701284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBOeuLVuAPTLN6vQKVxAw0mAbQvV60ZgiF6RxAel8/s=;
        b=T3WVH9I2ybeE65k6gXqSbCyCxWdGDtLop0yxaCZpoSjFF9GKsLwoMCwPGorM1exo7C
         1uurtmCsu87pBMMs+83M1YiR09qn1ropnSPOkX0KVs4Ef9OfGT9QrggYAm02IA1TaaBu
         CTz6JVJyDWL/hDy7j9zO1FDh9U46eVOMiFlhMiNh1P0OpFgBypFAS/Ne6OYR3rzd/W+L
         uJgQ3Kcc3cxbcWwTEH1MjEeXxX3o5LHmrqC4yMwuuCAUVBykexh5FJhXUD/rlj+4r2Fd
         aO7LhA92xaAmjE9jlVlZVJkHijfZF9bifjwdK7fHm+y5ji83NfaH3ygvE5gB02gIQiWE
         QiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109284; x=1691701284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBOeuLVuAPTLN6vQKVxAw0mAbQvV60ZgiF6RxAel8/s=;
        b=DXHoiqBodsEtpe5XvWU6dtrNoPxGLiV9qB8eHOAPttZ6QKYNqoI3mXVsa5XN9LcAxQ
         3uA/pDXUGDA9aADOZZJgd/l2xPCCgh0f5oaLJGvoqJPhzGAj8OnTrkusiM61c+KWj0IT
         ZB3Hu68RT18VsXCNCWFlwAiHnSsmLEKEWRGDGrjr51Un0tSRRz/rIf2Zig0gitUOJWMM
         d+8hYumFDZ9a8Tb+gKYOrNx6eW/cxB5QaQgjkG1R0/XS2h0WKhxlhBWHkQyGd0NlPJZU
         IZGtSYeUUCuEHHe09xqSAWpCmuB+19nO36LWb8hxUJqhB3LaKpSwBrVJGUB5aRf6zuut
         +BgA==
X-Gm-Message-State: ABy/qLZbDqbXbruvQCjoZ3+rnHvYHCxCY8Jx/tjK6xpAvkx60JTI64Bo
	WMbcU9za3sXB7nzxd/cNkaAHkdFAakhuNHlxn7o=
X-Google-Smtp-Source: APBJJlFL+eBGE8iC49k1T3p8ap0pFJsYB4yOfOHZr7K0ISqzqPws7NcTJbde0JeETxCOtlQb2rZA1g==
X-Received: by 2002:a05:6808:10c5:b0:3a3:eab8:8ba5 with SMTP id s5-20020a05680810c500b003a3eab88ba5mr18920078ois.27.1689109282744;
        Tue, 11 Jul 2023 14:01:22 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:d1e8:1b90:7e91:3217])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b003a1e965bf39sm1290575oic.2.2023.07.11.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:01:22 -0700 (PDT)
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
Subject: [PATCH net v3 2/4] selftests: tc-testing: add tests for qfq mtu sanity check
Date: Tue, 11 Jul 2023 18:01:01 -0300
Message-Id: <20230711210103.597831-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711210103.597831-1-pctammela@mojatatu.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QFQ only supports a certain bound of MTU size so make sure
we check for this requirement in the tests.

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


