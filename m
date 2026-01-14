Return-Path: <netdev+bounces-249925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F13D20BE0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B01403016AC1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5C332903;
	Wed, 14 Jan 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/olIjIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9532E6B7;
	Wed, 14 Jan 2026 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414566; cv=none; b=R9w0l9rQgfNUSIxzrgBoyrC6JRKKzq44WtbglOQwfe7KNDzk9ECebSF6OEPGsSZNq58uNT5daHGOfa1sq/OPl6biyTd2DE4iqR4/mtbmMp1eCSOI1nHSiivYNWk4E/SUJ5wSg6u4ivUzOT6b4/Y9vkeqSZ0bUrj95p9PB/HMmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414566; c=relaxed/simple;
	bh=NluLEF7NMmp3/AgudKp+8aM6MBbaE0n02a0tsv2rEXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBw5bn6sEce42E8hj6c/G7hoH71REsGisKpR30e/5fEsk2OHPWph343F+D7zpN0Q8Wmyw4/ihygS1WoRNvsxoWMUoUvOPY0UkrdGnFYFw4+0ln9T8hQI+zkrskFhZZHzFvl9/LOCcVVs8H8RSkJ9kDSgriBRAZ+Bc3SQP5FQ6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/olIjIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E6DC4CEF7;
	Wed, 14 Jan 2026 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768414565;
	bh=NluLEF7NMmp3/AgudKp+8aM6MBbaE0n02a0tsv2rEXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/olIjIZfEKxE4MnNNIenrvMBsWIKmaBEvhi76I8+nYBWKJ4wMVEXYMsmt7KxT5iz
	 D4oUZoEiWm/h1H9fwxGRQDPKUWoR0gQQrHjh3rC2z2djAGcXB9XL8YcAJ9TylkWzeI
	 s2XegiU5svgbx3ZjQOHdwh0NKcXcBVx2/g7w6v0/snGx0WfhopuTALN9jgjmlWTQ8l
	 nuZzxfzduIcnP7SPo0yVoHjo79AZF3s2uk6ReJF3Nh1BtXEHhdX7lsKrBTMHbJdNsT
	 m1O0sGCSlIqP0AUGkzZ9EruKtbyEyflFsCkk59RsMm7PzjXYdgAF8d2E4CRKbKfqY9
	 uVv/DRs2bcLhw==
Date: Wed, 14 Jan 2026 19:16:03 +0100
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
Message-ID: <aWfdY53PQPcqTpYv@lore-desk>
References: <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXxQL3Vd8nyun2Je"
Content-Disposition: inline
In-Reply-To: <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>


--BXxQL3Vd8nyun2Je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 14, Andrew Lunn wrote:
> On Wed, Jan 14, 2026 at 05:29:28PM +0100, Christian Marangi wrote:
> > On Wed, Jan 14, 2026 at 04:56:02PM +0100, Andrew Lunn wrote:
> > > > > Yes. What you plug into PCI is not a part of this hardware, so ca=
nnot be
> > > > > part of the compatible.
> > > > >=20
> > > >=20
> > > > Thanks for the quick response. Just to make sure Lorenzo doesn't get
> > > > confused, I guess a v3 would be sending v1 again (firmware-names
> > > > implementation series) with the review tag and we should be done wi=
th
> > > > this.
> > >=20
> > > Since this is a PCI device, you can ask it what it is, and then load
> > > the correct firmware based on the PCI vendor:product. You don't need
> > > to describe the hardware in DT because it is enumerable.
> > >=20
> >=20
> > Hi Andrew,
> >=20
> > I think it's problematic to create a bind between the NPU and
> > PCIe.
>=20
> But the NPU must already be bound to PCIe. How else does it know which
> PCIe slot the WiFi card is on, so it can make use of it?

In the current codebase the NPU driver does not need to access the WiFi PCIe
slot (or any other external device) since the offloading (wired and wireles=
s)
is fully managed by the NPU chip (hw + firmware binaries). The NPU driver is
only responsible for loading the proper firmware binaries, configure NPU hw
registers and export APIs for other external chips (e.g. MT76).
IIUC your proposal, we should add a PCIe slot access in the NPU kernel driv=
er in
order to enumerate PCIe Vendor/Device IDs during device probe and load the
proper firmware binaries, right? If so, this approach seems quite more comp=
lex
to me with respect of relying on firmware-name dts property (assuming
firmware-name is a suitable property for this scope). What do you think?

Regards,
Lorenzo

>=20
>      Andrew

--BXxQL3Vd8nyun2Je
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWfdYwAKCRA6cBh0uS2t
rE57AP9zuvgwh7EtMJ2YP09lnx23PG43DiyywAvJ1zCn4QPlywEA/LYdZ976dnCp
U9sh/SlAO7baGe7pcsLNjgLptRArTQY=
=OEKc
-----END PGP SIGNATURE-----

--BXxQL3Vd8nyun2Je--

