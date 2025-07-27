Return-Path: <netdev+bounces-210350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11BB12E36
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586B117CBA2
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28B1DD9D3;
	Sun, 27 Jul 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QiNliuiO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11543155326;
	Sun, 27 Jul 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753603550; cv=none; b=sxPOWnRfSIfJao3kj37euxke9hERjR1hUF2brAu40+mEwkRtENuxwVyZ5xbH/LLlnY8aquMLJ8rp1TKgppj8i8Qr0biOVE4TlBKyWA/5/viVPJ6iUTZlnNHYnHQGczWSHl81kaAVbRMwAgAU1lWGuBhd2oWD3V5zqZd3T9hvk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753603550; c=relaxed/simple;
	bh=e61m84fGX2vrBugF0y+lPAXMApbOPGKCY7UvCfdkjDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYQkIHPCNyqFl0hI76Z2F17d6qI3u4d3bD+49RWNXHp7JujKkwZY/pThTf+wTl1nF46SrjTZhsSZtTqDmNfRf/iZeOhXjIHecR/n5eaX6FXAaY5gbzVgh6hi+bwXnrJ8SRoRICuaQ+jaK1JgmTIOk5ZXeQP125Qu+jphDe8Ly+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QiNliuiO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 335AC1038C126;
	Sun, 27 Jul 2025 10:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753603545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RkBrq8EwJtKrLLyc89nHWZVNStBBKpPPsVnWhREsJ3M=;
	b=QiNliuiOiHMjVLrreXLPVMtdb6modtyn9YS0LJimse60TjPW5KL5jdyhUQZDOY0BJv6vC1
	QmtyZEOevEZTYA8m6jqbfaSVYXBgqvsZR5E2aR97uWQuTuifRl+698ko3S6iiGtHpKLFNe
	yWEyEguBDDn1mGpPhlu9LbqolnulGLNkJiZNQrF8qGy6n+isjMCBKOxr62Ll1SUBoTHz4P
	xkRalhn9K9xq/3l8AhS2ydZJsbY+TPWDUm6YcCY3nXF9/ilaZrewuDzrXnrMtfFD/G8MSS
	2ZqOD584dzQgbM+HYAc1wjEuastuPoEVRDpORsPcjxGHBfbGC0svhTytmYE0XQ==
Date: Sun, 27 Jul 2025 10:05:37 +0200
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
Subject: Re: [net-next v16 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250727100537.4abf90fd@wsk>
In-Reply-To: <20250726133835.6e28a717@kernel.org>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-5-lukma@denx.de>
	<20250725151829.40bd5f4e@kernel.org>
	<20250726221323.0754f3cd@wsk>
	<20250726133835.6e28a717@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0V+L.IMPpnGggWz/bxwq32Y";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/0V+L.IMPpnGggWz/bxwq32Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Sat, 26 Jul 2025 22:13:23 +0200 Lukasz Majewski wrote:
> > > > +		ret =3D register_netdev(fep->ndev[i]);
> > > > +		if (ret) {
> > > > +			dev_err(&fep->ndev[i]->dev,
> > > > +				"%s: ndev %s register err:
> > > > %d\n", __func__,
> > > > +				fep->ndev[i]->name, ret);
> > > > +			break;
> > > > +		}     =20
> > >=20
> > > Error handling in case of register_netdev() still buggy, AFAICT.
> > >  =20
> >=20
> > I've added the code to set fep->ndev[i] =3D NULL to
> > mtip_ndev_cleanup(). IMHO this is the correct place to add it. =20
>=20
> If register_netdev() fails you will try to unregister it and hit=20
> a BUG_ON().

Ach.... right. Thanks for explanation.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/0V+L.IMPpnGggWz/bxwq32Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiF3dEACgkQAR8vZIA0
zr3XqAgA2sXocPAdmK/F5WB7kLsc6cqCUe6c3iGLjKWISsBkLMNQpfTzN8u3AMt+
SE64cZAf1HmhN+dCrW+M+/xlKliLHwlkMF6E+Xpd+GhfIeNRijyPXBrcAB2c+Npd
5yqu9q6rVYD+icUz8AuRiWJQQhKHxrj35cdP7rKD0iyL/NjetQJwRRnlBIF1Asb6
Y8qLJY52pRfXxgr2pdlmkE2onr9sEnM4VsZrnWy0yuyb0ufMy8NEuRy+mh6TYeqk
O1TmsdbbUMAcXaGk3XYR6btXXu5bkgn3hGdEJnORLtq1I+W9RH13kbHiKqm7w5Jb
gZuhF67G07ueQCFJDxAjLMjVflKSOQ==
=Tm9v
-----END PGP SIGNATURE-----

--Sig_/0V+L.IMPpnGggWz/bxwq32Y--

