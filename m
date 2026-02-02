Return-Path: <netdev+bounces-256024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MHgK08kgWnCEQMAu9opvQ
	(envelope-from <netdev+bounces-256024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15050D2202
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3823028357
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1303A34B691;
	Mon,  2 Feb 2026 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r4v/UGtL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3595335097
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071047; cv=none; b=KjpoCjErZeP1+hhYREbAKhI/iPuyUA6NIEwA4e8iNgoupJY81s4f+bj7FFQBGXmOUSIKVnAuZjooy4rrfOQqWrj4GRNE+ngkOxDkSZhfZwfq9N80h9gsJF0J7UKlncKvxSU/lQ4s+UnPnjTw4VMac0WGOSkz3sbQInjapfiYiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071047; c=relaxed/simple;
	bh=AetDwO46ZhBMfZ4oEXPf1L25ctycj5Dsf+H2VEBztxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJeoKXvVCZsOGH1cqdFgWkHNHKjeU12uY2qy2m0zKxxWk7qJGldEuhmY7uBaYSPh4PVVHAbUrkAcoYRq55pCQmIFcPNMzNBJF4IsfSZnj3z4rt7eMfS9jUQGpT/XiGyAz1grVtNADaBOp/QuIadYtnkwfRKCI3jxQWMnW1zC0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r4v/UGtL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R07+WFKsROkJ/0bkPSwXlUMloUzMBmhxbjZDo50qUpU=; b=r4v/UGtLlmi422VxNfwr9D06dV
	f4vDNxMe4Sm6QyIr1fbAIFeiUGHdAl68eE6eYbzQ67Gglvu3Qd0uRIj0NmH+gSjQmZ9mipbF4qyk5
	Qz04iQfl+P6EidVLaTNY0qe1WNq8mhS0EH+jYsJUo2lpZ/CrXfsK7k/71Ecww+x0+2t+RGZWChWEX
	595yVAy84LQFGT1K6HKXaxoKmX7PJTnnAsPCv7ARWExThspuvLQUYLft2kREwN0cLEzOVET+GPVNF
	emRG9E/9s+ASwSJyL2n3pyE5+G0yYd4TJ7EFIKQKuTBD47lLbeF0DmTSffB06+TnbVAaZxJ50bQAP
	NlbskKUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57944)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vn2Kk-000000004RO-3H5x;
	Mon, 02 Feb 2026 22:23:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vn2Kg-000000003lb-0IMd;
	Mon, 02 Feb 2026 22:23:46 +0000
Date: Mon, 2 Feb 2026 22:23:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Wei Fang <wei.fang@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
Message-ID: <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,gmail.com,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15050D2202
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> 
> Hi Russell,
> 
> On 11/24/25 1:27 PM, Russell King (Oracle) wrote:
> > Some platforms have problems when EEE is enabled, and thus need a way
> > to disable stmmac EEE support. Add a flag before the other LPI related
> > flags which tells stmmac to avoid populating the phylink LPI
> > capabilities, which causes phylink to call phy_disable_eee() for any
> > PHY that is attached to the affected phylink instance.
> > 
> > iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> > along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> > to the receive clock domain, and takes four clock cycles to clear, this
> > leads to interrupt storms as the interrupt remains asserted for some
> > time after the LPI control and status register is read.
> > 
> > This problem becomes worse when the receive clock from the PHY stops
> > when the receive path enters LPI state - which means that lpi_intr_o
> > can not deassert until the clock restarts. Since the LPI state of the
> > receive path depends on the link partner, this is out of our control.
> > We could disable RX clock stop at the PHY, but that doesn't get around
> > the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> > 
> > Previously, iMX8MP worked around this by disabling gigabit EEE, but
> > this is insufficient - the problem is also visible at 100M speeds,
> > where the receive clock is slower.
> > 
> > There is extensive discussion and investigation in the thread linked
> > below, the result of which is summarised in this commit message.
> > 
> 
> We are seeing the same lpi_intr_o interrupt storm on the Renesas RZ/V2H
> EVK (dwmac-renesas-gbeth.c). On this platform, lpi_intr_o is routed as a
> separate, dedicated interrupt line to the CPU rather than being OR'd
> with the main DWMAC interrupt as on iMX8MP. This corresponds to the
> "eth_lpi" interrupt in the stmmac bindings:
> """
> - description: The interrupt that occurs when Rx exits the LPI state
> const: eth_lpi
> """
> 
> Looking through the other glue drivers/device-trees, it looks to me that
> every platform that defines a separate "eth_lpi" irq might have the
> interrupt storm problem.

That is highly likely.

> To fix this issue on these platforms, rather than disabling EEE
> altogether, would it be possible to just not request the eth_lpi
> interrupt and let EEE continue to work? Perhaps a new flag could let
> each platform decide.

Yes, because lpi_intr_o serves no purpose from a software point of
view - see the commit message below for the details. I do like
removing code from stmmac :)

> If not, maybe this patch could be merged to add the flag that disables
> EEE and I will just send a patch to disable EEE on our platforms as well.

We still need the flag to disable EEE for platforms where lpi_intr_o is
logically OR'd with the other interrupts, so there's no way to ignore
its persistent assertion.

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: stmmac: remove support for lpi_intr_o

The dwmac databook for v3.74a states that lpi_intr_o is a sideband
signal which should be used to ungate the application clock, and this
signal is synchronous to the receive clock. The receive clock can run
at 2.5, 25 or 125MHz depending on the media speed, and can stop under
the control of the link partner. This means that the time it takes to
clear is dependent on the negotiated media speed, and thus can be 8,
40, or 400ns after reading the LPI control and status register.

It has been observed with some aggressive link partners, this clock
can stop while lpi_intr_o is still asserted, meaning that the signal
remains asserted for an indefinite period that the local system has
no direct control over.

The LPI interrupts will still be signalled through the main interrupt
path in any case, and this path is not dependent on the receive clock.

This, since we do not gate the application clock, and the chances of
adding clock gating in the future are slim due to the clocks being
ill-defined, lpi_intr_o serves no useful purpose. Remove the code which
requests the interrupt, and all associated code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
 include/linux/stmmac.h                        |  1 -
 7 files changed, 59 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1c5a4af85b58..d26e8a063022 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -394,7 +394,6 @@ enum request_irq_err {
 	REQ_IRQ_ERR_SFTY,
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
-	REQ_IRQ_ERR_LPI,
 	REQ_IRQ_ERR_WOL,
 	REQ_IRQ_ERR_MAC,
 	REQ_IRQ_ERR_NO,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index aad1be1ec4c1..92d77b0c2f54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -719,7 +719,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
-	plat->msi_lpi_vec = 28;
 	plat->msi_sfty_ce_vec = 27;
 	plat->msi_sfty_ue_vec = 26;
 	plat->msi_rx_base_vec = 0;
@@ -1177,8 +1176,6 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
 	if (plat->msi_wol_vec < STMMAC_MSI_VEC_MAX)
 		res->wol_irq = pci_irq_vector(pdev, plat->msi_wol_vec);
-	if (plat->msi_lpi_vec < STMMAC_MSI_VEC_MAX)
-		res->lpi_irq = pci_irq_vector(pdev, plat->msi_lpi_vec);
 	if (plat->msi_sfty_ce_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ce_irq = pci_irq_vector(pdev, plat->msi_sfty_ce_vec);
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
@@ -1294,7 +1291,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	 */
 	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
-	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ed0b534d8d7b..d66ae6ea4df5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -442,13 +442,6 @@ static int loongson_dwmac_dt_config(struct pci_dev *pdev,
 		res->wol_irq = res->irq;
 	}
 
-	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res->lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	ret = device_get_phy_mode(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "phy_mode not found\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 012b0a477255..aafd8c39be63 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -31,7 +31,6 @@ struct stmmac_resources {
 	void __iomem *addr;
 	u8 mac[ETH_ALEN];
 	int wol_irq;
-	int lpi_irq;
 	int irq;
 	int sfty_irq;
 	int sfty_ce_irq;
@@ -297,7 +296,6 @@ struct stmmac_priv {
 	int wol_irq;
 	u32 gmii_address_bus_config;
 	struct timer_list eee_ctrl_timer;
-	int lpi_irq;
 	u32 tx_lpi_timer;
 	bool tx_lpi_clk_stop;
 	bool eee_enabled;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a451ae19f50..7925575fb348 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3734,10 +3734,6 @@ static void stmmac_free_irq(struct net_device *dev,
 			free_irq(priv->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
-		if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq)
-			free_irq(priv->lpi_irq, dev);
-		fallthrough;
-	case REQ_IRQ_ERR_LPI:
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
 			free_irq(priv->wol_irq, dev);
 		fallthrough;
@@ -3795,24 +3791,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		}
 	}
 
-	/* Request the LPI IRQ in case of another line
-	 * is used for LPI
-	 */
-	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
-		int_name = priv->int_name_lpi;
-		sprintf(int_name, "%s:%s", dev->name, "lpi");
-		ret = request_irq(priv->lpi_irq,
-				  stmmac_mac_interrupt,
-				  0, int_name, dev);
-		if (unlikely(ret < 0)) {
-			netdev_err(priv->dev,
-				   "%s: alloc lpi MSI %d (error: %d)\n",
-				   __func__, priv->lpi_irq, ret);
-			irq_err = REQ_IRQ_ERR_LPI;
-			goto irq_error;
-		}
-	}
-
 	/* Request the common Safety Feature Correctible/Uncorrectible
 	 * Error line in case of another line is used
 	 */
@@ -3952,19 +3930,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
 		}
 	}
 
-	/* Request the IRQ lines */
-	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
-		ret = request_irq(priv->lpi_irq, stmmac_interrupt,
-				  IRQF_SHARED, dev->name, dev);
-		if (unlikely(ret < 0)) {
-			netdev_err(priv->dev,
-				   "%s: ERROR: allocating the LPI IRQ %d (%d)\n",
-				   __func__, priv->lpi_irq, ret);
-			irq_err = REQ_IRQ_ERR_LPI;
-			goto irq_error;
-		}
-	}
-
 	/* Request the common Safety Feature Correctible/Uncorrectible
 	 * Error line in case of another line is used
 	 */
@@ -7752,7 +7717,6 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
-	priv->lpi_irq = res->lpi_irq;
 	priv->sfty_irq = res->sfty_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8979a50b5507..5c9fd91a1db9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -725,14 +725,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		stmmac_res->wol_irq = stmmac_res->irq;
 	}
 
-	stmmac_res->lpi_irq =
-		platform_get_irq_byname_optional(pdev, "eth_lpi");
-	if (stmmac_res->lpi_irq < 0) {
-		if (stmmac_res->lpi_irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
-	}
-
 	stmmac_res->sfty_irq =
 		platform_get_irq_byname_optional(pdev, "sfty");
 	if (stmmac_res->sfty_irq < 0) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 5199451dd0bc..2620f0217f88 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -300,7 +300,6 @@ struct plat_stmmacenet_data {
 	int int_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
-	int msi_lpi_vec;
 	int msi_sfty_ce_vec;
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
-- 
2.47.3

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

