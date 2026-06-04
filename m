Return-Path: <netdev+bounces-295076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXyIKsssIWp1AAEAu9opvQ
	(envelope-from <netdev+bounces-295076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785263DB58
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=DGVv7m63;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295076-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E66D3021596
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555333CF041;
	Thu,  4 Jun 2026 07:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4539768F;
	Thu,  4 Jun 2026 07:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558973; cv=none; b=pCN/cx/dw+nIoq6iJFESeWgje7kmFGZUAym8TfxyVZjRGwBtRM4zWAoPayxFH2rl/MU8WhLdk6KGrJDPnna/5nYXh2AS/U7rJkK8lawMZPPqx8MoMkifEDB9Ewl0LrkfRV4K/NADWFA8xfe7etrABns8PzuxHNEdQlFWoimGmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558973; c=relaxed/simple;
	bh=VhuT1f3F73q4WMUY9VjWd8OvrdIg3GzGo4nKEKp4WJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbKRjeoP5UsdOMr+15uFBo2VrAy9A2D3+uOYmlFIbr7cCN+/gk1N3LBJP6n5q7GKRuASyNEFbFRTnXATr6y6fzEOLQRudebdz2/twdFE2N28fr5SvCg2rrOm1SwaVN5OwJ1cd/hl3AlYRlgU6p11/63shaRG/iY/9UlyoEL+rAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DGVv7m63; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547gCovD206040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558933;
	bh=BERORA5pn5+F+Tt0fysFhyNMh35ab4PqT5ZmvqnLmAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DGVv7m63U9tauvdpjc+XRNmxCnd+yX5qHVTzkAjIYhxBkw8hjHqaJY6L0ysUWepva
	 EvVBe7Yoq84dy3Q+m+725zdQ5A7l654sOrwRffCIeMYAYfsyQSzLkAWb57+ev1aRGP
	 0rs96lOQ4Mq47DXU5Z2/+WcA8NG1XOTwA2x+OtEfVXMuGWU530iAzIku1zizvEv67s
	 B1GdYunpFZFKBfnuYYIJW+MM0ZQSUKtV2zWJM4Xxed6gGaRSaGSI3Az0jCLscuvCQp
	 K5L7eCqvXuhVeAjSVZp3f3HupCSEnr6uUmSQR8cY6NRPECoMKVIFa1VoO56UAFdYaa
	 2dLVvQdZiPmyQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547gCovD206040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:42:12 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:42:11 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 15:42:12 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 4/4] net: phy: realtek: load firmware for RTL8261C_CG
Date: Thu, 4 Jun 2026 15:42:09 +0800
Message-ID: <20260604074209.93-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604074209.93-1-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295076-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0785263DB58

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for loading firmware. Download some parameters
for RTL8261C_CG.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will not pad
 - reverse xmas tree for some definition
 - add explanation on rtl_phy_write_mmd_bits()
---
 drivers/net/phy/realtek/realtek_main.c | 230 +++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 86788feaae92..612ee7012e68 100644
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
@@ -282,6 +284,42 @@
 					 RTL8261X_INT_ALDPS_CHG | \
 					 RTL8261X_INT_JABBER)
 
+#define FW_MAIN_MAGIC			0x52544C38
+#define FW_SUB_MAGIC_8261C		0x32363143
+#define RTL8261X_POLL_TIMEOUT_MS	100
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
+	__le32 main_magic;	/* Main magic number 0x52544C38 ("RTL8") */
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
+	__u8  poll_set;		/* Poll for set (1) or clear (0) */
+	__u8  reserved;		/* Reserved */
+};
+
+#define FW_HEADER_SIZE		sizeof(struct rtl8261x_fw_header)
+#define FW_ENTRY_SIZE		sizeof(struct rtl8261x_fw_entry)
 
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -303,6 +341,8 @@ struct rtl821x_priv {
 
 struct rtl8261x_priv {
 	u8 sub_phy_id;
+	const char *fw_name;
+	bool fw_loaded;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -369,6 +409,7 @@ static int rtl8261x_probe(struct phy_device *phydev)
 
 	switch (sub_phy_id) {
 	case RTL8261C_CE_MODEL:
+		priv->fw_name = RTL8261C_CE_FW_NAME;
 		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
@@ -400,6 +441,178 @@ static int rtl8261x_get_features(struct phy_device *phydev)
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
+/**
+ * rtl_phy_write_mmd_bits - Write a bitfield in an MMD register
+ * @phydev: PHY device structure
+ * @devnum: MMD device number
+ * @reg:    MMD register address
+ * @msb:    Most significant bit of the field (inclusive)
+ * @lsb:    Least significant bit of the field (inclusive)
+ * @val:    Value to write into the field (right-aligned)
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int rtl_phy_write_mmd_bits(struct phy_device *phydev, int devnum,
+				  u16 reg, u8 msb, u8 lsb, u16 val)
+{
+	u32 reg_val;
+	int ret;
+
+	if (msb > 15 || lsb > msb)
+		return -EINVAL;
+
+	ret = phy_read_mmd(phydev, devnum, reg);
+	if (ret < 0)
+		return ret;
+	reg_val = ret;
+
+	reg_val &= ~GENMASK(msb, lsb);
+	reg_val |= (val << lsb) & GENMASK(msb, lsb);
+
+	return phy_write_mmd(phydev, devnum, reg, reg_val);
+}
+
+static int rtl8261x_fw_execute_entry(struct phy_device *phydev,
+				     const struct rtl8261x_fw_entry *entry)
+{
+	u16 addr, value, timeout_ms;
+	u8 dev, msb, lsb, poll_set;
+	u32 bits, expect_val;
+	int ret = 0;
+	int val;
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
+	switch (entry->type) {
+	case OP_WRITE:
+		ret = rtl_phy_write_mmd_bits(phydev, dev, addr, msb, lsb, value);
+		if (ret) {
+			phydev_err(phydev, "WRITE failed: dev=%d addr=0x%04x\n", dev, addr);
+			return ret;
+		}
+		break;
+
+	case OP_POLL: {
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
+			phydev_err(phydev, "POLL timeout: dev=%d addr=0x%04x\n",
+				   dev, addr);
+		break;
+	}
+	default:
+		phydev_err(phydev, "Unknown firmware operation: %d\n", entry->type);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
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
@@ -476,6 +689,22 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8261x_config_init(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	int ret = 0;
+
+	if (priv->fw_name && !priv->fw_loaded) {
+		ret = rtl8261x_fw_load(phydev);
+		if (ret) {
+			phydev_err(phydev, "Firmware loading failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -3171,6 +3400,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
 		.name			= "Realtek RTL8261C 10Gbps PHY",
 		.probe			= rtl8261x_probe,
+		.config_init		= rtl8261x_config_init,
 		.get_features		= rtl8261x_get_features,
 		.config_aneg		= rtl8261x_config_aneg,
 		.read_status		= genphy_c45_read_status,
-- 
2.43.0


