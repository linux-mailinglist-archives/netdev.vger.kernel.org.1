Return-Path: <netdev+bounces-100014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC58D7750
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967241F2120C
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93358AC3;
	Sun,  2 Jun 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiyrDfdB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAA2A1B0;
	Sun,  2 Jun 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349902; cv=none; b=FN1dAmQ9d4xHFjyl5Ho4/8QJVHRzkehfgrg2ewgHI2FAmALIWTtjAQarESf6qJ1X7nLyPPgqmwfgdkXigJ6h8hxth1Ud992Nbx0fjGCGpxZ220EDAb3oQ46HFH1jK2UtsGqKE8cghHB0Dv5SKtTIaiBiJS4S4WWQR68pi7ktUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349902; c=relaxed/simple;
	bh=jooBFlNnMtSqQJiYbhYs2HXqKL86Ry8byTbrCo+Q/Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFtB3SLcAg58Bl/f7ulW+EFkPll7TXJ94DpxTfR/S1cHCxcfPL+p/7hTFIs56BtvZzJ3b7VhBWD5rqN4szwoc6Y75ccLvXqtu1KRrtfj2+Ych3H4QExfLtHikC7xN5iOY2mVeCXcThXcXE4gsuVOXv486PupDo9GAWld254kydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiyrDfdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3B6C2BBFC;
	Sun,  2 Jun 2024 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717349901;
	bh=jooBFlNnMtSqQJiYbhYs2HXqKL86Ry8byTbrCo+Q/Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiyrDfdBwXNh2OkSx5SI/8cSd8Tj2Hp/i/m/KR+VafJu+aRllVMT1d/92E6uY0R4k
	 cNuVNvNbsUW1PAMHHNHkbRR2VSC+OVtITLncpcfl46F4dJdEwGecgYPO5QewwmqaPx
	 B+pk4jBRGLDICGxwcXovB6zXERynGXC8FLAp8WxweDhaDj7wOrdSBY3LGLBneOydM4
	 fmlyNithkxLVY+Mm2FLocvjA70iIQ6nwM+4Crl0WrTDs7UzpsJxqgTzpbqtnlP4iVx
	 hTQD75as91ktse83iT2yaFxF+IDnTvry7fIPUSP5qpCEzSQPjbNKc3Jlo9u6Oc+Wks
	 9M4B8eMxfpZQw==
Date: Sun, 2 Jun 2024 19:38:17 +0200
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
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 2/3] arm64: dts: airoha: Add EN7581 ethernet node
Message-ID: <ZlyuCeh9vOaZJsGy@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>
 <e79b7180-74ef-4306-9f73-47ee54c91660@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Wx2BgtruI5Ui/hB"
Content-Disposition: inline
In-Reply-To: <e79b7180-74ef-4306-9f73-47ee54c91660@lunn.ch>


--3Wx2BgtruI5Ui/hB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, May 31, 2024 at 12:22:19PM +0200, Lorenzo Bianconi wrote:
> > Introduce the Airoha EN7581 ethernet node in Airoha EN7581 dtsi
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  arch/arm64/boot/dts/airoha/en7581-evb.dts |  4 +++
> >  arch/arm64/boot/dts/airoha/en7581.dtsi    | 31 +++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/airoha/en7581-evb.dts b/arch/arm64/boo=
t/dts/airoha/en7581-evb.dts
> > index cf58e43dd5b2..82da86ae00b0 100644
> > --- a/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > +++ b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > @@ -24,3 +24,7 @@ memory@80000000 {
> >  		reg =3D <0x0 0x80000000 0x2 0x00000000>;
> >  	};
> >  };
> > +
> > +&eth0 {
> > +	status =3D "okay";
> > +};
>=20
> Is that enough to make it useful? Don't you need a phy-handle, or
> phy-mode?

This changes is actually in a subsequent patch (not posted yet) where I will
add support for the mt7530 dsa switch. Do you prefer to add it here?

Regards,
Lorenzo

>=20
> 	Andrew

--3Wx2BgtruI5Ui/hB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZlyuCQAKCRA6cBh0uS2t
rA7OAQDQeuluF59VsHhXbBC0HWm/n8vc0F0hx3vVWOQs0iQ5LwEAxsEOoZgfhO1t
9nrwx1aESpVtPHJDD8v05rPU2s7QqQU=
=VF2k
-----END PGP SIGNATURE-----

--3Wx2BgtruI5Ui/hB--

