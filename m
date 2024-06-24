Return-Path: <netdev+bounces-106206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2C7915384
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B3E286377
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBED19F492;
	Mon, 24 Jun 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIzhx9HX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9A19D8B3;
	Mon, 24 Jun 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246153; cv=none; b=kOBdMpl8i1KJ4OvstCcQlTKd8OE9I6VVcDLq6mrDkoLCjfDmEa3YIhQJ4glOCdalnt5fQkQ7bx42lCKjvrgo0ROamCVLpB+3vWV35dmKbQXSImcj6w4m+IztcALlCYfZAADYwkib56q0orjKKZlhypmkbzuJ3TIhuuIR9gOfj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246153; c=relaxed/simple;
	bh=4ZpMxaS5rdfRlRw6hjeOyoKnW3JWpq9baxrtUfKgVS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV6Z06h/elzopM+76aefMrBiXmG81xvHxS7VW0fAb8AHgB7nKra15gX5SzF+J+tX9OpGvf6ECHQC9vvXtvko1ISM3HnZ4MNXajHRf5HnWMOcmeAfXkSSxrkXkxoICNWuB7VcjdQDMNpfUzuCyXkwB+fmNaSZ2Dh+6bA1EOhvJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIzhx9HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A6EC2BBFC;
	Mon, 24 Jun 2024 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246152;
	bh=4ZpMxaS5rdfRlRw6hjeOyoKnW3JWpq9baxrtUfKgVS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIzhx9HXY95Sq2hWDaUrCNwGyoj8pJglygTG3nl5gwJqJ/pS5mY6cPjhSeaKiEKNl
	 baGQrKCVsZ/ZooIt3jMgaiRZc4DjgDlIzgshHfNcxE1SAS4vtLzO8Bd1HMrGOupcrc
	 dWW90SK3VeDPtD+wYKSMpHaY3SWGwzD5C6+Nhb4iGPbFINPprCf7M2vSunXYzqpvbH
	 ZTLnyYX3N0PK+QHdT0+i6R4n7rtgPNlMOOUP33DprtiOcR+ugZMVxPbL53zG43evrB
	 i7c3F0TGtsBUavzAKrgpqmrpAGbJc47Qjq7tpUDZfZ968OslI1/pK6+XdefVb0fDsR
	 oq5uRpo3L4HYw==
Date: Mon, 24 Jun 2024 18:22:28 +0200
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
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZnmdRIXoZ_Unt8sg@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <Zni13uFslHz5R6Ns@lore-desk>
 <e203100f-7bdd-4512-8a05-9a33476db488@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZDUgRKanLZnz6KNf"
Content-Disposition: inline
In-Reply-To: <e203100f-7bdd-4512-8a05-9a33476db488@lunn.ch>


--ZDUgRKanLZnz6KNf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 24, 2024 at 01:55:10AM +0200, Lorenzo Bianconi wrote:
> > > > +static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
> > > > +				    u32 port, u32 queue, u32 val)
> > > > +{
> > > > +	u32 orig_val, tmp, all_rsv, fq_limit;
> > > > +	const u32 pse_port_oq_id[] =3D {
> > > > +		PSE_PORT0_QUEUE,
> > > > +		PSE_PORT1_QUEUE,
> > > > +		PSE_PORT2_QUEUE,
> > > > +		PSE_PORT3_QUEUE,
> > > > +		PSE_PORT4_QUEUE,
> > > > +		PSE_PORT5_QUEUE,
> > > > +		PSE_PORT6_QUEUE,
> > > > +		PSE_PORT7_QUEUE,
> > > > +		PSE_PORT8_QUEUE,
> > > > +		PSE_PORT9_QUEUE,
> > > > +		PSE_PORT10_QUEUE
> > > > +	};
> > >=20
> > > > +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	/* hw misses PPE2 oq rsv */
> > > > +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> > > > +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> > > > +
> > > > +	for (i =3D 0; i < PSE_PORT0_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> > > > +	for (i =3D 0; i < PSE_PORT1_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> > > > +
> > > > +	for (i =3D 6; i < PSE_PORT2_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> > > > +
> > > > +	for (i =3D 0; i < PSE_PORT3_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);
> > >=20
> > > Code like this is making me wounder about the split between MAC
> > > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > > pure switchdev driver?
> >=20
> > airoha_eth driver implements just MAC features (FE and QDMA). Currently=
 we only
> > support the connection to the DSA switch (GDM1). EN7581 SoC relies on m=
t7530 driver
> > for DSA (I have not posted the patch for mt7530 yet, I will do after ai=
roha_eth
> > ones).
> =20
> > airoha_fe_oq_rsv_init() (we can improve naming here :) is supposed to c=
onfigure
> > hw pre-allocated memory for each queue available in Packet Switching En=
gine
> > (PSE) ports. PSE ports are not switch ports, but SoC internal ports use=
d to
> > connect PSE to different modules. In particular, we are currently imple=
menting
> > just the two connections below:
> > - CDM1 (port0) connects PSE to QDMA1
> > - GDM1 (port1) connects PSE to MT7530 DSA switch
> >=20
> > In the future we will post support for GDM2, GDM3 and GDM4 ports that a=
re
> > connecting PSE to exteranl PHY modules.
>=20
> Is the PSE involved in WiFi? When you come to implement NAT offload,
> etc, will that depend on the PSE?
>=20

Frame Engine architecture (Packet Switching Engine - PSE + Packet Processing
Engine - PPE) is similar to mtk_eth_soc driver (but register map and QDMA l=
ayer
are different). FE is used to define offload traffic rules (e.g. forwarding
between GDM interfaces or NAT rules).  Even in mtk_eth_soc frame engine cod=
ebase
is part of MAC driver. So far we do not support offloading rules, but we wi=
ll
do in the future. In order to support WiFI offload rules, FE requires a dif=
ferent
module/driver (NPU) similar to WED for mtk_eth_soc.
The mac - switch architecture is the same to the one used for MT7988a [0].
So far we support we support just gmac0 (that is connected to the switch).
In the future I will add support for gmac1 as well.

Regards,
Lorenzo

[0] https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/li=
nux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a.dtsi;h=3D9ad068=
fe05fc52bf1edc28d7dba4e162f30a0eb8;hb=3DHEAD

> Figure 9-1 of MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf clearly
> shows the PSE outside of the GMAC. I'm just wondering if the PSE
> should be a driver, or library, of its own, which is then shared by
> users, rather than being embedded in the MAC driver?


>=20
>        Andrew

--ZDUgRKanLZnz6KNf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnmdRAAKCRA6cBh0uS2t
rMlmAP47F4WR3g5V41OqUkOJCurFJ6mLtMJb3XqtcyEd7WyTtQD/cig/9RMqs2pV
Yvf98MUzi5MT5vlmlw/zATKLgR8PyAk=
=xY2O
-----END PGP SIGNATURE-----

--ZDUgRKanLZnz6KNf--

