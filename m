Return-Path: <netdev+bounces-33268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17679D3B6
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522D11C20FA9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263215AEA;
	Tue, 12 Sep 2023 14:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3291FB24
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C545DC433C7;
	Tue, 12 Sep 2023 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694529113;
	bh=nCDXCDraqsGo2IZGYAIOuK+jrylfUNs1NltItNEvSsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzfFF5eS0jKjFYDvO5isyKITSFx9Gnoou/xv7WTkxJg7qowQ87WM6A8bDeU4fZUs1
	 v+AU3kBJHoO/qvhkLBzY1LHIpY+mFTnKXIPiUxYl/w3RS3wkGKbFB69UBKlSVcpHoO
	 R9UMiesRBocyKoVCX9r61gVBb0m6a5HpXfKUD+oA6NSEynLpVPIsfvefLOWbcbq1lx
	 JGxEqnf0JXnj8shzNl1oXaeaaONd/2cX0VDR3d3YkhmkxsgAFwQcbMbGIsdIR/eV5I
	 SgC7qCUyKhiuK2IY0LWMINLlX//w2erE1Q9rltkmWhDbYoOgH/htDJbxJx4vH1fshy
	 XtHNCvawzd3Vg==
Date: Tue, 12 Sep 2023 15:31:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH v5 28/31] pinctrl: Add support for the Lantic PEF2256
 pinmux
Message-ID: <71761f94-14ea-4e2a-a079-c74dfa32387a@sirena.org.uk>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912101505.225899-1-herve.codina@bootlin.com>
 <CACRpkdbxdMZt4E1SF1v9as-jw=TpvS1mk2TQqAgywMBLbKaNoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rHoxlvq7D/pkDAXf"
Content-Disposition: inline
In-Reply-To: <CACRpkdbxdMZt4E1SF1v9as-jw=TpvS1mk2TQqAgywMBLbKaNoA@mail.gmail.com>
X-Cookie: Mickey Mouse wears a Spiro Agnew watch.


--rHoxlvq7D/pkDAXf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 01:04:56PM +0200, Linus Walleij wrote:
> On Tue, Sep 12, 2023 at 12:15=E2=80=AFPM Herve Codina <herve.codina@bootl=
in.com> wrote:

> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*

> I think SPDX mandates that you start the tag with C99 comments

> // SPDX-License-Identifier: GPL-2.0-only

Not for headers, they should use C style since they might be included in
contexts where C++ isn't supported.

--rHoxlvq7D/pkDAXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAdlAACgkQJNaLcl1U
h9AGMQf/fLsnOOVZlCeXkVRLWX87qtu4s7nr7P5jfwyYxnA4Bhl8MwftHW5rxDOf
TJcMOnHaQLx46ThWnYrWFopJsLO9g5x+NTP78wZTRCXJaJp4usJtpbNzUm4JAgfr
wJ7T2LLNlVFW5eJfODg+A+sL23DKqJ0B6MwZDixKhNM0tRYibE5ULV+DGzqxyvgz
yBkeRf5GWl9c4qVLP9Qg2VGx/9jbeOjiYGTd3LWeqJ6HxR8EItWZvKS72fGhOw+t
dp3VMrMnK9/HtTllRrE+m9GWdtkjG+FjaBGfp8LhzJ1IvYZb+Hyic+EVrTIQ+aC3
xmRd5GYPdrIG1w50Eci2Fa5Zqd4N4A==
=vkfj
-----END PGP SIGNATURE-----

--rHoxlvq7D/pkDAXf--

