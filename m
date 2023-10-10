Return-Path: <netdev+bounces-39520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346347BF93E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B5B1C20F2D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC118AEA;
	Tue, 10 Oct 2023 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kRyyVrBQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BA182CC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:41 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F22B4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad810be221so928481766b.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936118; x=1697540918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVamZVJm2AtqvtRyg+mnijeD62Xg+OMDFuWA82VLJUA=;
        b=kRyyVrBQK/VLduBhT3Ignkd0CT2xk1ROvJdkjTe4EMOJbUW1G0hdfBkOnfUWpF4yTw
         W7cvFotJ2pNOCFvWgyMtGpcxeg0EMNP6CIQhHU5NbMv4lUCHKYeZKkg/VbeQFWK9ApqL
         r+3Tt6Z77vU7igxw2y3xuV6oe7ntPfWiCpXdcUxfpzlJqsa4S8hhQe0meiNE+j45ugeK
         pscGb+oGnxZgq7M3QlYgX5gAyrJxnbJ2f0KlYVMWWFkyYNlZDZELd2sZvz1YYLcq0Fe2
         iBC1KKm/RkI1UonlAoMSz3sQQZKjcmZGa+RnyEhMrpIjCOu1OTVel+TC7FsonyJaNAJm
         yb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936118; x=1697540918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVamZVJm2AtqvtRyg+mnijeD62Xg+OMDFuWA82VLJUA=;
        b=lqjpdBGtPluadXlbmNS3gXKA+04JPv0wE/8WbQPyIIoL40IV145sv7jZpnsJqnzNRn
         tgRsxjQpbIvGB+hZA/FfjuTgCm04rX/956/z0BI5dRjcxM99x/CFWpiRgQm5BhJJs5U4
         iyw88MpiTp7Tg3jzUznoZ7uvDcXZu9113kcyf+X/MJGp1prJ4Yj2ZLjZLKc55NrzcYq5
         ZiNrJzz7G1LFiookWCgV3ZKbJ+tQCqJyPT53H6LmmQVJg0HwftrVJzrUExafs5ecp0/3
         fZsI42OIs7KxMhefbsYvCaCwCMyTdxHiVNX7Zu76j4RWnaGMcIic+FNVR80dVp6eIFWI
         /RyQ==
X-Gm-Message-State: AOJu0YxpZaROO3wZBQJoSFbeaJ/PmYCkVbe6bkNUYxaAXg/8EG7O1kje
	17YjAEni45jbhueM7PqHTA4GuPU1H+LrsckJdng=
X-Google-Smtp-Source: AGHT+IEkuX9w986JyCBNI3h0okIDR10F7btmdjRnN2+wbdHXnADuCqPGpTGiWhprjPM9PI76Zr8tbg==
X-Received: by 2002:a17:906:1dd:b0:9ae:540c:90ef with SMTP id 29-20020a17090601dd00b009ae540c90efmr15823569ejj.18.1696936118197;
        Tue, 10 Oct 2023 04:08:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090619cd00b009ae587ce135sm8232123ejd.223.2023.10.10.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 04/10] netlink: specs: devlink: make dont-validate single line
Date: Tue, 10 Oct 2023 13:08:23 +0200
Message-ID: <20231010110828.200709-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
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

From: Jiri Pirko <jiri@nvidia.com>

Make dont-validate field more compact and push it into a single line.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 67 ++++++------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 08f0ffe72e63..5308cc54cfc1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -245,10 +245,7 @@ operations:
       name: get
       doc: Get devlink instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-        - dump
-
+      dont-validate: [ strict, dump ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -271,9 +268,7 @@ operations:
       name: port-get
       doc: Get devlink port instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -299,9 +294,7 @@ operations:
       name: sb-get
       doc: Get shared buffer instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -325,9 +318,7 @@ operations:
       name: sb-pool-get
       doc: Get shared buffer pool instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -352,9 +343,7 @@ operations:
       name: sb-port-pool-get
       doc: Get shared buffer port-pool combinations and threshold.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -380,9 +369,7 @@ operations:
       name: sb-tc-pool-bind-get
       doc: Get shared buffer port-TC to pool bindings and threshold.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -409,9 +396,7 @@ operations:
       name: param-get
       doc: Get param instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -435,9 +420,7 @@ operations:
       name: region-get
       doc: Get region instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -462,10 +445,7 @@ operations:
       name: info-get
       doc: Get device information, like driver name, hardware and firmware versions etc.
       attribute-set: devlink
-      dont-validate:
-        - strict
-        - dump
-
+      dont-validate: [ strict, dump ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -489,9 +469,7 @@ operations:
       name: health-reporter-get
       doc: Get health reporter instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -514,9 +492,7 @@ operations:
       name: trap-get
       doc: Get trap instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -540,9 +516,7 @@ operations:
       name: trap-group-get
       doc: Get trap group instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -566,9 +540,7 @@ operations:
       name: trap-policer-get
       doc: Get trap policer instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -592,9 +564,7 @@ operations:
       name: rate-get
       doc: Get rate instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -619,9 +589,7 @@ operations:
       name: linecard-get
       doc: Get line card instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-
+      dont-validate: [ strict ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -645,10 +613,7 @@ operations:
       name: selftests-get
       doc: Get device selftest instances.
       attribute-set: devlink
-      dont-validate:
-        - strict
-        - dump
-
+      dont-validate: [ strict, dump ]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
-- 
2.41.0


