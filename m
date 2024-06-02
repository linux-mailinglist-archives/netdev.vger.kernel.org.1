Return-Path: <netdev+bounces-100028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2F8D783B
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 23:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A91C209B1
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1C6F06A;
	Sun,  2 Jun 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNLfVEaK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8051DDEE;
	Sun,  2 Jun 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717362957; cv=none; b=JarYUjLe4q85avvT8x8QUEGwSEGNqpqz629ffFYyUUdk5UcHMMf0tZH+jAL/GAAaIL2gZW8CG1KeGXpZVYpxipxLp0NdLKzVr4x1bC9Gg6d7qyY/5a7ofqI6aGn8dxQ9yvKYwE7IsXN3CwluTYwUhsCW7jB/0H8rmmOr3VILXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717362957; c=relaxed/simple;
	bh=M++0u+W4mK9MwYmOrRySBBS5cDRDB0dQj/1G68qhDeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H22x4GmbuKMR+8x81R2sLpMJhAj1puaUPnf2lnBGkJj9REZr1glKyHXUc3aSBNRYLjz7WK3gANgWZtKLj+55s+cLLCYnebzGiBEg6ylRHTBs4XHvkkGeAtKckVtzXACVZS0DUTxItxQk+UNvsWsdFNHRa6e8UCJlwc4BNDYJzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNLfVEaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27B9C2BBFC;
	Sun,  2 Jun 2024 21:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717362957;
	bh=M++0u+W4mK9MwYmOrRySBBS5cDRDB0dQj/1G68qhDeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNLfVEaKnI0TueS9xy+9VunvGyupBFb2V3bBfXXaV496NCJri1NXODSAiVx2tPQYZ
	 32wLJzDznfWZ0IQzquJtWZIrNcnhADuR85cIs5XrogX74zjMLsq8+wpnyZ2heYxrdf
	 DZ+IddJSYRa2tYH/fkvpgETA8zAUYnrq0+Z/Q45l1Zj54tnDeEWU4iRCkBfyuTyLge
	 UupdbbKqemzgvJVYXQESqdophOoBrC3S79VzmRKixJEC3R8XLBsZPE6+uwAnXmimKq
	 EKJbwllt1PTXgr6cIax/SIIkhNNqmpfC7N2aTehd+iQIbTMp6ra3UA9c07z+AKjwHO
	 L+xrcDJzK6Jig==
Date: Sun, 2 Jun 2024 23:15:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <ZlzhCVO7WCGyYMi9@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
 <c3207c89-2d4e-4e92-8822-f6a1f7d64e06@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CZ+A1N2g01IXv6oZ"
Content-Disposition: inline
In-Reply-To: <c3207c89-2d4e-4e92-8822-f6a1f7d64e06@lunn.ch>


--CZ+A1N2g01IXv6oZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static int airoha_set_gdma_port(struct airoha_eth *eth, int port, bool=
 enable)
> > +{
> > +	u32 vip_port, cfg_addr, val =3D enable ? FE_DP_PPE : FE_DP_DROP;
> > +
> > +	switch (port) {
> > +	case 0:
> > +		vip_port =3D BIT(22);
> > +		cfg_addr =3D REG_GDM3_FWD_CFG;
> > +		break;
> > +	case 1:
> > +		vip_port =3D BIT(23);
> > +		cfg_addr =3D REG_GDM3_FWD_CFG;
> > +		break;
> > +	case 2:
> > +		vip_port =3D BIT(25);
> > +		cfg_addr =3D REG_GDM4_FWD_CFG;
> > +		break;
> > +	case 4:
> > +		vip_port =3D BIT(24);
> > +		cfg_addr =3D REG_GDM4_FWD_CFG;
> > +		break;
>=20
> Please add some #defines for the BIT(), so there is descriptive
> names. Please do the same other places you have BIT macros, it makes
> the code easier to understand.

ack, I will do in v2

>=20
> > +static int airoha_set_gdma_ports(struct airoha_eth *eth, bool enable)
> > +{
> > +	const int port_list[] =3D { 0, 1, 2, 4 };
> > +	int i;
>=20
> Maybe add a comment about port 3?
>=20
> > +static void airoha_fe_vip_setup(struct airoha_eth *eth)
> > +{
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(3), 0x8863); /* ETH->PPP (0x8863) */
>=20
> Rather than a comment, use ETH_P_PPP_DISC

ack, I will do in v2

>=20
> > +	airoha_fe_wr(eth, REG_FE_VIP_EN(3), PATN_FCPU_EN_MASK | PATN_EN_MASK);
> > +
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(4), 0xc021); /* PPP->LCP (0xc021) */
>=20
> PPP_LCP

ack, I will do in v2
>=20
> > +	airoha_fe_wr(eth, REG_FE_VIP_EN(4),
> > +		     PATN_FCPU_EN_MASK | FIELD_PREP(PATN_TYPE_MASK, 1) |
> > +		     PATN_EN_MASK);
> > +
> > +	airoha_fe_wr(eth, REG_FE_VIP_PATN(6), 0x8021); /* PPP->IPCP (0x8021) =
*/
>=20
> PPP_IPCP
>=20
> etc...

ack, I will do in v2

>=20
> > +static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
> > +{
> > +	struct airoha_eth *eth =3D q->eth;
> > +	struct device *dev =3D eth->net_dev->dev.parent;
> > +	int qid =3D q - &eth->q_rx[0], nframes =3D 0;
>=20
> Reverse Christmass tree. Which means you will need to move some of the
> assignments into the body of the function.

ack, I will fix it in v2
>=20
> > +static int airoha_dev_open(struct net_device *dev)
> > +{
> > +	struct airoha_eth *eth =3D netdev_priv(dev);
> > +	int err;
> > +
> > +	if (netdev_uses_dsa(dev))
> > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > +	else
> > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
>=20
> Does this imply the hardware can be used in a situation where it is
> not connected to a switch? Does it have an MII and MDIO bus? Could a
> PHY be connected? If it can be used as a conventional NIC, we need to
> ensure there is a path to use usage without an ABI breakage.

I tested the driver removing the dsa switch from the board dts and
resetting the switch at bootstrap in order to erase uboot running
configuration.  Doing so the driver works fine.
Moreover, I will add in the future connections to different phys through
GDM{2,3,4} ports (so far we support just GDM1 that is connected the mt7530
switch).

>=20
> > +static int airoha_register_debugfs(struct airoha_eth *eth)
> > +{
> > +	eth->debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> > +	if (IS_ERR(eth->debugfs_dir))
> > +		return PTR_ERR(eth->debugfs_dir);
>=20
> No error checking should be performed with debugfs calls. Just keep
> going and it will work out O.K.

ack, I will fix it in v2

>=20
> > +	err =3D of_get_ethdev_address(np, dev);
> > +	if (err) {
> > +		if (err =3D=3D -EPROBE_DEFER)
> > +			return err;
> > +
> > +		eth_hw_addr_random(dev);
> > +		dev_err(&pdev->dev, "generated random MAC address %pM\n",
> > +			dev->dev_addr);
>=20
> dev_info() would be better here, since it is not considered an error.

ack, I will fix it in v2

>=20
> > +	err =3D airoha_hw_init(eth);
> > +	if (err)
> > +		return err;
> > +
> > +	airoha_qdma_start_napi(eth);
> > +	err =3D register_netdev(dev);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D airoha_register_debugfs(eth);
> > +	if (err)
> > +		return err;
> > +
> > +	platform_set_drvdata(pdev, eth);
>=20
> Is this required? As soon as you call register_netdev(), the device is
> live and in use. It can be sending the first packets before the
> function returns. So if anything needs this connection between the
> platform data and the eth, it will not be in place, and bad things
> will happen.

it is used just in the remove callback but I can move it before
register_netdev() and I will set it to NULL in case of error.

>=20
> > +static inline void airoha_qdma_start_napi(struct airoha_eth *eth)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> > +		napi_enable(&eth->q_tx_irq[i].napi);
> > +
> > +	airoha_qdma_for_each_q_rx(eth, i)
> > +		napi_enable(&eth->q_rx[i].napi);
> > +}
> > +
> > +static inline void airoha_qdma_stop_napi(struct airoha_eth *eth)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> > +		napi_disable(&eth->q_tx_irq[i].napi);
> > +
> > +	airoha_qdma_for_each_q_rx(eth, i)
> > +		napi_disable(&eth->q_rx[i].napi);
> > +}
>=20
> These seem off to be in a header file?

ack, I will move them in .c.

Regards,
Lorenzo

>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--CZ+A1N2g01IXv6oZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZlzhCQAKCRA6cBh0uS2t
rJzgAP47/O83h3iZRAN8AD3fUFvOiXbzDbxdVq8TOzN/nZawpwEA2gLE1PXnxaej
ySKZz7YXr26pru9cq6r6ZjwHESA61gU=
=5+65
-----END PGP SIGNATURE-----

--CZ+A1N2g01IXv6oZ--

