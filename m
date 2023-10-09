Return-Path: <netdev+bounces-39210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876E7BE556
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A38C1C2093D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFB374D3;
	Mon,  9 Oct 2023 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rObgtplN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD5199CC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:49:13 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF4AF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:49:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53b962f09e0so3170602a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696866549; x=1697471349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAN2BBazEQn9dft0Mj7F2GQVpsBxm1KWr274PiTJYRQ=;
        b=rObgtplNOUjgXhvqMDyvfGvAkiM2OH73843WCRn4qkWULrAPuGqj4DN6KEw+gNwX8K
         Px0X9LIeJYmt4HbCEjj5eQ3dWJln5sCvkSVAxPWoPHwyQi4JL+SSKN0HObLt1yEjHBL3
         o9RvPKAlFXvbaasg0tDBFUlJALOp/nLasiV2+DYpp8xYaYfbmtBVgVkjjmtidvbEX3Rn
         JAcePXrdPRUKZ3IPpVSBiZUD+uK9xyszn+PrJR1Q9OO47MneLKUel9ywgdMO1V4cKRKR
         dUgXYg19IpaE2ROwPtZu3IQtGYLDdHH0c1Af5X+vD2i9mBPsacYSMSrjN5DCD7xvSCu6
         /0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866549; x=1697471349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAN2BBazEQn9dft0Mj7F2GQVpsBxm1KWr274PiTJYRQ=;
        b=kXq99QiYXNfz/MqBVbJG85Z1Ut3Z27BUW+KdBW2bg8uQBbDSzeP2lip/nMwWnAQe0E
         7gBq2Hd43ttYBuus4ATkzKGtowjX1Zg9WNeh4Yuh5JT5QKatcdRndN9D30GRiSMMOR6E
         pb79RkxJ1Dxh45pcDOIpPIm1ZvvzAUC0CvQaB2XVKf5Zy3wbgQbjEGkwFBpUTzPSEtIn
         tWuJ2hMCa1b97IIoua6PUQvYbgcd1zKh/z+PLwoZmRPfZX8hE6nMQLbyjjdbPFLSLRoa
         H6AlQ/Hi5WkfmwwSS/dvSm5HevuuXWfg9xMfZS1m1vIYWJoxH2/PbkS8pCyuRvGSC4m5
         0tTw==
X-Gm-Message-State: AOJu0YwGSvAL1U77wTfmGMCjpi9llpfwROCucxNoL2MZZZW/jNj212es
	Ccb3qGNaJOt0m5v+7sit0nYFVbHIbu+eF6BifXY=
X-Google-Smtp-Source: AGHT+IH3RysIpF7p1oFH2gbiwhNqP9HsCTXYLbIMm1VrKOyKubDUROAEXv5hsTeV1Rq7BR1zewzGrw==
X-Received: by 2002:aa7:d501:0:b0:52f:2bd3:6f4d with SMTP id y1-20020aa7d501000000b0052f2bd36f4dmr14984508edq.0.1696866549491;
        Mon, 09 Oct 2023 08:49:09 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g8-20020a50ee08000000b0053490ca10e3sm6143351eds.62.2023.10.09.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:49:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] netlink: specs: don't allow version to be specified for genetlink
Date: Mon,  9 Oct 2023 17:49:07 +0200
Message-ID: <20231009154907.169117-1-jiri@resnulli.us>
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
 Documentation/netlink/genetlink-legacy.yaml | 8 ++++----
 Documentation/netlink/genetlink.yaml        | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..6300222f6c84 100644
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
index 3d338c48bf21..f1427d7e3b4a 100644
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


