Return-Path: <netdev+bounces-117320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4C94D93D
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9421F223DE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AD16F0DC;
	Fri,  9 Aug 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YBfTnTKR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909D16D9C0;
	Fri,  9 Aug 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246729; cv=none; b=rKF2bGmwDU+mA097i9tw2YQvp6KBdJIhUJLR/80nR1kFDfvEvzSMgG7st8T8cLpZXyZLKyA1CbIMriRwudGnXVfLBDyPyJPP9xKffieo23naFlk7JzoNKVTdPB2aKGWNzm4z9v+6piz12MrB06TrSHMVK9gNTIjZdNWZqttqjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246729; c=relaxed/simple;
	bh=XP33KH4bY9V10zNDfLJN3Cyxv1UL6RedpRPu9m2nfr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw04Gxx+QvBRqlc8AZa79kQI2OxealVt9wyPYH3XbIDx5YeAKj9W+cLPvWF7u4rl4S5JXqwrPvCI5DilOiPlP9/FNRxLC4lLc8468o+oWSN8tI7DlAIB7wJfFirO/xQj+Y/QZoF8tu/CRtzMWfsFE9iwqEBskUd5RPoR3HWF1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YBfTnTKR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723246727; x=1754782727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XP33KH4bY9V10zNDfLJN3Cyxv1UL6RedpRPu9m2nfr4=;
  b=YBfTnTKR8nAo9H6Nr38zyQyfIn/pbjOdyU4/OQTn8LHqD0wvvhpH6/Dq
   UzIOwBnYQ8Jk1psctUI/FuullSW7AGCojZT0IhILVVs6YkDMHkHsgEg7I
   /R4oJ1oE8AGZ5Ikpq4itEQCGxOHtqrtpf2uz3cIoAp/WxUdtEdBwTApds
   BizDFO6H+UI+AVQAf+rpo3oTgwok7y1nnw6ToaBAvO5aR0WTu8Wh+/Vfg
   TEUi7NNrwGFDBoaULZG/CUtuy1Gsfj+ZZ6znEzCv3E4x730XD9/VnjvNF
   co7qwsdiVQ869JgULPSXEfaWOrdeS024DCIjGr0N4RqoLbeNjCh1BTQxZ
   Q==;
X-CSE-ConnectionGUID: zHerXwjfR2qUoEM/PnTZ/A==
X-CSE-MsgGUID: Gyt0dUURQnaSbzoGRQ//0A==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30988812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 16:38:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 16:38:43 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:42 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support to KSZ9477 switch
Date: Fri, 9 Aug 2024 16:38:40 -0700
Message-ID: <20240809233840.59953-5-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809233840.59953-1-Tristram.Ha@microchip.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
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
connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.

SFP is typically used so the default is 1.  The driver can detect
10/100/1000 SFP and change the mode to 2.  For direct connect this mode
has to be explicitly set to 0 as driver cannot detect that
configuration.

The SGMII module can only report basic link status of the SFP, so it is
simulated as a regular internal PHY.

Since the regular PHY in the switch uses interrupt instead of polling the
driver has to handle the SGMII interrupt indicating link on/off.

One issue for the 1000BaseT SFP is there is no link down interrupt, so
the driver has to use polling to detect link down when the link is up.

Recent change in the DSA operation can setup the port before the PHY
interrupt handling function is registered.  As the SGMII interrupt can
be triggered after port setup there is extra code in the interrupt
processing to handle this situation.  Otherwise a kernel fault can be
triggered.

Note the SGMII interrupt cannot be masked in hardware.  Also the module
is not reset when the switch is reset.  It is important to reset the
module properly to make sure the interrupt is not triggered prematurely.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 340 +++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h     |   2 +
 drivers/net/dsa/microchip/ksz9477_reg.h |   5 +
 drivers/net/dsa/microchip/ksz_common.c  |  28 +-
 drivers/net/dsa/microchip/ksz_common.h  |   6 +
 5 files changed, 376 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 518ba4a1e34b..6ac0a06a4b74 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -342,6 +342,257 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
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
+	int ret = 0;
+
+	if (dev->sgmii_mode) {
+		struct ksz_port *port = &dev->ports[p];
+		u16 buf[6];
+
+		port_sgmii_r(dev, p, SR_MII, 0, buf, 6);
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
+			     bool master, bool autoneg, int speed, int duplex)
+{
+	u16 ctrl;
+	u16 cfg;
+	u16 adv;
+
+	/* SGMII registers are not changed by reset. */
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_AUTO_NEG_CTRL, &cfg, 1);
+	if (cfg & SR_MII_AUTO_NEG_COMPLETE_INTR)
+		return;
+	cfg = 0;
+	if (pcs)
+		cfg |= SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
+	if (master) {
+		cfg |= SR_MII_TX_CFG_PHY_MASTER;
+		cfg |= SR_MII_SGMII_LINK_UP;
+	}
+	cfg |= SR_MII_AUTO_NEG_COMPLETE_INTR;
+	port_sgmii_w(dev, p, SR_MII, MMD_SR_MII_AUTO_NEG_CTRL, &cfg, 1);
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_CTRL, &ctrl, 1);
+	if (master || !autoneg) {
+		switch (speed) {
+		case 1:
+			ctrl |= SR_MII_SPEED_100MBIT;
+			break;
+		case 2:
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
+	port_sgmii_r(dev, p, SR_MII, MMD_SR_MII_AUTO_NEGOTIATION, &adv, 1);
+	adv = SR_MII_AUTO_NEG_ASYM_PAUSE_RX << SR_MII_AUTO_NEG_PAUSE_S;
+	if (duplex)
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
+	 *              1f0001 = 01ad  1f0005 = 40a0  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0000
+	 * fiber:       1f0001 = 0189  1f0005 = 0000  1f8002 = 0000
+	 *              1f0001 = 01ad  1f0005 = 41a0  1f8002 = 0000
+	 */
+
+	/* Running in fiber mode. */
+	if (info->fiber && !data &&
+	    (status & (PORT_AUTO_NEG_ACKNOWLEDGE | PORT_LINK_STATUS)) ==
+	    (PORT_AUTO_NEG_ACKNOWLEDGE | PORT_LINK_STATUS)) {
+		data = SR_MII_STAT_LINK_UP |
+		       (SR_MII_STAT_1000_MBPS << SR_MII_STAT_S) |
+		       SR_MII_STAT_FULL_DUPLEX;
+	}
+	if (data & SR_MII_STAT_LINK_UP)
+		ret = 1;
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
+	ret |= 2;
+	info->sgmii_link = link;
+	info->phydev.link = (ret & 1);
+	return ret;
+}
+
+static void sgmii_check_work(struct work_struct *work)
+{
+	struct ksz_device *dev = container_of(work, struct ksz_device,
+					      sgmii_check.work);
+	struct ksz_port *p = &dev->ports[KSZ9477_SGMII_PORT];
+
+	if (p->sgmii && p->phydev.link) {
+		int ret = sgmii_port_get_speed(dev, KSZ9477_SGMII_PORT);
+		struct dsa_switch *ds = dev->ds;
+		struct phy_device *phydev;
+
+		phydev = mdiobus_get_phy(ds->user_mii_bus, KSZ9477_SGMII_PORT);
+		if ((ret & 2) && phydev)
+			phy_trigger_machine(phydev);
+		if (p->phydev.link)
+			schedule_delayed_work(&dev->sgmii_check,
+					      msecs_to_jiffies(500));
+	}
+}
+
+static void sgmii_initial_setup(struct ksz_device *dev, int port)
+{
+	struct ksz_port *p = &dev->ports[port];
+	/* Assume SGMII mode is 2. */
+	bool master = false;
+	bool autoneg = true;
+	bool pcs = true;
+
+	if (!p->sgmii || p->sgmii_setup)
+		return;
+
+	INIT_DELAYED_WORK(&dev->sgmii_check, sgmii_check_work);
+	if (dev->sgmii_mode == 0) {
+		master = true;
+		autoneg = false;
+	} else if (dev->sgmii_mode == 1) {
+		pcs = false;
+		master = true;
+	}
+	port_sgmii_setup(dev, port, pcs, master, autoneg, 2, 1);
+
+	/* Make invalid so the correct value is set. */
+	p->sgmii_link = 0xff;
+	p->sgmii_setup = 1;
+	sgmii_port_get_speed(dev, port);
+
+	/* Need to check link down if using fiber SFP. */
+	if (dev->sgmii_mode == 1 && p->phydev.link)
+		schedule_delayed_work(&dev->sgmii_check,
+				      msecs_to_jiffies(1000));
+}
+
 int ksz9477_reset_switch(struct ksz_device *dev)
 {
 	u8 data8;
@@ -354,6 +605,14 @@ int ksz9477_reset_switch(struct ksz_device *dev)
 	regmap_update_bits(ksz_regmap_8(dev), REG_SW_GLOBAL_SERIAL_CTRL_0,
 			   SPI_AUTO_EDGE_DETECTION, 0);
 
+	/* Only reset SGMII module when the driver is stopped. */
+	if (dev->chip_id == KSZ9477_CHIP_ID) {
+		struct ksz_port *p = &dev->ports[KSZ9477_SGMII_PORT];
+
+		if (p->sgmii_setup)
+			port_sgmii_reset(dev, KSZ9477_SGMII_PORT);
+	}
+
 	/* default configuration */
 	ksz_write8(dev, REG_SW_LUE_CTRL_1,
 		   SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER);
@@ -510,7 +769,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	 * A fixed PHY can be setup in the device tree, but this function is
 	 * still called for that port during initialization.
 	 * For RGMII PHY there is no way to access it so the fixed PHY should
-	 * be used.  For SGMII PHY the supporting code will be added later.
+	 * be used.  SGMII PHY is simulated as a regular PHY.
 	 */
 	if (!dev->info->internal_phy[addr]) {
 		struct ksz_port *p = &dev->ports[addr];
@@ -520,7 +779,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
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
@@ -533,6 +795,10 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
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
@@ -543,6 +809,24 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
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
@@ -1143,6 +1427,16 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 
 	if (dev->info->gbit_capable[port])
 		config->mac_capabilities |= MAC_1000FD;
+	if (dev->info->supports_sgmii[port]) {
+		struct dsa_switch *ds = dev->ds;
+		struct phy_device *phydev;
+
+		phydev = mdiobus_get_phy(ds->user_mii_bus, port);
+
+		/* Change this port interface to SGMII. */
+		if (phydev)
+			phydev->interface = PHY_INTERFACE_MODE_SGMII;
+	}
 }
 
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
@@ -1218,6 +1512,8 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		     PORT_FORCE_TX_FLOW_CTRL | PORT_FORCE_RX_FLOW_CTRL,
 		     !dev->info->internal_phy[port]);
 
+	sgmii_initial_setup(dev, port);
+
 	if (cpu_port)
 		member = dsa_user_ports(ds);
 	else
@@ -1296,6 +1592,10 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 			continue;
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
 	}
+	if (dev->chip_id == KSZ9477_CHIP_ID) {
+		/* Switch reset does not reset SGMII module. */
+		port_sgmii_reset(dev, KSZ9477_SGMII_PORT);
+	}
 }
 
 int ksz9477_enable_stp_addr(struct ksz_device *dev)
@@ -1370,6 +1670,12 @@ int ksz9477_setup(struct dsa_switch *ds)
 	 */
 	ksz_write8(dev, REG_SW_PME_CTRL, 0);
 
+	if (dev->chip_id == KSZ9477_CHIP_ID) {
+		struct ksz_port *p = &dev->ports[KSZ9477_SGMII_PORT];
+
+		p->sgmii = port_sgmii_detect(dev, KSZ9477_SGMII_PORT);
+	}
+
 	return 0;
 }
 
@@ -1484,6 +1790,8 @@ int ksz9477_switch_init(struct ksz_device *dev)
 
 void ksz9477_switch_exit(struct ksz_device *dev)
 {
+	if (delayed_work_pending(&dev->sgmii_check))
+		cancel_delayed_work_sync(&dev->sgmii_check);
 	ksz9477_reset_switch(dev);
 }
 
@@ -1515,6 +1823,34 @@ static irqreturn_t ksz9477_handle_port_irq(struct ksz_device *dev, u8 port,
 		++cnt;
 		*data &= ~PORT_ACL_INT;
 	}
+	if (*data & PORT_SGMII_INT) {
+		u16 data16 = 0;
+		int ret;
+
+		port_sgmii_w(dev, port, SR_MII, MMD_SR_MII_AUTO_NEG_STATUS,
+			     &data16, 1);
+		ret = sgmii_port_get_speed(dev, port);
+		if ((ret & 2)) {
+			struct ksz_port *p = &dev->ports[port];
+
+			p->phydev.interrupts = PHY_INTERRUPT_ENABLED;
+
+			/* No interrupt for link down. */
+			if (dev->sgmii_mode == 1 && p->phydev.link)
+				schedule_delayed_work(&dev->sgmii_check,
+						      msecs_to_jiffies(500));
+		}
+
+		/* Handle the interrupt if there is no PHY device or its
+		 * interrupt is not registered yet.
+		 */
+		if (!phydev || phydev->interrupts != PHY_INTERRUPT_ENABLED) {
+			if (phydev)
+				phy_trigger_machine(phydev);
+			++cnt;
+			*data &= ~PORT_SGMII_INT;
+		}
+	}
 
 	return (cnt > 0) ? IRQ_HANDLED : IRQ_NONE;
 }
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 51252d0d0774..ec318491d536 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -11,6 +11,8 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
+#define KSZ9477_SGMII_PORT		6
+
 int ksz9477_setup(struct dsa_switch *ds);
 u32 ksz9477_get_port_addr(int port, int offset);
 void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index da4ef3eb97c7..20e0b233d55d 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -1038,6 +1038,11 @@
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
index 7db74e036c3f..c16e3388dc1a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -936,8 +936,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x701b, 0x701b),
 	regmap_reg_range(0x701f, 0x7020),
 	regmap_reg_range(0x7030, 0x7030),
-	regmap_reg_range(0x7200, 0x7203),
-	regmap_reg_range(0x7206, 0x7207),
+	regmap_reg_range(0x7200, 0x7207),
 	regmap_reg_range(0x7300, 0x7301),
 	regmap_reg_range(0x7400, 0x7401),
 	regmap_reg_range(0x7403, 0x7403),
@@ -1399,6 +1398,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, true, false},
 		.supports_rgmii = {false, false, false, false,
 				   false, true, false},
+		.supports_sgmii = {false, false, false, false,
+				   false, false, true},
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
@@ -1806,6 +1807,10 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 	if (dev->info->supports_rgmii[port])
 		phy_interface_set_rgmii(config->supported_interfaces);
 
+	if (dev->info->supports_sgmii[port])
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+
 	if (dev->info->internal_phy[port]) {
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
@@ -2089,14 +2094,19 @@ static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 static int ksz_irq_phy_setup(struct ksz_device *dev)
 {
 	struct dsa_switch *ds = dev->ds;
+	struct ksz_port *p;
 	int phy;
 	int irq;
 	int ret;
 
 	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++) {
 		if (BIT(phy) & ds->phys_mii_mask) {
+			p = &dev->ports[phy];
+			irq = PORT_SRC_PHY_INT;
+			if (p->sgmii)
+				irq = 3;
 			irq = irq_find_mapping(dev->ports[phy].pirq.domain,
-					       PORT_SRC_PHY_INT);
+					       irq);
 			if (irq < 0) {
 				ret = irq;
 				goto out;
@@ -3222,6 +3232,9 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
 		return;
 	}
 
+	if (state->interface == PHY_INTERFACE_MODE_SGMII)
+		return;
+
 	ksz_set_xmii(dev, port, state->interface);
 
 	if (dev->dev_ops->setup_rgmii_delay)
@@ -4456,9 +4469,18 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
+		u32 mode;
+
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
+
+		dev->sgmii_mode = 1;
+		ret = of_property_read_u32(dev->dev->of_node,
+					   "microchip,sgmii-mode", &mode);
+		if (ret == 0 && mode <= 2)
+			dev->sgmii_mode = (u8)mode;
+
 		ports = of_get_child_by_name(dev->dev->of_node, "ethernet-ports");
 		if (!ports)
 			ports = of_get_child_by_name(dev->dev->of_node, "ports");
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a2547646026f..e6cb9304e7db 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -84,6 +84,7 @@ struct ksz_chip_data {
 	bool supports_mii[KSZ_MAX_NUM_PORTS];
 	bool supports_rmii[KSZ_MAX_NUM_PORTS];
 	bool supports_rgmii[KSZ_MAX_NUM_PORTS];
+	bool supports_sgmii[KSZ_MAX_NUM_PORTS];
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
 	const struct regmap_access_table *wr_table;
@@ -126,6 +127,9 @@ struct ksz_port {
 	u32 force:1;
 	u32 read:1;			/* read MIB counters in background */
 	u32 freeze:1;			/* MIB counter freeze is enabled */
+	u32 sgmii:1;			/* port is SGMII */
+	u32 sgmii_link:8;
+	u32 sgmii_setup:1;
 
 	struct ksz_port_mib mib;
 	phy_interface_t interface;
@@ -181,6 +185,8 @@ struct ksz_device {
 	struct ksz_port *ports;
 	struct delayed_work mib_read;
 	unsigned long mib_read_interval;
+	struct delayed_work sgmii_check;
+	u8 sgmii_mode;
 	u16 mirror_rx;
 	u16 mirror_tx;
 	u16 port_mask;
-- 
2.34.1


