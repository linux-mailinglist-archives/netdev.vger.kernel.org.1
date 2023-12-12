Return-Path: <netdev+bounces-56504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997E80F264
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022B2B20A3F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6277F24;
	Tue, 12 Dec 2023 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QREA5gfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482657765B;
	Tue, 12 Dec 2023 16:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E91C433C8;
	Tue, 12 Dec 2023 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398268;
	bh=ta9qDCjTjWyR69j+7I8MCMvgrq55mLcwFImJg/bIQqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QREA5gfn0t5sFMgfMcbuSLToFiNaFbG2PP5+kap/TYoImqaFVXsuQZbwHsfEBj4G9
	 wd1pVutWwMd2x7Q73CID/VvF/hVszlWNzNOr1WFVtEwuBmMj9klBvcbmOoNDsDfq4e
	 pTCgr1EIqC+xZ4Tuyr8ViEqaedZ0As6Jfi+jdL6Y07o9WcOxTSscexH0uK16lQSNYh
	 ADyRNuh824v/9OvV7VkjXcjGu11lgEbIhgsJyy5twFGNYF04k4y9qfQJ2eDR4YkafI
	 esdU5n+FCz3yVoITRk8NJZLj9lEfpvnEZeY6glFGugS27Aup+X2j25OJVf3FNJdcsO
	 D9Dx76SbASWFA==
Date: Tue, 12 Dec 2023 16:24:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 4/8] dt-bindings: net: pcs: add bindings
 for MediaTek USXGMII PCS
Message-ID: <20231212-panhandle-pasty-243c3556ea51@spud>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <510af8550385da947e2e2516629c4fbed7fc0f64.1702352117.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YruC2MCzDdXijj9+"
Content-Disposition: inline
In-Reply-To: <510af8550385da947e2e2516629c4fbed7fc0f64.1702352117.git.daniel@makrotopia.org>


--YruC2MCzDdXijj9+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 03:47:31AM +0000, Daniel Golle wrote:
> MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
> it in order to configure and monitor the Ethernet SerDes link in
> USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
> legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
> interface modes are also available.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,us=
xgmii.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.y=
aml b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> new file mode 100644
> index 0000000000000..0cdaa3545edb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/mediatek,usxgmii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek USXGMII PCS
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The MediaTek USXGMII PCS provides physical link control and status
> +  for USXGMII, 10GBase-R and 5GBase-R links on the SerDes interfaces
> +  provided by the PEXTP PHY.
> +  In order to also support legacy 2500Base-X, 1000Base-X and Cisco
> +  SGMII an existing mediatek,*-sgmiisys LynxI PCS is wrapped to
> +  provide those interfaces modes on the same SerDes interfaces shared
> +  with the USXGMII PCS.
> +
> +properties:
> +  $nodename:
> +    pattern: "^pcs@[0-9a-f]+$"
> +
> +  compatible:
> +    const: mediatek,mt7988-usxgmiisys
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: USXGMII top-level clock
> +
> +  resets:
> +    items:
> +      - description: XFI reset

For this two, why not just "maxItems: 1", since there are only one of
each?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt7988-clk.h>

> +    #define MT7988_TOPRGU_XFI0_GRST 12

Why? You can just put the raw numbers here and avoid the issues with the
bot being unable to test your series.

> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +        usxgmiisys0: pcs@10080000 {
> +          compatible =3D "mediatek,mt7988-usxgmiisys";
> +          reg =3D <0 0x10080000 0 0x1000>;
> +          clocks =3D <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>;
> +          resets =3D <&watchdog MT7988_TOPRGU_XFI0_GRST>;
> +        };
> +    };
> --=20
> 2.43.0

--YruC2MCzDdXijj9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiJNAAKCRB4tDGHoIJi
0gh/AP9oyVQ1N3J5pkEjMly0tOqZP7FqsYaPHKpAmHAo3tjaRAEApbppZl/Wk2dK
aaGNYg45wHQl3e7wiQc2iLV/iy3CkgU=
=IpBA
-----END PGP SIGNATURE-----

--YruC2MCzDdXijj9+--

