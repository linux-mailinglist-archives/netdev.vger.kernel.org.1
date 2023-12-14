Return-Path: <netdev+bounces-57649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313A813B62
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9081F223FE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7386A356;
	Thu, 14 Dec 2023 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QYCwS8ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1E6A32A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bce78f145so9907508e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702584902; x=1703189702; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQpFYsK8/obVkITErfPH3Tq20K9RS8oXAAq1YZCGghE=;
        b=QYCwS8ihkbZW81xJbA5cQOfR+IMGyYTZ/JAlD8siheJ02wCfASC48CJgIBKdrrKed6
         Nw6IpjOwa2mFgQ0kgT+ZW7FDWopfO465F5e8haDSjav7R+LM1yuOOxoNt9qq2oYNhmp/
         mRlvmZwINisuxDnMQ5YUB+rUYE6sCCdGqGNf+t1CP9I9ZJ9lIE0cA2lvH5F/VEa0yzGE
         Ls6F2y5mCjRUQOg3MoRyEp3YKxmCL5v10W78Md7Y6Ku6UWJqW5uR130ClT9mW43MaV9f
         OzIdryc4ZTxIexBCN5XVPgP1rEMUtsuCoBJcL5LX6lUpY21R5ClGEEl5EpsatcY0oFyD
         WeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584902; x=1703189702;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQpFYsK8/obVkITErfPH3Tq20K9RS8oXAAq1YZCGghE=;
        b=Y6tK36ncag8nJTfXgwSv+U32GbZcj9478DFGLhJ5PRQo2ICSyaLESQc2HzEDHFyq9v
         6R9wqpVtwr255Uq0IHw5sp1zkuw1JRUvwWSjyqpwpkQ4qbmbHn1wl20lGWxppxqqAK5e
         2OKfLT00LjEfzQpS2cB3GPG/n+U8ODS+Vy//fvd+FGYwDPyDdrti3bV9dLGhj2cFw6d2
         3lKPon8wNC5ir63jQ7LNSXD4EoMA0dYo4UqT89Cw98/7OXOqR9wZbY8IXp6NuImXa4g9
         0OtzH2Nkt88iuR4R3rsX7jaISuyjhI1EJQZuwYhEini+p/3wag4RZBC85r3f8egc8dht
         k5Ww==
X-Gm-Message-State: AOJu0YxwPUc15wSox/tI5DXbgTkvAq6P6JsA4WprTyi1X9aWjyJsMxQH
	GDSzBmveI6N5DAkRbfqi+3FPCA==
X-Google-Smtp-Source: AGHT+IF6xtDoWaYsQc+IvKQpfiDqtrfNeO8TXvb1Wd9mnsmgg1F4nRGOdE94WyGFWpC5VAvlRvfEgA==
X-Received: by 2002:ac2:5610:0:b0:50c:ff6c:64ae with SMTP id v16-20020ac25610000000b0050cff6c64aemr2078270lfd.196.1702584901823;
        Thu, 14 Dec 2023 12:15:01 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050e140f84besm369519lfb.164.2023.12.14.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:15:00 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux@armlinux.org.uk,
	kabel@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware loading on 88X3310
Date: Thu, 14 Dec 2023 21:14:39 +0100
Message-Id: <20231214201442.660447-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214201442.660447-1-tobias@waldekranz.com>
References: <20231214201442.660447-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

When probing, if a device is waiting for firmware to be loaded into
its RAM, ask userspace for the binary and load it over XMDIO.

We have no choice but to bail out of the probe if firmware is not
available, as the device does not have any built-in image on which to
fall back.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/phy/marvell10g.c | 149 +++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index ad43e280930c..83233b30d7b0 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -25,6 +25,7 @@
 #include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/hwmon.h>
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
@@ -50,6 +51,13 @@ enum {
 	MV_PMA_21X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH	= 0x6,
 	MV_PMA_BOOT		= 0xc050,
 	MV_PMA_BOOT_FATAL	= BIT(0),
+	MV_PMA_BOOT_PRGS_MASK	= 0x0006,
+	MV_PMA_BOOT_PRGS_INIT	= 0x0000,
+	MV_PMA_BOOT_PRGS_WAIT	= 0x0002,
+	MV_PMA_BOOT_PRGS_CSUM	= 0x0004,
+	MV_PMA_BOOT_PRGS_JRAM	= 0x0006,
+	MV_PMA_BOOT_APP_STARTED	= BIT(4),
+	MV_PMA_BOOT_APP_LOADED	= BIT(6),
 
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
@@ -96,6 +104,12 @@ enum {
 	MV_PCS_PORT_INFO_NPORTS_MASK	= 0x0380,
 	MV_PCS_PORT_INFO_NPORTS_SHIFT	= 7,
 
+	/* Firmware downloading */
+	MV_PCS_FW_ADDR_LOW	= 0xd0f0,
+	MV_PCS_FW_ADDR_HIGH	= 0xd0f1,
+	MV_PCS_FW_DATA		= 0xd0f2,
+	MV_PCS_FW_CSUM		= 0xd0f3,
+
 	/* SerDes reinitialization 88E21X0 */
 	MV_AN_21X0_SERDES_CTRL2	= 0x800f,
 	MV_AN_21X0_SERDES_CTRL2_AUTO_INIT_DIS	= BIT(13),
@@ -156,6 +170,7 @@ struct mv3310_chip {
 
 	const struct mv3310_mactype *mactypes;
 	size_t n_mactypes;
+	const char *firmware_path;
 
 #ifdef CONFIG_HWMON
 	int (*hwmon_read_temp_reg)(struct phy_device *phydev);
@@ -506,6 +521,132 @@ static const struct sfp_upstream_ops mv3310_sfp_ops = {
 	.module_insert = mv3310_sfp_insert,
 };
 
+struct mv3310_fw_hdr {
+	struct {
+		u32 size;
+		u32 addr;
+		u16 csum;
+	} __packed data;
+
+	u8 flags;
+#define MV3310_FW_HDR_DATA_ONLY BIT(6)
+
+	u8 port_skip;
+	u32 next_hdr;
+	u16 csum;
+
+	u8 pad[14];
+} __packed;
+
+static int mv3310_load_fw_sect(struct phy_device *phydev,
+			       const struct mv3310_fw_hdr *hdr, const u8 *data)
+{
+	int err = 0;
+	size_t i;
+	u16 csum;
+
+	dev_dbg(&phydev->mdio.dev, "Loading %u byte %s section at 0x%08x\n",
+		hdr->data.size,
+		(hdr->flags & MV3310_FW_HDR_DATA_ONLY) ? "data" : "executable",
+		hdr->data.addr);
+
+	for (i = 0, csum = 0; i < hdr->data.size; i++)
+		csum += data[i];
+
+	if ((u16)~csum != hdr->data.csum) {
+		dev_err(&phydev->mdio.dev, "Corrupt section data\n");
+		return -EINVAL;
+	}
+
+	phy_lock_mdio_bus(phydev);
+
+	/* Any existing checksum is cleared by a read */
+	__phy_read_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_CSUM);
+
+	__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_ADDR_LOW,  hdr->data.addr & 0xffff);
+	__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_ADDR_HIGH, hdr->data.addr >> 16);
+
+	for (i = 0; i < hdr->data.size; i += 2) {
+		__phy_write_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_DATA,
+				(data[i + 1] << 8) | data[i]);
+	}
+
+	csum = __phy_read_mmd(phydev, MDIO_MMD_PCS, MV_PCS_FW_CSUM);
+	if ((u16)~csum != hdr->data.csum) {
+		dev_err(&phydev->mdio.dev, "Download failed\n");
+		err = -EIO;
+		goto unlock;
+	}
+
+	if (hdr->flags & MV3310_FW_HDR_DATA_ONLY)
+		goto unlock;
+
+	__phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MV_PMA_BOOT, 0, MV_PMA_BOOT_APP_LOADED);
+	mdelay(200);
+	if (!(__phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MV_PMA_BOOT) & MV_PMA_BOOT_APP_STARTED)) {
+		dev_err(&phydev->mdio.dev, "Application did not startup\n");
+		err = -ENODEV;
+	}
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return err;
+}
+
+static int mv3310_load_fw(struct phy_device *phydev)
+{
+	const struct mv3310_chip *chip = to_mv3310_chip(phydev);
+	const struct firmware *fw;
+	struct mv3310_fw_hdr hdr;
+	const u8 *sect;
+	size_t i;
+	u16 csum;
+	int err;
+
+	if (!chip->firmware_path)
+		return -EOPNOTSUPP;
+
+	err = request_firmware(&fw, chip->firmware_path, &phydev->mdio.dev);
+	if (err)
+		return err;
+
+	if (fw->size & 1) {
+		err = -EINVAL;
+		goto release;
+	}
+
+	for (sect = fw->data; (sect + sizeof(hdr)) < (fw->data + fw->size);) {
+		memcpy(&hdr, sect, sizeof(hdr));
+		hdr.data.size = cpu_to_le32(hdr.data.size);
+		hdr.data.addr = cpu_to_le32(hdr.data.addr);
+		hdr.data.csum = cpu_to_le16(hdr.data.csum);
+		hdr.next_hdr = cpu_to_le32(hdr.next_hdr);
+		hdr.csum = cpu_to_le16(hdr.csum);
+
+		for (i = 0, csum = 0; i < offsetof(struct mv3310_fw_hdr, csum); i++)
+			csum += sect[i];
+
+		if ((u16)~csum != hdr.csum) {
+			dev_err(&phydev->mdio.dev, "Corrupt section header\n");
+			err = -EINVAL;
+			break;
+		}
+
+		err = mv3310_load_fw_sect(phydev, &hdr, sect + sizeof(hdr));
+		if (err)
+			break;
+
+		if (!hdr.next_hdr)
+			break;
+
+		sect = fw->data + hdr.next_hdr;
+	}
+
+release:
+	release_firmware(fw);
+	return err;
+}
+
 static int mv3310_probe(struct phy_device *phydev)
 {
 	const struct mv3310_chip *chip = to_mv3310_chip(phydev);
@@ -527,6 +668,12 @@ static int mv3310_probe(struct phy_device *phydev)
 		return -ENODEV;
 	}
 
+	if ((ret & MV_PMA_BOOT_PRGS_MASK) == MV_PMA_BOOT_PRGS_WAIT) {
+		ret = mv3310_load_fw(phydev);
+		if (ret)
+			return ret;
+	}
+
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -1219,6 +1366,7 @@ static const struct mv3310_chip mv3310_type = {
 
 	.mactypes = mv3310_mactypes,
 	.n_mactypes = ARRAY_SIZE(mv3310_mactypes),
+	.firmware_path = "mrvl/x3310fw.hdr",
 
 #ifdef CONFIG_HWMON
 	.hwmon_read_temp_reg = mv3310_hwmon_read_temp_reg,
@@ -1489,4 +1637,5 @@ static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
 MODULE_DESCRIPTION("Marvell Alaska X/M multi-gigabit Ethernet PHY driver");
+MODULE_FIRMWARE("mrvl/x3310fw.hdr");
 MODULE_LICENSE("GPL");
-- 
2.34.1


