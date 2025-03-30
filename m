Return-Path: <netdev+bounces-178218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBECA758BE
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 08:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F616C508
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB313AD38;
	Sun, 30 Mar 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="HuDg6KNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0F2AF06;
	Sun, 30 Mar 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743316690; cv=none; b=l1hznoi3fyk6oOJIHw54tSuRQrjZsqUYk5tCDgZ17zIgZ0cgbfM1elIi/Xxc6HI8W9DaBVFwqNqed69DyNoDr+9ulZL5BPxmUF0C0cV/uM/ieLPqBoNkNCCreidsVja0wXvbvWOjM2cR2HRobOS9DXWahWxziOPXIyDzIdkB3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743316690; c=relaxed/simple;
	bh=Vtr5gkc2mNXcPTMCDr+ewX/0No1VfEBKwGwq6TAnyfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YV3ugrhJ2B5IUx5ugUzaprRVFvwgp96apkrmL9M6gbndxVhtakhaXUCDJTYcwA1lr8Et6CvMSO7HhwQUm13OFa3ZvkzZ6rVO5SoYxIjarHkJ4SnpnhmAZrWjt4K1n66dEA0vj888EuflCnyiZlI3qoshfAL25Zhu0M6iHtRDPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=HuDg6KNZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B283010290279;
	Sun, 30 Mar 2025 08:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743316686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9k+Y5ReIOa8H47u79tGR1AW/2+R+LuYfBtErRCizLOk=;
	b=HuDg6KNZrF0KM1dFLTYi0XMA4mnXwPf214AlrNGhJ8eDezOa7d+fSBnrRE/g5yBfefQvvG
	Ox1n3XV+3vRLJwlsuninZZnf0YeEnxKvE2ryuljHLCnRnxXgIOZwLyFdL2kLfnQ+dg1zvg
	A+kFdr9e0qLTYc7vl1GWnZIcwmDPZdqFIqFmekrO7rehjJUCtgiUHDFBjCywRnw5a9IEXX
	mpSNCC33/y+Me9DX66o0hU6CfrypvtDjycEm8IfFuvbHsakGYLWNIwNhmdapNccePS884e
	qMWSjrSYRoVq5mkMTXFyz8aSDLhYlKZympEMFxH2ztikYpxIPKvxNUAkUFx+Ew==
Date: Sun, 30 Mar 2025 08:38:03 +0200
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
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250330083803.75a8b53e@wsk>
In-Reply-To: <b187dd05-2d9d-45d0-81d4-fc619dbba1d9@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-2-lukma@denx.de>
	<b187dd05-2d9d-45d0-81d4-fc619dbba1d9@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fBDXOrwfi.DnGuoT/zlieFq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/fBDXOrwfi.DnGuoT/zlieFq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +                        /* Both PHYs (i.e. 0,1) have the same,
> > single GPIO, */
> > +                        /* line to handle both, their interrupts
> > (AND'ed) */ =20
>=20
> ORed, not ANDed.
>=20

Yes, correct.

> Often, the interrupt line has a weak pullup resistor, so by default it
> is high. Either PHY can then pull it low, using an open collector,
> which is HI-Z when not driving.

Yes, correct - this is how it works.

>=20
> 	Andrew

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/fBDXOrwfi.DnGuoT/zlieFq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfo5ssACgkQAR8vZIA0
zr3WEQf9GrsZedlkoBqYc0+xKBgj8WPrMwiNSBqHy0trL7PSVtE9pN7ZQrFpRfdi
c2HPrZPNA8+zH5vnWWhdRzMBqywa7rtDLbBDaudDut+lqrwG8I5wRQAHfxZ++DH3
0dvq29opUYpQ6tJeZtack8i9RwdMEQ3jzvrQ9aEmao+PXfhsyqnUy4+7z1KcdCkc
1CvGBuNdbluE99D+ZO2/HC/aKnWAq+ugj4blbCsvuRTSKGoczBdOoZYLfcbkrfwf
BXoE140i5YytrVmWUEl8st58W1PFKTICFz+gSwS8L1JLHhBupi/Lbjzuy6GXHGql
q+llzRrl4kd2MdIr2q4LP+JbQ9/+mQ==
=NIIL
-----END PGP SIGNATURE-----

--Sig_/fBDXOrwfi.DnGuoT/zlieFq--

