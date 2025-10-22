Return-Path: <netdev+bounces-231567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0106BFA9E2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E163B2BF2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CE2FD664;
	Wed, 22 Oct 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HBHYBaf2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2F2FC00F;
	Wed, 22 Oct 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118725; cv=none; b=rT0MS34X+q9bEmk3XtZ+B/sVN7zHFbZ2wD3HTxtoWXO6UyDKWJFkBb/h8/S9e8MXmKGh1t9jNeSQF0tcR+KgnMyaJU4i07tFCy1lhfla5wV9uRNPrzjv0/BK3yVZb55galy7OsDLCzZ8jnpBklLt38nokO5rTz9IcwzPHiDijck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118725; c=relaxed/simple;
	bh=ms+zag/7r86CQCaiWGC3Z7UhMgu68ikR+Dwj2ZuEZqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDq8HMGGVfhXfpnyS3As9rk0Bnvmi6qXDb7OkdURnYMxzO8bDyG8WI6Karr9eEjDLk0vt1aC0SOQmbQ19MDYkfXbBggH3bIdn547ZUKZfoZz5Sf380hKIKloYFWPeBcTnZVSh+DrG+aUh++/YMxed0G2Mr4Mw4Z42qOn8Xc9d0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HBHYBaf2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 13089C0B8B7;
	Wed, 22 Oct 2025 07:38:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8660606DC;
	Wed, 22 Oct 2025 07:38:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EA9E102F2429;
	Wed, 22 Oct 2025 09:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118720; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iWvier8kbhkxAYenRkU9MVIUo2xMenGSI7RehQ0Iej8=;
	b=HBHYBaf2G9IaB4TLV+C49g9WIjnm7bSDZQeQjaIDPNF8UgxRwtsaXhnxApNRGC4/wyJbI1
	pWqow1HzZaDxrSgSQbAFI6dLG3iXR0NaozPXoxgq7oCM+xv+m4qbNx5aI4EIhOa7qKLjm0
	fRvwIO0u83K2wCvbWFvrUUWf9W3tS9kjbuQ98Dj1HupMZTMTECpelpIC6s6G6iwHyBc7DO
	gLKpEYMlUgugQ65EIGOVJ8iT+arWi77R197ln/TmjLr6bDrUabBsxQiXFpU9sfkHJdsRjZ
	bkDsic4P9pj7y0iRliPSU8r1hKNOOPAuQy1U8y0wFa3wArFf5boMy1eXzqSwYA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 22 Oct 2025 09:38:13 +0200
Subject: [PATCH net-next v2 4/5] net: macb: rename bp->sgmii_phy field to
 bp->phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-macb-eyeq5-v2-4-7c140abb0581@bootlin.com>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
In-Reply-To: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The bp->sgmii_phy field is initialised at probe by init_reset_optional()
if bp->phy_interface == PHY_INTERFACE_MODE_SGMII. It gets used by:
 - zynqmp_config: "cdns,zynqmp-gem" or "xlnx,zynqmp-gem" compatibles.
 - mpfs_config: "microchip,mpfs-macb" compatible.
 - versal_config: "xlnx,versal-gem" compatible.

Make name more generic as EyeQ5 requires the PHY in SGMII & RGMII cases.

Drop "for ZynqMP SGMII mode" comment that is already a lie, as it gets
used on Microchip platforms as well. And soon it won't be SGMII-only.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 05bfa9bd4782..87414a2ddf6e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1341,7 +1341,7 @@ struct macb {
 
 	struct macb_ptp_info	*ptp_info;	/* macb-ptp interface */
 
-	struct phy		*sgmii_phy;	/* for ZynqMP SGMII mode */
+	struct phy		*phy;
 
 	spinlock_t tsu_clk_lock; /* gem tsu clock locking */
 	unsigned int tsu_rate;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 71a472c85a23..914677f30f2c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2963,7 +2963,7 @@ static int macb_open(struct net_device *dev)
 
 	macb_init_hw(bp);
 
-	err = phy_power_on(bp->sgmii_phy);
+	err = phy_power_on(bp->phy);
 	if (err)
 		goto reset_hw;
 
@@ -2979,7 +2979,7 @@ static int macb_open(struct net_device *dev)
 	return 0;
 
 phy_off:
-	phy_power_off(bp->sgmii_phy);
+	phy_power_off(bp->phy);
 
 reset_hw:
 	macb_reset_hw(bp);
@@ -3011,7 +3011,7 @@ static int macb_close(struct net_device *dev)
 	phylink_stop(bp->phylink);
 	phylink_disconnect_phy(bp->phylink);
 
-	phy_power_off(bp->sgmii_phy);
+	phy_power_off(bp->phy);
 
 	spin_lock_irqsave(&bp->lock, flags);
 	macb_reset_hw(bp);
@@ -5139,13 +5139,13 @@ static int init_reset_optional(struct platform_device *pdev)
 
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		/* Ensure PHY device used in SGMII mode is ready */
-		bp->sgmii_phy = devm_phy_optional_get(&pdev->dev, NULL);
+		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
 
-		if (IS_ERR(bp->sgmii_phy))
-			return dev_err_probe(&pdev->dev, PTR_ERR(bp->sgmii_phy),
+		if (IS_ERR(bp->phy))
+			return dev_err_probe(&pdev->dev, PTR_ERR(bp->phy),
 					     "failed to get SGMII PHY\n");
 
-		ret = phy_init(bp->sgmii_phy);
+		ret = phy_init(bp->phy);
 		if (ret)
 			return dev_err_probe(&pdev->dev, ret,
 					     "failed to init SGMII PHY\n");
@@ -5174,7 +5174,7 @@ static int init_reset_optional(struct platform_device *pdev)
 	/* Fully reset controller at hardware level if mapped in device tree */
 	ret = device_reset_optional(&pdev->dev);
 	if (ret) {
-		phy_exit(bp->sgmii_phy);
+		phy_exit(bp->phy);
 		return dev_err_probe(&pdev->dev, ret, "failed to reset controller");
 	}
 
@@ -5182,7 +5182,7 @@ static int init_reset_optional(struct platform_device *pdev)
 
 err_out_phy_exit:
 	if (ret)
-		phy_exit(bp->sgmii_phy);
+		phy_exit(bp->phy);
 
 	return ret;
 }
@@ -5592,7 +5592,7 @@ static int macb_probe(struct platform_device *pdev)
 	mdiobus_free(bp->mii_bus);
 
 err_out_phy_exit:
-	phy_exit(bp->sgmii_phy);
+	phy_exit(bp->phy);
 
 err_out_free_netdev:
 	free_netdev(dev);
@@ -5616,7 +5616,7 @@ static void macb_remove(struct platform_device *pdev)
 	if (dev) {
 		bp = netdev_priv(dev);
 		unregister_netdev(dev);
-		phy_exit(bp->sgmii_phy);
+		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
@@ -5643,7 +5643,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	u32 tmp;
 
 	if (!device_may_wakeup(&bp->dev->dev))
-		phy_exit(bp->sgmii_phy);
+		phy_exit(bp->phy);
 
 	if (!netif_running(netdev))
 		return 0;
@@ -5772,7 +5772,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
-		phy_init(bp->sgmii_phy);
+		phy_init(bp->phy);
 
 	if (!netif_running(netdev))
 		return 0;

-- 
2.51.1


