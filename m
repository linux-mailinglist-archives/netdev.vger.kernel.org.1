Return-Path: <netdev+bounces-17212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013BD750CEA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DF2280E5F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD114F93;
	Wed, 12 Jul 2023 15:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC014F90
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:29 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE31989
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:26 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-47ec12a6e6cso1357241e0c.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176425; x=1691768425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=p/4edp6AI/6po2fS4FqNpB4kt0+zeJY2tJ9BxjVSbl/JG/z4tOYEoLmlNSt5hPNM97
         sTcMYFdzfDN0W8jsa8gBfw3pnCA3Dr9PyCBxo740hdzFuThTcpV/gV1zKgS8kTcG3XTj
         zeZGcEbDjNPqutoGmqrs7/APSzVAJ88UggH+iy0icb8/mBKwJRCyEzOX6U/sphqv8+6i
         iOdmbuPP7PxgQFNBgonzKUmRLw+eTTUyLNTCksS5bS9GS/6cqf02QpwYeExfxxY8ST/z
         zAqyuyjKL4BnLy5r+DR6UEkxOY6Axj84xKd+9Ti9fvMMbXp0HP7UyAYQaErquMxX/4ta
         xXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176425; x=1691768425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=HfJe7dRBtc8F3bNxhAve98HZ/ZBdFYxGrerMo2vKWLuHTYU9UMhht7l9BGU9Aa9qwK
         8D/O99J7oOk0/PUyFrp21K61aq/Ogv/0wzbTppUGAAm4ObOht5olYM8Mdy/hNrUI/T0s
         UvL0KV8e++T5ZrkY7grrwmP5/E62KoYFUDuP7860dLOhxVDq41I2fo13kSBA1fF0oDRi
         sz3njueiMwwHGAmskqKf0j0uOkdIIpA1JuiLa28/WjPumlA5MFGE2NDEOlD4hGpwhGua
         r2mLQ+iHno5UxWLMJHYZCK8F89BBbsP71JkbuYgYEtRna296u04rxkrtuRsbCP5KD0tf
         0CvQ==
X-Gm-Message-State: ABy/qLbJgT43VhbobhnsqWa00cuFfZUCv4/Yh33bxppI1NWJMEXdcdT+
	lXUZKWv5lvrtMuom6YkhVo58lpWkpLQHZdAqPaZD5w==
X-Google-Smtp-Source: APBJJlEA6XXGNhhaIC76tTcgLm3kEZx8DMgeZ2OsSbsPjSlPEFYhDSXz3mZgHUwj+BcP5gD/++C59Q==
X-Received: by 2002:a1f:49c4:0:b0:471:b557:12a with SMTP id w187-20020a1f49c4000000b00471b557012amr8691014vka.11.1689176424852;
        Wed, 12 Jul 2023 08:40:24 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:24 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 17/22] selftests: tc-testing: add JSON introspection file directory for P4TC
Date: Wed, 12 Jul 2023 11:39:44 -0400
Message-Id: <20230712153949.6894-18-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
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

Add JSON introspection directory where we'll store the introspection
files necessary when adding table entries in P4TC.

Also add a sample JSON introspection file (ptables.json) which will be
needed by the P4TC table entries test.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../introspection-examples/example_pipe.json  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/introspection-examples/example_pipe.json

diff --git a/tools/testing/selftests/tc-testing/introspection-examples/example_pipe.json b/tools/testing/selftests/tc-testing/introspection-examples/example_pipe.json
new file mode 100644
index 000000000..3cc26fc8d
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/introspection-examples/example_pipe.json
@@ -0,0 +1,92 @@
+{
+    "schema_version" : "1.0.0",
+    "pipeline_name" : "example_pipe",
+    "id" : 22,
+    "tables" : [
+        {
+            "name" : "cb/tname",
+            "id" : 1,
+            "tentries" : 2048,
+            "nummask" : 8,
+            "keysize" : 64,
+            "keyid" : 1,
+            "keyfields" : [
+                {
+                    "id" : 1,
+                    "name" : "srcAddr",
+                    "type" : "ipv4",
+                    "match_type" : "exact",
+                    "bitwidth" : 32
+                },
+                {
+                    "id" : 2,
+                    "name" : "dstAddr",
+                    "type" : "ipv4",
+                    "match_type" : "exact",
+                    "bitwidth" : 32
+                }
+            ],
+            "actions" : [
+            ]
+        },
+        {
+            "name" : "cb/tname2",
+            "id" : 2,
+            "tentries" : 2048,
+            "nummask" : 8,
+            "keysize" : 32,
+            "keyid" : 1,
+            "keyfields" : [
+                {
+                    "id" : 1,
+                    "name" : "srcPort",
+                    "type" : "be16",
+                    "match_type" : "exact",
+                    "bitwidth" : 16
+                },
+                {
+                    "id" : 2,
+                    "name" : "dstPort",
+                    "type" : "be16",
+                    "match_type" : "exact",
+                    "bitwidth" : 16
+                }
+            ],
+            "actions" : [
+            ]
+        },
+        {
+            "name" : "cb/tname3",
+            "id" : 3,
+            "tentries" : 2048,
+            "nummask" : 8,
+            "keysize" : 104,
+            "keyid" : 1,
+            "keyfields" : [
+                {
+                    "id" : 1,
+                    "name" : "randomKey1",
+                    "type" : "bit8",
+                    "match_type" : "exact",
+                    "bitwidth" : 8
+                },
+                {
+                    "id" : 2,
+                    "name" : "randomKey2",
+                    "type" : "bit32",
+                    "match_type" : "exact",
+                    "bitwidth" : 32
+                },
+                {
+                    "id" : 3,
+                    "name" : "randomKey3",
+                    "type" : "bit64",
+                    "match_type" : "exact",
+                    "bitwidth" : 64
+                }
+            ],
+            "actions" : [
+            ]
+        }
+    ]
+}
-- 
2.34.1


