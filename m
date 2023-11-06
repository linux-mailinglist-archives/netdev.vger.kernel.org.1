Return-Path: <netdev+bounces-46237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D267E2AFD
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28B42815E7
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0F29D03;
	Mon,  6 Nov 2023 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F98Wpxiw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E229420;
	Mon,  6 Nov 2023 17:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8389C433C7;
	Mon,  6 Nov 2023 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699292022;
	bh=oOcDWz4H6EBWQZ8XRRFn7yilwzV+aCmfOKBCXufKkEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F98WpxiwlABjLnTlC53iqz0UZ/avBbM4z0K08bsO8UinsyRhiHLr4d/VdaGgXHjFs
	 hbp/KzU+RkYgF4qtjf944AAgi1q0MpdnGUwvEcAZ2p4zHPqTXXfMbbeAFrEbrMt27y
	 HyrQBYLc8VuRI8aHJerD3OWeliIJKf+QYKvyRvqZTl0A4R1yav+mqMJhf9W4JRXGdZ
	 lco0JJ2ZhSA74E0bLiwKcOdV2J5eMkn2pbJMIEs4Doe0QqOBSohaSohew6u8WHbOYR
	 ZZhEXLUdmEQCOmoygJb7kNh2IorPhmBhHZqqlnmxPxhJCckiG4vn43K3SGJXf5CzUr
	 8E1Bz0PS1GPUw==
Date: Mon, 6 Nov 2023 17:33:36 +0000
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
Subject: Re: [net-next RFC PATCH v5 4/4] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <20231106-plentiful-kilt-9f228cbbe6e0@spud>
References: <20231106165433.2746-1-ansuelsmth@gmail.com>
 <20231106165433.2746-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L/mZ8GihQdWIG/0t"
Content-Disposition: inline
In-Reply-To: <20231106165433.2746-4-ansuelsmth@gmail.com>


--L/mZ8GihQdWIG/0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 05:54:33PM +0100, Christian Marangi wrote:
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
> Changes v5:
> - Drop extra entry not related to HW description
> Changes v3:
> - Make DT description more OS agnostic
> - Use custom select to fix dtbs checks
> Changes v2:
> - Add DT patch
>=20
>  .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquanti=
a.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml =
b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> new file mode 100644
> index 000000000000..7106c5bdf73c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -0,0 +1,123 @@
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
> +    - Attached SPI flash directly to the PHY with the firmware. The PHY
> +      will self load the firmware in the presence of this configuration.

> +    - Dedicated partition on system NAND with firmware in it. NVMEM
> +      subsystem will be used and the declared NVMEM cell will load
> +      the firmware to the PHY using the PHY mailbox interface.

I'd probably phrase this one as something more like "Read from a
dedicated partition on system NAND declared in an NVMEM cell, and loaded
to the PHY using its mailbox interface." or something like that - mostly
to get rid of the linux specific "NVMEM subsystem" from the description.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +    - Manually provided firmware loaded from a file in the filesystem.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id03a1.b445
> +          - ethernet-phy-id03a1.b460
> +          - ethernet-phy-id03a1.b4a2
> +          - ethernet-phy-id03a1.b4d0
> +          - ethernet-phy-id03a1.b4e0
> +          - ethernet-phy-id03a1.b5c2
> +          - ethernet-phy-id03a1.b4b0
> +          - ethernet-phy-id03a1.b662
> +          - ethernet-phy-id03a1.b712
> +          - ethernet-phy-id31c3.1c12
> +  required:
> +    - compatible
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: specify the name of PHY firmware to load
> +
> +  nvmem-cells:
> +    description: phandle to the firmware nvmem cell
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: firmware
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-phy@0 {
> +            /*  Only needed to make DT lint tools work. Do not copy/paste
> +             *  into real DTS files.
> +             */
> +            compatible =3D "ethernet-phy-id31c3.1c12",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg =3D <0>;
> +            firmware-name =3D "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776=
_VER1630.cld";
> +        };
> +
> +        ethernet-phy@1 {
> +            /*  Only needed to make DT lint tools work. Do not copy/paste
> +             *  into real DTS files.
> +             */
> +            compatible =3D "ethernet-phy-id31c3.1c12",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg =3D <0>;
> +            nvmem-cells =3D <&aqr_fw>;
> +            nvmem-cell-names =3D "firmware";
> +        };
> +    };
> +
> +    flash {
> +        compatible =3D "jedec,spi-nor";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        partitions {
> +            compatible =3D "fixed-partitions";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            /* ... */
> +
> +            partition@650000 {
> +                compatible =3D "nvmem-cells";
> +                label =3D "0:ethphyfw";
> +                reg =3D <0x650000 0x80000>;
> +                read-only;
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                aqr_fw: aqr_fw@0 {
> +                    reg =3D <0x0 0x5f42a>;
> +                };
> +            };
> +
> +            /* ... */
> +
> +        };
> +    };
> --=20
> 2.40.1
>=20

--L/mZ8GihQdWIG/0t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUkjcAAKCRB4tDGHoIJi
0nWmAQD/6caNNaXg4llLe5jQkRunI0dM64BFefhMSwUhRP5KugD/TbX4eaFaejKE
darP3qusg8I9T17zUTxt8PN8F35mbAc=
=Kg0u
-----END PGP SIGNATURE-----

--L/mZ8GihQdWIG/0t--

