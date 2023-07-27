Return-Path: <netdev+bounces-21801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA7764C96
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB831C215A1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7FFBEE;
	Thu, 27 Jul 2023 08:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C101FBEC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5238C433C8;
	Thu, 27 Jul 2023 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690446007;
	bh=ZOrVyIMfU4XpSn7UdLHa8hRU7oEBnQJsIPlHeRvuFcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHBQpkdojMRAPtSSVOI2WRnZN/AvXm08ZGy/3AMvUkfeEDcPsrHPGTekUyW5fXJxJ
	 zdCTcLMIRhvFYCbBMh4fLTN/Splo6c8g7EpZUzV+kc3CWBEA9+e87aztnL7Pnando+
	 pwIu0dDAaTMZGUJpqT7v9ut6SYL3i3U0Lok2Ul2QmbFjy/c+qomP7DFNMWOB3UHcT+
	 W/OUOtWHyqFJfluyEgawYuM9loJtKVM7uM3V+VQ0I9nzojooaE7vyShQC2nj6AT86L
	 oYjCYV5xUeE+UK2ny6qdJMEbyR0c7Mfu2nsJKb4l9IqecATQzsXax4HK0eXNkTiSJ0
	 dqlMmnFwcjcow==
Date: Thu, 27 Jul 2023 09:19:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230727-talcum-backside-5bdbe2171fb6@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DM6e+RDa3XBbMs9a"
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-6-herve.codina@bootlin.com>


--DM6e+RDa3XBbMs9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 05:02:01PM +0200, Herve Codina wrote:
> The QMC (QUICC mutichannel controller) is a controller present in some
> PowerQUICC SoC such as MPC885.
> The QMC HDLC uses the QMC controller to transfer HDLC data.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Do=
cumentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> new file mode 100644
> index 000000000000..8bb6f34602d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QMC HDLC

"QMC HDLC" seems excessively terse.

> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to tra=
nsfer
> +  HDLC data.
> +
> +properties:
> +  compatible:
> +    const: fsl,qmc-hdlc
> +
> +  fsl,qmc-chan:

Perhaps I am just showing my lack of knowledge in this area, but what is
fsl specific about wanting a reference to the channel of a "QMC"?
Is this something that hardware from other manufacturers would not also
want to do?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to QMC node
> +          - description: Channel number
> +    description:
> +      Should be a phandle/number pair. The phandle to QMC node and the Q=
MC
> +      channel to use.
> +
> +required:
> +  - compatible
> +  - fsl,qmc-chan
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdlc {
> +        compatible =3D "fsl,qmc-hdlc";
> +        fsl,qmc-chan =3D <&qmc 16>;
> +    };
> --=20
> 2.41.0
>=20

--DM6e+RDa3XBbMs9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMIorwAKCRB4tDGHoIJi
0qkLAQC6sDWnGDv+x5El1pIJ5VwJJnPS/IZlV0Qs715IhJHxvwEAzt3hBjT6R02J
luBI20Rzy9YB7KndWqGrmYR7rVtFKgk=
=8ut0
-----END PGP SIGNATURE-----

--DM6e+RDa3XBbMs9a--

