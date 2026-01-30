Return-Path: <netdev+bounces-255115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iExLJoeSfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:14:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CCB9F09
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38210304CCC7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C7378D75;
	Fri, 30 Jan 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Te3+u6Vm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94676378D7C
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771445; cv=none; b=bcucPMTI1P+olkPeTtVRsK94sGdImyHOP1oh8+MfYyzv5wPeTJGky/Pdo9/DEq627/Xtd91zuvxUSWp58/CzzD6pHPLyQ7JDKhigITiKsX8jZWVpDTpexcFQJ9Lx1GkPr/fhOUeaOnJnYy4h3Dd0UwLUNHPmXWXXL/dLPjLkJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771445; c=relaxed/simple;
	bh=vShS4Y6qRmE2himCmwjVV259fO++enTJn1ThXj7u4YU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nD8wkVxOLt++Dgn28tp2gHqnyBqoyqkV8DPknZ/im3gOe/SX12anO+0DmOP5EBXcpxIfQ3EczStfkA+ctH/xdXF9T98OxMI0JLTvQbfISdDr6We7eCKcmm7GxiwfTrj5veopBn5wzD9hL84+29ut510kduFzGpUS7xlkFpqm4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Te3+u6Vm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yynZOzn5o3dXhPOMSlGn66/FfoPYsbv/+Gmwdzz5VFg=; b=Te3+u6VmvsNhcjidF5gG1qJ7NT
	k3rL7J/G68Q0b0uVaUmQja0Cu4f5ZGs1usudjv4ZXTM+YgOOp/zAzsforiisjLa1lVHGopFJk2xCF
	2XQ8MqDAKKBBONfjAkjEAJKGF2Nu84Rxc798rtMAYQy3l/cX0wGDWsEY/zRIk68IyG/MtmsT5fy3w
	Fg9Qaxs+fo4snzxxGwBbDOofMxsBG96MRMOvO4WB1P0mDCv4ArYLKk2JVdPN3VUCwX+6MUmy6RJPE
	xbWhnlxlaKSfWmkjlZC/dse5sOAQaMqTMNi47cnFWXcLOiLR9MeAne5kcdvRNVz7sTeHNQTJJdtLA
	UiO2/Tyg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41186 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vlmOb-0000000013O-1md4;
	Fri, 30 Jan 2026 11:10:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vlmOa-00000006zvB-1fIe;
	Fri, 30 Jan 2026 11:10:36 +0000
In-Reply-To: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: stmmac: handle integrated PCS phy_intf_sel
 separately
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vlmOa-00000006zvB-1fIe@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 30 Jan 2026 11:10:36 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255115-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: EE9CCB9F09
X-Rspamd-Action: no action

The dwmac core has no support for SGMII without using its integrated
PCS. Thus, PHY_INTF_SEL_SGMII is only supported when this block is
present, and it makes no sense for stmmac_get_phy_intf_sel() to decode
this.

None of the platform glue users that use stmmac_get_phy_intf_sel()
directly accept PHY_INTF_SEL_SGMII as a valid mode.

Check whether a PCS will be used by the driver for the interface mode,
and if it is the integrated PCS, query the integrated PCS for the
phy_intf_sel_i value to use.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 ++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c  |  9 +++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a3c155cccd9b..b2b90c3c1c45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3159,8 +3159,6 @@ int stmmac_get_phy_intf_sel(phy_interface_t interface)
 		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 	else if (phy_interface_mode_is_rgmii(interface))
 		phy_intf_sel = PHY_INTF_SEL_RGMII;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
-		phy_intf_sel = PHY_INTF_SEL_SGMII;
 	else if (interface == PHY_INTERFACE_MODE_RMII)
 		phy_intf_sel = PHY_INTF_SEL_RMII;
 	else if (interface == PHY_INTERFACE_MODE_REVMII)
@@ -3174,13 +3172,24 @@ static int stmmac_prereset_configure(struct stmmac_priv *priv)
 {
 	struct plat_stmmacenet_data *plat_dat = priv->plat;
 	phy_interface_t interface;
+	struct phylink_pcs *pcs;
 	int phy_intf_sel, ret;
 
 	if (!plat_dat->set_phy_intf_sel)
 		return 0;
 
 	interface = plat_dat->phy_interface;
-	phy_intf_sel = stmmac_get_phy_intf_sel(interface);
+
+	/* Check whether this mode uses a PCS */
+	pcs = stmmac_mac_select_pcs(&priv->phylink_config, interface);
+	if (priv->integrated_pcs && pcs == &priv->integrated_pcs->pcs) {
+		/* Request the phy_intf_sel from the integrated PCS */
+		phy_intf_sel = stmmac_integrated_pcs_get_phy_intf_sel(pcs,
+								    interface);
+	} else {
+		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
+	}
+
 	if (phy_intf_sel < 0) {
 		netdev_err(priv->dev,
 			   "failed to get phy_intf_sel for %s: %pe\n",
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index e827c03ae932..88fa359ea716 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -81,6 +81,15 @@ void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 	}
 }
 
+int stmmac_integrated_pcs_get_phy_intf_sel(struct phylink_pcs *pcs,
+					   phy_interface_t interface)
+{
+	if (interface == PHY_INTERFACE_MODE_SGMII)
+		return PHY_INTF_SEL_SGMII;
+
+	return -EINVAL;
+}
+
 int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
 			       u32 int_mask)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 13ee5bd6c788..23bbd4f10bf8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -42,6 +42,8 @@ phylink_pcs_to_stmmac_pcs(struct phylink_pcs *pcs)
 
 void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 			       struct stmmac_extra_stats *x);
+int stmmac_integrated_pcs_get_phy_intf_sel(struct phylink_pcs *pcs,
+					   phy_interface_t interface);
 int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
 			       u32 int_mask);
 
-- 
2.47.3


