Return-Path: <netdev+bounces-186685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D240AA0564
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9861170BF5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9027A931;
	Tue, 29 Apr 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gFr5oOyM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34736274FF3;
	Tue, 29 Apr 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914796; cv=none; b=AAoxWsYBG2rCoFG01lzWMIOZlyn0D+iNISdW4kxD/zaSu35HB291AAGMnEOdEPI1f/AiQDSiq1SKREkAwtWjkj6v7iCeSjH33D2jN1YMoD8M3CUZIlyqeY0vYoujRDJh1xo63Px9J5oQ6CvK/CzugkBNNVXrtGQFoC3F+MHce2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914796; c=relaxed/simple;
	bh=kqErvxenmG2YIQeaLjoSCbGuE3CwAGrl7IeChf0Jkxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGrXLwdSCerUcjVErDVISPeUjrCN9xrtjouKdF4uRyZuXYy7l1R/KGNi7amcR17ZaS494eL11COdAjm49K86wSUmu8brYIkjr3lD0HogEdvQOUCoS5BmJhwITyTb2u1z8GgxtYIlAwHpP2rjqL9I+qapnv7oSqsT1fIaGqAY/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gFr5oOyM; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C94F110271400;
	Tue, 29 Apr 2025 10:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745914785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Xe+5znHVUqk5GYGgi3E2U343rq4B5qNUfQk8zHOXAdQ=;
	b=gFr5oOyMT8linriMuZr4uL8ElmpqxoxstsyXFpKtaJBbO/PHV0+T/mvjKtJIq0pW7818vo
	fKP1kr190BR1IYMiH+OBIRxpV0dBeHoDWDV7S1N6R6qqdYAsYd6r39YGf5uGyjCPQa27VD
	RDTRJsd+oTkMZOY5TrV7Tg6outSqHIHlVUnqm1WIq7+6fpnER7bCYnNaVISTyqZRVIwOFs
	PUt1eZwWSGb0Zpfnojzid/sB4N003pyGEZDQs/Xlg3OiuzqdM/Qa6Z2Lbbvm7vnf2Ga3fT
	GJQ19qKKbF2BleEtlQaAzpYVTmp646Uxr1rnI8AB2R/o1Vr/baw76GJE70KLLQ==
Date: Tue, 29 Apr 2025 10:19:38 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v8 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250429101938.54790e51@wsk>
In-Reply-To: <20250428132932.273fc568@kernel.org>
References: <20250428074424.3311978-1-lukma@denx.de>
	<20250428074424.3311978-5-lukma@denx.de>
	<20250428132932.273fc568@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7C5c+VP_Ssr.yXpqT9xQXe/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/7C5c+VP_Ssr.yXpqT9xQXe/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Mon, 28 Apr 2025 09:44:21 +0200 Lukasz Majewski wrote:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >=20
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >=20
> > It can be used interchangeably with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >=20
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data to/form switch (and then switch sends them to
> > respecitive ports).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch> =20
>=20
> Linking fails with allmodconfig
>=20
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.o WARNING:
> modpost: missing MODULE_DESCRIPTION() in
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.o ERROR: modpost:
> missing MODULE_LICENSE() in
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.o WARNING: modpost:
> missing MODULE_DESCRIPTION() in
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.o ERROR: modpost:
> "mtip_forced_forward"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_port_learning_config"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_port_blocking_config"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_port_enable_config"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_port_broadcast_config"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_port_multicast_config"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_switch_en_port_separation"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_register_notifiers"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_unregister_notifiers"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw.ko] undefined! ERROR:
> modpost: "mtip_is_switch_netdev_port"
> [drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.ko] undefined!
> WARNING: modpost: suppressed 3 unresolved symbol warnings because
> there were too many)

Yes, you are right.

I've adjusted makefile to build it properly as a module.

Thanks for spotting it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7C5c+VP_Ssr.yXpqT9xQXe/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgQi5oACgkQAR8vZIA0
zr0EhQgAlT/wbAiGajLapmWxKuLFGzpGBN8yTQAWZkR4q5Av8pTGrIofsvMVyke5
CAsy+yyi3ZJTiuqTKCKQYolWV3uFnFxiUhyy/s1V/8gJqZFPUx3H3p/vC1ezXORM
f6gWiBdCwYS9e3FPbAY8UFo8oaIjF9O3ec020NvIeCbBXYTy5KOyp+Vbpkifc3uj
Ns3T/3nqxmuzg6OyIos2sJIi/NUc6z9ihZV5wyg9AyOBccteEsIfTWamUSKNj/i8
2GyU4WiMR8/h9lOiXB+wtrCQ9m8DtpnrfBNek1bOuIZgZr7yQhh7A2pUqRk698NS
zC79DNTenk6v6L6vNX/Ii47rbfis/w==
=llBU
-----END PGP SIGNATURE-----

--Sig_/7C5c+VP_Ssr.yXpqT9xQXe/--

