Return-Path: <netdev+bounces-45903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC97E035B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324F71C20DCD
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66181798F;
	Fri,  3 Nov 2023 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7u8rZeg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82FC121;
	Fri,  3 Nov 2023 13:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49140C433C7;
	Fri,  3 Nov 2023 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699016931;
	bh=Q7bthhPoFjkWUMlyFUZKED1Byw57+VTorIZ5iPKMrmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7u8rZegwQaDQ0DVB0SWfhvzDOx6s4B2KWdYGuJfQFnK7NiWYZ3fK2qriOHdVWgef
	 FjEnXwODUNWC/2ZADbWtGIBmFE3sNmf5sDT7+5nwnbd12e8ENhEkOHQPYC44qVOcL5
	 2CdToKfZ1foCN03SGj2Ig5YVkgQLBx/xVsGzsK15NeO6tXEhL69MC2coX8T/nZY2Rc
	 t5jXHDZkQbiDGZ3W3mJcyVfVBBTbcimbk39f/xBz+G3yk6Ie6kTq1oXCDqZ9X2Bpzg
	 6Xsdutfcgt+QTVcRI7Liq2sdez+MaQZK9UjPNQKTyfqGU/+Umm7YBp2wG1/sxIPJS2
	 pLdGAyH/CHJ4g==
Date: Fri, 3 Nov 2023 13:08:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 4/4] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <20231103-outboard-murkiness-e3256874c9a7@spud>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <20231102150032.10740-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YBRbmXQ7LbrT3SgB"
Content-Disposition: inline
In-Reply-To: <20231102150032.10740-4-ansuelsmth@gmail.com>


--YBRbmXQ7LbrT3SgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Thu, Nov 02, 2023 at 04:00:32PM +0100, Christian Marangi wrote:
> Document bindings for Marvell Aquantia PHY.
>=20
> The Marvell Aquantia PHY require a firmware to work correctly and there
> at least 3 way to load this firmware.
>=20
> Describe all the different way and document the binding "firmware-name"
> to load the PHY firmware from userspace.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v3:
> - Make DT description more OS agnostic
> - Use custom select to fix dtbs checks
> Changes v2:
> - Add DT patch
>=20
>  .../bindings/net/marvell,aquantia.yaml        | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquanti=
a.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml =
b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> new file mode 100644
> index 000000000000..d43cf28a4d61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Aquantia Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actua=
lly
> +  work.
> +
> +  This can be done and is implemented by OEM in 3 different way:
> +    - Attached SPI directly to the PHY with the firmware. The PHY will

You a word here? Should that not be "SPI flash"?

> +      self load the firmware in the presence of this configuration.

> +    - Dedicated partition on system NAND with firmware in it. NVMEM
> +      subsystem will be used and the declared NVMEM cell will load
> +      the firmware to the PHY using the PHY mailbox interface.
> +    - Manually provided firmware loaded from a file in the filesystem.
> +
> +  If declared, NVMEM will always take priority over filesystem provided
> +  firmware.

This section here reads entirely like "software policy". The first
bullet in your list is fine - as that is what the PHY will do itself.
The second and third bullets here seem like two different ways that
someone could integrate their system, and I am not objecting to either
of those ways of doing things.
The priority system that you mention however I don't think is suitable
for a description of the hardware - the PHY itself doesn't require that
an external-to-it flash device take priority over something in the
filesystem, right?


--YBRbmXQ7LbrT3SgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUTw3QAKCRB4tDGHoIJi
0qf4AQDU5T+OXQT6MxLXyNCp4aiexeUQQeT+wge60Mjxod2E6AD/Tj2SZ7SnSWNL
2wwCzdXT8D+xgkafSOHsTzmCVBiQQQ0=
=TObr
-----END PGP SIGNATURE-----

--YBRbmXQ7LbrT3SgB--

