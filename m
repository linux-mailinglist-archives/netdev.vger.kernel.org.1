Return-Path: <netdev+bounces-214047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB482B27F3F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0812EAE625C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974A286D52;
	Fri, 15 Aug 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vdd7VkHx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D02857CC
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257583; cv=none; b=hmioOIi8DtFUuVRxRi11jqKql1DWbVV6nCNh6ID6EkBBniyovkeHqmd1NuFGWF8gdIKOqEtlWczRaEfkBFvC8TH5ctH62YflF15yZbWO8sFR4QGMjRuUuY+arQ39OX+DH0DUvzG4hUSwlgLWloiq7xjTuHVQNJkn0dduaNgcUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257583; c=relaxed/simple;
	bh=fK+8yUKjxtZ+kcL1nu9EvhGqVi+lb2QrEE1vZntkVtw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FY3TP6xLhsG7jGOm85bU5N4COIsGI2r69k41Q7E11bdJHnsugBSE2zqYRM+S5n2vyBIqW9GGGKf+g9sr2VO6FcNH4Q4ARJIrQCr8MlYfeoWuDFy7lwMFpOMbLZRff76fEXRE93b+SNAapaPn649KLPwyPh+lDEc8GlPvVWdW2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vdd7VkHx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bo2VFsEvx+fN7c8gTRD/Vrtsf+k2CrLOmw1eJfPwpU8=; b=Vdd7VkHxf9l/miVsisKi8HxBJu
	MMD3xMgbH9/Y1YXApdfiXdD3grZA2wz9DO9d960tF8FIXpMbxd5QlS9+7F2uJtBXNAMLIfv3m0F8/
	If3ct396y4akRuvPIBTO6C/PlcmRZhhJHbb6lH4bzO8Le5n2qvPHJznNCTvqvcraocCE0xQXGSZJR
	E7B76tS5qzfUwHBuBGTj480Ev1+/vh7qQHNGCqSZS2ZVSgBTsllBUG8DZFWvTBTsGJnw8VY0RqMfy
	7Jg4/dXBTOhRY3Xxu89IExzRTlPT6V8bPCxX7nll82ypqanfTd5vJx3tlxLIC/J+wXTcU82lRlus3
	xvDp6+zw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45706 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsg3-00012H-1o;
	Fri, 15 Aug 2025 12:32:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsfK-008vKj-Pw; Fri, 15 Aug 2025 12:32:10 +0100
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
Subject: [PATCH net-next 5/7] net: stmmac: use core wake IRQ support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsfK-008vKj-Pw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:32:10 +0100

The PM core provides management of wake IRQs along side setting the
device wake enable state. In order to use this, we need to register
the interrupt used to wakeup the system using devm_pm_set_wake_irq()
or dev_pm_set_wake_irq(). The core will then enable or disable IRQ
wake state on this interrupt as appropriate, depending on the
device_set_wakeup_enable() state. device_set_wakeup_enable() does not
care about having balanced enable/disable calls.

Make use of this functionality, rather than explicitly managing the
IRQ enable state in the set_wol() ethtool op. This removes the IRQ
wake state management from stmmac.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 14 +-------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  4 ++--
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index bf95f03dd33f..b16b8aeeb583 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -289,7 +289,6 @@ struct stmmac_priv {
 	u32 msg_enable;
 	int wolopts;
 	int wol_irq;
-	bool wol_irq_disabled;
 	int clk_csr;
 	struct timer_list eee_ctrl_timer;
 	int lpi_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 58542b72cc01..39fa1ec92f82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -815,19 +815,7 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
-	if (wol->wolopts) {
-		device_set_wakeup_enable(priv->device, 1);
-		/* Avoid unbalanced enable_irq_wake calls */
-		if (priv->wol_irq_disabled)
-			enable_irq_wake(priv->wol_irq);
-		priv->wol_irq_disabled = false;
-	} else {
-		device_set_wakeup_enable(priv->device, 0);
-		/* Avoid unbalanced disable_irq_wake calls */
-		if (!priv->wol_irq_disabled)
-			disable_irq_wake(priv->wol_irq);
-		priv->wol_irq_disabled = true;
-	}
+	device_set_wakeup_enable(priv->device, !!wol->wolopts);
 
 	mutex_lock(&priv->lock);
 	priv->wolopts = wol->wolopts;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c24b890e1089..e715e9f2fe22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/prefetch.h>
 #include <linux/pinctrl/consumer.h>
 #ifdef CONFIG_DEBUG_FS
@@ -3724,7 +3725,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	/* Request the Wake IRQ in case of another line
 	 * is used for WoL
 	 */
-	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
 		int_name = priv->int_name_wol;
 		sprintf(int_name, "%s:%s", dev->name, "wol");
@@ -3885,7 +3885,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
 	/* Request the Wake IRQ in case of another line
 	 * is used for WoL
 	 */
-	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
 		ret = request_irq(priv->wol_irq, stmmac_interrupt,
 				  IRQF_SHARED, dev->name, dev);
@@ -7277,6 +7276,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->plat->pmt) {
 		dev_info(priv->device, "Wake-Up On Lan supported\n");
 		device_set_wakeup_capable(priv->device, 1);
+		devm_pm_set_wake_irq(priv->device, priv->wol_irq);
 	}
 
 	if (priv->dma_cap.tsoen)
-- 
2.30.2


