Return-Path: <netdev+bounces-17978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A684753ED6
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF841C2141C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CA14287;
	Fri, 14 Jul 2023 15:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8E14264
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:27:58 +0000 (UTC)
Received: from aposti.net (aposti.net [89.234.176.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7C269F;
	Fri, 14 Jul 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1689348473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pIC2EQa0W5UA2DBrmWwQ0ZJQKXPUNXc31P2C1+6Z48=;
	b=HIY1fXnAna2ilYcIaCpn6E4mJP0saT6co1mxHMQVB7aPVAuNptK6OitT18L0gyQ0WZuYP2
	iloDMDPV3v7X8djbH9/Jiw8GxvaaAtVoi/Nv5l7VGO/0UWMqPiIGE+1fRr2QOgJBmMxj1y
	/tfXW8V7L1g3zjW6enMKEhOGt98uf6Q=
Message-ID: <b5647c230e4e2c473dc0ed66390301fafa561911.camel@crapouillou.net>
Subject: Re: [PATCH 3/3] dt-bindings: net: davicom,dm9000: convert to DT
 schema
From: Paul Cercueil <paul@crapouillou.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>,  linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Date: Fri, 14 Jul 2023 17:27:51 +0200
In-Reply-To: <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
	 <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Krzysztof,

Le jeudi 13 juillet 2023 =C3=A0 17:28 +0200, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> Convert the Davicom DM9000 Fast Ethernet Controller bindings to DT
> schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0.../bindings/net/davicom,dm9000.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 59
> +++++++++++++++++++
> =C2=A0.../bindings/net/davicom-dm9000.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 ---------
> =C2=A02 files changed, 59 insertions(+), 27 deletions(-)
> =C2=A0create mode 100644
> Documentation/devicetree/bindings/net/davicom,dm9000.yaml
> =C2=A0delete mode 100644 Documentation/devicetree/bindings/net/davicom-
> dm9000.txt
>=20
> diff --git
> a/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
> b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
> new file mode 100644
> index 000000000000..66a7c6eec767
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Davicom DM9000 Fast Ethernet Controller
> +
> +maintainers:
> +=C2=A0 - Paul Cercueil <paul@crapouillou.net>

Did you decide that by yourself? :)

I do have one of these on my MIPS CI20 board, so I'm fine with
maintaining it - but a head's up would have been nice.

Cheers,
-Paul

> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 const: davicom,dm9000
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Address registers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Data registers
> +
> +=C2=A0 interrupts:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 davicom,no-eeprom:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: Configuration EEPROM is not available
> +
> +=C2=A0 davicom,ext-phy:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: Use external PHY
> +
> +=C2=A0 reset-gpios:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 vcc-supply: true
> +
> +required:
> +=C2=A0 - compatible
> +=C2=A0 - reg
> +=C2=A0 - interrupts
> +
> +allOf:
> +=C2=A0 - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
> +=C2=A0 - $ref: /schemas/net/ethernet-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/irq.h>
> +
> +=C2=A0=C2=A0=C2=A0 ethernet@a8000000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "davicom,dm900=
0";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xa8000000 0x2>, <0x=
a8000002 0x2>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&gph1>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <1 IRQ_TYPE_LE=
VEL_HIGH>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local-mac-address =3D [00 00 =
de ad be ef];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 davicom,no-eeprom;
> +=C2=A0=C2=A0=C2=A0 };
> diff --git a/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> b/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> deleted file mode 100644
> index 64c159e9cbf7..000000000000
> --- a/Documentation/devicetree/bindings/net/davicom-dm9000.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Davicom DM9000 Fast Ethernet controller
> -
> -Required properties:
> -- compatible =3D "davicom,dm9000";
> -- reg : physical addresses and sizes of registers, must contain 2
> entries:
> -=C2=A0=C2=A0=C2=A0 first entry : address register,
> -=C2=A0=C2=A0=C2=A0 second entry : data register.
> -- interrupts : interrupt specifier specific to interrupt controller
> -
> -Optional properties:
> -- davicom,no-eeprom : Configuration EEPROM is not available
> -- davicom,ext-phy : Use external PHY
> -- reset-gpios : phandle of gpio that will be used to reset chip
> during probe
> -- vcc-supply : phandle of regulator that will be used to enable
> power to chip
> -
> -Example:
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ethernet@18000000 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0compatible =3D "davicom,dm9000";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0reg =3D <0x18000000 0x2 0x18000004 0x2>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&gpn>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0interrupts =3D <7 4>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0local-mac-address =3D [00 00 de ad be ef];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0davicom,no-eeprom;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0reset-gpios =3D <&gpf 12 GPIO_ACTIVE_LOW>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0vcc-supply =3D <&eth0_power>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};


