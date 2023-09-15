Return-Path: <netdev+bounces-34128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F67A2393
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C231C20A2B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E77125B1;
	Fri, 15 Sep 2023 16:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA411CBF;
	Fri, 15 Sep 2023 16:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B929C433C8;
	Fri, 15 Sep 2023 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694795332;
	bh=xFP4xP9LgYUNQYWlHLEw+gHE48/2qAyc2EfESi3YoiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONYvrKPbd80wQteDgGA4/C/inRBfN9eLEkTU51VoXcnrs4QWl1IRU7FQOEp/FL9kT
	 DDIRkzvi9g06a8WNelzs4R/OZlsX5jDMIkw4kX80Wa2/vkR5+Awuq8XIADoqzamYaW
	 5k6K6uPdYabwSUxl2ZJREpYDAEGIw+oCxriQKyweKmzoAld0wh3+4GtUGB22UtwHMc
	 YdmwhlPGcsvXWAxbBi3TsTc0FhnODy1d7cHx52xbmLwN+1wxbMZjnT+l62d2VqxjiC
	 anMmFZfFL9QCgoG4XHGROHf6NS0TsPlRlKNXw8ZnFlf8Vf0gdH8Wt3IFMAokM+jdjX
	 txiefVRftqsiw==
Date: Fri, 15 Sep 2023 18:28:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org, sujuan.chen@mediatek.com,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 10/15] net: ethernet: mtk_wed: introduce WED
 support for MT7988
Message-ID: <ZQSGQH5n78e0wpz7@lore-desk>
References: <cover.1694701767.git.lorenzo@kernel.org>
 <330efa9f15a6da8a8e7596d3a942f3e893730e12.1694701767.git.lorenzo@kernel.org>
 <20230915145548.GA3704791-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yyt0PgioCXTYT4h4"
Content-Disposition: inline
In-Reply-To: <20230915145548.GA3704791-robh@kernel.org>


--Yyt0PgioCXTYT4h4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 14, 2023 at 04:38:15PM +0200, Lorenzo Bianconi wrote:
> > From: Sujuan Chen <sujuan.chen@mediatek.com>
> >=20
> > Similar to MT7986 and MT7622, enable Wireless Ethernet Ditpatcher for
[...]
> > -	ring_size =3D dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
> > -	n_pages =3D ring_size / MTK_WED_BUF_PER_PAGE;
> > +	if (!mtk_wed_is_v3_or_greater(dev->hw)) {
> > +		dev->tx_buf_ring.desc_size =3D sizeof(struct mtk_wdma_desc);
>=20
> Instead of checking the version or using of_device_is_compatible() in=20
> other places why don't you define driver match data for all this static=
=20
> data.

ack, I will look into it.

Regards,
Lorenzo

>=20
> Rob

--Yyt0PgioCXTYT4h4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQSGQAAKCRA6cBh0uS2t
rJXiAQCakzUT0GOnyU0/R38SoArHgoeIBl5bxY1xtoxwJOUMgwD/b+t/uUG8UFJk
rErIrPODkOdRCFq961CiUNRTVAzv+w0=
=SpFW
-----END PGP SIGNATURE-----

--Yyt0PgioCXTYT4h4--

