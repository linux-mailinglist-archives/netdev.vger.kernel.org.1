Return-Path: <netdev+bounces-178437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BFAA77037
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127A73A8B40
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4321C17B;
	Mon, 31 Mar 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FuSaIXew"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5358472;
	Mon, 31 Mar 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457357; cv=none; b=t4oqw6vBfh7o+PKwSXkAKtKXSVbtIFGxHFQL2NvlbvfgvR2w50m/nC4Om7aeVmnPeARRrrcUXzY2VP/DqxdLvpnoMyCPrynGvkYCIplWKXXKAajayTCqRS/tjxf4wYPcHyOgf9gJItg5cpFBFc9yLg7fkythr1Nea1Tg9Rup3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457357; c=relaxed/simple;
	bh=eKy1iJR4g5U3s+aFBDikNbhsOoPfWdMM3ym1vPp2i0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGx8myDV3VP0SlSfuOiAk/WuaNPG3zjqrMyR/+2BTQQcwAtBznOc8UnlCBFeP8odvP047PAQNF6vMnU9i7WXb/gJU7/3x+Crw5MOKe0uURmLzdKSXTFKZsG7qAA0VZiNK5ryeO6pAN2Kg74i/77jVBJXNfuavF2chTH1yb+w0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FuSaIXew; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C99410252BE4;
	Mon, 31 Mar 2025 23:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743457353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UCntAeEomuMLgqZmqZj4SrvGP+3DLTO8xxLbbymA6n8=;
	b=FuSaIXewAfF7+H7TSOGHjWpA+pkSIOEwwXyr4uTcTv25w23zJORlyoZajX3yHZ9cxSFd/h
	TRg/I1Bum6UAfwWPzsTmbQOGMTvdldauacrYXlWWyzysy+LqoPAPa7OIYAdLbM2AHvM1mn
	esi3dRDPCrS8TE9Pyt7YGBWySxHpfaZGRotIdeC8zCK/dQULXeiQLU5XvTIJd+aUgufKQd
	6Oxyft17aC5rtHT6vRBlmSLWXkHX6SHTy/FiVzQN6atxZtlgnfbcHIsMVWxPnC82lrnq6/
	pvh23yqBTVlI1/pgsIYjelfif3LZod1cKxlnUJgSpoybxWWyRdz0dbfJEFOCdQ==
Date: Mon, 31 Mar 2025 23:42:28 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
Message-ID: <20250331234228.5d8249ac@wsk>
In-Reply-To: <ec703b87-91a4-4ed0-a604-aceb90769ab0@gmx.net>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331101036.68afd26a@kernel.org>
	<20250331211125.79badeaf@wsk>
	<ec703b87-91a4-4ed0-a604-aceb90769ab0@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/okte2gjYXUvf+jGnOR83L_j";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/okte2gjYXUvf+jGnOR83L_j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> Am 31.03.25 um 21:11 schrieb Lukasz Majewski:
> > Hi Jakub,
> > =20
> >> On Mon, 31 Mar 2025 12:31:12 +0200 Lukasz Majewski wrote: =20
> >>> This patch series adds support for More Than IP's L2 switch driver
> >>> embedded in some NXP's SoCs. This one has been tested on imx287,
> >>> but is also available in the vf610. =20
> >> Lukasz, please post with RFC in the subject tags during the merge
> >> window. As I already said net-next is closed. =20
> > Ach, Ok.
> >
> > I hope, that we will finish all reviews till 07.04, so v4 would be
> > the final version. =20
> well i appreciate your work on this driver,

Do you maintain some vf610 or imx28 devices, which would like to use L2
switch?

> but this is not how it's
> going to work. No version of this patch series had a review time of a
> week.

I just pointed out that patches would not be pulled (or anything else
would be done with them) until the merge window is re-opened.

> It's about quality not about deadlines.
>=20

:-D

> Regards

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/okte2gjYXUvf+jGnOR83L_j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfrDEQACgkQAR8vZIA0
zr3zwggAgZ8Wu0bOaQkLLopJTM9SIopbyU4MrpYpKkdbWhImV32dIF9o6jegDmy0
e/o+Pm2UHCf5eoGg5BuqSjiGZ0tPXSHPMWn6j82p6AtMWaHLq8taHYdJcLBXM/uW
Gyrg1W9Vedntq/vh2vigjnBod/vvmFbSEZgPX4tPMckPvaATJy7BwD04HnvdR5aU
TfXVgDB4KeS13WGXI0wfSadRBUS6AjhAtj93SeQcbbhWOG8hRLvzFaVPKvF5pRzF
UDK1yojMqgDgpAfvCuz2EUH+r8olSz8EAui3nhyMhyI/nqp6HY6VQtkFZOdY9vYu
xUNZIw4qn2L3rsFBbxsdxrDzj3MLuw==
=7djP
-----END PGP SIGNATURE-----

--Sig_/okte2gjYXUvf+jGnOR83L_j--

