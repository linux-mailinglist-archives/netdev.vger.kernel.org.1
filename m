Return-Path: <netdev+bounces-288513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD77HrCpB2pSBQMAu9opvQ
	(envelope-from <netdev+bounces-288513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F05594F6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE1103030D05
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004D3EFFD5;
	Fri, 15 May 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM1w+NO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52F3E2AC5;
	Fri, 15 May 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887020; cv=none; b=KqS9cH1Co408ye5b1/sFGuh4I8p+cmSU45ymQ5G5aXna4IMmGyHTEWmYW/wM+H72qnnOgT7lskTezNNlvP4env4nOTtJZSC23m9RipIIfbTHNx05268mI0dNPRgPQfaNFqCa9KQgtWSk1pujfN/juPvvgcMGVAawMzhSUQS1KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887020; c=relaxed/simple;
	bh=1r82rYSNMenWf/XASXUWWox3ZaAki0Zmtg1D42mzMAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6YiB2A92pp7V/QvPEauIReJZ8Kvz9haOrejK4FLLYZnj5S8u1uUy3/9nthKPRu+ax0p3azj+B3vIXzAdn7kaPrlKf1LKh+rhpoCuLQhHg5FVwKpJ4HdUSsxXW6QwRlHiMMMvWxK7VJJN55+tqavdA8bdglTNnSSdFRT63Psq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM1w+NO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4E3C2BCC7;
	Fri, 15 May 2026 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887020;
	bh=1r82rYSNMenWf/XASXUWWox3ZaAki0Zmtg1D42mzMAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KM1w+NO3IDxZaXEl+iHsA4htdRrSkwpE9weA1vHeHFOFp5uUmWwyU7OqKoCSw++cW
	 cKxCaS5liNRBSnsDIDzaS3iZdQiFMLfYdqR1TYhDVibMkOQ8Z6VVrmEYmPhQkHMT29
	 kZXbtaLlhnT297VXzPIi2jn648ZTY7HdYJ8CSG4BtEdj8+ItMsdb+5GJhiSMO6+OX2
	 ZYP4a88hI7AlLOpU0lbHqlfNgEar3Nw6ZXQ42HwuKZbmsGNCpVt1HWfLNdIyxskzA4
	 9b+fwt1a+e4kYDkgbQ+0Q1Xr4OrLAlv8I6b7coFPJcKB3+QsG6jz7qEDycINcfHTHu
	 VIyez0jcG0SRA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 01:16:17 +0200
Subject: [PATCH 5/5] net: dsa: ks8995: Delete surplus driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-ks8995-to-ksz8-v1-5-70d0ef4aa5f4@kernel.org>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: EE2F05594F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,openwrt.org:url]
X-Rspamd-Action: no action

The Microchip ksz driver now handles all switches that the
old driver was handling, but better.

Delete the old driver.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/Kconfig  |   9 -
 drivers/net/dsa/Makefile |   1 -
 drivers/net/dsa/ks8995.c | 857 -----------------------------------------------
 3 files changed, 867 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index b91b9766ebc2..e6315573bea4 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -95,15 +95,6 @@ config NET_DSA_RZN1_A5PSW
 	  This driver supports the A5PSW switch, which is embedded in Renesas
 	  RZ/N1 SoC.
 
-config NET_DSA_KS8995
-	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
-	depends on SPI
-	depends on !NET_DSA_MICROCHIP_KSZ_SPI
-	select NET_DSA_TAG_NONE
-	help
-	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
-	  switches, managed over SPI.
-
 config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index f5a463b87ec2..bbbadf2e41a2 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
 bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
 obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
-obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
 obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o
diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
deleted file mode 100644
index 77d8b842693c..000000000000
--- a/drivers/net/dsa/ks8995.c
+++ /dev/null
@@ -1,857 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SPI driver for Micrel/Kendin KS8995M and KSZ8864RMN ethernet switches
- *
- * Copyright (C) 2008 Gabor Juhos <juhosg at openwrt.org>
- * Copyright (C) 2025 Linus Walleij <linus.walleij@linaro.org>
- *
- * This file was based on: drivers/spi/at25.c
- *     Copyright (C) 2006 David Brownell
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/bits.h>
-#include <linux/if_bridge.h>
-#include <linux/if_vlan.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/of.h>
-#include <linux/spi/spi.h>
-#include <net/dsa.h>
-
-#define DRV_VERSION		"0.1.1"
-#define DRV_DESC		"Micrel KS8995 Ethernet switch SPI driver"
-
-/* ------------------------------------------------------------------------ */
-
-#define KS8995_REG_ID0		0x00    /* Chip ID0 */
-#define KS8995_REG_ID1		0x01    /* Chip ID1 */
-
-#define KS8995_REG_GC0		0x02    /* Global Control 0 */
-
-#define KS8995_GC0_P5_PHY	BIT(3)	/* Port 5 PHY enabled */
-
-#define KS8995_REG_GC1		0x03    /* Global Control 1 */
-#define KS8995_REG_GC2		0x04    /* Global Control 2 */
-
-#define KS8995_GC2_HUGE		BIT(2)	/* Huge packet support */
-#define KS8995_GC2_LEGAL	BIT(1)	/* Legal size override */
-
-#define KS8995_REG_GC3		0x05    /* Global Control 3 */
-#define KS8995_REG_GC4		0x06    /* Global Control 4 */
-
-#define KS8995_GC4_10BT		BIT(4)	/* Force switch to 10Mbit */
-#define KS8995_GC4_MII_FLOW	BIT(5)	/* MII full-duplex flow control enable */
-#define KS8995_GC4_MII_HD	BIT(6)	/* MII half-duplex mode enable */
-
-#define KS8995_REG_GC5		0x07    /* Global Control 5 */
-#define KS8995_REG_GC6		0x08    /* Global Control 6 */
-#define KS8995_REG_GC7		0x09    /* Global Control 7 */
-#define KS8995_REG_GC8		0x0a    /* Global Control 8 */
-#define KS8995_REG_GC9		0x0b    /* Global Control 9 */
-
-#define KS8995_GC9_SPECIAL	BIT(0)	/* Special tagging mode (DSA) */
-
-/* In DSA the ports 1-4 are numbered 0-3 and the CPU port is port 4 */
-#define KS8995_REG_PC(p, r)	(0x10 + (0x10 * (p)) + (r)) /* Port Control */
-#define KS8995_REG_PS(p, r)	(0x1e + (0x10 * (p)) + (r)) /* Port Status */
-
-#define KS8995_REG_PC0		0x00    /* Port Control 0 */
-#define KS8995_REG_PC1		0x01    /* Port Control 1 */
-#define KS8995_REG_PC2		0x02    /* Port Control 2 */
-#define KS8995_REG_PC3		0x03    /* Port Control 3 */
-#define KS8995_REG_PC4		0x04    /* Port Control 4 */
-#define KS8995_REG_PC5		0x05    /* Port Control 5 */
-#define KS8995_REG_PC6		0x06    /* Port Control 6 */
-#define KS8995_REG_PC7		0x07    /* Port Control 7 */
-#define KS8995_REG_PC8		0x08    /* Port Control 8 */
-#define KS8995_REG_PC9		0x09    /* Port Control 9 */
-#define KS8995_REG_PC10		0x0a    /* Port Control 10 */
-#define KS8995_REG_PC11		0x0b    /* Port Control 11 */
-#define KS8995_REG_PC12		0x0c    /* Port Control 12 */
-#define KS8995_REG_PC13		0x0d    /* Port Control 13 */
-
-#define KS8995_PC0_TAG_INS	BIT(2)	/* Enable tag insertion on port */
-#define KS8995_PC0_TAG_REM	BIT(1)	/* Enable tag removal on port */
-#define KS8995_PC0_PRIO_EN	BIT(0)	/* Enable priority handling */
-
-#define KS8995_PC2_TXEN		BIT(2)	/* Enable TX on port */
-#define KS8995_PC2_RXEN		BIT(1)	/* Enable RX on port */
-#define KS8995_PC2_LEARN_DIS	BIT(0)	/* Disable learning on port */
-
-#define KS8995_PC13_TXDIS	BIT(6)	/* Disable transmitter */
-#define KS8995_PC13_PWDN	BIT(3)	/* Power down */
-
-#define KS8995_REG_TPC0		0x60    /* TOS Priority Control 0 */
-#define KS8995_REG_TPC1		0x61    /* TOS Priority Control 1 */
-#define KS8995_REG_TPC2		0x62    /* TOS Priority Control 2 */
-#define KS8995_REG_TPC3		0x63    /* TOS Priority Control 3 */
-#define KS8995_REG_TPC4		0x64    /* TOS Priority Control 4 */
-#define KS8995_REG_TPC5		0x65    /* TOS Priority Control 5 */
-#define KS8995_REG_TPC6		0x66    /* TOS Priority Control 6 */
-#define KS8995_REG_TPC7		0x67    /* TOS Priority Control 7 */
-
-#define KS8995_REG_MAC0		0x68    /* MAC address 0 */
-#define KS8995_REG_MAC1		0x69    /* MAC address 1 */
-#define KS8995_REG_MAC2		0x6a    /* MAC address 2 */
-#define KS8995_REG_MAC3		0x6b    /* MAC address 3 */
-#define KS8995_REG_MAC4		0x6c    /* MAC address 4 */
-#define KS8995_REG_MAC5		0x6d    /* MAC address 5 */
-
-#define KS8995_REG_IAC0		0x6e    /* Indirect Access Control 0 */
-#define KS8995_REG_IAC1		0x6f    /* Indirect Access Control 0 */
-#define KS8995_REG_IAD7		0x70    /* Indirect Access Data 7 */
-#define KS8995_REG_IAD6		0x71    /* Indirect Access Data 6 */
-#define KS8995_REG_IAD5		0x72    /* Indirect Access Data 5 */
-#define KS8995_REG_IAD4		0x73    /* Indirect Access Data 4 */
-#define KS8995_REG_IAD3		0x74    /* Indirect Access Data 3 */
-#define KS8995_REG_IAD2		0x75    /* Indirect Access Data 2 */
-#define KS8995_REG_IAD1		0x76    /* Indirect Access Data 1 */
-#define KS8995_REG_IAD0		0x77    /* Indirect Access Data 0 */
-
-#define KSZ8864_REG_ID1		0xfe	/* Chip ID in bit 7 */
-
-#define KS8995_REGS_SIZE	0x80
-#define KSZ8864_REGS_SIZE	0x100
-#define KSZ8795_REGS_SIZE	0x100
-
-#define ID1_CHIPID_M		0xf
-#define ID1_CHIPID_S		4
-#define ID1_REVISION_M		0x7
-#define ID1_REVISION_S		1
-#define ID1_START_SW		1	/* start the switch */
-
-#define FAMILY_KS8995		0x95
-#define FAMILY_KSZ8795		0x87
-#define CHIPID_M		0
-#define KS8995_CHIP_ID		0x00
-#define KSZ8864_CHIP_ID		0x01
-#define KSZ8795_CHIP_ID		0x09
-
-#define KS8995_CMD_WRITE	0x02U
-#define KS8995_CMD_READ		0x03U
-
-#define KS8995_CPU_PORT		4
-#define KS8995_NUM_PORTS	5 /* 5 ports including the CPU port */
-#define KS8995_RESET_DELAY	10 /* usec */
-
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
-struct ks8995_switch {
-	struct spi_device	*spi;
-	struct device		*dev;
-	struct dsa_switch	*ds;
-	struct mutex		lock;
-	struct gpio_desc	*reset_gpio;
-	struct bin_attribute	regs_attr;
-	const struct ks8995_chip_params	*chip;
-	int			revision_id;
-	unsigned int max_mtu[KS8995_NUM_PORTS];
-};
-
-static const struct spi_device_id ks8995_id[] = {
-	{"ks8995", ks8995},
-	{"ksz8864", ksz8864},
-	{"ksz8795", ksz8795},
-	{ }
-};
-MODULE_DEVICE_TABLE(spi, ks8995_id);
-
-static const struct of_device_id ks8995_spi_of_match[] = {
-	{ .compatible = "micrel,ks8995" },
-	{ .compatible = "micrel,ksz8864" },
-	{ .compatible = "micrel,ksz8795" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, ks8995_spi_of_match);
-
-static inline u8 get_chip_id(u8 val)
-{
-	return (val >> ID1_CHIPID_S) & ID1_CHIPID_M;
-}
-
-static inline u8 get_chip_rev(u8 val)
-{
-	return (val >> ID1_REVISION_S) & ID1_REVISION_M;
-}
-
-/* create_spi_cmd - create a chip specific SPI command header
- * @ks: pointer to switch instance
- * @cmd: SPI command for switch
- * @address: register address for command
- *
- * Different chip families use different bit pattern to address the switches
- * registers:
- *
- * KS8995: 8bit command + 8bit address
- * KSZ8795: 3bit command + 12bit address + 1bit TR (?)
- */
-static inline __be16 create_spi_cmd(struct ks8995_switch *ks, int cmd,
-				    unsigned address)
-{
-	u16 result = cmd;
-
-	/* make room for address (incl. address shift) */
-	result <<= ks->chip->addr_width + ks->chip->addr_shift;
-	/* add address */
-	result |= address << ks->chip->addr_shift;
-	/* SPI protocol needs big endian */
-	return cpu_to_be16(result);
-}
-/* ------------------------------------------------------------------------ */
-static int ks8995_read(struct ks8995_switch *ks, char *buf,
-		 unsigned offset, size_t count)
-{
-	__be16 cmd;
-	struct spi_transfer t[2];
-	struct spi_message m;
-	int err;
-
-	cmd = create_spi_cmd(ks, KS8995_CMD_READ, offset);
-	spi_message_init(&m);
-
-	memset(&t, 0, sizeof(t));
-
-	t[0].tx_buf = &cmd;
-	t[0].len = sizeof(cmd);
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].rx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
-
-	mutex_lock(&ks->lock);
-	err = spi_sync(ks->spi, &m);
-	mutex_unlock(&ks->lock);
-
-	return err ? err : count;
-}
-
-static int ks8995_write(struct ks8995_switch *ks, char *buf,
-		 unsigned offset, size_t count)
-{
-	__be16 cmd;
-	struct spi_transfer t[2];
-	struct spi_message m;
-	int err;
-
-	cmd = create_spi_cmd(ks, KS8995_CMD_WRITE, offset);
-	spi_message_init(&m);
-
-	memset(&t, 0, sizeof(t));
-
-	t[0].tx_buf = &cmd;
-	t[0].len = sizeof(cmd);
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
-
-	mutex_lock(&ks->lock);
-	err = spi_sync(ks->spi, &m);
-	mutex_unlock(&ks->lock);
-
-	return err ? err : count;
-}
-
-static inline int ks8995_read_reg(struct ks8995_switch *ks, u8 addr, u8 *buf)
-{
-	return ks8995_read(ks, buf, addr, 1) != 1;
-}
-
-static inline int ks8995_write_reg(struct ks8995_switch *ks, u8 addr, u8 val)
-{
-	char buf = val;
-
-	return ks8995_write(ks, &buf, addr, 1) != 1;
-}
-
-/* ------------------------------------------------------------------------ */
-
-static int ks8995_stop(struct ks8995_switch *ks)
-{
-	return ks8995_write_reg(ks, KS8995_REG_ID1, 0);
-}
-
-static int ks8995_start(struct ks8995_switch *ks)
-{
-	return ks8995_write_reg(ks, KS8995_REG_ID1, 1);
-}
-
-static int ks8995_reset(struct ks8995_switch *ks)
-{
-	int err;
-
-	err = ks8995_stop(ks);
-	if (err)
-		return err;
-
-	udelay(KS8995_RESET_DELAY);
-
-	return ks8995_start(ks);
-}
-
-/* ks8995_get_revision - get chip revision
- * @ks: pointer to switch instance
- *
- * Verify chip family and id and get chip revision.
- */
-static int ks8995_get_revision(struct ks8995_switch *ks)
-{
-	int err;
-	u8 id0, id1, ksz8864_id;
-
-	/* read family id */
-	err = ks8995_read_reg(ks, KS8995_REG_ID0, &id0);
-	if (err) {
-		err = -EIO;
-		goto err_out;
-	}
-
-	/* verify family id */
-	if (id0 != ks->chip->family_id) {
-		dev_err(&ks->spi->dev, "chip family id mismatch: expected 0x%02x but 0x%02x read\n",
-			ks->chip->family_id, id0);
-		err = -ENODEV;
-		goto err_out;
-	}
-
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
-
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
-	}
-err_out:
-	return err;
-}
-
-static int ks8995_check_config(struct ks8995_switch *ks)
-{
-	int ret;
-	u8 val;
-
-	ret = ks8995_read_reg(ks, KS8995_REG_GC0, &val);
-	if (ret) {
-		dev_err(ks->dev, "failed to read KS8995_REG_GC0\n");
-		return ret;
-	}
-
-	dev_dbg(ks->dev, "port 5 PHY %senabled\n",
-		(val & KS8995_GC0_P5_PHY) ? "" : "not ");
-
-	val |= KS8995_GC0_P5_PHY;
-	ret = ks8995_write_reg(ks, KS8995_REG_GC0, val);
-	if (ret)
-		dev_err(ks->dev, "failed to set KS8995_REG_GC0\n");
-
-	dev_dbg(ks->dev, "set KS8995_REG_GC0 to 0x%02x\n", val);
-
-	return 0;
-}
-
-static void
-ks8995_mac_config(struct phylink_config *config, unsigned int mode,
-		  const struct phylink_link_state *state)
-{
-}
-
-static void
-ks8995_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
-		   unsigned int mode, phy_interface_t interface,
-		   int speed, int duplex, bool tx_pause, bool rx_pause)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ks8995_switch *ks = dp->ds->priv;
-	int port = dp->index;
-	int ret;
-	u8 val;
-
-	/* Allow forcing the mode on the fixed CPU port, no autonegotiation.
-	 * We assume autonegotiation works on the PHY-facing ports.
-	 */
-	if (port != KS8995_CPU_PORT)
-		return;
-
-	dev_dbg(ks->dev, "MAC link up on CPU port (%d)\n", port);
-
-	ret = ks8995_read_reg(ks, KS8995_REG_GC4, &val);
-	if (ret) {
-		dev_err(ks->dev, "failed to read KS8995_REG_GC4\n");
-		return;
-	}
-
-	/* Conjure port config */
-	switch (speed) {
-	case SPEED_10:
-		dev_dbg(ks->dev, "set switch MII to 100Mbit mode\n");
-		val |= KS8995_GC4_10BT;
-		break;
-	case SPEED_100:
-	default:
-		dev_dbg(ks->dev, "set switch MII to 100Mbit mode\n");
-		val &= ~KS8995_GC4_10BT;
-		break;
-	}
-
-	if (duplex == DUPLEX_HALF) {
-		dev_dbg(ks->dev, "set switch MII to half duplex\n");
-		val |= KS8995_GC4_MII_HD;
-	} else {
-		dev_dbg(ks->dev, "set switch MII to full duplex\n");
-		val &= ~KS8995_GC4_MII_HD;
-	}
-
-	dev_dbg(ks->dev, "set KS8995_REG_GC4 to %02x\n", val);
-
-	/* Enable the CPU port */
-	ret = ks8995_write_reg(ks, KS8995_REG_GC4, val);
-	if (ret)
-		dev_err(ks->dev, "failed to set KS8995_REG_GC4\n");
-}
-
-static void
-ks8995_mac_link_down(struct phylink_config *config, unsigned int mode,
-		     phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ks8995_switch *ks = dp->ds->priv;
-	int port = dp->index;
-
-	if (port != KS8995_CPU_PORT)
-		return;
-
-	dev_dbg(ks->dev, "MAC link down on CPU port (%d)\n", port);
-
-	/* Disable the CPU port */
-}
-
-static const struct phylink_mac_ops ks8995_phylink_mac_ops = {
-	.mac_config = ks8995_mac_config,
-	.mac_link_up = ks8995_mac_link_up,
-	.mac_link_down = ks8995_mac_link_down,
-};
-
-static enum
-dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
-					 int port,
-					 enum dsa_tag_protocol mp)
-{
-	/* This switch actually uses the 6 byte KS8995 protocol */
-	return DSA_TAG_PROTO_NONE;
-}
-
-static int ks8995_setup(struct dsa_switch *ds)
-{
-	return 0;
-}
-
-static int ks8995_port_enable(struct dsa_switch *ds, int port,
-			      struct phy_device *phy)
-{
-	struct ks8995_switch *ks = ds->priv;
-
-	dev_dbg(ks->dev, "enable port %d\n", port);
-
-	return 0;
-}
-
-static void ks8995_port_disable(struct dsa_switch *ds, int port)
-{
-	struct ks8995_switch *ks = ds->priv;
-
-	dev_dbg(ks->dev, "disable port %d\n", port);
-}
-
-static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
-					struct switchdev_brport_flags flags,
-					struct netlink_ext_ack *extack)
-{
-	/* We support enabling/disabling learning */
-	if (flags.mask & ~(BR_LEARNING))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int ks8995_port_bridge_flags(struct dsa_switch *ds, int port,
-				    struct switchdev_brport_flags flags,
-				    struct netlink_ext_ack *extack)
-{
-	struct ks8995_switch *ks = ds->priv;
-	int ret;
-	u8 val;
-
-	if (flags.mask & BR_LEARNING) {
-		ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), &val);
-		if (ret) {
-			dev_err(ks->dev, "failed to read KS8995_REG_PC2 on port %d\n", port);
-			return ret;
-		}
-
-		if (flags.val & BR_LEARNING)
-			val &= ~KS8995_PC2_LEARN_DIS;
-		else
-			val |= KS8995_PC2_LEARN_DIS;
-
-		ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), val);
-		if (ret) {
-			dev_err(ks->dev, "failed to write KS8995_REG_PC2 on port %d\n", port);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void ks8995_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
-{
-	struct ks8995_switch *ks = ds->priv;
-	int ret;
-	u8 val;
-
-	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), &val);
-	if (ret) {
-		dev_err(ks->dev, "failed to read KS8995_REG_PC2 on port %d\n", port);
-		return;
-	}
-
-	/* Set the bits for the different STP states in accordance with
-	 * the datasheet, pages 36-37 "Spanning tree support".
-	 */
-	switch (state) {
-	case BR_STATE_DISABLED:
-	case BR_STATE_BLOCKING:
-	case BR_STATE_LISTENING:
-		val &= ~KS8995_PC2_TXEN;
-		val &= ~KS8995_PC2_RXEN;
-		val |= KS8995_PC2_LEARN_DIS;
-		break;
-	case BR_STATE_LEARNING:
-		val &= ~KS8995_PC2_TXEN;
-		val &= ~KS8995_PC2_RXEN;
-		val &= ~KS8995_PC2_LEARN_DIS;
-		break;
-	case BR_STATE_FORWARDING:
-		val |= KS8995_PC2_TXEN;
-		val |= KS8995_PC2_RXEN;
-		val &= ~KS8995_PC2_LEARN_DIS;
-		break;
-	default:
-		dev_err(ks->dev, "unknown bridge state requested\n");
-		return;
-	}
-
-	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), val);
-	if (ret) {
-		dev_err(ks->dev, "failed to write KS8995_REG_PC2 on port %d\n", port);
-		return;
-	}
-
-	dev_dbg(ks->dev, "set KS8995_REG_PC2 for port %d to %02x\n", port, val);
-}
-
-static void ks8995_phylink_get_caps(struct dsa_switch *dsa, int port,
-				    struct phylink_config *config)
-{
-	unsigned long *interfaces = config->supported_interfaces;
-
-	if (port == KS8995_CPU_PORT)
-		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
-
-	if (port <= 3) {
-		/* Internal PHYs */
-		__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
-		/* phylib default */
-		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
-	}
-
-	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
-}
-
-/* Huge packet support up to 1916 byte packages "inclusive"
- * which means that tags are included. If the bit is not set
- * it is 1536 bytes "inclusive". We present the length without
- * tags or ethernet headers. The setting affects all ports.
- */
-static int ks8995_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
-{
-	struct ks8995_switch *ks = ds->priv;
-	unsigned int max_mtu;
-	int ret;
-	u8 val;
-	int i;
-
-	ks->max_mtu[port] = new_mtu;
-
-	/* Roof out the MTU for the entire switch to the greatest
-	 * common denominator: the biggest set for any one port will
-	 * be the biggest MTU for the switch.
-	 */
-	max_mtu = ETH_DATA_LEN;
-	for (i = 0; i < KS8995_NUM_PORTS; i++) {
-		if (ks->max_mtu[i] > max_mtu)
-			max_mtu = ks->max_mtu[i];
-	}
-
-	/* Translate to layer 2 size.
-	 * Add ethernet and (possible) VLAN headers, and checksum to the size.
-	 * For ETH_DATA_LEN (1500 bytes) this will add up to 1522 bytes.
-	 */
-	max_mtu += VLAN_ETH_HLEN;
-	max_mtu += ETH_FCS_LEN;
-
-	ret = ks8995_read_reg(ks, KS8995_REG_GC2, &val);
-	if (ret) {
-		dev_err(ks->dev, "failed to read KS8995_REG_GC2\n");
-		return ret;
-	}
-
-	if (max_mtu <= 1522) {
-		val &= ~KS8995_GC2_HUGE;
-		val &= ~KS8995_GC2_LEGAL;
-	} else if (max_mtu > 1522 && max_mtu <= 1536) {
-		/* This accepts packets up to 1536 bytes */
-		val &= ~KS8995_GC2_HUGE;
-		val |= KS8995_GC2_LEGAL;
-	} else {
-		/* This accepts packets up to 1916 bytes */
-		val |= KS8995_GC2_HUGE;
-		val |= KS8995_GC2_LEGAL;
-	}
-
-	dev_dbg(ks->dev, "new max MTU %d bytes (inclusive)\n", max_mtu);
-
-	ret = ks8995_write_reg(ks, KS8995_REG_GC2, val);
-	if (ret)
-		dev_err(ks->dev, "failed to set KS8995_REG_GC2\n");
-
-	return ret;
-}
-
-static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
-{
-	return 1916 - ETH_HLEN - ETH_FCS_LEN;
-}
-
-static const struct dsa_switch_ops ks8995_ds_ops = {
-	.get_tag_protocol = ks8995_get_tag_protocol,
-	.setup = ks8995_setup,
-	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
-	.port_bridge_flags = ks8995_port_bridge_flags,
-	.port_enable = ks8995_port_enable,
-	.port_disable = ks8995_port_disable,
-	.port_stp_state_set = ks8995_port_stp_state_set,
-	.port_change_mtu = ks8995_change_mtu,
-	.port_max_mtu = ks8995_get_max_mtu,
-	.phylink_get_caps = ks8995_phylink_get_caps,
-};
-
-/* ------------------------------------------------------------------------ */
-static int ks8995_probe(struct spi_device *spi)
-{
-	struct ks8995_switch *ks;
-	int err;
-	int variant = spi_get_device_id(spi)->driver_data;
-
-	if (variant >= max_variant) {
-		dev_err(&spi->dev, "bad chip variant %d\n", variant);
-		return -ENODEV;
-	}
-
-	ks = devm_kzalloc(&spi->dev, sizeof(*ks), GFP_KERNEL);
-	if (!ks)
-		return -ENOMEM;
-
-	mutex_init(&ks->lock);
-	ks->spi = spi;
-	ks->dev = &spi->dev;
-	ks->chip = &ks8995_chip[variant];
-
-	ks->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
-						 GPIOD_OUT_HIGH);
-	err = PTR_ERR_OR_ZERO(ks->reset_gpio);
-	if (err) {
-		dev_err(&spi->dev,
-			"failed to get reset gpio: %d\n", err);
-		return err;
-	}
-
-	err = gpiod_set_consumer_name(ks->reset_gpio, "switch-reset");
-	if (err)
-		return err;
-
-	if (ks->reset_gpio) {
-		/*
-		 * If a reset line was obtained, wait for 100us after
-		 * de-asserting RESET before accessing any registers, see
-		 * the KS8995MA datasheet, page 44.
-		 */
-		gpiod_set_value_cansleep(ks->reset_gpio, 0);
-		udelay(100);
-	}
-
-	spi_set_drvdata(spi, ks);
-
-	spi->mode = SPI_MODE_0;
-	spi->bits_per_word = 8;
-	err = spi_setup(spi);
-	if (err) {
-		dev_err(&spi->dev, "spi_setup failed, err=%d\n", err);
-		return err;
-	}
-
-	err = ks8995_get_revision(ks);
-	if (err)
-		return err;
-
-	err = ks8995_reset(ks);
-	if (err)
-		return err;
-
-	dev_info(&spi->dev, "%s device found, Chip ID:%x, Revision:%x\n",
-		 ks->chip->name, ks->chip->chip_id, ks->revision_id);
-
-	err = ks8995_check_config(ks);
-	if (err)
-		return err;
-
-	ks->ds = devm_kzalloc(&spi->dev, sizeof(*ks->ds), GFP_KERNEL);
-	if (!ks->ds)
-		return -ENOMEM;
-
-	ks->ds->dev = &spi->dev;
-	ks->ds->num_ports = KS8995_NUM_PORTS;
-	ks->ds->ops = &ks8995_ds_ops;
-	ks->ds->phylink_mac_ops = &ks8995_phylink_mac_ops;
-	ks->ds->priv = ks;
-
-	err = dsa_register_switch(ks->ds);
-	if (err)
-		return dev_err_probe(&spi->dev, err,
-				     "unable to register DSA switch\n");
-
-	return 0;
-}
-
-static void ks8995_remove(struct spi_device *spi)
-{
-	struct ks8995_switch *ks = spi_get_drvdata(spi);
-
-	dsa_unregister_switch(ks->ds);
-	/* assert reset */
-	gpiod_set_value_cansleep(ks->reset_gpio, 1);
-}
-
-/* ------------------------------------------------------------------------ */
-static struct spi_driver ks8995_driver = {
-	.driver = {
-		.name	    = "spi-ks8995",
-		.of_match_table = ks8995_spi_of_match,
-	},
-	.probe	  = ks8995_probe,
-	.remove	  = ks8995_remove,
-	.id_table = ks8995_id,
-};
-
-module_spi_driver(ks8995_driver);
-
-MODULE_DESCRIPTION(DRV_DESC);
-MODULE_VERSION(DRV_VERSION);
-MODULE_AUTHOR("Gabor Juhos <juhosg at openwrt.org>");
-MODULE_LICENSE("GPL v2");

-- 
2.54.0


