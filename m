Return-Path: <netdev+bounces-128180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBBF97865C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765AB1F2225D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621371EEE4;
	Fri, 13 Sep 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxin2TFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CC7DA64;
	Fri, 13 Sep 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247062; cv=none; b=nr956Nvbbcc6+Y6SjilXfoGLWHleLsfBG+EnZzYDMHgptFi0AYx3u0H+odUuNoOC6WocrsBLFBoBUPjs4bE9PiVNjxAjmUO01WEY8zErzTdUc0O5k9fMmWWcZoz7y0col7R9lJJIQjzb7KDO7NBes8ONZYxFgpPbKGMhAEOea3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247062; c=relaxed/simple;
	bh=Bimw3teACghVaYDGbMFiMeYLIhGUrCaX5bh5RjG58O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmQg5ut2GFL0eMz0DtXM8yT/LGdTwVOQ25HAHmWczRlbrav0ORRPIY7WNPpw9XYDVn2f+jaDJ60S6w/I5mJF8U9jf/k4TUM5RUOueZgrD7BEjDTr94yqE+EA7pz47jsx+1uwM1kLaByQWHawbyf+70kNRwInAaF4JVhX1gQlW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxin2TFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6ADC4CEC0;
	Fri, 13 Sep 2024 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726247061;
	bh=Bimw3teACghVaYDGbMFiMeYLIhGUrCaX5bh5RjG58O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxin2TFYdo2MpnoqN3/ru1HXkcRRgGB0aGiMC3+oI/dvsnotFUvxCMtQoPFpmLWvp
	 42JQreaD/b26F7UepH93bp8GmZOfDc4wN7EZ3Bg+NTdgjnUOyaKulsSOlH5amgeWwX
	 JJI3jHupE1s5neWUzhqNkYRCr0KAcI5V6nzAy71JqPFPEZvCtU6eXVYGTR2kMdC4sb
	 1+zZ84ml2XFSO3tMSmzcs2os+2sX9Wd4HUTImpGtSXeQZzaKXuCGQ52O8ha2iM9/NW
	 yW8ybh0rzwS1NZPOxcCNP+wTbin7+prMU7oAx1BiAK55l0smOaodlE6spWLfFPFxe4
	 5evh8JodlF01Q==
Date: Fri, 13 Sep 2024 18:04:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: dsa: the adjacent DSA
 port must appear first in "link" property
Message-ID: <20240913-estimate-badland-5ab577e69bab@spud>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="erhZyKGbQwqN4Ufv"
Content-Disposition: inline
In-Reply-To: <20240913131507.2760966-3-vladimir.oltean@nxp.com>


--erhZyKGbQwqN4Ufv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 04:15:05PM +0300, Vladimir Oltean wrote:
> If we don't add something along these lines, it is absolutely impossible
> to know, for trees with 3 or more switches, which links represent direct
> connections and which don't.
>=20
> I've studied existing mainline device trees, and it seems that the rule
> has been respected thus far. I've actually tested such a 3-switch setup
> with the Turris MOX.

What about out of tree (so in u-boot or the likes)? Are there other
users that we need to care about?

This doesn't really seem like an ABI change, if this is the established
convention, but feels like a fixes tag and backports to stable etc are
in order to me.

>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa-port.yaml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Do=
cumentation/devicetree/bindings/net/dsa/dsa-port.yaml
> index 480120469953..307c61aadcbc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> @@ -31,10 +31,11 @@ properties:
> =20
>    link:
>      description:
> -      Should be a list of phandles to other switch's DSA port. This
> -      port is used as the outgoing port towards the phandle ports. The
> -      full routing information must be given, not just the one hop
> -      routes to neighbouring switches
> +      Should be a list of phandles to other switch's DSA port. This port=
 is
> +      used as the outgoing port towards the phandle ports. In case of tr=
ees
> +      with more than 2 switches, the full routing information must be gi=
ven.
> +      The first element of the list must be the directly connected DSA p=
ort
> +      of the adjacent switch.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        maxItems: 1
> --=20
> 2.34.1
>=20

--erhZyKGbQwqN4Ufv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuRwkAAKCRB4tDGHoIJi
0vfHAP9cFzroVB3GZuA91GabzA+2kn0YS6xgfGRCeLfS6kRX1QEA5gk62mEFp0mn
yro855Nq9nioDWT9HBzDB0OgiW+rHAA=
=W9Nn
-----END PGP SIGNATURE-----

--erhZyKGbQwqN4Ufv--

