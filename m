Return-Path: <netdev+bounces-100020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2C8D7766
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C84E1C20CA7
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4B57C8A;
	Sun,  2 Jun 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA/TVdPu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75582D058;
	Sun,  2 Jun 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717351247; cv=none; b=K6QG3JUE9oS2M/KUgdqsVl8nvbqDq8QG8tHfMpkVMQFes7BExcUKafNAzrzTUTFkv1gNGPczeOjvV/ME7NoU5TOMID6TdeGiyOftsluQIuxf7GtpxGezwVPOm6lPvsjrUaxwF4O0Q47FHCa3KVG0RLhrIL/N7Xl5F/xQmIdBZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717351247; c=relaxed/simple;
	bh=5UOnIiRDPsNdGugtQZJiB/T2OYSpcEW+eXrkeXtY3RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXeNAQOXmWNxIvzoDPNqmc5qwhbM3okEcO5+91/suuq4PAiDDYkRddHt9kkGtGSe88glh3EE+HZUgsGv8BcNMuVvCuGVO8Mv/sWJQiAQuOPiCpIwAcyq+aLeyVaHIIDNhoie3AmQr+mtLwChpqrSs8Cy14bhDvJCbij4pGWHCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA/TVdPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE931C2BBFC;
	Sun,  2 Jun 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717351247;
	bh=5UOnIiRDPsNdGugtQZJiB/T2OYSpcEW+eXrkeXtY3RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iA/TVdPuXZPybwHwCmA6GHM4NU8a5NDlRurw2P1I4HZV5tnhKKtnByNW7xZ2Qm3q5
	 LSqEqr6w3sX7E8WTPlMk254Hv7+kZXMDE4JncCbNl2PNPGiUVlqyXfFRtcli8UiVOd
	 +HW0zcnLlRnsSULWFXQ5QR5rHZKBBRLGqAKexNXCYcCxmyZwhwRda0tpDmALIMgejS
	 AOCrgMMFCIg8jft7Pgz5Dq3MNerkMj0JBvfaP9NwaIkZi/sema9CNwvxU8TC2R7Clg
	 lb4plkR4ilcqHUz7N7oX+PnZimXVwp/TrnXBSCDxCqQ5n8QBihPdt+kIJPpMZkE1dK
	 Ym0rTdmB4yetQ==
Date: Sun, 2 Jun 2024 20:00:43 +0200
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
Message-ID: <ZlyzS8eDlPHnfFPe@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>
 <e79b7180-74ef-4306-9f73-47ee54c91660@lunn.ch>
 <ZlyuCeh9vOaZJsGy@lore-desk>
 <1ffe4a56-c3fc-4553-aa32-c7a0d9780b5c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mLMcE8/hNitlLsVi"
Content-Disposition: inline
In-Reply-To: <1ffe4a56-c3fc-4553-aa32-c7a0d9780b5c@lunn.ch>


--mLMcE8/hNitlLsVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 02, 2024 at 07:38:17PM +0200, Lorenzo Bianconi wrote:
> > > On Fri, May 31, 2024 at 12:22:19PM +0200, Lorenzo Bianconi wrote:
> > > > Introduce the Airoha EN7581 ethernet node in Airoha EN7581 dtsi
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/airoha/en7581-evb.dts |  4 +++
> > > >  arch/arm64/boot/dts/airoha/en7581.dtsi    | 31 +++++++++++++++++++=
++++
> > > >  2 files changed, 35 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/airoha/en7581-evb.dts b/arch/arm64=
/boot/dts/airoha/en7581-evb.dts
> > > > index cf58e43dd5b2..82da86ae00b0 100644
> > > > --- a/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > > > +++ b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > > > @@ -24,3 +24,7 @@ memory@80000000 {
> > > >  		reg =3D <0x0 0x80000000 0x2 0x00000000>;
> > > >  	};
> > > >  };
> > > > +
> > > > +&eth0 {
> > > > +	status =3D "okay";
> > > > +};
> > >=20
> > > Is that enough to make it useful? Don't you need a phy-handle, or
> > > phy-mode?
> >=20
> > This changes is actually in a subsequent patch (not posted yet) where I=
 will
> > add support for the mt7530 dsa switch. Do you prefer to add it here?
>=20
> I would prefer you move this later when you add the switch.

ack, I will do in v2.

Regards,
Lorenzo

>=20
> 	Andrew

--mLMcE8/hNitlLsVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZlyzSwAKCRA6cBh0uS2t
rAySAQDvYJ/z4iFpraJsdCmypuOvJe21bKuejWVQA2FhNoeVPgEAqowO2Ld13fNX
nrrqtZTJf79b1etA0M9fpyy4O4QHDw8=
=Rlsw
-----END PGP SIGNATURE-----

--mLMcE8/hNitlLsVi--

