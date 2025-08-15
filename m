Return-Path: <netdev+bounces-214048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4851B27F3E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7636220B0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72902877CD;
	Fri, 15 Aug 2025 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j5wcYz69"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF086287247
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257589; cv=none; b=Igcmyt6r9wso7kTf3BCJSZoq/+wmUy5/FWUqTrSJXe9vQS3HKdvN8wGHj6XUw+bqcpKkMn+HpBfqucfEvy5Oyg9X1Owpnjq0Tz+lKXN2hH6uSC+lw6JbA0KNoqiyXQvGyFlJtAUNF46oisT7d+omuPtEboMIP76XjNE+IlWbnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257589; c=relaxed/simple;
	bh=2nMy/tqi7pEZxYqMs+4b8QVsUgJnma3jyuAS01GdJPU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZXHNh+kIH3x8CEMyS+I+MTZVBR+P1hvKZF6GzGB0cah3alLVzVYTRhNezPmwvHDHbSBeS1E5olvtBu1nFV32WsZql3BGjAKnEzzlpB347rrk8jtZx6cUf7DOqpJHrJG3UDXpUtIjlIz8j8frt+fGolJQAMTaCqiBQDlIinPqQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j5wcYz69; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QN1lkRj9Z/Xeof2lKh1zXqe0BYL9plrkCkxT01SueLQ=; b=j5wcYz699WblcRDzmmeF/CVJyq
	rwsJ+cYfmesalx22/SjEUC71zNvDVIYP+hs80HbLkzJkZaxSKCKMM9N9zrtogW1ZQoCCp/jzks3/e
	t631LrlkZXHzMfSsH4+nT8l8guvUrS5pLRsivlXqdeMkhwAD8iPaX5r+a5Yeqgq0BHIAw81hpfTEz
	Gu5+mZEwN76jhornRIbzhnRpt1/AyjMrAX1fIKE87Pw3VCLoHsk666FFpsOLdJp7xSh3YVfTj0W3B
	NVIvic083MCRsGYpVXaLjhnhjTDmpCwJJ/j2US9KJkjjU/vjIdgZpZd63rI+e3zn6oqaoGSrWmnHW
	U8iMU+Lw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45718 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsg8-00012Y-20;
	Fri, 15 Aug 2025 12:33:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsfP-008vKp-U1; Fri, 15 Aug 2025 12:32:15 +0100
In-Reply-To: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/7] net: stmmac: add helpers to indicate WoL enable
 status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsfP-008vKp-U1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:32:15 +0100

Add two helpers to abstract the WoL enable status at the PHY and MAC to
make the code easier to read.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h          | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 11 +++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b16b8aeeb583..78d6b3737a26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -375,6 +375,16 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
+static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
+{
+	return priv->plat->pmt && device_may_wakeup(priv->device);
+}
+
+static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
+{
+	return !priv->plat->pmt && device_may_wakeup(priv->device);
+}
+
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e715e9f2fe22..78113e2602ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7857,7 +7857,7 @@ int stmmac_suspend(struct device *dev)
 		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
 
 	/* Enable Power down mode by programming the PMT regs */
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+	if (stmmac_wol_enabled_mac(priv)) {
 		stmmac_pmt(priv, priv->hw, priv->wolopts);
 		priv->irq_wake = 1;
 	} else {
@@ -7868,11 +7868,10 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+	if (stmmac_wol_enabled_phy(priv))
 		phylink_speed_down(priv->phylink, false);
 
-	phylink_suspend(priv->phylink,
-			device_may_wakeup(priv->device) && priv->plat->pmt);
+	phylink_suspend(priv->phylink, stmmac_wol_enabled_mac(priv));
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -7948,7 +7947,7 @@ int stmmac_resume(struct device *dev)
 	 * this bit because it can generate problems while resuming
 	 * from another devices (e.g. serial console).
 	 */
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+	if (stmmac_wol_enabled_mac(priv)) {
 		mutex_lock(&priv->lock);
 		stmmac_pmt(priv, priv->hw, 0);
 		mutex_unlock(&priv->lock);
@@ -8001,7 +8000,7 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+	if (stmmac_wol_enabled_phy(priv))
 		phylink_speed_up(priv->phylink);
 
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index c849676d98e8..a3e077f225d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -934,7 +934,7 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
+	if (!stmmac_wol_enabled_mac(priv)) {
 		/* Disable clock in case of PWM is off */
 		clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
@@ -955,7 +955,7 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
+	if (!stmmac_wol_enabled_mac(priv)) {
 		/* enable the clk previously disabled */
 		ret = pm_runtime_force_resume(dev);
 		if (ret)
-- 
2.30.2


