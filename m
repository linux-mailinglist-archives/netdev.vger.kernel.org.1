Return-Path: <netdev+bounces-250382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46CD29F08
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8953309086C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484E3376AC;
	Fri, 16 Jan 2026 02:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9843375A0;
	Fri, 16 Jan 2026 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529373; cv=none; b=ZD3tuOlBV/woRJggBKa2Iosss5QRj59yHwaC/LfQQmSnKVyLiKGN2vdo61Ez6PdGev5UEF6fhiLXbuhURNLZJ0O2S53AxVVsG554VwpTgdj/eUDtDLxHnHi+ys3I3RQZh9bilSCB6kadNUV1A6UdqWM/i81m92tpxmFXwgPRXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529373; c=relaxed/simple;
	bh=1bEa2Jv/bTv7bHrcPfXv9ul57tdtU4FVmXDJgJry74s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V80j7JfxeCJJEda+Z/SKFuudU0LKu+1OrKN1brgfBg2rhxruLFesgrMll8MYwid5ujn7Kit5csIAs2dY6+h8vfJB9L/Ow0IFlvHVgzSNygqfvWVIrn5rcafQKou0Jeb2qBnTlgl9VEvAcDELvJSPgSkJn5GDmszDF4DLpMYM+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:15 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:15 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:14 +0800
Subject: [PATCH net-next v2 03/15] net: ftgmac100: Replace all
 of_device_is_compatible()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-3-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=3130;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=+aILZO8pus/3meVrNzurjk9uWwwKRISZWHJRBZ3qWxI=;
 b=kNuHqI1db8zTlIuaxe2mfcKEyi4Kk0RdJocFJz3O9oggj25IpW4jIjQrox/okmfwVGd2P4NRU
 2MuE9izUYNcCJ3D4pBP7+57KVV7Q7xTZE8ieKa9jmdwmuMnz0pZgmuc
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Now that the priv structure includes the MAC ID, make use of it
instead of the more expensive of_device_is_compatible().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 104eb7b1f5bb..f07167cabf39 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1720,8 +1720,8 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	if (!priv->mii_bus)
 		return -EIO;
 
-	if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-	    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500) {
 		/* The AST2600 has a separate MDIO controller */
 
 		/* For the AST2400 and AST2500 this driver only supports the
@@ -1926,9 +1926,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500 ||
+	    priv->mac_id == FTGMAC100_AST2600) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1973,8 +1973,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * available PHYs and register them.
 		 */
 		if (of_get_property(np, "phy-handle", NULL) &&
-		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
+		    (priv->mac_id == FTGMAC100_AST2400 ||
+		     priv->mac_id == FTGMAC100_AST2500)) {
 			err = ftgmac100_setup_mdio(netdev);
 			if (err)
 				goto err_setup_mdio;
@@ -2026,7 +2026,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (priv->mac_id == FTGMAC100_AST2600)
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2044,11 +2044,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	/* AST2400  doesn't have working HW checksum generation */
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
+	if (priv->mac_id == FTGMAC100_AST2400)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	/* AST2600 tx checksum with NCSI is broken */
-	if (priv->use_ncsi && of_device_is_compatible(np, "aspeed,ast2600-mac"))
+	if (priv->use_ncsi && priv->mac_id == FTGMAC100_AST2600)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	if (np && of_get_property(np, "no-hw-checksum", NULL))

-- 
2.34.1


