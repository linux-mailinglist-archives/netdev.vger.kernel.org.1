Return-Path: <netdev+bounces-178253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF295A75F1F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D793A8211
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4891A3BD7;
	Mon, 31 Mar 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NnnXc3jb"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC61519B8;
	Mon, 31 Mar 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404449; cv=none; b=mfhyD7KhMGnZEuXgp2z/73OtI43wRw4qHasru7s/j6MxWr84rrZgzBBBY0ukB50syvhvlaYgOvrCiii/r2JRy1Ya/RHZLvHGNAjzReLbFlPqt5BPERYUjBNcK8MbSMA68ABD6X/FzkVjWP7kHl8M3JwR5U8VftE41BWO8QA5CeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404449; c=relaxed/simple;
	bh=p/p8rn7lBW65XVPA+w0Sra2JPznUZ41wzwWe+Ccmuxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uK1VvG6rDKWMJ5qavldnzp+CRByZRasaBusm9qfN1NJ9sZRIE2BBmCNQpTH5BoSyNG12SjQABEU3fjeIn7AEThq61ySTnrgrzhf/kzPHz2PL9Y25v68q7spaYaceJYqpwqFzOCVWQTSbH8xeRrnMAu/zqfiXaAJytzxs7ucjHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NnnXc3jb; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07FFA102F66E1;
	Mon, 31 Mar 2025 09:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743404439; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Tuk9xLLGOA3p2uSHVjgEZqViacVfaAPTNHEavU4XDWs=;
	b=NnnXc3jbq7tgb9NvNsc9O9FQmE+niADmjpA5rKPOCm1kMZVJGVlMDhqRZeGk8x5hTsguYq
	pvGzvAwYbMQeIaXFyfvOCg8JFIkR1j6JinU2OEH+7nQiniop+N4eEQOPkZbgW57u/Jlw62
	Lgurh2V2yvOKoaFccfxzeseieCKCbVYDcKh6NX/1vrCfORggFLr5GE1YIWnX1dxcaF/fBb
	vCkCijMHFcCZW7rxNFWZpap+LszDiTYnSNwq8nuF8IvsBmxEYJUCqQ9iq/KL5qfYdIKIqo
	fsZ0OiFr2imsRSjTGUSExQBccEI/TXhceVDp4zQpSVtLNOUUjjPKIcEirUQKUw==
Date: Mon, 31 Mar 2025 09:00:33 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <20250331090033.281807b2@wsk>
In-Reply-To: <022e19f5-9a9c-42eb-9358-a6fe832e8f5f@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-5-lukma@denx.de>
	<3648e94f-93e6-4fb0-a432-f834fe755ee3@lunn.ch>
	<20250330222041.10fb8d3d@wsk>
	<022e19f5-9a9c-42eb-9358-a6fe832e8f5f@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O3v+DOu0N.qQTG3HhCy4w.0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/O3v+DOu0N.qQTG3HhCy4w.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew.

> > > > +	/* Prevent a state halted on mii error */
> > > > +	if (fep->mii_timeout && phy_dev->state =3D=3D PHY_HALTED) {
> > > > +		phy_dev->state =3D PHY_UP;
> > > > +		goto spin_unlock;
> > > > +	}   =20
> > >=20
> > > A MAC driver should not be playing around with the internal state
> > > of phylib. =20
> >=20
> > Ok, I've replaced it with PHY API calls (phy_start() and
> > phy_is_started()). =20
>=20
> phy_start() and phy_stop() should be used in pairs. It is not good to
> call start more often than stop.
>=20
> What exactly is going on here? Why would there be MII errors?
>=20

Exactly.

I've double check it - this can be safely dropped.

> 	Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/O3v+DOu0N.qQTG3HhCy4w.0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfqPZEACgkQAR8vZIA0
zr2uZAf/X9cFX5/KF/UwjOOG5zujQrAPZ8w1dyFZMuxUtk8kuXMPb15aOYHrHNru
75mZmO+XEFjn8ZH1zo8gNFkcIZtXXRl9ySXNdv3qKnlRBNdMddQR5lMI+l1OixPr
SEH8lCzHgIi3s+RHFNsFrOrRnkKYkQwNHjiciDsgOFfn2Pzn7/oysfr0N/0guAsf
o4IQTXOe6HKQk/xiKYSiYSxbxZEYkEhVaRiizQwFF/lPbInPSJYN4/QMPkoaldcT
qcRyDKlHIAcvHnts/1lsTgrlugfSqAIdXgnUYKwi0GCmpkX7U6DA15uN7+kfhKSq
wm1rAr67gqNHiUvqXB6WyIQRFbZPNg==
=ACUc
-----END PGP SIGNATURE-----

--Sig_/O3v+DOu0N.qQTG3HhCy4w.0--

