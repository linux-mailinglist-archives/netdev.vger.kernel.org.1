Return-Path: <netdev+bounces-191619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D367ABC803
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4F118924CF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E921322B;
	Mon, 19 May 2025 19:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFF1EA7C9;
	Mon, 19 May 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684310; cv=none; b=a28qfRx1P5keDWwDPrcdFeedlJ37CKIRH0SujM9vkkYDVdthtnjqrjENGwSHa4DtTplngaG1sYTxU5XxzTb7R+zZwgageeN0HdSH2StUqSrdZF1o+Ns/x75qJ3vC1cAZQj5Dmq9IueGvw4sMg441W2QMssoJ2LbGyLfe1+IODqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684310; c=relaxed/simple;
	bh=d5+GpqYlRnvy9j99rtBZRRfevga+7sc0qw0iNVxAEAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqz9iAJBy3GcmgMcfu5odK8zhfj6YUkuaVxh/ahQpC2Bw8P6IOP08WMjze6iail4/5wydO7QWHPE5zgZVITXjhGotY/YnSwoegoPU6jIihtEcwAny1qfx/Vx104cY7/Ue/YXTeUCSh3Vd9uLYpr2CyP6FWheXu+oU8/ElH80fSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 2BB801F00056;
	Mon, 19 May 2025 19:51:37 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 1D950AC2AF1; Mon, 19 May 2025 19:51:36 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 9BE1CAC2AED;
	Mon, 19 May 2025 19:51:32 +0000 (UTC)
Date: Mon, 19 May 2025 21:51:30 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] net: dwmac-sun8i: Use parsed internal PHY address
 instead of 1
Message-ID: <aCuLwuSliICh86SP@collins>
References: <20250519164936.4172658-1-paulk@sys-base.io>
 <d89565fc-e338-4a58-b547-99f5ae87b559@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VL1tc0gaoDiGu1D4"
Content-Disposition: inline
In-Reply-To: <d89565fc-e338-4a58-b547-99f5ae87b559@lunn.ch>


--VL1tc0gaoDiGu1D4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your reply.

Le Mon 19 May 25, 21:25, Andrew Lunn a =C3=A9crit :
> On Mon, May 19, 2025 at 06:49:36PM +0200, Paul Kocialkowski wrote:
> > While the MDIO address of the internal PHY on Allwinner sun8i chips is
> > generally 1, of_mdio_parse_addr is used to cleanly parse the address
> > from the device-tree instead of hardcoding it.
> >=20
> > A commit reworking the code ditched the parsed value and hardcoded the
> > value 1 instead, which didn't really break anything but is more fragile
> > and not future-proof.
> >=20
> > Restore the initial behavior using the parsed address returned from the
> > helper.
> >=20
> > Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/exter=
nal MDIOs")
> > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
>=20
> Have you validated all .dts files using this binding? Any using
> anything other than 1? The problem with silly bugs like this is that
> there might be DT blobs with the value 42 which currently work, but
> will break as soon as this patch lands.

There's actually only two users of this (this code path for internal PHYs is
only used by two chips), which are platform dtsi files that have the address
already set to 1.

I have actually tested both with hardware and they work fine.

> Just stating in the commit message you have checked will help get the
> patch merged.

Do you think it's worth resending? I'd be fine with adding this when picking
up the patch:

The internal PHY is only found on the H3/H5 and V3s/V3/S3 chips which alrea=
dy
have the same address properly described in their platform device-tree and
were verified to work after this patch.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--VL1tc0gaoDiGu1D4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmgri8IACgkQhP3B6o/u
lQxmxQ//buEL628Aci5cGp43IOq18Bzcz4AqwqiGwgLeInHX5XL/j7iKqm3Snxvw
EgF1CVwszdRfg7wt/C6HaIQiz1VX4HtfvwY11oQNR3gom2gTzIzLsEqYiC+ZbLAf
zx5h38nsM47Yml4gxXLfXp3YcKgdSZzUePvTgkoI4ScCFRUaUxW8fDUOILDEnR6D
vpjbp+qXjuA3lFWpREr2OztgOr/BxNMu/g2KVvuuSRtRXxPsesjls2mtXkimrmB+
2kUDz/s83L50iCLbnmVY0Ac6D6V4G3DIpXwI8EcssnzA9nQmnnZ3d6X4tBQU+3Eh
G1hZfgWzMg7p7F09cHOqpoflvAyuPeU9LAdHVjgP3oAcK5Zredbtha8mVMOz8JFF
JMF99vrBfcq0W0uUPvOu0bW9IoC/rSlilHURibBPNbzZRq318pk8i6CMozIv9CD6
a3+fH69JxziH+jYNSKtPl8uNLsZM0o4QLVCQZYiY8ep8ZgodDsjtb5uCGzULedR2
UMhu7eYKXJPU3777swOzakEcW6k0ZHRVgit2hA2xLLbCBm7fWNeaDhxQAIta0kPh
fZCFJQ1ChcNM+aJ0/GhkUDZvurax7mBW19qXemer587wPHSqjwKYsZldU+jhChXe
9tE6Njmq5MqsrBQe3olAmyePoVYKQrqqDLr9aCiXLTS6ewf+jUo=
=lDrU
-----END PGP SIGNATURE-----

--VL1tc0gaoDiGu1D4--

