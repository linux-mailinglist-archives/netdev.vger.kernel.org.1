Return-Path: <netdev+bounces-263732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOLrKg8IqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B687F1FE44B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98C7C3018069
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9C739F19A;
	Wed,  4 Mar 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r3QC6xsj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E36A00F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619786; cv=none; b=gyRwKzCBoPRbYOiT/5L0MiU4ZUQPRhHw+SHAqbwJzat4+RTmM+7D/vydCEw0wLZ4g5A2be+uwxIGMYZORuLFrYhp8YqrYho18tad5rRGpdGc2rg5lmNclcz17VL6mC6FNCk+sGL27xrRmdZP8pckkL3QlzAlp3KzlNiLcyj7FS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619786; c=relaxed/simple;
	bh=XP0qYTz4Vp9a1av2boL/63wsKXkxBCqBjzLqgbWWrfc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gIPTGSi1mY1IfFk0Mr4LOzBUKLymv3n8lkUlBM05prjUE108HjbpIhqrnDh0HcFZmBM7/zHaKpBrGoBztnGuMQpg6xmhKnra7PVfl5ZQqyMZYJTRqddzCYfVNANtglDN98RcGZgI8x+gHOulLdAuiunCUObAJFfUfwN+vtTT6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r3QC6xsj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7TWPZWgjMflG60hVdURSGE4ETIH+Z1lgrcFU4tilmE4=; b=r3QC6xsjCplgKEbbd5wJUzqSmg
	ynznx4oGKAuntVC47eJpmc9q4ATqLW2hXnjeFYCWTTl5SN/ySfCnjpt2HDTjNngR57A79iOfAcypF
	W9+ER2p16cKZMaWYcxQ2WV5UjISUgeMHKbypsR/NlajIhn6Dhj4x6TGYaL2gfQnpA7hnES4mo5AS+
	WALwNDGxJvh/uxV4027srX2hrRU/fxArzyEL0za1iT+BuIOuerXXQAJ/2Cg2PRRgcHPdvv2NTQdZw
	GzXpSNn+0momR9PKb6CYtvFy39H+UaojWLyCmQTzaLKdfRtp2D5muacDYR4Q8fG7NQZUZVZb2a7TW
	6SGTzgCA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37552 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNV-000000006M5-1Yt4;
	Wed, 04 Mar 2026 10:22:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNU-0000000Br1K-0bhr;
	Wed, 04 Mar 2026 10:22:52 +0000
In-Reply-To: <aagH023pvswd0tlT@shell.armlinux.org.uk>
References: <aagH023pvswd0tlT@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/8] net: stmmac: use u32 for MDIO register field
 masks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNU-0000000Br1K-0bhr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:22:52 +0000
X-Rspamd-Queue-Id: B687F1FE44B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263732-lists,netdev=lfdr.de,kernel];
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
	NEURAL_SPAM(0.00)[0.163];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

MDIO registers are 32-bit, so use u32 to describe the masks for these
registers. Convert the GENMASK() initialisers to GENMASK_U32() for
type compatibility.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h         |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c    |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c  | 12 ++++++------
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 978f90065681..46454e2886ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -608,9 +608,9 @@ struct mac_link {
 struct mii_regs {
 	unsigned int addr;	/* MII Address */
 	unsigned int data;	/* MII Data */
-	unsigned int addr_mask;		/* MII address mask */
-	unsigned int reg_mask;		/* MII reg mask */
-	unsigned int clk_csr_mask;
+	u32 addr_mask;		/* MII address mask */
+	u32 reg_mask;		/* MII reg mask */
+	u32 clk_csr_mask;
 };
 
 struct mac_device_info {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 6dfccc969d0e..a6f8e78856aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -369,7 +369,7 @@ static int loongson_dwmac_setup(void *apriv, struct mac_device_info *mac)
 	mac->mii.data = GMAC_MII_DATA;
 	mac->mii.addr_mask = 0x0000F800;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_mask = GENMASK(5, 2);
+	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6b18072112db..3ce03b059277 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1063,9 +1063,9 @@ static int sun8i_dwmac_setup(void *ppriv, struct mac_device_info *mac)
 	mac->link.duplex = EMAC_DUPLEX_FULL;
 	mac->mii.addr = EMAC_MDIO_CMD;
 	mac->mii.data = EMAC_MDIO_DATA;
-	mac->mii.reg_mask = GENMASK(8, 4);
-	mac->mii.addr_mask = GENMASK(16, 12);
-	mac->mii.clk_csr_mask = GENMASK(22, 20);
+	mac->mii.reg_mask = GENMASK_U32(8, 4);
+	mac->mii.addr_mask = GENMASK_U32(16, 12);
+	mac->mii.clk_csr_mask = GENMASK_U32(22, 20);
 	mac->unicast_filter_entries = 8;
 
 	/* Synopsys Id is not available */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 10acca806f4f..4ea55be04c5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -498,7 +498,7 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.data = GMAC_MII_DATA;
 	mac->mii.addr_mask = 0x0000F800;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_mask = GENMASK(5, 2);
+	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 911753b9889e..7c91ea2775d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -186,7 +186,7 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	mac->mii.data = MAC_MII_DATA;
 	mac->mii.addr_mask = 0x0000F800;
 	mac->mii.reg_mask = 0x000007C0;
-	mac->mii.clk_csr_mask = GENMASK(5, 2);
+	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 0e87590c806b..602771e19d0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1030,9 +1030,9 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
 	mac->mii.addr = GMAC_MDIO_ADDR;
 	mac->mii.data = GMAC_MDIO_DATA;
-	mac->mii.addr_mask = GENMASK(25, 21);
-	mac->mii.reg_mask = GENMASK(20, 16);
-	mac->mii.clk_csr_mask = GENMASK(11, 8);
+	mac->mii.addr_mask = GENMASK_U32(25, 21);
+	mac->mii.reg_mask = GENMASK_U32(20, 16);
+	mac->mii.clk_csr_mask = GENMASK_U32(11, 8);
 	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index ba98e22f1c12..915e7c2ab11f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1551,9 +1551,9 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 
 	mac->mii.addr = XGMAC_MDIO_ADDR;
 	mac->mii.data = XGMAC_MDIO_DATA;
-	mac->mii.addr_mask = GENMASK(20, 16);
-	mac->mii.reg_mask = GENMASK(15, 0);
-	mac->mii.clk_csr_mask = GENMASK(21, 19);
+	mac->mii.addr_mask = GENMASK_U32(20, 16);
+	mac->mii.reg_mask = GENMASK_U32(15, 0);
+	mac->mii.clk_csr_mask = GENMASK_U32(21, 19);
 	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
@@ -1591,9 +1591,9 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 
 	mac->mii.addr = XGMAC_MDIO_ADDR;
 	mac->mii.data = XGMAC_MDIO_DATA;
-	mac->mii.addr_mask = GENMASK(20, 16);
-	mac->mii.reg_mask = GENMASK(15, 0);
-	mac->mii.clk_csr_mask = GENMASK(21, 19);
+	mac->mii.addr_mask = GENMASK_U32(20, 16);
+	mac->mii.reg_mask = GENMASK_U32(15, 0);
+	mac->mii.clk_csr_mask = GENMASK_U32(21, 19);
 
 	return 0;
 }
-- 
2.47.3


