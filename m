Return-Path: <netdev+bounces-33638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A276D79EFC8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9342826E3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65F1F954;
	Wed, 13 Sep 2023 16:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A1AD52
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ACFC433C8;
	Wed, 13 Sep 2023 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694624397;
	bh=BnteqCpF/CAUK7DK9U9Ghtfp5dt4d9MfOz2/eAS/u7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPc5I0ZLysgdFaSm9d3iPjGsHib6No1WDfTfDNmZ8EJftw2ukgPJqbdTvFwfII6h5
	 XsjFCfQwy0hAhvcNI/zC1jAxOZx+xj3WkJy3PnXdFgBaTdKUmzEXfr8r119FUpA9ws
	 uEyzFAjE2f/LP5rj9F/N4Be4pbP/BK9uPoheaZ2R88lgsiTu9NUbtgyaz2XOX1oPZT
	 eklyhY3ZUUL2hQtxVd/re7fFxkttitCrig5ohr9Pm1WOgM5lChR8UOojrbVvjicS9G
	 gipMxf05N4nYGfN5v5g6bWOTb7T8iOMYlMWHXGVTPRzp+C5LHyalJK3Qgj/yIop80d
	 GuvQxVLkJ3wdg==
Date: Wed, 13 Sep 2023 17:59:48 +0100
From: Mark Brown <broonie@kernel.org>
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
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Simon Horman <horms@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 24/31] net: wan: Add framer framework support
Message-ID: <e3245053-1d4c-4ee3-9e03-8a6ca54e26d1@sirena.org.uk>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912101436.225781-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3d4xnD0OBUXwj5Mp"
Content-Disposition: inline
In-Reply-To: <20230912101436.225781-1-herve.codina@bootlin.com>
X-Cookie: Use extra care when cleaning on stairs.


--3d4xnD0OBUXwj5Mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:14:36PM +0200, Herve Codina wrote:
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.
>=20
> The framer framework provides a set of APIs for the framer drivers
> (framer provider) to create/destroy a framer and APIs for the framer
> users (framer consumer) to obtain a reference to the framer, and
> use the framer.

If people are fine with this could we perhaps get it applied on a branch
with a tag?  That way we could cut down the size of the series a little
and I could apply the generic ASoC bit too, neither of the two patches
have any dependency on the actual hardware.

--3d4xnD0OBUXwj5Mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUB6oMACgkQJNaLcl1U
h9C6Xgf/eVzH2ZK88zsRlmvtdc+p6XZjgKPJFkUlIhE9Ma70SkaA+GvjpzFrSISC
0oFzEllaNXg3QA5Dql2eFFYQgtr5ubist5gEg7ySisIk/3GFEx1+bOqfE8Hd0wxS
EOmSRrnORoEywUsp1tI/CIh6s+FkPAwH0ZLtXwvWiKeWjQc8q9wKDnqqahC84N6Q
NESewhcaX2cQNfQXdyKGrnV9RVVSaVml3mQ4OvcjG21+FFq8IFvmn1HuLyhzj7ka
ACjNRWS9xgBsIqVyOOaYB2Ji62cf+WK4/DJig11BI34n9N7Tnbi80+kb0JX/WVno
ncpqIK4/jpD4JNn+BxeAIiICNG0cQw==
=nBcU
-----END PGP SIGNATURE-----

--3d4xnD0OBUXwj5Mp--

