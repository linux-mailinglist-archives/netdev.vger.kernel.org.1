Return-Path: <netdev+bounces-42936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D827D0B79
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2011CB216A7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CB12E60;
	Fri, 20 Oct 2023 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="14+nng4G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2112E72
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:47 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B21981
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99de884ad25so89084766b.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793687; x=1698398487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGSMwjk+6cVpik+pCr+FJmvPyJ/4yqFHddmnFAdyJHA=;
        b=14+nng4GOFkUscbDc0N6T4eSlK10NXfb3p6IFE8OJLnBou5zQ9CrpcsahrleFWjbsM
         K9OrmAs/kL6Eo1mYeRkzklYRxbz64nPQD0Mpp1+0/RH4uWMyxFqDRzMMjN4YCD7CluWn
         AbnOcUeYEBUojOxhOn8/sl/5MNWVHPXgK+mxTyYwYALZlbLniFc/SQSqHiKBW40Sv20v
         +jPSxCpS8GUi3rO3Fq2h3r3yAVeONFlBQY/DGVBaLgITNVtcmOOwCc2Nkouwo2lz4nh0
         BbiV7oBmMPx/8wPhk9zaCR+SYEfCKTbrtfjHAyowCh3yvx4yPHDqq33T7LgnoWzUydD4
         LZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793687; x=1698398487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGSMwjk+6cVpik+pCr+FJmvPyJ/4yqFHddmnFAdyJHA=;
        b=RrtozNvtXNeedmuOTr0Pk7vMJB2qis4X+IzbQOYBDFwt6U08YxzDpE0U4X8zA78fhE
         sWVm/HqSNLrcs8CkGTVUld+Qn+9YMduDgs6tGY+gL/9d46vyfWv4898SxyYimgASxWa6
         l5C+0So4yRpoAAERzB8IH6I6I6dukgG3EXsnvk1ogWqQXNQldnYtBbx8muDQ4aNkRyiY
         cxkywxdfKHml+5nbeaza8dxr8y/Y9RGwSF9bn/JkaxACMv0zu9F01Q5s3KmRrFRqD0Nk
         7f61CCQzPn6Ej4B12HlXcoEurmCNRYI4HYiWTWp9gSxyKPQqpZf4Ngs7Bkowd5XYN7Y1
         qtZw==
X-Gm-Message-State: AOJu0Yzhw+JMBdcsRkv9I31EtSuDLoI2tCke+nEN4+kKERb+if08mnDY
	yn2QYWJP0FEFixtIXGHlWM7yY80mdplnh2rzw2M=
X-Google-Smtp-Source: AGHT+IGKuImX9hCVTkGgddE1y31haRad9vTWoyWw5iEUnYz/y9ip+WGQwWJvyMfGdBOFgfSlWioSqQ==
X-Received: by 2002:a17:906:db09:b0:9be:c2cd:aa29 with SMTP id xj9-20020a170906db0900b009bec2cdaa29mr569091ejb.77.1697793687478;
        Fri, 20 Oct 2023 02:21:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906348f00b009c387ff67bdsm1104077ejb.22.2023.10.20.02.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:27 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 05/10] netlink: specs: devlink: make dont-validate single line
Date: Fri, 20 Oct 2023 11:21:12 +0200
Message-ID: <20231020092117.622431-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Make dont-validate field more compact and push it into a single line.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 67 ++++++------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 94a1ca10f5fc..dd035a8f5eb4 100644
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


