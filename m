Return-Path: <netdev+bounces-33581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D5B79EB1C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0871F1C20D36
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603151DDE6;
	Wed, 13 Sep 2023 14:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29891F19B
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0450DC433C7;
	Wed, 13 Sep 2023 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694615420;
	bh=+DH1aDUKeb2gyoq8PZbX/q8CQn1YPVrrRzxuKGgwWmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxslrVoo+v4MpIK6NSRcFfvKIz7MIrFmFqc5SXPWL1myeHnHMNc2qJmpDCi+0Ec/3
	 DcBiABApDix0/1QohXIuvIYdH/F0vf07Q/cq2vh8A7TJYnjGByi3raRl/hfnroQW3o
	 e/whUUh83JKCGv151I8y3k0/jFWAacoXpQO1Rj6IIMaKpw/Sx+7IrOeGSjsniDQTqk
	 I7J0DK/4Mr1dBNemYn8f9tbGN/aJfmUSlJ42SRIvK5Vy+BNNv2kfElhLNUhnKN+4us
	 44vcEowl8F1R2i3+UXlTdPm/dJCTcWFxE0vVtZFF1RMMEKmkvBRqbmm3Fy5EvbdLNj
	 J2LU6LxYql4ow==
Date: Wed, 13 Sep 2023 15:30:14 +0100
From: Conor Dooley <conor@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <20230913-frisbee-backlog-17391b962c13@spud>
References: <20230913091011.2808202-1-danishanwar@ti.com>
 <20230913091011.2808202-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhD3bkOP9US8+Azu"
Content-Disposition: inline
In-Reply-To: <20230913091011.2808202-2-danishanwar@ti.com>


--zhD3bkOP9US8+Azu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 02:40:10PM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation =
at
> that port.
>=20
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b=
/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 836d2d60e87d..229c8f32019f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -107,6 +107,13 @@ properties:
>                phandle to system controller node and register offset
>                to ICSSG control register for RGMII transmit delay
> =20
> +          ti,half-duplex-capable:
> +            type: boolean
> +            description:
> +              Indicates that the PHY output pin COL is routed to ICSSG G=
PIO pin
> +              (PRGx_PRU0/1_GPIO10) as input so that the ICSSG MII port is
> +              capable of half duplex operations.
> +
>          required:
>            - reg
>      anyOf:
> --=20
> 2.34.1
>=20

--zhD3bkOP9US8+Azu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHHdgAKCRB4tDGHoIJi
0mvUAP4qy5TJEF8GK7qnltjQgB5hD3d27b1gsOqjmvxsAzzYPQEAqxYmzjKrQCAs
8rF1NkKlICXrKxlH016cCoGBjia5CwI=
=8yEv
-----END PGP SIGNATURE-----

--zhD3bkOP9US8+Azu--

