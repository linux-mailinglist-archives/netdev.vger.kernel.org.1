Return-Path: <netdev+bounces-109521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58619928AE0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6811C22BF2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E7154C18;
	Fri,  5 Jul 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L57ffcZI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7B1BC43;
	Fri,  5 Jul 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191071; cv=none; b=TgkYvdOsSRkXHZs9vc+zkIVaEPX6Rudo42PcL8g3JrrrY04mz0XBWeogx3lXrMyAoS8UsJPxEisYCh4zMs1EAxXp7Xj/x+uPuyAnzTl9krAAnEVMBB8pojpVhdenvpCviNRYQUwpcJCX10JFIVERF5B8bLCu7axb+XjroO4mAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191071; c=relaxed/simple;
	bh=5aSZPBI+CT+PJ2YOau9hx8UcPEqP2KmBHY4e2Kku+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1MV++7RBB5qEnvaYdaoS/UQ/xHA4u0ZqeWvWaC0ca6Dwk/AxrlsVIMBdQzUkVmbUkjvMsxoJ9VVi31IHkdapdIcH3YQ8vV7WBOXJ2yxbcE6AflT+LKVDg5rsdsuPsMyNwYEcwsUoOguc/F4B4Mb0o2hdpFNHxR5rjyeVbHZ9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L57ffcZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEA0C116B1;
	Fri,  5 Jul 2024 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720191071;
	bh=5aSZPBI+CT+PJ2YOau9hx8UcPEqP2KmBHY4e2Kku+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L57ffcZIVNWj2dyoom1oWnhVPZELMhqCPZ9Ni+tfcZXD1RbnRZ60qK7XsEgUj8GUI
	 yqS8qqdcQzcHm7jp/J7SkAsG6Hzn0xQGhzQMK64pryjq0zRiLT1MVaTCAT1d/ct54b
	 0PYd0pkszhvNn+TI8cWi9PhxVW3XYuj83KQSthMbnMHJ/byZj+1JBjkXU8+QPEkCWX
	 06nNDG0Xn1WXhjYtYxsUMes7zytNieNJRu//RAJgxiAahmE/lZOqNEEWQWuUmRz+zQ
	 bML7/0Y1ZmsXcJGmAYz/m+uggNcIZh04F2jbBL5KnCgSi2oaGUd03jHepvlyQgkWb1
	 4E7dkG8URec3A==
Date: Fri, 5 Jul 2024 15:51:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240705-curing-lisp-c10eccf74685@spud>
References: <20240704140413.2797199-1-kamilh@axis.com>
 <20240704140413.2797199-4-kamilh@axis.com>
 <20240704-snitch-national-0ac33afdfb68@spud>
 <35d571bd-251d-45b5-9e4f-93c83d1a43c8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AJ85VJgRFD4qhchh"
Content-Disposition: inline
In-Reply-To: <35d571bd-251d-45b5-9e4f-93c83d1a43c8@lunn.ch>


--AJ85VJgRFD4qhchh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 11:11:41PM +0200, Andrew Lunn wrote:
> > > ---
> > >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml =
b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > index 8fb2a6ee7e5b..349ae72ebf42 100644
> > > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > @@ -93,6 +93,14 @@ properties:
> > >        the turn around line low at end of the control phase of the
> > >        MDIO transaction.
> > > =20
> > > +  brr-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      If set, indicates the network cable interface is alternative o=
ne as

nit: an alternative

> > > +      defined in the BroadR-Reach link mode specification under 1BR-=
100 and
> > > +      1BR-10 names. The driver needs to configure the PHY to operate=
 in
> > > +      BroadR-Reach mode.
> >=20
> > I find this second sentence unclear. Does the driver need to do
> > configure the phy because this mode is not enabled by default or because
> > the device will not work outside of this mode.
>=20
> BroadR-Reach uses one pair. Standard 10/100Mbps ethernet needs 2 pair,
> and 1G needs 4 pair. So any attempt to use standard 10/100/1G is going
> to fail, the socket/plug and cable just don't work for anything other
> than BroadR-Reach.
>=20
> As far as i understand it, the PHY could be strapped into BroadR-Reach
> mode, but there is no guarantee it is, so we should also program it to
> BroadR-Reach mode if this property is present.

Right, I guess for people that want brr-mode they'll probably understand
that and it's just unclear to me as I don't :) The nitpicking side of my
brain would like that last sentence reworded to "The PHY must be
configured to operate in BroadR-Reach mode by software", mostly cos the
word "driver" assumes a particular model for the OS, but it's not really
a big deal.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--AJ85VJgRFD4qhchh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZogIVgAKCRB4tDGHoIJi
0sESAP9FCOQKHHPEvePmpnAhGYkJLl8a8v/8qnk251JehCIpaAEA/UJDDCiH5KPQ
TvAbQKLoguD+74GG4gOtvSglYhJbcwc=
=dWlq
-----END PGP SIGNATURE-----

--AJ85VJgRFD4qhchh--

