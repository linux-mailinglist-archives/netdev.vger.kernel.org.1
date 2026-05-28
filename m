Return-Path: <netdev+bounces-292583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF+CACX2F2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD715EE2CA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D981319D328
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC73546FD;
	Thu, 28 May 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XepxTvSO"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9103546FB;
	Thu, 28 May 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954848; cv=none; b=diCVMJzWbo7svboSZ2eWu9JeBzh8KLJCwGA9A53r/mH2RT1VUoT4hAFrCHSzAJED6pw9FcHU+GAAoBBPq3NpJ+QCXvWVmY7LK6YKaVjV8fTI9b2DiUYmwU37S/cdmLmGAvRHspfc9pEwekcBONy5au4tBo+TpPiJLucrmA2dSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954848; c=relaxed/simple;
	bh=uEo1Y/l/5mgCgbITW7t40b5ZWdmKIqZ5sCdvEHqwmmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9VV+iju159nlMpWay6fdzg+1mHOWkHVTxJ/Exh5uG+hHDd69bKm+ciikznd6+rX5QlceVke54cmTFRb0bZd/cDVME4hAqqWwpAoazdsiABRfYEw7KIrvQDyS0XvUz2PDtq/DG6PlRfZxKgDLOr1bDqMxyQrAX9dv0BWbDPRpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XepxTvSO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64S7rTB113171905, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779954809;
	bh=HB/h7ITvi5hb4qCFCsAgNXRU83Usr6AZH9kColeDYdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XepxTvSOKsfTw33v0BKvg9Z2ocsuy4RZe1QqhY+GAX3Ka7iNTPSKvgM5huC7IMArW
	 +exF5XWJmixxziETJhEJOGhRtiHQ1eSzMN27qHLxpUYBLZQQBHyop3/c1lzcJRcB6j
	 TH38XxFX2wo2G3eSAxua27bodgrWcCJVIlgzAKpxlWC2yjlSWlz8dmycPiAadiIZtc
	 ETD924FGJFr6BvjqoU6OFdPVME463ZHehZ2rF5sBAOrQf+4gOVwLe+jfB4P5BrFFmB
	 LPsNp+mOEVKncjmqD+ELdiSh4WhCpjNo/7KJJOBVDfoyUe6owSuLYqQBDEkgu475kQ
	 0TKUm9zoapKsQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64S7rTB113171905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 15:53:29 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 May 2026 15:53:28 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 28 May 2026 15:53:28 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/2] net: phy: realtek: load firmware for RTL8261C
Date: Thu, 28 May 2026 15:52:26 +0800
Message-ID: <20260528075226.1054-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260528075226.1054-1-javen_xu@realsil.com.cn>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Queue-Id: 6CD715EE2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for loading firmware. Download some parameters
for RTL8261C.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 221 +++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index fe743fd0421b..d20cdc68cc62 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,12 +18,51 @@
 #include <linux/clk.h>
 #include <linux/string_choices.h>
 #include <net/phy/realtek_phy.h>
+#include <linux/firmware.h>
+#include <linux/crc32.h>
 
 #include "../phylib.h"
 #include "realtek.h"
 
 #define RTL_8261C_CG			0x001cc898
 #define RTL_8261CE_CG			0x001cc899
+#define FW_MAIN_MAGIC			0x52544C38
+#define FW_SUB_MAGIC_8261C		0x32363143
+#define FW_SUB_MAGIC_8261D		0x32363144
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
+} __packed;
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
+} __packed;
+
+#define FW_HEADER_SIZE		sizeof(struct rtl8261x_fw_header)
+#define FW_ENTRY_SIZE		sizeof(struct rtl8261x_fw_entry)
 
 #define RTL8201F_IER_PAGE			0x07
 #define RTL8201F_IER				0x13
@@ -332,6 +371,8 @@ struct rtl8261x_priv {
 	enum rtl8261x_chip_model model;
 	u8 sub_phy_id;
 	bool is_generic;
+	const char *fw_name;
+	bool fw_loaded;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -413,16 +454,19 @@ static int rtl8261x_probe(struct phy_device *phydev)
 	switch (sub_phy_id) {
 	case RTL8261C_CE_MODEL:
 		priv->model = RTL8261_MODEL_C_CE;
+		priv->fw_name = RTL8261C_CE_FW_NAME;
 		phydev_info(phydev, "RTL8261C/CE detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
 	case RTL8261D_MODEL:
 		priv->model = RTL8261_MODEL_D;
+		priv->fw_name = NULL;
 		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
 	default:
 		priv->model = RTL8261_MODEL_GENERIC;
+		priv->fw_name = NULL;
 		priv->is_generic = true;
 		phydev_warn(phydev, "Unknown sub_id 0x%02x! Using GENERIC mode. Update driver for full support.\n",
 			    sub_phy_id);
@@ -452,6 +496,165 @@ static int rtl8261x_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8261x_verify_firmware(struct phy_device *phydev, const struct firmware *fw)
+{
+	const struct rtl8261x_fw_header *hdr;
+	u32 calc_crc, file_crc;
+	size_t data_len;
+	u16 num_entries;
+	u32 main_magic, sub_magic;
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
+	if (sub_magic != FW_SUB_MAGIC_8261C && sub_magic != FW_SUB_MAGIC_8261D) {
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
+static int rtl_phy_write_mmd_bits(struct phy_device *phydev, int devnum,
+				  u16 reg, u8 msb, u8 lsb, u16 val)
+{
+	int ret;
+	u32 reg_val;
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
+	if (ret)
+		return ret;
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
 static int rtl8261x_config_master_slave(struct phy_device *phydev)
 {
 	u16 val;
@@ -601,6 +804,22 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8261x_config_init(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv = phydev->priv;
+	int ret = 0;
+
+	if (!priv->is_generic && !priv->fw_loaded) {
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
@@ -3296,6 +3515,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
 		.name             = "Realtek RTL8261C_RTL8261D 10Gbps PHY",
 		.probe            = rtl8261x_probe,
+		.config_init	  = rtl8261x_config_init,
 		.get_features     = rtl8261x_get_features,
 		.config_aneg      = rtl8261x_config_aneg,
 		.read_status      = rtl8261x_read_status,
@@ -3308,6 +3528,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
 		.name             = "Realtek RTL8261CE 10Gbps PHY",
 		.probe            = rtl8261x_probe,
+		.config_init	  = rtl8261x_config_init,
 		.get_features     = rtl8261x_get_features,
 		.config_aneg      = rtl8261x_config_aneg,
 		.read_status      = rtl8261x_read_status,
-- 
2.43.0


