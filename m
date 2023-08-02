Return-Path: <netdev+bounces-23675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28876D1AD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625751C212C8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAF8C02;
	Wed,  2 Aug 2023 15:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB38460
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:08 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A24C06
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so74558245e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989627; x=1691594427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN4tj6ro1FneEJbRj7B8hPejpVe40Jja+XIMGYax1bc=;
        b=uX+6pPpAIRAZwmYRuQdsRxjDdm6t8phXmddpI5wFFk5cmZHtnUzGtQu5z69ic1+/f7
         rnk+tTRaCMcG4sH8CqO4sRCXXCLvpkhIJZoAfKY9r9gB5SHBcTszWYLkmoFXytMunyFH
         IKucltjolF71d7u6C7ncL1+RGD1P91svUEj3FcjJRWXjQcR+5QDt+SNEhiL9DdAxqMTL
         KE2XleJ2L625SM99h96/Ts/z/G7nxD47RQ4qccJzo8eTgQly5MtepVLGPP+la0wu25wk
         ug9m0gHONGHFK1Tlfl3lgSAB1nx4gxGOEaLKWCXm2pyB4YmHFxyJRJKm+at0Zk5n1HlS
         L9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989627; x=1691594427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4tj6ro1FneEJbRj7B8hPejpVe40Jja+XIMGYax1bc=;
        b=dlIiYgWlEu7HmROYPlv15WKjgglZ2nhko7GL7JWdgXZqff7J+Kzqbt6GgBnumvQxxo
         pWRbTeM7xA+Rxask6gX37ZbNjzRFHGV4Wg25C45xfXyGU90aCKXLSUE3+tYhlxjYhvot
         RV8LF0hhC3MXHQALbhSGuosbYCFfWClZQC9o0p0m6pB4tPOVvd04vWpRQ1s7ZMaC+I1a
         mDfZWCKaUNOCHTzheLe8Ib30n0px036f0B7MiYupWdHGRSZXB/kUvss9GJ07ef+zDzoi
         e10OkEIiqCPjrd/RGqUmmnaBxOlhBiorIUbXZwK/Hi6P6nXWCgV/A2GZvr4fQwTMiu+O
         7iEw==
X-Gm-Message-State: ABy/qLa7wqyzY+OfrKUwM/oYvsNHH9BJiiDmVvg4ETIf+d5TzWlfjB8G
	SQpDHcP/gQJz6eukdqmuuw9FjvBdCPCKTFQLHop2UQ==
X-Google-Smtp-Source: APBJJlFDH5piI9ZE7C8Tu+4uRfLFN48R7fZPB/Od9D9a0vHGrbfT5g3XfN+FtzMJN0Z8Ds/2GmDkGQ==
X-Received: by 2002:a1c:7419:0:b0:3fb:e2af:49f6 with SMTP id p25-20020a1c7419000000b003fbe2af49f6mr4808926wmc.39.1690989627526;
        Wed, 02 Aug 2023 08:20:27 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d4b4a000000b003176c6e87b1sm18877760wrs.81.2023.08.02.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 01/11] netlink: specs: add dump-strict flag for dont-validate property
Date: Wed,  2 Aug 2023 17:20:13 +0200
Message-ID: <20230802152023.941837-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
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

From: Jiri Pirko <jiri@nvidia.com>

Allow user to specify GENL_DONT_VALIDATE_DUMP_STRICT flag for validation
and add this flag to netlink spec schema.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 57d1c1c4918f..4c1f8c22627b 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -274,7 +274,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             do: &subop-type
               description: Main command handler.
               type: object
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 43b769c98fb2..196076dfa309 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -321,7 +321,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             # Start genetlink-legacy
             fixed-header: *fixed-header
             # End genetlink-legacy
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 1cbb448d2f1c..3d338c48bf21 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -243,7 +243,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             do: &subop-type
               description: Main command handler.
               type: object
-- 
2.41.0


