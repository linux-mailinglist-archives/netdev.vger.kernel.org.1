Return-Path: <netdev+bounces-180783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C09A827DA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02741B845D1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C925E81E;
	Wed,  9 Apr 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BUOI5u4N"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C06A47;
	Wed,  9 Apr 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208947; cv=none; b=dECQ1bI+2ilG6M64CcDsExLAYqqT5m5LkW9nLfkvdOsZnY+ngmMGdCu9aGJzGNBrmQOMqif/t3l+uVVxSw+EpMqNurGUx/xQpCwVcqZLyqeOCd7+yzRUK+OJQiaN9GE29AwpFsm05cJ95BvnYuxmx9mFdlrltbNWA6Hsd+rEMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208947; c=relaxed/simple;
	bh=DY5hr/N79Zj8jPciVFTpI3C4aMEkV1Ymqa3zJVQ4klA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq3cPk8PqVj9ipkrJEaif7KSiMVBEL+WnmmkZN1JU98YgJMJFsKJ3FeQNYpwl3HsHyN7ZgUmGhtBK+dfOKXVkNJhdEDYDNBXtlmaeyNv65pzHeiHmjYTBr1hvu9JuDwSNXc6tChqe1T40Lp1WPkNjeI9VHs/bRVWkCc6M705EsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BUOI5u4N; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DEDD102EB98D;
	Wed,  9 Apr 2025 16:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744208941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LsvOV40rHLHEO52M3MfyuhChr2LG3bnILrU9gU+hjVA=;
	b=BUOI5u4Nz4QAKa223h8Jo/UxWNb/XU4MK3bBv4zNnM1ZsW16drAvqFRxZZXxVIw3k2LGku
	jdhi6ipcYTDKmLwcDCBEEEE/6F7jywUB3ghtGFrw6Y0SB7izpIWgSnprVlD9anRVcoiGvW
	Xd8KqfVpmiQgNg0ScUk99aiEIMcGwIkJBBoyBToO/wgnBjrIb/vbYBzUXLYVodWVohp2e9
	Aa/yXU8+5Pan4ZLYcJsi7X9V1h2/0qL3yv7KgZ+pTd2KfkEX5kjslUIg0qz+/tae+fJQfn
	BjW9F1f9KWA3ohtSlfnn1+3D3PwSSuDA/zePSt0t4LwuI2nYOvflDGr90vuMnA==
Date: Wed, 9 Apr 2025 16:28:54 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250409162854.069abe88@wsk>
In-Reply-To: <20250408151447.GX395307@horms.kernel.org>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-5-lukma@denx.de>
	<20250408151447.GX395307@horms.kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dNduXPY5UY6jbpqt=Tj7eFz";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/dNduXPY5UY6jbpqt=Tj7eFz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> On Mon, Apr 07, 2025 at 04:51:56PM +0200, Lukasz Majewski wrote:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >=20
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >=20
> > It can be used interchangeably with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >=20
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data to/form switch (and then switch sends them to
> > respecitive ports).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Hi Lukasz,
>=20
> This is not a complete review, but I did spend a bit of time
> looking over this and have provided some feedback on
> things I noticed below.
>=20

Thanks for your feedback.

> ...
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > b/drivers/net/ethernet/freescale/mtipsw/Kconfig new file mode 100644
> > index 000000000000..450ff734a321
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config FEC_MTIP_L2SW
> > +	tristate "MoreThanIP L2 switch support to FEC driver"
> > +	depends on OF
> > +	depends on NET_SWITCHDEV
> > +	depends on BRIDGE
> > +	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
> > +	help
> > +	  This enables support for the MoreThan IP L2 switch on
> > i.MX
> > +	  SoCs (e.g. iMX28, vf610). It offloads bridging to this
> > IP block's
> > +	  hardware and allows switch management with standard
> > Linux tools.
> > +	  This switch driver can be used interchangeable with the
> > already
> > +	  available FEC driver, depending on the use case's
> > requirments. =20
>=20
> nit: requirements
>=20
> Flagged by checkpatch.pl --codespell
>=20

Ok.

> ...
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c =20
>=20
> ...
>=20
> > +static void mtip_enet_init(struct switch_enet_private *fep, int
> > port) +{
> > +	void __iomem *enet_addr =3D fep->enet_addr;
> > +	u32 mii_speed, holdtime, tmp; =20
>=20
> I think it would be best to avoid variable names like tmp which have
> little meaning. Although still rather generic, perhaps reg would be
> more appropriate. Or better still something relating to the name the
> register, say rcr.

Ok, I will use reg/rcr instead of tmp.

>=20
> > +
> > +	if (port =3D=3D 2)
> > +		enet_addr +=3D MCF_ESW_ENET_PORT_OFFSET;
> > +
> > +	tmp =3D MCF_FEC_RCR_PROM | MCF_FEC_RCR_MII_MODE |
> > +		MCF_FEC_RCR_MAX_FL(1522);
> > +
> > +	if (fep->phy_interface[port - 1]  =3D=3D
> > PHY_INTERFACE_MODE_RMII)
> > +		tmp |=3D MCF_FEC_RCR_RMII_MODE;
> > +
> > +	writel(tmp, enet_addr + MCF_FEC_RCR);
> > +
> > +	/* TCR */
> > +	writel(MCF_FEC_TCR_FDEN, enet_addr + MCF_FEC_TCR);
> > +
> > +	/* ECR */
> > +	writel(MCF_FEC_ECR_ETHER_EN, enet_addr + MCF_FEC_ECR);
> > +
> > +	/* Set MII speed to 2.5 MHz
> > +	 */
> > +	mii_speed =3D DIV_ROUND_UP(clk_get_rate(fep->clk_ipg),
> > 5000000);
> > +	mii_speed--;
> > +
> > +	/* The i.MX28 and i.MX6 types have another filed in the
> > MSCR (aka
> > +	 * MII_SPEED) register that defines the MDIO output hold
> > time. Earlier
> > +	 * versions are RAZ there, so just ignore the difference
> > and write the
> > +	 * register always.
> > +	 * The minimal hold time according to IEE802.3 (clause 22)
> > is 10 ns.
> > +	 * HOLDTIME + 1 is the number of clk cycles the fec is
> > holding the
> > +	 * output.
> > +	 * The HOLDTIME bitfield takes values between 0 and 7
> > (inclusive).
> > +	 * Given that ceil(clkrate / 5000000) <=3D 64, the
> > calculation for
> > +	 * holdtime cannot result in a value greater than 3.
> > +	 */
> > +	holdtime =3D DIV_ROUND_UP(clk_get_rate(fep->clk_ipg),
> > 100000000) - 1; +
> > +	fep->phy_speed =3D mii_speed << 1 | holdtime << 8;
> > +
> > +	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
> > +}
> > +
> > +static int mtip_setup_mac(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned char *iap, tmpaddr[ETH_ALEN]; =20
>=20
> Maybe mac_addr instead of tmpaddr.

Ok.

>=20
> > +
> > +	/* Use MAC address from DTS */
> > +	iap =3D &fep->mac[priv->portnum - 1][0];
> > +
> > +	/* Use MAC address set by bootloader */
> > +	if (!is_valid_ether_addr(iap)) {
> > +		*((unsigned long *)&tmpaddr[0]) =3D
> > +			be32_to_cpu(readl(fep->enet_addr +
> > MCF_FEC_PALR));
> > +		*((unsigned short *)&tmpaddr[4]) =3D
> > +			be16_to_cpu(readl(fep->enet_addr +
> > +					  MCF_FEC_PAUR) >> 16); =20
>=20
> * Above, and elsewhere in this patch unsigned long seems to be
>   used for 32 bit values. But unsigned long can be 64 bits wide.
>=20

As fair as I know - from the outset - this driver had some implicit
assumption to be used on 32 bit SoCs (imx28, vf610).

As a result the unsigned long would be 32 bits.

On the other hand - the documentation clearly says that registers in
this IP block implementation are 32 bit wide.

>   I would suggest using u32, u16, and friends throughout this
>   patch where an integer has a specific number of bits.
>=20

I think that values, which directly readl()/writel() values from the
registers shall be u32. However, more generic code could use int/
unsigned int though.

> * readl returns a 32-bit value in host byte order.
>   But the above assumes it returns a big endian value.
>=20
>   This does not seem correct.
>=20

Please consult similar implementation from fec_main.c:
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/ethernet/free=
scale/fec_main.c#L2044

I would use the same approach as in the above link.

> * The point immediately above aside, the assignment of
>   host byte order values to the byte-array tmpaddr
>   seems to assume an endianness (little endian?).
>=20
>   It should work on either endian.
>=20

I guess that implementation from above link is the correct one.

> > +		iap =3D &tmpaddr[0];
> > +	}
> > +
> > +	/* Use random MAC address */
> > +	if (!is_valid_ether_addr(iap)) {
> > +		eth_hw_addr_random(dev);
> > +		dev_info(&fep->pdev->dev, "Using random MAC
> > address: %pM\n",
> > +			 dev->dev_addr);
> > +		iap =3D (unsigned char *)dev->dev_addr;
> > +	}
> > +
> > +	/* Adjust MAC if using macaddr (and increment if needed) */
> > +	eth_hw_addr_gen(dev, iap, priv->portnum - 1);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * crc8_calc - calculate CRC for MAC storage
> > + *
> > + * @pmacaddress: A 6-byte array with the MAC address. The first
> > byte is
> > + *               the first byte transmitted.
> > + *
> > + * Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
> > + * It omits the final shift in of 8 zeroes a "normal" CRC would do
> > + * (getting the remainder).
> > + *
> > + *  Examples (hexadecimal values):<br>
> > + *   10-11-12-13-14-15  =3D> CRC=3D0xc2
> > + *   10-11-cc-dd-ee-00  =3D> CRC=3D0xe6
> > + *
> > + * Return: The 8-bit CRC in bits 7:0
> > + */
> > +static int crc8_calc(unsigned char *pmacaddress) =20
>=20
> Can lib/crc8.c:crc8() be used here?

This seems a bit problematic, as the above code is taken from the
vendor driver.

The documentation states - that the hash uses CRC-8 with following
polynomial:

x^8 + x^2 + x + 1 (0x07), which shall correspond to available in Linux:

static unsigned char mac1[] =3D {0x10, 0x11, 0x12, 0x13, 0x14, 0x15};
crc8_populate_msb(mtipl2sw_crc8_table, 0x07);
crc8(mtipl2sw_crc8_table, mac1, sizeof(mac1), CRC8_INIT_VALUE);

However, those results don't match (either with 0xFF and 0x00 as the
initial value).

I've also searched the Internet to compare different CRC
implementations used in field:
https://crccalc.com/?crc=3D0x10 0x11 0x12 0x13 0x14
0x15&method=3DCRC-8&datatype=3Dhex&outtype=3Dhex

they also doesn't match results from this code.

Hence, the question - which implementation is right?

Vendor developer could have known a bit more than we do, so I would
prefer to keep this code as is - especially that switch internally may
use this crc8 calculation to find proper "slot/index" in the atable.

>=20
> > +{
> > +	int byt; /* byte index */
> > +	int bit; /* bit index */
> > +	int crc =3D 0x12;
> > +	int inval;
> > +
> > +	for (byt =3D 0; byt < 6; byt++) {
> > +		inval =3D (((int)pmacaddress[byt]) & 0xff);
> > +		/* shift bit 0 to bit 8 so all our bits
> > +		 * travel through bit 8
> > +		 * (simplifies below calc)
> > +		 */
> > +		inval <<=3D 8;
> > +
> > +		for (bit =3D 0; bit < 8; bit++) {
> > +			/* next input bit comes into d7 after
> > shift */
> > +			crc |=3D inval & 0x100;
> > +			if (crc & 0x01)
> > +				/* before shift  */
> > +				crc ^=3D 0x1c0;
> > +
> > +			crc >>=3D 1;
> > +			inval >>=3D 1;
> > +		}
> > +	}
> > +	/* upper bits are clean as we shifted in zeroes! */
> > +	return crc;
> > +}
> > +
> > +static void mtip_read_atable(struct switch_enet_private *fep, int
> > index,
> > +			     unsigned long *read_lo, unsigned long
> > *read_hi) +{
> > +	unsigned long atable_base =3D (unsigned long)fep->hwentry;
> > +
> > +	*read_lo =3D readl((const void *)atable_base + (index << 3));
> > +	*read_hi =3D readl((const void *)atable_base + (index << 3)
> > + 4); +} =20
>=20
> It is unclear why hwentry, which is a pointer, is being cast to an
> integer and then back to a pointer. I see pointer arithmetic, but
> that can operate on pointers just as well as integers, without making
> assumptions about how wide pointers are with respect to longs.
>=20
> And in any case, can't the types be used to directly access the
> offsets needed like this?
>=20
> 	atable =3D fep->hwentry.mtip_table64b_entry;
>=20
> 	*read_lo =3D readl(&atable[index].lo);
> 	*read_hi =3D readl(&atable[index].hi);
>=20

The code as is seems to be OK.

The (atable) memory structure is as follows:

1. You can store 2048 MAC addresses (2x32 bit each).

2. Memory from point 1 is addressed as follows:
	2.1 -> from MAC address the CRC8 is calculated (0x00 - 0xFF).
	This is the 'index' in the original code.
	2.2 -> as it may happen that for two different MAC address the
	same CRC8 is calculated (i.e. 'index' is the same), each
	'index' can store 8 entries for MAC addresses (and it is
	searched in a linear way if needed).

IMHO, the index above shall be multiplied by 8.

> Also, and perhaps more importantly, readl expects to be passed
> a pointer to __iomem. But the appropriate annotations seem
> to be missing (forcing them with a cast is not advisable here IMHO).
>=20

I think that the code below:
unsigned long atable_base =3D (unsigned long)fep->hwentry;

could be replaced with
void __iomem *atable_base =3D fep->hwentry;

and the (index << 3) with (index * ATABLE_ENTRY_PER_SLOT)

> Please do run sparse over your patches to iron out __iomem
> (and endian) issues.
>=20

Ok, I will run the make C=3D1 when compiling.

> > +
> > +static void mtip_write_atable(struct switch_enet_private *fep, int
> > index,
> > +			      unsigned long write_lo, unsigned
> > long write_hi) +{
> > +	unsigned long atable_base =3D (unsigned long)fep->hwentry;
> > +
> > +	writel(write_lo, (void *)atable_base + (index << 3));
> > +	writel(write_hi, (void *)atable_base + (index << 3) + 4); =20
>=20
> Likewise here.

Please see the above comment.

>=20
> > +} =20
>=20
> ...
>=20
> > +/* Clear complete MAC Look Up Table */
> > +void mtip_clear_atable(struct switch_enet_private *fep)
> > +{
> > +	int index;
> > +
> > +	for (index =3D 0; index < 2048; index++)
> > +		mtip_write_atable(fep, index, 0, 0);
> > +}
> > +
> > +/**
> > + * mtip_update_atable_static - Update switch static address table
> > + *
> > + * @mac_addr: Pointer to the array containing MAC address to
> > + *            be put as static entry
> > + * @port:     Port bitmask numbers to be added in static entry,
> > + *            valid values are 1-7
> > + * @priority: The priority for the static entry in table =20
>=20
> @fep should also be documented here.
>=20

OK.

> Flagged by ./scripts/kernel-doc -none
> and W=3D1 builds.
>=20
> > + *
> > + * Updates MAC address lookup table with a static entry.
> > + *
> > + * Searches if the MAC address is already there in the block and
> > replaces
> > + * the older entry with the new one. If MAC address is not there
> > then puts
> > + * a new entry in the first empty slot available in the block.
> > + *
> > + * Return: 0 for a successful update else -ENOSPC when no slot
> > available
> > + */
> > +static int mtip_update_atable_static(unsigned char *mac_addr,
> > unsigned int port,
> > +				     unsigned int priority,
> > +				     struct switch_enet_private
> > *fep) =20
>=20
> ...
>=20
> > +/* During a receive, the cur_rx points to the current incoming
> > buffer.
> > + * When we update through the ring, if the next incoming buffer has
> > + * not been given to the system, we just set the empty indicator,
> > + * effectively tossing the packet.
> > + */
> > +static int mtip_switch_rx(struct net_device *dev, int budget, int
> > *port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct switch_t *fecp =3D fep->hwp;
> > +	unsigned short status, pkt_len;
> > +	struct net_device *pndev;
> > +	u8 *data, rx_port =3D 0xFF;
> > +	struct ethhdr *eth_hdr;
> > +	int pkt_received =3D 0;
> > +	struct sk_buff *skb;
> > +	unsigned long flags;
> > +	struct cbd_t *bdp;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags);
> > +
> > +	/* First, grab all of the stats for the incoming packet.
> > +	 * These get messed up if we get called due to a busy
> > condition.
> > +	 */
> > +	bdp =3D fep->cur_rx;
> > +
> > +	while (!((status =3D bdp->cbd_sc) & BD_ENET_RX_EMPTY)) { =20
>=20
> ...
>=20
> > +	} /* while (!((status =3D bdp->cbd_sc) & BD_ENET_RX_EMPTY))
> > */ +
> > +	writel(bdp, &fep->cur_rx); =20
>=20
> I'm confused buy this.
>=20
> At the top of this function, bdp is assigned using:
>=20
> 	bdp =3D fep->cur_rx;
>=20
> But here writel() is used to assign bdp to &fep->cur_rx.
> Which assumes that bdp is a 32-bit little endian value.
> But it is a pointer in host byte order which may be wide than 32-bits.
>=20
> On x86_64 int is 32-bits while pointers are 64 bits.

I will cross compile with make W=3D1 and C=3D1 to find all problematic
places.

> W=3D1 builds with gcc 14.2.0 flag this problem like this:
>=20
>=20
> .../mtipl2sw.c:1108:9: error: incompatible pointer to integer
> conversion passing 'struct cbd_t *' to parameter of type 'unsigned
> int' [-Wint-conversion] 1108 |         writel(bdp, &fep->cur_rx); |
>              ^~~
>=20
>=20
> This also assumes that &fep->cur_rx is a pointer to __iomem,
> but that does not seem to be the case.

The writel(bdp, &fep->cur_rx); shall be just replaced with fep->cur_rx
=3D bdp.

Thanks for spotting.

>=20
> > +	spin_unlock_irqrestore(&fep->hw_lock, flags);
> > +
> > +	return pkt_received;
> > +} =20
>=20
> ...
>=20
> > +static int __init mtip_switch_dma_init(struct switch_enet_private
> > *fep) +{
> > +	struct cbd_t *bdp, *cbd_base;
> > +	int ret, i;
> > +
> > +	/* Check mask of the streaming and coherent API */
> > +	ret =3D dma_set_mask_and_coherent(&fep->pdev->dev,
> > DMA_BIT_MASK(32));
> > +	if (ret < 0) {
> > +		dev_err(&fep->pdev->dev, "No suitable DMA
> > available\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Allocate memory for buffer descriptors */
> > +	cbd_base =3D dma_alloc_coherent(&fep->pdev->dev, PAGE_SIZE,
> > &fep->bd_dma,
> > +				      GFP_KERNEL);
> > +	if (!cbd_base)
> > +		return -ENOMEM;
> > +
> > +	/* Set receive and transmit descriptor base */
> > +	fep->rx_bd_base =3D cbd_base;
> > +	fep->tx_bd_base =3D cbd_base + RX_RING_SIZE;
> > +
> > +	/* Initialize the receive buffer descriptors */
> > +	bdp =3D fep->rx_bd_base;
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		bdp->cbd_sc =3D 0;
> > +		bdp++;
> > +	}
> > +
> > +	/* Set the last buffer to wrap */
> > +	bdp--;
> > +	bdp->cbd_sc |=3D BD_SC_WRAP;
> > +
> > +	/* ...and the same for transmmit */ =20
>=20
> nit: transmit

Ok.

>=20
> > +	bdp =3D fep->tx_bd_base;
> > +	for (i =3D 0; i < TX_RING_SIZE; i++) {
> > +		/* Initialize the BD for every fragment in the
> > page */
> > +		bdp->cbd_sc =3D 0;
> > +		bdp->cbd_bufaddr =3D 0;
> > +		bdp++;
> > +	}
> > +
> > +	/* Set the last buffer to wrap */
> > +	bdp--;
> > +	bdp->cbd_sc |=3D BD_SC_WRAP;
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		if (fep->ndev[i]) {
> > +			unregister_netdev(fep->ndev[i]);
> > +			free_netdev(fep->ndev[i]);
> > +		}
> > +	}
> > +} =20
>=20
> ...
>=20
> > +static const struct of_device_id mtipl2_of_match[] =3D {
> > +	{ .compatible =3D "nxp,imx28-mtip-switch",
> > +	  .data =3D &mtip_imx28_l2switch_info},
> > +	{ /* sentinel */ }
> > +} =20
>=20
> There should be a trailing ';' on the line above.
>=20

+1

> ...
>=20
> > +struct  addr_table64b_entry { =20
>=20
> One space after struct is enough.
>=20
> > +	unsigned int lo;  /* lower 32 bits */
> > +	unsigned int hi;  /* upper 32 bits */
> > +};
> > +
> > +struct  mtip_addr_table_t { =20
>=20
> I think you can drop the '_t' from the name of this struct.
> We know it is a type :)

Ok.

>=20
> > +	struct addr_table64b_entry  mtip_table64b_entry[2048]; =20
>=20
> One space is enough after addr_table64b_entry.
> And in general, unless the aim is to align field names
> (not here because there is only one field :)
>=20
> > +};
> > +
> > +#define MCF_ESW_LOOKUP_MEM_OFFSET      0x4000
> > +#define MCF_ESW_ENET_PORT_OFFSET      0x4000
> > +#define ENET_SWI_PHYS_ADDR_OFFSET	0x8000 =20
>=20
> Ditto.
>=20

+1

> ...
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c =20
>=20
> > new file mode 100644
> > index 000000000000..0b76a60858a5
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  L2 switch Controller driver for MTIP block - bridge network
> > interface
> > + *
> > + *  Copyright (C) 2025 DENX Software Engineering GmbH
> > + *  Lukasz Majewski <lukma@denx.de>
> > + */
> > +
> > +#include <linux/netdevice.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "mtipl2sw.h" =20
>=20
> Blank line here please.
>=20

Ok.

> > +static int mtip_ndev_port_link(struct net_device *ndev,
> > +			       struct net_device *br_ndev,
> > +			       struct netlink_ext_ack *extack)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev),
> > *other_priv;
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct net_device *other_ndev;
> > +
> > +	/* Check if one port of MTIP switch is already bridged */
> > +	if (fep->br_members && !fep->br_offload) {
> > +		/* Get the second bridge ndev */
> > +		other_ndev =3D fep->ndev[fep->br_members - 1];
> > +		other_priv =3D netdev_priv(other_ndev);
> > +		if (other_priv->master_dev !=3D br_ndev) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "L2 offloading only
> > possible for the same bridge!");
> > +			return notifier_from_errno(-EOPNOTSUPP);
> > +		}
> > +
> > +		fep->br_offload =3D 1;
> > +		mtip_switch_dis_port_separation(fep);
> > +		mtip_clear_atable(fep);
> > +	}
> > +
> > +	if (!priv->master_dev)
> > +		priv->master_dev =3D br_ndev;
> > +
> > +	fep->br_members |=3D BIT(priv->portnum - 1);
> > +
> > +	dev_dbg(&ndev->dev,
> > +		"%s: ndev: %s br: %s fep: 0x%x members: 0x%x
> > offload: %d\n",
> > +		__func__, ndev->name,  br_ndev->name, (unsigned
> > int)fep, =20
>=20
> Perhaps it would be best to use %p as the format specifier for fep
> and not cast it.
>=20
> On x86_64 int is 32-bits while pointers are 64 bits.
> W=3D1 builds with gcc 14.2.0 flag this problem like this:
>=20
> .../mtipl2sw_br.c:45:55: warning: cast from pointer to integer of
> different size [-Wpointer-to-int-cast] 45 |                 __func__,
> ndev->name,  br_ndev->name, (unsigned int)fep, |
>                                  ^

Ok.

>=20
> > +		fep->br_members, fep->br_offload);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void mtip_netdevice_port_unlink(struct net_device *ndev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +
> > +	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n",
> > __func__,
> > +		ndev->name, fep->br_members);
> > +
> > +	fep->br_members &=3D ~BIT(priv->portnum - 1);
> > +	priv->master_dev =3D NULL;
> > +
> > +	if (!fep->br_members) {
> > +		fep->br_offload =3D 0;
> > +		mtip_switch_en_port_separation(fep);
> > +		mtip_clear_atable(fep);
> > +	}
> > +} =20
>=20
> ...
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/dNduXPY5UY6jbpqt=Tj7eFz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf2hCYACgkQAR8vZIA0
zr2eWggAnGaPnum/oDc9V7qV5DGHw6FRQcrvaw74UOyG0zMT9ozngRyzM0MDhXRa
4ax8CFkyfUp7XmffyYlhE1S7iSec4hSCf2CFb+yTfKKO2hKBrU7DYLYyN7AMy8gK
EI9PE6n2k4pJS9XpU9aN5LOWCVgy33jSrwDKZBUtOAaMN9iomoFsFUOk1ooc99Q9
g3Su044eov6gxiKibN8mtv5S9imrPIBUdLuNASbejZG4ChXv4sQLjiWpoMSP9RSE
EZGzKqVSXtUo02Qm8ZZtnjLcp+FufjfbEbfdwq/aPWZj5lZvnFuOt4lKflaj4YOT
Qafg2fTOqthKpwSsPn5uhqsaHnJU0w==
=R/iR
-----END PGP SIGNATURE-----

--Sig_/dNduXPY5UY6jbpqt=Tj7eFz--

