Return-Path: <netdev+bounces-303937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zmqkHjjZRWoXGAsAu9opvQ
	(envelope-from <netdev+bounces-303937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0016F3339
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=q7SRW+ck;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303937-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303937-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D1D302FEAD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572131353C;
	Thu,  2 Jul 2026 03:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CD30FC39;
	Thu,  2 Jul 2026 03:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962468; cv=none; b=tK2Wd7r4zLsX2MPWt8EhVih5zVwo4F7uEH00oPCM0nJNIBXT96alNdhySdxm9dg+6oDCXbu1NKivhI8AXLgS6M2JeJN+JPStL05uX5FgCoC6DJPc4jHCTTHmppT6MZE8A2FQDzJhQbBCgqLudkaOYASbU1Pa0ex7s9PnTAfLfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962468; c=relaxed/simple;
	bh=rEMpWYQUNHf3nJmBx33bAPL7im+eGGZ1RjEKxdvFFDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICeuw+KSKdp8VDa9c7wREQSozvJ49T3PjjbsEVy2N9hUf0eKpndwn4MOMVPhgBUmqtydXx6RpHeUuDAw4hdg2UwwbiNTc19HT00NYr1YESuXLLxIY0QPThNWI0fqpoXK+03iLLvYcfs6Mjci49bySOb7LgwjTdDhq7Ss6YrKQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=q7SRW+ck; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6623KOD101649089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782962424;
	bh=T8TJ4Nyny8uXvTOkshuCUJF8lqeA1n0BcGULW0Qrygg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=q7SRW+ck8vU2QGWUzY64MWNW4cHhOcoYStFybnOWpX6fGI/xR5uJYRIyxsgNJlg9o
	 +BqjcVl8ehC/CI+k7qaF+7hJDgko8zl30W7fMq6okgCRsL56Mhl8KisifgUBP7YMdf
	 d/EeHWcDhBYfw+MnmYZZiT2ZwAwqHqvCzUVhyeK6pberrL9ur7X6odM8nDsikoBATE
	 4Pm+g66yrVF7Bv90Cr+Z69FxVDkOWGQHA5iG+oEq7N4iYIWgyDnUfjIv5eXquOcuwQ
	 TNVn2jMAjeWnF3rgcfIOokuINKBdH1wX34poAtWkwNWf2APZcbiVX4xUivQ+VcLyjT
	 5g4YCi5ydOTYw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6623KOD101649089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 11:20:24 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Jul 2026 11:20:24 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Jul 2026 11:20:24 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 4/4] net: phy: realtek: load firmware for RTL8261C_CG
Date: Thu, 2 Jul 2026 11:20:19 +0800
Message-ID: <20260702032020.589-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260702032020.589-1-javen_xu@realsil.com.cn>
References: <20260702032020.589-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303937-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0016F3339

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for loading firmware. Download some parameters
for RTL8261C_CG.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will not pad
 - reverse xmas tree for some definition
 - add explanation on rtl_phy_write_mmd_bits()

Changes in v3:
 - add struct rtl8261x_priv

Changes in v4:
 - add struct device *dev

Changes in v5:
 - no changes

Changes in v6:
 - replace rtl_phy_write_mmd_bits with phy_modify_mmd, keep mdio lock
 - check msb and lsb at the beginning of rtl8261x_fw_execute_entry()
 - add comments on rtl8261x_config_init()

Changes in v7:
 - no changes

Changes in v8:
 - remove some phydev_err message in rtl8261x_fw_execute_entry() and
   rtl8261x_config_init()
---
 drivers/net/phy/realtek/realtek_main.c | 214 +++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ef3700894ebf..10c8abfebe84 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -8,7 +8,9 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
+#include <linux/crc32.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/firmware.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pm_wakeirq.h>
@@ -281,6 +283,43 @@
 					 RTL8261X_INT_ALDPS_CHG | \
 					 RTL8261X_INT_JABBER)
 
+#define FW_MAIN_MAGIC			0x52544C38
+#define FW_SUB_MAGIC_8261C		0x32363143
+#define RTL8261X_POLL_TIMEOUT_MS	100
+#define RTL8261X_MAX_MMD_DEV		31
+
+#define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
+MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
+
+enum rtl8261x_fw_op {
+	OP_WRITE = 0x00,	/* Write */
+	OP_POLL  = 0x02,	/* Polling */
+};
+
+struct rtl8261x_fw_header {
+	__le32 main_magic;	/* Main magic number */
+	__le32 sub_magic;	/* Sub magic number */
+	__le16 version_major;	/* Major version */
+	__le16 version_minor;	/* Minor version */
+	__le16 num_entries;	/* Number of entries */
+	__le16 reserved;	/* Reserved */
+	__le32 crc32;		/* CRC32 checksum */
+};
+
+struct rtl8261x_fw_entry {
+	__u8  type;		/* Operation type (OP_*) */
+	__u8  dev;		/* MMD device */
+	__le16 addr;		/* Register address */
+	__u8  msb;		/* MSB bit position */
+	__u8  lsb;		/* LSB bit position */
+	__le16 value;		/* Value to write/compare */
+	__le16 timeout_ms;	/* Poll timeout in milliseconds */
+	__u8  poll_set;		/* Poll until equal (1) or not equal (0) */
+	__u8  reserved;		/* Reserved */
+};
+
+#define FW_HEADER_SIZE		sizeof(struct rtl8261x_fw_header)
+#define FW_ENTRY_SIZE		sizeof(struct rtl8261x_fw_entry)
 
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -300,6 +339,11 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+struct rtl8261x_priv {
+	const char *fw_name;
+	bool fw_loaded;
+};
+
 static int rtl821x_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -342,8 +386,16 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 
 static int rtl8261x_probe(struct phy_device *phydev)
 {
+	struct device *dev = &phydev->mdio.dev;
+	struct rtl8261x_priv *priv;
 	int sub_phy_id, ret;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
 	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
 			    RTL_8261X_SUB_PHY_ID_ADDR);
 	if (ret < 0)
@@ -357,6 +409,7 @@ static int rtl8261x_probe(struct phy_device *phydev)
 
 	switch (sub_phy_id) {
 	case RTL8261C_CE_MODEL:
+		priv->fw_name = RTL8261C_CE_FW_NAME;
 		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
@@ -407,6 +460,152 @@ static int rtl8261x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8261x_verify_firmware(struct phy_device *phydev, const struct firmware *fw)
+{
+	const struct rtl8261x_fw_header *hdr;
+	u32 main_magic, sub_magic;
+	u32 calc_crc, file_crc;
+	size_t data_len;
+	u16 num_entries;
+
+	if (fw->size < FW_HEADER_SIZE) {
+		phydev_err(phydev, "Firmware too small: %zu bytes\n", fw->size);
+		return -EINVAL;
+	}
+
+	hdr = (const struct rtl8261x_fw_header *)fw->data;
+
+	main_magic = le32_to_cpu(hdr->main_magic);
+	if (main_magic != FW_MAIN_MAGIC) {
+		phydev_err(phydev, "Invalid firmware magic: 0x%08x\n", main_magic);
+		return -EINVAL;
+	}
+
+	sub_magic = le32_to_cpu(hdr->sub_magic);
+	if (sub_magic != FW_SUB_MAGIC_8261C) {
+		phydev_err(phydev, "Invalid sub magic: 0x%08x\n", sub_magic);
+		return -EINVAL;
+	}
+
+	num_entries = le16_to_cpu(hdr->num_entries);
+	data_len = num_entries * FW_ENTRY_SIZE;
+
+	if (fw->size != sizeof(*hdr) + data_len) {
+		phydev_err(phydev, "Firmware size mismatch\n");
+		return -EINVAL;
+	}
+
+	calc_crc = crc32(~0, fw->data + FW_HEADER_SIZE, data_len) ^ ~0;
+	file_crc = le32_to_cpu(hdr->crc32);
+
+	if (calc_crc != file_crc) {
+		phydev_err(phydev, "CRC32 mismatch: calculated=0x%08x file=0x%08x\n",
+			   calc_crc, file_crc);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_fw_execute_entry(struct phy_device *phydev,
+				     const struct rtl8261x_fw_entry *entry)
+{
+	u16 addr, value, timeout_ms;
+	u8 dev, msb, lsb, poll_set;
+	u32 bits, expect_val;
+	int ret, val;
+
+	dev = entry->dev;
+	addr = le16_to_cpu(entry->addr);
+	msb = entry->msb;
+	lsb = entry->lsb;
+	value = le16_to_cpu(entry->value);
+	timeout_ms = le16_to_cpu(entry->timeout_ms);
+	poll_set = entry->poll_set;
+
+	if (timeout_ms == 0)
+		timeout_ms = RTL8261X_POLL_TIMEOUT_MS;
+
+	if (dev > RTL8261X_MAX_MMD_DEV) {
+		phydev_err(phydev, "invalid firmware MMD device: dev=%u\n", dev);
+		return -EINVAL;
+	}
+
+	if (msb > 15 || lsb > msb) {
+		phydev_err(phydev, "invalid firmware bits: msb=%u, lsb=%u\n", msb, lsb);
+		return -EINVAL;
+	}
+
+	switch (entry->type) {
+	case OP_WRITE:
+		ret = phy_modify_mmd(phydev, dev, addr,
+				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
+		if (ret)
+			return ret;
+		break;
+
+	case OP_POLL:
+		bits = GENMASK(msb, lsb);
+		expect_val = (value << lsb) & bits;
+
+		if (poll_set)
+			ret = phy_read_mmd_poll_timeout(phydev, dev, addr, val,
+							(val & bits) == expect_val,
+							1000, timeout_ms * 1000, false);
+		else
+			ret = phy_read_mmd_poll_timeout(phydev, dev, addr, val,
+							(val & bits) != expect_val,
+							1000, timeout_ms * 1000, false);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_fw_load(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	const struct rtl8261x_fw_entry *entry;
+	const struct rtl8261x_fw_header *hdr;
+	const struct firmware *fw;
+	int ret, i;
+
+	if (!priv->fw_name)
+		return 0;
+
+	ret = request_firmware(&fw, priv->fw_name, &phydev->mdio.dev);
+	if (ret) {
+		phydev_err(phydev, "Failed to load firmware %s: %d\n", priv->fw_name, ret);
+		return ret;
+	}
+
+	ret = rtl8261x_verify_firmware(phydev, fw);
+	if (ret)
+		goto release_fw;
+
+	hdr = (const struct rtl8261x_fw_header *)fw->data;
+
+	entry = (const struct rtl8261x_fw_entry *)(fw->data + FW_HEADER_SIZE);
+	for (i = 0; i < le16_to_cpu(hdr->num_entries); i++, entry++) {
+		ret = rtl8261x_fw_execute_entry(phydev, entry);
+		if (ret) {
+			phydev_err(phydev, "Entry %d failed: %d\n", i, ret);
+			goto release_fw;
+		}
+	}
+
+	priv->fw_loaded = true;
+
+release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
 static int rtl8261x_config_intr(struct phy_device *phydev)
 {
 	int ret;
@@ -484,6 +683,20 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8261x_config_init(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+
+	/* The firmware parameters are preserved across IEEE soft resets and
+	 * suspend/resume cycles. Reloading is only necessary after a power
+	 * cycle or hard reset.
+	 */
+	if (priv->fw_name && !priv->fw_loaded)
+		return rtl8261x_fw_load(phydev);
+
+	return 0;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -3179,6 +3392,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
 		.name			= "Realtek RTL8261C 10Gbps PHY",
 		.probe			= rtl8261x_probe,
+		.config_init		= rtl8261x_config_init,
 		.get_features		= rtl8261x_get_features,
 		.config_aneg		= rtl8261x_config_aneg,
 		.read_status		= rtl8261x_read_status,
-- 
2.43.0


