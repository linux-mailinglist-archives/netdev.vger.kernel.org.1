Return-Path: <netdev+bounces-197867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872AADA167
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC018914F7
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B25263C75;
	Sun, 15 Jun 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Fvdouv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F517EEB1;
	Sun, 15 Jun 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977803; cv=none; b=LqcxaYoGYZ3Fnj+Hje207zkV5cSAuzfDmjueLwOOlmpOidjlgvAdid85nqt1PHibhCdPCUhn5AdFDC+V1I0/yIcnnzkz7XmLCXRxL3Fdt+/+BATFnQiXztApJeOIP4HSnRZHT1Lqsa3OQiVde2pb75/kmvfb1WDftvwbcDgbj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977803; c=relaxed/simple;
	bh=G2CDdBbRrmYymKS4L5Z4OVIYHkFBoX38/5rv04VfCpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwOFN1sCGdmjUWYTE/xBGT9+sfcwjexV0309F7LUvN/lybw8WHck+Av3ZS92LlyYfvMHsRsje/T3tZkTWYYmvr3sq1X01dn4k+g9VOnfVE/3fgx6Fg21PFTNfN6RNvU45uCtBbtkWE19t3/llpOm+FKalR5uk4UHl0omx3pOUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Fvdouv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68726C4CEE3;
	Sun, 15 Jun 2025 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749977801;
	bh=G2CDdBbRrmYymKS4L5Z4OVIYHkFBoX38/5rv04VfCpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2Fvdouvgn3r/weCireAnZIeyq5rji8be5bBBFkperf6upHh+O0b+IGoonxz7FHce
	 ul7aAmFeC58duwkGPg4Zt56d33Nj9vOBn/l7MmSbqON5qJKcBbfyGvSfvTUDPznL9h
	 PuPu8viqNCnlFwT+TKOze+nhoKlR56iNDl+01jNj6zLNpUdImswW9oSAHpGFnUhwma
	 5ipmT0I1M3kK5xQEk5gALXoRC+rl3tMtgpjqBxqf9jAdgMY67ZoX0jncrLW6HXPNz0
	 Xic0KTt5q1rcIcle+Ms53uoheWeFSB2kxlSbgNftSdIzXUx94HFXgKMh3ubVuWBZjc
	 xlVXWqQGdZNTQ==
Date: Sun, 15 Jun 2025 10:56:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org
Subject: Re: [net-next v1] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <aE6Kx4JHyEmDY2mQ@lore-desk>
References: <20250613191813.61010-1-linux@fw-web.de>
 <aE0pav5c8Ji1Q7br@lore-rh-laptop>
 <E6B6CB88-4B47-455D-9554-DE9BFC209454@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W2SN/lL0wh+oroZo"
Content-Disposition: inline
In-Reply-To: <E6B6CB88-4B47-455D-9554-DE9BFC209454@public-files.de>


--W2SN/lL0wh+oroZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 14, Frank Wunderlich wrote:
> Am 14. Juni 2025 09:48:58 MESZ schrieb Lorenzo Bianconi <lorenzo@kernel.o=
rg>:
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>=20
> >> Add named interrupts and keep index based fallback for exiting devicet=
rees.
> >>=20
> >> Currently only rx and tx IRQs are defined to be used with mt7988, but
> >> later extended with RSS/LRO support.
> >>=20
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 24 +++++++++++++--------
> >>  1 file changed, 15 insertions(+), 9 deletions(-)
> >>=20
> >> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net=
/ethernet/mediatek/mtk_eth_soc.c
> >> index b76d35069887..fcec5f95685e 100644
> >> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> >> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> >> @@ -5106,17 +5106,23 @@ static int mtk_probe(struct platform_device *p=
dev)
> >>  		}
> >>  	}
> >> =20
> >> -	for (i =3D 0; i < 3; i++) {
> >> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> >> -			eth->irq[i] =3D eth->irq[0];
> >> -		else
> >> -			eth->irq[i] =3D platform_get_irq(pdev, i);
> >> -		if (eth->irq[i] < 0) {
> >> -			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> >> -			err =3D -ENXIO;
> >> -			goto err_wed_exit;
> >> +	eth->irq[1] =3D platform_get_irq_byname(pdev, "tx");
> >> +	eth->irq[2] =3D platform_get_irq_byname(pdev, "rx");
> >
> >Hi Frank,
> >
> >doing so you are not setting eth->irq[0] for MT7988 devices but it is ac=
tually
> >used in mtk_add_mac() even for non-MTK_SHARED_INT devices. I guess we ca=
n reduce
> >the eth->irq array size to 2 and start from 0 even for the MT7988 case.
> >What do you think?
>=20
> Hi Lorenzo,
>=20
> Thank you for reviewing my patch
>=20
> I had to leave flow compatible with this:
>=20
> <https://github.com/frank-w/BPI-Router-Linux/blob/bd7e1983b9f0a69cf47cc9b=
9631138910d6c1d72/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L5176>

I guess the best would be to start from 0 even here (and wherever it is
necessary) and avoid reading current irq[0] since it is not actually used f=
or
!shared_int devices (e.g. MT7988).  Agree?

>=20
> Here the irqs are taken from index 1 and 2 for
>  registration (!shared_int else only 0). So i avoided changing the
>  index,but yes index 0 is unset at this time.
>=20
> I guess the irq0 is not really used here...
> I tested the code on bpi-r4 and have traffic
>  rx+tx and no crash.
>  imho this field is not used on !shared_int
>  because other irq-handlers are used and
>  assigned in position above.

agree. I have not reviewed the code in detail, but this is why
I think we can avoid reading it.

>=20
> It looks like the irq[0] is read before...there is a
>  message printed for mediatek frame engine
>  which uses index 0 and shows an irq 102 on
>  index way and 0 on named version...but the
>  102 in index way is not visible in /proc/interrupts.
> So imho this message is misleading.
>=20
> Intention for this patch is that irq 0 and 3 on
>  mt7988 (sdk) are reserved (0 is skipped on=20
> !shared_int and 3 never read) and should imho
>  not listed in devicetree. For further cleaner
>  devicetrees (with only needed irqs) and to
>  extend additional irqs for rss/lro imho irq
>  names make it better readable.

Same here, if you are not listing them in the device tree, you can remove t=
hem
in the driver too (and adjust the code to keep the backward compatibility).

Regards,
Lorenzo

>=20
> >Regards,
> >Lorenzo
> >
> >> +	if (eth->irq[1] < 0 || eth->irq[2] < 0) {
> >> +		for (i =3D 0; i < 3; i++) {
> >> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> >> +				eth->irq[i] =3D eth->irq[0];
> >> +			else
> >> +				eth->irq[i] =3D platform_get_irq(pdev, i);
> >> +
> >> +			if (eth->irq[i] < 0) {
> >> +				dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> >> +				err =3D -ENXIO;
> >> +				goto err_wed_exit;
> >> +			}
> >>  		}
> >>  	}
> >> +
> >>  	for (i =3D 0; i < ARRAY_SIZE(eth->clks); i++) {
> >>  		eth->clks[i] =3D devm_clk_get(eth->dev,
> >>  					    mtk_clks_source_name[i]);
> >> --=20
> >> 2.43.0
> >>=20
>=20
>=20
> regards Frank

--W2SN/lL0wh+oroZo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaE6KxgAKCRA6cBh0uS2t
rLW+AQDpfSGh+NZyjhOon4w6ir5aDO+JYLtW9pWA+9lJDd2t5wEA9rEPWrWqDis0
Vagdhcg9+7wUZX87d/XZ4CDvFcRaxgI=
=ITe8
-----END PGP SIGNATURE-----

--W2SN/lL0wh+oroZo--

