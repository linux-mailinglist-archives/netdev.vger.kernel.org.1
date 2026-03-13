Return-Path: <netdev+bounces-267425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUDG4z6s2nWeQAAu9opvQ
	(envelope-from <netdev+bounces-267425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:52:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9142827EF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE2BE31D3EEB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B936D4F5;
	Fri, 13 Mar 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JrW+dX61"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2631E83C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402728; cv=none; b=XNe9s24K8kDX5kn5UVNVk/Bvu9NsaCGAwmavZI5oSKzpG+cqoWHCTmgppns6Eu1mdzi307ulYiIvNlAeu9w9L/TiavOde548tNSNNco8kTzZWkK7LLWfg+mmVsy6tHjUS80uKCG6NTP2+3SvqUlsJoRMnXJ1HKTmt0P05jnQ46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402728; c=relaxed/simple;
	bh=R7HdYWmWF71ZVXY+heGFL/jb54o7UKb5SmiGlvqgM7k=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Zwh7kPep2mSnZvF5aRaBJp5O4wDhyMOupmPR0z02HUc/3aQYTv30fR1jMevImNYdG7tjS6/lBFW/H1jdmp1n4skIVr9V+G8Srz0PoQlShleoVtDie5CovLRcjeplxSJ2DXiI8Oo5UL177sUg6VjS+VqIpO9C/DapP5lono6MMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JrW+dX61; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pjvmOUdFPEzL0W797PPwOdGoxTvJI66nOK1+4vE46v4=; b=JrW+dX61X5zpzTRcfWVGANZhVw
	akbCHK4En9AlQSYOFQZlAsDlOT3mthJ0KX6b91qJfQXoSvPK9oQ2w+Vm0cxkFSBuAgcencFUnzvt4
	Zxkgyej65rrMzz/WhV9I96XnyBF8SQ589jArWrIQIAyR4hmkKxnEKFtWZZ/BgC9I9qC7Zg9Bjdj1q
	ztTxldxKrizJgiLFG2qE0INDVQswoIuEZvYbDoKy82APv52xpkYB8mgwKvPSQOewEWN/Dl17is2gg
	CJszDMO3hWfPbeCZ3K6akCFEnEKRozGpaVYx1qo094TydePWFHsJDIVuWvHW1u5HzNVVAzMVW3kU4
	BaNPqclg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41352 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w113f-000000000sI-25Ix;
	Fri, 13 Mar 2026 11:51:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w113e-0000000DDwc-2oRv;
	Fri, 13 Mar 2026 11:51:58 +0000
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
Subject: [PATCH net-next v2] net: stmmac: move MSI data out of struct
 stmmac_priv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w113e-0000000DDwc-2oRv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 11:51:58 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267425-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.860];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: BE9142827EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Only three platforms supprt MSIs, which means having all the strings
and interrupt arrays always allocated wastes space. None of this data
is performance critical - this data is only used when requesting and
releasing the MSI interrupts.

Move the MSI data out of struct stmmac_priv into its own separately
allocated structure, and move its initialisation to a separate
function.

This removes 768 bytes from struct stmmac_priv.

Link: https://lore.kernel.org/r/aYtq4ypxXTvn_Is6@shell.armlinux.org.uk
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: fix AI review comments in stmmac_free_irq() and resolve the 80 column
wrap.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  31 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 102 +++++++++++-------
 2 files changed, 81 insertions(+), 52 deletions(-)

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
index 11150bddd872..124d7a00f9f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3725,6 +3725,7 @@ static void stmmac_free_irq(struct net_device *dev,
 			    enum request_irq_err irq_err, int irq_idx)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_msi *msi = priv->msi;
 	int j;
 
 	switch (irq_err) {
@@ -3732,28 +3733,30 @@ static void stmmac_free_irq(struct net_device *dev,
 		irq_idx = priv->plat->tx_queues_to_use;
 		fallthrough;
 	case REQ_IRQ_ERR_TX:
-		for (j = irq_idx - 1; j >= 0; j--) {
-			if (priv->tx_irq[j] > 0) {
-				irq_set_affinity_hint(priv->tx_irq[j], NULL);
-				free_irq(priv->tx_irq[j], &priv->dma_conf.tx_queue[j]);
+		for (j = irq_idx - 1; msi && j >= 0; j--) {
+			if (msi->tx_irq[j] > 0) {
+				irq_set_affinity_hint(msi->tx_irq[j], NULL);
+				free_irq(msi->tx_irq[j],
+					 &priv->dma_conf.tx_queue[j]);
 			}
 		}
 		irq_idx = priv->plat->rx_queues_to_use;
 		fallthrough;
 	case REQ_IRQ_ERR_RX:
-		for (j = irq_idx - 1; j >= 0; j--) {
-			if (priv->rx_irq[j] > 0) {
-				irq_set_affinity_hint(priv->rx_irq[j], NULL);
-				free_irq(priv->rx_irq[j], &priv->dma_conf.rx_queue[j]);
+		for (j = irq_idx - 1; msi && j >= 0; j--) {
+			if (msi->rx_irq[j] > 0) {
+				irq_set_affinity_hint(msi->rx_irq[j], NULL);
+				free_irq(msi->rx_irq[j],
+					 &priv->dma_conf.rx_queue[j]);
 			}
 		}
 
-		if (priv->sfty_ue_irq > 0 && priv->sfty_ue_irq != dev->irq)
-			free_irq(priv->sfty_ue_irq, dev);
+		if (msi && msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq)
+			free_irq(msi->sfty_ue_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_UE:
-		if (priv->sfty_ce_irq > 0 && priv->sfty_ce_irq != dev->irq)
-			free_irq(priv->sfty_ce_irq, dev);
+		if (msi && msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq)
+			free_irq(msi->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
@@ -3773,9 +3776,30 @@ static void stmmac_free_irq(struct net_device *dev,
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
@@ -3783,7 +3807,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	int i;
 
 	/* For common interrupt */
-	int_name = priv->int_name_mac;
+	int_name = msi->int_name_mac;
 	sprintf(int_name, "%s:%s", dev->name, "mac");
 	ret = request_irq(dev->irq, stmmac_mac_interrupt,
 			  0, int_name, dev);
@@ -3799,7 +3823,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	 * is used for WoL
 	 */
 	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
-		int_name = priv->int_name_wol;
+		int_name = msi->int_name_wol;
 		sprintf(int_name, "%s:%s", dev->name, "wol");
 		ret = request_irq(priv->wol_irq,
 				  stmmac_mac_interrupt,
@@ -3817,7 +3841,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	 * Error line in case of another line is used
 	 */
 	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
-		int_name = priv->int_name_sfty;
+		int_name = msi->int_name_sfty;
 		sprintf(int_name, "%s:%s", dev->name, "safety");
 		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
 				  0, int_name, dev);
@@ -3833,16 +3857,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
@@ -3851,16 +3875,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
@@ -3870,23 +3894,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
 
@@ -3894,23 +3918,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
 
@@ -7806,12 +7830,12 @@ static int __stmmac_dvr_probe(struct device *device,
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


