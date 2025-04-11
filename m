Return-Path: <netdev+bounces-181817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A823A8683E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B6B9A430E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459629B20D;
	Fri, 11 Apr 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0ybzZLpG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505F29AAF3
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406846; cv=none; b=A0yeuw19TY6bpVzcxONRIm5J/iVhTXSKDDWbohP0bXAQkJNLrnDsSOzuikK8/z+0vbviTN5lgASAbbrenPuoEUHIQadyjZ5Tu6KVq0WScedi6zNe8ZPEJQZHCg/5uZrkDk6vOuqYXMwO+PryUNWpndk5BgUDz9kLzI1Jrqd+tXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406846; c=relaxed/simple;
	bh=OwHm/WzTSmqMrdfwMFy8N+H/Zu7CPSNDR+lHxSFQE4A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZlFmEmE4XTPNYbjQ2ujva4UbYAaPBlXpmAvOL8wxcOzQ+/EH04GI+o9GIn1Py2vUHmtq5mUL++/JHj4C3x+aXhd9yDN44W9k9zu/DF9hz8tagfhZrWx/t57kPmbEURST/PdxJDvCUIUrzoq/7L7jl5lNQhOT8HoFrJlrJmRNY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0ybzZLpG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XNU0B7Pxg+fwWIdIIkX0RkCub1Jj5TxVKb6gtV2O6xU=; b=0ybzZLpG9KBPfQ4ODcsZ3i9O1O
	NyC8gppf37foLfTykUG6jN6Roj79VuNqpSPWzrA2fzdM9c2Tmeo9gGuhq8LIEUY3P+AxkFf2o5Iv1
	MD2OiMBTW4f+/CPBPe0bjTJh2zXQWtmlBB2jfn4a7ZvcWTGoDPfbkaF1zRJKc6aPhNioopd/cL7cj
	ExlgsaRDy+EzbVO/sM9CySl2tEGqvdM2l4Vehlb5wTYud/xfARaFUxdghT25hauOJXw45FF9UmPpA
	5BoK63n2gDxLyrskbehh7rSDuU7ZGLo9qe8QZZ8FxgQfTfGGMjLpOHqMc882qGwonTe/GcMA943CM
	cn/c1k4g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43832 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3LuB-0003s8-1N;
	Fri, 11 Apr 2025 22:27:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Lta-000CP7-7r; Fri, 11 Apr 2025 22:26:42 +0100
In-Reply-To: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 22:26:42 +0100

Add PTP basic support for Marvell 88E151x single port PHYs.  These
PHYs support timestamping the egress and ingress of packets, but does
not support any packet modification, nor do we support any filtering
beyond selecting packets that the hardware recognises as PTP/802.1AS.

The PHYs support hardware pins for providing an external clock for the
TAI counter, and a separate pin that can be used for event capture or
generation of a trigger (either a pulse or periodic). Only event
capture is supported.

We currently use a delayed work to poll for the timestamps which is
far from ideal, but we also provide a function that can be called from
an interrupt handler - which would be good to tie into the main Marvell
PHY driver.

The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
drivers. The hardware is very similar to the implementation found in
the 88E6xxx DSA driver, but the access methods are very different,
although it may be possible to create a library that both can use
along with accessor functions.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/Kconfig       |  13 ++
 drivers/net/phy/Makefile      |   1 +
 drivers/net/phy/marvell.c     |  21 ++-
 drivers/net/phy/marvell_ptp.c | 307 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/marvell_ptp.h |  21 +++
 5 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/marvell_ptp.c
 create mode 100644 drivers/net/phy/marvell_ptp.h

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d29f9f7fd2e1..fb8b326f5c7e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -240,6 +240,19 @@ config MARVELL_PHY
 	help
 	  Currently has a driver for the 88E1XXX
 
+config MARVELL_PHY_PTP
+	bool "Marvell PHY PTP support"
+	depends on NETWORK_PHY_TIMESTAMPING
+	depends on (PTP_1588_CLOCK = y && MARVELL_PHY = y) || \
+		   (PTP_1588_CLOCK && MARVELL_PHY = m)
+	select PTP_1588_CLOCK_MARVELL
+	help
+	  Support PHY timestamping on Marvell 88E1510, 88E1512, 88E1514
+	  and 88E1518 PHYs.
+
+	  N.B. In order for this to be fully functional, your MAC driver
+	  must call the skb_tx_timestamp() function.
+
 config MARVELL_10G_PHY
 	tristate "Marvell Alaska 10Gbit PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 23ce205ae91d..9d513a18afb6 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
+obj-$(CONFIG_MARVELL_PHY_PTP)	+= marvell_ptp.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 623292948fa7..1e9a4b300216 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -38,6 +38,8 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
+#include "marvell_ptp.h"
+
 #define MII_MARVELL_PHY_PAGE		22
 #define MII_MARVELL_COPPER_PAGE		0x00
 #define MII_MARVELL_FIBER_PAGE		0x01
@@ -3647,7 +3649,7 @@ static const struct sfp_upstream_ops m88e1510_sfp_ops = {
 	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
-static int m88e1510_probe(struct phy_device *phydev)
+static int m88e15xx_probe(struct phy_device *phydev)
 {
 	int err;
 
@@ -3658,6 +3660,22 @@ static int m88e1510_probe(struct phy_device *phydev)
 	return phy_sfp_probe(phydev, &m88e1510_sfp_ops);
 }
 
+static int m88e1510_probe(struct phy_device *phydev)
+{
+	int err;
+
+	err = m88e15xx_probe(phydev);
+	if (err)
+		return err;
+
+	return marvell_phy_ptp_probe(phydev);
+}
+
+static void m88e1510_remove(struct phy_device *phydev)
+{
+	marvell_phy_ptp_remove(phydev);
+}
+
 static struct phy_driver marvell_drivers[] = {
 	{
 		.phy_id = MARVELL_PHY_ID_88E1101,
@@ -3916,6 +3934,7 @@ static struct phy_driver marvell_drivers[] = {
 		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = m88e1510_probe,
+		.remove = m88e1510_remove,
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
diff --git a/drivers/net/phy/marvell_ptp.c b/drivers/net/phy/marvell_ptp.c
new file mode 100644
index 000000000000..3ba71c44ffb0
--- /dev/null
+++ b/drivers/net/phy/marvell_ptp.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell PTP driver for 88E1510, 88E1512, 88E1514 and 88E1518 PHYs
+ *
+ * Ideas taken from 88E6xxx DSA and DP83640 drivers. This file
+ * implements the packet timestamping support only (PTP).  TAI
+ * support is separate.
+ */
+#include <linux/marvell_ptp.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+
+#include "marvell_ptp.h"
+
+#define MARVELL_PAGE_MISC			6
+#define GCR					20
+#define GCR_PTP_POWER_DOWN			BIT(9)
+#define GCR_PTP_REF_CLOCK_SOURCE		BIT(8)
+#define GCR_PTP_INPUT_SOURCE			BIT(7)
+#define GCR_PTP_OUTPUT				BIT(6)
+
+#define MARVELL_PAGE_PTP_PORT_1			8
+
+#define MARVELL_PAGE_TAI_GLOBAL			12
+#define MARVELL_PAGE_PTP_GLOBAL			14
+#define PTPG_READPLUS_COMMAND			14
+#define PTPG_READPLUS_DATA			15
+
+struct marvell_phy_ptp {
+	struct marvell_ptp ptp;
+	struct mii_timestamper mii_ts;
+};
+
+static struct marvell_phy_ptp *mii_ts_to_phy_ptp(struct mii_timestamper *mii_ts)
+{
+	return container_of(mii_ts, struct marvell_phy_ptp, mii_ts);
+}
+
+static bool marvell_phy_ptp_rxtstamp(struct mii_timestamper *mii_ts,
+				     struct sk_buff *skb, int type)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ptp_rxtstamp(&phy_ptp->ptp, skb, type);
+}
+
+static void marvell_phy_ptp_txtstamp(struct mii_timestamper *mii_ts,
+				     struct sk_buff *skb, int type)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ptp_txtstamp(&phy_ptp->ptp, skb, type);
+}
+
+static int marvell_phy_ptp_hwtstamp(struct mii_timestamper *mii_ts,
+				    struct kernel_hwtstamp_config *kcfg,
+				    struct netlink_ext_ack *ack)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ptp_hwtstamp(&phy_ptp->ptp, kcfg, ack);
+}
+
+static int marvell_phy_ptp_ts_info(struct mii_timestamper *mii_ts,
+				   struct kernel_ethtool_ts_info *ts_info)
+{
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+
+	return marvell_ptp_ts_info(&phy_ptp->ptp, ts_info);
+}
+
+/* TAI accessor functions */
+static int marvell_phy_tai_enable(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_MISC, GCR,
+				GCR_PTP_POWER_DOWN, 0);
+}
+
+static u64 marvell_phy_tai_clock_read(struct device *dev,
+				      struct ptp_system_timestamp *sts)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int err, oldpage, lo, hi;
+
+	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
+	if (oldpage >= 0) {
+		/* 88e151x says to write 0x8e0e */
+		ptp_read_system_prets(sts);
+		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
+		ptp_read_system_postts(sts);
+		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
+		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
+	}
+	err = phy_restore_page(phydev, oldpage, err);
+
+	if (err || lo < 0 || hi < 0)
+		return 0;
+
+	return lo | hi << 16;
+}
+
+static int marvell_phy_tai_write(struct device *dev, u8 reg, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_TAI_GLOBAL, reg, val);
+}
+
+static int marvell_phy_tai_modify(struct device *dev, u8 reg, u16 mask, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_TAI_GLOBAL,
+				reg, mask, val);
+}
+
+static int marvell_phy_ptp_global_write(struct device *dev, u8 reg, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_PTP_GLOBAL, reg, val);
+}
+
+/* Read the status, timestamp and PTP common header sequence from the PHY.
+ * Apparently, reading these are atomic, but there is no mention how the
+ * PHY treats this access as atomic. So, we set the DisTSOverwrite bit
+ * when configuring the PHY.
+ */
+static int marvell_phy_ptp_port_read_ts(struct device *dev,
+					struct marvell_ts *ts, u8 reg)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int oldpage, page = MARVELL_PAGE_PTP_PORT_1 + (reg >> 4);
+	int ret;
+
+	reg &= 15;
+
+	/* Read status register */
+	oldpage = phy_select_page(phydev, page);
+	if (oldpage >= 0) {
+		ret = __phy_read(phydev, reg);
+		if (ret < 0)
+			goto restore;
+
+		ts->stat = ret;
+		if (!(ts->stat & MV_STATUS_VALID)) {
+			ret = 0;
+			goto restore;
+		}
+
+		/* Read low timestamp */
+		ret = __phy_read(phydev, reg + 1);
+		if (ret < 0)
+			goto restore;
+
+		ts->time = ret;
+
+		/* Read high timestamp */
+		ret = __phy_read(phydev, reg + 2);
+		if (ret < 0)
+			goto restore;
+
+		ts->time |= ret << 16;
+
+		/* Read sequence */
+		ret = __phy_read(phydev, reg + 3);
+		if (ret < 0)
+			goto restore;
+
+		ts->seq = ret;
+
+		/* Clear valid */
+		__phy_write(phydev, reg, 0);
+
+		ret = 1;
+	}
+restore:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int marvell_phy_ptp_port_write(struct device *dev, u8 reg, u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_write_paged(phydev, MARVELL_PAGE_PTP_PORT_1 + (reg >> 4),
+			       reg & 15, val);
+}
+
+static int marvell_phy_ptp_port_modify(struct device *dev, u8 reg, u16 mask,
+				       u16 val)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	return phy_modify_paged(phydev, MARVELL_PAGE_PTP_PORT_1 + (reg >> 4),
+				reg & 15, mask, val);
+}
+
+static long marvell_phy_ptp_aux_work(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	struct marvell_phy_ptp *phy_ptp;
+
+	phy_ptp = mii_ts_to_phy_ptp(phydev->mii_ts);
+
+	return marvell_ptp_aux_work(&phy_ptp->ptp);
+}
+
+static const struct marvell_ptp_ops marvell_phy_ptp_ops = {
+	.tai_enable = marvell_phy_tai_enable,
+	.tai_clock_read = marvell_phy_tai_clock_read,
+	.tai_write = marvell_phy_tai_write,
+	.tai_modify = marvell_phy_tai_modify,
+	.ptp_global_write = marvell_phy_ptp_global_write,
+	.ptp_port_read_ts = marvell_phy_ptp_port_read_ts,
+	.ptp_port_write = marvell_phy_ptp_port_write,
+	.ptp_port_modify = marvell_phy_ptp_port_modify,
+	.ptp_aux_work = marvell_phy_ptp_aux_work,
+};
+
+static const struct marvell_tai_param marvell_phy_tai_param = {
+	/* This assumes a 125MHz clock */
+	.cc_mult_num = 1 << 9,
+	.cc_mult_den = 15625U,
+	.cc_mult = 8 << 28,
+	.cc_shift = 28,
+};
+
+/* This function should be called from the PHY threaded interrupt
+ * handler to process any stored timestamps in a timely manner.
+ * The presence of an interrupt has an effect on how quickly a
+ * timestamp requiring received packet will be processed.
+ */
+irqreturn_t marvell_phy_ptp_irq(struct phy_device *phydev)
+{
+	struct marvell_phy_ptp *phy_ptp;
+
+	if (!phydev->mii_ts)
+		return IRQ_NONE;
+
+	phy_ptp = mii_ts_to_phy_ptp(phydev->mii_ts);
+
+	return marvell_ptp_irq(&phy_ptp->ptp);
+}
+EXPORT_SYMBOL_GPL(marvell_phy_ptp_irq);
+
+int marvell_phy_ptp_probe(struct phy_device *phydev)
+{
+	struct marvell_phy_ptp *phy_ptp;
+	struct marvell_tai *tai;
+	struct device *dev;
+	int err;
+
+	dev = &phydev->mdio.dev;
+
+	phy_ptp = devm_kzalloc(dev, sizeof(*phy_ptp), GFP_KERNEL);
+	if (!phy_ptp)
+		return -ENOMEM;
+
+	phy_ptp->mii_ts.rxtstamp = marvell_phy_ptp_rxtstamp;
+	phy_ptp->mii_ts.txtstamp = marvell_phy_ptp_txtstamp;
+	phy_ptp->mii_ts.hwtstamp = marvell_phy_ptp_hwtstamp;
+	phy_ptp->mii_ts.ts_info = marvell_phy_ptp_ts_info;
+
+	/* Get the TAI for this PHY. */
+	err = marvell_tai_probe(&tai, &marvell_phy_ptp_ops,
+				&marvell_phy_tai_param,
+			        "Marvell PHY", dev);
+	if (err)
+		return err;
+
+	err = marvell_ptp_probe(&phy_ptp->ptp, dev, tai,
+				&marvell_phy_ptp_ops);
+	if (err) {
+		marvell_tai_remove(tai);
+		return err;
+	}
+
+	phydev->mii_ts = &phy_ptp->mii_ts;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(marvell_phy_ptp_probe);
+
+void marvell_phy_ptp_remove(struct phy_device *phydev)
+{
+	struct marvell_phy_ptp *phy_ptp;
+	struct mii_timestamper *mii_ts;
+
+	/* Disconnect from the net subsystem - we assume there is no
+	 * packet activity at this point.
+	 */
+	mii_ts = phydev->mii_ts;
+	phydev->mii_ts = NULL;
+
+	if (mii_ts) {
+		phy_ptp = mii_ts_to_phy_ptp(mii_ts);
+		marvell_ptp_remove(&phy_ptp->ptp);
+		marvell_tai_remove(phy_ptp->ptp.tai);
+	}
+}
+EXPORT_SYMBOL_GPL(marvell_phy_ptp_remove);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Marvell PHY PTP library");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/phy/marvell_ptp.h b/drivers/net/phy/marvell_ptp.h
new file mode 100644
index 000000000000..7d009fe4fd23
--- /dev/null
+++ b/drivers/net/phy/marvell_ptp.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MARVELL_PTP_H
+#define MARVELL_PTP_H
+
+#if IS_ENABLED(CONFIG_MARVELL_PHY_PTP)
+irqreturn_t marvell_phy_ptp_irq(struct phy_device *phydev);
+int marvell_phy_ptp_probe(struct phy_device *phydev);
+void marvell_phy_ptp_remove(struct phy_device *phydev);
+#else
+static inline int marvell_phy_ptp_dummy_probe(void)
+{
+	return 0;
+}
+#define marvell_phy_ptp_probe(x...) marvell_phy_ptp_dummy_probe()
+
+static inline void marvell_phy_ptp_remove(struct phy_device *phydev)
+{
+}
+#endif
+
+#endif
-- 
2.30.2


