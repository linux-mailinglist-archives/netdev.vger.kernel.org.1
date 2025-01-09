Return-Path: <netdev+bounces-156864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CDBA080ED
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363E7167081
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54171F4293;
	Thu,  9 Jan 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmKbiGaO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F42F43;
	Thu,  9 Jan 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452767; cv=none; b=kH7kr8nsfAvA4O79PLWyjuKmonhK6TEmovoeY8chAA6OLpQu5r/KSdt+1B8Lvkogqwb9xv/oggeNRU7ZQG08HBeFh8xY49MuTeNjSeCwQgrLXEuZh1JpcfWRMoVYS59cwr8MIDiq5QpDE/3kMKBoZlGkc+9s9xrb1m2FrZrAN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452767; c=relaxed/simple;
	bh=mhPRywFd9ukygV++MaAXiNyV5JNms8b00h2HE8kvKOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gArTZnXE2Z2AcEeY7yDiOqafXPtg2f+liU3r+hDqYo6bz6xc2DzIKYbjSUoVfaMzJcx/8Wx1rVftkPGWAPzQ8rdwih8UI9ahQJRlEFWmH0BXlm/Dw0+Oiuf32UUcQjv1yTwRBneDp9d6kgmAROEFUQCb2ctbtP9jq4bsuaaqCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmKbiGaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE4AC4CEE1;
	Thu,  9 Jan 2025 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736452767;
	bh=mhPRywFd9ukygV++MaAXiNyV5JNms8b00h2HE8kvKOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmKbiGaOvh4kRZyPoFMpl4Hv7UZ64wj9aEqot7bZkr24mg24dXgcC0q96WYxsIsMk
	 lv2D2KaZbv5yw+HRlLz+1xI6pEtU+Qovx+8CVTzvCJ14mctvGFQCz7uZ3KgqYAOekt
	 QYPN2i4fDfkzVsCynTxKCXJOeUF7mid0xI2HhNVUBShzQ/Pwbqllh2TXgOVCXbmIRW
	 jTcQO8hrHBwuJZs6IYqZEBjiqCZhS7WmpHE4+ywVXHzs5LcsHh3CPt1vKQDuBK2Uua
	 qqYA2qIUPdnrC/B1U0+YjSolD6dJA4AjIrPPKERupn3KMFWKspODmOT5OjvBQpoV9T
	 AYQNubLiDyffw==
Date: Thu, 9 Jan 2025 19:59:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <94386bd6-18b7-4779-a4eb-98e26c90326b@sirena.org.uk>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
 <20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
 <20250109075926.52a699de@kernel.org>
 <20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
 <Z3_415FoqTn_sV87@pengutronix.de>
 <20250109174942.391cbe6a@kmaincent-XPS-13-7390>
 <20250109115141.690c87b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NSkeXpHCuIxL2qxl"
Content-Disposition: inline
In-Reply-To: <20250109115141.690c87b8@kernel.org>
X-Cookie: I'll be Grateful when they're Dead.


--NSkeXpHCuIxL2qxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 11:51:41AM -0800, Jakub Kicinski wrote:
> On Thu, 9 Jan 2025 17:49:42 +0100 Kory Maincent wrote:

> > I think I should only drop patch 11 and 12 from this series which add s=
omething
> > new while the rest is reshuffle or fix code.

> I mentioned 13 & 14 because I suspected we may need to wait for
> the maintainers of regulator, and merge 13 in some special way.
> Looks like Mark merged 13 already, so =F0=9F=A4=B7=EF=B8=8F

Well, you were saying that the subdevice structure didn't make sense and
you wanted to see it dropped for now so given that it's -rc6 and it's
unlikely that'll get fixed for this release it made sense to just apply
the regulator bit for now and get myself off these huge threads.

There's no direct dependency here so it should be fine to merge the
networking stuff separately if that does get sorted out.

--NSkeXpHCuIxL2qxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeAKpgACgkQJNaLcl1U
h9DJGQf/TrjYjWyxWPOe93U9iK8pbYy1z+8Fdp7XW16bvIYUyy2wIgOhxHN6C4Hy
GFIJunL04e/lAYn2JASs+Kye89yTJuJHcP21XKh/NRpxBsjs2dTZYAEkPNBGIZeM
wOwWf+z2s7f61Rr+HHv5cYt0RPOPTshtzlvN+x6AP4yaxdFj/S9GBVy7H+jDL9Dp
3Tocxr84eIkzV4bO2F3o1OghlE5DFoJm8e/CzX6urG1kl7VoLVtjnPBOmykJb22y
1kwUQ9kzCVmLIaOkiaEMRWj3YIU7Du4yKnI8tXCHlObwdNmvyHzvS7amHDwzj4Va
oeOxnigonsYDoeuVB1f7NOqKt6xWnw==
=gJu2
-----END PGP SIGNATURE-----

--NSkeXpHCuIxL2qxl--

