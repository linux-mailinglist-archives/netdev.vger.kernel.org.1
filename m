Return-Path: <netdev+bounces-15152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92C745F90
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D61C204F9
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C13100A6;
	Mon,  3 Jul 2023 15:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C09100A3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:11:24 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85081114
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:11:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b05d63080cso4680972fac.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688397081; x=1690989081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T00GBwuyZ5EBjQMl3HlnUXfbDwtPDiAoLiMp41bcFI=;
        b=Gsz378OoYeiMZsqtalJquOHU8bvhgF4Wc4BX/4ve+dprrUIWWoMHfrlQnjfVhDusOp
         3GyysxBCpx1nTg9gCwZq9onDCcVQJiXrB8Xvj9ByhORk4YFnt+2JrzNK8GGlzslc1Aqd
         fsf5op9XL5YbLCtVghjmpG6EMmNwmEkYXobOIuixQf0OJSoy3e44mqWRIFCCn2UgY5aQ
         nLVhz2Ew3bvBxKNUjCHxH2PDAgUFERqRz7E+YIg59y7lU2bBDFH7tlXXLL+Ne9npwkSu
         6Q6H+YKINGr2RfiPdLnMfL8M3f/RugtUINOEBAah1y32+k9mAOwzzCBmvlcGOpy1V9lV
         RxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397081; x=1690989081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+T00GBwuyZ5EBjQMl3HlnUXfbDwtPDiAoLiMp41bcFI=;
        b=Jd2iUxiMcdylaY4FU264193kjeDN0sTG01GRmonLzy9vy43VTvOU0zc/Jkd5tw7cGp
         v9b40B/ZUa9dzd1pUMRZIhZJLdDsFf/1tA4r+jkBPD1go/d7C1eXyeJ6xz/l78KIgNe1
         eC6Bqi01ww0fyEIVJ8xTRh+Ruh49lwa221Ep0kLnLPcPXFIb9Dgy/pZ64JisBL7BxOTK
         bk1hbyAnThTWP/B6Vu7C7bO1eH3MUA8UOpol0JS2TCZGO0cOccpNuyEwRxfk7E8RUlJF
         Fp4rX3J5Jzv5qdkRCXYopL+JByPkdZVQWzTinbDCb8LkTRMjTbxu1+1PC/fEMKNbNjVD
         YqwQ==
X-Gm-Message-State: ABy/qLb6n/6LbBGErxaJL7QBj/ZSPoX7sEbS/z5MLyPzFEnAI7H0PA0Y
	evVYOr3RYyjDlPY7larFZzix671WS3ZW1QWQXrw=
X-Google-Smtp-Source: ACHHUZ58pq4NkOEKgl2jeP/0K+Jgqq/vZuH6S1qwL7nXLD8yG2Oi8gSEA0IoB0BkgHJQicpdOc5ojw==
X-Received: by 2002:a05:6870:e891:b0:18e:b6d5:7451 with SMTP id q17-20020a056870e89100b0018eb6d57451mr12211597oan.13.1688397081706;
        Mon, 03 Jul 2023 08:11:21 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:7e4b:4854:9cb2:8ddc])
        by smtp.gmail.com with ESMTPSA id cm9-20020a056870b60900b0019f188355a8sm12452600oab.17.2023.07.03.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:11:21 -0700 (PDT)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 2/2] selftests: tc-testing: add tests for qfq mtu sanity check
Date: Mon,  3 Jul 2023 12:10:38 -0300
Message-Id: <20230703151038.157771-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703151038.157771-1-pctammela@mojatatu.com>
References: <20230703151038.157771-1-pctammela@mojatatu.com>
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


