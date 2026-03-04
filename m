Return-Path: <netdev+bounces-263708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMurK4UCqGkRnQAAu9opvQ
	(envelope-from <netdev+bounces-263708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918A1FE01B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E29FC3037D7F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F139F188;
	Wed,  4 Mar 2026 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M9HjhNE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D063033C0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618355; cv=none; b=JnQ4aicFw0bE8Qvh1A9ZJMKBrZT2iVsKH+Bvk9hZ8ootXlBuK/Zitipv8bSF5qI3VIn5umxyUJG8uFASWjXyHEQQTE7pYF/D/jHsqOufedKKkJX5HAynnCYU5Im1m9zqhI5xs8uhGyw0QHm1c6j0PBhGjuRiW/XPN7nYVFwmdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618355; c=relaxed/simple;
	bh=Gfd7B7ql+ueW1elwqPAFE3oydJVnAT3ypUR8/SwNJRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ik0E/hKbEV2PXEnnOhIj+vDhu9akvjG5VwT/g8JlFpLkjcyu9y8VOqQH86YvI2Mp9UlQN0nAakhmHCM+fF58UGnmcYs8BKAq3P3t/jiX9A8LrCVSBRbyU7dCimwYcdFk9gVa24AmGUElGOvzqDXrldzopriuPv41rfdGv8WR+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M9HjhNE4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 13E1D4E42538;
	Wed,  4 Mar 2026 09:59:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D740A5FF5C;
	Wed,  4 Mar 2026 09:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F1711036977B;
	Wed,  4 Mar 2026 10:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772618342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jO+WMNA5FIO5l4TT7PRcI+iwxq8dA48cn1PI5SmWFxo=;
	b=M9HjhNE4NX99Pp/8LSFYR614KbD7xC2Fvz0+5w/UQb3lj5scvXgEZgZw/g3bbbvit47XI0
	exNuboXwikEw0/jPcMnLwSkN1jvnn0HFIqgN3VjXg7gf44IHRCplX2Q7YEwIkRuEBuo01Y
	e5xTSuzEm62hTHQs+mdOXVsIG+WMaHpvDFeQrP8dPT5vSnOiggRMeQwXqj+0pUYbF9e75X
	sVrUbac9IHSBestzh8n24rGKOf1cNXIDbZgkKktAkFyL33A0SU+g3QBccajkjHw6iAURWX
	N4+F8hx9qk/eMVtZzgg5Nj4hzLtTF82ftug8e2uc5vaAFfeoyQM60t44fJxd5Q==
Message-ID: <32dd938b-2693-4efb-b70b-f713fbd8fefd@bootlin.com>
Date: Wed, 4 Mar 2026 10:58:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R Gigabit
 Ethernet PHY driver
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
 <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7918A1FE01B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,collabora.com:email]
X-Rspamd-Action: no action

Hi Louis-Alexis

On 04/03/2026 10:35, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Introduce a driver for the Airoha AN8801R Series Gigabit Ethernet
> PHY; this currently supports setting up PHY LEDs, 10/100M, 1000M
> speeds, and Wake on LAN and PHY interrupts.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/net/phy/Kconfig      |    5 +
>  drivers/net/phy/Makefile     |    1 +
>  drivers/net/phy/air_an8801.c | 1059 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1065 insertions(+)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 7b73332a13d9520582fb45780528de4e17496f5e..53f451479509b7c11999beaf91ae08ed4ed01e86 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -96,6 +96,11 @@ config AS21XXX_PHY
>  	  AS21210PB1 that all register with the PHY ID 0x7500 0x7500
>  	  before the firmware is loaded.
>  
> +config AIR_AN8801_PHY
> +	tristate "Airoha AN8801 Gigabit PHY"
> +	help
> +	  Currently supports the Airoha AN8801R PHY.
> +
>  config AIR_EN8811H_PHY
>  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
>  	select PHY_COMMON_PROPS
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 3a34917adea72d03342a8a4ef703ee5d087d229e..83516da36c9ffa4e3b077717e9fc375e38ab2ea5 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -29,6 +29,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
>  
>  obj-$(CONFIG_ADIN_PHY)		+= adin.o
>  obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
> +obj-$(CONFIG_AIR_AN8801_PHY)	+= air_an8801.o
>  obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
>  obj-$(CONFIG_AMD_PHY)		+= amd.o
>  obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
> diff --git a/drivers/net/phy/air_an8801.c b/drivers/net/phy/air_an8801.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..86828c7d9716ee45832483d74f01f2764fcda408
> --- /dev/null
> +++ b/drivers/net/phy/air_an8801.c
> @@ -0,0 +1,1059 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for the Airoha AN8801 Gigabit PHY.
> + *
> + * Copyright (C) 2025 Airoha Technology Corp.
> + * Copyright (C) 2025 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +
> +#define AN8801R_PHY_ID			0xc0ff0421
> +
> +/* MII Registers */
> +#define AIR_EXT_PAGE_ACCESS		0x1f
> +#define   AIR_PHY_PAGE_STANDARD		0
> +#define   AIR_PHY_PAGE_EXTENDED_1	1
> +#define   AIR_PHY_PAGE_EXTENDED_4	4
> +
> +/* MII Registers - Airoha Page 1 */
> +#define AN8801_EXT_REG_PHY		0x14
> +#define   AN8801_EXT_PHY_STATUS0	GENMASK(1, 0)
> +#define   AN8801_EXT_PHY_DOWNSHIFT_CTL	GENMASK(3, 2) /* 2 to 5 1G auto-neg attempts (0..3) */
> +#define   AN8801_EXT_PHY_DOWNSHIFT_EN	BIT(4)
> +#define   AN8801_EXT_PHY_CTRL0		BIT(5)
> +#define   AN8801_EXT_PHY_STATUS1	GENMASK(8, 6)
> +#define   AN8801_EXT_PHY_CTRL1		GENMASK(14, 9)
> +
> +/* MII Registers - Airoha Page 4 */
> +#define AN8801_PBUS_ACCESS		BIT(28)
> +#define AN8801_PBUS_EPHY_ACCESS		BIT(24)
> +#define AN8801_PBUS_CL22_ACCESS		BIT(23)
> +
> +#define AIR_BPBUS_MODE			0x10
> +#define AIR_BPBUS_WR_ADDR_HIGH		0x11
> +#define AIR_BPBUS_WR_ADDR_LOW		0x12
> +#define AIR_BPBUS_WR_DATA_HIGH		0x13
> +#define AIR_BPBUS_WR_DATA_LOW		0x14
> +#define AIR_BPBUS_RD_ADDR_HIGH		0x15
> +#define AIR_BPBUS_RD_ADDR_LOW		0x16
> +#define AIR_BPBUS_RD_DATA_HIGH		0x17
> +#define AIR_BPBUS_RD_DATA_LOW		0x18
> +
> +/* BPBUS Registers */
> +#define AN8801_BPBUS_REG_LED_GPIO	0x54
> +#define AN8801_BPBUS_REG_LED_ID_SEL	0x58
> +#define   LED_ID_GPIO_SEL(led, gpio)	((led) << ((gpio) * 3))
> +#define AN8801_BPBUS_REG_GPIO_MODE	0x70
> +#define AN8801_BPBUS_REG_PHY_IRQ_GPIO	0x7c
> +#define   AN8801_PHY_IRQ_GPIO_NUM_MASK	GENMASK(19, 16)
> +#define   AN8801_PHY_IRQ_GPIO_NUM	1
> +
> +#define AN8801_BPBUS_REG_CKO		0x1a4
> +#define AN8801_CKO_OUTPUT_MODE_AUTO	3
> +
> +#define AN8801_BPBUS_REG_LINK_MODE	0x5054
> +#define  AN8801_BPBUS_LINK_MODE_1000	BIT(0)
> +
> +#define AN8801_BPBUS_REG_BYPASS_PTP	0x21c004
> +#define   AN8801_BYP_PTP_SGMII_TO_GPHY	BIT(8)
> +#define   AN8801_BYP_PTP_RGMII_TO_GPHY	BIT(0)
> +
> +#define AN8801_BPBUS_REG_TXDLY_STEP	0x21c024
> +#define   RGMII_DELAY_STEP_MASK		GENMASK(2, 0)
> +#define   RGMII_TXDELAY_FORCE_MODE	BIT(24)
> +
> +#define AN8801_BPBUS_REG_RXDLY_STEP	0x21c02c
> +#define   RGMII_RXDELAY_ALIGN		BIT(4)
> +#define   RGMII_RXDELAY_FORCE_MODE	BIT(24)
> +
> +#define AN8801_BPBUS_REG_EFIFO_CTL(x)	(0x270004 + (0x100 * (x))) /* 0..2 */
> +#define   AN8801_EFIFO_ALL_EN		GENMASK(7, 0)
> +#define   AN8801_EFIFO_RX_EN		BIT(0)
> +#define   AN8801_EFIFO_TX_EN		BIT(1)
> +#define   AN8801_EFIFO_RX_CLK_EN	BIT(2)
> +#define   AN8801_EFIFO_TX_CLK_EN	BIT(3)
> +#define   AN8801_EFIFO_RX_EEE_EN	BIT(4)
> +#define   AN8801_EFIFO_TX_EEE_EN	BIT(5)
> +#define   AN8801_EFIFO_RX_ODD_NIBBLE_EN	BIT(6)
> +#define   AN8801_EFIFO_TX_ODD_NIBBLE_EN	BIT(7)
> +
> +#define AN8801_BPBUS_REG_WOL_MAC_16_47	0x285114
> +#define AN8801_BPBUS_REG_WOL_MAC_0_15	0x285118
> +
> +#define AN8801_BPBUS_REG_WAKEUP_CTL1	0x285400
> +#define   AN8801_WOL_WAKE_MAGIC_EN	GENMASK(3, 1)
> +
> +#define AN8801_BPBUS_REG_WAKEUP_CTL2	0x285404
> +#define   AN8801_WAKE_OUT_TYPE_PULSE	BIT(0) /* Set/Unset: Pulse/Static */
> +#define   AN8801_WAKE_OUT_POLARITY_NEG	BIT(1) /* Set/Unset: Negative/Positive */
> +#define   AN8801_WAKE_OUT_WIDTH		GENMASK(2, 3)
> +#define    AN8801_WAKE_OUT_84MS		0
> +#define    AN8801_WAKE_OUT_168MS	1
> +#define    AN8801_WAKE_OUT_336MS	2
> +#define    AN8801_WAKE_OUT_672MS	3
> +#define   AN8801_WAKE_OUT_EN		BIT(4)
> +#define   AN8801_PME_WAKEUP_CLR		BIT(8)
> +
> +#define AN8801_BPBUS_REG_WAKE_IRQ_EN	0x285700
> +#define AN8801_BPBUS_REG_WAKE_IRQ_STS	0x285704
> +#define   AN8801_IRQ_WAKE_LNKCHG	BIT(0) /* Wake on link change */
> +#define   AN8801_IRQ_WAKE_UNIPKT	BIT(1) /* Wake on unicast packet */
> +#define   AN8801_IRQ_WAKE_MULPKT	BIT(2) /* Wake on multicast packet */
> +#define   AN8801_IRQ_WAKE_BCPKT		BIT(3) /* Wake on broadcast packet */
> +#define   AN8801_IRQ_WAKE_MAGICPKT	BIT(4) /* Wake on magic packet */
> +#define   AN8801_IRQ_WAKE_ALL		GENMASK(4, 0)
> +
> +/* MDIO_MMD_VEND1 Registers */
> +#define AN8801_PHY_TX_PAIR_DLY_SEL_GBE	0x13
> +#define   AN8801_PHY_PAIR_DLY_SEL_A_GBE	GENMASK(14, 12)
> +#define   AN8801_PHY_PAIR_DLY_SEL_B_GBE	GENMASK(10, 8)
> +#define   AN8801_PHY_PAIR_DLY_SEL_C_GBE	GENMASK(6, 4)
> +#define   AN8801_PHY_PAIR_DLY_SEL_D_GBE	GENMASK(2, 0)
> +#define AN8801_PHY_RXADC_CTRL		0xd8
> +#define   AN8801_PHY_RXADC_SAMP_PHSEL_A	BIT(12)
> +#define   AN8801_PHY_RXADC_SAMP_PHSEL_B	BIT(8)
> +#define   AN8801_PHY_RXADC_SAMP_PHSEL_C	BIT(4)
> +#define   AN8801_PHY_RXADC_SAMP_PHSEL_D	BIT(0)
> +#define AN8801_PHY_RXADC_REV_0		0xd9
> +#define   AN8801_PHY_RXADC_REV_MASK_A	GENMASK(15, 8)
> +#define   AN8801_PHY_RXADC_REV_MASK_B	GENMASK(7, 0)
> +#define AN8801_PHY_RXADC_REV_1		0xda
> +#define   AN8801_PHY_RXADC_REV_MASK_C	GENMASK(15, 8)
> +#define   AN8801_PHY_RXADC_REV_MASK_D	GENMASK(7, 0)
> +
> +/* MDIO_MMD_VEND2 Registers */
> +#define LED_BCR				0x21
> +#define   LED_BCR_MODE_MASK		GENMASK(1, 0)
> +#define   LED_BCR_TIME_TEST		BIT(2)
> +#define   LED_BCR_CLK_EN		BIT(3)
> +#define   LED_BCR_EVT_ALL		BIT(4)
> +#define   LED_BCR_EXT_CTRL		BIT(15)
> +#define   LED_BCR_MODE_DISABLE		0
> +#define   LED_BCR_MODE_2LED		1
> +#define   LED_BCR_MODE_3LED_1		2
> +#define   LED_BCR_MODE_3LED_2		3
> +
> +#define LED_ON_DUR			0x22
> +#define   LED_ON_DUR_MASK		GENMASK(15, 0)
> +
> +#define LED_BLINK_DUR			0x23
> +#define   LED_BLINK_DUR_MASK		GENMASK(15, 0)
> +
> +#define LED_ON_CTRL(i)			(0x24 + ((i) * 2))
> +#define   LED_ON_EVT_MASK		GENMASK(6, 0)
> +#define   LED_ON_EVT_LINK_1000M		BIT(0)
> +#define   LED_ON_EVT_LINK_100M		BIT(1)
> +#define   LED_ON_EVT_LINK_10M		BIT(2)
> +#define   LED_ON_EVT_LINK_DN		BIT(3)
> +#define   LED_ON_EVT_FDX		BIT(4)
> +#define   LED_ON_EVT_HDX		BIT(5)
> +#define   LED_ON_EVT_FORCE		BIT(6)
> +#define   LED_ON_POL			BIT(14)
> +#define   LED_ON_EN			BIT(15)
> +
> +#define LED_BLINK_CTRL(i)		(0x25 + ((i) * 2))
> +#define LED_BLINK_EVT_MASK		GENMASK(9, 0)
> +#define LED_BLINK_EVT_1000M_TX		BIT(0)
> +#define LED_BLINK_EVT_1000M_RX		BIT(1)
> +#define LED_BLINK_EVT_100M_TX		BIT(2)
> +#define LED_BLINK_EVT_100M_RX		BIT(3)
> +#define LED_BLINK_EVT_10M_TX		BIT(4)
> +#define LED_BLINK_EVT_10M_RX		BIT(5)
> +#define LED_BLINK_EVT_COLLISION		BIT(6)
> +#define LED_BLINK_EVT_RX_CRC_ERR	BIT(7)
> +#define LED_BLINK_EVT_RX_IDLE_ERR	BIT(8)
> +#define LED_BLINK_EVT_FORCE		BIT(9)
> +
> +#define AN8801R_NUM_LEDS		3
> +#define AN8801_PERIOD_SHIFT		15
> +#define AN8801_PERIOD_UNIT		32768 /* (1 << AN8801_PERIOD_SHIFT) */
> +#define AN8801_MAX_PERIOD_MS		2147
> +
> +#define LED_BLINK_DURATION_UNIT		780
> +#define LED_BLINK_DURATION(f)		(LED_BLINK_DURATION_UNIT << (f))
> +
> +#define AN8801_LED_DURATION_UNIT_US	32768
> +
> +#define AN8801_REG_PHY_INTERNAL0	0x600
> +#define AN8801_REG_PHY_INTERNAL1	0x601
> +#define   AN8801_PHY_INTFUNC_MASK	GENMASK(15, 0) /* PHY internal functions */
> +
> +enum an8801r_led_fn {
> +	AN8801R_LED_FN_NONE,
> +	AN8801R_LED_FN_LINK,
> +	AN8801R_LED_FN_ACTIVITY,
> +	AN8801R_LED_FN_MAX,
> +};
> +
> +static int an8801r_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
> +}
> +
> +static int an8801r_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
> +}
> +
> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> +				    u32 addr, u32 data)
> +{
> +	int ret;
> +
> +	addr |= AN8801_PBUS_ACCESS;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_MODE, MII_MMD_CTRL_ADDR);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH, upper_16_bits(addr));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW, lower_16_bits(addr));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH, upper_16_bits(data));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW, lower_16_bits(data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __air_buckpbus_reg_read(struct phy_device *phydev,
> +				   u32 addr, u32 *data)
> +{
> +	int pbus_data_l, pbus_data_h;
> +	int ret;
> +
> +	addr |= AN8801_PBUS_ACCESS;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_MODE, MII_MMD_CTRL_ADDR);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH, upper_16_bits(addr));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW, lower_16_bits(addr));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
> +	if (pbus_data_h < 0)
> +		return pbus_data_h;
> +
> +	pbus_data_l = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
> +	if (pbus_data_l < 0)
> +		return pbus_data_l;
> +
> +	*data = (pbus_data_h << 16) | pbus_data_l;
> +	return 0;
> +}
> +
> +static int air_buckpbus_reg_rmw(struct phy_device *phydev,
> +				u32 addr, u32 mask, u32 set)
> +{
> +	u32 data_old, data_new;
> +	int prev_page, ret;
> +
> +	prev_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +	if (prev_page < 0)
> +		return prev_page;
> +
> +	ret = __air_buckpbus_reg_read(phydev, addr, &data_old);
> +	if (ret)
> +		return phy_restore_page(phydev, prev_page, ret);
> +
> +	data_new = data_old & ~mask;
> +	data_new |= set;
> +	if (data_new != data_old)
> +		ret = __air_buckpbus_reg_write(phydev, addr, data_new);
> +
> +	return phy_restore_page(phydev, prev_page, ret);
> +}
> +
> +static int air_buckpbus_reg_set_bits(struct phy_device *phydev,
> +				     u32 addr, u32 mask)
> +{
> +	return air_buckpbus_reg_rmw(phydev, addr, mask, mask);
> +}
> +
> +static int air_buckpbus_reg_clear_bits(struct phy_device *phydev,
> +				       u32 addr, u32 mask)
> +{
> +	return air_buckpbus_reg_rmw(phydev, addr, mask, 0);
> +}
> +
> +static int air_buckpbus_reg_write(struct phy_device *phydev, u32 addr, u32 data)
> +{
> +	int prev_page, ret = 0;
> +
> +	prev_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +	if (prev_page < 0)
> +		return prev_page;
> +
> +	ret = __air_buckpbus_reg_write(phydev, addr, data);
> +
> +	return phy_restore_page(phydev, prev_page, ret);
> +}
> +
> +static int air_buckpbus_reg_read(struct phy_device *phydev, u32 addr, u32 *data)
> +{
> +	int prev_page, ret;
> +
> +	prev_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +	if (prev_page < 0)
> +		return prev_page;
> +
> +	ret = __air_buckpbus_reg_read(phydev, addr, data);
> +
> +	return phy_restore_page(phydev, prev_page, ret);
> +}
These buckplus accessors look very similar to what's in the existing air_en8811h.c
driver, any chance the code can be shared ?

[...]


> +static int an8801r_rgmii_rxdelay(struct phy_device *phydev, u16 delay_steps)
> +{
> +	u32 reg_val;
> +
> +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> +		return -EINVAL;
> +
> +	reg_val = delay_steps & RGMII_DELAY_STEP_MASK;
> +	reg_val |= RGMII_RXDELAY_ALIGN;
> +	reg_val |= RGMII_RXDELAY_FORCE_MODE;
> +
> +	return air_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_RXDLY_STEP,
> +				      reg_val);
> +}
> +
> +static int an8801r_rgmii_txdelay(struct phy_device *phydev, u16 delay_steps)
> +{
> +	u32 reg_val;
> +
> +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> +		return -EINVAL;
> +
> +	reg_val = delay_steps & RGMII_DELAY_STEP_MASK;
> +	reg_val |= RGMII_TXDELAY_FORCE_MODE;
> +
> +	return air_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_TXDLY_STEP,
> +				      reg_val);
> +}
> +
> +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> +{
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return an8801r_rgmii_txdelay(phydev, 4);
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		return an8801r_rgmii_rxdelay(phydev, 0);
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		return an8801r_rgmii_txdelay(phydev, 4);
> +		return an8801r_rgmii_rxdelay(phydev, 0);
> +	case PHY_INTERFACE_MODE_RGMII:
> +	default:
> +		return 0;
> +	}

Can you elaborate on these values for the steps ? Why is it 4 for TX internal delays, but 0 for RX delays ?

Maxime

