Return-Path: <netdev+bounces-305617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NEtvFlWCTWqe1QEAu9opvQ
	(envelope-from <netdev+bounces-305617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C37720465
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=rYoz846Q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305617-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305617-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B0B303F7F4
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F074C77BF;
	Tue,  7 Jul 2026 22:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21248124C;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463681; cv=none; b=s8nZQXHiqqMU5VA6BCZ6Xo4z6cx7FV55Mg33eOAFJE+s4DPuRnIVBtjAqgziQIWTzq16I1EBs4JRZ8/pyzSqgHeTUTDH9OHZun8xddJVYgLooCsbPCjKhhMTsDh+GWss4npc5+sZfEbaTwMGnpxIJnbnwhbdl8Kc5M12E83f6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463681; c=relaxed/simple;
	bh=k/xTka8c00spcMv7wSfzf5Jy9717WAXhR5OhsJeXbYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D17ET6EXKOfXaeJp3DdroG9DkWoEBDwhcyqhPYLje/Wt6aBlcuN+qN5U9JDSgz6QciMR/4DImCNA3gATg5R4qWMMWh/vBHEIpLPDCeQnohX6F5LOdAowtH2cPc0E0yNdBs97XTB4mqxy8WZq5lmLNJnMeNtm1py6oRBgMRXxEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYoz846Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77009C2BCFA;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783463681;
	bh=k/xTka8c00spcMv7wSfzf5Jy9717WAXhR5OhsJeXbYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rYoz846QncHApu7FwxnZq824jnsSLuXj+Bubzhg3t74En8ywY0UNWZpnxk/V0bf5T
	 pHtx/6mhl4evtbe6MbldhV+5EMOf4TK6mMUWVnbrFNaSXZK0GiotyK0lFxvWp7Fcg1
	 qxkTKabYD41mNt/Y3KS4Z0Q7kQtSQh21HVikUy/CYhds0d3gu/BP+4whfim5tOLt3+
	 eLkyl1RW6vM+hwKAJbo+35WrrA1h3LIBcxFQg9T8hs4TN8W6C/Js/HDS3WqDMdpGD/
	 LBANYldIklNTO9sqre3biv7mKmih/6tV0rmWtx29NGDmNSBune3OFDv1KYYlsGvJaL
	 Kdqr6tgaIcsHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BFC43602;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 08 Jul 2026 01:33:41 +0300
Subject: [PATCH net-next v5 13/13] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-adin1140-driver-v5-13-4aca7b51a58b@analog.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783463678; l=30444;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=VpiewsIid4iiRTPKCH+bqp8kBZgV8K9q/IiCAfEIk7g=;
 b=BQHSO2yQgheDfUFMDZ4ZmVWScEYCdl95ugTmMlDrnZM967dA4vbQNGgO9K4F4JAzQZeIOioeI
 tkFULNgl6UKBY9zGqlfUJnM1/ahWiAjHGX0mr8pUOAgumFmGy3B6aKD
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305617-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,analog.com:url,analog.com:replyto,analog.com:mid,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1C37720465

From: Ciprian Regus <ciprian.regus@analog.com>

Add a driver for ADIN1140. The device is a 10BASE-T1S MAC-PHY
(integrated in the same package) that connects to a CPU over an SPI bus,
and implements the Open Alliance TC6 protocol for control and frame
transfers. As such, this driver relies on oa_tc6 for the communication
with the device. The device has an alternative name (AD3306), so the
driver can be probed using one of the two compatible strings.

For control transactions, ADIN1140 only implements the protected mode.
The driver has a custom implementation for the mii_bus access methods as a
workaround for hardware issues:

1. The OA TC6 standard defines the direct and indirect access modes for
   MDIO transactions. The ADIN1140 incorrectly advertises indirect mode
   only (supported capabilities register - 0x2, bit 9), while actually
   implementing just the direct mode. We cannot rely on the CAP register
   to choose an access method (which oa_tc6 does by default, even though
   it only implements the direct mode), so the driver has to use its
   own.
2. The ADIN1140 cannot access the C22 register space of the internal
   PHY, while the PHY is busy receiving frames. If that happens, the
   CONFIG0 and CONFIG2 registers of the MAC will get corrupted and the
   data transfer will stop. Those two registers configure settings for
   the transfer protocol between the MAC and host, so the value for some
   of their subfields shouldn't be changed while the netdev is up.
   Since we know the PHY is internal, the MAC driver can implement a
   custom mii_bus, which can intercept C22 accesses. Most of the
   registers mapped in the 0x0 - 0x3 range (the only ones the PHY offers)
   are read only, and their value can be read from somewhere else (e.g
   the PHYID 1 & 2 have the same value as 0x1 in the MAC memory map).
   For the fields that are R/W (loopback and AN/reset) in the control
   register, the PHY driver already implements the set_loopback() and
   config_aneg() functions. The C22 write function of the driver is a
   no-op and is used to protect against the ioctl MDIO access path.
   C45 accesses do not cause this issue, so we can properly implement
   them.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v5 changelog:
 - Configured the MAC to clear statistics on read and updated
   adin1140_stats_work() to accumulate the stats values in
   priv->stats. Otherwise, fast accumulating counters stored in the hw
   will overflow, since registers are 32 bit wide. Also, only updated
   priv->stats when a counter was successfully read.
 - Replaced ndo_set_rx_mode use with ndo_set_rx_mode_async.
 - Fixed the logic in adin1140_rx_mode to update unicast/multicast MAC
   filter entries even if IFF_ALLMUTLI is set.
 - Removed {rx,tx}_unicast_frames and rx_addr_filter_dropped from the
   custom ethtool statistics, since they are already covered by standard
   counters.
v4:
 - Renamed the macros used to define registers in MMS0 and MMS1 to
   include ADIN1140_MAC_ prefix in order to match the TRM naming scheme
   (MAC_register_name for MMS0 and MMS1).
 - Used the renamed OA_TC6_MAC_MMS1 macro for MMS1 instead of
   OA_TC6_VEND_MMS1.
 - Updated the MAINTAINERS entry to reflect the dt bindings file rename to
   adi,ad3306.yaml.
v3 changelog:
 - Clear the unused destination address filter slots in
   adin1140_rx_mode_work(). This is required in case we remove
   multicast or unicast addresses from a netdev.
 - The device only allows destination MAC masks for the first 2 slots.
   Fix adin1140_mac_filter_set() to take this into account.
 - use oa_tc6_{write,read}_register_mms, since the OA_TC6_MMS_REG()
   macro was removed. Update the register address defines accordingly.
 - use the devres API for mdio and netdev alloc/register instead of
   manually managing those.
 - use dev_err_probe() in several places to simplify logging during
   probe.
 - use scoped_guard() instead of spin_lock/unlock(). Had to break some
   sequences in their own function to fit the 80 character limit.
 - fix the comment describing the reason for skb padding in the TX path.
v2 changelog:
 - Exported statistics that match the ethtool_stats entries as such and
   kept the other ones custom, using ethtool strings.
 - Used phy_do_ioctl_running() for ndo_eth_ioctl.
 - Adapted the mii_bus and PHY handling to the newly added
   OA_TC6_BROKEN_PHY flag for oa_tc6.
 - Used the oa_tc6_mdiobus_read_c45/oa_tc6_mdiobus_write_c45 functions
   for the C45 read/write mii_bus operations.
 - Removed OA TC6 register definitions (e.g CONFIG2) from the adin1140
   driver and instead used the ones exported from oa_tc6.h
 - Used OA_TC6_MMS_REG to define MMS registers instead of
   ADIN1140_MMS_REG.
 - Returned default values for the MII_PHYSID1/MII_PHYSID2.
 - Set the mii_bus->phy_mask, since the the same PHY will be registered
   32 times otherwise.
 - Updated the MAINTAINERS entry to include the dt-bindings.
---
 MAINTAINERS                         |   8 +
 drivers/net/ethernet/adi/Kconfig    |  12 +
 drivers/net/ethernet/adi/Makefile   |   1 +
 drivers/net/ethernet/adi/adin1140.c | 791 ++++++++++++++++++++++++++++++++++++
 4 files changed, 812 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25f8e4aedbed..ba946b63d4a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1900,6 +1900,14 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
+ANALOG DEVICES INC ETHERNET DRIVERS
+M:	Ciprian Regus <ciprian.regus@analog.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/net/adi,ad3306.yaml
+F:	drivers/net/ethernet/adi/adin1140.c
+
 ANALOG DEVICES INC ETHERNET PHY DRIVERS
 M:	Ciprian Regus <ciprian.regus@analog.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
index 760a9a60bc15..bdb8ff7d15da 100644
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -26,4 +26,16 @@ config ADIN1110
 	  Say yes here to build support for Analog Devices ADIN1110
 	  Low Power 10BASE-T1L Ethernet MAC-PHY.
 
+config ADIN1140
+	tristate "Analog Devices ADIN1140 MAC-PHY"
+	depends on SPI
+	select ADIN1140_PHY
+	select OA_TC6
+	help
+	  Say yes here to build support for Analog Devices, Inc. ADIN1140
+	  10BASE-T1S Ethernet MAC-PHY.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called adin1140.
+
 endif # NET_VENDOR_ADI
diff --git a/drivers/net/ethernet/adi/Makefile b/drivers/net/ethernet/adi/Makefile
index d0383d94303c..0390ca8ccc49 100644
--- a/drivers/net/ethernet/adi/Makefile
+++ b/drivers/net/ethernet/adi/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_ADIN1110) += adin1110.o
+obj-$(CONFIG_ADIN1140) += adin1140.o
diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
new file mode 100644
index 000000000000..93710baca151
--- /dev/null
+++ b/drivers/net/ethernet/adi/adin1140.c
@@ -0,0 +1,791 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Analog Devices, Inc. ADIN1140 10BASE-T1S MAC-PHY
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/oa_tc6.h>
+#include <linux/phy.h>
+
+#define ADIN1140_MAC_CONFIG2_STAT_CLR_RD	BIT(6)
+#define ADIN1140_MAC_CONFIG2_FWD_UNK2HOST	BIT(2)
+
+#define ADIN1140_MAC_P1_LOOP_ADDR_REG	0xC4
+
+#define ADIN1140_MAC_ADDR_FILT_UPR_REG		0x50
+#define ADIN1140_MAC_ADDR_FILT_APPLY2PORT1	BIT(30)
+#define ADIN1140_MAC_ADDR_FILT_TO_HOST		BIT(16)
+
+#define ADIN1140_MAC_ADDR_FILT_LWR_REG		0x51
+
+#define ADIN1140_MAC_ADDR_MASK_UPR_REG	0x70
+#define ADIN1140_MAC_ADDR_MASK_LWR_REG	0x71
+
+#define ADIN1140_MAC_FILT_MC_SLOT	0U
+#define ADIN1140_MAC_FILT_BC_SLOT	1U
+#define ADIN1140_MAC_FILT_UC_SLOT	2U
+#define ADIN1140_MAC_FILT_MAX_SLOT	16U
+#define ADIN1140_MAC_FILT_MASK_LIMIT	2U
+
+#define ADIN1140_MAC_RX_FRAME_CNT		0xA1
+#define ADIN1140_MAC_RX_BC_FRAME_CNT		0xA2
+#define ADIN1140_MAC_RX_MC_FRAME_CNT		0xA3
+#define ADIN1140_MAC_RX_CRC_ERR_CNT		0xA5
+#define ADIN1140_MAC_RX_ALIGN_ERR_CNT		0xA6
+#define ADIN1140_MAC_RX_PREAMBLE_ERR_CNT	0xA7
+#define ADIN1140_MAC_RX_SHORT_ERR_CNT		0xA8
+#define ADIN1140_MAC_RX_LONG_ERR_CNT		0xA9
+#define ADIN1140_MAC_RX_PHY_ERR_CNT		0xAA
+#define ADIN1140_MAC_RX_DRP_FULL_CNT		0xAB
+#define ADIN1140_MAC_RX_DRP_FILTER_CNT		0xAD
+#define ADIN1140_MAC_RX_IFG_ERR_CNT		0xAE
+#define ADIN1140_MAC_TX_FRAME_CNT		0xB1
+#define ADIN1140_MAC_TX_BC_FRAME_CNT		0xB2
+#define ADIN1140_MAC_TX_MC_FRAME_CNT		0xB3
+#define ADIN1140_MAC_TX_SINGLE_COL_CNT		0xB5
+#define ADIN1140_MAC_TX_MULTI_COL_CNT		0xB6
+#define ADIN1140_MAC_TX_DEFERRED_CNT		0xB7
+#define ADIN1140_MAC_TX_LATE_COL_CNT		0xB8
+#define ADIN1140_MAC_TX_EXCESS_COL_CNT		0xB9
+#define ADIN1140_MAC_TX_UNDERRUN_CNT		0xBA
+
+/* ADIN1140_MAC_FILT_MAX_SLOT - 3 (multicast, broadcast and unicast
+ * reserved slots)
+ */
+#define ADIN1140_MAC_FILT_AVAIL	13U
+
+#define ADIN1140_PHY_CTRL_DEFAULT	0x1000
+#define ADIN1140_PHY_STATUS_DEFAULT	0x082D
+#define ADIN1140_PHY_ID1		0x0283
+#define ADIN1140_PHY_ID2		0xBE00
+
+#define ADIN1140_STATS_CHECK_DELAY	(3 * HZ)
+
+enum adin1140_statistics_entry {
+	rx_frames,
+	rx_bc_frames,
+	rx_mc_frames,
+	rx_crc_errors,
+	rx_align_errors,
+	rx_preamble_errors,
+	rx_short_frame_errors,
+	rx_long_frame_errors,
+	rx_phy_errors,
+	rx_fifo_full_dropped,
+	rx_addr_filter_dropped,
+	rx_ifg_errors,
+	tx_frames,
+	tx_bc_frames,
+	tx_mc_frames,
+	tx_single_collision,
+	tx_multi_collision,
+	tx_deferred,
+	tx_late_collision,
+	tx_excess_collision,
+	tx_underrun,
+	ADIN1140_STATS_CNT,
+};
+
+struct adin1140_statistics_reg {
+	const char *name;
+	enum adin1140_statistics_entry idx;
+};
+
+struct adin1140_priv {
+	struct net_device *netdev;
+	struct oa_tc6 *tc6;
+	struct mii_bus *mdiobus;
+	struct phy_device *phydev;
+	struct delayed_work stats_work;
+
+	/* Protects stats[] from concurrent updates in adin1140_stats_work
+	 * and reads in the get_stats functions
+	 */
+	spinlock_t stat_lock;
+	u64 stats[ADIN1140_STATS_CNT];
+};
+
+static const u32 adin1140_stat_regs[] = {
+	[rx_frames] = ADIN1140_MAC_RX_FRAME_CNT,
+	[rx_bc_frames] = ADIN1140_MAC_RX_BC_FRAME_CNT,
+	[rx_mc_frames] = ADIN1140_MAC_RX_MC_FRAME_CNT,
+	[rx_crc_errors] = ADIN1140_MAC_RX_CRC_ERR_CNT,
+	[rx_align_errors] = ADIN1140_MAC_RX_ALIGN_ERR_CNT,
+	[rx_preamble_errors] = ADIN1140_MAC_RX_PREAMBLE_ERR_CNT,
+	[rx_short_frame_errors]	= ADIN1140_MAC_RX_SHORT_ERR_CNT,
+	[rx_long_frame_errors] = ADIN1140_MAC_RX_LONG_ERR_CNT,
+	[rx_phy_errors] = ADIN1140_MAC_RX_PHY_ERR_CNT,
+	[rx_fifo_full_dropped] = ADIN1140_MAC_RX_DRP_FULL_CNT,
+	[rx_addr_filter_dropped] = ADIN1140_MAC_RX_DRP_FILTER_CNT,
+	[rx_ifg_errors] = ADIN1140_MAC_RX_IFG_ERR_CNT,
+	[tx_frames] = ADIN1140_MAC_TX_FRAME_CNT,
+	[tx_bc_frames] = ADIN1140_MAC_TX_BC_FRAME_CNT,
+	[tx_mc_frames] = ADIN1140_MAC_TX_MC_FRAME_CNT,
+	[tx_single_collision] = ADIN1140_MAC_TX_SINGLE_COL_CNT,
+	[tx_multi_collision] = ADIN1140_MAC_TX_MULTI_COL_CNT,
+	[tx_deferred] = ADIN1140_MAC_TX_DEFERRED_CNT,
+	[tx_late_collision] = ADIN1140_MAC_TX_LATE_COL_CNT,
+	[tx_excess_collision] = ADIN1140_MAC_TX_EXCESS_COL_CNT,
+	[tx_underrun] = ADIN1140_MAC_TX_UNDERRUN_CNT,
+};
+
+static const struct adin1140_statistics_reg adin1140_stats[] = {
+	{.name = "rx_preamble_errors", .idx = rx_preamble_errors},
+	{.name = "rx_ifg_errors", .idx = rx_ifg_errors},
+};
+
+static int adin1140_mac_filter_set(struct adin1140_priv *priv,
+				   const u8 *addr, const u8 *mask,
+				   u8 slot)
+{
+	u32 reg_address;
+	u32 val;
+	int ret;
+
+	if (slot >= ADIN1140_MAC_FILT_MAX_SLOT)
+		return -ENOSPC;
+
+	reg_address = ADIN1140_MAC_ADDR_FILT_UPR_REG + 2 * slot;
+
+	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					reg_address,
+					get_unaligned_be16(&addr[0]) |
+					ADIN1140_MAC_ADDR_FILT_APPLY2PORT1 |
+					ADIN1140_MAC_ADDR_FILT_TO_HOST);
+	if (ret)
+		return ret;
+
+	reg_address = ADIN1140_MAC_ADDR_FILT_LWR_REG + 2 * slot;
+	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					reg_address,
+					get_unaligned_be32(&addr[2]));
+	if (ret)
+		return ret;
+
+	/* Only the first 2 destination MAC filter slots support masking.
+	 * For the other entries, the destination address in the received
+	 * frame must match exactly.
+	 */
+	if (slot >= ADIN1140_MAC_FILT_MASK_LIMIT)
+		return 0;
+
+	val = get_unaligned_be16(&mask[0]);
+	reg_address = ADIN1140_MAC_ADDR_MASK_UPR_REG + (2 * slot);
+
+	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					reg_address, val);
+	if (ret)
+		return ret;
+
+	val = get_unaligned_be32(&mask[2]);
+	reg_address = ADIN1140_MAC_ADDR_MASK_LWR_REG + (2 * slot);
+
+	return oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					 reg_address, val);
+}
+
+static int adin1140_mac_filter_clear(struct adin1140_priv *priv, u8 slot)
+{
+	u8 mask[ETH_ALEN];
+	u8 addr[ETH_ALEN];
+
+	memset(mask, 0xFF, ETH_ALEN);
+	memset(addr, 0x0, ETH_ALEN);
+
+	return adin1140_mac_filter_set(priv, addr, mask, slot);
+}
+
+static int adin1140_filter_unicast(struct adin1140_priv *priv)
+{
+	/* Only the first 2 filter slots support masking, so no unicast
+	 * address will ever need a mask. The first slots are used for the
+	 * all multicast and broadcast filter.
+	 */
+	return adin1140_mac_filter_set(priv, priv->netdev->dev_addr, NULL,
+				       ADIN1140_MAC_FILT_UC_SLOT);
+}
+
+static int adin1140_filter_all_multicast(struct adin1140_priv *priv, bool en)
+{
+	u8 multicast_addr[ETH_ALEN] = {1, 0, 0, 0, 0, 0};
+
+	if (en)
+		return adin1140_mac_filter_set(priv, multicast_addr,
+					       multicast_addr,
+					       ADIN1140_MAC_FILT_MC_SLOT);
+
+	return adin1140_mac_filter_clear(priv, ADIN1140_MAC_FILT_MC_SLOT);
+}
+
+static int adin1140_filter_broadcast(struct adin1140_priv *priv, bool enabled)
+{
+	u8 mask[ETH_ALEN];
+
+	if (enabled) {
+		memset(mask, 0xFF, ETH_ALEN);
+		return adin1140_mac_filter_set(priv, mask, mask,
+					       ADIN1140_MAC_FILT_BC_SLOT);
+	}
+
+	return adin1140_mac_filter_clear(priv, ADIN1140_MAC_FILT_BC_SLOT);
+}
+
+static int adin1140_default_filter_config(struct adin1140_priv *priv)
+{
+	int ret;
+
+	ret = adin1140_filter_broadcast(priv, true);
+	if (ret)
+		return ret;
+
+	return adin1140_filter_unicast(priv);
+}
+
+static int adin1140_promiscuous_mode(struct adin1140_priv *priv, bool enabled)
+{
+	int ret;
+	u32 val;
+
+	ret = oa_tc6_read_register(priv->tc6, OA_TC6_REG_CONFIG2, &val);
+	if (ret)
+		return ret;
+
+	if (enabled)
+		val |= ADIN1140_MAC_CONFIG2_FWD_UNK2HOST;
+	else
+		val &= ~ADIN1140_MAC_CONFIG2_FWD_UNK2HOST;
+
+	return oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG2, val);
+}
+
+static int adin1140_rx_mode(struct net_device *dev,
+			    struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
+{
+	struct adin1140_priv *priv = netdev_priv(dev);
+	struct netdev_hw_addr *ha;
+	bool all_multi, promisc;
+	u32 mac_addrs;
+	u8 slot, i;
+	int ret;
+
+	/* The ADIN1140 has 16 dest MAC address filter slots:
+	 * 0 - reserved for all multicast filter.
+	 * 1 - reserved for broadcast filter.
+	 * 2 - reserved for the device's own unicast MAC.
+	 * 3 -> 15 - available for other unicast/multicast filters.
+	 */
+
+	mac_addrs = netdev_hw_addr_list_count(uc);
+	all_multi = false;
+	promisc = false;
+
+	if (priv->netdev->flags & IFF_PROMISC)
+		promisc = true;
+	else if (priv->netdev->flags & IFF_ALLMULTI)
+		all_multi = true;
+	else
+		mac_addrs += netdev_hw_addr_list_count(mc);
+
+	if (mac_addrs > ADIN1140_MAC_FILT_AVAIL) {
+		/* The filter table is full. Enable promisc mode. */
+		promisc = true;
+	}
+
+	ret = adin1140_promiscuous_mode(priv, promisc);
+	if (ret)
+		return ret;
+
+	ret = adin1140_filter_all_multicast(priv, all_multi);
+	if (ret)
+		return ret;
+
+	slot = ADIN1140_MAC_FILT_UC_SLOT + 1;
+	if (!promisc) {
+		netdev_hw_addr_list_for_each(ha, uc) {
+			ret = adin1140_mac_filter_set(priv, ha->addr, NULL,
+						      slot);
+			if (ret)
+				return ret;
+
+			slot++;
+		}
+
+		if (!all_multi) {
+			netdev_hw_addr_list_for_each(ha, mc) {
+				ret = adin1140_mac_filter_set(priv, ha->addr,
+							      NULL, slot);
+				if (ret)
+					return ret;
+
+				slot++;
+			}
+		}
+	}
+
+	for (i = slot; i < ADIN1140_MAC_FILT_MAX_SLOT; i++) {
+		ret = adin1140_mac_filter_clear(priv, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void adin1140_stats_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct adin1140_priv *priv;
+	u32 reg_val;
+	int ret;
+	u32 i;
+
+	priv = container_of(dwork, struct adin1140_priv, stats_work);
+
+	for (i = 0; i < ARRAY_SIZE(adin1140_stat_regs); i++) {
+		ret = oa_tc6_read_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					       adin1140_stat_regs[i],
+					       &reg_val);
+		if (ret)
+			goto out;
+
+		scoped_guard(spinlock, &priv->stat_lock)
+			priv->stats[i] += reg_val;
+	}
+
+out:
+	schedule_delayed_work(dwork, ADIN1140_STATS_CHECK_DELAY);
+}
+
+static int adin1140_configure(struct adin1140_priv *priv)
+{
+	u32 reg_val;
+	int ret;
+
+	ret = oa_tc6_zero_align_receive_frame_enable(priv->tc6);
+	if (ret)
+		return ret;
+
+	/* Disable MAC loopback */
+	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_MAC_MMS1,
+					ADIN1140_MAC_P1_LOOP_ADDR_REG, 0x0);
+	if (ret)
+		return ret;
+
+	ret = oa_tc6_read_register(priv->tc6, OA_TC6_REG_CONFIG2, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val |= ADIN1140_MAC_CONFIG2_STAT_CLR_RD;
+
+	ret = oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG2, reg_val);
+	if (ret)
+		return ret;
+
+	return adin1140_default_filter_config(priv);
+}
+
+static int adin1140_open(struct net_device *netdev)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+
+	schedule_delayed_work(&priv->stats_work, ADIN1140_STATS_CHECK_DELAY);
+
+	phy_start(netdev->phydev);
+	netif_start_queue(netdev);
+
+	return 0;
+}
+
+static int adin1140_close(struct net_device *netdev)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+
+	cancel_delayed_work_sync(&priv->stats_work);
+
+	netif_stop_queue(netdev);
+	phy_stop(netdev->phydev);
+
+	return 0;
+}
+
+static netdev_tx_t adin1140_start_xmit(struct sk_buff *skb,
+				       struct net_device *netdev)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+
+	/* The MAC doesn't automatically pad the frame to a 60 byte minimum
+	 * size in case the host sends a shorter skb, so we have to do it in
+	 * the driver. The FCS will be added by the MAC.
+	 */
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+
+	return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static int adin1140_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+	struct sockaddr *address = addr;
+	u8 mask[ETH_ALEN];
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(netdev, addr);
+	if (ret < 0)
+		return ret;
+
+	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
+		return 0;
+
+	memset(mask, 0xFF, ETH_ALEN);
+	ret = adin1140_mac_filter_set(priv, address->sa_data, mask,
+				      ADIN1140_MAC_FILT_UC_SLOT);
+	if (ret)
+		return ret;
+
+	eth_commit_mac_addr_change(netdev, addr);
+
+	return 0;
+}
+
+static void __adin1140_ndo_get_stats64(struct adin1140_priv *priv,
+				       struct rtnl_link_stats64 *storage)
+{
+	storage->rx_errors = priv->stats[rx_crc_errors] +
+			     priv->stats[rx_align_errors] +
+			     priv->stats[rx_preamble_errors] +
+			     priv->stats[rx_short_frame_errors] +
+			     priv->stats[rx_long_frame_errors] +
+			     priv->stats[rx_phy_errors] +
+			     priv->stats[rx_ifg_errors];
+
+	storage->tx_errors = priv->stats[tx_excess_collision] +
+			     priv->stats[tx_underrun];
+
+	storage->rx_dropped = priv->stats[rx_fifo_full_dropped] +
+			      priv->stats[rx_addr_filter_dropped];
+
+	storage->multicast = priv->stats[rx_mc_frames];
+
+	storage->collisions = priv->stats[tx_single_collision] +
+			      priv->stats[tx_multi_collision];
+
+	storage->rx_length_errors = priv->stats[rx_short_frame_errors] +
+				    priv->stats[rx_long_frame_errors];
+	storage->rx_over_errors = priv->stats[rx_fifo_full_dropped];
+	storage->rx_crc_errors = priv->stats[rx_crc_errors];
+	storage->rx_frame_errors = priv->stats[rx_align_errors];
+	storage->rx_missed_errors = priv->stats[rx_fifo_full_dropped];
+
+	storage->tx_aborted_errors = priv->stats[tx_excess_collision];
+	storage->tx_fifo_errors = priv->stats[tx_underrun];
+	storage->tx_window_errors = priv->stats[tx_late_collision];
+}
+
+static void adin1140_ndo_get_stats64(struct net_device *dev,
+				     struct rtnl_link_stats64 *storage)
+{
+	struct adin1140_priv *priv = netdev_priv(dev);
+
+	storage->rx_packets = priv->netdev->stats.rx_packets;
+	storage->tx_packets = priv->netdev->stats.tx_packets;
+
+	storage->rx_bytes = priv->netdev->stats.rx_bytes;
+	storage->tx_bytes = priv->netdev->stats.tx_bytes;
+
+	scoped_guard(spinlock, &priv->stat_lock)
+		__adin1140_ndo_get_stats64(priv, storage);
+}
+
+static void adin1140_get_drvinfo(struct net_device *netdev,
+				 struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ADIN1140", sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(netdev->dev.parent),
+		sizeof(info->bus_info));
+}
+
+static void adin1140_get_ethtool_stats(struct net_device *netdev,
+				       struct ethtool_stats *stats, u64 *data)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+	u32 i;
+
+	scoped_guard(spinlock, &priv->stat_lock) {
+		for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
+			data[i] = priv->stats[adin1140_stats[i].idx];
+	}
+}
+
+static void adin1140_get_ethtool_strings(struct net_device *netdev, u32 sset,
+					 u8 *p)
+{
+	u32 i;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(adin1140_stats); i++)
+			ethtool_puts(&p, adin1140_stats[i].name);
+
+		break;
+	}
+}
+
+static int adin1140_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(adin1140_stats);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void __adin1140_eth_mac_stats(struct adin1140_priv *priv,
+				     struct ethtool_eth_mac_stats *mac_stats)
+{
+	mac_stats->FramesReceivedOK = priv->stats[rx_frames];
+	mac_stats->BroadcastFramesReceivedOK = priv->stats[rx_bc_frames];
+	mac_stats->MulticastFramesReceivedOK = priv->stats[rx_mc_frames];
+	mac_stats->FrameCheckSequenceErrors = priv->stats[rx_crc_errors];
+	mac_stats->AlignmentErrors = priv->stats[rx_align_errors];
+	mac_stats->FrameTooLongErrors = priv->stats[rx_long_frame_errors];
+	mac_stats->FramesLostDueToIntMACRcvError =
+					priv->stats[rx_fifo_full_dropped];
+	mac_stats->FramesTransmittedOK = priv->stats[tx_frames];
+	mac_stats->BroadcastFramesXmittedOK = priv->stats[tx_bc_frames];
+	mac_stats->MulticastFramesXmittedOK = priv->stats[tx_mc_frames];
+	mac_stats->SingleCollisionFrames = priv->stats[tx_single_collision];
+	mac_stats->MultipleCollisionFrames = priv->stats[tx_multi_collision];
+	mac_stats->FramesWithDeferredXmissions = priv->stats[tx_deferred];
+	mac_stats->LateCollisions = priv->stats[tx_late_collision];
+	mac_stats->FramesAbortedDueToXSColls =
+					priv->stats[tx_excess_collision];
+	mac_stats->FramesLostDueToIntMACXmitError = priv->stats[tx_underrun];
+}
+
+static void adin1140_get_eth_mac_stats(struct net_device *netdev,
+				       struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct adin1140_priv *priv = netdev_priv(netdev);
+
+	scoped_guard(spinlock, &priv->stat_lock)
+		__adin1140_eth_mac_stats(priv, mac_stats);
+}
+
+static int adin1140_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
+{
+	/* The ADIN1140's standard PHY C22 register map (OA TC6 0xFF00 -
+	 * 0xFF1F), of which only 0xFF00 - 0xFF03 are implemented) cannot be
+	 * accessed while frames are being received by the PHY. In case this
+	 * happens the CONFIG0 and CONFIG2 register values will get corrupted,
+	 * getting a random value. Both reads and writes cause the same
+	 * behavior. This is a workaround that avoids MDIO accesses all
+	 * together. Since this is a 10BASE-T1S PHY, only the loopback and
+	 * reset (AN) bits in the control register (0x0) can be written.
+	 * These functionalities have custom implementations in the PHY
+	 * driver. C45 accesses do not cause this issue.
+	 */
+
+	switch (regnum) {
+	case MII_BMCR:
+		return ADIN1140_PHY_CTRL_DEFAULT;
+	case MII_BMSR:
+		return ADIN1140_PHY_STATUS_DEFAULT;
+	case MII_PHYSID1:
+		return ADIN1140_PHY_ID1;
+	case MII_PHYSID2:
+		return ADIN1140_PHY_ID2;
+	default:
+		return 0xFFFF;
+	}
+}
+
+static int adin1140_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
+				  u16 val)
+{
+	return -EIO;
+}
+
+static int adin1140_mdio_register(struct adin1140_priv *priv,
+				  struct spi_device *spidev)
+{
+	priv->mdiobus = devm_mdiobus_alloc(&spidev->dev);
+	if (!priv->mdiobus)
+		return dev_err_probe(&spidev->dev, -ENOMEM,
+				     "MDIO bus alloc failed\n");
+
+	priv->mdiobus->name = "adin1140-mdiobus";
+	priv->mdiobus->priv = priv->tc6;
+	priv->mdiobus->parent = &spidev->dev;
+	priv->mdiobus->phy_mask = GENMASK(31, 1);
+	priv->mdiobus->read = adin1140_mdiobus_read;
+	priv->mdiobus->write = adin1140_mdiobus_write;
+	priv->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
+	priv->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
+
+	snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "adin1140-%s.%u",
+		 dev_name(&spidev->dev), spi_get_chipselect(spidev, 0));
+
+	return devm_mdiobus_register(&spidev->dev, priv->mdiobus);
+}
+
+static void adin1140_handle_link_change(struct net_device *netdev)
+{
+	phy_print_status(netdev->phydev);
+}
+
+static void adin1140_phy_remove(void *data)
+{
+	phy_disconnect(data);
+}
+
+static int adin1140_phy_init(struct adin1140_priv *priv,
+			     struct spi_device *spidev)
+{
+	int ret;
+
+	ret = adin1140_mdio_register(priv, spidev);
+	if (ret)
+		return ret;
+
+	priv->phydev = phy_find_first(priv->mdiobus);
+	if (!priv->phydev)
+		return dev_err_probe(&spidev->dev, -ENODEV, "No PHY found\n");
+
+	priv->phydev->is_internal = true;
+	ret = phy_connect_direct(priv->netdev, priv->phydev,
+				 &adin1140_handle_link_change,
+				 PHY_INTERFACE_MODE_INTERNAL);
+	if (ret)
+		return dev_err_probe(&spidev->dev, ret,
+				     "Can't attach PHY to %s\n",
+				     priv->mdiobus->id);
+
+	ret = devm_add_action_or_reset(&spidev->dev, adin1140_phy_remove,
+				       priv->phydev);
+	if (ret)
+		return ret;
+
+	phy_attached_info(priv->phydev);
+
+	return 0;
+}
+
+static const struct ethtool_ops adin1140_ethtool_ops = {
+	.get_drvinfo = adin1140_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_ethtool_stats = adin1140_get_ethtool_stats,
+	.get_sset_count = adin1140_get_sset_count,
+	.get_strings = adin1140_get_ethtool_strings,
+	.get_link_ksettings = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.get_eth_mac_stats = adin1140_get_eth_mac_stats,
+};
+
+static const struct net_device_ops adin1140_netdev_ops = {
+	.ndo_open = adin1140_open,
+	.ndo_stop = adin1140_close,
+	.ndo_start_xmit	= adin1140_start_xmit,
+	.ndo_set_mac_address = adin1140_set_mac_address,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_set_rx_mode_async = adin1140_rx_mode,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
+	.ndo_get_stats64 = adin1140_ndo_get_stats64,
+};
+
+static void adin1140_oa_tc6_remove(void *data)
+{
+	oa_tc6_exit(data);
+}
+
+static int adin1140_probe(struct spi_device *spi)
+{
+	struct oa_tc6_quirks tc6_quirks = {};
+	struct net_device *netdev;
+	struct adin1140_priv *priv;
+	int ret;
+
+	netdev = devm_alloc_etherdev(&spi->dev, sizeof(struct adin1140_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	spi_set_drvdata(spi, priv);
+	spin_lock_init(&priv->stat_lock);
+
+	tc6_quirks.quirk_flags = OA_TC6_BROKEN_PHY;
+
+	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);
+	if (!priv->tc6)
+		return -ENODEV;
+
+	ret = devm_add_action_or_reset(&spi->dev, adin1140_oa_tc6_remove,
+				       priv->tc6);
+	if (ret)
+		return ret;
+
+	ret = adin1140_phy_init(priv, spi);
+	if (ret)
+		return ret;
+
+	if (device_get_ethdev_address(&spi->dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	ret = adin1140_configure(priv);
+	if (ret)
+		return ret;
+
+	INIT_DELAYED_WORK(&priv->stats_work, adin1140_stats_work);
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->irq = spi->irq;
+	netdev->netdev_ops = &adin1140_netdev_ops;
+	netdev->ethtool_ops = &adin1140_ethtool_ops;
+	netdev->netns_immutable = true;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
+			      IFF_UNICAST_FLT;
+
+	ret = devm_register_netdev(&spi->dev, netdev);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to register netdev");
+
+	return 0;
+}
+
+static const struct spi_device_id adin1140_spi_id[] = {
+	{ .name = "ad3306" },
+	{ .name = "adin1140" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, adin1140_spi_id);
+
+static const struct of_device_id adin1140_match_table[] = {
+	{ .compatible = "adi,ad3306" },
+	{ .compatible = "adi,adin1140" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adin1140_match_table);
+
+static struct spi_driver adin1140_driver = {
+	.driver = {
+		.name = "adin1140",
+		.of_match_table = adin1140_match_table,
+	 },
+	.probe = adin1140_probe,
+	.id_table = adin1140_spi_id,
+};
+module_spi_driver(adin1140_driver);
+
+MODULE_DESCRIPTION("Analog Devices, Inc. ADIN1140 10BASE-T1S MAC-PHY");
+MODULE_AUTHOR("Ciprian Regus <ciprian.regus@analog.com>");
+MODULE_LICENSE("GPL");

-- 
2.43.0



