Return-Path: <netdev+bounces-143480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D79C2962
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428EF2850E2
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341378C8B;
	Sat,  9 Nov 2024 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C+Eb6Pku"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958B3FB9C;
	Sat,  9 Nov 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117420; cv=none; b=klQNsdot3vcX18ErliaKTk3GzhGuzZe6lfMLSPJnocgaNzUsuzsoOCOq+p9ntXLYbPY9LUqEuUFpJhMlSqbGYoIlsk9k7avfUhQ7xBsGz2XjhefDNo3Ahr17ykoig3SEvYDvmXXNaNa7dJ9Mqiz9/O3eaZnsE3OkbJDcCAwAo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117420; c=relaxed/simple;
	bh=6WZQcKjzmj9X8VA2pSpmco60CCWNimwKBp1muR4dBlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpVNfpnM8nGOTnuq3dGfZZ+g3ZbOS07GrQishxQ7m+5t2A+mehMRfT42tveE4gztQROqJ4gIkQ63UVvHdeuXNbIYjZwKZKwEYz1rGnFQqxIXbcPVbXF4Zck2SiYzxJbPWk96PPwfXN12GpsLimA1by3A3F1K/M0Ba66GYauMFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C+Eb6Pku; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117417; x=1762653417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WZQcKjzmj9X8VA2pSpmco60CCWNimwKBp1muR4dBlw=;
  b=C+Eb6PkubNHNfBc6AeFoE85aBSZxwen9L7cCvXk/ENwH12SYB8LwHuk6
   ll3uuEDSAaH82xxRy2CQguCtJDNlofDKOWFLybwYVlsQFhxvEANNO1BEU
   haMDqxMFqzEvmGvoqqWFRMp2rqAVoy3/mbUCnilN5ULKxaV7Gq93hn07v
   arvmojOtnBoLKUfJn49JTf/JScB9mpbVUrQbK7zUirDDsih06vpdUGdnZ
   EpMwHYD0p+E/WaKlcKVW12PlfBs2CGA3dXuY9/ZMrtzC5YjP1ZjdB8wpX
   wFm1Lo596Q+w7jMmgBfcQuOcwS1o9Y/GiF2N1CJRgePXdVYiD5ZFpFLP+
   Q==;
X-CSE-ConnectionGUID: 5vaTV7aQT/yecz//2xjQUw==
X-CSE-MsgGUID: evj5emFBSWenCDiyK/oyvQ==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="37590951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:56:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:56:35 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:56:34 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Fri, 8 Nov 2024 17:56:33 -0800
Message-ID: <20241109015633.82638-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109015633.82638-1-Tristram.Ha@microchip.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT SFP.

SFP is typically used so the default is 1.  The driver can detect
10/100/1000BaseT SFP and change the mode to 2.  For direct connect the
device tree can use fixed-link for the SGMII port as this link will
never be disconnected.

The SGMII module can only support basic link status of the SFP, so the
port can be simulated as having a regular internal PHY when SFP cage
logic is not used.

One issue for the 1000BaseX SFP is there is no link down interrupt, so
the driver has to use polling to detect link off when the link is up.

Note the SGMII interrupt cannot be masked in hardware.  Also the module
is not reset when the switch is reset.  It is important to reset the
module properly to make sure interrupt is not triggered prematurely.

A PCS driver for the SGMII port is added to accommodate the SFP cage
logic used in the phylink code.  It is used to confirm the link is up
and process the SGMII interrupt.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 450 +++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h     |   7 +-
 drivers/net/dsa/microchip/ksz9477_reg.h |   6 +
 drivers/net/dsa/microchip/ksz_common.c  |  94 ++++-
 drivers/net/dsa/microchip/ksz_common.h  |  21 ++
 5 files changed, 571 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 0ba658a72d8f..1a53980b6e80 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -12,6 +12,8 @@
 #include <linux/phy.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/irqdomain.h>
+#include <linux/phylink.h>
 #include <net/dsa.h>
 #include <net/switchdev.h>
 
@@ -161,6 +163,382 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
 					10, 1000);
 }
 
+static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 len)
+{
+	u32 data;
+
+	data = devid & PORT_SGMII_DEVICE_ID_M;
+	data <<= PORT_SGMII_DEVICE_ID_S;
+	data |= reg;
+	if (len > 1)
+		data |= PORT_SGMII_AUTO_INCR;
+	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
+}
+
+static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 *buf, u16 len)
+{
+	u32 data;
+
+	port_sgmii_s(dev, port, devid, reg, len);
+	while (len) {
+		ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
+		*buf++ = (u16)data;
+		len--;
+	}
+}
+
+static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 *buf, u16 len)
+{
+	u32 data;
+
+	port_sgmii_s(dev, port, devid, reg, len);
+	while (len) {
+		data = *buf++;
+		ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
+		len--;
+	}
+}
+
+static int port_sgmii_detect(struct ksz_device *dev, uint p)
+{
+	struct ksz_port *port = &dev->ports[p];
+	int ret = 0;
+
+	if (dev->sgmii_mode) {
+		u16 buf[6];
+		int i = 0;
+
+		do {
+			port_sgmii_r(dev, p, SR_MII, 0, buf, 6);
+			i++;
+		} while (!buf[5] && i < 10);
+		if (buf[5] & SR_MII_REMOTE_ACK) {
+			if (buf[5] & (SR_MII_REMOTE_HALF_DUPLEX |
+				      SR_MII_REMOTE_FULL_DUPLEX))
+				port->fiber = 1;
+			else if (dev->sgmii_mode == 1)
+				dev->sgmii_mode = 2;
+			ret = 1;
+		} else if (dev->sgmii_mode == 1) {
+			port->fiber = 1;
+			ret = 1;
+		}
+	} else {
+		/* Need to be told to run in direct mode. */
+		port->fiber = 1;
+		ret = 1;
+	}
+	return ret;
+}
+
+static void port_sgmii_reset(struct ksz_device *dev, uint p)
+{
+	u16 ctrl;
+
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+	ctrl |= SR_MII_RESET;
+	port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+}
+
+static void port_sgmii_setup(struct ksz_device *dev, uint p, bool pcs,
+			     bool master, bool autoneg, bool intr, int speed,
+			     int duplex)
+{
+	u16 ctrl;
+	u16 cfg;
+	u16 adv;
+
+	cfg = 0;
+	if (pcs)
+		cfg |= SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
+	if (master) {
+		cfg |= SR_MII_TX_CFG_PHY_MASTER;
+		cfg |= SR_MII_SGMII_LINK_UP;
+	}
+	if (intr)
+		cfg |= SR_MII_AUTO_NEG_COMPLETE_INTR;
+	port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_AUTO_NEG_CTRL, &cfg, 1);
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+	if (master || !autoneg) {
+		switch (speed) {
+		case SPEED_100:
+			ctrl |= SR_MII_SPEED_100MBIT;
+			break;
+		case SPEED_1000:
+			ctrl |= SR_MII_SPEED_1000MBIT;
+			break;
+		}
+	}
+	if (!autoneg) {
+		ctrl &= ~SR_MII_AUTO_NEG_ENABLE;
+		port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+		return;
+	} else if (!(ctrl & SR_MII_AUTO_NEG_ENABLE)) {
+		ctrl |= SR_MII_AUTO_NEG_ENABLE;
+		port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+	}
+
+	/* Need to write to advertise register to send correct signal. */
+	/* Default value is 0x0020. */
+	adv = SR_MII_AUTO_NEG_ASYM_PAUSE_RX << SR_MII_AUTO_NEG_PAUSE_S;
+	if (duplex == DUPLEX_FULL)
+		adv |= SR_MII_AUTO_NEG_FULL_DUPLEX;
+	else
+		adv |= SR_MII_AUTO_NEG_HALF_DUPLEX;
+	port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_AUTO_NEGOTIATION, &adv, 1);
+	if (master && autoneg) {
+		ctrl |= SR_MII_AUTO_NEG_RESTART;
+		port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+	}
+}
+
+#define PORT_LINK_UP		BIT(0)
+#define PORT_LINK_CHANGE	BIT(1)
+#define PORT_LINK_INVALID	BIT(2)
+
+static int sgmii_port_get_speed(struct ksz_device *dev, uint p)
+{
+	struct ksz_port *info = &dev->ports[p];
+	int ret = 0;
+	u16 status;
+	u16 speed;
+	u16 data;
+	u8 link;
+
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_STATUS, &status, 1);
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_STATUS, &status, 1);
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_AUTO_NEG_STATUS, &data, 1);
+
+	/* Typical register values in different modes.
+	 * 10/100/1000: 1f0001 = 01ad  1f0005 = 4000  1f8002 = 0008
+	 *              1f0001 = 01bd  1f0005 = d000  1f8002 = 001a
+	 * 1000:        1f0001 = 018d  1f0005 = 0000  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 40a0  1f8002 = 0001
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0001
+	 * fiber:       1f0001 = 0189  1f0005 = 0000  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0001
+	 */
+
+	if (data & SR_MII_AUTO_NEG_COMPLETE_INTR) {
+		data &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
+		port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_AUTO_NEG_STATUS, &data,
+			     1);
+	}
+
+	/* Running in fiber mode. */
+	if (info->fiber && !data) {
+		u16 link_up = PORT_LINK_STATUS;
+
+		if (dev->sgmii_mode == 1)
+			link_up |= PORT_AUTO_NEG_ACKNOWLEDGE;
+		if ((status & link_up) == link_up)
+			data = SR_MII_STAT_LINK_UP |
+			       (SR_MII_STAT_1000_MBPS << SR_MII_STAT_S) |
+			       SR_MII_STAT_FULL_DUPLEX;
+	}
+	if (data & SR_MII_STAT_LINK_UP) {
+		ret = PORT_LINK_UP;
+	} else if (info->interface == PHY_INTERFACE_MODE_1000BASEX &&
+		 status == 0x018d) {
+		info->sgmii_link = 0xff;
+		return PORT_LINK_INVALID;
+	}
+
+	link = (data & ~SR_MII_AUTO_NEG_COMPLETE_INTR);
+	if (info->sgmii_link == link)
+		return ret;
+
+	if (data & SR_MII_STAT_LINK_UP) {
+		u16 ctrl;
+
+		/* Need to update control register with same link setting. */
+		ctrl = SR_MII_AUTO_NEG_ENABLE;
+		speed = (data >> SR_MII_STAT_S) & SR_MII_STAT_M;
+		if (speed == SR_MII_STAT_1000_MBPS)
+			ctrl |= SR_MII_SPEED_1000MBIT;
+		else if (speed == SR_MII_STAT_100_MBPS)
+			ctrl |= SR_MII_SPEED_100MBIT;
+		if (data & SR_MII_STAT_FULL_DUPLEX)
+			ctrl |= SR_MII_FULL_DUPLEX;
+		port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+
+		speed = (data >> SR_MII_STAT_S) & SR_MII_STAT_M;
+		info->phydev.speed = SPEED_10;
+		if (speed == SR_MII_STAT_1000_MBPS)
+			info->phydev.speed = SPEED_1000;
+		else if (speed == SR_MII_STAT_100_MBPS)
+			info->phydev.speed = SPEED_100;
+
+		info->phydev.duplex = 0;
+		if (data & SR_MII_STAT_FULL_DUPLEX)
+			info->phydev.duplex = 1;
+	}
+	ret |= PORT_LINK_CHANGE;
+	info->sgmii_link = link;
+	info->phydev.link = (ret & PORT_LINK_UP);
+	return ret;
+}
+
+static bool sgmii_need_polling(struct ksz_device *dev, struct ksz_port *p)
+{
+	/* SGMII mode 2 has link up and link down interrupts. */
+	if (dev->sgmii_mode == 2 && p->sgmii_has_intr)
+		return false;
+
+	/* SGMII mode 1 has link up interrupt but not link down interrupt. */
+	if (dev->sgmii_mode == 1 && p->sgmii_has_intr && !p->phydev.link)
+		return false;
+
+	/* SGMII mode 0 for direct connect has no link change. */
+	if (dev->sgmii_mode == 0)
+		return false;
+	return true;
+}
+
+static void sgmii_check_work(struct work_struct *work)
+{
+	struct ksz_device *dev = container_of(work, struct ksz_device,
+					      sgmii_check.work);
+	u8 port = dev->info->sgmii_port - 1;
+	struct ksz_port *p = &dev->ports[port];
+	int ret;
+
+	ret = sgmii_port_get_speed(dev, port);
+	if (ret & PORT_LINK_CHANGE) {
+		struct phy_device *phydev;
+
+		/* When simulating PHY. */
+		p->phydev.interrupts = PHY_INTERRUPT_ENABLED;
+		phydev = mdiobus_get_phy(dev->ds->user_mii_bus, port);
+		if (phydev)
+			phy_trigger_machine(phydev);
+
+		/* When using SFP code. */
+		dsa_port_phylink_mac_change(dev->ds, port, p->phydev.link);
+	}
+	if (sgmii_need_polling(dev, p))
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(500));
+}
+
+static irqreturn_t ksz9477_sgmii_irq_thread_fn(int irq, void *dev_id)
+{
+	struct ksz_pcs *priv = dev_id;
+	struct ksz_device *dev = priv->dev;
+	u8 port = priv->port;
+	u16 data16 = 0;
+	int ret;
+
+	port_sgmii_w(dev, port, SR_MII, MMD_SR_MII_AUTO_NEG_STATUS, &data16, 1);
+	ret = sgmii_port_get_speed(dev, port);
+	if (ret & PORT_LINK_CHANGE) {
+		struct ksz_port *p = &dev->ports[port];
+		struct phy_device *phydev;
+
+		/* When simulating PHY. */
+		p->phydev.interrupts = PHY_INTERRUPT_ENABLED;
+		phydev = mdiobus_get_phy(dev->ds->user_mii_bus, port);
+		if (phydev)
+			phy_trigger_machine(phydev);
+
+		/* When using SFP code. */
+		dsa_port_phylink_mac_change(dev->ds, port, p->phydev.link);
+
+		/* No interrupt for link down. */
+		if (sgmii_need_polling(dev, p))
+			schedule_delayed_work(&dev->sgmii_check,
+					      msecs_to_jiffies(500));
+	}
+	return IRQ_HANDLED;
+}
+
+static void sgmii_initial_setup(struct ksz_device *dev, int port)
+{
+	struct ksz_port *p = &dev->ports[port];
+	/* Assume SGMII mode is 2. */
+	bool autoneg = true;
+	bool master = false;
+	bool intr = false;
+	bool pcs = true;
+	int irq, ret;
+
+	/* Only setup SGMII port once. */
+	if (!p->sgmii || p->sgmii_setup)
+		return;
+
+	irq = irq_find_mapping(p->pirq.domain, PORT_SGMII_INT_LOC);
+	if (irq > 0) {
+		ret = request_threaded_irq(irq, NULL,
+					   ksz9477_sgmii_irq_thread_fn,
+					   IRQF_ONESHOT, "SGMII",
+					   p->pcs_priv);
+		if (!ret) {
+			intr = true;
+			p->sgmii_has_intr = 1;
+		}
+	}
+
+	/* Make invalid so the correct value is set. */
+	p->sgmii_link = 0xff;
+
+	INIT_DELAYED_WORK(&dev->sgmii_check, sgmii_check_work);
+	if (dev->sgmii_mode == 0) {
+		master = true;
+		autoneg = false;
+	} else if (dev->sgmii_mode == 1) {
+		pcs = false;
+		master = true;
+	}
+	port_sgmii_setup(dev, port, pcs, master, autoneg, intr, SPEED_1000,
+			 DUPLEX_FULL);
+
+	p->sgmii_setup = 1;
+	sgmii_port_get_speed(dev, port);
+
+	/* Need to check link down if using fiber SFP. */
+	if (sgmii_need_polling(dev, p))
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(500));
+}
+
+void ksz9477_pcs_get_state(struct phylink_pcs *pcs,
+			   struct phylink_link_state *state)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+	struct ksz_port *p = &dev->ports[priv->port];
+	int ret;
+
+	ret = sgmii_port_get_speed(dev, priv->port);
+	if (!(ret & PORT_LINK_UP))
+		state->link = false;
+	state->duplex = p->phydev.duplex;
+	state->speed = p->phydev.speed;
+	if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+		state->an_complete = state->link;
+	} else if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+		if (ret == PORT_LINK_INVALID)
+			schedule_delayed_work(&dev->sgmii_check,
+					      msecs_to_jiffies(200));
+	}
+}
+
+void ksz9477_pcs_link_up(struct phylink_pcs *pcs, unsigned int mode,
+			 phy_interface_t interface, int speed, int duplex)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+	struct ksz_port *p = &dev->ports[priv->port];
+
+	/* No interrupt for link down. */
+	if (sgmii_need_polling(dev, p))
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(500));
+}
+
 int ksz9477_reset_switch(struct ksz_device *dev)
 {
 	u8 data8;
@@ -345,7 +723,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	 * A fixed PHY can be setup in the device tree, but this function is
 	 * still called for that port during initialization.
 	 * For RGMII PHY there is no way to access it so the fixed PHY should
-	 * be used.  For SGMII PHY the supporting code will be added later.
+	 * be used.  SGMII PHY is simulated as a regular PHY.
 	 */
 	if (!dev->info->internal_phy[addr]) {
 		struct ksz_port *p = &dev->ports[addr];
@@ -355,7 +733,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			val = 0x1140;
 			break;
 		case MII_BMSR:
-			val = 0x796d;
+			if (p->phydev.link)
+				val = 0x796d;
+			else
+				val = 0x7949;
 			break;
 		case MII_PHYSID1:
 			val = 0x0022;
@@ -368,6 +749,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			break;
 		case MII_LPA:
 			val = 0xc5e1;
+			if (p->phydev.speed == SPEED_10)
+				val &= ~0x0180;
+			if (p->phydev.duplex == 0)
+				val &= ~0x0140;
 			break;
 		case MII_CTRL1000:
 			val = 0x0700;
@@ -378,6 +763,24 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			else
 				val = 0;
 			break;
+		case MII_ESTATUS:
+			val = 0x3000;
+			break;
+
+		/* This register holds the PHY interrupt status. */
+		case MII_TPISTATUS:
+			val = (LINK_DOWN_INT | LINK_UP_INT) << 8;
+			if (p->phydev.interrupts == PHY_INTERRUPT_ENABLED) {
+				if (p->phydev.link)
+					val |= LINK_UP_INT;
+				else
+					val |= LINK_DOWN_INT;
+			}
+			p->phydev.interrupts = 0;
+			break;
+		default:
+			val = 0;
+			break;
 		}
 	} else {
 		ret = ksz_pread16(dev, addr, 0x100 + (reg << 1), &val);
@@ -973,11 +1376,27 @@ static phy_interface_t ksz9477_get_interface(struct ksz_device *dev, int port)
 void ksz9477_get_caps(struct ksz_device *dev, int port,
 		      struct phylink_config *config)
 {
+	struct ksz_port *p = &dev->ports[port];
+
 	config->mac_capabilities = MAC_10 | MAC_100 | MAC_ASYM_PAUSE |
 				   MAC_SYM_PAUSE;
 
 	if (dev->info->gbit_capable[port])
 		config->mac_capabilities |= MAC_1000FD;
+
+	if (p->sgmii) {
+		struct phy_device *phydev;
+
+		phydev = mdiobus_get_phy(dev->ds->user_mii_bus, port);
+
+		/* Change this port interface to SGMII. */
+		if (phydev)
+			phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+	}
 }
 
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
@@ -1054,6 +1473,8 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		     PORT_FORCE_TX_FLOW_CTRL | PORT_FORCE_RX_FLOW_CTRL,
 		     !dev->info->internal_phy[port]);
 
+	sgmii_initial_setup(dev, port);
+
 	if (cpu_port)
 		member = dsa_user_ports(ds);
 	else
@@ -1132,6 +1553,10 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 			continue;
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
 	}
+
+	/* Switch reset does not reset SGMII module. */
+	if (dev->info->sgmii_port > 0)
+		port_sgmii_reset(dev, dev->info->sgmii_port - 1);
 }
 
 int ksz9477_enable_stp_addr(struct ksz_device *dev)
@@ -1201,6 +1626,23 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* enable global MIB counter freeze function */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
 
+	if (dev->info->sgmii_port > 0) {
+		struct ksz_port *p = &dev->ports[dev->info->sgmii_port - 1];
+		struct ksz_pcs *pcs_priv;
+
+		p->sgmii = port_sgmii_detect(dev, dev->info->sgmii_port - 1);
+		if (p->sgmii) {
+			pcs_priv = devm_kzalloc(dev->dev,
+						sizeof(struct ksz_pcs),
+						GFP_KERNEL);
+			if (!pcs_priv)
+				return -ENOMEM;
+			p->pcs_priv = pcs_priv;
+			pcs_priv->dev = dev;
+			pcs_priv->port = dev->info->sgmii_port - 1;
+		}
+	}
+
 	/* Make sure PME (WoL) is not enabled. If requested, it will
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
 	 * do not like PME events changes before shutdown.
@@ -1319,6 +1761,8 @@ int ksz9477_switch_init(struct ksz_device *dev)
 
 void ksz9477_switch_exit(struct ksz_device *dev)
 {
+	if (delayed_work_pending(&dev->sgmii_check))
+		cancel_delayed_work_sync(&dev->sgmii_check);
 	ksz9477_reset_switch(dev);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index d2166b0d881e..24a42d5ee023 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 series Header file
  *
- * Copyright (C) 2017-2022 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_H
@@ -97,4 +97,9 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
 				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
 				  unsigned long cookie, u32 prio);
 
+void ksz9477_pcs_get_state(struct phylink_pcs *pcs,
+			   struct phylink_link_state *state);
+void ksz9477_pcs_link_up(struct phylink_pcs *pcs, unsigned int mode,
+			 phy_interface_t interface, int speed, int duplex);
+
 #endif
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 04235c22bf40..0c15c0b16b42 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -805,6 +805,7 @@
 #define REG_PORT_INT_STATUS		0x001B
 #define REG_PORT_INT_MASK		0x001F
 
+#define PORT_SGMII_INT_LOC		3
 #define PORT_SGMII_INT			BIT(3)
 #define PORT_PTP_INT			BIT(2)
 #define PORT_PHY_INT			BIT(1)
@@ -1025,6 +1026,11 @@
 #define SR_MII_AUTO_NEG_FULL_DUPLEX	BIT(5)
 
 #define MMD_SR_MII_REMOTE_CAPABILITY	0x0005
+
+#define SR_MII_REMOTE_ACK		BIT(14)
+#define SR_MII_REMOTE_HALF_DUPLEX	BIT(6)
+#define SR_MII_REMOTE_FULL_DUPLEX	BIT(5)
+
 #define MMD_SR_MII_AUTO_NEG_EXP		0x0006
 #define MMD_SR_MII_AUTO_NEG_EXT		0x000F
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f73833e24622..8163342d778a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -354,10 +354,30 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 					int speed, int duplex, bool tx_pause,
 					bool rx_pause);
 
+static struct phylink_pcs *
+ksz_phylink_mac_select_pcs(struct phylink_config *config,
+			   phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	struct ksz_port *p = &dev->ports[dp->index];
+
+	if (!p->sgmii)
+		return ERR_PTR(-EOPNOTSUPP);
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return &p->pcs_priv->pcs;
+	default:
+		return NULL;
+	}
+}
+
 static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
 };
 
 static const struct ksz_dev_ops ksz9477_dev_ops = {
@@ -395,6 +415,8 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
 	.exit = ksz9477_switch_exit,
+	.pcs_get_state = ksz9477_pcs_get_state,
+	.pcs_link_up = ksz9477_pcs_link_up,
 };
 
 static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
@@ -1033,8 +1055,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x701b, 0x701b),
 	regmap_reg_range(0x701f, 0x7020),
 	regmap_reg_range(0x7030, 0x7030),
-	regmap_reg_range(0x7200, 0x7203),
-	regmap_reg_range(0x7206, 0x7207),
+	regmap_reg_range(0x7200, 0x7207),
 	regmap_reg_range(0x7300, 0x7301),
 	regmap_reg_range(0x7400, 0x7401),
 	regmap_reg_range(0x7403, 0x7403),
@@ -1554,6 +1575,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -1972,6 +1994,45 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 		dev->dev_ops->get_caps(dev, port, config);
 }
 
+static void ksz_pcs_get_state(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+
+	if (dev->dev_ops->pcs_get_state)
+		dev->dev_ops->pcs_get_state(pcs, state);
+}
+
+static int ksz_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising,
+			  bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static void ksz_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static void ksz_pcs_link_up(struct phylink_pcs *pcs, unsigned int mode,
+			    phy_interface_t interface, int speed, int duplex)
+{
+	struct ksz_pcs *priv = container_of(pcs, struct ksz_pcs, pcs);
+	struct ksz_device *dev = priv->dev;
+
+	if (dev->dev_ops->pcs_link_up)
+		dev->dev_ops->pcs_link_up(pcs, mode, interface, speed, duplex);
+}
+
+static const struct phylink_pcs_ops ksz_pcs_ops = {
+	.pcs_get_state = ksz_pcs_get_state,
+	.pcs_config = ksz_pcs_config,
+	.pcs_an_restart = ksz_pcs_an_restart,
+	.pcs_link_up = ksz_pcs_link_up,
+};
+
 void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 {
 	struct ethtool_pause_stats *pstats;
@@ -2021,7 +2082,7 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 
 	spin_unlock(&mib->stats64_lock);
 
-	if (dev->info->phy_errata_9477) {
+	if (dev->info->phy_errata_9477 && dev->info->sgmii_port != port + 1) {
 		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
 		if (ret)
 			dev_err(dev->dev, "Failed to monitor transmission halt\n");
@@ -2531,6 +2592,12 @@ static int ksz_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
+	if (dev->info->sgmii_port > 0) {
+		p = &dev->ports[dev->info->sgmii_port - 1];
+		if (p->pcs_priv)
+			p->pcs_priv->pcs.ops = &ksz_pcs_ops;
+	}
+
 	/* Start with learning disabled on standalone user ports, and enabled
 	 * on the CPU port. In lack of other finer mechanisms, learning on the
 	 * CPU port will avoid flooding bridge local addresses on the network
@@ -3355,6 +3422,17 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
 	if (dev->info->internal_phy[port])
 		return;
 
+	/* No need to configure XMII control register when using SGMII. */
+	if (state->interface == PHY_INTERFACE_MODE_SGMII ||
+	    state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+		struct ksz_port *p = &dev->ports[port];
+
+		p->interface = state->interface;
+		return;
+	}
+	if (dev->info->sgmii_port == port + 1)
+		return;
+
 	if (phylink_autoneg_inband(mode)) {
 		dev_err(dev->dev, "In-band AN not supported!\n");
 		return;
@@ -4783,6 +4861,9 @@ int ksz_switch_register(struct ksz_device *dev)
 		dev->ports[i].num = i;
 	}
 
+	/* Default SGMII mode is detecting which type of SFP is used. */
+	dev->sgmii_mode = 1;
+
 	/* set the real number of ports */
 	dev->ds->num_ports = dev->info->port_cnt;
 
@@ -4813,6 +4894,13 @@ int ksz_switch_register(struct ksz_device *dev)
 				of_get_phy_mode(port,
 						&dev->ports[port_num].interface);
 
+				/* SGMII port can be used without using SFP. */
+				if (dev->info->sgmii_port == port_num + 1) {
+					if (of_phy_is_fixed_link(port) &&
+					    !dev->ports[port_num].interface)
+						dev->sgmii_mode = 0;
+				}
+
 				ksz_parse_rgmii_delay(dev, port_num, port);
 			}
 			of_node_put(ports);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index bec846e20682..12b043bb766a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -86,6 +86,7 @@ struct ksz_chip_data {
 	bool supports_rgmii[KSZ_MAX_NUM_PORTS];
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
+	u8 sgmii_port;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 };
@@ -114,6 +115,13 @@ struct ksz_switch_macaddr {
 	refcount_t refcount;
 };
 
+struct ksz_pcs {
+	struct phylink_pcs pcs;
+	struct ksz_device *dev;
+	int irq;
+	u8 port;
+};
+
 struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
@@ -125,6 +133,10 @@ struct ksz_port {
 	u32 force:1;
 	u32 read:1;			/* read MIB counters in background */
 	u32 freeze:1;			/* MIB counter freeze is enabled */
+	u32 sgmii:1;			/* port is SGMII */
+	u32 sgmii_has_intr:1;
+	u32 sgmii_link:8;
+	u32 sgmii_setup:1;
 
 	struct ksz_port_mib mib;
 	phy_interface_t interface;
@@ -134,6 +146,7 @@ struct ksz_port {
 	void *acl_priv;
 	struct ksz_irq pirq;
 	u8 num;
+	struct ksz_pcs *pcs_priv;
 #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
 	struct hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
@@ -156,6 +169,7 @@ struct ksz_device {
 	struct mutex alu_mutex;		/* ALU access */
 	struct mutex vlan_mutex;	/* vlan access */
 	const struct ksz_dev_ops *dev_ops;
+	const struct phylink_pcs_ops *pcs_ops;
 
 	struct device *dev;
 	struct regmap *regmap[__KSZ_NUM_REGMAPS];
@@ -181,6 +195,8 @@ struct ksz_device {
 	struct ksz_port *ports;
 	struct delayed_work mib_read;
 	unsigned long mib_read_interval;
+	struct delayed_work sgmii_check;
+	u8 sgmii_mode;
 	u16 mirror_rx;
 	u16 mirror_tx;
 	u16 port_mask;
@@ -379,6 +395,11 @@ struct ksz_dev_ops {
 	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
 	void (*exit)(struct ksz_device *dev);
+
+	void (*pcs_get_state)(struct phylink_pcs *pcs,
+			      struct phylink_link_state *state);
+	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int mode,
+			    phy_interface_t interface, int speed, int duplex);
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
-- 
2.34.1


