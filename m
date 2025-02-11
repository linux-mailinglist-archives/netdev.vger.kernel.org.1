Return-Path: <netdev+bounces-165230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6FA31234
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7797A327C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB6260A22;
	Tue, 11 Feb 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGlzpG27"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949E253B5A;
	Tue, 11 Feb 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293066; cv=none; b=kxXFEh0TaZZDyfV681VwZK9QTKF26ai3IiFGECTEk4FkIItXigdFgLj9WgqM0E1gW3im3BlgI8k6HOspvkNH+Z6Y6A0zBlfD0IRDucuYzVGYlJvO38sj30HkvLX+9aOh/9k/+jZqPT06bOeXFjocLYK5o8emmbQp++MIp8FdeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293066; c=relaxed/simple;
	bh=XenSwIiny7jWeKOqCxAtMXzolXULUFHtebJbW59m/F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKvAJ01/tPf1NIv56MooS5gObuhUhH1feDaQwtGK9aRXf2c9HOZYLpjSjgkHl/9IwSHvJt0rcrEUbzc12scd+IQcqG1yZ3uILUwBRf+WhxNJiWq2rd8H9mZYVL47YD4ao4/EJbitCeJs6WyVrSb8/P9Tii4d436v884Wn9ZVIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGlzpG27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE973C4CEDD;
	Tue, 11 Feb 2025 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739293066;
	bh=XenSwIiny7jWeKOqCxAtMXzolXULUFHtebJbW59m/F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGlzpG27tpKE+N0yKxRo0yTi35KNK3M8bfZcksEgY+EUx5TOm8PKbgQw4LVKoInSE
	 nHgwTk8glkSO0BHyampKLqnMndedZenmkUVy11wRy3ZuNtKXnLY7HfSLLxYNyigFJY
	 i0cFUO1InQYJ6F5FB2h54D5LbImzYUvUTe3enzXLxlvpWQYUyqOpynIs/vO9eLJm1f
	 Ku4zvXK2FH3hR1rSon8TgFNw8iFzJe67LKtqjj41F5jykPTqVLo0Df0K2xWfO8FnNA
	 V6Hw93Hr4qaUM4bjauHFB5UUHxBOp8ytCTyRZMRSREc4V+I9L8R8KGy1MvSAN9hGlJ
	 XAGVg68OnlwDQ==
Date: Tue, 11 Feb 2025 16:57:40 +0000
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250211-anointer-lubricate-7187aa3bda44@spud>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z+1UdOrhRBQRb0c+"
Content-Disposition: inline
In-Reply-To: <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>


--Z+1UdOrhRBQRb0c+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 09:33:47AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Add property tx-amplitude-100base-tx-percent in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Do=
cumentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2c71454ae8e362e7032e44712949e12da6826070..e0c001f1690c1eb9b0386438f=
2d5558fd8c94eca 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -232,6 +232,12 @@ properties:
>        PHY's that have configurable TX internal delays. If this property =
is
>        present then the PHY applies the TX delay.
> =20
> +  tx-amplitude-100base-tx-percent:
> +    description:
> +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the =
PHYs
> +      default will be left as is.
> +    default: 100
> +
>    leds:
>      type: object
> =20
>=20
> --=20
> 2.39.5
>=20
>=20

--Z+1UdOrhRBQRb0c+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uBhAAKCRB4tDGHoIJi
0tsYAQCYAPeG16vFxybr5BtiIoZbroPUUjBWX+z7VeEyXYInYAD7B0fX0IkbazgJ
QWWthKOAVxreyDpzD6ahxpUbd5PmHgY=
=G1KB
-----END PGP SIGNATURE-----

--Z+1UdOrhRBQRb0c+--

