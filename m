Return-Path: <netdev+bounces-95811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BB8C3787
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924661F2113C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6B47A48;
	Sun, 12 May 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mdFLx4SE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460A4776A
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531363; cv=none; b=rNHPWoggSGwOPoWWTtFlCyxWVkeYerl7JXZkOVuWCxVLjF25gTedg7hI2TmNTFCGFcJnoemcFkcIjuLrilZrN2ASqHcTHd0vOJ6GXZZXrcIylUorRpgDgwNnmJ7AjTBFiP0P53c+5vkHgYuWbf689wRCRFDgRan3g8KbsxEzDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531363; c=relaxed/simple;
	bh=HN6EVBA2bwyWeQSy0U9QhjZwRzIEx56EKnPryOtv9Rc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hZE8M4xgrp3vQPAe4XskFvuJ9RN1N1Dp3AyVklpkjypTer1pmE9H8C7UXWeGAD7Fr/PcstXmpcKF9EN9LekewYMvJslMrWQOpGhTqeP26aBWPmmhY5akcG1MgtaPklbeNeRARvLPDy1S/6HKYFf0O3tacipVOMCDkBh2xIaGJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mdFLx4SE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lwVyGBHvyoza9upu+A79pjeY+QabfKllohhsXbrMA7Q=; b=mdFLx4SEuA77PgfpKTy8j7vWfv
	sRWJN1ARXIUbhOLbI/9zhOMz450ie87TLbXCmpW5ixYQDzsmdJlEneUA4GTNULnxiRnupklp/wvra
	CNiwf9TIQj1+ATEvwwtPIIWVMHHVYNY0qZfzM1nkWXlo/pD7xDv5WwxFDsOJKeMy7Tg2yPFP98Nqu
	exfrwBVPBGGJSDo/hOHDnsbjaPEEvLIYd89Krt0JpHXqbkfF0i8aBv0XdMlVhknxnaP0NYN+LYkE9
	82Y+3Hk3qOReELSedtwP9MDvtXT58WDCHEL7H4s2/0uhgekFJSGyRZOkcWYhaBiOfyDJk5VjMxH4+
	gtOeMsEQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39826 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s6C4R-0000tS-1o;
	Sun, 12 May 2024 17:29:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s6C4T-00Ck6U-D0; Sun, 12 May 2024 17:29:09 +0100
In-Reply-To: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next 3/6] net: stmmac: remove pcs_rane() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s6C4T-00Ck6U-D0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 12 May 2024 17:29:09 +0100

The pcs_rane() method is no longer called, remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c    |  6 ------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c   |  8 --------
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c |  2 --
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  3 ---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h    | 17 -----------------
 5 files changed, 36 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index cf20af8f0bbc..05907fb5b0aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -401,11 +401,6 @@ static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + LPI_TIMER_CTRL);
 }
 
-static void dwmac1000_rane(void __iomem *ioaddr, bool restart)
-{
-	dwmac_rane(ioaddr, GMAC_PCS_BASE, restart);
-}
-
 static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 {
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
@@ -582,7 +577,6 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_timer = dwmac1000_set_eee_timer,
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
-	.pcs_rane = dwmac1000_rane,
 	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 48e5d15cead1..dfe5aa41224c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -753,11 +753,6 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-static void dwmac4_rane(void __iomem *ioaddr, bool restart)
-{
-	dwmac_rane(ioaddr, GMAC_PCS_BASE, restart);
-}
-
 static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 {
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
@@ -1283,7 +1278,6 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
@@ -1328,7 +1322,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
@@ -1377,7 +1370,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index bb82eaa2e099..a818ba3e336e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1554,7 +1554,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
 	.set_eee_pls = dwxgmac2_set_eee_pls,
-	.pcs_rane = NULL,
 	.pcs_get_adv_lp = NULL,
 	.debug = NULL,
 	.set_filter = dwxgmac2_set_filter,
@@ -1613,7 +1612,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
 	.set_eee_pls = dwxgmac2_set_eee_pls,
-	.pcs_rane = NULL,
 	.pcs_get_adv_lp = NULL,
 	.debug = NULL,
 	.set_filter = dwxgmac2_set_filter,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index ecc957fa16cc..2ccb9de250d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -376,7 +376,6 @@ struct stmmac_ops {
 		      struct stmmac_extra_stats *x, u32 rx_queues,
 		      u32 tx_queues);
 	/* PCS calls */
-	void (*pcs_rane)(void __iomem *ioaddr, bool restart);
 	void (*pcs_get_adv_lp)(void __iomem *ioaddr, struct rgmii_adv *adv);
 	/* Safety Features */
 	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
@@ -492,8 +491,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_eee_pls, __args)
 #define stmmac_mac_debug(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, debug, __priv, __args)
-#define stmmac_pcs_rane(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, pcs_rane, __priv, __args)
 #define stmmac_pcs_get_adv_lp(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pcs_get_adv_lp, __args)
 #define stmmac_safety_feat_config(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index c0821ed4e9b2..a1770461b891 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -74,23 +74,6 @@ static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
 	}
 }
 
-/**
- * dwmac_rane - To restart ANE
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
- * @restart: to restart ANE
- * Description: this is to just restart the Auto-Negotiation.
- */
-static inline void dwmac_rane(void __iomem *ioaddr, u32 reg, bool restart)
-{
-	u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
-
-	if (restart)
-		value |= GMAC_AN_CTRL_RAN;
-
-	writel(value, ioaddr + GMAC_AN_CTRL(reg));
-}
-
 /**
  * dwmac_get_adv_lp - Get ADV and LP cap
  * @ioaddr: IO registers pointer
-- 
2.30.2


