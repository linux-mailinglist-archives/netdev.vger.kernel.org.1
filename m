Return-Path: <netdev+bounces-263735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ0PFj4JqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:28:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D51FE560
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DAE31534E5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543B3A1CE7;
	Wed,  4 Mar 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cSoHbMFc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7837DEA2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619801; cv=none; b=qHENHZzji8+ZZps62C0NqywGP+O1VL491yTxMALdBMVBW2s8hzYLBvt1GkD3EhHim8DHdifwIsAnjwyPfiJB0T1UQKWwYu/b5yI0xTvXeLUMWBC1SSzq6wgM/KJIyqPKPK7pBlHr4PRJFsujVd87ksP7lxbej8i3aHl+jkXxbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619801; c=relaxed/simple;
	bh=pA86z/i3G0h6yNyEhsoKiTouctT+Hh6FEJ5n3fIQ4Us=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=g6X1rErun836fUFuUmVuOluqxe5cML2D2IxA+TkYASQcmvUPB7R2XALP2/2JhAZ0RELivSciUkVCw0gPpFVbK2LdB9BMSSsxJ56df4/BzRBhk+roCjejBujJ7yjuQxa47NzLny7xwj4HpFQa33+u5Fump1g6GFN2n7kDTwoxGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cSoHbMFc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qWkkwAQhRSg7J4BYF0vIgQD9gaPtRxcuEN+JTsY4Ylw=; b=cSoHbMFcIvk4CgvcGuphPu/riy
	CE2/BzPlCWK1mL7SdseOzs2go/e4JNP1iQZNN7QDUqqz1stS5KmaWNLch50qNB8dyV97gpKy/fbtS
	mxzqEL3JLAnCwnPk794lcEskYE0Ok0JKUJ4DUlyxQNPk4WCDIBVPXgPGxVWyA4F9DdldUWeINnPoF
	gBV89L+sW0Wb0yRIcxkj2Pf+yg7kOOeSJUbnnLLIrkyi0Bj9KSqmB4f2OKluF146BjaMa3o8kZnhX
	LA44ZumsSA1v3TA7yialAGACFoyjXJGCUiG321xQty5OjPhrypywYYPlIH8P6BLzi4s5dvsaC/zK+
	MxqaYjJA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60844 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNl-000000006N7-1Rzg;
	Wed, 04 Mar 2026 10:23:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNj-0000000Br1c-2Fg7;
	Wed, 04 Mar 2026 10:23:07 +0000
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
Subject: [PATCH net-next 8/8] net: stmmac: make pcs_mask and phy_mask u32
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNj-0000000Br1c-2Fg7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:23:07 +0000
X-Rspamd-Queue-Id: B18D51FE560
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
	TAGGED_FROM(0.00)[bounces-263735-lists,netdev=lfdr.de,kernel];
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
	NEURAL_SPAM(0.00)[0.257];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

The PCS and PHY masks are passed to the mdio bus layer as phy_mask
to prevent bus addresses between 0 and 31 inclusive being scanned,
and this is declared as u32. Also declare these as u32 in stmmac
for type consistency.

Since this is a u32, use BIT_U32() rather than BIT() to generate
values for these fields.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 +-
 include/linux/stmmac.h                               | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ece2a0c38562..fc13bfb47783 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -699,7 +699,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	/* Intel mgbe SGMII interface uses pcs-xcps */
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
-		plat->mdio_bus_data->pcs_mask = BIT(INTEL_MGBE_XPCS_ADDR);
+		plat->mdio_bus_data->pcs_mask = BIT_U32(INTEL_MGBE_XPCS_ADDR);
 		plat->mdio_bus_data->default_an_inband = true;
 		plat->select_pcs = intel_mgbe_select_pcs;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index b913fe5af488..bfe22da14102 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -168,7 +168,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
 	loongson_default_data(pdev, plat);
 
 	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
-	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
+	plat->mdio_bus_data->phy_mask = ~BIT_u32(2);
 	plat->fix_mac_speed = loongson_gnet_fix_speed;
 
 	return 0;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 678d03d6d3bd..965ada809fdf 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -84,8 +84,8 @@ struct stmmac_priv;
 /* Platfrom data for platform device structure's platform_data field */
 
 struct stmmac_mdio_bus_data {
-	unsigned int phy_mask;
-	unsigned int pcs_mask;
+	u32 phy_mask;
+	u32 pcs_mask;
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
-- 
2.47.3


