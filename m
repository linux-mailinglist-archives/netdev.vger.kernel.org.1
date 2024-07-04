Return-Path: <netdev+bounces-109285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40D927B03
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F71283625
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5241B29B4;
	Thu,  4 Jul 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+WVeMF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B91AEFFF;
	Thu,  4 Jul 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109864; cv=none; b=KrWdZWFTOq4rl3B4w1nTrJLrntQoFGufo77AmgvzzNEbBtCb/YsaI7Hmsbuyo0epSoI1naHXgIPt5D6iXA8lxQSaLydMWyN9rVtpWGuS/3npvwqRWYQqk4mcGV4O+4ck37bAlTvzwGrvEPmvV7l4POC+6pnMyH32GfIcSLrTrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109864; c=relaxed/simple;
	bh=pcYwbjCfgj34IXSyuEgh8UhDZzrsWrKWN//jUhn90xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjjv7f9uIoRnHOT224n8ARG9zAdbKa89SIGkvypC1G8uGMUvM5uMTnx/uCRQX3qpaTtr2dEjmxVTldKurjKVptXSLbw+37dOrV2obVx7DUW2UABWUoAhc26CZrV786vG2FQQO6E4q4PnLaGYmGK19h+yVvgY7Q8AD4xv7J2pab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+WVeMF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14181C3277B;
	Thu,  4 Jul 2024 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720109864;
	bh=pcYwbjCfgj34IXSyuEgh8UhDZzrsWrKWN//jUhn90xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+WVeMF+NYPDsHpwlhbI6h6KdYEeIqGROvpXW+rJP51I+9O6hvRGNTTrmjZzFPxRl
	 ggcDM2r8PlFDZkwQvJMFpcszBkwn1py/KkcSxlQGsRw4EehK2eskO58UXIU6tNTkTq
	 LPmIlOMACdI81J7aBeKBB/HEcuf+SL0lMdGepAL42WU41BqnHd34MEsmlfxBKRLgww
	 nFEoV5LKyZj5u0yRHlc8HEhbVj6WUFfEjoIUbTNxDKUmcBttS3RwCzBOo70LTB+Qvj
	 rZOwfKlmMGP0h3YS+1G2Sgv7w3RfQ6+Kz9Pb8pJ97OvYvGDiJWhL70DTRGJ3PHnJbe
	 phgWZH51pUzKA==
Date: Thu, 4 Jul 2024 17:17:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240704-snitch-national-0ac33afdfb68@spud>
References: <20240704140413.2797199-1-kamilh@axis.com>
 <20240704140413.2797199-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="akwRYHEp/6rrMnoh"
Content-Disposition: inline
In-Reply-To: <20240704140413.2797199-4-kamilh@axis.com>


--akwRYHEp/6rrMnoh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 04:04:12PM +0200, Kamil Hor=E1k (2N) wrote:
> There is a group of PHY chips supporting BroadR-Reach link modes in
> a manner allowing for more or less identical register usage as standard
> Clause 22 PHY.
> These chips support standard Ethernet link modes as well, however, the
> circuitry is mutually exclusive and cannot be auto-detected.
> The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
> based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
> (1BR-10 in Broadcom documents).
>=20
> Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.
>=20
> Signed-off-by: Kamil Hor=E1k (2N) <kamilh@axis.com>

Where did the tags go? There's no mention of why they were dropped.

> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Do=
cumentation/devicetree/bindings/net/ethernet-phy.yaml
> index 8fb2a6ee7e5b..349ae72ebf42 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -93,6 +93,14 @@ properties:
>        the turn around line low at end of the control phase of the
>        MDIO transaction.
> =20
> +  brr-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If set, indicates the network cable interface is alternative one as
> +      defined in the BroadR-Reach link mode specification under 1BR-100 =
and
> +      1BR-10 names. The driver needs to configure the PHY to operate in
> +      BroadR-Reach mode.

I find this second sentence unclear. Does the driver need to do
configure the phy because this mode is not enabled by default or because
the device will not work outside of this mode.

Cheers,
Conor.

--akwRYHEp/6rrMnoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobLIgAKCRB4tDGHoIJi
0khVAQDaogE6E7Bmwygq9kfblzI9ZEadOk4sGBJj3y6H4ltyHwEAwOOszI49sk1m
0zPPtlKlL5GBNerNOZGS74x2NHoW6Ak=
=pxKj
-----END PGP SIGNATURE-----

--akwRYHEp/6rrMnoh--

