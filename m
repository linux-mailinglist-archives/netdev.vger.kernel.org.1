Return-Path: <netdev+bounces-188326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E87AAC2CB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A8C7B9B00
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24F27CB0B;
	Tue,  6 May 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="W6ahW4Cd"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346427AC42;
	Tue,  6 May 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531016; cv=none; b=mkXCGP6M++mrS4MxBKxNHl/f9QcjtM/w+vcZZK+TUG91WW0iPyrtWV9aGFB4fo3NI51wGIqPj8opJWU2BdOlnIfssh+nCySnfezi0JJN+fabsa5RCpr7SU2r9iqj1bQ9bc3ITjToKnpEmcQW7KhAqGFH3vCt+jjJhM79VTTGsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531016; c=relaxed/simple;
	bh=6zvLh1+M1TopLSMEihum0IjZMluVdHS2PGGCBhHCFos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwfSYL0lcON6Leofwyi3NduYylMBIisMIF9EavYH3bPV43ffPjHaXWH33wh46TYcJkCzseUPC3Jo5Q05SKN3eVLa9v7U13jd1rlJhb5LbNqxo5Cv7rGHukOCG+3mgDSbvsv/oWRuzpplqJXL+9xsQh4/mibYEEbx0YS+/BRRco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=W6ahW4Cd; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FA101048C2EF;
	Tue,  6 May 2025 13:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746531012; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=j+tjm4josKsxx1XYGwI2ueKPNoEguumH2AgRPhy7ttY=;
	b=W6ahW4CdKTfVxM95VHuGYdddGdilzhWER2Uybu0fbJV8lhKvmzz6jyldsaXQYo1D6rxQed
	/IEuy42LWI6CH6yGXVXl7Wc56T/ZLjItA5b/oRsCRX79p4jsPVSyv717zDHqFhi4AHOvBA
	lwQR/DuRqPbOxCRvz3G8B6k2lI/v7ha/iOgJdQUsh2PpYgzFWu963NQkOtYSMCtdlfelaG
	a5vUosABWOg9xbYof+5USgGRX39V61UGuVb0W6c4RhH2PXKYkBxeuszey34ueGpLi6vqPW
	LbN/LUcrygAtvkk0m6fGRYM+QcSNZkZu+yXJoiRQmgQSdRvRSvGrmrcUycL1eA==
Date: Tue, 6 May 2025 13:30:09 +0200
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
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250506133009.3e945546@wsk>
In-Reply-To: <20250505131611.0c779894@kernel.org>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
	<20250502071328.069d0933@kernel.org>
	<20250504082811.4893afaa@wsk>
	<20250505131611.0c779894@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VGhUyR7bm1Y+8Pq6wGW6=0i";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/VGhUyR7bm1Y+8Pq6wGW6=0i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Sun, 4 May 2025 08:28:11 +0200 Lukasz Majewski wrote:
> > > Now that basic build is green the series has advanced to full
> > > testing, where coccicheck says:
> > >=20
> > > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1961:1-6:
> > > WARNING: invalid free of devm_ allocated data
> > > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1237:16-19:
> > > ERROR: bus is NULL but dereferenced.   =20
> >=20
> > I'm sorry for not checking the code with coccinelle.
> >=20
> > I do have already used sparse and checkpatch. =20
>=20
> No worries. Not testing a build W=3D1 is a bit of a faux pas.

Yes, I'm fully aware of them - mea culpa.

(at least now by default I will have W=3D1 set :-) )

> But coccinelle is finicky and slow.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VGhUyR7bm1Y+8Pq6wGW6=0i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgZ8sEACgkQAR8vZIA0
zr2hpwgA4XcfexGrhhN6LFts0lR95BX5rhktdQBEW5FlLs57vikXMEzNzJqty9n3
MqEjDsfAcdHJfe9vwMMVgoxBLBDahgnAki/tyn+PrtH78hmXIZ8p4ZOShnGalF11
13lKMYA8oH/tCLonXLTvspvwR92/S0aUZKszFWwDq4VS8ZBLHRUMtU0TvkA/TZps
7VrU+3V6SX16CPI73894dh5lkc+tV5bnJJu2PTQ+pMhL+DuLmEMSCkxyhAocLcdq
bvcb6o3hjhXzQtE70wXbI2HfH5X/x4hEyliOfK8Q+/s/BsjWFjEsxCvtVCb4UCGR
DQ7kBhb6w1Q4Q5B+D+d8g/R+O/iNbw==
=4Uhq
-----END PGP SIGNATURE-----

--Sig_/VGhUyR7bm1Y+8Pq6wGW6=0i--

