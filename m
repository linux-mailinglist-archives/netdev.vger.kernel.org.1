Return-Path: <netdev+bounces-234667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC8C25CA0
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09F374F715A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7621767D;
	Fri, 31 Oct 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMhdOB+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6791F5847;
	Fri, 31 Oct 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923290; cv=none; b=UCh/aside/MQ9CyhOLmmt6I/JMAR4F4jw9yeVs5FdXXc9l3tSB7IFAfV9l8G4FpQGVKLlHsCdZc1t1s4O42GqV5cFMQJJK62TeELJP4YMSQp/jYVCyQa0nD5cNfoaxBuSV33sNf3QNiXu0J0FlCoPvgFxVKlPMCU++SMFETemh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923290; c=relaxed/simple;
	bh=hhV5vO7shNUsRg+5Wn47NeijB5Xy6knDF8kwZguxWqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Wlj+mTzuWs1KTEvcgK1uFLbgAt2xttC5ogjvj+6uYkT8IHx+RrCs1YqoKDsfye3QugKQ/Ikr+FRDViirG2qIA783M8Zfhn+B4VqmMkSHnwnv5cPwtjVqp6s1wg5TQDHMi1wad/+qNp0Wq/PWrEjBKGGBecyPq4TLieotsrkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMhdOB+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B3DC4CEE7;
	Fri, 31 Oct 2025 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761923288;
	bh=hhV5vO7shNUsRg+5Wn47NeijB5Xy6knDF8kwZguxWqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMhdOB+My6boDB6ghkVCj7rdVDZchfxroblBkTV3NJngTJFLkkd7IdPSU4x8GhOsr
	 8zLQq+bVt7AZ/5C6Pg9w0qvrPucmmlcz6arvqG7EkUPvhKtzECdVtETdwOv9SBZXO5
	 dhuRUGeWllOI3pdz3HOPyoahBMiq/HIPFrlHA5uGtGdB01A9EvXNgNR2eXKxW5e0yl
	 WRYGhLPBuKB69/0IncRhGQIwo5ndwD66ttm1rhTCr73lb11rNpgfp1HnGSqg62PvQy
	 BKXd8ucdt/7USw18Vi7w+43Ir4Y/vxFJ2WHPdhBDNz/z7JvS4DvakvAfCZIEyc8CT/
	 DGYP1mx8SRZcw==
Date: Fri, 31 Oct 2025 15:08:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Buday Csaba <buday.csaba@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ethernet-phy: clarify when compatible
 must specify PHY ID
Message-ID: <20251031-smartness-cattishly-465de28ec20b@spud>
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
 <f08d956b-4392-41c0-93d7-d7dd105c016c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntQblQwoVNjBFIgI"
Content-Disposition: inline
In-Reply-To: <f08d956b-4392-41c0-93d7-d7dd105c016c@lunn.ch>


--ntQblQwoVNjBFIgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 02:01:26PM +0100, Andrew Lunn wrote:
> On Fri, Oct 31, 2025 at 09:15:06AM +0100, Buday Csaba wrote:
> > Change PHY ID description in ethernet-phy.yaml to clarify that a
> > PHY ID is required (may -> must) when the PHY requires special
> > initialization sequence.
> >=20
> > Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kern=
el.org/
> > Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> >=20
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/=
Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 2ec2d9fda..6f5599902 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -35,9 +35,10 @@ properties:
> >          description: PHYs that implement IEEE802.3 clause 45
> >        - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
> >          description:
> > -          If the PHY reports an incorrect ID (or none at all) then the
> > -          compatible list may contain an entry with the correct PHY ID
> > -          in the above form.
> > +          If the PHY reports an incorrect ID (or none at all), or the =
PHY
> > +          requires a specific initialization sequence (like a particul=
ar
> > +          order of clocks, resets, power supplies), then the compatibl=
e list
> > +          must contain an entry with the correct PHY ID in the above f=
orm.
>=20
> That is good start, but how about:
>=20
>           PHYs contain identification registers. These will be read to
>           identify the PHY. If the PHY reports an incorrect ID, or the
>           PHY requires a specific initialization sequence (like a
>           particular order of clocks, resets, power supplies), in
>           order to be able to read the ID registers, then the
>           compatible list must contain an entry with the correct PHY
>           ID in the above form.
>=20
> The first two sentences make it clear we ideally use the ID registers.
> Then we say what happens if cannot work.
>=20
> The "(or none at all)" is exactly the case you are trying to clarify,
> it does not respond due to missing reset, clocks etc. We don't need to
> say it twice, so i removed it.

I like this wording,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

--ntQblQwoVNjBFIgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQTQ0wAKCRB4tDGHoIJi
0s2YAQCWOfnQgjf28reEeXDLxZn1pmVaVpd+2TFOYi3ZSjasUQEAoqOMOXyeufvW
6R6eWhRA4n/i9o4N6Vdmd4NY+qDbVgw=
=gNd4
-----END PGP SIGNATURE-----

--ntQblQwoVNjBFIgI--

