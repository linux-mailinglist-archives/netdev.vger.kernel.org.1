Return-Path: <netdev+bounces-144895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16A9C89FC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808A1B27791
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444791F9AA6;
	Thu, 14 Nov 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPR/fBQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E51F9A8D;
	Thu, 14 Nov 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587377; cv=none; b=GALgQhglJOOnbar6GCCERysJNarEoyjLBEJdini2oGrLpjm1n7ZuxF8pGZ0y6bQQFJibVVg07BDFaKnTR3IZ8o9QohE+Y0/BjPfWPoVSe6k9KVDOwsUk5o4gsde3kz+/4L07jmvJMFmgdR+sEdDKbexYglcjuXbVxkMguDgoQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587377; c=relaxed/simple;
	bh=jO8wO2u4TzSToVkvP8mnOBJEASwGFrGljAE99wHmaPE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=TDU5lMZoFXNzCxlufGBtS6feQSpDQ78hKRfiyMSzV2WkKqtU9vBVsLr4SAjmgqVpV0JsGB/ucitxmmo5MKUTdOnlF8Z8xtrDvX4O8gKRBdhjISVp/BqEbtUw9Jh+5+bg2ifSVPpoJGbML0Hd1WY/U8Mhnl2mXmy7foLbr8lGp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPR/fBQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DD9C4CECD;
	Thu, 14 Nov 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731587376;
	bh=jO8wO2u4TzSToVkvP8mnOBJEASwGFrGljAE99wHmaPE=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=SPR/fBQd80bXXGD5IPBlR4X7HFTjYE5PHfr8245sbYTmj+g0esjtnIiss+qf2ZyKD
	 HOdgQ4qZ5mJNnB+ExZV0XFEfEhFYayh4LFv8vHeMCLExPg2baQW835vkCWkNHYacNy
	 Ms8uvo9fWQZPskkh23D2w93r6TlksldOU1u65ij5sM8uIdFwHRhQJeKu+PgJCowB1M
	 9be93vxQCvQnfAzgoTUFzEteB1ZbvyQnHgN58FKyDI2OBBAjTIVctfgMZjRIER6h9W
	 a/9oa/sbht8PM9Xn/zHOK2euCD8uxgKuQbjnsGV8HXemsHCmd9CuI8PZmdBsrIpRkL
	 W+P0WM8igLjhg==
Content-Type: multipart/signed;
 boundary=52ace44e12075fa8225f0041c53d0c91369398e0eb41fb0d755839799c8c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 14 Nov 2024 13:29:32 +0100
Message-Id: <D5LWHT7OU9DQ.NCMSTUWT5991@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Set mediatek,mac-wol on
 DWMAC node for all boards
Cc: <kernel@collabora.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "Biao Huang"
 <biao.huang@mediatek.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Jose Abreu" <joabreu@synopsys.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>, "Andrew Halaney" <ahalaney@redhat.com>,
 "Simon Horman" <horms@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
X-Mailer: aerc 0.16.0
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com> <20241109-mediatek-mac-wol-noninverted-v2-2-0e264e213878@collabora.com> <bdbfb1db-1291-4f95-adc9-36969bb51eb4@collabora.com>
In-Reply-To: <bdbfb1db-1291-4f95-adc9-36969bb51eb4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--52ace44e12075fa8225f0041c53d0c91369398e0eb41fb0d755839799c8c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Nov 14, 2024 at 10:26 AM CET, AngeloGioacchino Del Regno wrote:
> Il 09/11/24 16:16, N=C3=ADcolas F. R. A. Prado ha scritto:
> > Due to the mediatek,mac-wol property previously being handled backwards
> > by the dwmac-mediatek driver, its use in the DTs seems to have been
> > inconsistent.
> >=20
> > Now that the driver has been fixed, correct this description. All the
> > currently upstream boards support MAC WOL, so add the mediatek,mac-wol
> > property to the missing ones.
> >=20
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   | 1 +
> >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  | 1 +
> >   arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1 +
> >   3 files changed, 3 insertions(+)
> >=20
>
> ..snip..
>
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/=
boot/dts/mediatek/mt8195-demo.dts
> > index 31d424b8fc7cedef65489392eb279b7fd2194a4a..c12684e8c449b2d7b3b3a79=
086925bfe5ae0d8f8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > @@ -109,6 +109,7 @@ &eth {
> >   	pinctrl-names =3D "default", "sleep";
> >   	pinctrl-0 =3D <&eth_default_pins>;
> >   	pinctrl-1 =3D <&eth_sleep_pins>;
> > +	mediatek,mac-wol;
>
> The demo board has the same WoL capability as the EVK, so you can avoid a=
dding the
> mac-wol property here.

Not sure I can follow you here.

>
> >   	status =3D "okay";
> >  =20
> >   	mdio {
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.=
dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> > index e2e75b8ff91880711c82f783c7ccbef4128b7ab4..4985b65925a9ed10ad44a6e=
58b9657a9dd48751f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> > @@ -271,6 +271,7 @@ &eth {
> >   	pinctrl-names =3D "default", "sleep";
> >   	pinctrl-0 =3D <&eth_default_pins>;
> >   	pinctrl-1 =3D <&eth_sleep_pins>;
> > +	mediatek,mac-wol;
>
> I'm mostly sure that Kontron's i1200 works the same as the EVK in regards=
 to WoL.
>
> Michael, I recall you worked on this board - can you please confirm?

I'd say so. Honestly, I've never tried WoL on this board, but I'm
not aware of any difference to the *demo* board (not the EVK).

-michael

--52ace44e12075fa8225f0041c53d0c91369398e0eb41fb0d755839799c8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZzXtLRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iWHAF9EGqmrI+ZjOLTQX1iNMNp1lIL3a30zG0Z
fCfLfeCWZL2+RRWPcly4R/8op414wophAYCl6jD4W7sXAYn0uTQU69C8uyAyzQus
LYNR9AIEedX7Y537PxIcEpLeEJ++qmkDDo8=
=xSul
-----END PGP SIGNATURE-----

--52ace44e12075fa8225f0041c53d0c91369398e0eb41fb0d755839799c8c--

