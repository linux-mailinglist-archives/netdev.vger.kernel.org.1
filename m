Return-Path: <netdev+bounces-23175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805FE76B392
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B137C1C203BD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE623BDF;
	Tue,  1 Aug 2023 11:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957423BDD
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:49 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3030E43
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so30971826d6.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889927; x=1691494727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=exk+gaawJHJTaXDDetOtj9qmEUE9xRU9yayOmZfO0WTTNDHbwiPukorANVtpC0Dx+f
         aJFNqWCvzwvK+lamhLpXrm5IB84Mc6pFqfeM70HxrRjxQNpJCe+eEYdU7Ce3nOUdWP0a
         rObp+oIMHduNfDFSyWCFyRDmmTHqb9gRhqqCs8IP6siQt/tf0yIWusA6wFQ4/M80/kcm
         lEWYTc16vEFOsnf9C3Se4dz+sVT88zJze1hRxDVqy0SEIdYdRcNEH58pb8+YpnTKC/P1
         41jZEBKQePn1uU5NyR2WFh3SDRWNurT1bBCTe/i6puOajg0qfK4g4botUMxpTdJAZGPG
         UB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889927; x=1691494727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=VU5+IOow+xWGbEKT96zvLELQhARCR0cXjBj2ROs9PjxX8S6rQjRLTax3LkBGrASlc+
         jgbT65W8J9cwUsrSpvDuZj0uhoUZwWeaGEF7NHASAJkqY5qaojXvD/EONAc2tLDMgvM5
         g+LGa+JAZT7lclMEzernaA61J3WoiJ78lSOCnwZwmJcmcYj7zMl7pAoW6bLJln3+NqpI
         bfRpfHFYw5CAKlMEFZXCwAxLJ8SDT6dQK7hFJ5hLSmFB62c+pbJKqlYpUL/h+CeiFKhm
         LBHmnrEKggDupSG61jJWTzxLTE2LGItwnz5q3A+dC2tdYfWOjd0qWU3oVNCFlRjB7KFl
         4gnw==
X-Gm-Message-State: ABy/qLZhQjEi9/afKS4igaZkkgMnm7fGQAPR3YDkr2dSVpw/IeK+7wdo
	PePxiopG/R/Nxwig5gt/lrdQGfqteQxtndH/RgEmpQ==
X-Google-Smtp-Source: APBJJlFXS6oRTJNcmI1rrDA5K3BUNkqEJ2cW5KYEiP9mPxOSsdo6qmlR0QS/+E+YhdckAIGTP+Rfag==
X-Received: by 2002:a0c:f5d4:0:b0:63d:55e7:91f2 with SMTP id q20-20020a0cf5d4000000b0063d55e791f2mr11963023qvm.28.1690889926753;
        Tue, 01 Aug 2023 04:38:46 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:45 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 18/23] selftests: tc-testing: add JSON introspection file directory for P4TC
Date: Tue,  1 Aug 2023 07:38:02 -0400
Message-Id: <20230801113807.85473-19-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
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


