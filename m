Return-Path: <netdev+bounces-264284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P0xLU9fqWlc6QAAu9opvQ
	(envelope-from <netdev+bounces-264284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:47:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47B20FF0C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF98630BC944
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA24378D6E;
	Thu,  5 Mar 2026 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kjOZapz9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EC37F8D3
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707376; cv=none; b=FdOPpJCigYqV2fheGt56gQz0bgX5oEmqDG5LWO+lgonk37dg2vMYdokSHBzmIe0PVKorNr3FlYBuIzfC6MrQp5mmcvwXE7QbyrUxN+fwnm2lL/XH0gi5Gd12FRJr2hAiXC40dQYXy5QK6gAdQTkXz6qyOm1KL641DDKTXOPLFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707376; c=relaxed/simple;
	bh=KUvl8dMVtpKFdYXYsB4f1lhROudC5oaA6zbBk02mmU4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pjG/aisGlE7stdJoxX4WIM6rSf5+RNcqURJTyT7PC0VDqUQ5X2ngLBUqn2S0XmbmoChiFdEGAvNiS5JPlYUzjWiHVhLzNeXN/mp9Kb9suiV2OfMASAyEf5JbYeVUsjfi3rc56aTRuvCRxJx/mCsmjq4eprUfgk3IBhyYvbkAkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kjOZapz9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZgLn5gKTC6ltjP22vENPvguQQAUnJs1iU1xrD1qgNa0=; b=kjOZapz9Cy687qC4OkDRb34zzI
	aDvzNyVJBUL1P2nBVmBo55U8s+wJwYybrPZ0fKLXulCpOcFB87VEouy9exDrhtvmQJCmF8XGWZz9Z
	OZmFI+DXsQTMsLVYDyj2TcO7eOU83+/4VoyDpBodtQOCc1lhTU0dYOeywPSisj1kowKzv6V4ZZSuX
	tsE+Uiqv4L+5agHYuS5KLfy4EH6B7XpxjfEYEjAyXs5gX8VsMX9mkhKEUl0GyPrUsehenzS40TPSE
	G+9p/Ro3ia6PikvJs8gkG5lxNfYNgQVP+VpWqbKJG8P1wJLJ5dFjqAvDYAFOZo7c+7qNvfTqKqUbO
	om0dWTnA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58672 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vy6AF-000000007nW-1SLf;
	Thu, 05 Mar 2026 10:42:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vy6AE-0000000Btwv-1LM4;
	Thu, 05 Mar 2026 10:42:42 +0000
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next v2 4/8] net: stmmac: mdio: convert field prep to use
 field_prep()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vy6AE-0000000Btwv-1LM4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Mar 2026 10:42:42 +0000
X-Rspamd-Queue-Id: 1A47B20FF0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264284-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.194];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Action: no action

Convert the MDIO field preparation to use field_prep(), which removes
the need to store separate mask and shifts. Also convert the clk_csr
value using __ffs() to do the shift as we need to detect overflows
for this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h         | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c    | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c  | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c    | 6 +++---
 8 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index e4ce1167ebab..978f90065681 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -608,11 +608,8 @@ struct mac_link {
 struct mii_regs {
 	unsigned int addr;	/* MII Address */
 	unsigned int data;	/* MII Data */
-	unsigned int addr_shift;	/* MII address shift */
-	unsigned int reg_shift;		/* MII reg shift */
 	unsigned int addr_mask;		/* MII address mask */
 	unsigned int reg_mask;		/* MII reg mask */
-	unsigned int clk_csr_shift;
 	unsigned int clk_csr_mask;
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9c51c96223ad..6dfccc969d0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -367,11 +367,8 @@ static int loongson_dwmac_setup(void *apriv, struct mac_device_info *mac)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_shift = 11;
 	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_shift = 6;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index c01b86fd64da..6b18072112db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1063,11 +1063,8 @@ static int sun8i_dwmac_setup(void *ppriv, struct mac_device_info *mac)
 	mac->link.duplex = EMAC_DUPLEX_FULL;
 	mac->mii.addr = EMAC_MDIO_CMD;
 	mac->mii.data = EMAC_MDIO_DATA;
-	mac->mii.reg_shift = 4;
 	mac->mii.reg_mask = GENMASK(8, 4);
-	mac->mii.addr_shift = 12;
 	mac->mii.addr_mask = GENMASK(16, 12);
-	mac->mii.clk_csr_shift = 20;
 	mac->mii.clk_csr_mask = GENMASK(22, 20);
 	mac->unicast_filter_entries = 8;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index af566636fad9..10acca806f4f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -496,11 +496,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_shift = 11;
 	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_shift = 6;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index db4fbe64a38a..911753b9889e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -184,11 +184,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = MAC_CONTROL_PS;
 	mac->mii.addr = MAC_MII_ADDR;
 	mac->mii.data = MAC_MII_DATA;
-	mac->mii.addr_shift = 11;
 	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_shift = 6;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 623868afe93d..0e87590c806b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1030,11 +1030,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
 	mac->mii.addr = GMAC_MDIO_ADDR;
 	mac->mii.data = GMAC_MDIO_DATA;
-	mac->mii.addr_shift = 21;
 	mac->mii.addr_mask = GENMASK(25, 21);
-	mac->mii.reg_shift = 16;
 	mac->mii.reg_mask = GENMASK(20, 16);
-	mac->mii.clk_csr_shift = 8;
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 49893b9fb88c..ba98e22f1c12 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1551,11 +1551,8 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 
 	mac->mii.addr = XGMAC_MDIO_ADDR;
 	mac->mii.data = XGMAC_MDIO_DATA;
-	mac->mii.addr_shift = 16;
 	mac->mii.addr_mask = GENMASK(20, 16);
-	mac->mii.reg_shift = 0;
 	mac->mii.reg_mask = GENMASK(15, 0);
-	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
 	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
@@ -1594,11 +1591,8 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 
 	mac->mii.addr = XGMAC_MDIO_ADDR;
 	mac->mii.data = XGMAC_MDIO_DATA;
-	mac->mii.addr_shift = 16;
 	mac->mii.addr_mask = GENMASK(20, 16);
-	mac->mii.reg_shift = 0;
 	mac->mii.reg_mask = GENMASK(15, 0);
-	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index c9f0b8b601d2..afe98ff5bdcb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -234,8 +234,8 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 {
 	const struct mii_regs *mii_regs = &priv->hw->mii;
 
-	return ((pa << mii_regs->addr_shift) & mii_regs->addr_mask) |
-	       ((gr << mii_regs->reg_shift) & mii_regs->reg_mask) |
+	return field_prep(mii_regs->addr_mask, pa) |
+	       field_prep(mii_regs->reg_mask, gr) |
 	       priv->gmii_address_bus_config |
 	       MII_ADDR_GBUSY;
 }
@@ -577,7 +577,7 @@ static void stmmac_mdio_bus_config(struct stmmac_priv *priv)
 	else
 		value = stmmac_clk_csr_set(priv);
 
-	value <<= priv->hw->mii.clk_csr_shift;
+	value <<= __ffs(priv->hw->mii.clk_csr_mask);
 
 	if (value & ~priv->hw->mii.clk_csr_mask)
 		dev_warn(priv->device,
-- 
2.47.3


