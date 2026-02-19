Return-Path: <netdev+bounces-259479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHIdJkEdl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:25:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E736A15F74B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC40D304994A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AA633EAF2;
	Thu, 19 Feb 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTC3lmWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA733E368
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511069; cv=none; b=ahNgqH0qpyKpT/Qr1Q7HxjLS7e9K+F9VXp5B0PmE6O6G7fecuibvf3qiRSwidkdNyR8e75rgHWNR/EPGVdbvR1Xu+o2NtIfPUGeOjdRvDVhYHntzZeEhvCI/ZVTPN+y3Oz3JOvqlB6ODZ0nbWIDX5Wbu/DOvzm8r78CA6rVsa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511069; c=relaxed/simple;
	bh=cgiaA7o70/vcjA6g+s/hCato8BkbK0rOfCCUVQbKUdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lu4iFWtATEaV06Wyj6MLry/DiCIYVDgw2ikXXpvPWLZCdS4V8m3O6VNzRJ5ejsWIYJirGFxOsxsxy2AnBOMFMAb4ygTk49+txf7NXMIFDK7F360RRkTnbGVZXU4IrAtNNqfSRmJP7iJykI3RCGn3PDr1kfvrQKG67YL3SgeaKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTC3lmWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586E4C116C6;
	Thu, 19 Feb 2026 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511069;
	bh=cgiaA7o70/vcjA6g+s/hCato8BkbK0rOfCCUVQbKUdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uTC3lmWXR/xKsFEHUzvE2e0AkYA0AsGdTfmFCNEPhY0CiySAvnKLJ56Y/53cwyn84
	 sOz9dpZQUP+KDlBLPfpeBbzPWUQfuygjzztF2RZYCaAdFjJM3pUDmIL9GWKz5m0Mqc
	 xX0qMHCcgg1fB0cT068peH81nyQGgChIcSPSmXBUtI5rNAi90RnrIceDyIWIwz/1pa
	 fQYEOEq7T1YL6CzOGs9LIn/DX4aBIbmMtmXb9G2zE+NGrrtfthhGirs4vCvdSCukpN
	 /HLXst41l0ewCCHbUCaIAqMwBol2mIbc1XZ8vje7S9y34mE3O0mpBgcFehezISfBhI
	 5V4Tw15i+WGpw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 15:24:19 +0100
Subject: [PATCH net v3 3/5] net: dsa: ks8955: Delete KSZ8864 and KSZ8795
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-ks8995-fixups-v3-3-a7fc63fe1916@kernel.org>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
In-Reply-To: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259479-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E736A15F74B
X-Rspamd-Action: no action

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
index 2522c9057382..b7c9de39f68e 100644
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
+	dev_info(&spi->dev, "KS8995MA device found, Chip ID:%x, Revision:%x\n",
+		 KS8995_CHIP_ID, ks->revision_id);
 
 	err = ks8995_check_config(ks);
 	if (err)

-- 
2.53.0


