Return-Path: <netdev+bounces-30594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC87882B4
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E657A1C20F5C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1160C8F8;
	Fri, 25 Aug 2023 08:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5AC8D7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:42 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462431BF2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso9477281fa.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953619; x=1693558419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54ao4xaeANf4rYkAGw85Jng+0pqwuC1IeOIbZUJzqJU=;
        b=SD6zi5hdP37v7XK2WXOyGSuCWPPkf1xM4cgm3BQoMwSGbIV6Tfg51HeO7J3ZHH3wM/
         bWZB9dVgyQ26S9TTeJplZISCJzPBS5zYHF3894MPbjWZYP42rgX9yo1f0NAt5V7+Y49W
         c65e+Dkefoe16rNrvtu8/BjhrctBRgQDPAvWTxZGcf3wn3sdbGWI8qwflSN7GT15lzkf
         p9dnYJj8TMduUMWz5stBJhHyZy5MKWZdMFrrN7g7oLBrzMMfjnbsUmHDldL2DUv/sKz6
         IJx//ZuIiaV7CIfo8ZLZFbd4203f/0AbDJ6TJtC8wm+R3tFnPrmh7c2Kl2qbz+3RlQ4m
         Kt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953619; x=1693558419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54ao4xaeANf4rYkAGw85Jng+0pqwuC1IeOIbZUJzqJU=;
        b=j8M5J+4WJ9R2DuiBXNHwP4gcffMI3bKVsxRo1sSik86rxYlPwVLUMvtpyDJFnX//lw
         O/m+9B4xeUDs+ev74k58Ua30Abqwsea6sEbovqu/5BURGyXjREgMRgc9F9v6D79PqqVk
         PdqG7zCXr1xNClTRPo3av869X8UoPXG/urjF/Y7lUn6xlWpaNrZ4igC6qqwNptRgCUN8
         L89BDWnnwZ3Ej/BBGPQaw8lPE1UiYhtggAcLNaBM9pyYNsmaWCuLjaMAE1/kze8UofDb
         NekKOEAMEpJu4EPzrRh7WkwsjgEQd8bLjlYyimN/+sjqrVTjEFP56sXg3IQgXiuWvxMP
         R1vA==
X-Gm-Message-State: AOJu0Yz79wQx5BYgAk6Fvc1llVTIPYr7m87Ls8JLPRIRjTeQarhVyHT3
	QHoYYYA/GRJoRSxZCuFIewd+2knEHjYyyfhsGERjUhPd
X-Google-Smtp-Source: AGHT+IGTBYua2Xwf2CU9NQ1ZFvOzOaNwGZX+pM8UpYQrJeyTLCtSCrANcPrWe+obta0/oKaAmdIzKw==
X-Received: by 2002:a2e:920b:0:b0:2bb:a06d:1d3c with SMTP id k11-20020a2e920b000000b002bba06d1d3cmr13060421ljg.24.1692953619586;
        Fri, 25 Aug 2023 01:53:39 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003fee849df23sm1593076wmi.22.2023.08.25.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 09/15] devlink: use tracepoint_enabled() helper
Date: Fri, 25 Aug 2023 10:53:15 +0200
Message-ID: <20230825085321.178134-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
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

In preparation for the trap code move, use tracepoint_enabled() helper
instead of trace_devlink_trap_report_enabled() which would not be
defined in that scope.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 6d31aaee8ce8..1db3a7928465 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -3131,7 +3131,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 	devlink_trap_stats_update(trap_item->stats, skb->len);
 	devlink_trap_stats_update(trap_item->group_item->stats, skb->len);
 
-	if (trace_devlink_trap_report_enabled()) {
+	if (tracepoint_enabled(devlink_trap_report)) {
 		struct devlink_trap_metadata metadata = {};
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
-- 
2.41.0


