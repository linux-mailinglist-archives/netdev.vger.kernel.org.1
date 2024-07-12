Return-Path: <netdev+bounces-111082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B792FCCE
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE54EB2233E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5E172780;
	Fri, 12 Jul 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSSlDL+8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6B171E66;
	Fri, 12 Jul 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795442; cv=none; b=aeGsr+NpprDr2zL+7nHuiynQPry8HbDS+6PNUJcwb5Q4XzYuxYdtmHIoGNZwwUBb5wTWmXuSbDIyu/JeYGVt1mqGBxnhsVSJ/Y+MiaTR0mvErDIpKsekrpgJCO5Ci73fdueDNOcyzkPXhiKxj/G+OXdFR8eUx8FkFS0uoKvgBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795442; c=relaxed/simple;
	bh=gQpcwRC4/5FOc0wtnFuFaFYMiezq8FgesboB2PnlK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCY2Lu8ShhwkJ1qjBJl1Wp6pUmWGzbMNOlUZioFL+VBKHpg8e5FzygSNiZiXj/J06hkwir/jpbHj7CdrIUD6IysuJ+Fa1sygWlHFgG5LCYC9BpS4neVBb4pzHcD3SqSP2nczw2Zvl8foXBtSvUcGk7Pq5uSN8XfIbGSL3yCa8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSSlDL+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1EAC32782;
	Fri, 12 Jul 2024 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720795441;
	bh=gQpcwRC4/5FOc0wtnFuFaFYMiezq8FgesboB2PnlK5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSSlDL+8jcdA+6v+7PTfFZZxuk1p6MlG68olCJ+eiGtUoVZfyJC4ixqeKvs6jlUXA
	 HtbATap21mYNt89iRlxy187d1/iRPoLrOVxsIzIUAtL9H2t0ioyOfECxjWEBTwrzDV
	 F9VFFTmvMNsFdIcr3O8bMw1tzekXQpL2qNLK5Z1QAAkOL8NNjjVwauVB7KZiz2Oz0X
	 xFj8AqRttM7WYqMPXtWHV7EitiQ5cGTPj1WOqPFfgADUNfuNUgI6PhSK/4E4G4VhSN
	 E5IfqIEzWYgpSf6Wnep75A/t+uj8e0gYuJ5izO/mA3+YJP54sbqF0F/YM3op6DEJCD
	 HMW1IFvPGSSZw==
Date: Fri, 12 Jul 2024 16:43:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZpFBLkYyMXtMgbA8@lore-desk>
References: <cover.1720600905.git.lorenzo@kernel.org>
 <8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
 <20240711181003.4089a633@kernel.org>
 <ZpEz-o1Dkg1gF_ud@lore-desk>
 <20240712072819.4f43062c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pk218n7yoGNpiOvl"
Content-Disposition: inline
In-Reply-To: <20240712072819.4f43062c@kernel.org>


--Pk218n7yoGNpiOvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 12 Jul 2024 15:47:38 +0200 Lorenzo Bianconi wrote:
> > > On Wed, 10 Jul 2024 10:47:41 +0200 Lorenzo Bianconi wrote: =20
> > > > Add airoha_eth driver in order to introduce ethernet support for
> > > > Airoha EN7581 SoC available on EN7581 development board (en7581-evb=
).
> > > > en7581-evb networking architecture is composed by airoha_eth as mac
> > > > controller (cpu port) and a mt7530 dsa based switch.
> > > > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > > > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just bas=
ic
> > > > functionalities are supported now) while QDMA is used for DMA opera=
tion
> > > > and QOS functionalities between mac layer and the dsa switch (hw Qo=
S is
> > > > not available yet and it will be added in the future).
> > > > Currently only hw lan features are available, hw wan will be added =
with
> > > > subsequent patches. =20
> > >=20
> > > It seems a bit unusual for DSA to have multiple ports, isn't it?
> > > Can you explain how this driver differs from normal DSA a little=20
> > > more in the commit message? =20
> >=20
> > The Airoha eth SoC architecture is similar to mtk_eth_soc one (e.g MT79=
88a).
> > The FrameEngine (FE) module has multiple GDM ports that are connected to
> > different blocks. Current airoha_eth driver supports just GDM1 that is =
connected
> > to a MT7530 DSA switch (I have not posted a tiny patch for mt7530 drive=
r yet).
> > In the future we will support even GDM{2,3,4} that will connect to diff=
er
> > phy modues (e.g. 2.5Gbps phy).
>=20
> What I'm confused by is the mentioned of DSA. You put the port in the
> descriptor, and there can only be one switch on the other side, right?

do you mean fport in msg1 (airoha_dev_xmit())?

	fport =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4 : port->id;
	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
	       ...

fport refers to the GDM port and not to the dsa user port. Am I missing
something?

>=20
> > > > +	q =3D &eth->q_tx[qid];
> > > > +	if (WARN_ON_ONCE(!q->ndesc))
> > > > +		goto error;
> > > > +
> > > > +	spin_lock_bh(&q->lock);
> > > > +
> > > > +	nr_frags =3D 1 + sinfo->nr_frags;
> > > > +	if (q->queued + nr_frags > q->ndesc) {
> > > > +		/* not enough space in the queue */
> > > > +		spin_unlock_bh(&q->lock);
> > > > +		return NETDEV_TX_BUSY; =20
> > >=20
> > > no need to stop the queue? =20
> >=20
> > reviewing this chunk, I guess we can get rid of it since we already blo=
ck the
> > txq at the end of airoha_dev_xmit() if we do not have enough space for =
the next
> > packet:
> >=20
> > 	if (q->ndesc - q->queued < q->free_thr)
> > 		netif_tx_stop_queue(txq);
>=20
> But @q is shared in your case isn't it? Unless we walk and stop all
> ports this won't save us. Coincidentally not sure how useful BQL can

Oh, right. We can theoretically have a packet from another netdevice for the
same hw queue. I will stop the queue in this case.

> be in a setup like this :( It will have no way to figure out the real
> egress rate given that each netdev only sees a (non-)random sample
> of traffic sharing the queue :(

do you prefer to remove BQL support?

Regards,
Lorenzo

>=20
>=20

--Pk218n7yoGNpiOvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZpFBLQAKCRA6cBh0uS2t
rHUHAP4knlEt2n1t0dzUJot3WgTREMFLojM+Pw+fV4mSJnsEbgD8CL+Xt9qs82vT
CuPBYjdhCYsa55y/5dtDnLHPdvqoYgk=
=Vu+r
-----END PGP SIGNATURE-----

--Pk218n7yoGNpiOvl--

