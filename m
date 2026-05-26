Return-Path: <netdev+bounces-291630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELOrLGltFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B6B5D3B94
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4176B303071F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5E3DF018;
	Tue, 26 May 2026 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="127YGpCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB53DE44B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788881; cv=none; b=RXd9jMEe2jMf2IJ+1TKXDHt8STrRKUagLcJQUrUsdPOCoMCkwGlXfJtKv9uR0kbEwc0XyrvFhComvBBNdxLm/zVbE9ZKuezwu9s/0ouVQ7DvGP6Njy3ihQcUSDSCc/7u44h6jp3H6+zQBCtUAOjebGetJnhHmnCdUeR5WkbMQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788881; c=relaxed/simple;
	bh=hzRu9sY1TexaOQYaEXbujNtRV7bArS5rlfB7GNAN8Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKvDXgGM45I5+9jj0OmWWTTPS1uRG9giZscXCqkg5X0SV2SVGi1kjg3GVIwDvu8dJx2NRRSJWb+UMc/ji9u5KasWmlyITSgzJxAKZ1yJZODioFxV74V1zm231TsT4CQYqaOHAzd1IMsYSnvLZzSEJdoIxLiVCX2SrUF+J+gegh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=127YGpCF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 59A631A36CE;
	Tue, 26 May 2026 09:47:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C27B60732;
	Tue, 26 May 2026 09:47:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D42710888582;
	Tue, 26 May 2026 11:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nHWkjNMpqsqTnSKiOm8i7Nm0HYKAvN1ZNA2K3QcMkbo=;
	b=127YGpCFUWQlfirVvSc3f+axLVo2v9OBZWqUlcNPu9xs3Xct67fVO3MFMLBlXiy/80eodn
	tf19sgH9GOVJbEhwn/POViPLttz+hEOcadsoyTWsRK06SuHszttonkgP313zoMsD6Be5SJ
	zU5A51P8/i0fPBJGNCuPCKg/0vSxYxrtejTwU5Szf72C0LbAyasysmhcoquALrV8LqgEt4
	4EnyZVjJftmON1eHOe9zf6xiL+/1AdWl5IvtpDN0eDCIlk7U4cd+4qQ+AvCOoT0PZx8bK7
	ZQCujPYVKQtrB7AxcBqw+lhRBIdfSccmUBYr4yn8+BDjoWiVyzhWqbrMNIg2+w==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:34 +0200
Subject: [PATCH net-next 8/9] net: dsa: microchip: implement
 lan937x-specific MDIO registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260526-clean-ksz-3rd-v1-8-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 59B6B5D3B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All the switches use a common mdio_register() function that uses two
ksz_dev_ops callbacks (.mdio_bus_preinit() and .create_phy_addr_map())
to handle the lan937x specific case. These two callbacks are used only
at this place in the code.

Implement a new lan937x-specific MDIO registration functions that uses
these two lan937x-specific functions. The lan937x bindings don't
have any 'interrupts' property so this lan937x_mdio_register() doesn't
call ksz_irq_phy_setup().
Expose the common ksz_*_mdio_{read/write} functions so they can be used
in lan937x.c
Remove the callbacks from ksz_dev_ops.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c   | 30 +++-------
 drivers/net/dsa/microchip/ksz_common.h   | 42 ++------------
 drivers/net/dsa/microchip/lan937x_main.c | 99 +++++++++++++++++++++++++++++++-
 3 files changed, 110 insertions(+), 61 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 404399737cea..708dddf2c6cf 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2256,7 +2256,7 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 	dev->dev_ops->cfg_port_member(dev, port, port_member | cpu_port);
 }
 
-static int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum)
+int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct ksz_device *dev = bus->priv;
 	struct dsa_switch *ds = dev->ds;
@@ -2264,8 +2264,7 @@ static int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum)
 	return ds->ops->phy_read(ds, addr, regnum);
 }
 
-static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
-			     u16 val)
+int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
 {
 	struct ksz_device *dev = bus->priv;
 	struct dsa_switch *ds = dev->ds;
@@ -2286,7 +2285,7 @@ static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
  *
  * Return: Value of the PHY register, or a negative error code on failure.
  */
-static int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum)
+int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct ksz_device *dev = bus->priv;
 
@@ -2306,8 +2305,7 @@ static int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum)
  *
  * Return: 0 on success, or a negative error code on failure.
  */
-static int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum,
-				 u16 val)
+int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
 {
 	struct ksz_device *dev = bus->priv;
 
@@ -2415,8 +2413,8 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
  *
  * Return: 0 on success, or a negative error code on failure.
  */
-static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
-				   struct device_node *mdio_np)
+int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
+			    struct device_node *mdio_np)
 {
 	struct device_node *phy_node, *phy_parent_node;
 	bool phys_are_valid = true;
@@ -2519,20 +2517,8 @@ int ksz_mdio_register(struct ksz_device *dev)
 		goto put_mdio_node;
 	}
 
-	if (dev->dev_ops->mdio_bus_preinit) {
-		ret = dev->dev_ops->mdio_bus_preinit(dev, !!parent_bus);
-		if (ret)
-			goto put_mdio_node;
-	}
-
-	if (dev->dev_ops->create_phy_addr_map) {
-		ret = dev->dev_ops->create_phy_addr_map(dev, !!parent_bus);
-		if (ret)
-			goto put_mdio_node;
-	} else {
-		for (i = 0; i < dev->info->port_cnt; i++)
-			dev->phy_addr_map[i] = i;
-	}
+	for (i = 0; i < dev->info->port_cnt; i++)
+		dev->phy_addr_map[i] = i;
 
 	bus->priv = dev;
 	if (parent_bus) {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c8f9ac6c3a38..a7fc23ced38c 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -362,42 +362,6 @@ struct ksz_dev_ops {
 	u32 (*get_port_addr)(int port, int offset);
 	void (*cfg_port_member)(struct ksz_device *dev, int port, u8 member);
 
-	/**
-	 * @mdio_bus_preinit: Function pointer to pre-initialize the MDIO bus
-	 *                    for accessing PHYs.
-	 * @dev: Pointer to device structure.
-	 * @side_mdio: Boolean indicating if the PHYs are accessed over a side
-	 *             MDIO bus.
-	 *
-	 * This function pointer is used to configure the MDIO bus for PHY
-	 * access before initiating regular PHY operations. It enables either
-	 * SPI/I2C or side MDIO access modes by unlocking necessary registers
-	 * and setting up access permissions for the selected mode.
-	 *
-	 * Return:
-	 *  - 0 on success.
-	 *  - Negative error code on failure.
-	 */
-	int (*mdio_bus_preinit)(struct ksz_device *dev, bool side_mdio);
-
-	/**
-	 * @create_phy_addr_map: Function pointer to create a port-to-PHY
-	 *                       address map.
-	 * @dev: Pointer to device structure.
-	 * @side_mdio: Boolean indicating if the PHYs are accessed over a side
-	 *             MDIO bus.
-	 *
-	 * This function pointer is responsible for mapping switch ports to PHY
-	 * addresses according to the configured access mode (SPI or side MDIO)
-	 * and the device’s strap configuration. The mapping setup may vary
-	 * depending on the chip variant and configuration. Ensures the correct
-	 * address mapping for PHY communication.
-	 *
-	 * Return:
-	 *  - 0 on success.
-	 *  - Negative error code on failure (e.g., invalid configuration).
-	 */
-	int (*create_phy_addr_map)(struct ksz_device *dev, bool side_mdio);
 	void (*r_mib_cnt)(struct ksz_device *dev, int port, u16 addr,
 			  u64 *cnt);
 	void (*r_mib_pkt)(struct ksz_device *dev, int port, u16 addr,
@@ -493,6 +457,12 @@ int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 int ksz_suspend(struct dsa_switch *ds);
 int ksz_resume(struct dsa_switch *ds);
 
+int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
+			    struct device_node *mdio_np);
+int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum);
+int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
+int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum);
+int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
 int ksz_mdio_register(struct ksz_device *dev);
 int ksz_pirq_setup(struct ksz_device *dev, u8 p);
 int ksz_girq_setup(struct ksz_device *dev);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 742b919ae4df..73ad99dac72d 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/phy.h>
+#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
@@ -681,6 +682,100 @@ static int lan937x_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
+/**
+ * lan937x_mdio_register - Register and configure the MDIO bus for the LAN937x.
+ * @dev: Pointer to the KSZ device structure.
+ *
+ * This function sets up and registers an MDIO bus for a LAN937x switch,
+ * allowing access to its internal PHYs. If the device supports side MDIO,
+ * the function will configure the external MDIO controller specified by the
+ * "mdio-parent-bus" device tree property to directly manage internal PHYs.
+ * Otherwise, SPI or I2C access is set up for PHY access.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int lan937x_mdio_register(struct ksz_device *dev)
+{
+	struct device_node *parent_bus_node;
+	struct mii_bus *parent_bus = NULL;
+	struct dsa_switch *ds = dev->ds;
+	struct device_node *mdio_np;
+	struct mii_bus *bus;
+	int ret;
+
+	mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
+	if (!mdio_np)
+		return 0;
+
+	parent_bus_node = of_parse_phandle(mdio_np, "mdio-parent-bus", 0);
+	if (parent_bus_node && !dev->info->phy_side_mdio_supported) {
+		dev_err(dev->dev, "Side MDIO bus is not supported for this HW, ignoring 'mdio-parent-bus' property.\n");
+		ret = -EINVAL;
+
+		goto put_mdio_node;
+	} else if (parent_bus_node) {
+		parent_bus = of_mdio_find_bus(parent_bus_node);
+		if (!parent_bus) {
+			ret = -EPROBE_DEFER;
+
+			goto put_mdio_node;
+		}
+
+		dev->parent_mdio_bus = parent_bus;
+	}
+
+	bus = devm_mdiobus_alloc(ds->dev);
+	if (!bus) {
+		ret = -ENOMEM;
+		goto put_mdio_node;
+	}
+
+	ret = lan937x_mdio_bus_preinit(dev, !!parent_bus);
+	if (ret)
+		goto put_mdio_node;
+
+	ret = lan937x_create_phy_addr_map(dev, !!parent_bus);
+	if (ret)
+		goto put_mdio_node;
+
+	bus->priv = dev;
+	if (parent_bus) {
+		bus->read = ksz_parent_mdio_read;
+		bus->write = ksz_parent_mdio_write;
+		bus->name = "KSZ side MDIO";
+		snprintf(bus->id, MII_BUS_ID_SIZE, "ksz-side-mdio-%d",
+			 ds->index);
+	} else {
+		bus->read = ksz_sw_mdio_read;
+		bus->write = ksz_sw_mdio_write;
+		bus->name = "ksz user smi";
+		if (ds->dst->index != 0)
+			snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d-%d", ds->dst->index, ds->index);
+		else
+			snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+	}
+
+	ret = ksz_parse_dt_phy_config(dev, bus, mdio_np);
+	if (ret)
+		goto put_mdio_node;
+
+	ds->phys_mii_mask = bus->phy_mask;
+	bus->parent = ds->dev;
+
+	ds->user_mii_bus = bus;
+
+	ret = devm_of_mdiobus_register(ds->dev, bus, mdio_np);
+	if (ret)
+		dev_err(ds->dev, "unable to register MDIO bus %s\n",
+			bus->id);
+
+put_mdio_node:
+	of_node_put(mdio_np);
+	of_node_put(parent_bus_node);
+
+	return ret;
+}
+
 static int lan937x_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -794,7 +889,7 @@ static int lan937x_setup(struct dsa_switch *ds)
 		goto port_release;
 	}
 
-	ret = ksz_mdio_register(dev);
+	ret = lan937x_mdio_register(dev);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to register the mdio");
 		goto out_ptp_clock_unregister;
@@ -857,8 +952,6 @@ const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 const struct ksz_dev_ops lan937x_dev_ops = {
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
-	.create_phy_addr_map = lan937x_create_phy_addr_map,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
 	.r_mib_pkt = ksz9477_r_mib_pkt,
 	.r_mib_stat64 = ksz_r_mib_stats64,

-- 
2.54.0


