Return-Path: <netdev+bounces-269100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFdMCavXumkXcgIAu9opvQ
	(envelope-from <netdev+bounces-269100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:49:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08602BF9C3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2823334A4D9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAE3E715C;
	Wed, 18 Mar 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IdhPMrk5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557682D640D
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849986; cv=none; b=AIiUXVIv4+LzPOLqdu5PDXGQXuDm1WUv95vpLuNDTngf0oEGhFcrxAh7pYsYZJ6AU/p2tOl153z4Tcqpb40Kd5LN/j/gONp2aIxcRosQUrOoRE7NvaagGbnbwzvvYfoGhZySjVruALPcT1PwdcOcWuI+pNqlns+cBT6yTQ/mWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849986; c=relaxed/simple;
	bh=o+jqL3FtSgu2LeTxHWN/vwNwSecVHZCG5W4IVkCLBUQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GT+kcyoICthk+vJu3RM0ANslZL4WiQWk8B6wnmZdZTmrJX2O7keue03AZZQ7yxMwzh/t3XUMMlqqb0Q55Dz8RKwLW3IicDIbigG8Dq0gP9bzHrX+PcLRhE9MtJpLaWM/O1efD//n8DpnZ4J3wRN0NjNg4WxggpuPvZs53nnKhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IdhPMrk5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cSfNrtwIA1VaENvujV5TSp8vdQ3v1myOgrpZxvYr8gU=; b=IdhPMrk5INj5SfpEsApUO305rb
	cbsAKeqUQ2vTpO6TekMeKYpavN4u7dJF6HZq8wImgtL0lN32U2sungw+EQq+Dg8wU8KBMMxLzJ+0g
	jwl2JRVstQdXs1IiI0D1+DzXbDeUZ+Am0+NNqCtEkSRv2vr3y1Y9sd8IqxBzt3iU8Q8mM3YkRCI8Y
	7Jz18Z+wfc7KYQKYS9JvZL45BHtaEetoLvrCvLl1uQ0eqttFOZwmr5SqsH9z19+dkNX4bbM4pAgB+
	fo7wrDDqqV44E7FS43MAVG/hdJebRTg6Z6xTGk0reA9yF5TjI24ieIXQrwn2deY4gYrZrhzVi8cd3
	NHzQVuMg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47258 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w2tPP-000000003eJ-3WVx;
	Wed, 18 Mar 2026 16:06:11 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w2tPP-0000000DYAX-0TKw;
	Wed, 18 Mar 2026 16:06:11 +0000
In-Reply-To: <abrNYVfZ1Iwff2EI@shell.armlinux.org.uk>
References: <abrNYVfZ1Iwff2EI@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next v2 maybe? 1/5] net: stmmac: move default_an_inband to
 plat_stmmacenet_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w2tPP-0000000DYAX-0TKw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 18 Mar 2026 16:06:11 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269100-lists,netdev=lfdr.de,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.434];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A08602BF9C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the default_an_inband flag from struct mdio_bus_data to struct
plat_stmmacenet_data. This is to allow platforms that do not use the
integrated MDIO bus to enable inband mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index f621077c30a4..7898b5075a8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -298,7 +298,7 @@ static void tgl_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
 
 	if (FIELD_GET(SERDES_LINK_MODE_MASK, data) == SERDES_LINK_MODE_2G5) {
 		dev_info(priv->device, "Link Speed Mode: 2.5Gbps\n");
-		priv->plat->mdio_bus_data->default_an_inband = false;
+		priv->plat->default_an_inband = false;
 		interface = PHY_INTERFACE_MODE_2500BASEX;
 	} else {
 		interface = PHY_INTERFACE_MODE_SGMII;
@@ -700,7 +700,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		plat->mdio_bus_data->pcs_mask = BIT_U32(INTEL_MGBE_XPCS_ADDR);
-		plat->mdio_bus_data->default_an_inband = true;
+		plat->default_an_inband = true;
 		plat->select_pcs = intel_mgbe_select_pcs;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0a933aac3f03..90af7212b8d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1390,7 +1390,6 @@ static int stmmac_init_phy(struct net_device *dev)
 
 static int stmmac_phylink_setup(struct stmmac_priv *priv)
 {
-	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct phylink_config *config;
 	struct phylink_pcs *pcs;
 	struct phylink *phylink;
@@ -1415,9 +1414,7 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 	priv->tx_lpi_clk_stop = priv->plat->flags &
 				STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 
-	mdio_bus_data = priv->plat->mdio_bus_data;
-	if (mdio_bus_data)
-		config->default_an_inband = mdio_bus_data->default_an_inband;
+	config->default_an_inband = priv->plat->default_an_inband;
 
 	/* Get the PHY interface modes (at the PHY end of the link) that
 	 * are supported by the platform.
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 72febd246bdb..565bb394b194 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -89,7 +89,6 @@ struct stmmac_mdio_bus_data {
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
-	bool default_an_inband;
 };
 
 struct stmmac_dma_cfg {
@@ -250,6 +249,7 @@ struct plat_stmmacenet_data {
 	struct stmmac_dma_cfg *dma_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
+	bool default_an_inband;
 	bool enh_desc;
 	bool tx_coe;
 	bool bugged_jumbo;
-- 
2.47.3


