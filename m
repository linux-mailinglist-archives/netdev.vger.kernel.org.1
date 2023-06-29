Return-Path: <netdev+bounces-14535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F374244B
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E58280E04
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA916419;
	Thu, 29 Jun 2023 10:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD816408
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:13 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5731BE8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3fde8e4d321so4309811cf.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035571; x=1690627571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=mC2t/5Qhw9ly5st+1PQIOUZPSbQ+2v98dzzRDGiasmR5tNluU70hVIGIGcMHXNIdgT
         vnDtMKEonFAleiNPBVr4ueFWQIFgzTNv413n8qtzEStGP5UfFinmrteQLOgVz0eTPRkS
         QqOdKO6W+EOgkQGjctuaTzeTFJvQwkTBd6YEKnEuyKAFZETrRTc/tb+4nycvC7aMqtvk
         jPZV1wBDo41LbaCDvrqup0DDYanCOveXGxQKPYsQx/dqs7Q9G1zZKfFKATNuoRC/42fE
         Pbpt4MKGnTUqX+v6tkvox1pr89OBGBFthZFkrWCbXrLwaffElrvSfnlEyFp1nbhIdIWl
         9Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035571; x=1690627571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bmaq8sSqJGX0MiTMkY+yfMqcY2Y7Ml7OWq0+ubiQUA=;
        b=Z7oXHs4iM1Us7zm4uE4xtdh3WKfq2FyuQUwn6M+p6UUlHfzrLpssfwz2GXp2nGTqV+
         xW77WlGzd5b6pi2o8PuPBKvDUMfNtkWBFRjMqD4il6Yh+aoGqet4WqX+ys9fFwXaKxy0
         7P0NmFjrfXr1+qHHkF0h+ZhpAO2dHzN9hQBK16Xo3/QfFv62x7sAMMiKAZvHk/a4qyXg
         AMTK9XTzVwSgHE+KzDTZSi8eMXckHeQDbk6FxnR3Mfa/GIel7qUd1RyF/6/7D3JmiePm
         9Aarws2fqELDnJTYtufEqjoji6yzt+Ti/kB8ox1t2dz8QFK7t4MbUSk4r/WUxhBDpGTZ
         V4Nw==
X-Gm-Message-State: AC+VfDybt/J8DMgqA+Di6y6dHr5EDfeIballkn1YZjjwyMtMXiFfGaxz
	552tMgUqZa0Rr7CI8djurSgy7AOfKtXt95IEbFs=
X-Google-Smtp-Source: ACHHUZ7W3nNkiVssPlUW5l55c52Dr+kpYIoIdzWJkx1qi6Ws8gGtlrFgursO0GVn5svIJNPJ15dUMg==
X-Received: by 2002:a05:6214:258c:b0:62f:e0e1:478e with SMTP id fq12-20020a056214258c00b0062fe0e1478emr43765003qvb.63.1688035570968;
        Thu, 29 Jun 2023 03:46:10 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:46:10 -0700 (PDT)
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
	kernel@mojatatu.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 16/21] selftests: tc-testing: add JSON introspection file directory for P4TC
Date: Thu, 29 Jun 2023 06:45:33 -0400
Message-Id: <20230629104538.40863-17-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629104538.40863-1-jhs@mojatatu.com>
References: <20230629104538.40863-1-jhs@mojatatu.com>
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


