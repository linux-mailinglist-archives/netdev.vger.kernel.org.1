Return-Path: <netdev+bounces-111089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425E92FD20
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6186728523C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849EE17166D;
	Fri, 12 Jul 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyMqm/d8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C58821;
	Fri, 12 Jul 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796678; cv=none; b=LWMl7HJhwoHbFjKKnIhDChcltRDgaUppuhw/wHym47J+SUpWaF3ZqRmdlAG9bA2YXT8YrPVWnNy7iwc0eXvC73FEFF7HxJd20sbKNCVwcx09Ba0bpWHqdd7oA3iu09pAQeuDHnRhV+3ZH/KPdt0xt8aH4yJLhVjrzLMwgH2PTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796678; c=relaxed/simple;
	bh=z2ecqsPAYASZD2A2evVebbdkkv9mdIYLlaEA6NG5YZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0b4pT2y0OZh6JKvOZtcF2qekj2/YjGRJKbukCZ1tOb4W/cbOHP8v8wLd/QrPMi+hJROkeC2IvvVaIeMuThWu8CfnIZWBGbphF0SMJGM3dEw3QhE+QKcNhxfYOOQaJQ0U9lI41raPwr18fZbPz3jWmZhgWy57Sp7sHNQPTo1f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyMqm/d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA80C32782;
	Fri, 12 Jul 2024 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720796677;
	bh=z2ecqsPAYASZD2A2evVebbdkkv9mdIYLlaEA6NG5YZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyMqm/d8Wna5olkJvQxq07tM1rg4n7CbbqIxreylCwqv58A4WrUdzG1yYdIKyuych
	 4sxAj/rbFSrs/r49THFKj1yOo62cxn2C/BrSic/9vdaJLgAGYZPSemgFt0y1yCTVnX
	 UQz2gAT9fjhCbeGIlZR6dx7DCktrc/9ge+q8jSNqqt0CQdQm5I4bN6ANP4/SyAvvvx
	 hZ+lS3heiz5y/LcOluBHT3WnMScRrQTymM83nRA/hcGFSXnBYuj4RbnaSzrkoD5g4q
	 zrAAprMoAJcd7o9d8w6PfLD343Y0VpoVaEKzJS1jCUj5y9/LTalBP65POWjzdVMf0n
	 M89ueiWOXpsSA==
Date: Fri, 12 Jul 2024 17:04:34 +0200
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
Message-ID: <ZpFGAqM9p-1mGLhM@lore-desk>
References: <cover.1720600905.git.lorenzo@kernel.org>
 <8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
 <20240711181003.4089a633@kernel.org>
 <ZpEz-o1Dkg1gF_ud@lore-desk>
 <20240712072819.4f43062c@kernel.org>
 <ZpFBLkYyMXtMgbA8@lore-desk>
 <20240712080002.37c11d02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FrVz4LyIzcl3psSO"
Content-Disposition: inline
In-Reply-To: <20240712080002.37c11d02@kernel.org>


--FrVz4LyIzcl3psSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 12 Jul 2024 16:43:58 +0200 Lorenzo Bianconi wrote:
> > > On Fri, 12 Jul 2024 15:47:38 +0200 Lorenzo Bianconi wrote: =20
> > > > The Airoha eth SoC architecture is similar to mtk_eth_soc one (e.g =
MT7988a).
> > > > The FrameEngine (FE) module has multiple GDM ports that are connect=
ed to
> > > > different blocks. Current airoha_eth driver supports just GDM1 that=
 is connected
> > > > to a MT7530 DSA switch (I have not posted a tiny patch for mt7530 d=
river yet).
> > > > In the future we will support even GDM{2,3,4} that will connect to =
differ
> > > > phy modues (e.g. 2.5Gbps phy). =20
> > >=20
> > > What I'm confused by is the mentioned of DSA. You put the port in the
> > > descriptor, and there can only be one switch on the other side, right=
? =20
> >=20
> > do you mean fport in msg1 (airoha_dev_xmit())?
> >=20
> > 	fport =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4 : port->id;
> > 	msg1 =3D FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> > 	       ...
> >=20
> > fport refers to the GDM port and not to the dsa user port. Am I missing
> > something?
>=20
> Ooh, I see, reading what you explained previously now makes sense.
> So only 1 of the ports goes to the DSA switch, and the other ones
> are connected to SoC pins? A diagram would be worth a 1000 words ;)

exactly, just GDM1 FE port is connected to the DSA switch.
I will try to do my best for the diagram :)

>=20
> > > be in a setup like this :( It will have no way to figure out the real
> > > egress rate given that each netdev only sees a (non-)random sample
> > > of traffic sharing the queue :( =20
> >=20
> > do you prefer to remove BQL support?
>=20
> No strong preference, I worry it will do more harm than good in
> this case. It's not what it's designed for basically. But without
> testing it's all speculation, so up to you, users can always disable
> using sysfs.

let me take a look to it again but, if it is not harmful, I would prefer
to remove it and add it in the future if necessary.

Regards,
Lorenzo

--FrVz4LyIzcl3psSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZpFGAgAKCRA6cBh0uS2t
rLaaAQCs3Dx/ZbyTEKnvJiV1lXvr4OpdqB5sQ8NeRm0lUoltUAEAm9VJeU8rmV/k
KCyqk8Q9/767CSTrlgZjOh2sG848hQU=
=r6VF
-----END PGP SIGNATURE-----

--FrVz4LyIzcl3psSO--

