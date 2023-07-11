Return-Path: <netdev+bounces-16967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4274F98F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773E1281423
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC41EA9E;
	Tue, 11 Jul 2023 21:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DA1ED20
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:01:33 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5110DD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:32 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-565f8e359b8so4287398eaf.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109291; x=1691701291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+wNL7uX7hr5BtVhWKeG8QW6Iwt6qL0jrJtflU9Rw0g=;
        b=F4mb2Bm/nJEI8G1VXSHURHaJoxZSolT4mdMNufTM4a3dWrX5sPgvjcj9sKbWlbuNyk
         zsxKRv2yldnAnvsjOjQNTHJaUneJFjRy0kR2vb6ILsfW3n8xlRONKcalZEykFNUhj6+Y
         wZLAJtzCWbWhxq3b2J/SlcCVATJ+NMdPcOFL6NPZQJk/P2MyeZXaUuo1jcBcQDa/yXWo
         4Xyxgnu2Yzy3oS4K15wVtCSGI1osh8i9UObSxs8PytxoDJoniQh3hoccUhPcFggXcBP+
         72mgRboMdDBXqzGWUTyNL3Q86UYSXVMD4/a/WEkLLz96p4wU5zdpEzqc9m9TKkDEZwx4
         8hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109291; x=1691701291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+wNL7uX7hr5BtVhWKeG8QW6Iwt6qL0jrJtflU9Rw0g=;
        b=FJdbL23jVJdrq8DuTC6jZwR8YWNq4aRZd1582Cu5XXUm4JrRAg2qjYzDgD6p+0eJU+
         Yf5J+FJBP/oy5G1YG8wt1Kb1nZBr+LJy0bshjq8nPjWyQ7lrYvPSWLURKqHikKG03d+a
         BAq7BZCBrK6+Rqh61t38fWDezJLG9Od6ryg4dZRKpDM/m0v1zRkkW1ni0gfgT801ashN
         yAQbkvF4BRZ0jBrVDJngxfwQH5mp4tHxVf+Mcy3pgvZIonpavCZ+SyjrW8lNiiE4W/U0
         kN8A/20HYyjc5gCP154f0Suartn2FTjFiI9Jp/NwOavv9FoMN9eODS//WScFLR3lkeFy
         Vbzg==
X-Gm-Message-State: ABy/qLY+X2dDCR5nyJ2ilToXMF8wuuxgJhmirFmCsMmAvbWHCF+SUHxW
	O9OAXgmS11GrJ5T0tPxUG8HJXxrGjL+/iORUs4s=
X-Google-Smtp-Source: APBJJlGuc0vkNQFpBfr5S8ohkx89OKez5xdQwLvy0dCFMNpbd2aeeWhOV5OqZjE+XeOvDC6XBay7EQ==
X-Received: by 2002:a05:6808:10d2:b0:3a1:e3ee:742a with SMTP id s18-20020a05680810d200b003a1e3ee742amr20748917ois.8.1689109291443;
        Tue, 11 Jul 2023 14:01:31 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:d1e8:1b90:7e91:3217])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b003a1e965bf39sm1290575oic.2.2023.07.11.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:01:31 -0700 (PDT)
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
Subject: [PATCH net v3 4/4] selftests: tc-testing: add test for qfq with stab overhead
Date: Tue, 11 Jul 2023 18:01:03 -0300
Message-Id: <20230711210103.597831-5-pctammela@mojatatu.com>
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

A packet with stab overhead greater than QFQ_MAX_LMAX should be dropped
by the QFQ qdisc as it can't handle such lengths.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/qfq.json       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
index 965da7622dac..976dffda4654 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
@@ -261,5 +261,43 @@
         "teardown": [
             "$IP link del dev $DUMMY type dummy"
         ]
+    },
+    {
+        "id": "5993",
+        "name": "QFQ with stab overhead greater than max packet len",
+        "category": [
+            "qdisc",
+            "qfq",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$IP link set dev $DUMMY up || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: stab mtu 2048 tsize 512 mpu 0 overhead 999999999 linklayer ethernet root qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 100",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip flower dst_ip 1.3.3.7/32 action mirred egress mirror dev $DUMMY"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: matchall classid 1:1",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 22,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='1.3.3.7')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc ls dev $DUMMY",
+        "matchPattern": "dropped 22",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root qfq"
+        ]
     }
 ]
-- 
2.39.2


