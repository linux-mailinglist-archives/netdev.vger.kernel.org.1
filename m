Return-Path: <netdev+bounces-228537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD1BCD9A9
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C7AC4E33BB
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DA72F60D8;
	Fri, 10 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqeXPOBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7B2F0693;
	Fri, 10 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107758; cv=none; b=hAz6OJbdppCgmZ51AMFMJhUdcEjW7fiD1DgpcySNnE6x7bKPDs5zZNXd5RI/ji3viYayXDkSTGmaLRYA3xTnVJ2jRfiz0T+mzXxxFQdkZXcajbgRLiek/Cpn9NPNXDNe80NJeRsuJqNJOkBYDQdOvxpvAa4eJ+TJND8gdLXqEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107758; c=relaxed/simple;
	bh=P3ckS6KP9KEeg27CHO0IgZ9AWw66/dulT1LbsMlX38c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq9Oi++1eQRtISWKcaLzj8OmMhZb1htBc+UjhrTO6ue5Jvvhq5Kl+c4euEaKGG7pevDxd3JMNCuV5Zx3Do2SoWI1L1uHCQARBQqzNx3QpCAqUXYeTkFsQrzViB924BAuOUBW73kmJk2u/azDb0MU+AKRKe60DSNScLpL+fhIldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqeXPOBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4D2C4CEF1;
	Fri, 10 Oct 2025 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107758;
	bh=P3ckS6KP9KEeg27CHO0IgZ9AWw66/dulT1LbsMlX38c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqeXPOBA+q1/ep0IjpuybFarBvAT0ewAaq9KuttmpfY2mCeaXc/SIq0ic4cnC89V2
	 FBIjDq4hc+wqsu75UqztCGZy5Wt91FyE5S4NyR6EsYvRmvO6je7z+56tBAD2fjvV2J
	 jlFOBnhvoTQ3NJPm/1fSGefNO8mfQN35mVpeSXs/sIOjlDtYzGECXeJuK6Fj/yvtv0
	 3qkEUWPb1+bUXM8+Vb9qworpMmaUfgPsHM27beUKL6dfzWNRcj+eAW4pHn8DDxtK5E
	 d6RyXWHZk+NlN60/sV0fvuhy4Vx7H2+7hPZHftbNJn+mto0I8HGUENB2mxqITCirRs
	 /XhX+DWTkTYSA==
Date: Fri, 10 Oct 2025 15:49:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Wismer <thomas@wismer.xyz>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <20251010-gigahertz-parakeet-4e8b62ffa9fd@spud>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
 <20251007-stipulate-replace-1be954b0e7d2@spud>
 <20251008135243.22a908ec@pavilion>
 <e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
 <20251009223302.306e036a@pavilion>
 <8395a77f-b3ae-4328-9acb-58c6ac00bf9e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jUuVTbrEGbCichIw"
Content-Disposition: inline
In-Reply-To: <8395a77f-b3ae-4328-9acb-58c6ac00bf9e@lunn.ch>


--jUuVTbrEGbCichIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 11:43:04PM +0200, Andrew Lunn wrote:
> > When adapting the driver, I also considered an auto-detection mechanism.
> > However, it felt safer to rely on the devicetree information than readi=
ng
> > a silicon revision register, which has a totally different meaning on
> > some other device. I have therefore decided to make the driver behaviour
> > solely dependent on the devicetree information and to use the silicon
> > revision only as a sanity check (as already implemented in the driver).
>=20
> So if the silicon and the DT disagree, you get -ENODEV or similar?
> That is what i would recommend, so that broken DT blobs get found by
> the developer.

I'm personally not a big fan of this kind of thing, as it prevents using
fallbacks for new devices when done strictly. I only really like it
being done this way if the driver does not produce errors for unknown
part numbers, only if (using this case as an example) a b device is
labeled as a non-b, or vice-versa. IOW, if the driver doesn't recognise
the ID, believe what's in DT.

> > Is there any best practice when to use auto-detection with I2C devices?
>=20
> Not really. There are devices/drivers where the compatible is just
> used to indicate where to find the ID register in the hardware,
> nothing else. The ID register is then used by the driver to do the
> right thing, we trust the silicon to describe itself. But things like
> PHY devices have the ID in a well known location, so we actually don't
> require a compatible, but if one is given, we use that instead of the
> ID found in the silicon. So the exact opposite.
>=20
> > Regardless of whether the driver queries the silicon revision, the B
> > device declaration would look somehow strange to me with a driver having
> > one single compatible, i.e. compatible =3D "ti,tps23881b", "ti,tps23881=
".
> > The first one specifically names the hardware, the fallback is actually
> > the name of its predecessor, which is strictly speaking not 100%
> > compatible but required to have the driver loaded.
>=20
> If it is not compatible, a fallback will not actually work, don't list
> a fallback.

Yeah, seconded. I think my original mail about this was maybe a bit
confusingly worded, where I was envisaging a world where a driver that
encountered a b device could load the firmware for the non-b device, and
it would just be a redundant operation. A fallback would be suitable,
but obviously not ideal then. Since that isn't permitted, using a
fallback here does not make sense.

--jUuVTbrEGbCichIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkc6QAKCRB4tDGHoIJi
0um4AQDpGEdB55DPYgit0LAzOWpRH7yUGBtcti/pFz2pLFxjrgEA7oOKHm8GJRHa
gUGwja+A5XEwahUtuVVBTWREHJDEgAY=
=nHBT
-----END PGP SIGNATURE-----

--jUuVTbrEGbCichIw--

