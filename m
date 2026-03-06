Return-Path: <netdev+bounces-264852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOwHJKrzqmkjZAEAu9opvQ
	(envelope-from <netdev+bounces-264852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:32:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CF223D96
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05D503033E7D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69F3D3007;
	Fri,  6 Mar 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="QwtE9Q5i"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC23CB2FD;
	Fri,  6 Mar 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810998; cv=pass; b=GcUSUUQMwwObgin5g80we2Jnp8JcakTemVxMLOgJ/wF+Oq5wsohoUvuZij/ek+S1Nxs8FHWFo34DoV9HxVzm8tWGnYMv+yD6NtKihq2WkFnjp4WYw9Ul7/sKQUDpEuNMoFnqASQnefdHv+Pmw18yA1JqwpZyVwviLepWvRrIp0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810998; c=relaxed/simple;
	bh=6WvcLyo8T7/eRYAd2hFhxvH6/UoakPhv4wuL6Hh4E3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvruo9zNQs+8AFlPLzfWWa3bNkjrpYALZJjbmaSnDrAoxEzGnIhrMXieRZe2HGYUhsfbVwXOXdVLhSIyZp1LHfWN8mrZG6LVxq/UP7TE1yLN05Iult8Hp+QxWgM8/2XaNFAS7PowEZx9VOlJCgndKmAM/X7jhGb+HGncBToeFyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=QwtE9Q5i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772810952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n2CYVx5JEDi0jk7OtgRi1swlscIlbUn5VPsdgz7NvVrgIfn+WMv2KXI/2JlE7nPHZ0TEvb8s4U+5tH1ltVfjH7JcuVDdh83lXrx48NZPhs1L5yuW7XF/ieT8XZIDpJLmcAAxVG/1oZSz6aIAMS3vW+h9ra/1prqmsvWCyzlLhIk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772810952; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+SgJSaoS3xBZpSKJEkAK1Alkfabvk0poTkSdP90aLcE=; 
	b=Pn7VofxnewzUyi1JWpxghspal6Amf0Tc59KQoiKS5EPXlyEQpHescP55ScfJt2wDZbBn2tx+EUIAIolRAvNC801wWPvaUXrbQEVKN4+V+9xZReScByZLctzHHQjasSLTLQqk+0wHAC1zuCoNGkdP8TOVATY8ZrYi2S07i5/wU3w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772810952;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=+SgJSaoS3xBZpSKJEkAK1Alkfabvk0poTkSdP90aLcE=;
	b=QwtE9Q5iJGOpPOTY0pjt6t3wv0ZMo4y2eJia7JBnri7zdmVxnPhHc+Z2e7oHGeEd
	49kTZ1WXWj8k4ha7p3uHhbSKsr7A6PkEg6KQUjq6PicJuWpKTbtYXgfS1ZKmY0/sBVy
	C6bwC2oB9+pPHniMQD2eCPdr+Qo0ayjq8WducjEQ=
Received: by mx.zohomail.com with SMTPS id 1772810949873805.2836907763226;
	Fri, 6 Mar 2026 07:29:09 -0800 (PST)
Message-ID: <2825e5b6dff6ed6319c70f9b1c4358a7e07487ad.camel@collabora.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit	 <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, 	kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 16:29:03 +0100
In-Reply-To: <32dd938b-2693-4efb-b70b-f713fbd8fefd@bootlin.com>
References: 
	<20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
	 <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
	 <32dd938b-2693-4efb-b70b-f713fbd8fefd@bootlin.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 9A4CF223D96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264852-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Maxime,

On Wed, 2026-03-04 at 10:58 +0100, Maxime Chevallier wrote:
> Hi Louis-Alexis
>=20
> On 04/03/2026 10:35, Louis-Alexis Eyraud wrote:
> > From: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> >=20
> > Introduce a driver for the Airoha AN8801R Series Gigabit Ethernet
> > PHY; this currently supports setting up PHY LEDs, 10/100M, 1000M
> > speeds, and Wake on LAN and PHY interrupts.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0drivers/net/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 5 +
> > =C2=A0drivers/net/phy/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 1 +
> > =C2=A0drivers/net/phy/air_an8801.c | 1059
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A03 files changed, 1065 insertions(+)
> >=20
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index
> > 7b73332a13d9520582fb45780528de4e17496f5e..53f451479509b7c11999beaf9
> > 1ae08ed4ed01e86 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -96,6 +96,11 @@ config AS21XXX_PHY
> > =C2=A0	=C2=A0 AS21210PB1 that all register with the PHY ID 0x7500
> > 0x7500
> > =C2=A0	=C2=A0 before the firmware is loaded.
> > =C2=A0
> > +config AIR_AN8801_PHY
> > +	tristate "Airoha AN8801 Gigabit PHY"
> > +	help
> > +	=C2=A0 Currently supports the Airoha AN8801R PHY.
> > +
> > =C2=A0config AIR_EN8811H_PHY
> > =C2=A0	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> > =C2=A0	select PHY_COMMON_PROPS
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> > index
> > 3a34917adea72d03342a8a4ef703ee5d087d229e..83516da36c9ffa4e3b077717e
> > 9fc375e38ab2ea5 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -29,6 +29,7 @@ obj-y				+=3D $(sfp-obj-y)
> > $(sfp-obj-m)
> > =C2=A0
> > =C2=A0obj-$(CONFIG_ADIN_PHY)		+=3D adin.o
> > =C2=A0obj-$(CONFIG_ADIN1100_PHY)	+=3D adin1100.o
> > +obj-$(CONFIG_AIR_AN8801_PHY)	+=3D air_an8801.o
> > =C2=A0obj-$(CONFIG_AIR_EN8811H_PHY)=C2=A0=C2=A0 +=3D air_en8811h.o
> > =C2=A0obj-$(CONFIG_AMD_PHY)		+=3D amd.o
> > =C2=A0obj-$(CONFIG_AMCC_QT2025_PHY)	+=3D qt2025.o
> > diff --git a/drivers/net/phy/air_an8801.c
> > b/drivers/net/phy/air_an8801.c
> > new file mode 100644
> > index
> > 0000000000000000000000000000000000000000..86828c7d9716ee45832483d74
> > f01f2764fcda408
> > --- /dev/null
> > +++ b/drivers/net/phy/air_an8801.c
> > @@ -0,0 +1,1059 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for the Airoha AN8801 Gigabit PHY.
> > + *
> > + * Copyright (C) 2025 Airoha Technology Corp.
> > + * Copyright (C) 2025 Collabora Ltd.
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> > +
> > +#define AN8801R_PHY_ID			0xc0ff0421
> > +
> > +/* MII Registers */
> > +#define AIR_EXT_PAGE_ACCESS		0x1f
> > +#define=C2=A0=C2=A0 AIR_PHY_PAGE_STANDARD		0
> > +#define=C2=A0=C2=A0 AIR_PHY_PAGE_EXTENDED_1	1
> > +#define=C2=A0=C2=A0 AIR_PHY_PAGE_EXTENDED_4	4
> > +
> > +/* MII Registers - Airoha Page 1 */
> > +#define AN8801_EXT_REG_PHY		0x14
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_STATUS0	GENMASK(1, 0)
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_DOWNSHIFT_CTL	GENMASK(3, 2) /* 2 to=
 5 1G
> > auto-neg attempts (0..3) */
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_DOWNSHIFT_EN	BIT(4)
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_CTRL0		BIT(5)
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_STATUS1	GENMASK(8, 6)
> > +#define=C2=A0=C2=A0 AN8801_EXT_PHY_CTRL1		GENMASK(14, 9)
> > +
> > +/* MII Registers - Airoha Page 4 */
> > +#define AN8801_PBUS_ACCESS		BIT(28)
> > +#define AN8801_PBUS_EPHY_ACCESS		BIT(24)
> > +#define AN8801_PBUS_CL22_ACCESS		BIT(23)
> > +
> > +#define AIR_BPBUS_MODE			0x10
> > +#define AIR_BPBUS_WR_ADDR_HIGH		0x11
> > +#define AIR_BPBUS_WR_ADDR_LOW		0x12
> > +#define AIR_BPBUS_WR_DATA_HIGH		0x13
> > +#define AIR_BPBUS_WR_DATA_LOW		0x14
> > +#define AIR_BPBUS_RD_ADDR_HIGH		0x15
> > +#define AIR_BPBUS_RD_ADDR_LOW		0x16
> > +#define AIR_BPBUS_RD_DATA_HIGH		0x17
> > +#define AIR_BPBUS_RD_DATA_LOW		0x18
> > +
> > +/* BPBUS Registers */
> > +#define AN8801_BPBUS_REG_LED_GPIO	0x54
> > +#define AN8801_BPBUS_REG_LED_ID_SEL	0x58
> > +#define=C2=A0=C2=A0 LED_ID_GPIO_SEL(led, gpio)	((led) << ((gpio) * 3))
> > +#define AN8801_BPBUS_REG_GPIO_MODE	0x70
> > +#define AN8801_BPBUS_REG_PHY_IRQ_GPIO	0x7c
> > +#define=C2=A0=C2=A0 AN8801_PHY_IRQ_GPIO_NUM_MASK	GENMASK(19, 16)
> > +#define=C2=A0=C2=A0 AN8801_PHY_IRQ_GPIO_NUM	1
> > +
> > +#define AN8801_BPBUS_REG_CKO		0x1a4
> > +#define AN8801_CKO_OUTPUT_MODE_AUTO	3
> > +
> > +#define AN8801_BPBUS_REG_LINK_MODE	0x5054
> > +#define=C2=A0 AN8801_BPBUS_LINK_MODE_1000	BIT(0)
> > +
> > +#define AN8801_BPBUS_REG_BYPASS_PTP	0x21c004
> > +#define=C2=A0=C2=A0 AN8801_BYP_PTP_SGMII_TO_GPHY	BIT(8)
> > +#define=C2=A0=C2=A0 AN8801_BYP_PTP_RGMII_TO_GPHY	BIT(0)
> > +
> > +#define AN8801_BPBUS_REG_TXDLY_STEP	0x21c024
> > +#define=C2=A0=C2=A0 RGMII_DELAY_STEP_MASK		GENMASK(2, 0)
> > +#define=C2=A0=C2=A0 RGMII_TXDELAY_FORCE_MODE	BIT(24)
> > +
> > +#define AN8801_BPBUS_REG_RXDLY_STEP	0x21c02c
> > +#define=C2=A0=C2=A0 RGMII_RXDELAY_ALIGN		BIT(4)
> > +#define=C2=A0=C2=A0 RGMII_RXDELAY_FORCE_MODE	BIT(24)
> > +
> > +#define AN8801_BPBUS_REG_EFIFO_CTL(x)	(0x270004 + (0x100 * (x)))
> > /* 0..2 */
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_ALL_EN		GENMASK(7, 0)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_RX_EN		BIT(0)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_TX_EN		BIT(1)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_RX_CLK_EN	BIT(2)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_TX_CLK_EN	BIT(3)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_RX_EEE_EN	BIT(4)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_TX_EEE_EN	BIT(5)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_RX_ODD_NIBBLE_EN	BIT(6)
> > +#define=C2=A0=C2=A0 AN8801_EFIFO_TX_ODD_NIBBLE_EN	BIT(7)
> > +
> > +#define AN8801_BPBUS_REG_WOL_MAC_16_47	0x285114
> > +#define AN8801_BPBUS_REG_WOL_MAC_0_15	0x285118
> > +
> > +#define AN8801_BPBUS_REG_WAKEUP_CTL1	0x285400
> > +#define=C2=A0=C2=A0 AN8801_WOL_WAKE_MAGIC_EN	GENMASK(3, 1)
> > +
> > +#define AN8801_BPBUS_REG_WAKEUP_CTL2	0x285404
> > +#define=C2=A0=C2=A0 AN8801_WAKE_OUT_TYPE_PULSE	BIT(0) /* Set/Unset:
> > Pulse/Static */
> > +#define=C2=A0=C2=A0 AN8801_WAKE_OUT_POLARITY_NEG	BIT(1) /* Set/Unset:
> > Negative/Positive */
> > +#define=C2=A0=C2=A0 AN8801_WAKE_OUT_WIDTH		GENMASK(2, 3)
> > +#define=C2=A0=C2=A0=C2=A0 AN8801_WAKE_OUT_84MS		0
> > +#define=C2=A0=C2=A0=C2=A0 AN8801_WAKE_OUT_168MS	1
> > +#define=C2=A0=C2=A0=C2=A0 AN8801_WAKE_OUT_336MS	2
> > +#define=C2=A0=C2=A0=C2=A0 AN8801_WAKE_OUT_672MS	3
> > +#define=C2=A0=C2=A0 AN8801_WAKE_OUT_EN		BIT(4)
> > +#define=C2=A0=C2=A0 AN8801_PME_WAKEUP_CLR		BIT(8)
> > +
> > +#define AN8801_BPBUS_REG_WAKE_IRQ_EN	0x285700
> > +#define AN8801_BPBUS_REG_WAKE_IRQ_STS	0x285704
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_LNKCHG	BIT(0) /* Wake on link
> > change */
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_UNIPKT	BIT(1) /* Wake on unicast
> > packet */
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_MULPKT	BIT(2) /* Wake on
> > multicast packet */
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_BCPKT		BIT(3) /* Wake on
> > broadcast packet */
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_MAGICPKT	BIT(4) /* Wake on magic
> > packet */
> > +#define=C2=A0=C2=A0 AN8801_IRQ_WAKE_ALL		GENMASK(4, 0)
> > +
> > +/* MDIO_MMD_VEND1 Registers */
> > +#define AN8801_PHY_TX_PAIR_DLY_SEL_GBE	0x13
> > +#define=C2=A0=C2=A0 AN8801_PHY_PAIR_DLY_SEL_A_GBE	GENMASK(14, 12)
> > +#define=C2=A0=C2=A0 AN8801_PHY_PAIR_DLY_SEL_B_GBE	GENMASK(10, 8)
> > +#define=C2=A0=C2=A0 AN8801_PHY_PAIR_DLY_SEL_C_GBE	GENMASK(6, 4)
> > +#define=C2=A0=C2=A0 AN8801_PHY_PAIR_DLY_SEL_D_GBE	GENMASK(2, 0)
> > +#define AN8801_PHY_RXADC_CTRL		0xd8
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_SAMP_PHSEL_A	BIT(12)
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_SAMP_PHSEL_B	BIT(8)
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_SAMP_PHSEL_C	BIT(4)
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_SAMP_PHSEL_D	BIT(0)
> > +#define AN8801_PHY_RXADC_REV_0		0xd9
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_REV_MASK_A	GENMASK(15, 8)
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_REV_MASK_B	GENMASK(7, 0)
> > +#define AN8801_PHY_RXADC_REV_1		0xda
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_REV_MASK_C	GENMASK(15, 8)
> > +#define=C2=A0=C2=A0 AN8801_PHY_RXADC_REV_MASK_D	GENMASK(7, 0)
> > +
> > +/* MDIO_MMD_VEND2 Registers */
> > +#define LED_BCR				0x21
> > +#define=C2=A0=C2=A0 LED_BCR_MODE_MASK		GENMASK(1, 0)
> > +#define=C2=A0=C2=A0 LED_BCR_TIME_TEST		BIT(2)
> > +#define=C2=A0=C2=A0 LED_BCR_CLK_EN		BIT(3)
> > +#define=C2=A0=C2=A0 LED_BCR_EVT_ALL		BIT(4)
> > +#define=C2=A0=C2=A0 LED_BCR_EXT_CTRL		BIT(15)
> > +#define=C2=A0=C2=A0 LED_BCR_MODE_DISABLE		0
> > +#define=C2=A0=C2=A0 LED_BCR_MODE_2LED		1
> > +#define=C2=A0=C2=A0 LED_BCR_MODE_3LED_1		2
> > +#define=C2=A0=C2=A0 LED_BCR_MODE_3LED_2		3
> > +
> > +#define LED_ON_DUR			0x22
> > +#define=C2=A0=C2=A0 LED_ON_DUR_MASK		GENMASK(15, 0)
> > +
> > +#define LED_BLINK_DUR			0x23
> > +#define=C2=A0=C2=A0 LED_BLINK_DUR_MASK		GENMASK(15, 0)
> > +
> > +#define LED_ON_CTRL(i)			(0x24 + ((i) * 2))
> > +#define=C2=A0=C2=A0 LED_ON_EVT_MASK		GENMASK(6, 0)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_LINK_1000M		BIT(0)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_LINK_100M		BIT(1)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_LINK_10M		BIT(2)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_LINK_DN		BIT(3)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_FDX		BIT(4)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_HDX		BIT(5)
> > +#define=C2=A0=C2=A0 LED_ON_EVT_FORCE		BIT(6)
> > +#define=C2=A0=C2=A0 LED_ON_POL			BIT(14)
> > +#define=C2=A0=C2=A0 LED_ON_EN			BIT(15)
> > +
> > +#define LED_BLINK_CTRL(i)		(0x25 + ((i) * 2))
> > +#define LED_BLINK_EVT_MASK		GENMASK(9, 0)
> > +#define LED_BLINK_EVT_1000M_TX		BIT(0)
> > +#define LED_BLINK_EVT_1000M_RX		BIT(1)
> > +#define LED_BLINK_EVT_100M_TX		BIT(2)
> > +#define LED_BLINK_EVT_100M_RX		BIT(3)
> > +#define LED_BLINK_EVT_10M_TX		BIT(4)
> > +#define LED_BLINK_EVT_10M_RX		BIT(5)
> > +#define LED_BLINK_EVT_COLLISION		BIT(6)
> > +#define LED_BLINK_EVT_RX_CRC_ERR	BIT(7)
> > +#define LED_BLINK_EVT_RX_IDLE_ERR	BIT(8)
> > +#define LED_BLINK_EVT_FORCE		BIT(9)
> > +
> > +#define AN8801R_NUM_LEDS		3
> > +#define AN8801_PERIOD_SHIFT		15
> > +#define AN8801_PERIOD_UNIT		32768 /* (1 <<
> > AN8801_PERIOD_SHIFT) */
> > +#define AN8801_MAX_PERIOD_MS		2147
> > +
> > +#define LED_BLINK_DURATION_UNIT		780
> > +#define LED_BLINK_DURATION(f)		(LED_BLINK_DURATION_UNIT
> > << (f))
> > +
> > +#define AN8801_LED_DURATION_UNIT_US	32768
> > +
> > +#define AN8801_REG_PHY_INTERNAL0	0x600
> > +#define AN8801_REG_PHY_INTERNAL1	0x601
> > +#define=C2=A0=C2=A0 AN8801_PHY_INTFUNC_MASK	GENMASK(15, 0) /* PHY
> > internal functions */
> > +
> > +enum an8801r_led_fn {
> > +	AN8801R_LED_FN_NONE,
> > +	AN8801R_LED_FN_LINK,
> > +	AN8801R_LED_FN_ACTIVITY,
> > +	AN8801R_LED_FN_MAX,
> > +};
> > +
> > +static int an8801r_read_page(struct phy_device *phydev)
> > +{
> > +	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
> > +}
> > +
> > +static int an8801r_write_page(struct phy_device *phydev, int page)
> > +{
> > +	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
> > +}
> > +
> > +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> > +				=C2=A0=C2=A0=C2=A0 u32 addr, u32 data)
> > +{
> > +	int ret;
> > +
> > +	addr |=3D AN8801_PBUS_ACCESS;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_MODE,
> > MII_MMD_CTRL_ADDR);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
> > upper_16_bits(addr));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
> > lower_16_bits(addr));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH,
> > upper_16_bits(data));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,
> > lower_16_bits(data));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __air_buckpbus_reg_read(struct phy_device *phydev,
> > +				=C2=A0=C2=A0 u32 addr, u32 *data)
> > +{
> > +	int pbus_data_l, pbus_data_h;
> > +	int ret;
> > +
> > +	addr |=3D AN8801_PBUS_ACCESS;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_MODE,
> > MII_MMD_CTRL_ADDR);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH,
> > upper_16_bits(addr));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,
> > lower_16_bits(addr));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
> > +	if (pbus_data_h < 0)
> > +		return pbus_data_h;
> > +
> > +	pbus_data_l =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
> > +	if (pbus_data_l < 0)
> > +		return pbus_data_l;
> > +
> > +	*data =3D (pbus_data_h << 16) | pbus_data_l;
> > +	return 0;
> > +}
> > +
> > +static int air_buckpbus_reg_rmw(struct phy_device *phydev,
> > +				u32 addr, u32 mask, u32 set)
> > +{
> > +	u32 data_old, data_new;
> > +	int prev_page, ret;
> > +
> > +	prev_page =3D phy_select_page(phydev,
> > AIR_PHY_PAGE_EXTENDED_4);
> > +	if (prev_page < 0)
> > +		return prev_page;
> > +
> > +	ret =3D __air_buckpbus_reg_read(phydev, addr, &data_old);
> > +	if (ret)
> > +		return phy_restore_page(phydev, prev_page, ret);
> > +
> > +	data_new =3D data_old & ~mask;
> > +	data_new |=3D set;
> > +	if (data_new !=3D data_old)
> > +		ret =3D __air_buckpbus_reg_write(phydev, addr,
> > data_new);
> > +
> > +	return phy_restore_page(phydev, prev_page, ret);
> > +}
> > +
> > +static int air_buckpbus_reg_set_bits(struct phy_device *phydev,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 u32 addr, u32 mask)
> > +{
> > +	return air_buckpbus_reg_rmw(phydev, addr, mask, mask);
> > +}
> > +
> > +static int air_buckpbus_reg_clear_bits(struct phy_device *phydev,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 addr, u32 mask)
> > +{
> > +	return air_buckpbus_reg_rmw(phydev, addr, mask, 0);
> > +}
> > +
> > +static int air_buckpbus_reg_write(struct phy_device *phydev, u32
> > addr, u32 data)
> > +{
> > +	int prev_page, ret =3D 0;
> > +
> > +	prev_page =3D phy_select_page(phydev,
> > AIR_PHY_PAGE_EXTENDED_4);
> > +	if (prev_page < 0)
> > +		return prev_page;
> > +
> > +	ret =3D __air_buckpbus_reg_write(phydev, addr, data);
> > +
> > +	return phy_restore_page(phydev, prev_page, ret);
> > +}
> > +
> > +static int air_buckpbus_reg_read(struct phy_device *phydev, u32
> > addr, u32 *data)
> > +{
> > +	int prev_page, ret;
> > +
> > +	prev_page =3D phy_select_page(phydev,
> > AIR_PHY_PAGE_EXTENDED_4);
> > +	if (prev_page < 0)
> > +		return prev_page;
> > +
> > +	ret =3D __air_buckpbus_reg_read(phydev, addr, data);
> > +
> > +	return phy_restore_page(phydev, prev_page, ret);
> > +}
> These buckplus accessors look very similar to what's in the existing
> air_en8811h.c
> driver, any chance the code can be shared ?
>=20
The buckpbus accessors functions of air_en8811h driver have indeed very
close function sequences and the defines usages to the ones in the
an8801 patches.
The main difference I see is this patch accessors do an additional
operation by setting AN8801_PBUS_ACCESS bit on the address. But it can
be done another way, so the en8811h accessors can be used without
modifications.
The existing buckpbus accessors seemed also rather generic, in
exception of air_write_buf. It may need to be modified to remove
firmware data type if it needs to be factorized (currently no need for
an8801 code).

For test purposes, I've tried to factorize the air_en8811h reg_read,
reg_write and reg_modify in a common module (similar to the existing
bcm-phy-lib used by Broadcom PHY drivers) and use them in this new
driver.
It seems to work with only a few modifications in the an8801 driver
patch and it removes these new reg_read, reg_write and reg_rmw, and a
dozen of duplicated defines.
The air_phy_read_page/air_phy_write_page implemented by air_en8811h
could also be commonized too.

Would the creation of a new Airoha PHY common module (for instance
air_phy_lib) in separate patches be the right way for this code
factorization? Or is a there an alternative solution?
> [...]
>=20
>=20
> > +static int an8801r_rgmii_rxdelay(struct phy_device *phydev, u16
> > delay_steps)
> > +{
> > +	u32 reg_val;
> > +
> > +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> > +		return -EINVAL;
> > +
> > +	reg_val =3D delay_steps & RGMII_DELAY_STEP_MASK;
> > +	reg_val |=3D RGMII_RXDELAY_ALIGN;
> > +	reg_val |=3D RGMII_RXDELAY_FORCE_MODE;
> > +
> > +	return air_buckpbus_reg_write(phydev,
> > AN8801_BPBUS_REG_RXDLY_STEP,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_val);
> > +}
> > +
> > +static int an8801r_rgmii_txdelay(struct phy_device *phydev, u16
> > delay_steps)
> > +{
> > +	u32 reg_val;
> > +
> > +	if (delay_steps > RGMII_DELAY_STEP_MASK)
> > +		return -EINVAL;
> > +
> > +	reg_val =3D delay_steps & RGMII_DELAY_STEP_MASK;
> > +	reg_val |=3D RGMII_TXDELAY_FORCE_MODE;
> > +
> > +	return air_buckpbus_reg_write(phydev,
> > AN8801_BPBUS_REG_TXDLY_STEP,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_val);
> > +}
> > +
> > +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> > +{
> > +	switch (phydev->interface) {
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		return an8801r_rgmii_txdelay(phydev, 4);
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +		return an8801r_rgmii_rxdelay(phydev, 0);
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +		return an8801r_rgmii_txdelay(phydev, 4);
> > +		return an8801r_rgmii_rxdelay(phydev, 0);
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	default:
> > +		return 0;
> > +	}
>=20
> Can you elaborate on these values for the steps ? Why is it 4 for TX
> internal delays, but 0 for RX delays ?
I tried to find about those values and what they mean.=C2=A0
The values are indeed odd, you would expect something more similar for
both rx and tx.
They come from the downstream drivers (kernel and u-boot as well) that
set them without much explanation.=C2=A0I did not find any info in the data
sheet I have.

I am going to look further into this.

Regards,
Louis-Alexis
>=20
> Maxime

