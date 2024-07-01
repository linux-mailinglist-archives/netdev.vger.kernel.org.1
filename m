Return-Path: <netdev+bounces-108174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89A91E25C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E3328872E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2933161337;
	Mon,  1 Jul 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0V5ujIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2198C1D;
	Mon,  1 Jul 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843974; cv=none; b=gdw98QHieSPBLHwlXVNDaMsG1wRNoJN1aI771z9Lg69mCgBO6h1u4xVbf7dGRCeAKRBtOv4ZcgPOo5uKwG4FDJ3uUWTE00HhhBaFDdSyR5Ojl6H3cjboF/e64Xpr8l1Ny24xKV5WFoNEuwFsJUxUM9BghYsecitb9EzHoXU9JTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843974; c=relaxed/simple;
	bh=fmwZXCjuj0NA9DjirjyOyzJHTKDit436XbZ/klfs5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOXDDNbnGv0O0olvizSBJ7r2djpE+BTFmprNkftlJE4rEZaqYaQeeM3r503yrlcUyWMyz+q+QZLrKbAn5i9MSQvLEPMNM65bihYs9N0pgLa6mqu1a2rgLTVP2B8mp936DQtvg7sLIaCw+HW8qaA9MhlDjtlfoqSjzhoi88OvSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0V5ujIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F4C116B1;
	Mon,  1 Jul 2024 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843974;
	bh=fmwZXCjuj0NA9DjirjyOyzJHTKDit436XbZ/klfs5Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0V5ujIl+UMTHnRS1kJvkxxqL0rD8NWDHljKyif1AUcIwSWRI/MqGHgmXTJ1t/DKN
	 Q/SeUBn0/RaCHwSRTfaB40Jen7lERYj0HblLXB5jCLeelpabsZhz5UMshA7VKl5uqo
	 LOsFTgmMiPAqhAkkE/Zm6kyMvHMhmxjUEz0sgi7lcEN3jeetfx69pOKAuHkzMTuiWq
	 MNF70XIbh6hhKvojZX0IX9ziSAFYrtY/TPa6j2r9mSetaA88gMR1a8Nl1yriS5HVcU
	 VihZW4auNsWJHVCfyFRUcUmkM7Pp8KqADO93+M8fQOI3AGOs5CqtWebDIlw9JpPBEF
	 UGMjJOSvNGifg==
Date: Mon, 1 Jul 2024 16:26:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <ZoK8glSv-mtNPOLX@lore-desk>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>
 <20240701135319.GE17134@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfGzRyLDChOcgYkO"
Content-Disposition: inline
In-Reply-To: <20240701135319.GE17134@kernel.org>


--yfGzRyLDChOcgYkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jun 29, 2024 at 05:01:38PM +0200, Lorenzo Bianconi wrote:
> > Add airoha_eth driver in order to introduce ethernet support for
> > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > en7581-evb networking architecture is composed by airoha_eth as mac
> > controller (cpu port) and a mt7530 dsa based switch.
> > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > functionalities are supported now) while QDMA is used for DMA operation
> > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > not available yet and it will be added in the future).
> > Currently only hw lan features are available, hw wan will be added with
> > subsequent patches.
> >=20
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> Some minor feedback from my side.

Hi Simon,

>=20
> > +static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
> > +				    u32 clear, u32 set)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (WARN_ON_ONCE(index >=3D ARRAY_SIZE(eth->irqmask)))
> > +		return;
> > +
> > +	spin_lock_irqsave(&eth->irq_lock, flags);
> > +
> > +	eth->irqmask[index] &=3D ~clear;
> > +	eth->irqmask[index] |=3D set;
> > +	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
> > +	/* Read irq_enable register in order to guarantee the update above
> > +	 * completes in the spinlock critical section.
> > +	 */
> > +	airoha_rr(eth, REG_INT_ENABLE(index));
>=20
> airoha_rr() expects an __iomem pointer as it's first argument,
> but the type of eth is struct airoha_eth *eth.
>=20
> Should this be using airoha_qdma_rr() instead?

ack, right. Thx for pointing this out. I will fix it in v5.

>=20
> Flagged by Sparse.
>=20
> > +
> > +	spin_unlock_irqrestore(&eth->irq_lock, flags);
> > +}
>=20
> ...
>=20
> > +static void airoha_ethtool_get_strings(struct net_device *dev, u32 sse=
t,
> > +				       u8 *data)
> > +{
> > +	int i;
> > +
> > +	if (sset !=3D ETH_SS_STATS)
> > +		return;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++) {
> > +		memcpy(data + i * ETH_GSTRING_LEN,
> > +		       airoha_ethtool_stats_name[i], ETH_GSTRING_LEN);
> > +	}
> > +
> > +	data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(airoha_ethtool_stats_name);
> > +	page_pool_ethtool_stats_get_strings(data);
> > +}
>=20
> W=3D1 allmodconfig builds on x86_64 with gcc-13 complain about the use
> of memcpy above because the source is (often?) less than ETH_GSTRING_LEN
> bytes long.
>=20
> I think the preferred solution is to use ethtool_puts(),
> something like this (compile tested only!):
>=20
> @@ -2291,12 +2291,9 @@ static void airoha_ethtool_get_strings(struct net_=
device *dev, u32 sset,
>  	if (sset !=3D ETH_SS_STATS)
>  		return;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++) {
> -		memcpy(data + i * ETH_GSTRING_LEN,
> -		       airoha_ethtool_stats_name[i], ETH_GSTRING_LEN);
> -	}
> +	for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
> +		ethtool_puts(&data, airoha_ethtool_stats_name[i]);
> =20
> -	data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(airoha_ethtool_stats_name);
>  	page_pool_ethtool_stats_get_strings(data);
>  }
> =20

ack, I will fix it in v5.

>=20
> ...
>=20
> > +static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device=
_node *np)
> > +{
> > +	const __be32 *id_ptr =3D of_get_property(np, "reg", NULL);
> > +	struct net_device *dev;
> > +	struct airoha_gdm_port *port;
>=20
> nit: reverse xmas tree

ack, I will fix it in v5.

Regards,
Lorenzo

>=20
> > +	int err, index;
> > +	u32 id;
>=20
> ...
>=20
> --=20
> pw-bot: changes-requested

--yfGzRyLDChOcgYkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoK8ggAKCRA6cBh0uS2t
rDBPAQDur3zFnkAytxa5yij4hb3hCBJQ819Y+tMsR1PMD6423gEAlutApyx/5x3N
LWRCKbrEtI16dofZ1jDxo7xNHCU21Ac=
=HRGl
-----END PGP SIGNATURE-----

--yfGzRyLDChOcgYkO--

