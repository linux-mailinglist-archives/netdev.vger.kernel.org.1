Return-Path: <netdev+bounces-210568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F4B13F2E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C43A52A0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8D271A84;
	Mon, 28 Jul 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z1lR3FYI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B82741C2
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717605; cv=none; b=bBNKDsswnBUSdUE5xLzwFXWNCp0lxxa9z01dhJfjhqcOoLEN6fwWRdinM/SQCSoI3LvTkHjBzVoVmMkTbxvnGQOxnEoXkYIc7LvYy0XvkhShSCZ/ff4yG33NRs9ecbhuLKfkYvVjoRULEwnkSY8Ubd82Sdu0ppx1SVdCO845ziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717605; c=relaxed/simple;
	bh=GPfwDkHJHerXqx4OnBe3lZKL8Yw2KkFCu5A+v7htVjE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WZsdvt6aR+/H+Spl+xbM2+Qn5HE/AJLv0SXb6MVrLi8Wfw+CHx3ufvvnvmo0XYwKEMPp9Dowap0f7qI9eOkYFrCUrqVJZb9yo0e70uS/qK1aANDy55GTsFu6QtKKuLgOooR03mz6rw3HgAMsqSJSJz2C1L1gGeqqT2xzJ8+lVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z1lR3FYI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hvpIuIYR+OFZWfZ+noueKHmU0ee5RQLXv8mbWGSuBsw=; b=Z1lR3FYIP49Z9k1MorzRPnrMHG
	CedRUGtvJDyzN4J0cYnbsqxGHDkT00bZ17ACNq3UKY9mBOqKSmZb6ZuB6IXYxjVrNyid1gEBUCZoF
	L3oYho/a15hewwVtueD3UQ3meSqfuRhM6W0xpf/LIWskSPZ81b9xw92ajbeEzpGasraOlOHALwxaj
	dVLNaj1MJ3q4Y6QmskK03YtIZkt5I+jSYUWrQ6K753ExCycbclR6v157vNWsEOhwpZI6bPR89yMBR
	TDefZq0uuk57ZpqmkUwDxuJz+4JReRHsVd9KdOc/DT3srMeYtPvrvk49F2TrGRAorItQcNIja6myi
	lwQPS3Ag==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54450 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ugQ3g-0000Up-11;
	Mon, 28 Jul 2025 16:46:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ugQ2y-006KDL-K7; Mon, 28 Jul 2025 16:45:52 +0100
In-Reply-To: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 5/7] net: stmmac: use core wake IRQ support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ugQ2y-006KDL-K7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 28 Jul 2025 16:45:52 +0100

The PM core provides management of wake IRQs along side setting the
device wake enable state. In order to use this, we need to register
the interrupt used to wakeup the system using devm_pm_set_wake_irq()
or dev_pm_set_wake_irq(). The core will then enable or disable IRQ
wake state on this interrupt as appropriate.

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
index cda09cf5dcca..e1df59a643e3 100644
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
index 6a4ef32f57ec..7d467b494685 100644
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


