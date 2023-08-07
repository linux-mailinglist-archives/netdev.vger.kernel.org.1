Return-Path: <netdev+bounces-24958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A177251F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82F51C20C07
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A3101FE;
	Mon,  7 Aug 2023 13:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817B10781
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A0C433C8;
	Mon,  7 Aug 2023 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691413808;
	bh=+ylZyoYYRfcm6fV2c5Chg3oeks3UOFVe6ienNx0Fhmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptPcngcyFrXPhfW+uAcklMgxyhnPVyuRFGiByyYxP0vv5fqTTBf1C+4ZecNjaXNCU
	 x5dexojsK7ip6GaiKDXtsaoPTYSzIcInPyoG7TA1F5LhXIZeJNLz4vhFA354hQ91bs
	 jlsfMHj4h4bMB1a/aQ3hV8/OzE/8wWOiZVToK/QLyt9vfOvmf665T9kjIbKegLgNdG
	 EZ4JdpqVL7wvyWODD+mDyu8mLQ22wCFOdQmTWgvbGeolnFdDe+TK/BROYHkQNEskI5
	 tUJXXtpYQAPIshCzIIkr5tAXQJJ/v2mXmUc9Kz2LqqQ5og6ku6/LbuVEVnS+gnoIru
	 0Ov9IDZ3B4O+w==
Date: Mon, 7 Aug 2023 14:09:58 +0100
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256
 pinmux
Message-ID: <8f80edf2-c93d-416f-bcab-f7be3badf64a@sirena.org.uk>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com>
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTPmHke3dW8il9IP"
Content-Disposition: inline
In-Reply-To: <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
X-Cookie: idleness, n.:


--jTPmHke3dW8il9IP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 03:05:15PM +0200, Linus Walleij wrote:
> On Wed, Jul 26, 2023 at 5:04=E2=80=AFPM Herve Codina <herve.codina@bootli=
n.com> wrote:

> > +#include "linux/bitfield.h"

> Really? I don't think there is such a file there.

> Do you mean <linux/bitfield.h> and does this even compile?

#include "" means "try the local directory first then fall back to
system includes" so it'll work, it picks up extra stuff on top of what
<> does.  There's a stylistic issue though.

--jTPmHke3dW8il9IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ7SUACgkQJNaLcl1U
h9Cgmwf/SLPNpdzBUj796oCGdE0sLv3Wx6OOJqUx6r7OcXxbdmI57ntyLtd42nrN
Bto5bvnu1D1GkKvkmyy+3qu8xEk9s7C2T9S8wddibRU4Ltzcda/eNPj7PwZuLuj1
0z8caed2ZZTmxKQJzHev6bV798Prre1UC1Wu8xTev1OLJpck8z68ITezl6gh97ma
TFmBFQx8ZozN8KVhSTI49Oc5lUUWGJC/CYjNSASRYYC5Wm/bSfAfdDHclNhQLaW9
7VQNOvJvO5CmbCu7s0dq39QvEWgoC2sm0Cx8ZWUpHxjKZVyWbnfMr0sMyPwgLtWb
vb6uLwRLtAlanfRgULyEgNLTnZ+BIw==
=+n7M
-----END PGP SIGNATURE-----

--jTPmHke3dW8il9IP--

