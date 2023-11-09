Return-Path: <netdev+bounces-46954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A07E7560
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1581C20B9E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC38FB4;
	Thu,  9 Nov 2023 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwO7IGYq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF638FAD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:59:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C0420B
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:59:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b31e000e97so20310977b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699574361; x=1700179161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSg0N0Mojefdt17Wf3Jz8MW1Fxcg76vDk/15T+gqDos=;
        b=OwO7IGYqncvdS80JjHhLhlXUOuPYlvyocfLVj+ue+x2PRzhRcY+ipKEggwfZqW8hzu
         XmYS5gVd548sxX/vBaeC8oh7AvGB24EBywqJZtsH/m4QA3Jlaqf7JH2uJBViUKKWNCZS
         0RnbMrLxbeL0hFIiUOmaHR7NMar8B0fOaxT1HNuapEQvIO9bd45+8LNDWfjKboQM5D0S
         z6sCp/8ZkAeZ1PRndnsvumI/mAa6PVNHNENty00Yq3YFJhMofyVzSMh9544xP4Z4DZrb
         askw3fr3SO8fMaqIV4XsNONN/RO2Il3U78Ci1VtXclZTFJw8U+ZNrGvSLg1H0t9Gf7eS
         z+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574361; x=1700179161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSg0N0Mojefdt17Wf3Jz8MW1Fxcg76vDk/15T+gqDos=;
        b=whL/qIQCLQOwWVY8VrsO78N2ulxwhuiH5o942+J13wO58QiQJYnx9XKqt7KTC9fStX
         p4140TggfT+0+X72n+II/J0IZ8zMQLUGOCVWJgP1sDK/kXgVp5gz6RWhCYBOfZobtixX
         2T1IGlmQZsiSGkNzRLC3AOQxKlZwbCrhojy0u+Hjf/RCTGjE5G0QtQdThOZNPvlbojBP
         Nl8mS47q8Io4vMwJDcUKnUlMTodbMz6LsFelntvQ1NYsXodmc7WRx7cNzHd+8CPz4lE/
         ABe0eXlBR0YWwQ9QvXK9sSghUrraqOWPR+PPCtyq36/Lo6J3gDTG9ME9L3q592WuACwW
         N+kw==
X-Gm-Message-State: AOJu0YyjMxuYZmGsEjjodmHO996CsPps2wL8cltMm+Vm3th8GYnSsUIT
	lYL5nJBZUztoGUrBfg3l2Lwh5kCwM3/YkLOeWM5xHkpHgGNcluh0fJPm/n5dDd2Z1AfYVKaqUoh
	+EuoFmYeRy9gBippiVE/lov4KT+ea5iuaLDMtYvwkn/oLF3anAv2UhWgspXcxqI2TkW7Ezw==
X-Google-Smtp-Source: AGHT+IHHFhQdev/ZwFvJAFYtdoIXRTCGyhjCrtOe3sM3GJbuymWuYcsT7Bobo8LKrj0uNMjPnVofsl8VtEsKxX4=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:b167:fc3a:73b5:f1e6])
 (user=ziweixiao job=sendgmr) by 2002:a0d:d7c9:0:b0:59b:c811:a709 with SMTP id
 z192-20020a0dd7c9000000b0059bc811a709mr184258ywd.0.1699574361048; Thu, 09 Nov
 2023 15:59:21 -0800 (PST)
Date: Thu,  9 Nov 2023 15:59:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231109235916.1105860-1-ziweixiao@google.com>
Subject: [PATCH net] gve: Fixes for napi_poll when budget is 0
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

Netpoll will explicilty pass the polling call with a budget of 0 to
indicate it's clearing the Tx path only. For the gve_rx_poll and
gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
to do all the work. Add check to avoid the rx path and xdp path being
called when budget is 0. And also add check to avoid napi_complete_done
being triggered when budget is 0 for netpoll.

Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 10 +++++-----
 drivers/net/ethernet/google/gve/gve_rx.c   |  4 ----
 drivers/net/ethernet/google/gve/gve_tx.c   |  4 ----
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 276f996f95dc..5a84ccfd3423 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -254,16 +254,16 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
 	if (block->tx) {
 		if (block->tx->q_num < priv->tx_cfg.num_queues)
 			reschedule |= gve_tx_poll(block, budget);
-		else
+		else if (budget)
 			reschedule |= gve_xdp_poll(block, budget);
 	}
 
-	if (block->rx) {
+	if (block->rx && budget > 0) {
 		work_done = gve_rx_poll(block, budget);
 		reschedule |= work_done == budget;
 	}
 
-	if (reschedule)
+	if (reschedule || budget == 0)
 		return budget;
 
        /* Complete processing - don't unmask irq if busy polling is enabled */
@@ -298,12 +298,12 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	if (block->tx)
 		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
 
-	if (block->rx) {
+	if (block->rx && budget > 0) {
 		work_done = gve_rx_poll_dqo(block, budget);
 		reschedule |= work_done == budget;
 	}
 
-	if (reschedule)
+	if (reschedule || budget == 0)
 		return budget;
 
 	if (likely(napi_complete_done(napi, work_done))) {
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index e84a066aa1a4..73655347902d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -1007,10 +1007,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
 
 	feat = block->napi.dev->features;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	if (budget > 0)
 		work_done = gve_clean_rx_done(rx, budget, feat);
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 6957a865cff3..9f6ffc4a54f0 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -925,10 +925,6 @@ bool gve_xdp_poll(struct gve_notify_block *block, int budget)
 	bool repoll;
 	u32 to_do;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	/* Find out how much work there is to be done */
 	nic_done = gve_tx_load_event_counter(priv, tx);
 	to_do = min_t(u32, (nic_done - tx->done), budget);
-- 
2.43.0.rc0.421.g78406f8d94-goog


