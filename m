Return-Path: <netdev+bounces-116025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4329948D3E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30571C236A4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544221C2312;
	Tue,  6 Aug 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V84xQF8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCD1C2311
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941529; cv=none; b=jtWvCAly1xOP/C+EOLvw+FmvjHadqgiwdp1h3Pn2z0u1SvePYjLYvYv3xsHe99JFj90hADMQufp4ova8hATaXTM63BVj+ZfwI3rlN3HaZROAWrq2fYYLKrSD79UcJQ9ZT5wOguQmbF+38LvKIjJE/GOo/TZACqNQYzmtPDGrR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941529; c=relaxed/simple;
	bh=+al5FmN+16P24jfwWkecabgEd+xqc7Jwsjs9HXuUbLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hcK2gF9sjYKtGyx0osGzwl+DvWXC1Rqwh6lVpXACb/pZldnpV2KvqMxLRPv1Z0fu6s8OryPaRb1S/xbxOsVyEvbRnshX9Ae359K/VCYH35m2RjzYapfC+a6+gr5x2bPkv9wq6oGPdwFGHFwyWAzWG0o2j9rH2jagx/uACUz4t7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V84xQF8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A801C32786;
	Tue,  6 Aug 2024 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941528;
	bh=+al5FmN+16P24jfwWkecabgEd+xqc7Jwsjs9HXuUbLk=;
	h=From:Date:Subject:To:Cc:From;
	b=V84xQF8WVMRn5GhPF31w6xnhf43JeB3DthohuV5AVuCLVj88AtBm6+BTKq8fkyReE
	 WcaMuePO+aQn+mODpPaKBKFG9zt2JiIQAUyWJ3sKq2mYfNALh607fH+UiGmnKcJZqZ
	 L5fVHFawgDE0fJuMMaVCfv9cSqv5HC6dE067ZlC5hYzi9rpucGdBHHMzsBVDWjzS/x
	 5980q/y7dTm7s9ez/ZKetHlv6XXTMPaKq0oTcH1oeO2BZOfUdm7zOl3C6+3F/aA5wi
	 RWkMvfsDJm6VcP5e30cMNBLYyAuT9dTo5CVlRbxSZJU++lzl+RT7sRehkuy1qjn4F8
	 UCiro8FbDQiqw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 06 Aug 2024 11:52:01 +0100
Subject: [PATCH net-next] net: stmmac: xgmac: use const char arrays for
 string constants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xgmac-const-char-arrays-v1-1-8d91ec885d45@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFAAsmYC/x2MQQqDMBAAvyJ77kJMQyP9ivQQ49buoavsBomIf
 2/ocWBmTjBSJoNnd4LSzsarNOhvHeRPkoWQ58bgnQ9ucA+syzdlzKtYwWYoJtV0GIbYz8Pdxyn
 EDK3elN5c/+cRhAoK1QKv6/oBrfzMJnMAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.0

Jiri Slaby advises me that the preferred mechanism for declaring
string constants is static char arrays, so use that here.

This mostly reverts
commit 1692b9775e74 ("net: stmmac: xgmac: use #define for string constants")

That commit was a fix for
commit 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels").
The fix being replacing const char * with #defines in order to address
compilation failures observed on GCC 6 through 10.

Compile tested only.
No functional change intended.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/netdev/485dbc5a-a04b-40c2-9481-955eaa5ce2e2@kernel.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 69 +++++++++++-----------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f196cd99d510..cbf2dd976ab1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -846,42 +846,41 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
-#define DPP_RX_ERR "Read Rx Descriptor Parity checker Error"
-#define DPP_TX_ERR "Read Tx Descriptor Parity checker Error"
-
+static const char dpp_rx_err[] = "Read Rx Descriptor Parity checker Error";
+static const char dpp_tx_err[] = "Read Tx Descriptor Parity checker Error";
 static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
-	{ true, "TDPES0", DPP_TX_ERR },
-	{ true, "TDPES1", DPP_TX_ERR },
-	{ true, "TDPES2", DPP_TX_ERR },
-	{ true, "TDPES3", DPP_TX_ERR },
-	{ true, "TDPES4", DPP_TX_ERR },
-	{ true, "TDPES5", DPP_TX_ERR },
-	{ true, "TDPES6", DPP_TX_ERR },
-	{ true, "TDPES7", DPP_TX_ERR },
-	{ true, "TDPES8", DPP_TX_ERR },
-	{ true, "TDPES9", DPP_TX_ERR },
-	{ true, "TDPES10", DPP_TX_ERR },
-	{ true, "TDPES11", DPP_TX_ERR },
-	{ true, "TDPES12", DPP_TX_ERR },
-	{ true, "TDPES13", DPP_TX_ERR },
-	{ true, "TDPES14", DPP_TX_ERR },
-	{ true, "TDPES15", DPP_TX_ERR },
-	{ true, "RDPES0", DPP_RX_ERR },
-	{ true, "RDPES1", DPP_RX_ERR },
-	{ true, "RDPES2", DPP_RX_ERR },
-	{ true, "RDPES3", DPP_RX_ERR },
-	{ true, "RDPES4", DPP_RX_ERR },
-	{ true, "RDPES5", DPP_RX_ERR },
-	{ true, "RDPES6", DPP_RX_ERR },
-	{ true, "RDPES7", DPP_RX_ERR },
-	{ true, "RDPES8", DPP_RX_ERR },
-	{ true, "RDPES9", DPP_RX_ERR },
-	{ true, "RDPES10", DPP_RX_ERR },
-	{ true, "RDPES11", DPP_RX_ERR },
-	{ true, "RDPES12", DPP_RX_ERR },
-	{ true, "RDPES13", DPP_RX_ERR },
-	{ true, "RDPES14", DPP_RX_ERR },
-	{ true, "RDPES15", DPP_RX_ERR },
+	{ true, "TDPES0", dpp_tx_err },
+	{ true, "TDPES1", dpp_tx_err },
+	{ true, "TDPES2", dpp_tx_err },
+	{ true, "TDPES3", dpp_tx_err },
+	{ true, "TDPES4", dpp_tx_err },
+	{ true, "TDPES5", dpp_tx_err },
+	{ true, "TDPES6", dpp_tx_err },
+	{ true, "TDPES7", dpp_tx_err },
+	{ true, "TDPES8", dpp_tx_err },
+	{ true, "TDPES9", dpp_tx_err },
+	{ true, "TDPES10", dpp_tx_err },
+	{ true, "TDPES11", dpp_tx_err },
+	{ true, "TDPES12", dpp_tx_err },
+	{ true, "TDPES13", dpp_tx_err },
+	{ true, "TDPES14", dpp_tx_err },
+	{ true, "TDPES15", dpp_tx_err },
+	{ true, "RDPES0", dpp_rx_err },
+	{ true, "RDPES1", dpp_rx_err },
+	{ true, "RDPES2", dpp_rx_err },
+	{ true, "RDPES3", dpp_rx_err },
+	{ true, "RDPES4", dpp_rx_err },
+	{ true, "RDPES5", dpp_rx_err },
+	{ true, "RDPES6", dpp_rx_err },
+	{ true, "RDPES7", dpp_rx_err },
+	{ true, "RDPES8", dpp_rx_err },
+	{ true, "RDPES9", dpp_rx_err },
+	{ true, "RDPES10", dpp_rx_err },
+	{ true, "RDPES11", dpp_rx_err },
+	{ true, "RDPES12", dpp_rx_err },
+	{ true, "RDPES13", dpp_rx_err },
+	{ true, "RDPES14", dpp_rx_err },
+	{ true, "RDPES15", dpp_rx_err },
 };
 
 static void dwxgmac3_handle_dma_err(struct net_device *ndev,


