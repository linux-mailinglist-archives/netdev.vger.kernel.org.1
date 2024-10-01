Return-Path: <netdev+bounces-130940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3D98C233
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3401C237DD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61581C9EB3;
	Tue,  1 Oct 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="US93eD0b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A01CB32C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798671; cv=none; b=VVlLG0BTDmNI4wwysDeTPVcPiCmGEEPvYUg4ugpoGUHsMC+ZiFtIWWVK49PRoOPGZ8cJuwGiURHOZjUTHxWh1BbqT3igxqOOmvgpB5Hs+woso56lvJkFd28xGSeW9POWtIo3O5MQJ4gZeOwJqZLCbXxDvPb9WisEAqFQz3wc+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798671; c=relaxed/simple;
	bh=xIad9RmPp6o1lyMZanp9R3+0XREtgiaJvuLYOQY29GI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Q+TRrKyVvxqWS/lJ5B/8yGFyIispo+rgUvmVjlAyxuHJ7kb24XBnR9em5Nl5Y2sKM/R3HgyV3FMuTUkKK5+smbGYCPX5UcWO7B9TOr4UlD13EwVk/8u535DuoR0e1/TDYSeki30j1KerCpxy3Dk8PMTV8m/PAPxt2FteNrbnTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=US93eD0b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gucVEeBQ3abR50NZ5qLEaijIyYt/c/z+m5NkURR8eQA=; b=US93eD0bjF9bunkCdivpRguAhu
	kqMGg1x16bCsnQubyI/HWSvwO63SSvgj8zP6ebuLXPY2qsNEBt2svVncmCkKfbzn+SDYxIvD6d8ve
	rplCTX6qBUEN0Ib8/gzdqbNs1g76EOqGPcB+Mds/v4p4NuSUkOhtnPZsgdtv96PHvQyz+cYY/dJZY
	CyNJewfa1hqtC2uvDKulr5w6t4YsAT6Ct3+u3yyiJwEv/IUPS6BdBfgMnoAGkOLg1gIpXTY2RlpQO
	3tByfHhaY3+pgK2li7ng97slEgSYxnMpLZzAcn8jVwzAuG1BhsJgZIW4jsm1jVqyIzHBW0RpYpIr0
	hMmOcm/A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34700 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMC-000652-1P;
	Tue, 01 Oct 2024 17:04:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMA-005ZI3-Va; Tue, 01 Oct 2024 17:04:11 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:10 +0100

Move the PCS reset to .pcs_pre_config() rather than at creation time,
which means we call the reset function with the interface that we're
actually going to be using to talk to the downstream device.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # sja1105
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 39 +++++++++++++++++++++++++++---------
 include/linux/pcs/pcs-xpcs.h |  1 +
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 82463f9d50c8..7c6c40ddf722 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -659,6 +659,30 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
 }
 EXPORT_SYMBOL_GPL(xpcs_config_eee);
 
+static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+	const struct dw_xpcs_compat *compat;
+	int ret;
+
+	if (!xpcs->need_reset)
+		return;
+
+	compat = xpcs_find_compat(xpcs->desc, interface);
+	if (!compat) {
+		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+			phy_modes(interface));
+		return;
+	}
+
+	ret = xpcs_soft_reset(xpcs, compat);
+	if (ret)
+		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+			ERR_PTR(ret));
+
+	xpcs->need_reset = false;
+}
+
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
@@ -1365,6 +1389,7 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
 
 static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_validate = xpcs_validate,
+	.pcs_pre_config = xpcs_pre_config,
 	.pcs_config = xpcs_config,
 	.pcs_get_state = xpcs_get_state,
 	.pcs_an_restart = xpcs_an_restart,
@@ -1460,18 +1485,12 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 
 static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
-	const struct dw_xpcs_compat *compat;
-
-	compat = xpcs_find_compat(xpcs->desc, interface);
-	if (!compat)
-		return -EINVAL;
-
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs->pcs.poll = false;
-		return 0;
-	}
+	else
+		xpcs->need_reset = true;
 
-	return xpcs_soft_reset(xpcs, compat);
+	return 0;
 }
 
 static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index b4a4eb6c8866..fd75d0605bb6 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -61,6 +61,7 @@ struct dw_xpcs {
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
+	bool need_reset;
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.30.2


