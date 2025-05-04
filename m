Return-Path: <netdev+bounces-187630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCCAA861C
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 12:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623C61896927
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE51A5BB6;
	Sun,  4 May 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bSHe0DDO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6219CD13;
	Sun,  4 May 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746355716; cv=none; b=sI+T59/2kpizuBHwd34KmdV1zNa0RABhQ9xudq3lhH5xwh0zGwpvIQlZ5rKz30do+lPYCJ0cXS+rcfp/WFIrKX6bwoq1P8JGfz9W6cpncXPrilh3DdeRfnfFAWcIuOkc1gQKXScO8H0/13NFiif99hwNki6t4xmO8kJHtvkvtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746355716; c=relaxed/simple;
	bh=yohRdADPEvKcn1OgbYLsZmUTUK2TESb0qM0A8LJcYPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBApubTDHGEKyBg8/G5VL3hukoXGVXLwqw4xlD94sfedmp1Wh9Wi1rBsTwZVYLOSp2+LNNSNWO8ZKNfQaFXyTaWbnv674qkmjFoRV2B0+0vUsf81g7rDRuFTdUJqQoihpC0ud8MFqnuqn3ufSeNxyCbVERn6jxO5RjynoT1+pqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bSHe0DDO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F789102EBA58;
	Sun,  4 May 2025 12:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746355712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oyfspuUXsvtxwACFp2OjNa2e1i5qQ9TaWwXqk1eb8pI=;
	b=bSHe0DDO0HmUzUv3nmn0yIx82Pqb+ItFmQHz+j+0ES347ylkqZfmv5jaG1li+ZwJeqeCvI
	wbDv5wEkcWm8fn8Uczp/EQI2ok6MxarqXcFhzcaNtCDjbhBRHx80Wq0Pgxi4M9LbGkvo14
	7Fdz3q2pFT6dUJ4ajBPgymZob7aamniu1ETu5GucgZEjEqABhSvhAYGynRyU5q0SFxNE9H
	FbjuTg/HlHFZXtQiP0bcfJpz6w9OUE8lB/bS+MWt4qJNGI73QlE2Q/7DgW8MMCfjOZ/VBt
	3NzAPiixMXGlvwKdLkHxchlhnc2+GaTj35fMn9ZMvi01cZU6XF1euYpK0OSyZg==
Date: Sun, 4 May 2025 12:48:29 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250504124829.725a0248@wsk>
In-Reply-To: <20250502170503.GN3339421@horms.kernel.org>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
	<20250502170503.GN3339421@horms.kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6FB_Di5S7gZ0Mh6S0HegD37";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/6FB_Di5S7gZ0Mh6S0HegD37
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 May 2025 18:05:03 +0100
Simon Horman <horms@kernel.org> wrote:

> On Fri, May 02, 2025 at 09:44:44AM +0200, Lukasz Majewski wrote:
>=20
> > +static int mtip_sw_probe(struct platform_device *pdev) =20
>=20
> ...
>=20
> > +	ret =3D devm_request_irq(&pdev->dev, fep->irq,
> > mtip_interrupt, 0,
> > +			       dev_name(&pdev->dev), fep);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, fep->irq, =20
>=20
> It looks like the 2nd argument to dev_err_probe() should be ret
> rather than fep->irq.
>=20

+1

> Flagged by Smatch.
>=20
> > +				     "Could not alloc IRQ\n"); =20
>=20
> ...




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6FB_Di5S7gZ0Mh6S0HegD37
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgXRf0ACgkQAR8vZIA0
zr2NTQf7Bp4wh7lNJIyD6OEZaoyV4crQkImvD0UYuNmerhQ7X1xXh99sWe45M4hr
wUggoeicjfVNJFvjy6LJOfJQASUH/pkgZhUGoiLorpvjdlJ2qEmbDLNa48lEGDCB
GHjvENE6teQt6Ug4gcmgpU0bSrjZRSeLXGTL6CWtHPiqPIaerIP7T4MD/J9SVM3J
kPobZbf+5QfkzM+Tgwib8AZ5y52xCBSeCumXjD5slM9+w1AFrnpcZ8Uf5m/6dSKp
IXuLWzGdDigdq8TUkyGg1Z5GkG3hNErAFdokY6qol6TRKxAVRqKjc+ADyfUVQL7Q
1LvfWI79bwBZ4u5xcfiBHEhgHpGKvw==
=m30w
-----END PGP SIGNATURE-----

--Sig_/6FB_Di5S7gZ0Mh6S0HegD37--

