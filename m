Return-Path: <netdev+bounces-39454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472B7BF4AE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FD91C20AF1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9BFBFA;
	Tue, 10 Oct 2023 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rG0Wy0yw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21087FBEC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:48:15 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141849E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:48:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d3755214dso162735f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696924092; x=1697528892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcOwdRsQKp7A6HqwjVHNg6aZdJbfVW2XhERMI6uJp4c=;
        b=rG0Wy0yw0IZ7+bJkU2+IDlZ74l5ku+/LDa0QvDHvWCsoEdaErs+h+ejEt+wjVzzvEI
         6XClUa+ItoTFinwEN/y3vVfnihvqL4xejddjnU0IQD9CDDyxHE2M1Io0VfyhBmYtEktv
         MVF5fi0YzQBmxzkfGzb6Ae3VRutV2FlTd6UFkqGIncdlmURr89ndnsyPFe2wEc8mUNDp
         YNasKXJLrvfmtj4os11RTRhfytoMF9NdaBeCHz0c9/AfrxBDKUPOYNpVhFSkmWWezg/5
         zcp5otqMYCiEiG5NddgfqibluAQ69FqFYU/2UQ/cN6zN80qlBkybU4Ch4QPgAeFKGbeB
         4Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696924092; x=1697528892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcOwdRsQKp7A6HqwjVHNg6aZdJbfVW2XhERMI6uJp4c=;
        b=CqQplbwFIgKWa0xmJErQs+E275IRHtx9ZhkPgK/OBsIb11jhr8zHVoEERH3J0zJkkI
         bOCk5h25AM4iYoSTaOOoPr7/jjWwtGSrFji4DMQREADivjGe/D7GwqVttfo8hCiUEZOV
         nbPjRHT/XFlN+aj5Em3erJEPmqNcC9FPdLplcxFVU3pL/87ZXsK0hB1kjzMN5ceAHSXm
         iUtJK00ndc6hSq3u0VUAD6gRuLKPLNXdI3DFBykUS1d1PK3JKyMwH29loo8h1vkxwl32
         GeSWgpB7IjeSd5TnPmt78s7MrqbjaetlysOdnMSfxrmPz8v+WV1p1fGDyWvP1UocrfqT
         iEQQ==
X-Gm-Message-State: AOJu0Ywz0TRAINB0rtpaylojGdIxAFdM+ECw5CBmDsaQS+LrUeN6jvNf
	raQ0MAGC1k6snT/6cUZrZwuAbfVRCVSP/TxM0eM=
X-Google-Smtp-Source: AGHT+IGpWR7gnfUW3TNbueEcvu7uh/VIolD8vk7aSySvyJVa7miZ5CNk1f7FX6usYFj1dI13bnIqgA==
X-Received: by 2002:a05:6000:1a50:b0:314:1b4d:bb27 with SMTP id t16-20020a0560001a5000b003141b4dbb27mr14973520wry.64.1696924092390;
        Tue, 10 Oct 2023 00:48:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k17-20020adff291000000b003143867d2ebsm11810684wro.63.2023.10.10.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:48:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2] netlink: specs: don't allow version to be specified for genetlink
Date: Tue, 10 Oct 2023 09:48:10 +0200
Message-ID: <20231010074810.191177-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
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

There is no good reason to specify the version for new protocols.
Forbid it in genetlink schema.

If the future proves me wrong, this restriction could be easily lifted.

Move the version definition in between legacy properties
in genetlink-legacy.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added genetlink-c bits
---
 Documentation/netlink/genetlink-c.yaml      | 4 ----
 Documentation/netlink/genetlink-legacy.yaml | 8 ++++----
 Documentation/netlink/genetlink.yaml        | 4 ----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 32736b2d8ae8..f9366aaddd21 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -26,10 +26,6 @@ properties:
     type: string
   doc:
     type: string
-  version:
-    description: Generic Netlink family version. Default is 1.
-    type: integer
-    minimum: 1
   protocol:
     description: Schema compatibility level. Default is "genetlink".
     enum: [ genetlink, genetlink-c ]
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 25fe1379b180..a6a490333a1a 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -26,10 +26,6 @@ properties:
     type: string
   doc:
     type: string
-  version:
-    description: Generic Netlink family version. Default is 1.
-    type: integer
-    minimum: 1
   protocol:
     description: Schema compatibility level. Default is "genetlink".
     enum: [ genetlink, genetlink-c, genetlink-legacy ] # Trim
@@ -53,6 +49,10 @@ properties:
       Defines if the input policy in the kernel is global, per-operation, or split per operation type.
       Default is split.
     enum: [ split, per-op, global ]
+  version:
+    description: Generic Netlink family version. Default is 1.
+    type: integer
+    minimum: 1
   # End genetlink-legacy
 
   definitions:
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 6ea1c947ce51..2b788e607a14 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -26,10 +26,6 @@ properties:
     type: string
   doc:
     type: string
-  version:
-    description: Generic Netlink family version. Default is 1.
-    type: integer
-    minimum: 1
   protocol:
     description: Schema compatibility level. Default is "genetlink".
     enum: [ genetlink ]
-- 
2.41.0


