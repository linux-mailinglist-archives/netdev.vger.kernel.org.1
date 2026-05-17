Return-Path: <netdev+bounces-288718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RsB0K5CjCWrGiwQAu9opvQ
	(envelope-from <netdev+bounces-288718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4699560AD9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2828300878D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359126ED33;
	Sun, 17 May 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="IK8S5ebO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C41A682B
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016589; cv=none; b=ly8MFQ0I8Pcm/MLGBgIMHadw3lzg34I7veHMwxU5EmPVLjS2OcQ/bJHp5sHwOKMuqiLDLEXVCi94k21AkmesZS2DvYR1365wVJbh6NuGsmlp5w9NYxNdkipTa/80DVG6d47Eop5oe2Lupgner7Cb3/eLq9ssgjoP0DH4c4YlIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016589; c=relaxed/simple;
	bh=yJP1V90gAYQDKjEyEG+pNA3s324lWEwHHIhWXjaCTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obRoY+hCXWD1+PMWB7KLVdDRlAYRDTc26Bq4eZ+8H41SyTdrvsSrUvtknlpaxyzgZdAKQDys+fac4RpHyrmRcUcpOlRtoG/IPmQErO22PmzTEDQ4y3oUlhJAyZEDyftaKzRu+HNN3IIAHCMpXW1Fps5E9TY+LbYgwreANyKtqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=IK8S5ebO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779016558; x=1779621358;
	i=markus.stockhausen@gmx.de;
	bh=S4TAYeFIlUsfIybUZVPDVO8LXhQ/91tClonogm2bN/s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IK8S5ebOtSxgWMQzkBJCd7Dn1UF0rf6qJc7TwcE3EGi801ZNLDdOEe9OTthtqwQ3
	 aVLWr4foMnQKwmLpmSAAH5wgvoyOYV12ogn/9GBDcpS9WL3cTT7tbUnoRh/pS+79n
	 Z9KGdpqynjh/LKStlCy7AZ3ZMbgCjcFJLU1FxXt78Y7FAs7KTADJjJwGkB/d2TEiH
	 3TRaUOdvJ8wGGWBxQl0dKUlsImzck77slZq2Q6YNu+F2gf9l9nY4vrwTiBSkxcki9
	 XTbJYCM1CDeEGW/V9WT+ShcCm4aB+cOKrkdQSBuZmFxiheO3nsE7WEOBFZuUkMxmh
	 tDMXqanU7XilwJfUAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1x4CoA0iGO-00prjS; Sun, 17
 May 2026 13:15:58 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH] net: mdio: Add Realtek Otto MDIO driver
Date: Sun, 17 May 2026 13:15:30 +0200
Message-ID: <20260517111530.220017-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hVK5OgjMEcibdAQsNUbr2zRF/3TId2DrwkJy0HXrH5gHxDz4B33
 WD4LOgl5ByDEjAxiAwcBt10dmrk3RdttahmavSx6l2dyryA7bKsngG8DyZzhZAQhpBwHNVu
 eh5Fh2F9bpHkA85UaXmAlBfkKKqIbDTQGRUX5nQBDrRDPpZzwl7WICw8xKwahgTb8bzKtvS
 EUal6fhhEOt/OC8q65CQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LvNRS123rhc=;G0UjLcp90vtRwBoBmgjFWEyE+wh
 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
 gKOfW6YMQ84Bf44wi918ByUwjEU=
X-Rspamd-Queue-Id: C4699560AD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288718-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

With this RFC I want to open up the discussion what will be the best
way to enhance/replace the existing RTL9300 MDIO driver for further
devices of the Realtek Otto switch platform.

A short history: Downstream never had good code quality. But there
was always a pragmatic solution that sadly had tricky dependencies.
Upstreaming of the RTL9300 standalone driver in 2025 did not find its
way back into the OpenWrt project due to the limited device support.
In the last year a lot of things were sorted out and now there is a
driver with a superset of features that has gained some quality. Its
basis comes from the downstream code and was developed towards the
upstream concept. As of today it is the backbone for over 80 devices
driven by 8 different SoCs.

There are a few issues left that will fixed in the next weeks. So
slowly it boils down to the question, how to best submit all of this
to upstream.

What works the same as the existing driver:

- The multiple SMI bus concept has been taken over
- Existing RTL930x devices are supported

What goes beyound the current implementation:

- The driver supports RTL838x, RTL839x and RTL931x devices.
- The I/O handling has been harmonized/simplified
- Driver provides C45/C22 access in parallel
- The driver configures the Realtek MDIO polling engine. This is a
  crucial part so that the MAC layer can properly recognize the
  network status of all ports. See the long documentation.

I attach the current version of the driver to this RFC so that you
can get a better picture.

Thanks for your time and feedback in advance.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/Kconfig             |   10 +
 drivers/net/mdio/Makefile            |    1 +
 drivers/net/mdio/mdio-realtek-otto.c | 1239 ++++++++++++++++++++++++++
 3 files changed, 1250 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-realtek-otto.c

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index c71132f33f84..9254b262f623 100644
=2D-- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -169,6 +169,16 @@ config MDIO_IPQ8064
 	  This driver supports the MDIO interface found in the network
 	  interface units of the IPQ8064 SoC
=20
+config MDIO_REALTEK_OTTO
+	tristate "Realtek Otto MDIO interface support"
+	default MACH_REALTEK_RTL
+	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	help
+	  This driver supports the MDIO bus on SoCs of the Realtek Otto
+	  switch platform. These include gigabit devices like the RTL838x
+	  or RTL839x. Additionally 2.5G/10G devices like the RTL930x and
+	  RTL931x are supported.
+
 config MDIO_REALTEK_RTL9300
 	tristate "Realtek RTL9300 MDIO interface support"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 048586746026..71bfd56b0916 100644
=2D-- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MDIO_MSCC_MIIM)		+=3D mdio-mscc-miim.o
 obj-$(CONFIG_MDIO_MVUSB)		+=3D mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+=3D mdio-octeon.o
 obj-$(CONFIG_MDIO_PIC64HPSC)		+=3D mdio-pic64hpsc.o
+obj-$(CONFIG_MDIO_REALTEK_OTTO)		+=3D mdio-realtek-otto.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+=3D mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+=3D mdio-regmap.o
 obj-$(CONFIG_MDIO_SUN4I)		+=3D mdio-sun4i.o
diff --git a/drivers/net/mdio/mdio-realtek-otto.c b/drivers/net/mdio/mdio-=
realtek-otto.c
new file mode 100644
index 000000000000..8c37866ce268
=2D-- /dev/null
+++ b/drivers/net/mdio/mdio-realtek-otto.c
@@ -0,0 +1,1239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * On all Realtek switch platforms the hardware periodically reads the li=
nk status of all PHYs.
+ * The result is automatically written into MAC specific registers that c=
an be consumed by a
+ * DSA driver.  This is to some degree programmable, so that one can tell=
 the hardware to read
+ * specific C22 registers from specific pages, or C45 registers, to deter=
mine the current link
+ * speed, duplex, flow-control, ...
+ *
+ * This happens without any need for the driver to do anything at runtime=
, completely invisible
+ * and in a parallel hardware thread, independent of the CPU running Linu=
x. All one needs to do
+ * is to set it up once. Having the MAC link settings automatically follo=
w the PHY link status
+ * also happens to be the only way to control MAC port status in a meanin=
gful way, or at least
+ * it's the only way thats is fully understood, as this is what every ven=
dor firmware is doing.
+ *
+ * The hardware PHY polling unit doesn't care about bus locking. It just =
assumes that all paged
+ * PHY operations are also done via the same hardware unit offering this =
PHY access abstractions.
+ *
+ * Additionally the devices are known to have a so called raw mode. Using=
 the special MAX_PAGE-1
+ * with the MDIO controller found in Realtek SoCs allows to access the PH=
Y in raw mode, i.e.
+ * bypassing the cache and paging engine of the MDIO controller. E.g. for=
 RTL838x this is 4095.
+ *
+ * On the other hand Realtek PHYs usually make use of select register 0x1=
f to switch pages. There
+ * is no problem to issue separate page and access bus calls to the PHYs =
when they are not
+ * attached to an Realtek SoC. The design should be to keep the PHY code =
bus independent.
+ *
+ * To bring all this together one needs a tricky bus design that intercep=
ts select page calls but
+ * lets raw page accesses through. And especially knows how to handle raw=
 accesses to the select
+ * register.
+ *
+ * While C45 clause handling is pretty standard the legacy functions basi=
cally track the accesses
+ * and the state of the bus with the rtmd_port attributes of the control =
structure. The page
+ * selection works as follows:
+ *
+ * phy_write(phydev, RTMD_PAGE_SELECT, 12)	: store internal page 12 in dr=
iver
+ * phy_write(phydev, 7, 33)			: write page=3D12, reg=3D7, val=3D33
+ *
+ * Any Realtek PHY that is connected to this bus must simply provide the =
standard page functions:
+ *
+ * define RTL821X_PAGE_SELECT 0x1f
+ *
+ * static int rtl821x_read_page(struct phy_device *phydev)
+ * {
+ *   return __phy_read(phydev, RTL821X_PAGE_SELECT);
+ * }
+ *
+ * static int rtl821x_write_page(struct phy_device *phydev, int page)
+ * {
+ *   return __phy_write(phydev, RTL821X_PAGE_SELECT, page);
+ * }
+ *
+ * In case there are non Realtek PHYs attached to the bus the logic might=
 need to be changed.
+ * For now it should be sufficient.
+ */
+
+#include <linux/fwnode.h>
+#include <linux/fwnode_mdio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define RTMD_MAX_PORTS				57
+#define RTMD_MAX_SMI_BUSES			4
+
+#define RTMD_838X_NUM_BUSES			1
+#define RTMD_838X_NUM_PAGES			4096
+#define RTMD_838X_NUM_PORTS			28
+#define RTMD_839X_NUM_BUSES			2
+#define RTMD_839X_NUM_PAGES			8192
+#define RTMD_839X_NUM_PORTS			52
+#define RTMD_930X_NUM_BUSES			4
+#define RTMD_930X_NUM_PAGES			4096
+#define RTMD_930X_NUM_PORTS			28
+#define RTMD_931X_NUM_BUSES			4
+#define RTMD_931X_NUM_PAGES			8192
+#define RTMD_931X_NUM_PORTS			56
+
+#define RTMD_PAGE_SELECT			0x1f
+#define RTMD_RAW_PAGE(p)			((p) - 1)
+
+#define RTMD_PHY_AQR113C_A			0x31c31c12
+#define RTMD_PHY_AQR113C_B			0x31c31c13
+#define RTMD_PHY_AQR813				0x31c31cb2
+#define RTMD_PHY_RTL8218D			0x001cc983
+#define RTMD_PHY_RTL8218E			0x001cc984
+#define RTMD_PHY_RTL8221B_VB_CG			0x001cc849
+#define RTMD_PHY_RTL8221B_VM_CG			0x001cc84a
+#define RTMD_PHY_RTL8224			0x001ccad0
+#define RTMD_PHY_RTL8226			0x001cc838
+#define RTMD_PHY_RTL8261			0x001ccaf3
+
+#define RTMD_PHY_MAC_1G				3
+#define RTMD_PHY_MAC_2G_PLUS			1
+#define RTMD_PHY_MAC_SDS			0
+
+#define RTMD_PHY_POLL_MMD(dev, reg, bit)	((((bit) & GENMASK(3, 0)) << 21)=
 | \
+						 (((dev) & GENMASK(4, 0)) << 16) | \
+						 ((reg) & GENMASK(15, 0)))
+
+/* MDIO bus registers/fields */
+#define RTMD_C45_DATA(devnum, regnum)		((((devnum) & GENMASK(4, 0)) << 16=
) | \
+						  ((regnum) & GENMASK(15, 0)))
+#define RTMD_DATA_IN_HI_OUT_LOW			16
+#define RTMD_DATA_IN_LOW_OUT_HI			0
+#define RTMD_RUN				BIT(0)
+
+#define RTMD_838X_SMI_GLB_CTRL			0xa100
+#define   RTMD_838X_SMI_GLB_PHY_MAN_24_27	BIT(7)
+#define   RTMD_838X_SMI_GLB_PHY_PATCH_DONE	BIT(15)
+#define RTMD_838X_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTMD_838X_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTMD_838X_CMD_FAIL			0 /* No hardware support */
+#define   RTMD_838X_CMD_READ_C22		0
+#define   RTMD_838X_CMD_READ_C45		BIT(1)
+#define   RTMD_838X_CMD_WRITE_C22		BIT(2)
+#define   RTMD_838X_CMD_WRITE_C45		(BIT(1) | BIT(2))
+#define   RTMD_838X_C22_DATA(page, reg)		((reg) << 20 | RTMD_PAGE_SELECT =
<< 15 | (page) << 3)
+#define RTMD_838X_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define RTMD_838X_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTMD_838X_SMI_POLL_CTRL			0xa17c
+#define RTMD_838X_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
+#define RTMD_839X_BCAST_PHYID_CTRL		0x03ec
+#define RTMD_839X_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTMD_839X_CMD_FAIL			BIT(1)
+#define   RTMD_839X_CMD_READ_C22		0
+#define   RTMD_839X_CMD_READ_C45		BIT(2)
+#define   RTMD_839X_CMD_WRITE_C22		BIT(3)
+#define   RTMD_839X_CMD_WRITE_C45		(BIT(2) | BIT(3))
+#define   RTMD_839X_C22_DATA(page, reg)		((reg) << 5 | (page) << 10)
+#define RTMD_839X_PHYREG_CTRL			(0x03e0)
+#define   RTMD_839X_PHYREG_SKIP_EXT_PAGE	GENMASK(8, 0)
+#define RTMD_839X_PHYREG_DATA_CTRL		0x03f0
+#define RTMD_839X_PHYREG_MMD_CTRL		0x03f4
+#define RTMD_839X_PHYREG_PORT_CTRL(x)		(0x03e4 + (x) * 4)
+#define RTMD_839X_SMI_PORT_POLLING_CTRL		0x03fc
+#define RTMD_839X_SMI_GLB_CTRL			0x03f8
+
+#define RTMD_930X_SMI_GLB_CTRL			0xca00
+#define   RTMD_930X_SMI_GLB_INTF_SEL(bus)	BIT(16 + (bus))
+#define   RTMD_930X_SMI_GLB_POLL_SEL(bus)	BIT(20 + (bus))
+#define RTMD_930X_SMI_ACCESS_PHY_CTRL_0		0xcb70
+#define RTMD_930X_SMI_ACCESS_PHY_CTRL_1		0xcb74
+#define   RTMD_930X_CMD_FAIL			BIT(25)
+#define   RTMD_930X_CMD_READ_C22		0
+#define   RTMD_930X_CMD_READ_C45		BIT(1)
+#define   RTMD_930X_CMD_WRITE_C22		BIT(2)
+#define   RTMD_930X_CMD_WRITE_C45		(BIT(1) | BIT(2))
+#define   RTMD_930X_C22_DATA(page, reg)		((reg) << 20 | RTMD_PAGE_SELECT =
<< 15 | (page) << 3)
+#define RTMD_930X_SMI_ACCESS_PHY_CTRL_2		0xcb78
+#define RTMD_930X_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTMD_930X_SMI_PORT0_15_POLLING_SEL	0xca08
+#define RTMD_930X_SMI_PORT16_27_POLLING_SEL	0xca0c
+#define RTMD_930X_SMI_MAC_TYPE_CTRL		0xca04
+#define   RTMD_930X_SMI_MAC_TYPE_P0_23(pn)	(GENMASK(1, 0) << (((pn) / 4) =
* 2))
+#define   RTMD_930X_SMI_MAC_TYPE_P24_27(pn)	(GENMASK(2, 0) << (((pn) - 24=
) * 3 + 12))
+#define RTMD_930X_SMI_POLL_CTRL			0xca90
+#define RTMD_930X_SMI_PRVTE_POLLING_CTRL	0xca10
+#define RTMD_930X_SMI_10G_POLLING_REG0_CFG	0xcbb4
+#define RTMD_930X_SMI_10G_POLLING_REG9_CFG	0xcbb8
+#define RTMD_930X_SMI_10G_POLLING_REG10_CFG	0xcbbc
+#define RTMD_930X_SMI_PORT0_5_ADDR_CTRL	0xcb80
+
+#define RTMD_931X_SMI_PORT_POLLING_CTRL		0x0ccc
+#define RTMD_931X_SMI_INDRT_ACCESS_BC		0x0c14
+#define   RTMD_931X_SMI_INDRT_PORT(pn)		((pn) << 5)
+#define RTMD_931X_SMI_GLB_CTRL0			0x0cc0
+#define   RTMD_931X_SMI_GLB_PRVTE0_POLL(bus)	BIT(20 + (bus))
+#define   RTMD_931X_SMI_GLB_PRVTE1_POLL(bus)	BIT(24 + (bus))
+#define RTMD_931X_SMI_GLB_CTRL1			0x0cbc
+#define   RTMD_931X_SMI_GLB_FMT_SEL_C45(bus)	BIT((bus) * 2 + 1)
+#define   RTMD_931X_SMI_GLB_FMT_SEL_FRC(bus)	BIT((bus) * 2)
+#define RTMD_931X_SMI_INDRT_ACCESS_CTRL_0	0x0c00
+#define   RTMD_931X_CMD_FAIL			BIT(1)
+#define   RTMD_931X_CMD_READ_C22		0
+#define   RTMD_931X_CMD_READ_C45		BIT(3)
+#define   RTMD_931X_CMD_WRITE_C22		BIT(4)
+#define   RTMD_931X_CMD_WRITE_C45		(BIT(3) | BIT(4))
+#define   RTMD_931X_C22_DATA(page, reg)		((reg) << 6 | (page) << 11)
+#define RTMD_931X_SMI_INDRT_ACCESS_CTRL_1	0x0c04
+#define RTMD_931X_SMI_INDRT_ACCESS_CTRL_2(x)	(0x0c08 + (x) * 4)
+#define RTMD_931X_SMI_INDRT_ACCESS_CTRL_3	0x0c10
+#define RTMD_931X_SMI_INDRT_ACCESS_MMD		0x0c18
+#define RTMD_931X_SMI_PHY_ABLTY_GET_SEL(pn)	(0x0cac + ((pn) / 16) * 4)
+#define   RTMD_931X_SMI_PHY_ABLTY_MDIO		0x0
+#define   RTMD_931X_SMI_PHY_ABLTY_SDS		0x2
+#define   RTMD_931X_SMI_PHY_ABLTY_MASK(pn)	(GENMASK(1, 0) << (((pn) % 16)=
 * 2))
+#define RTMD_931X_SMI_PORT_POLLING_SEL		0x0c9c
+#define RTMD_931X_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTMD_931X_SMI_10GPHY_POLLING_SEL0	0x0cf0
+#define RTMD_931X_SMI_10GPHY_POLLING_SEL1	0x0cf4
+#define RTMD_931X_SMI_10GPHY_POLLING_SEL2	0x0cf8
+#define RTMD_931X_SMI_10GPHY_POLLING_SEL3	0x0cfc
+#define RTMD_931X_SMI_10GPHY_POLLING_SEL4	0x0d00
+
+#define for_each_phy_port(ctrl, pn) \
+	for_each_set_bit(pn, (ctrl)->phy_ports, RTMD_MAX_PORTS)
+
+#define for_each_sds_port(ctrl, pn) \
+	for_each_set_bit(pn, (ctrl)->sds_ports, RTMD_MAX_PORTS)
+
+struct rtmd_port {
+	int page;
+	bool raw;
+	u8 smi_addr;
+	u8 smi_bus;
+};
+
+struct rtmd_bus {
+	bool is_c45;
+	struct mii_bus *mii_bus;
+};
+
+struct rtmd_ctrl {
+	struct mutex lock; /* protect HW access */
+	struct regmap *map;
+	const struct rtmd_config *cfg;
+	struct rtmd_port port[RTMD_MAX_PORTS];
+	struct rtmd_bus bus[RTMD_MAX_SMI_BUSES];
+	DECLARE_BITMAP(phy_ports, RTMD_MAX_PORTS);
+	DECLARE_BITMAP(sds_ports, RTMD_MAX_PORTS);
+};
+
+struct rtmd_chan {
+	struct rtmd_ctrl *ctrl;
+	u8 smi_bus;
+	s8 port[PHY_MAX_ADDR];
+};
+
+struct rtmd_command_data {
+	u32 brdcast;
+	u32 c22_adr;
+	u32 c45_adr;
+	u32 ex_page;
+	u32 io_data;
+	u32 mask_lo;
+	u32 mask_hi;
+};
+
+struct rtmd_config {
+	u32 cmd_fail;
+	u32 cmd_io_shift;
+	struct rtmd_command_data cmd_regs;
+	int bus_map_base;
+	u16 num_buses;
+	u16 num_pages;
+	u16 num_ports;
+	u32 poll_ctrl;
+	int port_map_base;
+	int (*read_c22)(struct mii_bus *bus, u32 pn, u32 page, u32 reg, u32 *val=
);
+	int (*read_c45)(struct mii_bus *bus, u32 pn, u32 devnum, u32 regnum, u32=
 *val);
+	int (*setup_ctrl)(struct rtmd_ctrl *ctrl);
+	int (*setup_polling)(struct rtmd_ctrl *ctrl);
+	int (*write_c22)(struct mii_bus *bus, u32 pn, u32 page, u32 reg, u32 val=
);
+	int (*write_c45)(struct mii_bus *bus, u32 pn, u32 devnum, u32 regnum, u3=
2 val);
+};
+
+struct rtmd_phy_info {
+	int mac_type;
+	bool has_giga_lite;
+	bool has_res_reg;
+	bool force_res;
+	unsigned int poll_duplex;
+	unsigned int poll_adv_1000;
+	unsigned int poll_lpa_1000;
+};
+
+static inline struct rtmd_ctrl *rtmd_ctrl_from_bus(struct mii_bus *bus)
+{
+	return ((struct rtmd_chan *)bus->priv)->ctrl;
+}
+
+static int rtmd_phy_to_port(struct mii_bus *bus, int phy)
+{
+	struct rtmd_chan *chan =3D bus->priv;
+
+	return chan->port[phy];
+}
+
+static int rtmd_run_cmd(struct mii_bus *bus, u32 cmd,
+			struct rtmd_command_data *cmd_data, u32 *val)
+{
+	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
+	u32 cmdstate;
+	int ret;
+
+	if (ctrl->cfg->cmd_regs.mask_hi) {
+		/* high port count models have 3 extra command registers */
+		ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.brdcast, cmd_data->=
brdcast);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.ex_page, cmd_data->=
ex_page);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.mask_hi, cmd_data->=
mask_hi);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.mask_lo, cmd_data->m=
ask_lo);
+	if (ret)
+		return ret;
+
+	/* depending on model write output data to high or low word in I/O regis=
ter */
+	ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.io_data,
+			   cmd_data->io_data << ctrl->cfg->cmd_io_shift);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.c45_adr, cmd_data->c=
45_adr);
+	if (ret)
+		return ret;
+
+	/* C22 data and command bits share the same register. */
+	ret =3D regmap_write(ctrl->map, ctrl->cfg->cmd_regs.c22_adr,
+			   cmd_data->c22_adr | cmd | RTMD_RUN);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read_poll_timeout(ctrl->map, ctrl->cfg->cmd_regs.c22_adr,
+				       cmdstate, !(cmdstate & RTMD_RUN), 20, 500000);
+	if (ret) {
+		dev_warn_once(&bus->dev, "access timed out\n");
+		return ret;
+	}
+
+	if (cmdstate & ctrl->cfg->cmd_fail) {
+		dev_warn_once(&bus->dev, "access failed\n");
+		return -EIO;
+	}
+
+	if (!val)
+		return 0;
+
+	/* read back data from opposite word in I/O register */
+	ret =3D regmap_read(ctrl->map, ctrl->cfg->cmd_regs.io_data, val);
+	if (!ret)
+		*val =3D (*val >> (16 - ctrl->cfg->cmd_io_shift)) & GENMASK(15, 0);
+
+	return ret;
+}
+
+static int rtmd_838x_read_c22(struct mii_bus *bus, u32 pn, u32 page, u32 =
reg, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_838X_C22_DATA(page, reg),
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_838X_CMD_READ_C22, &cmd_data, val);
+}
+
+static int rtmd_838x_write_c22(struct mii_bus *bus, u32 pn, u32 page, u32=
 reg, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_838X_C22_DATA(page, reg),
+		.io_data =3D val,
+		.mask_lo =3D BIT(pn),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_838X_CMD_WRITE_C22, &cmd_data, NULL);
+}
+
+static int rtmd_838x_read_c45(struct mii_bus *bus, u32 pn, u32 devnum, u3=
2 regnum, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_838X_CMD_READ_C45, &cmd_data, val);
+}
+
+static int rtmd_838x_write_c45(struct mii_bus *bus, u32 pn, u32 devnum, u=
32 regnum, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D val,
+		.mask_lo =3D BIT(pn),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_838X_CMD_WRITE_C45, &cmd_data, NULL);
+}
+
+static int rtmd_839x_read_c22(struct mii_bus *bus, u32 pn, u32 page, u32 =
reg, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_839X_C22_DATA(page, reg),
+		.ex_page =3D RTMD_839X_PHYREG_SKIP_EXT_PAGE,
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_839X_CMD_READ_C22, &cmd_data, val);
+}
+
+static int rtmd_839x_write_c22(struct mii_bus *bus, u32 pn, u32 page, u32=
 reg, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_839X_C22_DATA(page, reg),
+		.ex_page =3D RTMD_839X_PHYREG_SKIP_EXT_PAGE,
+		.io_data =3D val,
+		.mask_lo =3D (u32)(BIT_ULL(pn)),
+		.mask_hi =3D (u32)(BIT_ULL(pn) >> 32),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_839X_CMD_WRITE_C22, &cmd_data, NULL);
+}
+
+static int rtmd_839x_read_c45(struct mii_bus *bus, u32 pn, u32 devnum, u3=
2 regnum, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_839X_CMD_READ_C45, &cmd_data, val);
+}
+
+static int rtmd_839x_write_c45(struct mii_bus *bus, u32 pn, u32 devnum, u=
32 regnum, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D val,
+		.mask_lo =3D (u32)(BIT_ULL(pn)),
+		.mask_hi =3D (u32)(BIT_ULL(pn) >> 32),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_839X_CMD_WRITE_C45, &cmd_data, NULL);
+}
+
+static int rtmd_930x_read_c22(struct mii_bus *bus, u32 pn, u32 page, u32 =
reg, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_930X_C22_DATA(page, reg),
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_930X_CMD_READ_C22, &cmd_data, val);
+}
+
+static int rtmd_930x_write_c22(struct mii_bus *bus, u32 pn, u32 page, u32=
 reg, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_930X_C22_DATA(page, reg),
+		.io_data =3D val,
+		.mask_lo =3D BIT(pn),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_930X_CMD_WRITE_C22, &cmd_data, NULL);
+}
+
+static int rtmd_930x_read_c45(struct mii_bus *bus, u32 pn, u32 devnum, u3=
2 regnum, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D pn,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_930X_CMD_READ_C45, &cmd_data, val);
+}
+
+static int rtmd_930x_write_c45(struct mii_bus *bus, u32 pn, u32 devnum, u=
32 regnum, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.io_data =3D val,
+		.mask_lo =3D BIT(pn),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_930X_CMD_WRITE_C45, &cmd_data, NULL);
+}
+
+static int rtmd_931x_read_c22(struct mii_bus *bus, u32 pn, u32 page, u32 =
reg, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.brdcast =3D RTMD_931X_SMI_INDRT_PORT(pn),
+		.c22_adr =3D RTMD_931X_C22_DATA(page, reg),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_931X_CMD_READ_C22, &cmd_data, val);
+}
+
+static int rtmd_931x_write_c22(struct mii_bus *bus, u32 pn, u32 page, u32=
 reg, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c22_adr =3D RTMD_931X_C22_DATA(page, reg),
+		.mask_lo =3D (u32)(BIT_ULL(pn)),
+		.mask_hi =3D (u32)(BIT_ULL(pn) >> 32),
+		.io_data =3D val,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_931X_CMD_WRITE_C22, &cmd_data, NULL);
+}
+
+static int rtmd_931x_read_c45(struct mii_bus *bus, u32 pn, u32 devnum, u3=
2 regnum, u32 *val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.brdcast =3D RTMD_931X_SMI_INDRT_PORT(pn),
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+	};
+
+	return rtmd_run_cmd(bus, RTMD_931X_CMD_READ_C45, &cmd_data, val);
+}
+
+static int rtmd_931x_write_c45(struct mii_bus *bus, u32 pn, u32 devnum, u=
32 regnum, u32 val)
+{
+	struct rtmd_command_data cmd_data =3D {
+		.c45_adr =3D RTMD_C45_DATA(devnum, regnum),
+		.mask_lo =3D (u32)(BIT_ULL(pn)),
+		.mask_hi =3D (u32)(BIT_ULL(pn) >> 32),
+		.io_data =3D val,
+	};
+
+	return rtmd_run_cmd(bus, RTMD_931X_CMD_WRITE_C45, &cmd_data, NULL);
+}
+
+static int rtmd_read_c45(struct mii_bus *bus, int phy, int devnum, int re=
gnum)
+{
+	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
+	int ret, pn, val =3D 0;
+
+	pn =3D rtmd_phy_to_port(bus, phy);
+	if (pn < 0)
+		return -ENOENT;
+
+	guard(mutex)(&ctrl->lock);
+	ret =3D (*ctrl->cfg->read_c45)(bus, pn, devnum, regnum, &val);
+	dev_dbg(&bus->dev, "rd_MMD(phy=3D0x%02x, dev=3D0x%04x, reg=3D0x%04x) =3D=
 0x%04x, ret =3D %d\n",
+		phy, devnum, regnum, val, ret);
+
+	return ret ? ret : val;
+}
+
+static int rtmd_read_c22(struct mii_bus *bus, int phy, int regnum)
+{
+	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
+	int ret, pn, val =3D 0;
+
+	pn =3D rtmd_phy_to_port(bus, phy);
+	if (pn < 0)
+		return -ENOENT;
+
+	guard(mutex)(&ctrl->lock);
+	if (regnum =3D=3D RTMD_PAGE_SELECT &&
+	    ctrl->port[pn].page !=3D RTMD_RAW_PAGE(ctrl->cfg->num_pages))
+		return ctrl->port[pn].page;
+
+	ctrl->port[pn].raw =3D (ctrl->port[pn].page =3D=3D RTMD_RAW_PAGE(ctrl->c=
fg->num_pages));
+
+	ret =3D (*ctrl->cfg->read_c22)(bus, pn, ctrl->port[pn].page, regnum, &va=
l);
+	dev_dbg(&bus->dev, "rd_PHY(phy=3D0x%02x, pag=3D0x%04x, reg=3D0x%04x) =3D=
 0x%04x, ret =3D %d\n",
+		phy, ctrl->port[pn].page, regnum, val, ret);
+
+	return ret ? ret : val;
+}
+
+static int rtmd_write_c45(struct mii_bus *bus, int phy, int devnum, int r=
egnum, u16 val)
+{
+	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
+	int ret, pn;
+
+	pn =3D rtmd_phy_to_port(bus, phy);
+	if (pn < 0)
+		return -ENOENT;
+
+	guard(mutex)(&ctrl->lock);
+	ret =3D (*ctrl->cfg->write_c45)(bus, pn, devnum, regnum, val);
+	dev_dbg(&bus->dev, "wr_MMD(phy=3D0x%02x, dev=3D0x%04x, reg=3D0x%04x, val=
=3D0x%04x), ret =3D %d\n",
+		phy, devnum, regnum, val, ret);
+
+	return ret;
+}
+
+static int rtmd_write_c22(struct mii_bus *bus, int phy, int regnum, u16 v=
al)
+{
+	struct rtmd_ctrl *ctrl =3D rtmd_ctrl_from_bus(bus);
+	int ret, page, pn;
+
+	pn =3D rtmd_phy_to_port(bus, phy);
+	if (pn < 0)
+		return -ENOENT;
+
+	guard(mutex)(&ctrl->lock);
+	page =3D ctrl->port[pn].page;
+
+	if (regnum =3D=3D RTMD_PAGE_SELECT)
+		ctrl->port[pn].page =3D val;
+
+	if (!ctrl->port[pn].raw &&
+	    (regnum !=3D RTMD_PAGE_SELECT || page =3D=3D RTMD_RAW_PAGE(ctrl->cfg=
->num_pages))) {
+		ctrl->port[pn].raw =3D (page =3D=3D RTMD_RAW_PAGE(ctrl->cfg->num_pages)=
);
+
+		ret =3D (*ctrl->cfg->write_c22)(bus, pn, page, regnum, val);
+		dev_dbg(&bus->dev,
+			"wr_PHY(phy=3D0x%02x, pag=3D0x%04x, reg=3D0x%04x, val=3D0x%04x), ret =
=3D %d\n",
+			phy, page, regnum, val, ret);
+		return ret;
+	}
+
+	ctrl->port[pn].raw =3D false;
+
+	return 0;
+}
+
+static int rtmd_poll_port(struct rtmd_ctrl *ctrl, int pn, bool active)
+{
+	return regmap_assign_bits(ctrl->map, ctrl->cfg->poll_ctrl + (pn / 32) * =
4,
+				  BIT(pn % 32), active);
+}
+
+static int rtmd_disable_polling(struct rtmd_ctrl *ctrl)
+{
+	int pn, ret;
+
+	for (pn =3D 0; pn < ctrl->cfg->num_ports; pn++) {
+		ret =3D rtmd_poll_port(ctrl, pn, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_enable_polling(struct rtmd_ctrl *ctrl)
+{
+	int pn, ret;
+
+	for_each_phy_port(ctrl, pn) {
+		ret =3D rtmd_poll_port(ctrl, pn, true);
+		if (ret)
+			return ret;
+	}
+
+	for_each_sds_port(ctrl, pn) {
+		ret =3D rtmd_poll_port(ctrl, pn, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_setup_smi_topology(struct rtmd_ctrl *ctrl)
+{
+	u32 reg, mask, val, pn;
+	int ret;
+
+	for_each_phy_port(ctrl, pn) {
+		if (ctrl->cfg->bus_map_base) {
+			reg =3D ctrl->cfg->bus_map_base + (pn / 16) * 4;
+			mask =3D GENMASK(1, 0) << ((pn % 16) * 2);
+			val =3D (u32)ctrl->port[pn].smi_bus << __ffs(mask);
+			ret =3D regmap_update_bits(ctrl->map, reg, mask, val);
+			if (ret)
+				return ret;
+		}
+
+		if (ctrl->cfg->port_map_base) {
+			reg =3D ctrl->cfg->port_map_base + (pn / 6) * 4;
+			mask =3D GENMASK(4, 0) << ((pn % 6) * 5);
+			val =3D (u32)ctrl->port[pn].smi_addr << __ffs(mask);
+			ret =3D regmap_update_bits(ctrl->map, reg, mask, val);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static u32 rtmd_get_phy_id(struct phy_device *phydev)
+{
+	if (!phydev)
+		return 0;
+
+	if (phydev->is_c45) {
+		for (int devad =3D 0; devad < MDIO_MMD_NUM; devad++) {
+			u32 phyid =3D phydev->c45_ids.device_ids[devad];
+
+			if (phyid && phyid !=3D 0xffffffff)
+				return phyid;
+		}
+	}
+
+	return phydev->phy_id;
+}
+
+static int rtmd_get_phy_info(struct rtmd_ctrl *ctrl, int pn, struct rtmd_=
phy_info *phyinfo)
+{
+	struct mii_bus *bus;
+	u32 smi_addr, phyid;
+
+	if (!test_bit(pn, ctrl->phy_ports))
+		return -EINVAL;
+
+	bus =3D ctrl->bus[ctrl->port[pn].smi_bus].mii_bus;
+	smi_addr =3D ctrl->port[pn].smi_addr;
+	phyid =3D rtmd_get_phy_id(mdiobus_get_phy(bus, smi_addr));
+	*phyinfo =3D (struct rtmd_phy_info){};
+
+	/* Determine PHY specific characteristics for polling fine tuning */
+	switch (phyid) {
+	case RTMD_PHY_AQR113C_A:
+	case RTMD_PHY_AQR113C_B:
+	case RTMD_PHY_AQR813:
+		phyinfo->mac_type =3D RTMD_PHY_MAC_2G_PLUS;
+		phyinfo->poll_duplex =3D RTMD_PHY_POLL_MMD(1, 0x0000, 8);
+		phyinfo->poll_adv_1000 =3D RTMD_PHY_POLL_MMD(7, 0xc400, 15);
+		phyinfo->poll_lpa_1000 =3D RTMD_PHY_POLL_MMD(7, 0xe820, 15);
+		break;
+	case RTMD_PHY_RTL8218D:
+	case RTMD_PHY_RTL8218E:
+		phyinfo->mac_type =3D RTMD_PHY_MAC_1G;
+		phyinfo->has_giga_lite =3D true;
+		break;
+	case RTMD_PHY_RTL8226:
+	case RTMD_PHY_RTL8221B_VB_CG:
+	case RTMD_PHY_RTL8221B_VM_CG:
+	case RTMD_PHY_RTL8224:
+		phyinfo->mac_type =3D RTMD_PHY_MAC_2G_PLUS;
+		phyinfo->has_giga_lite =3D true;
+		phyinfo->poll_duplex =3D RTMD_PHY_POLL_MMD(31, 0xa400, 8);
+		phyinfo->poll_adv_1000 =3D RTMD_PHY_POLL_MMD(31, 0xa412, 9);
+		phyinfo->poll_lpa_1000 =3D RTMD_PHY_POLL_MMD(31, 0xa414, 11);
+		break;
+	case RTMD_PHY_RTL8261:
+		phyinfo->mac_type =3D RTMD_PHY_MAC_2G_PLUS;
+		phyinfo->has_giga_lite =3D true;
+		phyinfo->has_res_reg =3D true;
+		break;
+	default:
+		dev_warn(&bus->dev, "skip polling setup for phy 0x%08x on port %d\n", p=
hyid, pn);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtmd_838x_setup_ctrl(struct rtmd_ctrl *ctrl)
+{
+	/*
+	 * PHY_PATCH_DONE enables phy control via SoC. This is required for phy =
access,
+	 * including patching. Must always be set before the phys are probed.
+	 */
+	return regmap_set_bits(ctrl->map, RTMD_838X_SMI_GLB_CTRL,
+			       RTMD_838X_SMI_GLB_PHY_PATCH_DONE);
+}
+
+static int rtmd_838x_setup_polling(struct rtmd_ctrl *ctrl)
+{
+	/*
+	 * Control bits EX_PHY_MAN_xxx have an important effect on the detection=
 of the media
+	 * status (fibre/copper) of a PHY. Once activated, register MAC_LINK_MED=
IA_STS can
+	 * give the real media status (0=3Dcopper, 1=3Dfibre). For now assume th=
at if address 24 is
+	 * PHY driven, it must be a combo PHY and media detection is needed.
+	 */
+	return regmap_assign_bits(ctrl->map, RTMD_838X_SMI_GLB_CTRL,
+				  RTMD_838X_SMI_GLB_PHY_MAN_24_27,
+				  test_bit(24, ctrl->phy_ports));
+}
+
+static int rtmd_930x_setup_ctrl(struct rtmd_ctrl *ctrl)
+{
+	int ret;
+
+	/* Define C22/C45 bus feature set */
+	for (int smi_bus =3D 0; smi_bus < ctrl->cfg->num_buses; smi_bus++) {
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_930X_SMI_GLB_CTRL,
+					 RTMD_930X_SMI_GLB_INTF_SEL(smi_bus),
+					 ctrl->bus[smi_bus].is_c45);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_930x_set_port_ability(struct rtmd_ctrl *ctrl, u32 pn, u32=
 ability)
+{
+	u32 mask;
+
+	if (pn < 24)
+		mask =3D RTMD_930X_SMI_MAC_TYPE_P0_23(pn);
+	else if (pn < 28)
+		mask =3D RTMD_930X_SMI_MAC_TYPE_P24_27(pn);
+	else
+		return -EINVAL;
+
+	return regmap_update_bits(ctrl->map, RTMD_930X_SMI_MAC_TYPE_CTRL,
+				  mask, ability << __ffs(mask));
+}
+
+static int rtmd_930x_setup_polling(struct rtmd_ctrl *ctrl)
+{
+	struct rtmd_phy_info phyinfo;
+	int ret;
+	u32 pn;
+
+	/* set all ports to "SerDes driven" */
+	for (pn =3D 0; pn < ctrl->cfg->num_ports; pn++) {
+		ret =3D rtmd_930x_set_port_ability(ctrl, pn, RTMD_PHY_MAC_SDS);
+		if (ret)
+			return ret;
+	}
+
+	/* Define PHY specific polling parameters */
+	for_each_phy_port(ctrl, pn) {
+		if (rtmd_get_phy_info(ctrl, pn, &phyinfo))
+			continue;
+
+		/* set port to "PHY driven" */
+		ret =3D rtmd_930x_set_port_ability(ctrl, pn, phyinfo.mac_type);
+		if (ret)
+			return ret;
+
+		/* polling via standard or resolution register */
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_930X_SMI_GLB_CTRL,
+					 RTMD_930X_SMI_GLB_POLL_SEL(ctrl->port[pn].smi_bus),
+					 phyinfo.has_res_reg);
+		if (ret)
+			return ret;
+
+		/* proprietary Realtek 1G/2.5 lite polling */
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_930X_SMI_PRVTE_POLLING_CTRL,
+					 BIT(pn), phyinfo.has_giga_lite);
+		if (ret)
+			return ret;
+
+		if (!phyinfo.poll_duplex && !phyinfo.poll_adv_1000 && !phyinfo.poll_lpa=
_1000)
+			continue;
+
+		/* Unique 10G polling setup enforced by hardware design. Always same 10=
G PHYs. */
+		ret =3D regmap_write(ctrl->map, RTMD_930X_SMI_10G_POLLING_REG0_CFG,
+				   phyinfo.poll_duplex);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, RTMD_930X_SMI_10G_POLLING_REG9_CFG,
+				   phyinfo.poll_adv_1000);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, RTMD_930X_SMI_10G_POLLING_REG10_CFG,
+				   phyinfo.poll_lpa_1000);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_931x_setup_ctrl(struct rtmd_ctrl *ctrl)
+{
+	int ret;
+
+	/* Define C22/C45 bus feature set (bit 1 of SMI_SETx_FMT_SEL) */
+	for (int smi_bus =3D 0; smi_bus < ctrl->cfg->num_buses; smi_bus++) {
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_931X_SMI_GLB_CTRL1,
+					 RTMD_931X_SMI_GLB_FMT_SEL_C45(smi_bus),
+					 ctrl->bus[smi_bus].is_c45);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_931x_set_port_ability(struct rtmd_ctrl *ctrl, u32 pn, u32=
 ability)
+{
+	u32 mask;
+
+	if (pn < ctrl->cfg->num_ports)
+		mask =3D RTMD_931X_SMI_PHY_ABLTY_MASK(pn);
+	else
+		return -EINVAL;
+
+	return regmap_update_bits(ctrl->map, RTMD_931X_SMI_PHY_ABLTY_GET_SEL(pn)=
,
+				  mask, ability << __ffs(mask));
+}
+
+static int rtmd_931x_setup_polling(struct rtmd_ctrl *ctrl)
+{
+	struct rtmd_phy_info phyinfo;
+	int ret;
+	u32 pn;
+
+	/* set all ports to "SerDes driven" */
+	for (pn =3D 0; pn < ctrl->cfg->num_ports; pn++) {
+		ret =3D rtmd_931x_set_port_ability(ctrl, pn, RTMD_931X_SMI_PHY_ABLTY_SD=
S);
+		if (ret)
+			return ret;
+	}
+
+	/* Define PHY specific polling parameters */
+	for_each_phy_port(ctrl, pn) {
+		u8 smi_bus =3D ctrl->port[pn].smi_bus;
+
+		if (rtmd_get_phy_info(ctrl, pn, &phyinfo))
+			continue;
+
+		/* set port to "PHY driven" */
+		ret =3D rtmd_931x_set_port_ability(ctrl, pn, RTMD_931X_SMI_PHY_ABLTY_MD=
IO);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_931X_SMI_GLB_CTRL0,
+					 RTMD_931X_SMI_GLB_PRVTE0_POLL(smi_bus),
+					 phyinfo.has_res_reg);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_931X_SMI_GLB_CTRL0,
+					 RTMD_931X_SMI_GLB_PRVTE1_POLL(smi_bus),
+					 phyinfo.force_res);
+		if (ret)
+			return ret;
+
+		/* polling std. or proprietary format (bit 0 of SMI_SETx_FMT_SEL) */
+		ret =3D regmap_assign_bits(ctrl->map, RTMD_931X_SMI_GLB_CTRL1,
+					 RTMD_931X_SMI_GLB_FMT_SEL_FRC(smi_bus),
+					 phyinfo.force_res);
+		if (ret)
+			return ret;
+
+		if (!phyinfo.poll_duplex && !phyinfo.poll_adv_1000 && !phyinfo.poll_lpa=
_1000)
+			continue;
+
+		/* Unique 10G polling setup enforced by hardware design. Always same 10=
G PHYs. */
+		ret =3D regmap_write(ctrl->map, RTMD_931X_SMI_10GPHY_POLLING_SEL2,
+				   phyinfo.poll_duplex);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, RTMD_931X_SMI_10GPHY_POLLING_SEL3,
+				   phyinfo.poll_adv_1000);
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(ctrl->map, RTMD_931X_SMI_10GPHY_POLLING_SEL4,
+				   phyinfo.poll_lpa_1000);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmd_map_ports(struct device *dev)
+{
+	struct fwnode_handle *fw_dev =3D dev_fwnode(dev);
+	struct rtmd_ctrl *ctrl =3D dev_get_drvdata(dev);
+	int smi_bus, smi_addr, pn;
+
+	struct fwnode_handle *fw_parent __free(fwnode_handle) =3D fwnode_get_par=
ent(fw_dev);
+	if (!fw_parent)
+		return -ENODEV;
+
+	struct fwnode_handle *fw_switch __free(fwnode_handle) =3D
+		fwnode_get_named_child_node(fw_parent, "ethernet-switch");
+	if (!fw_switch)
+		return dev_err_probe(dev, -ENODEV, "%pfwP missing ethernet-switch\n", f=
w_parent);
+
+	struct fwnode_handle *fw_ports __free(fwnode_handle) =3D
+		fwnode_get_named_child_node(fw_switch, "ethernet-ports");
+	if (!fw_ports)
+		return dev_err_probe(dev, -ENODEV, "%pfwP missing ethernet-ports\n", fw=
_switch);
+
+	fwnode_for_each_child_node_scoped(fw_ports, fw_port) {
+		if (fwnode_property_read_u32(fw_port, "reg", &pn))
+			continue;
+
+		if (pn =3D=3D ctrl->cfg->num_ports)
+			continue;
+
+		if (pn > ctrl->cfg->num_ports)
+			return dev_err_probe(dev, -EINVAL, "%pfwP illegal port number\n", fw_p=
ort);
+
+		if (test_bit(pn, ctrl->phy_ports) ||
+		    test_bit(pn, ctrl->sds_ports))
+			return dev_err_probe(dev, -EINVAL, "%pfwP duplicate port number\n",
+					     fw_port);
+
+		struct fwnode_handle *fw_phy __free(fwnode_handle) =3D
+			fwnode_find_reference(fw_port, "phy-handle", 0);
+		if (IS_ERR(fw_phy)) {
+			/* port without a phy-handle is SerDes driven */
+			__set_bit(pn, ctrl->sds_ports);
+			continue;
+		}
+
+		if (fwnode_property_read_u32(fw_phy, "reg", &smi_addr))
+			return dev_err_probe(dev, -EINVAL, "%pfwP no phy address\n", fw_phy);
+
+		if (smi_addr >=3D PHY_MAX_ADDR)
+			return dev_err_probe(dev, -EINVAL, "%pfwP illegal phy address\n", fw_p=
hy);
+
+		struct fwnode_handle *fw_bus __free(fwnode_handle) =3D fwnode_get_paren=
t(fw_phy);
+		if (!fw_bus || fwnode_property_read_u32(fw_bus, "reg", &smi_bus))
+			return dev_err_probe(dev, -EINVAL, "%pfwP no bus number\n",
+					     fw_bus ?: fw_phy);
+
+		if (smi_bus >=3D ctrl->cfg->num_buses)
+			return dev_err_probe(dev, -EINVAL, "%pfwP illegal bus number\n", fw_bu=
s);
+
+		if (fwnode_device_is_compatible(fw_phy, "ethernet-phy-ieee802.3-c45"))
+			ctrl->bus[smi_bus].is_c45 =3D true;
+
+		ctrl->port[pn].smi_bus =3D smi_bus;
+		ctrl->port[pn].smi_addr =3D smi_addr;
+		__set_bit(pn, ctrl->phy_ports);
+	}
+
+	return 0;
+}
+
+static int rtmd_probe_one(struct device *dev, struct rtmd_ctrl *ctrl,
+			  struct fwnode_handle *fw_bus)
+{
+	struct rtmd_chan *chan;
+	struct mii_bus *bus;
+	int smi_bus, ret;
+	u32 pn;
+
+	ret =3D fwnode_property_read_u32(fw_bus, "reg", &smi_bus);
+	if (ret)
+		return dev_err_probe(dev, ret, "%pfwP no bus number\n", fw_bus);
+	if (smi_bus >=3D ctrl->cfg->num_buses)
+		return dev_err_probe(dev, -EINVAL, "%pfwP illegal bus number\n", fw_bus=
);
+
+	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*chan));
+	if (!bus)
+		return -ENOMEM;
+
+	ctrl->bus[smi_bus].mii_bus =3D bus;
+
+	chan =3D bus->priv;
+	chan->ctrl =3D ctrl;
+	chan->smi_bus =3D smi_bus;
+
+	/* setup reverse lookup bus/phy -> port */
+	for (int smi_addr =3D 0; smi_addr < ARRAY_SIZE(chan->port); smi_addr++)
+		chan->port[smi_addr] =3D -1;
+	for_each_phy_port(ctrl, pn)
+		if (ctrl->port[pn].smi_bus =3D=3D smi_bus)
+			chan->port[ctrl->port[pn].smi_addr] =3D pn;
+
+	bus->name =3D "Realtek MDIO bus";
+	bus->read =3D rtmd_read_c22;
+	bus->write =3D rtmd_write_c22;
+	bus->read_c45 =3D rtmd_read_c45;
+	bus->write_c45 =3D rtmd_write_c45;
+	bus->parent =3D dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "realtek-mdio-%d", smi_bus);
+
+	ret =3D devm_of_mdiobus_register(dev, bus, to_of_node(fw_bus));
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot register MDIO %d bus\n", smi_bus=
);
+
+	return 0;
+}
+
+static int rtmd_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct rtmd_ctrl *ctrl;
+	int ret;
+
+	ctrl =3D devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ret =3D devm_mutex_init(dev, &ctrl->lock);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, ctrl);
+	ctrl->cfg =3D (const struct rtmd_config *)device_get_match_data(dev);
+	ctrl->map =3D syscon_node_to_regmap(pdev->dev.of_node->parent);
+	if (IS_ERR(ctrl->map))
+		return PTR_ERR(ctrl->map);
+
+	ret =3D rtmd_disable_polling(ctrl);
+	if (ret)
+		return ret;
+
+	ret =3D rtmd_map_ports(dev);
+	if (ret)
+		return ret;
+
+	ret =3D rtmd_setup_smi_topology(ctrl);
+	if (ret)
+		return ret;
+
+	if (ctrl->cfg->setup_ctrl) {
+		ret =3D ctrl->cfg->setup_ctrl(ctrl);
+		if (ret)
+			return ret;
+	}
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret =3D rtmd_probe_one(dev, ctrl, child);
+		if (ret)
+			return ret;
+	}
+
+	if (ctrl->cfg->setup_polling) {
+		ret =3D ctrl->cfg->setup_polling(ctrl);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D rtmd_enable_polling(ctrl);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct rtmd_config rtmd_838x_cfg =3D {
+	.cmd_fail	=3D RTMD_838X_CMD_FAIL,
+	.cmd_io_shift	=3D RTMD_DATA_IN_HI_OUT_LOW,
+	.cmd_regs =3D {
+		.c22_adr =3D RTMD_838X_SMI_ACCESS_PHY_CTRL_1,
+		.c45_adr =3D RTMD_838X_SMI_ACCESS_PHY_CTRL_3,
+		.mask_lo =3D RTMD_838X_SMI_ACCESS_PHY_CTRL_0,
+		.io_data =3D RTMD_838X_SMI_ACCESS_PHY_CTRL_2,
+	},
+	.num_buses	=3D RTMD_838X_NUM_BUSES,
+	.num_pages	=3D RTMD_838X_NUM_PAGES,
+	.num_ports	=3D RTMD_838X_NUM_PORTS,
+	.poll_ctrl	=3D RTMD_838X_SMI_POLL_CTRL,
+	.port_map_base	=3D RTMD_838X_SMI_PORT0_5_ADDR_CTRL,
+	.read_c22	=3D rtmd_838x_read_c22,
+	.read_c45	=3D rtmd_838x_read_c45,
+	.setup_ctrl	=3D rtmd_838x_setup_ctrl,
+	.setup_polling	=3D rtmd_838x_setup_polling,
+	.write_c22	=3D rtmd_838x_write_c22,
+	.write_c45	=3D rtmd_838x_write_c45,
+};
+
+static const struct rtmd_config rtmd_839x_cfg =3D {
+	.cmd_fail	=3D RTMD_839X_CMD_FAIL,
+	.cmd_io_shift	=3D RTMD_DATA_IN_HI_OUT_LOW,
+	.cmd_regs =3D {
+		.brdcast =3D RTMD_839X_BCAST_PHYID_CTRL,
+		.c22_adr =3D RTMD_839X_PHYREG_ACCESS_CTRL,
+		.c45_adr =3D RTMD_839X_PHYREG_MMD_CTRL,
+		.ex_page =3D RTMD_839X_PHYREG_CTRL,
+		.mask_lo =3D RTMD_839X_PHYREG_PORT_CTRL(0),
+		.mask_hi =3D RTMD_839X_PHYREG_PORT_CTRL(1),
+		.io_data =3D RTMD_839X_PHYREG_DATA_CTRL,
+	},
+	.num_buses	=3D RTMD_839X_NUM_BUSES,
+	.num_pages	=3D RTMD_839X_NUM_PAGES,
+	.num_ports	=3D RTMD_839X_NUM_PORTS,
+	.poll_ctrl	=3D RTMD_839X_SMI_PORT_POLLING_CTRL,
+	.read_c22	=3D rtmd_839x_read_c22,
+	.read_c45	=3D rtmd_839x_read_c45,
+	.write_c22	=3D rtmd_839x_write_c22,
+	.write_c45	=3D rtmd_839x_write_c45,
+};
+
+static const struct rtmd_config rtmd_930x_cfg =3D {
+	.cmd_fail	=3D RTMD_930X_CMD_FAIL,
+	.cmd_io_shift	=3D RTMD_DATA_IN_HI_OUT_LOW,
+	.cmd_regs =3D {
+		.c22_adr =3D RTMD_930X_SMI_ACCESS_PHY_CTRL_1,
+		.c45_adr =3D RTMD_930X_SMI_ACCESS_PHY_CTRL_3,
+		.mask_lo =3D RTMD_930X_SMI_ACCESS_PHY_CTRL_0,
+		.io_data =3D RTMD_930X_SMI_ACCESS_PHY_CTRL_2,
+	},
+	.bus_map_base	=3D RTMD_930X_SMI_PORT0_15_POLLING_SEL,
+	.num_buses	=3D RTMD_930X_NUM_BUSES,
+	.num_pages	=3D RTMD_930X_NUM_PAGES,
+	.num_ports	=3D RTMD_930X_NUM_PORTS,
+	.poll_ctrl	=3D RTMD_930X_SMI_POLL_CTRL,
+	.port_map_base	=3D RTMD_930X_SMI_PORT0_5_ADDR_CTRL,
+	.read_c22	=3D rtmd_930x_read_c22,
+	.read_c45	=3D rtmd_930x_read_c45,
+	.setup_ctrl	=3D rtmd_930x_setup_ctrl,
+	.setup_polling	=3D rtmd_930x_setup_polling,
+	.write_c22	=3D rtmd_930x_write_c22,
+	.write_c45	=3D rtmd_930x_write_c45,
+};
+
+static const struct rtmd_config rtmd_931x_cfg =3D {
+	.cmd_fail	=3D RTMD_931X_CMD_FAIL,
+	.cmd_io_shift	=3D RTMD_DATA_IN_LOW_OUT_HI,
+	.cmd_regs =3D {
+		.brdcast =3D RTMD_931X_SMI_INDRT_ACCESS_BC,
+		.c22_adr =3D RTMD_931X_SMI_INDRT_ACCESS_CTRL_0,
+		.c45_adr =3D RTMD_931X_SMI_INDRT_ACCESS_MMD,
+		.ex_page =3D RTMD_931X_SMI_INDRT_ACCESS_CTRL_1,
+		.mask_lo =3D RTMD_931X_SMI_INDRT_ACCESS_CTRL_2(0),
+		.mask_hi =3D RTMD_931X_SMI_INDRT_ACCESS_CTRL_2(1),
+		.io_data =3D RTMD_931X_SMI_INDRT_ACCESS_CTRL_3,
+	},
+	.bus_map_base	=3D RTMD_931X_SMI_PORT_POLLING_SEL,
+	.num_buses	=3D RTMD_931X_NUM_BUSES,
+	.num_pages	=3D RTMD_931X_NUM_PAGES,
+	.num_ports	=3D RTMD_931X_NUM_PORTS,
+	.poll_ctrl	=3D RTMD_931X_SMI_PORT_POLLING_CTRL,
+	.port_map_base	=3D RTMD_931X_SMI_PORT_ADDR_CTRL,
+	.read_c22	=3D rtmd_931x_read_c22,
+	.read_c45	=3D rtmd_931x_read_c45,
+	.setup_ctrl	=3D rtmd_931x_setup_ctrl,
+	.setup_polling	=3D rtmd_931x_setup_polling,
+	.write_c22	=3D rtmd_931x_write_c22,
+	.write_c45	=3D rtmd_931x_write_c45,
+};
+
+static const struct of_device_id rtmd_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &rtmd_838x_cfg, },
+	{ .compatible =3D "realtek,rtl8392-mdio", .data =3D &rtmd_839x_cfg, },
+	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &rtmd_930x_cfg, },
+	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &rtmd_931x_cfg, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtmd_ids);
+
+static struct platform_driver rtmd_driver =3D {
+	.probe =3D rtmd_probe,
+	.driver =3D {
+		.name =3D "mdio-rtl-otto",
+		.of_match_table =3D rtmd_ids,
+	},
+};
+
+module_platform_driver(rtmd_driver);
+
+MODULE_AUTHOR("Markus Stockhausen <markus.stockhausen@gmx.de>");
+MODULE_DESCRIPTION("Realtek Otto MDIO driver");
+MODULE_LICENSE("GPL");
=2D-=20
2.54.0


