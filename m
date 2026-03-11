Return-Path: <netdev+bounces-266651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGFOHVtwsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F5264AE0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684F030668E3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525331ED7C;
	Wed, 11 Mar 2026 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mp4OmuID"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B59846F;
	Wed, 11 Mar 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235959; cv=none; b=Ak60tTGOGmlmPnTe0PqsCSSnAJ+w+6Sd3UbWU3OJyMeLlKBHD8SGhIlX3GWj9A0FwMWtiypzpMc9By1gzCAr53TYOibPSdVz/KQ7UOXUqSaD78H9NrsbboJdqwJJzDuNc/ghk1ezvsCmqnfEfXdeluxnNQ/oq4ackfQ3XOStUV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235959; c=relaxed/simple;
	bh=5KWIx2eeor4DGBAJ65f034JdfkvDOFh6g4Jbum576uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqrLStoFuMgu+H60kjEiotD3Hl/V7Imr0p67oGLhzwN3DXlGYiKs1W+S0TR0vFTZTq+XDDn/RiUS/0YwYpIWn8yyi3DK9p1Mbv96VDpSeJFqxP/3UOH4lSd0m3TekxupH3YEFONG3n9oOvHD4JgYE3Q/d0HTLpEK9gj83Pi7PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mp4OmuID; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QEQFs0TTz6kOM3BeAm8PTLPbfl1GfhDYDZcp/vmbBkA=; b=mp4OmuID3KEVA4dSypFUZlxxwh
	PAJElXVaYdgvUKICIGCVgu4y+h7c6ivLTCwynjeF3P/eA+mS0SeVnoF1lm07xMTELYda5HoN7Rsm4
	qm0R0nX6twAj6I77L2mFROfBjVy73KU0vT29j1Knamm7lDJGOHFRakNzLCRLfsyW3SJwbA6rUoWUL
	3ROm3bD7HDSqo+4U4AAUTCtJqUJW+EB1qV3fhzFQqjCzkHPvJcyzuUxhYGeQ5Ta6VGlo5Ji4+0ja+
	dvtIXFI/F+SkPP6Z1YqCU0pV/yB/0qZ5pYrNHSL0jNLO1YUOG1x++miftWPtspOD/2QODLiUutEX9
	t6/+/BUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50500)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0Jff-000000006R7-0pos;
	Wed, 11 Mar 2026 13:32:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0Jfb-000000006Gm-0FRS;
	Wed, 11 Mar 2026 13:32:15 +0000
Date: Wed, 11 Mar 2026 13:32:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	vladimir.oltean@nxp.com, boon.khai.ng@altera.com
Subject: Re: [PATCH v10 0/5] Support multi-channel IRQs in stmmac platform
 drivers
Message-ID: <abFu3mJP0Y6Ra1BR@shell.armlinux.org.uk>
References: <20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 738F5264AE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,altera.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:17:57AM +0100, Jan Petrous via B4 Relay wrote:
> The stmmac core supports two interrupt modes, controlled by the
> flag STMMAC_FLAG_MULTI_MSI_EN:
> 
> - When the flag is set, the driver uses multi-channel IRQ mode (Multi-IRQ).
> - Otherwise, a single IRQ line is requested (aka MAC-IRQ):

Please can you test with this patch included - it's bubbled up near to
the top of my patch queue for net-next.

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: stmmac: move MSI data out of struct stmmac_priv

Only three platforms supprt MSIs, which means having all the strings
and interrupt arrays always allocated wastes space. None of this data
is performance critical - this data is only used when requesting and
releasing the MSI interrupts.

Move the MSI data out of struct stmmac_priv into its own separately
allocated structure, and move its initialisation to a separate
function.

This removes 768 bytes from struct stmmac_priv.

Link: https://lore.kernel.org/r/aYtq4ypxXTvn_Is6@shell.armlinux.org.uk
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 31 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 96 ++++++++++++-------
 2 files changed, 77 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index bba9bb9c95bf..7a66edba8f66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -243,6 +243,23 @@ struct stmmac_est {
 	u32 max_sdu[MTL_MAX_TX_QUEUES];
 };
 
+struct stmmac_msi {
+	int sfty_ce_irq;
+	int sfty_ue_irq;
+	int rx_irq[MTL_MAX_RX_QUEUES];
+	int tx_irq[MTL_MAX_TX_QUEUES];
+
+	/*irq name */
+	char int_name_mac[IFNAMSIZ + 9];
+	char int_name_wol[IFNAMSIZ + 9];
+	char int_name_lpi[IFNAMSIZ + 9];
+	char int_name_sfty[IFNAMSIZ + 10];
+	char int_name_sfty_ce[IFNAMSIZ + 10];
+	char int_name_sfty_ue[IFNAMSIZ + 10];
+	char int_name_rx_irq[MTL_MAX_RX_QUEUES][IFNAMSIZ + 14];
+	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
+};
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
@@ -329,19 +346,7 @@ struct stmmac_priv {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	unsigned int num_double_vlans;
 	int sfty_irq;
-	int sfty_ce_irq;
-	int sfty_ue_irq;
-	int rx_irq[MTL_MAX_RX_QUEUES];
-	int tx_irq[MTL_MAX_TX_QUEUES];
-	/*irq name */
-	char int_name_mac[IFNAMSIZ + 9];
-	char int_name_wol[IFNAMSIZ + 9];
-	char int_name_lpi[IFNAMSIZ + 9];
-	char int_name_sfty[IFNAMSIZ + 10];
-	char int_name_sfty_ce[IFNAMSIZ + 10];
-	char int_name_sfty_ue[IFNAMSIZ + 10];
-	char int_name_rx_irq[MTL_MAX_RX_QUEUES][IFNAMSIZ + 14];
-	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
+	struct stmmac_msi *msi;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 11150bddd872..24de4033c886 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3725,6 +3725,7 @@ static void stmmac_free_irq(struct net_device *dev,
 			    enum request_irq_err irq_err, int irq_idx)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_msi *msi = priv->msi;
 	int j;
 
 	switch (irq_err) {
@@ -3733,27 +3734,27 @@ static void stmmac_free_irq(struct net_device *dev,
 		fallthrough;
 	case REQ_IRQ_ERR_TX:
 		for (j = irq_idx - 1; j >= 0; j--) {
-			if (priv->tx_irq[j] > 0) {
-				irq_set_affinity_hint(priv->tx_irq[j], NULL);
-				free_irq(priv->tx_irq[j], &priv->dma_conf.tx_queue[j]);
+			if (msi->tx_irq[j] > 0) {
+				irq_set_affinity_hint(msi->tx_irq[j], NULL);
+				free_irq(msi->tx_irq[j], &priv->dma_conf.tx_queue[j]);
 			}
 		}
 		irq_idx = priv->plat->rx_queues_to_use;
 		fallthrough;
 	case REQ_IRQ_ERR_RX:
 		for (j = irq_idx - 1; j >= 0; j--) {
-			if (priv->rx_irq[j] > 0) {
-				irq_set_affinity_hint(priv->rx_irq[j], NULL);
-				free_irq(priv->rx_irq[j], &priv->dma_conf.rx_queue[j]);
+			if (msi->rx_irq[j] > 0) {
+				irq_set_affinity_hint(msi->rx_irq[j], NULL);
+				free_irq(msi->rx_irq[j], &priv->dma_conf.rx_queue[j]);
 			}
 		}
 
-		if (priv->sfty_ue_irq > 0 && priv->sfty_ue_irq != dev->irq)
-			free_irq(priv->sfty_ue_irq, dev);
+		if (msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq)
+			free_irq(msi->sfty_ue_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_UE:
-		if (priv->sfty_ce_irq > 0 && priv->sfty_ce_irq != dev->irq)
-			free_irq(priv->sfty_ce_irq, dev);
+		if (msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq)
+			free_irq(msi->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
@@ -3773,9 +3774,30 @@ static void stmmac_free_irq(struct net_device *dev,
 	}
 }
 
+static int stmmac_msi_init(struct stmmac_priv *priv,
+			   struct stmmac_resources *res)
+{
+	int i;
+
+	priv->msi = devm_kmalloc(priv->device, sizeof(*priv->msi), GFP_KERNEL);
+	if (!priv->msi)
+		return -ENOMEM;
+
+	priv->msi->sfty_ce_irq = res->sfty_ce_irq;
+	priv->msi->sfty_ue_irq = res->sfty_ue_irq;
+
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
+		priv->msi->rx_irq[i] = res->rx_irq[i];
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
+		priv->msi->tx_irq[i] = res->tx_irq[i];
+
+	return 0;
+}
+
 static int stmmac_request_irq_multi_msi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_msi *msi = priv->msi;
 	enum request_irq_err irq_err;
 	int irq_idx = 0;
 	char *int_name;
@@ -3783,7 +3805,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	int i;
 
 	/* For common interrupt */
-	int_name = priv->int_name_mac;
+	int_name = msi->int_name_mac;
 	sprintf(int_name, "%s:%s", dev->name, "mac");
 	ret = request_irq(dev->irq, stmmac_mac_interrupt,
 			  0, int_name, dev);
@@ -3799,7 +3821,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	 * is used for WoL
 	 */
 	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
-		int_name = priv->int_name_wol;
+		int_name = msi->int_name_wol;
 		sprintf(int_name, "%s:%s", dev->name, "wol");
 		ret = request_irq(priv->wol_irq,
 				  stmmac_mac_interrupt,
@@ -3817,7 +3839,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	 * Error line in case of another line is used
 	 */
 	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
-		int_name = priv->int_name_sfty;
+		int_name = msi->int_name_sfty;
 		sprintf(int_name, "%s:%s", dev->name, "safety");
 		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
 				  0, int_name, dev);
@@ -3833,16 +3855,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	/* Request the Safety Feature Correctible Error line in
 	 * case of another line is used
 	 */
-	if (priv->sfty_ce_irq > 0 && priv->sfty_ce_irq != dev->irq) {
-		int_name = priv->int_name_sfty_ce;
+	if (msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq) {
+		int_name = msi->int_name_sfty_ce;
 		sprintf(int_name, "%s:%s", dev->name, "safety-ce");
-		ret = request_irq(priv->sfty_ce_irq,
+		ret = request_irq(msi->sfty_ce_irq,
 				  stmmac_safety_interrupt,
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc sfty ce MSI %d (error: %d)\n",
-				   __func__, priv->sfty_ce_irq, ret);
+				   __func__, msi->sfty_ce_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY_CE;
 			goto irq_error;
 		}
@@ -3851,16 +3873,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	/* Request the Safety Feature Uncorrectible Error line in
 	 * case of another line is used
 	 */
-	if (priv->sfty_ue_irq > 0 && priv->sfty_ue_irq != dev->irq) {
-		int_name = priv->int_name_sfty_ue;
+	if (msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq) {
+		int_name = msi->int_name_sfty_ue;
 		sprintf(int_name, "%s:%s", dev->name, "safety-ue");
-		ret = request_irq(priv->sfty_ue_irq,
+		ret = request_irq(msi->sfty_ue_irq,
 				  stmmac_safety_interrupt,
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc sfty ue MSI %d (error: %d)\n",
-				   __func__, priv->sfty_ue_irq, ret);
+				   __func__, msi->sfty_ue_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY_UE;
 			goto irq_error;
 		}
@@ -3870,23 +3892,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
-		if (priv->rx_irq[i] == 0)
+		if (msi->rx_irq[i] == 0)
 			continue;
 
-		int_name = priv->int_name_rx_irq[i];
+		int_name = msi->int_name_rx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
-		ret = request_irq(priv->rx_irq[i],
+		ret = request_irq(msi->rx_irq[i],
 				  stmmac_msi_intr_rx,
 				  0, int_name, &priv->dma_conf.rx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
-				   __func__, i, priv->rx_irq[i], ret);
+				   __func__, i, msi->rx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_RX;
 			irq_idx = i;
 			goto irq_error;
 		}
-		irq_set_affinity_hint(priv->rx_irq[i],
+		irq_set_affinity_hint(msi->rx_irq[i],
 				      cpumask_of(i % num_online_cpus()));
 	}
 
@@ -3894,23 +3916,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		if (i >= MTL_MAX_TX_QUEUES)
 			break;
-		if (priv->tx_irq[i] == 0)
+		if (msi->tx_irq[i] == 0)
 			continue;
 
-		int_name = priv->int_name_tx_irq[i];
+		int_name = msi->int_name_tx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
-		ret = request_irq(priv->tx_irq[i],
+		ret = request_irq(msi->tx_irq[i],
 				  stmmac_msi_intr_tx,
 				  0, int_name, &priv->dma_conf.tx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
-				   __func__, i, priv->tx_irq[i], ret);
+				   __func__, i, msi->tx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_TX;
 			irq_idx = i;
 			goto irq_error;
 		}
-		irq_set_affinity_hint(priv->tx_irq[i],
+		irq_set_affinity_hint(msi->tx_irq[i],
 				      cpumask_of(i % num_online_cpus()));
 	}
 
@@ -7806,12 +7828,12 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
 	priv->sfty_irq = res->sfty_irq;
-	priv->sfty_ce_irq = res->sfty_ce_irq;
-	priv->sfty_ue_irq = res->sfty_ue_irq;
-	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
-		priv->rx_irq[i] = res->rx_irq[i];
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
-		priv->tx_irq[i] = res->tx_irq[i];
+
+	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
+		ret = stmmac_msi_init(priv, res);
+		if (ret)
+			return ret;
+	}
 
 	if (!is_zero_ether_addr(res->mac))
 		eth_hw_addr_set(priv->dev, res->mac);
-- 
2.47.3

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

