Return-Path: <netdev+bounces-21780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE7764BA3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5171C21580
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C5107BF;
	Thu, 27 Jul 2023 08:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DDD518
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516EEC433C8;
	Thu, 27 Jul 2023 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690445529;
	bh=tnGIkZ0IfVSxC+Yq+6QYwbRcNs+y3LaIpY7itDA1DY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3X0c1vs3a2ExMXkrF+1tcbDsnN2aqJCcQvv2E42gHFtthXoxHT+jaSco+ZogIg0G
	 w7tGNnMsZDib2IGYF984hf9xZSY5adT9vxpurLoOMGGSONNQFd8WdhzgsuAmXgk49K
	 dMaePLC2CGqQT2i6n9Et/bGw1iCT+XmtAMUlBT4nI1PHdiAY5WWzAFBFfDovs3hpXv
	 VjrgM0AtFh5s4anoNx0c7HbquZbJdD7PnTZfXSJhncYy2kd13o4lyvqr8/JOKnY3vL
	 zIUldsQfgz0SOIYaMa8Oar3jUOZj5tjJxq7oN5ca+/JEtWuvauejQ5M5bDpTAv+tlm
	 KMdwa+ZVqnw1A==
Date: Thu, 27 Jul 2023 09:12:01 +0100
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
Subject: Re: [PATCH v2 27/28] dt-bindings: net: fsl,qmc-hdlc: Add framer
 support
Message-ID: <20230727-jailer-recede-a62ab2238581@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-28-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eYAsfQrSrlZJPeWa"
Content-Disposition: inline
In-Reply-To: <20230726150225.483464-28-herve.codina@bootlin.com>


--eYAsfQrSrlZJPeWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 05:02:23PM +0200, Herve Codina wrote:
> A framer can be connected to the QMC HDLC.
> If present, this framer is the interface between the TDM used by the QMC
> HDLC and the E1/T1 line.
> The QMC HDLC can use this framer to get information about the line and
> configure the line.
>=20
> Add an optional framer property to reference the framer itself.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Why not fully describe the hardware in one patch in this series, rather
than split this over two different ones?

> ---
>  Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Do=
cumentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> index 8bb6f34602d9..bf29863ab419 100644
> --- a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> @@ -27,6 +27,11 @@ properties:
>        Should be a phandle/number pair. The phandle to QMC node and the Q=
MC
>        channel to use.
> =20
> +  framer:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the framer node
> +
>  required:
>    - compatible
>    - fsl,qmc-chan
> --=20
> 2.41.0
>=20

--eYAsfQrSrlZJPeWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMIm0AAKCRB4tDGHoIJi
0kUJAPwNtjLVJN1zsHlbb6aaExnJrN4N1c/y81aSzDXGP/5mtwD/ZlFY9Kf3kK6f
ZSCmoVzzU0F7LpDiZu5VLWEDSKophAY=
=Scw7
-----END PGP SIGNATURE-----

--eYAsfQrSrlZJPeWa--

