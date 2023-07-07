Return-Path: <netdev+bounces-16153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC374B959
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92A0280D3A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E417ACF;
	Fri,  7 Jul 2023 22:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3317FFA
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:01:38 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17693B7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:01:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b74faaac3bso2201909a34.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688767296; x=1691359296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eAqcjmCaVw9XN/waU4BooIl/PL/BIW2zs3IRQnhOZg=;
        b=fjiA95ATIsTC437w54ApXAR9NfwJeIrLdrurK/xxTJv/nF7+h7JUR3NnxmSd4VITDI
         2TgzG0nTE+5kOVqNIy0x4Cnnw/3kIa7IRyhG4ia60sqip418mx79UocISymdBILcuazz
         HNeYV+QzdN62wksvDiLpuAoaheM6MTCTvdfrkfIwTDSsUYiXYxRmjNT+FAvkqseOOXsX
         xKAlN5XNAFXB2AJssm+yQbOT44nXTkNUui97gfA90netNVFx4g3EZGYTB/66TTDgDHCN
         GcKTrnmVJsoTkvSkMbYJra4vSs8qKRZzmMjznl+wrM/ebx6QnW8MkASmSZ3/xTrFooiz
         +KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767296; x=1691359296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eAqcjmCaVw9XN/waU4BooIl/PL/BIW2zs3IRQnhOZg=;
        b=G26qH+BxLF6STs4uwAm6kTYcn+eoSBWMmLdjgs46gIEtfuinc6Ouli3W4CLaGtKYgW
         VcjRvbIgJRCRkYUVP6lKfwda7BWW9xTUhiOgIAYZBYOdGC6zKBkgEMkk/j5/fDmpPrUQ
         Q/RYmTc/mMs76LG/LWOZjquA+mLlBd3Q2wJwJ+prZvJZ0QASNzNENv2lzb7VjAerb7EY
         3vsrQij33klWc9gNLfxNLUTvzFsxAbPfBX505pvdhfP/eeOrwoN0BNXZm8hvjEJe5uEE
         8JDZHdOWDxtBRjoEF49LYF/O7eHwrd4x421yVfbhli3HRNHTTHVYZI3X4B4YAxUvDnb/
         BH4w==
X-Gm-Message-State: ABy/qLYsVmJm2DlgYYirS90rp3sg5jj+zAEUBl6/pnniyd1VwHXEQcY0
	vS3lx2LT2DmuSdRCZc6oAAATCI+1e+AiH6kQRoY=
X-Google-Smtp-Source: APBJJlEf7YGhRSAxZZ9ab8n8jSD6EURLpHV4bNF8YVXfuVIDYMxj9ZFMc/50wH8TsohrlxM55uVzYg==
X-Received: by 2002:a9d:4f16:0:b0:6b8:8006:df83 with SMTP id d22-20020a9d4f16000000b006b88006df83mr6180679otl.17.1688767296327;
        Fri, 07 Jul 2023 15:01:36 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:9dd1:feea:c9a4:7223])
        by smtp.gmail.com with ESMTPSA id p9-20020a9d76c9000000b006b45be2fdc2sm2055533otl.65.2023.07.07.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:01:36 -0700 (PDT)
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
Subject: [PATCH net v2 4/4] selftests: tc-testing: add test for qfq with stab overhead
Date: Fri,  7 Jul 2023 19:00:00 -0300
Message-Id: <20230707220000.461410-5-pctammela@mojatatu.com>
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

A packet with stab overhead greater than QFQ_MAX_LMAX should be dropped
by the QFQ qdisc as it can't handle such lengths.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/qfq.json       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/qfq.json
index 965da7622dac..6b8798f8dd04 100644
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
+            "$TC filter add dev $DEV1 ingress matchall action mirred egress mirror dev $DUMMY"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY parent 1: matchall classid 1:1",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 22,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.10')/TCP(sport=5000,dport=10)"
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


