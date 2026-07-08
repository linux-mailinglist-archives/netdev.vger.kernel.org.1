Return-Path: <netdev+bounces-305958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjZaD0yaTmqkQQIAu9opvQ
	(envelope-from <netdev+bounces-305958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D90729A54
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:43:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=RvqM806E;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=WkNnnL5l;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305958-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BFB230519AF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751743800D;
	Wed,  8 Jul 2026 18:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C54CA294;
	Wed,  8 Jul 2026 18:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536019; cv=none; b=MWB9jEYZAUTlsQ1rKdL8nlEvLlfIefx3bm0RNsbpE9fKXnwhTxABsv5iwOVjIJTKVsMCC+4eMPxjk3NRFjVxTDXGQsELDxjulQH/cr6S6YKqzBFgomKAQhDcNxc5THxXo6slTcJ1gSL0uU+qdq+KmPo/g3TniDUVgpS+f7bpOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536019; c=relaxed/simple;
	bh=n/XYjSpq2Xw/o5bOd7bCs6EoprtBqx9tYI/FPnX9tD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHDXQZqXPxlJ6EUKqRDTvnIfFh4zBp1q7eR3Hbh+Z36bl7XYVibt8f6Ecvxe736OEcA9/kmXWdnSDjYpMrax7jKe4S5Hm2/5eCT1Uq1sq1Q+y5R1BQL4xwnz3hjQqWBbGIYZMdNIl+SR0f8EqDKhTfvtmoYGz6g9iAfGq4HES44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RvqM806E; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WkNnnL5l; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536010;
	bh=n/XYjSpq2Xw/o5bOd7bCs6EoprtBqx9tYI/FPnX9tD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RvqM806EMc3GUzvt6rvZdTAz123QtRXQxGe/fSPC1NjTk1K9rv7RzW5YxszhZ3IUv
	 xA5XxTE0slQb4FoAyNyg/apgoaI107cChh3u+3ijVhp5M0de1aYGWk/8BFBMwkrSkr
	 c3NHxsxBoI/8Z0IITTzQjZD8xoCr12W+AUuRlKlKdjoYvQzES082X7VLEDskcjuY1+
	 hkhPPCWIQBI/OkRkUarn3H8TSsk+aHT8OlfXOlmF51Tttb+SVVepgW5VvNfbalQfXM
	 I7w5Yv9FVmXCRjth9iws12UPskWjHCPfTy6c7RMfbXRNQAHsbd/CN9XzgfWG/tcHk/
	 XbEzYSbJqdOxQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3EC904943A; Wed,  8 Jul 2026 18:40:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536005;
	bh=n/XYjSpq2Xw/o5bOd7bCs6EoprtBqx9tYI/FPnX9tD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WkNnnL5lE3EO9n23gAHcH5GfsWaZzNWdXytnLjxcr4j7iSyTrjcO++QSiXSg6mm6T
	 g8MTlvnt+vPwPT0FVgolWs3HDBU7AqfJMQVOlaHXS1NLSlKiPTKgkbijEFAT+DeNNP
	 WvQZWr6V+6VRsLWUIiOLrBe+TOHxRe/BHYTG3jcHQKCP7dC8SLgiHuMk1ZfZFWJEXC
	 w/GyzI7/7Ms1bVijfdMLDd7HfO2z9jMCPdE2b9fg20YtXGYZhu2s58SCQUVLviZ0Do
	 T55Pd37SjBUIDJonARfHcGgI9IYddv9v1gaaNWrQe+RdwnYK/onhqhbRTTJPl8ZsUD
	 ke1TdrXHnUIqA==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 10D2C493EA;
	Wed,  8 Jul 2026 18:40:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:08 +0200
Subject: [PATCH net-next v2 02/12] ax88179_178a: Add HW support for
 AX179A-based chips
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81D90729A54

This adds bindings and HW support for AX179A-based USB-Ethernet
controllers. The AX179A-family of chips consists of the
AX88279 (2.5GBit PHY)
AX88179A/B (1GBit PHY, B variant has wider temperature range)
AX772D/E (100Mbit PHY)

The controllers all have the same vendor and device ID
(0x0b95, 0x1790) and are distinguished by their BCD device versions,
which are
2.00 AX88179A/B
3.00 AX88772D/E
4.00 AX88279

For all chips, the driver calls the same ax88179a_bind() function
and the chips are then distinguished by the chip version and
BCD device ID. The AX179A-based chips all provide both a CDC-NCM
compatible USB interface, and a proprietary vendor interface. By default,
the proprietary vendor interface is not active and Linux will load the
CDC-NCM driver to support the devices. If the ax88179_178a module is
configured by the OS to have precedence over CDC-NCM, then this driver
will switch the device to use the vendor interface, and the device will
be controlled by the ax88179_178a driver when the device is probed again
after an automatic reset by the device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 961 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 926 insertions(+), 35 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 945c071dfd1d2f0816c779e1a401ac158adc8d99..3aad69b5d4f8ad43527fa7cf51304af9a926ea78 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -13,6 +13,7 @@
 #include <linux/usb/usbnet.h>
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
+#include <linux/if_vlan.h>
 
 #define AX88179_PHY_ID				0x03
 #define AX_EEPROM_LEN				0x100
@@ -32,17 +33,28 @@
 #define AX_ACCESS_EEPROM			0x04
 #define AX_ACCESS_EFUS				0x05
 #define AX_RELOAD_EEPROM_EFUSE			0x06
+#define AX88179A_WAKEUP_SETTING			0x07
+#define AX_FW_MODE				0x08
+#define AX88179A_FLASH_READ			0x21
+#define AX88179A_FLASH_WRITE			0x24
+#define AX88179A_ACCESS_BL			0x2A
+#define AX88179A_PHY_POWER			0x31
+#define AX88179A_AUTODETACH			0xC0
 #define AX_PAUSE_WATERLVL_LOW			0x54
 #define AX_PAUSE_WATERLVL_HIGH			0x55
 
+#define AX_FW_MODE_179A				0x01
 #define PHYSICAL_LINK_STATUS			0x02
 	#define	AX_USB_SS		0x04
 	#define	AX_USB_HS		0x02
+	#define AX_USB_FS		0x01
 
 #define GENERAL_STATUS				0x03
 /* Check AX88179 version. UA1:Bit2 = 0,  UA2:Bit2 = 1 */
 	#define	AX_SECLD		0x04
 
+#define AX_CHIP_STATUS				0x05
+
 #define AX_SROM_ADDR				0x07
 #define AX_SROM_CMD				0x0a
 	#define EEP_RD			0x04
@@ -62,6 +74,15 @@
 	#define AX_RX_CTL_PRO		0x0001
 	#define AX_RX_CTL_STOP		0x0000
 
+#define AX88179A_ETH_TX_GAP			0x0D
+
+#define AX88179A_BFM_DATA			0x0E
+	#define AX_TX_QUEUE_CFG		0x02
+	#define AX_TX_QUEUE_SET		0x08
+	#define AX_TX_Q1_AHB_FC_EN	0x10
+	#define AX_TX_Q2_AHB_FC_EN	0x20
+	#define AX_XGMII_EN		0x80
+
 #define AX_NODE_ID				0x10
 #define AX_MULFLTARY				0x16
 
@@ -91,6 +112,17 @@
 	#define AX_PHYPWR_RSTCTL_IPRL	0x0020
 	#define AX_PHYPWR_RSTCTL_AT	0x1000
 
+#define AX88179A_VLAN_ID_ADDRESS		0x2A
+
+#define AX88179A_VLAN_ID_CONTROL		0x2B
+	#define AX_VLAN_CONTROL_WE	0x0001
+	#define AX_VLAN_CONTROL_RD	0x0002
+	#define AX_VLAN_CONTROL_VSO	0x0010
+	#define AX_VLAN_CONTROL_VFE	0x0020
+
+#define AX88179A_VLAN_ID_DATA0			0x2C
+#define AX88179A_VLAN_ID_DATA1			0x2D
+
 #define AX_RX_BULKIN_QCTRL			0x2e
 #define AX_CLK_SELECT				0x33
 	#define AX_CLK_SELECT_BCS	0x01
@@ -111,7 +143,51 @@
 	#define AX_TXCOE_TCPV6		0x20
 	#define AX_TXCOE_UDPV6		0x40
 
+#define AX88179A_MAC_BM_INT_MASK		0x41
+#define AX88179A_MAC_BM_RX_DMA_CTL		0x43
+#define AX88179A_MAC_BM_TX_DMA_CTL		0x46
+
+#define AX88179A_MAC_RX_STATUS_CDC		0x6D
+	#define AX_LSOFC_WCNT_7_ACCESS	0x03
+	#define AX_GMII_CRC_APPEND	0x10
+
 #define AX_LEDCTRL				0x73
+#define AX88179A_MAC_ARC_CTRL			0x9E
+#define AX88179A_MAC_SWP_CTRL			0xB1
+
+#define AX88179A_MAC_TX_PAUSE			0xB2
+
+#define AX88179A_MAC_CDC_DELAY_TX		0xB5
+
+#define AX88179A_MAC_PATH			0xB7
+	#define AX_MAC_RX_PATH_READY	0x01
+	#define AX_MAC_TX_PATH_READY	0x02
+
+#define AX88179A_NEW_PAUSE_CTRL			0xB8
+	#define AX_NEW_PAUSE_EN		0x01
+
+#define AX88179A_MAC_BULK_OUT_CTRL		0xB9
+	#define AX_MAC_EFF_EN		0x02
+
+#define AX88179A_MAC_RX_DATA_CDC_CNT		0xC0
+	#define AX_MAC_LSO_ERR_EN	0x04
+	#define AX_MAC_MIQFFCTRL_FORMAT	0x10
+	#define AX_MAC_MIQFFCTRL_DROP_CRC 0x20
+
+#define AX88179A_AUTODETACH_DELAY	(5UL << 8)
+#define AX88179A_AUTODETACH_EN		1
+
+#define AX88179A_MAC_LSO_ENHANCE_CTRL		0xC3
+	#define AX_LSO_ENHANCE_EN	0x01
+
+#define AX88179A_MAC_TX_HDR_CKSUM		0xCC
+#define AX88179A_EP5_EHR			0xF9
+
+#define AX_PHY_POWER				0x02
+
+#define EPHY_LOW_POWER_EN			0x01
+#define S5_WOL_EN				0x04
+#define S5_WOL_LOW_POWER			0x20
 
 #define GMII_PHY_PHYSR				0x11
 	#define GMII_PHY_PHYSR_SMASK	0xc000
@@ -164,8 +240,58 @@
 	#define GMII_PHY_PGSEL_PAGE3	0x0003
 	#define GMII_PHY_PGSEL_PAGE5	0x0005
 
+/* TX Descriptor */
+#define AX179A_TX_DESC_LEN_MASK		0x1FFFFF
+#define AX179A_TX_DESC_DROP_PADD	BIT(28)
+#define AX179A_TX_DESC_VLAN		BIT(29)
+#define AX179A_TX_DESC_MSS_MASK		0x7FFF
+#define AX179A_TX_DESC_MSS_SHIFT	0x20
+#define AX179A_TX_DESC_VLAN_MASK	0xFFFF
+#define AX179A_TX_DESC_VLAN_SHIFT	0x30
+
+/* RX Packet Descriptor */
+#define AX179A_RX_PD_L4_ERR		BIT(0)
+#define AX179A_RX_PD_L3_ERR		BIT(1)
+#define AX179A_RX_PD_L4_TYPE_MASK	0x1C
+#define AX179A_RX_PD_L4_UDP		0x04
+#define AX179A_RX_PD_L4_TCP		0x10
+#define AX179A_RX_PD_L3_TYPE_MASK	0x60
+#define AX179A_RX_PD_L3_IP		0x20
+#define AX179A_RX_PD_L3_IP6		0x40
+
+#define AX179A_RX_PD_VLAN		BIT(10)
+#define AX179A_RX_PD_RX_OK		BIT(11)
+#define AX179A_RX_PD_DROP		BIT(31)
+#define AX179A_RX_PD_LEN_MASK	0x7FFF0000
+#define AX179A_RX_PD_LEN_SHIFT	0x10
+#define AX179A_RX_PD_VLAN_SHIFT	0x20
+
+/* RX Descriptor header */
+#define AX179A_RX_DH_PKT_CNT_MASK		0x1FFF
+#define AX179A_RX_DH_DESC_OFFSET_MASK	0xFFFFE000
+#define AX179A_RX_DH_DESC_OFFSET_SHIFT	0x0D
+
+#define AX179A_RX_HW_PAD			0x02
+
+#define AX_ADVERTISE_2500		0x1000
+
 static int ax88179_reset(struct usbnet *dev);
 
+enum ax_ether_link_speed {
+	ETHER_LINK_NONE = 0,
+	ETHER_LINK_10   = 1,
+	ETHER_LINK_100  = 2,
+	ETHER_LINK_1000 = 3,
+	ETHER_LINK_2500 = 4,
+};
+
+enum ax_chip_version {
+	AX_VERSION_INVALID		= 0x0,
+	AX_VERSION_AX88179		= 0x4,
+	AX_VERSION_AX88179A		= 0x6,	/* Also AX88772D */
+	AX_VERSION_AX88279		= 0x7,
+};
+
 struct ax88179_data {
 	u8  eee_enabled;
 	u8  eee_active;
@@ -174,6 +300,19 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 chip_version;
+	u8 fw_version[4];
+	u8 is_ax88772d;
+	u8 ip_align;
+	u8 link;
+	u8 speed;
+	u8 full_duplex;
+	bool pause_autoneg;
+	bool pause_tx;
+	bool pause_rx;
+	u8 rx_checksum;
+	u8 eeprom_read_cmd;
+	u16 eeprom_block;
 };
 
 struct ax88179_int_data {
@@ -181,15 +320,48 @@ struct ax88179_int_data {
 	__le32 intdata2;
 };
 
-static const struct {
+struct ax_bulkin_settings {
 	unsigned char ctrl, timer_l, timer_h, size, ifg;
-} AX88179_BULKIN_SIZE[] =	{
+};
+
+static const struct ax_bulkin_settings AX88179_BULKIN_SIZE[] =	{
 	{7, 0x4f, 0,	0x12, 0xff},
 	{7, 0x20, 3,	0x16, 0xff},
 	{7, 0xae, 7,	0x18, 0xff},
 	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
+static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
+	{5, 0x7B, 0x00,	0x17, 0x0F},	/* 1G, SS */
+	{5, 0xC0, 0x02,	0x06, 0x0F},	/* 1G, HS */
+	{7, 0xF0, 0x00,	0x0C, 0x0F},	/* 100M, Full, SS */
+	{6, 0x00, 0x00,	0x06, 0x0F},	/* 100M, Half, SS */
+	{5, 0xC0, 0x04,	0x06, 0x0F},	/* 100M, Full, HS */
+	{7, 0xC0, 0x04,	0x06, 0x0F},	/* 100M, Half, HS */
+	{7, 0x00, 0x00,	0x03, 0x3F},	/* FS */
+};
+
+static const struct ax_bulkin_settings AX88772D_BULKIN_SIZE[] = {
+	{0, 0x00, 0x00,	0x00, 0x00},	/* 1G, SS (unused) */
+	{0, 0x00, 0x00,	0x00, 0x00},	/* 1G, HS (unused) */
+	{0, 0x00, 0x00,	0x00, 0x00},	/* 100M, Full, SS (unused) */
+	{0, 0x00, 0x00,	0x00, 0x00},	/* 100M, Half, SS (unused) */
+	{5, 0xC0, 0x04,	0x06, 0x0F},	/* 100M, Full, HS */
+	{7, 0xC0, 0x04,	0x06, 0x0F},	/* 100M, Half, HS */
+	{7, 0x00, 0x00,	0x03, 0x3F},	/* FS */
+};
+
+static const struct ax_bulkin_settings AX88279_BULKIN_SIZE[] = {
+	{5, 0x10, 0x01,	0x11, 0x0F},	/* 2.5G */
+	{7, 0xB3, 0x01,	0x11, 0x0F},	/* 1G, SS */
+	{7, 0xC0, 0x02,	0x06, 0x0F},	/* 1G, HS */
+	{7, 0x80, 0x01,	0x03, 0x0F},	/* 100M, Full, SS */
+	{7, 0x80, 0x01,	0x03, 0x0F},	/* 100M, Half, SS */
+	{7, 0x80, 0x01,	0x03, 0x0F},	/* 100M, Full, HS */
+	{7, 0x80, 0x01,	0x03, 0x0F},	/* 100M, Half, HS */
+	{7, 0x00, 0x00,	0x03, 0x3F},	/* FS */
+};
+
 static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -425,6 +597,26 @@ static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 
 		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
 				  1, 1, &tmp8);
+
+		if (priv->chip_version >= AX_VERSION_AX88179A) {
+			ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
+			tmp16 |= AX_MEDIUM_RECEIVE_EN;
+			ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
+		}
+
+		if (priv->chip_version == AX_VERSION_AX88279)
+			ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8,
+					  EPHY_LOW_POWER_EN | S5_WOL_EN
+					  | S5_WOL_LOW_POWER | 0x8000, 0, NULL);
+
+	} else if (priv->chip_version == AX_VERSION_AX88279) {
+		ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8, 0x8000, 0, NULL);
+	}
+
+	if (priv->chip_version >= AX_VERSION_AX88179A) {
+		ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 0, EPHY_LOW_POWER_EN, 0, NULL);
+		ax88179_set_pm_mode(dev, false);
+		return 0;
 	}
 
 	/* Disable RX path */
@@ -456,12 +648,19 @@ static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 }
 
 /* This function is used to enable the autodetach function. */
-/* This function is determined by offset 0x43 of EEPROM */
+/* This function is determined by offset 0x43 of EEPROM for the AX88179 */
 static int ax88179_auto_detach(struct usbnet *dev)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	u16 tmp16;
 	u8 tmp8;
 
+	if (priv->chip_version >= AX_VERSION_AX88179A) {
+		tmp16 = AX88179A_AUTODETACH_DELAY;
+		ax88179_write_cmd(dev, AX88179A_AUTODETACH, tmp16, 0, 0, NULL);
+		return 0;
+	}
+
 	if (ax88179_read_cmd(dev, AX_ACCESS_EEPROM, 0x43, 1, 2, &tmp16) < 0)
 		return 0;
 
@@ -484,11 +683,31 @@ static int ax88179_auto_detach(struct usbnet *dev)
 static int ax88179_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+	u8 reg8;
 
+	ax179_data = dev->driver_priv;
 	ax88179_set_pm_mode(dev, true);
 
 	usbnet_link_change(dev, 0, 0);
 
+	if (ax179_data->chip_version >= AX_VERSION_AX88179A) {
+		ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+		if (!(reg8 & AX_PHY_POWER)) {
+			reg8 = AX_PHY_POWER;
+			ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+			msleep(250);
+		}
+		ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
+
+		/* Now, that AX_FW_MODE_179A is enabled, the PHY needs a power-cycle.
+		 * PHY-power is re-enabled in ax88179_reset()
+		 */
+		reg8 = 0;
+		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+		msleep(250);
+	}
+
 	ax88179_reset(dev);
 
 	ax88179_set_pm_mode(dev, false);
@@ -1293,6 +1512,17 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = ax179_data;
 
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	ax179_data->ip_align = 1;
+	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
+	ax179_data->eeprom_block = 2;
+
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -1317,6 +1547,124 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	ax88179_reset(dev);
 
 	return 0;
+
+err_nodev:
+	kfree(ax179_data);
+	ax179_data = NULL;
+
+	return ret;
+}
+
+static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct ax88179_data *ax179_data;
+	int ret;
+
+	/* Check if vendor configuration */
+	if (udev->actconfig->desc.bConfigurationValue != 1) {
+		netdev_info(dev->net, "Switching to vendor mode\n");
+		usb_driver_set_configuration(udev, 1);
+		return -ENODEV;
+	}
+
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret < 0)
+		return ret;
+
+	ax179_data = kzalloc_obj(*ax179_data);
+	if (!ax179_data)
+		return -ENOMEM;
+
+	dev->driver_priv = ax179_data;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	if (ax179_data->chip_version == AX_VERSION_AX88179A) {
+		if (udev->descriptor.bcdDevice == 0x300)
+			ax179_data->is_ax88772d = 1;
+	}
+
+	for (int i = 0; i < 3; i++) {
+		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
+				       1, 1, &ax179_data->fw_version[i]);
+		if (ret < 0)
+			ax179_data->fw_version[i] = 0xff;
+	}
+	netdev_info(dev->net, "AX88179A/279/772D Chip Version: %x, FW: %d.%d.%d.%d\n",
+		    ax179_data->chip_version,
+		    ax179_data->fw_version[0], ax179_data->fw_version[1],
+		    ax179_data->fw_version[2], ax179_data->fw_version[3]);
+
+	/* The AX88279 requires both the AX_RX_CTL_IPE and AX_RX_CTL_DROPCRCERR
+	 * bits set in AX_RX_CTL for creating correct RX-URBs. AX_RX_CTL_DROPCRCERR
+	 * is anyway set for all chips, make sure AX_RX_CTL_IPE is set via ip_align.
+	 * Also configure eeprom access parameters.
+	 */
+	if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		ax179_data->ip_align = 1;
+		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;
+		ax179_data->eeprom_block = 256;
+	} else {
+		ax179_data->ip_align = 0;
+		ax179_data->eeprom_read_cmd = AX_ACCESS_EFUS;
+		ax179_data->eeprom_block = 20;
+	}
+
+	dev->net->netdev_ops = &ax88179_netdev_ops;
+	dev->net->ethtool_ops = &ax88179_ethtool_ops;
+	dev->net->needed_headroom = 8;
+	dev->net->needed_tailroom = 8;
+	dev->net->min_mtu = ETH_MIN_MTU;
+	dev->hard_mtu = 9 * 1024;
+	dev->net->max_mtu = dev->hard_mtu - dev->net->hard_header_len;
+
+	/* Initialize MII structure */
+	dev->mii.dev = dev->net;
+	dev->mii.mdio_read = ax88179_mdio_read;
+	dev->mii.mdio_write = ax88179_mdio_write;
+	dev->mii.phy_id_mask = 0xff;
+	dev->mii.reg_num_mask = 0xff;
+	dev->mii.phy_id = 0x03;
+	if (!ax179_data->is_ax88772d)
+		dev->mii.supports_gmii = 1;
+
+	ax179_data->pause_autoneg = 1;
+	ax179_data->pause_tx = 1;
+	ax179_data->pause_rx = 1;
+
+	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
+			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
+			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			      NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	dev->net->hw_features |= dev->net->features;
+
+	dev->net->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+				  NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
+
+	netif_set_tso_max_size(dev->net, 16384);
+
+	/* Enable Transmission of Link Speed byte in interrupt URB */
+	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
+	ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0, 0, 0, NULL);
+
+	/* Read MAC address from DTB or ASIX chip */
+	ax88179_get_mac_addr(dev);
+	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
+
+	return 0;
+
+err_nodev:
+	kfree(ax179_data);
+	ax179_data = NULL;
+
+	return ret;
 }
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1338,6 +1686,22 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	kfree(ax179_data);
 }
 
+static void ax88179a_unbind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 tmp16;
+	u8 tmp8;
+
+	/* Configure RX control register => stop operation */
+	tmp16 = AX_RX_CTL_STOP;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);
+
+	kfree(ax179_data);
+}
+
 static void
 ax88179_rx_checksum(struct sk_buff *skb, u32 *pkt_hdr)
 {
@@ -1354,6 +1718,21 @@ ax88179_rx_checksum(struct sk_buff *skb, u32 *pkt_hdr)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
+static void ax88179a_rx_checksum(struct sk_buff *skb, u64 pkt_desc)
+{
+	u32 pkt_type;
+
+	skb->ip_summed = CHECKSUM_NONE;
+	/* checksum error bit is set */
+	if (pkt_desc & AX179A_RX_PD_L4_ERR || pkt_desc & AX179A_RX_PD_L3_ERR)
+		return;
+
+	pkt_type = pkt_desc & AX179A_RX_PD_L4_TYPE_MASK;
+	/* It must be a TCP or UDP packet with a valid checksum */
+	if (pkt_type == AX179A_RX_PD_L4_TCP || pkt_type == AX179A_RX_PD_L4_UDP)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+}
+
 static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
 	struct sk_buff *ax_skb;
@@ -1472,6 +1851,121 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	return 0;
 }
 
+static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct sk_buff *ax_skb;
+	u32 hdr_off, pkt_end;
+	u64 *pkt_desc_ptr;
+	u16 vlan_tag;
+	u16 pkt_cnt;
+	u64 rx_hdr;
+
+	/* SKB contents for AX179A-based chips:
+	 *   <packet 1>
+	 *   ...
+	 *   <packet N>
+	 *   <per-packet metadata entry 1>
+	 *   ...
+	 *   <per-packet metadata entry N>
+	 *   <rx_hdr>
+	 *
+	 * where:
+	 *   <packet N> contains pkt_len data bytes and padding:
+	 *		2 bytes of IP alignment (optional, depends on AX_RX_CTL_IPE flag)
+	 *		packet data received
+	 *		optional padding to 8-bytes boundary
+	 *   <per-packet metadata entry N> contains 8 bytes:
+	 *		pkt_len and fields AX_RXHDR_*
+	 *   <rx-hdr>	contains 8 bytes:
+	 *		pkt_cnt and hdr_off (offset of <per-packet metadata entry 1>)
+	 *
+	 * pkt_cnt is number of entries in the per-packet metadata array.
+	 */
+
+	if (!skb || skb->len < sizeof(rx_hdr))
+		goto err;
+
+	/* RX Descriptor Header */
+	skb_trim(skb, skb->len - sizeof(rx_hdr));
+	rx_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
+
+	/* Check these packets */
+	hdr_off = (rx_hdr & AX179A_RX_DH_DESC_OFFSET_MASK) >> AX179A_RX_DH_DESC_OFFSET_SHIFT;
+	pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;
+
+	/* Consistency check header position */
+	if (hdr_off != skb->len - (pkt_cnt * sizeof(rx_hdr)))
+		goto err;
+
+	/* Make sure that the bounds of the metadata array are inside the SKB
+	 * (and in front of the counter at the end).
+	 */
+	if (pkt_cnt * 8 + hdr_off > skb->len)
+		goto err;
+
+	/* Packets must not overlap the metadata array */
+	skb_trim(skb, hdr_off);
+
+	if (!pkt_cnt)
+		goto err;
+
+	/* Get the first RX packet descriptor */
+	pkt_desc_ptr = (u64 *)(skb->data + hdr_off);
+
+	pkt_end = 0;
+	while (pkt_cnt--) {
+		u64 pkt_desc = le64_to_cpup(pkt_desc_ptr);
+		u32 pkt_len_plus_padd;
+		u32 pkt_len;
+
+		pkt_len = (u32)((pkt_desc & AX179A_RX_PD_LEN_MASK) >> AX179A_RX_PD_LEN_SHIFT)
+			  - (ax179_data->ip_align ? 2 : 0);
+		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
+
+		pkt_end += pkt_len_plus_padd;
+		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
+			goto err;
+
+		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
+		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD)) {
+			skb_pull(skb, pkt_len_plus_padd);
+
+			/* Next RX Packet Descriptor */
+			pkt_desc_ptr++;
+			continue;
+		}
+
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
+		if (!ax_skb)
+			goto err;
+
+		skb_put(ax_skb, pkt_len);
+		memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),
+		       pkt_len);
+
+		if (ax179_data->rx_checksum)
+			ax88179a_rx_checksum(ax_skb, pkt_desc);
+
+		if (pkt_desc & AX179A_RX_PD_VLAN) {
+			vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
+			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q),
+					       vlan_tag & VLAN_VID_MASK);
+		}
+
+		usbnet_skb_return(dev, ax_skb);
+		skb_pull(skb, pkt_len_plus_padd);
+
+		/* Next RX Packet Header */
+		pkt_desc_ptr++;
+	}
+
+	return 1;
+
+err:
+	return 0;
+}
+
 static struct sk_buff *
 ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
@@ -1505,6 +1999,59 @@ ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 	return skb;
 }
 
+static struct sk_buff *
+ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
+{
+	u64 tx_desc = skb->len & AX179A_TX_DESC_LEN_MASK;
+	int frame_size = dev->maxpacket;
+	struct sk_buff *ax_skb;
+	u64 *tx_desc_ptr;
+	int padding_size;
+	int headroom;
+	int tailroom;
+	u16 tci = 0;
+
+	/* TSO MSS */
+	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & AX179A_TX_DESC_MSS_MASK)) <<
+		   AX179A_TX_DESC_MSS_SHIFT;
+
+	headroom = (skb->len + sizeof(tx_desc)) % 8;
+	padding_size = headroom ? 8 - headroom : 0;
+
+	if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) {
+		padding_size += 8;
+		tx_desc |= AX179A_TX_DESC_DROP_PADD;
+	}
+
+	if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && (vlan_get_tag(skb, &tci) >= 0)) {
+		tx_desc |= AX179A_TX_DESC_VLAN;
+		tx_desc |= ((u64)tci & AX179A_TX_DESC_VLAN_MASK) << AX179A_TX_DESC_VLAN_SHIFT;
+	}
+
+	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb))
+		return NULL;
+
+	headroom = skb_headroom(skb);
+	tailroom = skb_tailroom(skb);
+
+	if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
+		ax_skb = skb_copy_expand(skb, sizeof(tx_desc), padding_size, flags);
+		dev_kfree_skb_any(skb);
+		skb = ax_skb;
+		if (!skb)
+			return NULL;
+	}
+	if (padding_size != 0)
+		skb_put_zero(skb, padding_size);
+	/* Copy TX header */
+	tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
+	*tx_desc_ptr = cpu_to_le64(tx_desc);
+
+	usbnet_set_skb_tx_stats(skb, 1, 0);
+
+	return skb;
+}
+
 static int ax88179_link_reset(struct usbnet *dev)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -1580,72 +2127,343 @@ static int ax88179_link_reset(struct usbnet *dev)
 	return 0;
 }
 
+static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	const struct ax_bulkin_settings *bulkin_data;
+	int index = 0;
+
+	switch (ax179_data->speed) {
+	case ETHER_LINK_2500:	/* AX88279 only */
+		index = 0;
+		break;
+
+	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
+		if (ax179_data->chip_version == AX_VERSION_AX88279) {
+			if (link_sts & AX_USB_SS)
+				index = 1;
+			else if (link_sts & AX_USB_HS)
+				index = 2;
+		} else {
+			if (link_sts & AX_USB_SS)
+				index = 0;
+			else if (link_sts & AX_USB_HS)
+				index = 1;
+		}
+		break;
+
+	case ETHER_LINK_100:
+		if (ax179_data->chip_version == AX_VERSION_AX88279) {
+			if (link_sts & AX_USB_SS)
+				index = 3;
+			else if (link_sts & AX_USB_HS)
+				index = 5;
+			if (!ax179_data->full_duplex)
+				index++;
+		} else {
+			/* AX88279A & AX88277D */
+			if (link_sts & AX_USB_SS)
+				index = 2;
+			else if (link_sts & AX_USB_HS)
+				index = 4;
+			if (!ax179_data->full_duplex)
+				index++;
+		}
+		break;
+
+	case ETHER_LINK_10:
+		if (ax179_data->chip_version == AX_VERSION_AX88279)
+			index = 7;
+		else
+			index = 6;
+		break;
+
+	default:	/* No link */
+		index = 0;
+	}
+
+	if (ax179_data->chip_version == AX_VERSION_AX88279 && (link_sts & AX_USB_FS))
+		index = 7;
+
+	if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		bulkin_data = AX88279_BULKIN_SIZE;
+	} else {
+		if (ax179_data->is_ax88772d)
+			bulkin_data = AX88772D_BULKIN_SIZE;
+		else
+			bulkin_data = AX88179A_BULKIN_SIZE;
+	}
+
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, &bulkin_data[index]);
+}
+
+static int ax88179a_link_reset(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u8 tmp8, link_sts, reg8[3];
+	u16 tmp16, mode, speed;
+
+	if (!ax179_data->link) {
+		netdev_info(dev->net, "ax88179a - Link status is: 0\n");
+		return 0;
+	}
+
+	/* Stop RX/TX for link configuration */
+	tmp16 = AX_RX_CTL_STOP;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
+
+	tmp8 = 0xa5;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 1, &tmp8);
+
+	tmp16 = 0x0410;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 2, &tmp16);
+
+	tmp8 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_ETH_TX_GAP, 1, 1, &tmp8);
+
+	tmp8 = 0x07;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_EP5_EHR, 1, 1, &tmp8);
+
+	tmp8 = 0x28 | AX_NEW_PAUSE_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_NEW_PAUSE_CTRL, 1, 1, &tmp8);
+
+	mode = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN | AX_MEDIUM_RXFLOW_CTRLEN;
+
+	/* Link is up, but some older AX88179A FW versions do not send link speed
+	 * and duplex status in interrupt URB, so read it via MII
+	 */
+	if (!ax179_data->speed) {
+		struct ethtool_link_ksettings cmd;
+
+		mii_ethtool_get_link_ksettings(&dev->mii, &cmd);
+		ax179_data->full_duplex = cmd.base.duplex;
+		switch (cmd.base.speed) {
+		case SPEED_1000:
+			ax179_data->speed = ETHER_LINK_1000;
+			break;
+		case SPEED_100:
+			ax179_data->speed = ETHER_LINK_100;
+			break;
+		case SPEED_10:
+		default:
+			ax179_data->speed = ETHER_LINK_10;
+			break;
+		};
+	}
+
+	speed = 0;
+	switch (ax179_data->speed) {
+	case ETHER_LINK_2500:
+		reg8[0] = 0x00;
+		reg8[1] = 0xF8;
+		reg8[2] = 0x07;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_PAUSE, 3, 3, reg8);
+
+		reg8[0] = 0x78;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5);
+		reg8[2] = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		reg8[0] = 0x40;
+		reg8[1] = AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC | AX_MAC_LSO_ERR_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 2, 2, reg8);
+
+		tmp8 = AX_XGMII_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
+
+		tmp8 = 0x1C | AX_LSO_ENHANCE_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1, 1, &tmp8);
+
+		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_FULL_DUPLEX;
+
+		speed = 2500;
+		break;
+
+	case ETHER_LINK_1000:
+		mode |= AX_MEDIUM_GIGAMODE;
+		speed = 1000;
+		fallthrough;
+
+	case ETHER_LINK_100:
+		reg8[0] = 0x78;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
+		reg8[2] = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		tmp8 = 0x40;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
+
+		speed = speed ? speed : 100;
+		break;
+
+	case ETHER_LINK_10:
+		reg8[0] = 0xFA;
+		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
+		reg8[2] = 0xFF;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
+
+		tmp8 = 0xFA;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
+
+		speed = 10;
+		break;
+	}
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
+	ax88179a_bulkin_config(dev, link_sts);
+
+	if (ax179_data->chip_version < AX_VERSION_AX88279) {
+		tmp8 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
+	}
+
+	if (ax179_data->full_duplex)
+		mode |= AX_MEDIUM_FULL_DUPLEX;
+
+	if (dev->net->mtu > 1500)
+		mode |= AX_MEDIUM_JUMBO_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
+
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
+
+	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
+
+	ax179_data->eee_enabled = ax88179_chk_eee(dev);
+
+	netif_carrier_on(dev->net);
+
+	netdev_info(dev->net, "ax88179a - Link status is: 1, Link speed: %d, Duplex: %d\n",
+		    speed, ax179_data->full_duplex);
+
+	return 0;
+}
+
 static int ax88179_reset(struct usbnet *dev)
 {
-	u8 buf[5];
-	u16 *tmp16;
-	u8 *tmp;
 	struct ax88179_data *ax179_data = dev->driver_priv;
 	struct ethtool_keee eee_data;
+	u16 *tmp16;
+	u8 buf[5];
+	u8 *tmp;
 
 	tmp16 = (u16 *)buf;
 	tmp = (u8 *)buf;
 
 	/* Power up ethernet PHY */
-	*tmp16 = 0;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		*tmp16 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
 
-	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(500);
+		*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
+		msleep(500);
 
-	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(200);
+		*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
+		msleep(200);
+	} else {
+		*tmp = AX_PHY_POWER;
+		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, tmp);
+		msleep(250);
+	}
+
+	if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		*tmp16 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
+		*tmp16 &= ~(ADVERTISE_10FULL | ADVERTISE_10HALF);
+		*tmp16 |= AX_ADVERTISE_2500;
+		ax88179_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE, *tmp16);
+	}
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev);
 
+	if (ax179_data->chip_version >= AX_VERSION_AX88179A) {
+		*tmp = AX_MAC_EFF_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, 1, tmp);
+
+		*tmp16 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
+
+		*tmp = 0x04;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+		*tmp = 0x10;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
+
+		*tmp = 0;
+		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+			*tmp |= AX_VLAN_CONTROL_VFE;
+		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
+			*tmp |= AX_VLAN_CONTROL_VSO;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
+
+		*tmp = 0xff;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 1, tmp);
+
+		*tmp = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 1, tmp);
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 1, tmp);
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 1, tmp);
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 1, tmp);
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 1, tmp);
+	}
+
 	/* Read MAC address from DTB or asix chip */
 	ax88179_get_mac_addr(dev);
 	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
 
 	/* RX bulk configuration */
-	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
-
-	dev->rx_urb_size = 1024 * 20;
-
-	*tmp = 0x34;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
-
-	*tmp = 0x52;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
+		*tmp = 0x34;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+
+		*tmp = 0x52;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
+				  1, 1, tmp);
+		dev->rx_urb_size = 1024 * 20;
+	} else {
+		/* The Bulk-Register configuration for the AX88179A is done in
+		 * ax88179a_link_reset(), once the link is up for a given link and USB-speed.
+		 */
+		if (ax179_data->is_ax88772d)
+			dev->rx_urb_size = 1024 * 24;
+		else
+			dev->rx_urb_size = 1024 * 48;
+	}
 
 	/* Enable checksum offload */
 	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
+	ax179_data->rx_checksum = 1;
 
 	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
 	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
 
 	/* Configure RX control register => start operation */
-	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
-		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
-
-	*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL |
-	       AX_MONITOR_MODE_RWMP;
+	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
+			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
+	if (ax179_data->ip_align)
+		ax179_data->rxctl |= AX_RX_CTL_IPE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
+
+	if (ax179_data->chip_version < AX_VERSION_AX88179A)
+		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
+	else
+		*tmp = AX_MONITOR_MODE_RWMP;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);
 
 	/* Configure default medium type => giga */
 	*tmp16 = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN |
-		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX |
-		 AX_MEDIUM_GIGAMODE;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
-			  2, 2, tmp16);
+		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX;
+	if (!ax179_data->is_ax88772d)
+		*tmp16 |= AX_MEDIUM_GIGAMODE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
 
 	/* Check if WoL is supported */
 	ax179_data->wol_supported = 0;
@@ -1653,7 +2471,11 @@ static int ax88179_reset(struct usbnet *dev)
 			     1, 1, &tmp) > 0)
 		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
 
-	ax88179_led_setting(dev);
+	/* For chips starting with AX88179A, LEDS are configured by the adapter
+	 * firmware directly from EEPROM/EFUSE values
+	 */
+	if (ax179_data->chip_version < AX_VERSION_AX88179A)
+		ax88179_led_setting(dev);
 
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
@@ -1706,6 +2528,24 @@ static int ax88179_stop(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179a_stop(struct usbnet *dev)
+{
+	u16 reg16;
+	u8 reg8;
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
+
+	reg16 = 0;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &reg16);
+
+	reg8 = 0;
+	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
+
+	return 0;
+}
+
 static const struct driver_info ax88179_info = {
 	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
 	.bind = ax88179_bind,
@@ -1732,6 +2572,45 @@ static const struct driver_info ax88178a_info = {
 	.tx_fixup = ax88179_tx_fixup,
 };
 
+static const struct driver_info ax88179a_info = {
+	.description = "ASIX AX88179A USB 3.2 Gigabit Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179_status,
+	.link_reset = ax88179a_link_reset,
+	.reset = ax88179_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};
+
+static const struct driver_info ax88772d_info = {
+	.description = "ASIX AX88772D/E USB 2.0 Fast Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179_status,
+	.link_reset = ax88179a_link_reset,
+	.reset = ax88179_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};
+
+static const struct driver_info ax88279_info = {
+	.description = "ASIX AX88279 USB 3.2 2.5Gigabit Ethernet",
+	.bind = ax88179a_bind,
+	.unbind = ax88179a_unbind,
+	.status = ax88179_status,
+	.link_reset = ax88179a_link_reset,
+	.reset = ax88179_reset,
+	.stop = ax88179a_stop,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
+	.rx_fixup = ax88179a_rx_fixup,
+	.tx_fixup = ax88179a_tx_fixup,
+};
+
 static const struct driver_info cypress_GX3_info = {
 	.description = "Cypress GX3 SuperSpeed to Gigabit Ethernet Controller",
 	.bind = ax88179_bind,
@@ -1877,6 +2756,18 @@ static const struct driver_info at_umc2000sp_info = {
 
 static const struct usb_device_id products[] = {
 {
+	/* ASIX AX88179A/B USB 3.2 Gigabit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),
+	.driver_info = (unsigned long)&ax88179a_info,
+}, {
+	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
+	.driver_info = (unsigned long)&ax88772d_info,
+}, {
+	/* ASIX AX88279 USB 3.2 2.5GBit Ethernet */
+	USB_DEVICE_VER(0x0b95, 0x1790, 0x0400, 0x0400),
+	.driver_info = (unsigned long)&ax88279_info,
+}, {
 	/* ASIX AX88179 10/100/1000 */
 	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
 	.driver_info = (unsigned long)&ax88179_info,

-- 
2.47.3


