Return-Path: <netdev+bounces-26745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E4778C0B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E203F1C20B2F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F506FDA;
	Fri, 11 Aug 2023 10:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706206FB8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:27:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAAD2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7/c9avSgn2KOY8TjD9WNtSakrLC45VW6D0+95tch8Xk=; b=bt7ozVVxewmGcGWmHG9SXyY7zw
	I0QvhFvbhFTgdlMRrU21Fl11ZJKHtkwYXizDpWH2Rc912SrRRcXVTPEqBtpaAzAV6JdCx+Ro3Sjyu
	pHAbWhEcsi01cGFFki5g9spNw1unwlMfLul+WGU27DXki7tp5ONDJK5ItQ0JutFYdcmzQUTRjOGVj
	aNumK6TykI2WEMLIvU1jmNs+F3zwoAeOphki77RY9lUFkvtq3kLJMAI6AkOECC6vvQN+31kY8723M
	q43AEw8oZakhiRg7unB/hb9ysPQK0P4TgdTNFyW3Lb4J5piDbRDpOlFK//7DkNdrIwgumuZtLOih8
	IgMaaP1Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58106 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qUPLi-0005M2-1U;
	Fri, 11 Aug 2023 11:26:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qUPLi-003XN6-Dr; Fri, 11 Aug 2023 11:26:30 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Andre Edich <andre.edich@microchip.com>,
	Antoine Tenart <atenart@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Divya Koppera <Divya.Koppera@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mathias Kresin <dev@kresin.me>,
	Maxim Kochetkov <fido_max@inbox.ru>,
	Michael Walle <michael@walle.cc>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Willy Liu <willy.liu@realtek.com>,
	Yuiko Oshino <yuiko.oshino@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phy: fix IRQ-based wake-on-lan over hibernate /
 power off
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Aug 2023 11:26:30 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Uwe reports:
"Most PHYs signal WoL using an interrupt. So disabling interrupts [at
shutdown] breaks WoL at least on PHYs covered by the marvell driver."

Discussing with Ioana, the problem which was trying to be solved was:
"The board in question is a LS1021ATSN which has two AR8031 PHYs that
share an interrupt line. In case only one of the PHYs is probed and
there are pending interrupts on the PHY#2 an IRQ storm will happen
since there is no entity to clear the interrupt from PHY#2's registers.
PHY#1's driver will get stuck in .handle_interrupt() indefinitely."

Further confirmation that "the two AR8031 PHYs are on the same MDIO
bus."

With WoL using interrupts to wake the system, in such a case, the
system will begin booting with an asserted interrupt. Thus, we need to
cope with an interrupt asserted during boot.

Solve this instead by disabling interrupts during PHY probe. This will
ensure in Ioana's situation that both PHYs of the same type sharing an
interrupt line on a common MDIO bus will have their interrupt outputs
disabled when the driver probes the device, but before we hook in any
interrupt handlers - thus avoiding the interrupt storm.

A better fix would be for platform firmware to disable the interrupting
devices at source during boot, before control is handed to the kernel.

Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
Link: 20230804071757.383971-1-u.kleine-koenig@pengutronix.de
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 61921d4dbb13..c7cf61fe41cf 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
 			goto out;
 	}
 
+	phy_disable_interrupts(phydev);
+
 	/* Start out supporting everything. Eventually,
 	 * a controller will attach, and may modify one
 	 * or both of these values
@@ -3333,16 +3335,6 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
-static void phy_shutdown(struct device *dev)
-{
-	struct phy_device *phydev = to_phy_device(dev);
-
-	if (phydev->state == PHY_READY || !phydev->attached_dev)
-		return;
-
-	phy_disable_interrupts(phydev);
-}
-
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3376,7 +3368,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-- 
2.30.2


