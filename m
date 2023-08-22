Return-Path: <netdev+bounces-29779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D8784AB0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95811281178
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11734CD9;
	Tue, 22 Aug 2023 19:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9261DDE3
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:23 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50215CD0;
	Tue, 22 Aug 2023 12:43:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fee17aebc8so34442255e9.0;
        Tue, 22 Aug 2023 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733399; x=1693338199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzgGtNlOM1cvqfWM/EJhHUGF+FWBrjyYnlJyMWp5WUE=;
        b=dwDNJI1ULXjkF5FGBz8rCa1LjKoonGjAmkvHdQFSC+V/87qhuhf3w3QtA+4cms2B1S
         Xf15WpqvMAZGkCc+Yr64Z8ZHbE/HcEJosM3Qx+i3Hjn48xzKffMlxdzoU19OSJmxW/rX
         y0dfOL3SadtNec6qmeGRKmLQptte4zqCHZOegKACgfFaYF4ROIU1m4zrJa7lWS4U4Pr4
         s3atbN/05O5WP2TtQEier/fTQwePPOHHJb2RhiLI967Qm/0GXnMvGX1LCP88DXbYUfIk
         ZoNm6SFTiZX1kGNcPYXz3NAm6aaicuHHMWiXOym48SK2RNppkZz/sX2vqnmsAIQUYroK
         ERRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733399; x=1693338199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzgGtNlOM1cvqfWM/EJhHUGF+FWBrjyYnlJyMWp5WUE=;
        b=Mrz9RQqcHOPkZMPCgxfC72ZQ6nB227Avw3Bi2Ql4lTtQvqwgBQXu4CCLbaYsIxotj5
         qMGtuyQfIckK9q5VWEObJLIdGUmeV0UonHPU6fr2tU6J289XK0vLPBtxo67Rn3i3g/2g
         nd5EebeOz94Rv21vQ4U6h3ZNB58jxw+sk9+Ip1veT/PR0vWck+OMmVJItFFhuSJ2pj7X
         ArGDt3fdyoHeTsVjkyjC2P2LcFLJd+fT83iGNjvZ4qszBuqcibVKb5cXkUp2XTwbCSrf
         AhXtYNdQ7F7btQluSX+P4Eh4CTUN9m8Z8jherKz63qq/18Yw5ud2KSq/ZcJkfULnfkfO
         xatA==
X-Gm-Message-State: AOJu0YyEGaunyOjRTlxDSE8Dlbu1Jk54Hwi1EYDFPIVi+7PWAYm6UtzQ
	ohSF3XA7fuV+sZyDSMaTRsiyR3ouDgzmog==
X-Google-Smtp-Source: AGHT+IGtQK6gim551dXhgnCESuCzs5biKVt9CQqusmN2pWGMkGBzj7gGvULnYq/LphaMSFDTERnpOQ==
X-Received: by 2002:a1c:4c15:0:b0:3fe:266f:fe28 with SMTP id z21-20020a1c4c15000000b003fe266ffe28mr8433849wmf.14.1692733399063;
        Tue, 22 Aug 2023 12:43:19 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 01/12] doc/netlink: Fix typo in genetlink-* schemas
Date: Tue, 22 Aug 2023 20:42:53 +0100
Message-ID: <20230822194304.87488-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822194304.87488-1-donald.hunter@gmail.com>
References: <20230822194304.87488-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix typo verion -> version in genetlink-c and genetlink-legacy.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4c1f8c22627b..9806c44f604c 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -41,7 +41,7 @@ properties:
     description: Name of the define for the family name.
     type: string
   c-version-name:
-    description: Name of the define for the verion of the family.
+    description: Name of the define for the version of the family.
     type: string
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 196076dfa309..12a0a045605d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -41,7 +41,7 @@ properties:
     description: Name of the define for the family name.
     type: string
   c-version-name:
-    description: Name of the define for the verion of the family.
+    description: Name of the define for the version of the family.
     type: string
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
-- 
2.41.0


