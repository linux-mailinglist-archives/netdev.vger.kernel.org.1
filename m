Return-Path: <netdev+bounces-99080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6BB8D3A4B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6ADAB2550D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3697217F38B;
	Wed, 29 May 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibMzuFMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F7717F36E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995289; cv=none; b=tlqWz+fdm4rOjCzniVLg2bzScYqgXQrqePSrGOo4LqlS6ixYHzEAD9Okxv5y96y5BoM/izGSwiVy2rSDNFLC+GabjPKWgMw4y3sUdwsZgnXUa7wtV/qTnUsehmbOXp0RNa5FiIjWDQDwSunSa90qiGo6Ndh18cU4BpX9uZyr7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995289; c=relaxed/simple;
	bh=s7ps87vVMx2pZPlwmX1rES59yV6+9ATQata99PWEn08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoS+/V7Nx/TU/p49R1p0E2N3RA9/H4tIITP8D5rAc1SOpMbVlYEZ2goLzKeAgwr5oYYzd6QCGJX3iq6koNdFxohzSN6+SKbstvrNfadLs8yaVorpY0izN2bI2SIOFX4026R728YtyArE2igA6/DWZ6Q36UETH2NQYMPnU/PKEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibMzuFMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D8FC32782;
	Wed, 29 May 2024 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995288;
	bh=s7ps87vVMx2pZPlwmX1rES59yV6+9ATQata99PWEn08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibMzuFMTCM+AQiG5i8eWDBciUQ23hxUTJF7vdNWCjI8/jV0NK/q9Mehp6YnJuNnZj
	 0WVcg60MMuEtmDrcbvinf+xjsw4wMjPqOksOzcwSof+CuGb7OS8z7rnBzRo0aYV6ne
	 l8MvgmfTNFDEMPn/Q/kw3OgTU/ObgQNm6gpp/tOd5vRTGtZLMxO4pqE9oY8m71vx+p
	 jgPU36T6VROJvWp+SstqHlgmuZVMI6MNoH6xvnKedj+gL06bCtds6VaPzOt/wHl7bj
	 3PXUMvsy1whjY38Y2+iyAU680EgFI4t2pNZ5Gj17ZtT/1WRFe76bWLxJTUgvemSsHN
	 4xaaNzKw9jroA==
Date: Wed, 29 May 2024 17:08:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, daniel@makrotopia.org,
	dqfext@gmail.com, sean.wang@mediatek.com, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	nbd@nbd.name
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add debugfs support
Message-ID: <ZldE1cBeAk9jw3hs@lore-desk>
References: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>
 <9ad6b014-11e1-4def-8217-b1fbeac768c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OaVPF9wAGqO9CW/o"
Content-Disposition: inline
In-Reply-To: <9ad6b014-11e1-4def-8217-b1fbeac768c3@lunn.ch>


--OaVPF9wAGqO9CW/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, May 29, 2024 at 12:54:37PM +0200, Lorenzo Bianconi wrote:
> > Introduce debugfs support for mt7530 dsa switch.
> > Add the capability to read or write device registers through debugfs:
> >=20
> > $echo 0x7ffc > regidx
> > $cat regval
> > 0x75300000
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> In addition to Vladimirs NACK, you can also take a look at how
> mv88e6xxx exports registers and tables using devlink regions.

ack, right. Anyway in my case (mt7530-mmio) regmap is enough to dump regist=
er
values. Thanks for the pointer.

Regards,
Lorenzo

>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--OaVPF9wAGqO9CW/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZldE1QAKCRA6cBh0uS2t
rDG1AP9/CYLBt46VeY5RGxfWpNGfr2xd1FICgLMbVOLHU8LZfgD8CN57WIZxzRwa
/1pgn48IUmvDKL/SrWwzuPMPlYWMfgc=
=/dg/
-----END PGP SIGNATURE-----

--OaVPF9wAGqO9CW/o--

