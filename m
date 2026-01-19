Return-Path: <netdev+bounces-251049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82AD3A649
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0416C30049EF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725893590CA;
	Mon, 19 Jan 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXtnwdpT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1371359703;
	Mon, 19 Jan 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820878; cv=none; b=UjliAJZbslkC5Rpx0Y9HGz6tUBYg9xNw/OIFrR4qT+t44gWKuNRiGI68dUWDAUKxQp0hQBtvVQwlLXbFs1N1G3+HiaHfyj+3GQGwxNqUNAh7GnGQj86sxOP+gnjO8vvsXqO2Vn1PgNu29j2s7JQLA0E9s0Q8G6HaDaaOv2nS+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820878; c=relaxed/simple;
	bh=XGp1ly3M8msIpsMceEw/gMyV9HMm+0pOXJC/6DgB8Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9k5SsdUI+FM2ID1S2x2m7b4YzrlOI+38bLlu4U4uOMaixaXx8G9eJfWnanyZHpPLJerA3g6HORVqhfZCfYg23jcgb3suCvqQ17f6SrD5xY/jLJaH/jlWbk68cL7wmfY5qx1FyO4fR0s0xv6rXkcn72luzE9bwlu8YxUjd7qhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXtnwdpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BD9C19422;
	Mon, 19 Jan 2026 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768820877;
	bh=XGp1ly3M8msIpsMceEw/gMyV9HMm+0pOXJC/6DgB8Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXtnwdpTpk1JAv2utnVYpbBPUwDSJKup88ycL7YA/UZ0dz/gtOSe0u43Z0Lh0SKeb
	 bPgvkyHxDSsGGDcMr/nklUxpL7oVCSZF8ltacS3gqOrsUEChOAbgbWQ+mzU9iXSr43
	 1IDGSXTCD6HGjI3YGvZ8noHk2g9fh4+4Y2IavFkqMYKpCZxOWGk6klutRiLfllUMl+
	 8z9rTD0boj8lvVHS8BanonmH5BWOat3MqJflGr15O8HBDk2yOW8F9fRX32WUJgFOAu
	 VWuo8I/uskefPRvosrUusEcsGA4ODArNcWrpYMbZblQhiVHOwv4EJDl8E8k+Nb+vRU
	 7jMTmDSPyrsiQ==
Date: Mon, 19 Jan 2026 12:07:55 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <aW4QixwAJHaHWBBc@lore-desk>
References: <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
 <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch>
 <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk>
 <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jQ3aUfoTq/ymejtM"
Content-Disposition: inline
In-Reply-To: <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>


--jQ3aUfoTq/ymejtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Airoha folks reported the NPU hw can't provide the PCIe Vendor/Device I=
D info
> > of the connected WiFi chip.
> > I guess we have the following options here:
> > - Rely on the firmware-name property as proposed in v1
> > - Access the PCIe bus from the NPU driver during probe in order to enum=
erate
> >   the PCIe devices and verify WiFi chip PCIe Vendor/Device ID
> > - During mt76 probe trigger the NPU fw reload if required. This approac=
h would
> >   require adding a new callback in airoha_npu ops struct (please note I=
 have
> >   not tested this approach and I not sure this is really doable).
>=20
> What i'm wondering about is if the PCIe slots are hard coded in the
> firmware.  If somebody builds a board using different slots, they
> would then have different firmware? Or if they used the same slots,
> but swapped around the Ethernet and the WiFi, would it need different
> firmware?

As pointed out by Benjamin, the NPU is a generic Risc-V cpu cluster and it =
is
used to move packets from/to ethernet DMA rings to/from WiFi DMA rings with=
out
involving the host cpu (similar to what we have for MTK with WED module).
I think the PCIe slot info is not necessary for the NPU to work since it is
configured by ethernet (airoha-eth) and wireless drivers (mt76) with DMA ri=
ng
addresses to use via the airoha npu ops APIs, NPU just moves data between t=
he
DMA rings according to my understanding.

>=20
> So is the firmware name a property of the board?

We need to run different binaries on the NPU based on the MT76 WiFi chip
available on the board since the MT76 DMA rings layout changes between MT76=
 SoC
revisions (e.g. Egle MT7996 vs Kite MT7992). In this sense, I agree, the
firmware name is a board property.

>=20
> If the PCIe slots are actually hard coded in the NPU silicon, cannot
> be changed, then we might have a different solution, the firmware name
> might be placed into a .dtsi file, or even hard coded in the driver?

IIUC what you mean here, it seems the solution I proposed in v1 (using
firmware-name property), right?
In this case we can't hard code the firmware name in the NPU driver since
we can't understand the MT76 WiFi chip revision running on the board at
the moment (MT76 would need to provide this info during MT76 probe,
please take a look to the option 3 in my previous email).

>=20
> > What do you think? Which one do you prefer?
>=20
> I prefer to try to extract more information for the Airoha folks. What
> actually defines the firmware? Does the slots used matter? Does it
> matter what device goes in what slots? Is it all hard coded in
> silicon? Is there only one true hardware design and if you do anything
> else your board design is FUBAR, never to be supported?

I think the firmware is defined by the board hw configuration (e.g. MT76
SoC revision) and not by the specific PCIe slot used.
I do not think we have these info hardcoded in the silicon since NPU is a
generic RiscV cpu (this has been confirmed by airoha folks).

Regards,
Lorenzo

>=20
>      Andrew

--jQ3aUfoTq/ymejtM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaW4QiwAKCRA6cBh0uS2t
rHVjAP9ln1d7sXNSxkRsNknfKKihlRjELAPrblwXHVcTQkn0TwD/WBoeIZMbQe9k
Bf2zPPl1UuZ2iwviFi92j0LWHYa8hgs=
=EOBi
-----END PGP SIGNATURE-----

--jQ3aUfoTq/ymejtM--

