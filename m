Return-Path: <netdev+bounces-178228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D072EA75C2B
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4703A67B2
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F691DE2DF;
	Sun, 30 Mar 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Slbl9iyV"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB781C5F14;
	Sun, 30 Mar 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743366053; cv=none; b=b2hRfig+12Fr8ItPONXvPujUAnXoHfFZVMApQ664HOB9M2rqb5TVf9xVyqzVRx34y4rSoqBL+MV6ZNJVn8jmq/FChD4PRUS1/+4zNa0YrK8dda8pf2fIuF0Us5XDfHqB15zwcrednniX5mtc9d+wPT1LuEdSXxi7rT+ZRGqf5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743366053; c=relaxed/simple;
	bh=VuJyhXvIdR31kViKDRwAlQRkPIjGeSspTeWSLk6qi80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stxV3WPhcH3oPlbuy0W1IGUN7uy3cKn9x6+kKVlQgMtNxsCKzYCQYHUeMJ7uCMNNgZ29AJqHLA7ECCfPmcM7Xv+/HYh5lEIuV1RPcqm/tFiZsDpo1We2OdCWxko2cVaUEfhNVzbXZrxHkey0A3fL/THIX/E3ruEN0goVTDILoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Slbl9iyV; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E15C8102F66E1;
	Sun, 30 Mar 2025 22:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743366048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8qJ/Rut3ZHfnX40lpR7WWvNRDKHga3tSKw8W4V695Yg=;
	b=Slbl9iyVxOXJxEcoUX1qkrsvorT7y2qFt6c07mfIaD2XN3hYXacXuixYXxRjAF+/IyE7Sj
	pQtxCpZWkMyysL2BTrQZR2Gy/z/nMIECfg7RKor0fQ6Qfec1q3zRLbQJx67jbg773HEsqX
	kHWmEY50/j3o03lxFlBESTiUXRIA1EzP9cIW6kF/AbRzZtJ43DYTxWNlgXDccoiBprG+5d
	arYWA2UTQgpXbnrtKvWQuOyhc2WhXU3tz6hej9BP1cxZgCafGw6hZ6PU9Auhuk6WYcKFAQ
	vdgrN+c0/Gu7aVEfdzL1cjDuI3Fcbkz8p3nvwmKPtU8GDNzzdup0dVBk1//65A==
Date: Sun, 30 Mar 2025 22:20:41 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <20250330222041.10fb8d3d@wsk>
In-Reply-To: <3648e94f-93e6-4fb0-a432-f834fe755ee3@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-5-lukma@denx.de>
	<3648e94f-93e6-4fb0-a432-f834fe755ee3@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vWAwGI9Y0xok4baHReqdjuN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/vWAwGI9Y0xok4baHReqdjuN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +static bool bridge_offload;
> > +module_param(bridge_offload, bool, 0644); /* Allow setting by root
> > on boot */ +MODULE_PARM_DESC(bridge_offload, "L2 switch offload
> > mode enable:1, disable:0"); =20
>=20
> Please drop. module parameters are not liked.
>=20

Ok.

> In Linux, ports of a switch always starting in isolated mode, and
> userspace needs to add them to the same bridge.

Ok.

>=20
> > +
> > +static netdev_tx_t mtip_start_xmit(struct sk_buff *skb,
> > +				   struct net_device *dev);
> > +static void mtip_switch_tx(struct net_device *dev);
> > +static int mtip_switch_rx(struct net_device *dev, int budget, int
> > *port); +static void mtip_set_multicast_list(struct net_device
> > *dev); +static void mtip_switch_restart(struct net_device *dev, int
> > duplex0,
> > +				int duplex1); =20
>=20
> Forwards references are not like. Put the functions in the correct
> order so they are not needed.

Ok.

>=20
> > +/* Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
> > + * It omits the final shift in of 8 zeroes a "normal" CRC would do
> > + * (getting the remainder).
> > + *
> > + *  Examples (hexadecimal values):<br>
> > + *   10-11-12-13-14-15  =3D> CRC=3D0xc2
> > + *   10-11-cc-dd-ee-00  =3D> CRC=3D0xe6
> > + *
> > + *   param: pmacaddress
> > + *          A 6-byte array with the MAC address.
> > + *          The first byte is the first byte transmitted
> > + *   return The 8-bit CRC in bits 7:0
> > + */
> > +static int crc8_calc(unsigned char *pmacaddress)
> > +{
> > +	/* byte index */
> > +	int byt;
> > +	/* bit index */
> > +	int bit;
> > +	int inval;
> > +	int crc; =20
>=20
> Reverse Christmas tree. Please look through the whole driver and fix
> it up.

Ok.

>=20
> > +/* updates MAC address lookup table with a static entry
> > + * Searches if the MAC address is already there in the block and
> > replaces
> > + * the older entry with new one. If MAC address is not there then
> > puts a
> > + * new entry in the first empty slot available in the block
> > + *
> > + * mac_addr Pointer to the array containing MAC address to
> > + *          be put as static entry
> > + * port     Port bitmask numbers to be added in static entry,
> > + *          valid values are 1-7
> > + * priority The priority for the static entry in table
> > + *
> > + * return 0 for a successful update else -1  when no slot
> > available =20
>=20
> It would be nice to turn this into proper kerneldoc. It is not too far
> away at the moment.
>=20
> Also, return a proper error code not -1. ENOSPC?

Ok.

>=20
> > +static int mtip_update_atable_dynamic1(unsigned long write_lo,
> > +				       unsigned long write_hi, int
> > block_index,
> > +				       unsigned int port,
> > +				       unsigned int curr_time,
> > +				       struct switch_enet_private
> > *fep) =20
>=20
> It would be good to document the return value, because it is not the
> usual 0 success or negative error code.

Ok.

>=20
> > +static const struct net_device_ops mtip_netdev_ops; =20
>=20
> more forward declarations.

Ok, fixed.

>=20
> > +struct switch_enet_private *mtip_netdev_get_priv(const struct
> > net_device *ndev) +{
> > +	if (ndev->netdev_ops =3D=3D &mtip_netdev_ops)
> > +		return netdev_priv(ndev);
> > +
> > +	return NULL;
> > +} =20
>=20
> I _think_ the return value is not actually used. So maybe 0 or
> -ENODEV?

It is used at:
drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c in
mtip_port_dev_check()

to assess if network interfaces eligible for bridging are using the
same (i.e. mtipl2sw) driver.

Only when they match - bridging is performed.

>=20
> > +static int esw_mac_addr_static(struct switch_enet_private *fep)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		if (is_valid_ether_addr(fep->ndev[i]->dev_addr)) {
> > =20
>=20
> Is that possible? This is the interfaces own MAC address? If it is not
> valid, the probe should of failed.

I've double checked it - this cannot happen (i.e. that
is_valid_ether_addr(fep->ndev[i]->dev_addr) is NOT valid at this point
of execution.

I will remove this check

>=20
> > +			mtip_update_atable_static((unsigned char *)
> > +
> > fep->ndev[i]->dev_addr,
> > +						  7, 7, fep);
> > +		} else {
> > +			dev_err(&fep->pdev->dev,
> > +				"Can not add mac address %pM to
> > switch!\n",
> > +				fep->ndev[i]->dev_addr);
> > +			return -EFAULT;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtip_print_link_status(struct phy_device *phydev)
> > +{
> > +	if (phydev->link)
> > +		netdev_info(phydev->attached_dev,
> > +			    "Link is Up - %s/%s - flow control
> > %s\n",
> > +			    phy_speed_to_str(phydev->speed),
> > +			    phy_duplex_to_str(phydev->duplex),
> > +			    phydev->pause ? "rx/tx" : "off");
> > +	else
> > +		netdev_info(phydev->attached_dev, "Link is
> > Down\n"); +} =20
>=20
> phy_print_status()

Yes, I will remove mtip_print_link_status() and replace it with
phy_print_status()

>=20
> > +static void mtip_adjust_link(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct phy_device *phy_dev;
> > +	int status_change =3D 0, idx;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags);
> > +
> > +	idx =3D priv->portnum - 1;
> > +	phy_dev =3D fep->phy_dev[idx];
> > +
> > +	/* Prevent a state halted on mii error */
> > +	if (fep->mii_timeout && phy_dev->state =3D=3D PHY_HALTED) {
> > +		phy_dev->state =3D PHY_UP;
> > +		goto spin_unlock;
> > +	} =20
>=20
> A MAC driver should not be playing around with the internal state of
> phylib.

Ok, I've replaced it with PHY API calls (phy_start() and
phy_is_started()).

>=20
> > +static int mtip_mii_probe(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	int port_idx =3D priv->portnum - 1;
> > +	struct phy_device *phy_dev =3D NULL;
> > +
> > +	if (fep->phy_np[port_idx]) {
> > +		phy_dev =3D of_phy_connect(dev,
> > fep->phy_np[port_idx],
> > +					 &mtip_adjust_link, 0,
> > +
> > fep->phy_interface[port_idx]);
> > +		if (!phy_dev) {
> > +			netdev_err(dev, "Unable to connect to
> > phy\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	phy_set_max_speed(phy_dev, 100);
> > +	fep->phy_dev[port_idx] =3D phy_dev;
> > +	fep->link[port_idx] =3D 0;
> > +	fep->full_duplex[port_idx] =3D 0;
> > +
> > +	dev_info(&dev->dev,
> > +		 "MTIP PHY driver [%s] (mii_bus:phy_addr=3D%s,
> > irq=3D%d)\n",
> > +		 fep->phy_dev[port_idx]->drv->name,
> > +		 phydev_name(fep->phy_dev[port_idx]),
> > +		 fep->phy_dev[port_idx]->irq); =20
>=20
> phylib already prints something like that.

Yes, the=20
"net lan0: lan0: MTIP eth L2 switch <mac addr>"=20

is printed.

For the original call - I've used dev_dbg().

>=20
> > +static int mtip_mdiobus_reset(struct mii_bus *bus)
> > +{
> > +	if (!bus || !bus->reset_gpiod) {
> > +		dev_err(&bus->dev, "Reset GPIO pin not
> > provided!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	gpiod_set_value_cansleep(bus->reset_gpiod, 1);
> > +
> > +	/* Extra time to allow:
> > +	 * 1. GPIO RESET pin go high to prevent situation where
> > its value is
> > +	 *    "LOW" as it is NOT configured.
> > +	 * 2. The ENET CLK to stabilize before GPIO RESET is
> > asserted
> > +	 */
> > +	usleep_range(200, 300);
> > +
> > +	gpiod_set_value_cansleep(bus->reset_gpiod, 0);
> > +	usleep_range(bus->reset_delay_us, bus->reset_delay_us +
> > 1000);
> > +	gpiod_set_value_cansleep(bus->reset_gpiod, 1);
> > +
> > +	if (bus->reset_post_delay_us > 0)
> > +		usleep_range(bus->reset_post_delay_us,
> > +			     bus->reset_post_delay_us + 1000);
> > +
> > +	return 0;
> > +} =20
>=20
> What is wrong with the core code __mdiobus_register() which does the
> bus reset.

The main problem is that the "default" mdio reset is just asserting and
deasserting the reset line.

It doesn't take into account the state of the reset gpio before
assertion (if it was high for enough time) and if clocks already
were stabilized.

>=20
> > +static void mtip_get_drvinfo(struct net_device *dev,
> > +			     struct ethtool_drvinfo *info)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +
> > +	strscpy(info->driver, fep->pdev->dev.driver->name,
> > +		sizeof(info->driver));
> > +	strscpy(info->version, VERSION, sizeof(info->version)); =20
>=20
> Leave this empty, so you get the git hash of the kernel.

Ok.

>=20
> > +static void mtip_ndev_setup(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +
> > +	ether_setup(dev); =20
>=20
> That is pretty unusual

Yes - how it has been used is described below.

>=20
> > +	dev->ethtool_ops =3D &mtip_ethtool_ops;
> > +	dev->netdev_ops =3D &mtip_netdev_ops;
> > +
> > +	memset(priv, 0, sizeof(struct mtip_ndev_priv)); =20
>=20
> priv should already be zero....

Ok, I will remove

>=20
> > +static int mtip_ndev_init(struct switch_enet_private *fep)
> > +{
> > +	struct mtip_ndev_priv *priv;
> > +	int i, ret =3D 0;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		fep->ndev[i] =3D alloc_netdev(sizeof(struct
> > mtip_ndev_priv),
> > +					    fep->ndev_name[i],
> > NET_NAME_USER,
> > +					    mtip_ndev_setup); =20
>=20
> This explains the ether_setup(). It would be more normal to pass
> ether_setup() here, and set dev->ethtool_ops and dev->netdev_ops here.
>=20

Yes. I will do that.

> > +		if (!fep->ndev[i]) {
> > +			ret =3D -1; =20
>=20
> -ENOMEM?

Ok.

>=20
> > +			break;
> > +		}
> > +
> > +		priv =3D netdev_priv(fep->ndev[i]);
> > +		priv->fep =3D fep;
> > +		priv->portnum =3D i + 1;
> > +		fep->ndev[i]->irq =3D fep->irq;
> > +
> > +		ret =3D mtip_setup_mac(fep->ndev[i]);
> > +		if (ret) {
> > +			dev_err(&fep->ndev[i]->dev,
> > +				"%s: ndev %s MAC setup err: %d\n",
> > +				__func__, fep->ndev[i]->name, ret);
> > +			break;
> > +		}
> > +
> > +		ret =3D register_netdev(fep->ndev[i]);
> > +		if (ret) {
> > +			dev_err(&fep->ndev[i]->dev,
> > +				"%s: ndev %s register err: %d\n",
> > __func__,
> > +				fep->ndev[i]->name, ret);
> > +			break;
> > +		}
> > +		dev_info(&fep->ndev[i]->dev, "%s: MTIP eth L2
> > switch %pM\n",
> > +			 fep->ndev[i]->name,
> > fep->ndev[i]->dev_addr); =20
>=20
> I would drop this. A driver is normally silent unless things go wrong.

I've replaced dev_info() with dev_dbg() as this information may be
relevant during development.

>=20
> > +	}
> > +
> > +	if (ret)
> > +		mtip_ndev_cleanup(fep);
> > +
> > +	return 0; =20
>=20
> return ret?

Ok.

>=20
> > +static int mtip_ndev_port_link(struct net_device *ndev,
> > +			       struct net_device *br_ndev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +
> > +	dev_dbg(&ndev->dev, "%s: ndev: %s br: %s fep: 0x%x\n",
> > +		__func__, ndev->name,  br_ndev->name, (unsigned
> > int)fep); +
> > +	/* Check if MTIP switch is already enabled */
> > +	if (!fep->br_offload) {
> > +		if (!priv->master_dev)
> > +			priv->master_dev =3D br_ndev; =20
>=20
> It needs to be a little bit more complex than that, because the two
> ports could be assigned to two different bridges. You should only
> enable hardware bridging if they are a member of the same bridge.

This has been explained earlier.
The mtip_port_dev_check() checks in mtip_netdevice_event() if we use
ports from the mtipl2sw driver.

Only for them we start the bridge.

>=20
> 	Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/vWAwGI9Y0xok4baHReqdjuN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfpp5kACgkQAR8vZIA0
zr3Y8wgAtt7ywyWSLp1k/aqspwIG10tmdL5JUHvlWWJfzZxAmyphVsYNrnfSy5gA
VrcWKFXvhPiaxG2ZLsK59cNFLiFSa2SWi0fHE0DU7NyBWHfoaFITx9W9/z7Icmbe
3Jn8LtQl122bPIAkfTcMFgpyC9GZeN51PkiKNCsd88jC82IQzb04qViyB2y/tSFW
qLJK4K2Qi0vCVPsSZL0TUCm4Wm4gdOAaBDPARge7roRYXVqlzK+7ALHFcTCx0Etk
Mg8lWRizQe9IvR1vN/PrkJGDfNgI3GSfs4vIr4FG0EXFMkfm8nZ/slY0lkQvDVdK
Hh7IDp4Kf24dy1ycK+R2+5weZ/rLVA==
=w4+p
-----END PGP SIGNATURE-----

--Sig_/vWAwGI9Y0xok4baHReqdjuN--

