Return-Path: <netdev+bounces-28863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863C781074
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442CF282495
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37532563;
	Fri, 18 Aug 2023 16:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8787A38
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:24 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B93C0A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:23 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56e99f97f0fso365411eaf.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376582; x=1692981382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSDSdR8lYA3CyRQ61SRbC2eytywvaKi5Vn+nvHm9A2c=;
        b=ZKE09onA+xh5BBzDDYx6s2/RJu7RLre5B4pAKK3VbWcV+UT0Bs0PQLNlruQ03Nat3g
         Qzshd4G1AtNk711JCl5CeY6hbuHK2StjR9/5s0MTTcXYJMukw/wYOANnX4zGJ2nrJTNy
         qbBq70JW74SRMtOVTXA0wIKXxIdc4O+EFgcj7ZZkxoQNaBkFJ3fLwCL/bpdTxPwtiw3b
         mE+oZCYniRt8fnlRrkF7bKqwHiqw5ODfMFkxfcv5H4EERDmGRWjmkVlasDXcwBRm1AEK
         8ih3o34ChwawQf2wO5ojE38LvqCBau3cara+00zakZV2ITRkgQHa6DBulpPuk/zwbRyN
         +eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376582; x=1692981382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSDSdR8lYA3CyRQ61SRbC2eytywvaKi5Vn+nvHm9A2c=;
        b=BRMsdp8dSiBwmc4wt6syZSn7BySIIxnmwXTRDxzbmyunEx00+up5i9Qbk7RbX7hlM1
         gV1IhzX+vlsTA/FgHjuLwWcfw2iKckywjg4PskY9XzSgIaHpVGwOqui44O4du0/+pyQS
         9oQWveVE3Op6x9CgxuYa+iOIbnQLoi3jx3UyQOFi32TVUEa8wpOeNDnmhLlM5Cw/ILBw
         p6x0vGokwoV5AZUCfRWZSxpbS6k/xjuNzHhNtXYzzYcMjGltF6jUIeCgCK0WwpgPDuxB
         4I7OEfcVKq8vXMrFJkfwYCX6pE8wlzt05cSCdmRnCDEtmtfkW7j1NzCDP2B3pFnwuT30
         EkPQ==
X-Gm-Message-State: AOJu0YxF6EQ6sNxoLyM2K/CzqGJ+RQ3vkgM/9lPpRFhCMld4WBGyU3VP
	TRtvqqVZbMawfQcRYAzcTDY/q41pZPRLOrdzfHE=
X-Google-Smtp-Source: AGHT+IHxEGi+Bg3KG1HayON9OocqFOjyqBUNVB1u03CkEbJKEPbgNLnYzAnAM3lY1tq85s2xdtY4nw==
X-Received: by 2002:a4a:2559:0:b0:56e:68a8:7f5d with SMTP id v25-20020a4a2559000000b0056e68a87f5dmr3567569ooe.3.1692376582516;
        Fri, 18 Aug 2023 09:36:22 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:22 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] selftest/tc-testing: cls_u32: add tests for classid
Date: Fri, 18 Aug 2023 13:35:42 -0300
Message-Id: <20230818163544.351104-4-pctammela@mojatatu.com>
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


