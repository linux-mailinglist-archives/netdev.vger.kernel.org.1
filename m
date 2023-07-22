Return-Path: <netdev+bounces-20128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299275DBFB
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC541C211BB
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1E18AF5;
	Sat, 22 Jul 2023 11:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98162A
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 11:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E5C433C7;
	Sat, 22 Jul 2023 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690026436;
	bh=qEBn6e+fYz7AhV051ZDXT5ospKb3k9meMO3A37lVuJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2RDHwQcwB/hLm5ypoZMeeWNVB4tQO9WizZ0URooeHAORKqFh15tFh0Or0jb2ZfkS
	 cMp4BYRk0nDvV5F0mjuLFC5TffS3fxDPqBYx9O9aJiNZ2ejRMokZCdVJG9U73+DXUF
	 ubg9ETXOapXptJTnpVsGsaRjuby9kuZJcI3fZk1wxTg0S7b3K20Znsj4io7IUQGljY
	 pMiIBKZAIvQSqn9UIahDsxYgjXG310C8xvcw6yKASZ9qhB7hGapHbEaPGhsGo/uJ7p
	 Hvpl3cWiaYgtNQJ4LCq2ACFH2HKqBcnpKL7Ht7z2kGapeb7dYqMw/QB9xpvwViuC2+
	 RfGWIWgrH/w1w==
Date: Sat, 22 Jul 2023 12:47:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Greg Ungerer <gerg@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Message-ID: <20230722-blip-sleet-8c3a75b1c911@spud>
References: <cover.1689974536.git.daniel@makrotopia.org>
 <5a333fa431562efed461ec5a987d6982db2ed620.1689974536.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S3k3Sb20TyWQtpEz"
Content-Disposition: inline
In-Reply-To: <5a333fa431562efed461ec5a987d6982db2ed620.1689974536.git.daniel@makrotopia.org>


--S3k3Sb20TyWQtpEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 10:32:10PM +0100, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-KR or 10GBase-KR.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--S3k3Sb20TyWQtpEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvBvQAKCRB4tDGHoIJi
0rTAAQDHnk1AXL1i3JuZmYT+/xX+kwzUCVfTJwQJkX31Ipzx2gD+OJ94P3rAvdSL
gWeUD5nqQVtppRlDGSgQ2QX6lSK3Dww=
=dmf1
-----END PGP SIGNATURE-----

--S3k3Sb20TyWQtpEz--

