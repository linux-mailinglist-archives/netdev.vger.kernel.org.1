Return-Path: <netdev+bounces-30743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B20788CD3
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3662815A5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785D174FD;
	Fri, 25 Aug 2023 15:52:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC9174EC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:52:18 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B07B10D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7781225b4so729389b6e.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692978735; x=1693583535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0vTjezjoSM1DOz+TAXl0KH6KmFNNk+EeAzo4+1prqo=;
        b=WhdqzVFvJS7PxOKkGE1LA8PV8ATS0l+fzRXZy0qhF0bfBrJOuKOi2eWM/3mQCOHrZo
         n/6y36YRw/LI0S+OwgJbd3zG8vbbrPtVq68hjrw4H22PxidXric4aP1uAUZeHpsUV1H+
         zw2IVBxG/ENVUyadqAjU2t9sCjtb8a88WW+P3zY5PPEDXvP/QaayGKvs6Box34B92sV2
         pPEOX/DQ4YzXyTwv/3BfSW/j74AKvEMebXNf8S6maVY3SPsn/jCOZknnI+Kz+Hu+Pg1B
         mKQVQ+oC1T0MNTt5ioUhcJ8dPvnnDq/U76AG358iekw8hffkxTXTwFZRMrxzhbr6tFoB
         JZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978735; x=1693583535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0vTjezjoSM1DOz+TAXl0KH6KmFNNk+EeAzo4+1prqo=;
        b=ltZ/fgx9/aALW5FfL4Y8IwtUEeVjurUuWv1xD86iQu0XCq9AlInKtZ5mMi5+ilgk4x
         0M422IsdlxS6VGlip4erIzbhHlIxjnSsOMGi2IPmJwg3stgSuJx/PUszGGh62DzooG/W
         nPzORYNisou0y+5aKiXfLBsu7dEArgDqjktpM+nB235qzhW8L2xSVP4C9/uNHoNXnaAK
         FgTVs6Ly7+LxZF9vRzDgS/+FRRQeLgfhitaf4Fccg20YaRBAMNnulPO+UI6g1ctLEwL9
         bcPXgICufXa8cYdKxkNxBHD2XpYHWxyUI3gp0mtBUCvkN4NeGTTkBVuHmvv4oqIHwp0I
         3T2Q==
X-Gm-Message-State: AOJu0YyJCbVV2USdFlITgjVeHvU4to6AY26RY9Ybgsove9YHEjGeHp1o
	O9UmEyrGlyfSKvDuWVE4FBkSJAOZniDwHycyrKY=
X-Google-Smtp-Source: AGHT+IEMHBa+pblL0s7K1XkXV5RyAqVqJoNhVBLW6c1wz/mVGYEwgvWvDhGD4seSZ7qumopOJ4C8KA==
X-Received: by 2002:a05:6808:199e:b0:3a7:208c:4406 with SMTP id bj30-20020a056808199e00b003a7208c4406mr3707019oib.1.1692978735576;
        Fri, 25 Aug 2023 08:52:15 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:6001:c5a2:ad40:e52a])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003a88a9af01esm856678oib.49.2023.08.25.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:52:15 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/4] selftests/tc-testing: cls_fw: add tests for classid
Date: Fri, 25 Aug 2023 12:51:45 -0300
Message-Id: <20230825155148.659895-2-pctammela@mojatatu.com>
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


