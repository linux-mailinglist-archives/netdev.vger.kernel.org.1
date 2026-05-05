Return-Path: <netdev+bounces-284543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEs+J3cx+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353E4D27C4
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83C0B3067456
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA594A33F7;
	Tue,  5 May 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpf4TzUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDE4A2E27
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004322; cv=none; b=Qlhe1efaCM1q67aFmsbJT8uyywdvWxELfZijO1qk1S3KmxJiV3PjgVxfsmSqel9BN2etFXUPnO9lmAP2g+6iaguuNj4IrcLucb75KHzOOKp8da+BlZJrWamuTUZlR+y6s+xKVBiyqUza70OXsbsH988T42zNwcfNMBJhnTokIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004322; c=relaxed/simple;
	bh=4yeAwzkSCEBJNzlb6PsjpfG5jvHrdfl25Khl/EwVQxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NoAQjSKu75VNmTbWDTGIJyHDX3TLxFEIJv9zyLfndqQLrOXZFXGfbfszeZbzqCK35NI6BB/mpZhqnlmJ6kHYFSgpH94d5K2ZNsXviPPY+XDKyLPFrdcoDLgDsYN2G2hPwGdzCCFFbUTLqcQgwGS1aMuWZN7mE9VNf3SVACIDrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpf4TzUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D3C2BCC7;
	Tue,  5 May 2026 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778004322;
	bh=4yeAwzkSCEBJNzlb6PsjpfG5jvHrdfl25Khl/EwVQxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vpf4TzUFItUbsgAvGWQPD1YwUSbcJkjCvmX/rt6z2LoKyveCbIvF6BGbwDszGPNMY
	 ZYMGW74CzqyiX51R06gT+uOmugXpKlv3pDHUNDXLOtHp8PCFOrB67PDUovcksZEW+1
	 mDKPP1PfBZEmG2qDBQkKQFnPB8cRYvD8PoBtK8Xw/hCzWWMQE3YOgqE4HTDgwjhUSq
	 Gy4aC/OzUxPGzjHU6axR9yLWpNCkCiIPo6w5Td+ob/1/0PWKAL/G5vYFf9+6oqEtDO
	 mPsnr98szcDXhowIFRTZZ5B7NifcOHF6XKZxVA2Eqb2+YGATQ+1a6wcmHAnU1fEB1Y
	 asmtJyUE7wJ2A==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] [net-next v5] w5100: remove unused gpio link detection
Date: Tue,  5 May 2026 20:04:59 +0200
Message-Id: <20260505180459.1247690-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260505180459.1247690-1-arnd@kernel.org>
References: <20260505180459.1247690-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1353E4D27C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284543-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]

From: Arnd Bergmann <arnd@arndb.de>

Since the platform_device support is now gone, nothing ever passes a
valid gpio number, and all the link state handling can go away.

An earlier version of my patch changed this to look up the GPIO descriptor
from devicetree and convert it all to the modern interface, but there
are no users of that binding at the moment.

Remove the gpio handling, which is now one of the last users of the
legacy gpio interface in platform-independent code.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20230127095839.3266452-1-arnd@kernel.org/
---
v5: rewrite to just remove gpio support
v4: rebase to 7.1
v3: include linux/gpio/consumer.h to avoid build failure without GPIOLIB
v2: replace CONFIG_WIZNET_BUS_SHIFT with a constant
---
 drivers/net/ethernet/wiznet/w5100-spi.c |  2 +-
 drivers/net/ethernet/wiznet/w5100.c     | 62 +------------------------
 drivers/net/ethernet/wiznet/w5100.h     |  3 +-
 3 files changed, 3 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100-spi.c b/drivers/net/ethernet/wiznet/w5100-spi.c
index 990a3cce8c0f..d2c5e99ab9c7 100644
--- a/drivers/net/ethernet/wiznet/w5100-spi.c
+++ b/drivers/net/ethernet/wiznet/w5100-spi.c
@@ -450,7 +450,7 @@ static int w5100_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	return w5100_probe(&spi->dev, ops, priv_size, mac, spi->irq, -EINVAL);
+	return w5100_probe(&spi->dev, ops, priv_size, mac, spi->irq);
 }
 
 static void w5100_spi_remove(struct spi_device *spi)
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index cfe6813ce805..53d8dc642fbd 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 
 #include "w5100.h"
 
@@ -155,8 +154,6 @@ struct w5100_priv {
 	u16 s0_rx_buf_size;
 
 	int irq;
-	int link_irq;
-	int link_gpio;
 
 	struct napi_struct napi;
 	struct net_device *ndev;
@@ -417,16 +414,6 @@ static void w5100_get_drvinfo(struct net_device *ndev,
 		sizeof(info->bus_info));
 }
 
-static u32 w5100_get_link(struct net_device *ndev)
-{
-	struct w5100_priv *priv = netdev_priv(ndev);
-
-	if (gpio_is_valid(priv->link_gpio))
-		return !!gpio_get_value(priv->link_gpio);
-
-	return 1;
-}
-
 static u32 w5100_get_msglevel(struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
@@ -629,24 +616,6 @@ static irqreturn_t w5100_interrupt(int irq, void *ndev_instance)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t w5100_detect_link(int irq, void *ndev_instance)
-{
-	struct net_device *ndev = ndev_instance;
-	struct w5100_priv *priv = netdev_priv(ndev);
-
-	if (netif_running(ndev)) {
-		if (gpio_get_value(priv->link_gpio) != 0) {
-			netif_info(priv, link, ndev, "link is up\n");
-			netif_carrier_on(ndev);
-		} else {
-			netif_info(priv, link, ndev, "link is down\n");
-			netif_carrier_off(ndev);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static void w5100_setrx_work(struct work_struct *work)
 {
 	struct w5100_priv *priv = container_of(work, struct w5100_priv,
@@ -690,9 +659,6 @@ static int w5100_open(struct net_device *ndev)
 	w5100_hw_start(priv);
 	napi_enable(&priv->napi);
 	netif_start_queue(ndev);
-	if (!gpio_is_valid(priv->link_gpio) ||
-	    gpio_get_value(priv->link_gpio) != 0)
-		netif_carrier_on(ndev);
 	return 0;
 }
 
@@ -712,7 +678,6 @@ static const struct ethtool_ops w5100_ethtool_ops = {
 	.get_drvinfo		= w5100_get_drvinfo,
 	.get_msglevel		= w5100_get_msglevel,
 	.set_msglevel		= w5100_set_msglevel,
-	.get_link		= w5100_get_link,
 	.get_regs_len		= w5100_get_regs_len,
 	.get_regs		= w5100_get_regs,
 };
@@ -735,8 +700,7 @@ void *w5100_ops_priv(const struct net_device *ndev)
 EXPORT_SYMBOL_GPL(w5100_ops_priv);
 
 int w5100_probe(struct device *dev, const struct w5100_ops *ops,
-		int sizeof_ops_priv, const void *mac_addr, int irq,
-		int link_gpio)
+		int sizeof_ops_priv, const void *mac_addr, int irq)
 {
 	struct w5100_priv *priv;
 	struct net_device *ndev;
@@ -787,7 +751,6 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	priv->ndev = ndev;
 	priv->ops = ops;
 	priv->irq = irq;
-	priv->link_gpio = link_gpio;
 
 	ndev->netdev_ops = &w5100_netdev_ops;
 	ndev->ethtool_ops = &w5100_ethtool_ops;
@@ -840,26 +803,8 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	if (err)
 		goto err_hw;
 
-	if (gpio_is_valid(priv->link_gpio)) {
-		char *link_name = devm_kzalloc(dev, 16, GFP_KERNEL);
-
-		if (!link_name) {
-			err = -ENOMEM;
-			goto err_gpio;
-		}
-		snprintf(link_name, 16, "%s-link", netdev_name(ndev));
-		priv->link_irq = gpio_to_irq(priv->link_gpio);
-		if (request_any_context_irq(priv->link_irq, w5100_detect_link,
-					    IRQF_TRIGGER_RISING |
-					    IRQF_TRIGGER_FALLING,
-					    link_name, priv->ndev) < 0)
-			priv->link_gpio = -EINVAL;
-	}
-
 	return 0;
 
-err_gpio:
-	free_irq(priv->irq, ndev);
 err_hw:
 	destroy_workqueue(priv->xfer_wq);
 err_wq:
@@ -877,8 +822,6 @@ void w5100_remove(struct device *dev)
 
 	w5100_hw_reset(priv);
 	free_irq(priv->irq, ndev);
-	if (gpio_is_valid(priv->link_gpio))
-		free_irq(priv->link_irq, ndev);
 
 	flush_work(&priv->setrx_work);
 	flush_work(&priv->restart_work);
@@ -914,9 +857,6 @@ static int w5100_resume(struct device *dev)
 		w5100_hw_start(priv);
 
 		netif_device_attach(ndev);
-		if (!gpio_is_valid(priv->link_gpio) ||
-		    gpio_get_value(priv->link_gpio) != 0)
-			netif_carrier_on(ndev);
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/wiznet/w5100.h b/drivers/net/ethernet/wiznet/w5100.h
index 481af3b6d9e8..76e1b8149041 100644
--- a/drivers/net/ethernet/wiznet/w5100.h
+++ b/drivers/net/ethernet/wiznet/w5100.h
@@ -29,8 +29,7 @@ struct w5100_ops {
 void *w5100_ops_priv(const struct net_device *ndev);
 
 int w5100_probe(struct device *dev, const struct w5100_ops *ops,
-		int sizeof_ops_priv, const void *mac_addr, int irq,
-		int link_gpio);
+		int sizeof_ops_priv, const void *mac_addr, int irq);
 void w5100_remove(struct device *dev);
 
 extern const struct dev_pm_ops w5100_pm_ops;
-- 
2.39.5


