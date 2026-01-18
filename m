Return-Path: <netdev+bounces-250925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F55BD39A41
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0393009550
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F812FD7D5;
	Sun, 18 Jan 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYmmE5lp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1C23B63C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774067; cv=none; b=r73Nyl0uGja8sNmsqwsC2R/jNEOp9BExFgRVu+xuEJiePr+aIBqM67AIJF1tVAdqbMC16nA0f+dLg+gV9if0e1wYBbWeb8yzXqxINdu1OnQY0JIc4ITOyMCsHLjiOPsF/1kT8GeJLri8nUqWi0GYYZqOXbw5XxK1AqI95HZSMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774067; c=relaxed/simple;
	bh=6bGXKtzk3sHiL9yGoakAiE9ddzI9+hkmYP9qHE6su/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uhhnni8LV5W3t4asD7xKGgMst7mpe1cYxxRkkl4xZ4kw+ZkCO3keb/mT9o/U0yCyw/oWOXts5+JAkQVlSA56m6WAkXNFgf+wqP1CnH8qwVZqlSbvLqw8r/fNxWqjAw3IHfozt9XHXJssb0GRZfILKnYxtP173eNo8M5/Y/pwRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYmmE5lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCB1C116D0;
	Sun, 18 Jan 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774067;
	bh=6bGXKtzk3sHiL9yGoakAiE9ddzI9+hkmYP9qHE6su/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZYmmE5lpC4/4JqIaTCCz0ySxY1aflPL1ZV/+j3CZFqa50vo1z+N56uTzZtRCGMDys
	 hnP0peifg5N6gE6RD0qhMMPgeDdKe+gbPPhbLjTXwrpKb2/JMuQKXZIIxYl/u3Fw4n
	 OwkQa+1jcQNU4jsXqWHnXtCHxlWLg2jxm10gbucXJvGvTL437JXqFUOOsmo5cyml2Z
	 +v4lFzIiLEehBaMK1XvIbZLfQnPnOUFndUXtjD2jT55n1IA+xYcE8sCj14l79h4K/N
	 KmeHG/diiJxH8UXEXfiGdnIVZIHxX+lCpJf9PSaeHFS1bU44+JAMASku5ezr/ryieP
	 +OgVmScFlsfbw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 18 Jan 2026 23:07:32 +0100
Subject: [PATCH net-next 2/4] net: dsa: ks8955: Delete KSZ8864 and KSZ8795
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-ks8995-fixups-v1-2-10a493f0339d@kernel.org>
References: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
In-Reply-To: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

After studying the datasheets for a bit, I can conclude that
the register maps for the two KSZ variants explicitly said to
be supported by this driver are fully supported by the newer
Micrel KSZ driver, including full VLAN support and a different
custom tag than what the KS8995 is using.

Delete this support, users should be using the KSZ driver
CONFIG_NET_DSA_MICROCHIP_KSZ_SPI and any new device trees should
use:
micrel,ksz8864 -> microchip,ksz8864
micrel,ksz8795 -> microchip,ksz8795

Apparently Microchip acquired Micrel at some point and this
created the confusion.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 160 +++++++++--------------------------------------
 1 file changed, 28 insertions(+), 132 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index ff01097601ec..5ad62fa4e52c 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SPI driver for Micrel/Kendin KS8995M and KSZ8864RMN ethernet switches
+ * SPI driver for Micrel/Kendin KS8995M ethernet switch.
  *
  * Copyright (C) 2008 Gabor Juhos <juhosg at openwrt.org>
  * Copyright (C) 2025 Linus Walleij <linus.walleij@linaro.org>
@@ -114,11 +114,7 @@
 #define KS8995_REG_IAD1		0x76    /* Indirect Access Data 1 */
 #define KS8995_REG_IAD0		0x77    /* Indirect Access Data 0 */
 
-#define KSZ8864_REG_ID1		0xfe	/* Chip ID in bit 7 */
-
 #define KS8995_REGS_SIZE	0x80
-#define KSZ8864_REGS_SIZE	0x100
-#define KSZ8795_REGS_SIZE	0x100
 
 #define ID1_CHIPID_M		0xf
 #define ID1_CHIPID_S		4
@@ -127,11 +123,8 @@
 #define ID1_START_SW		1	/* start the switch */
 
 #define FAMILY_KS8995		0x95
-#define FAMILY_KSZ8795		0x87
 #define CHIPID_M		0
 #define KS8995_CHIP_ID		0x00
-#define KSZ8864_CHIP_ID		0x01
-#define KSZ8795_CHIP_ID		0x09
 
 #define KS8995_CMD_WRITE	0x02U
 #define KS8995_CMD_READ		0x03U
@@ -140,49 +133,6 @@
 #define KS8995_NUM_PORTS	5 /* 5 ports including the CPU port */
 #define KS8995_RESET_DELAY	10 /* usec */
 
-enum ks8995_chip_variant {
-	ks8995,
-	ksz8864,
-	ksz8795,
-	max_variant
-};
-
-struct ks8995_chip_params {
-	char *name;
-	int family_id;
-	int chip_id;
-	int regs_size;
-	int addr_width;
-	int addr_shift;
-};
-
-static const struct ks8995_chip_params ks8995_chip[] = {
-	[ks8995] = {
-		.name = "KS8995MA",
-		.family_id = FAMILY_KS8995,
-		.chip_id = KS8995_CHIP_ID,
-		.regs_size = KS8995_REGS_SIZE,
-		.addr_width = 8,
-		.addr_shift = 0,
-	},
-	[ksz8864] = {
-		.name = "KSZ8864RMN",
-		.family_id = FAMILY_KS8995,
-		.chip_id = KSZ8864_CHIP_ID,
-		.regs_size = KSZ8864_REGS_SIZE,
-		.addr_width = 8,
-		.addr_shift = 0,
-	},
-	[ksz8795] = {
-		.name = "KSZ8795CLX",
-		.family_id = FAMILY_KSZ8795,
-		.chip_id = KSZ8795_CHIP_ID,
-		.regs_size = KSZ8795_REGS_SIZE,
-		.addr_width = 12,
-		.addr_shift = 1,
-	},
-};
-
 struct ks8995_switch {
 	struct spi_device	*spi;
 	struct device		*dev;
@@ -190,23 +140,18 @@ struct ks8995_switch {
 	struct mutex		lock;
 	struct gpio_desc	*reset_gpio;
 	struct bin_attribute	regs_attr;
-	const struct ks8995_chip_params	*chip;
 	int			revision_id;
 	unsigned int max_mtu[KS8995_NUM_PORTS];
 };
 
 static const struct spi_device_id ks8995_id[] = {
-	{"ks8995", ks8995},
-	{"ksz8864", ksz8864},
-	{"ksz8795", ksz8795},
+	{"ks8995", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ks8995_id);
 
 static const struct of_device_id ks8995_spi_of_match[] = {
 	{ .compatible = "micrel,ks8995" },
-	{ .compatible = "micrel,ksz8864" },
-	{ .compatible = "micrel,ksz8795" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ks8995_spi_of_match);
@@ -237,10 +182,10 @@ static inline __be16 create_spi_cmd(struct ks8995_switch *ks, int cmd,
 {
 	u16 result = cmd;
 
-	/* make room for address (incl. address shift) */
-	result <<= ks->chip->addr_width + ks->chip->addr_shift;
+	/* make room for address */
+	result <<= 8;
 	/* add address */
-	result |= address << ks->chip->addr_shift;
+	result |= address;
 	/* SPI protocol needs big endian */
 	return cpu_to_be16(result);
 }
@@ -346,79 +291,37 @@ static int ks8995_reset(struct ks8995_switch *ks)
 static int ks8995_get_revision(struct ks8995_switch *ks)
 {
 	int err;
-	u8 id0, id1, ksz8864_id;
+	u8 id0, id1;
 
 	/* read family id */
 	err = ks8995_read_reg(ks, KS8995_REG_ID0, &id0);
-	if (err) {
-		err = -EIO;
-		goto err_out;
-	}
+	if (err)
+		return -EIO;
 
 	/* verify family id */
-	if (id0 != ks->chip->family_id) {
+	if (id0 != FAMILY_KS8995) {
 		dev_err(&ks->spi->dev, "chip family id mismatch: expected 0x%02x but 0x%02x read\n",
-			ks->chip->family_id, id0);
-		err = -ENODEV;
-		goto err_out;
+			FAMILY_KS8995, id0);
+		return -ENODEV;
 	}
 
-	switch (ks->chip->family_id) {
-	case FAMILY_KS8995:
-		/* try reading chip id at CHIP ID1 */
-		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
-		if (err) {
-			err = -EIO;
-			goto err_out;
-		}
-
-		/* verify chip id */
-		if ((get_chip_id(id1) == CHIPID_M) &&
-		    (get_chip_id(id1) == ks->chip->chip_id)) {
-			/* KS8995MA */
-			ks->revision_id = get_chip_rev(id1);
-		} else if (get_chip_id(id1) != CHIPID_M) {
-			/* KSZ8864RMN */
-			err = ks8995_read_reg(ks, KS8995_REG_ID1, &ksz8864_id);
-			if (err) {
-				err = -EIO;
-				goto err_out;
-			}
-
-			if ((ksz8864_id & 0x80) &&
-			    (ks->chip->chip_id == KSZ8864_CHIP_ID)) {
-				ks->revision_id = get_chip_rev(id1);
-			}
-
-		} else {
-			dev_err(&ks->spi->dev, "unsupported chip id for KS8995 family: 0x%02x\n",
-				id1);
-			err = -ENODEV;
-		}
-		break;
-	case FAMILY_KSZ8795:
-		/* try reading chip id at CHIP ID1 */
-		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
-		if (err) {
-			err = -EIO;
-			goto err_out;
-		}
+	/* try reading chip id at CHIP ID1 */
+	err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
+	if (err)
+		return -EIO;
 
-		if (get_chip_id(id1) == ks->chip->chip_id) {
-			ks->revision_id = get_chip_rev(id1);
-		} else {
-			dev_err(&ks->spi->dev, "unsupported chip id for KSZ8795 family: 0x%02x\n",
-				id1);
-			err = -ENODEV;
-		}
-		break;
-	default:
-		dev_err(&ks->spi->dev, "unsupported family id: 0x%02x\n", id0);
-		err = -ENODEV;
-		break;
+	/* verify chip id */
+	if ((get_chip_id(id1) == CHIPID_M) &&
+	    (get_chip_id(id1) == KS8995_CHIP_ID)) {
+		/* KS8995MA */
+		ks->revision_id = get_chip_rev(id1);
+	} else {
+		dev_err(&ks->spi->dev, "unsupported chip id for KS8995 family: 0x%02x\n",
+			id1);
+		return -ENODEV;
 	}
-err_out:
-	return err;
+
+	return 0;
 }
 
 static int ks8995_check_config(struct ks8995_switch *ks)
@@ -747,12 +650,6 @@ static int ks8995_probe(struct spi_device *spi)
 {
 	struct ks8995_switch *ks;
 	int err;
-	int variant = spi_get_device_id(spi)->driver_data;
-
-	if (variant >= max_variant) {
-		dev_err(&spi->dev, "bad chip variant %d\n", variant);
-		return -ENODEV;
-	}
 
 	ks = devm_kzalloc(&spi->dev, sizeof(*ks), GFP_KERNEL);
 	if (!ks)
@@ -761,7 +658,6 @@ static int ks8995_probe(struct spi_device *spi)
 	mutex_init(&ks->lock);
 	ks->spi = spi;
 	ks->dev = &spi->dev;
-	ks->chip = &ks8995_chip[variant];
 
 	ks->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
 						 GPIOD_OUT_HIGH);
@@ -804,8 +700,8 @@ static int ks8995_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	dev_info(&spi->dev, "%s device found, Chip ID:%x, Revision:%x\n",
-		 ks->chip->name, ks->chip->chip_id, ks->revision_id);
+	dev_info(&spi->dev, "KS8955MA device found, Chip ID:%x, Revision:%x\n",
+		 KS8995_CHIP_ID, ks->revision_id);
 
 	err = ks8995_check_config(ks);
 	if (err)

-- 
2.52.0


