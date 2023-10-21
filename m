Return-Path: <netdev+bounces-43226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE27D1CD0
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C251C21081
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C3DF60;
	Sat, 21 Oct 2023 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ud0PuQXX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E71FC0E
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:24 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09677D6B
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso2465251a12.3
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887641; x=1698492441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RYqVhoUzsNnBmvwHXFNprgWtrEFZ6Qj28ASQZd8V68=;
        b=ud0PuQXX12W631WRxEJwIyJhVxVKk1hGZ5+yaLHb3xhPaGc3JvyOBkTr50pd4ptEDp
         CEQLOju8XhJghrmZEvc7WQiN3pIoLruB97aDCRESRjbjltQXCDI8I+F5rjTsX4+BkJdm
         PnhaVEiHhxWEBdTY2iMyovddIxbd53+vG3e6KCiMiEeIJGJdKSbmIK4WjUG32kRURwPR
         OtN1GXKnUWXxrF+tQ3VHi5n4j9qfF4rcSY16dX9hL4PjiVcjS7Dl0VUFIvoZaRlVTbfi
         unhcCyFVQo+85okw7ldnn/l7CBBZfo/4FLKIlppytidZo90GUhXmypsUpwd33On5GE2o
         CoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887641; x=1698492441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RYqVhoUzsNnBmvwHXFNprgWtrEFZ6Qj28ASQZd8V68=;
        b=dqhxphLq6GrJGlzz+DsgVRjReEHwpEpQoVT9ZKyZgJpE1MOeoavh87HQCZEtz3MhZx
         M7iX+ah+GoXMXZoUNu2J8JilAVht/hW4lOosBf2HLoPWVis3nToACHUPXzZPupPl7Zta
         5y6ndjHvZw1UdBTDInZaIHwSlWX3jtTlOy0kbov2xB5Xn/b+66rj6QtDOIvhzEiS/jYm
         mYItLNcNq/MNZ37aAekf+9wItrOMdoyJnIXxQKVXn0a9le8kPVuOYujAC5EFIqi+ABW1
         vaX8Yg7g4Q24/q/SyuOCNGl6BaCRBbRONoMRHdL8TiymtxJB1AlbmjmtMJW7jnYQvxR7
         ifcw==
X-Gm-Message-State: AOJu0Yy9PCXbzZ6vAO1ehAD6I96M0Rbf9tPzWwXQh2j8k1lAm1r/uzhq
	gxzPp9cvszvc35wznQ9akEY0PVCnIeT7IV8Yd2Y=
X-Google-Smtp-Source: AGHT+IHW6NgOdKjtUI4tBQ78nee+AyTEg7+oaeslJd9ijj3PifZPjmM5fNiaFpBm6CD09C9AoQVZWA==
X-Received: by 2002:a50:a6d5:0:b0:53f:737c:93fe with SMTP id f21-20020a50a6d5000000b0053f737c93femr3203675edc.38.1697887641505;
        Sat, 21 Oct 2023 04:27:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s14-20020a05640217ce00b0053e625da9absm3255450edy.41.2023.10.21.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 05/10] netlink: specs: devlink: make dont-validate single line
Date: Sat, 21 Oct 2023 13:27:06 +0200
Message-ID: <20231021112711.660606-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Make dont-validate field more compact and push it into a single line.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


