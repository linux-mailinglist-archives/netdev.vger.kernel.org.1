Return-Path: <netdev+bounces-60618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413A8203E6
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 08:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A573B2130E
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DEB6D6D5;
	Sat, 30 Dec 2023 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="PXV2QEk/"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBF1FAF
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D73DD240002;
	Sat, 30 Dec 2023 07:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703920742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC+DAyvS2yG5CUC1BuOWvwvO9d8meTKU/pOuBL0xeNo=;
	b=PXV2QEk/JoNZNWAX4wSHbyyDvT3rS5J4u6xVbA+tp2/E5FaPTpUrvvbRGedGR5wAkdkU3U
	30WvZFsV9FZcolBlkl6WauLEaoEX0twlF83hUqWtXNJjWABAKkvTmsPzQ5w4Wf1cRBhcqA
	jZqVreXMGN2c76tHHMKPFHdzcDEyRFr+AA3EZpHxRRfeFvTyo8P32aywUBZPU6rLdkUJi4
	H8WGw+ywbTxf4I9VdYBdi4K6b2qJ5wP6hMLQcM7J/kI9wOOq0Ao2Zb6yUJ0ujbZ5TrebAN
	acOfJlsEPc1Q7kBY4UjRV31X8cdTiCLZtpwUil0BEngV/b646dNbcX4ULQllRA==
Message-ID: <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com>
Date: Sat, 30 Dec 2023 10:18:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-9-luizluca@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231223005253.17891-9-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 23.12.2023 03:46, Luiz Angelo Daros de Luca wrote:
> This reverts commit fe7324b932222574a0721b80e72c6c5fe57960d1.
> 
> The use of user_mii_bus is inappropriate when the hardware is described
> with a device-tree [1].
> 
> Since all drivers currently implementing ds_switch_ops.phy_{read,write}
> were not updated to utilize the MDIO information from OF with the
> generic "dsa user mii", they might not be affected by this change.
> 
> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

This doesn't make sense to me: "The use of user_mii_bus is inappropriate
when the hardware is described with a device-tree." I think this is the
correct statement: "The use of user_mii_bus is inappropriate when the MDIO
bus of the switch is described on the device-tree."

The patch log is also not clear on why this leads to the removal of
OF-based registration from the DSA core driver.

I would change the patch log here to something like this:

net: dsa: do not populate user_mii_bus when switch MDIO bus is described

The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
switch is described on the device-tree [1].

To keep things simple, make [all subdrivers that control a switch [with
MDIO bus] probed on OF] register the bus on the subdriver.

The subdrivers that control switches [with MDIO bus] probed on OF must
follow this logic to support all cases properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

There can be a case where ds->user_mii_bus is not populated, but
ds_switch_ops.phy_{read,write} is. That would mean the subdriver controls a
switch probed on OF, and it lets the DSA core driver to populate
ds->user_mii_bus and register the bus. We don't want this to happen.
Therefore, ds_switch_ops.phy_{read,write} should be only used on the
subdrivers that control switches probed on platform_data.

With that, the "!ds->user_mii_bus && ds->ops->phy_read" check under
dsa_switch_setup() remains in use only for switches probed on
platform_data. Therefore, remove OF-based registration as it's useless now.

---

I think we should do all this in a single patch. I've done it on the MT7530
DSA subdriver which I maintain.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..bbd230a73ead 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2155,15 +2155,21 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  {
  	struct dsa_switch *ds = priv->ds;
  	struct device *dev = priv->dev;
+	struct device_node *np, *mnp;
  	struct mii_bus *bus;
  	static int idx;
  	int ret;
  
+	np = priv->dev->of_node;
+	mnp = of_get_child_by_name(np, "mdio");
+
  	bus = devm_mdiobus_alloc(dev);
  	if (!bus)
  		return -ENOMEM;
  
-	ds->user_mii_bus = bus;
+	if (mnp == NULL)
+		ds->user_mii_bus = bus;
+
  	bus->priv = priv;
  	bus->name = KBUILD_MODNAME "-mii";
  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2174,10 +2180,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  	bus->parent = dev;
  	bus->phy_mask = ~ds->phys_mii_mask;
  
-	if (priv->irq)
+	if (priv->irq && mnp == NULL)
  		mt7530_setup_mdio_irq(priv);
  
-	ret = devm_mdiobus_register(dev, bus);
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
  	if (ret) {
  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
  		if (priv->irq)

Arınç

