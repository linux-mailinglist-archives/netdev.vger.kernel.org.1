Return-Path: <netdev+bounces-177368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB3A6FC70
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5613BFB00
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B725A32D;
	Tue, 25 Mar 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iI10GOZx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507C25A323;
	Tue, 25 Mar 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905205; cv=none; b=aG804TQdkK+FsRCdCa3uhJAknIs6SFoeqZS+PSNYuB7gScp3+edBz83SQfUiaIC63RCP1NA/7iKUzzZTtD1pgirBZ2jgtGteGsJDRYTdgaxjt0mWniKCS3YZEgI/7ajRnXsdGmbQvfQUoF1RpPaSBczmiFetNGVaskMTgiK+Vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905205; c=relaxed/simple;
	bh=W+zbuGuOsjMsAwj1TeKVa2TREDPoShSYxlcNLgWYVEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kz6tPoVXGaGMpeLn9TskJhK/x7YpmeJ1L0oty1beP5HEjn25MtFpBdUx7rfGO+Olss6tHLgIA2UlaYLBY2jwr6F3YPJlmu2XbKzTz0fVP4jix9cA/HJznS11C5Oq3kzBN/ts7P+Xk5J/c8ApDXribHxi+lWR60A4KokOGEQxbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iI10GOZx; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAD1F102F66FF;
	Tue, 25 Mar 2025 13:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742905201; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NWmWtlj/ywJV6x0SVa10Ru5jBz9yI3s7yAlnn7HAP+A=;
	b=iI10GOZxX1mHgyM2u8+7/hdsGhCCl9XeQNlR9159nd7Yrmp1M9EzyoQznOCNezfJNl+mJ9
	SugwMDIGDHQIt+JVt4gZ5jtXRMz5XkD7mYkyoH+3BBQsC6Wep4HQmwCEBLJguay3eUz7UO
	a++388I8tOOmPQB3cMRAuhPNSnW6ZWmqKY49V2c5IiK5nn5VJccHfnIESBHN9fzadsHgW9
	Xl3+WTEZKlPTP/gQXxOBNmcm+5pZf5nfRnW+HkKaqVdVO0M7unZEoNF4KEl9D0/hrc9Gqb
	jTvv2XpW46Zt70RZ+tso/GL43Wd/7AiEZ0vMVJoY64YbV5uAx1kHujfKwWVfZw==
Date: Tue, 25 Mar 2025 13:19:58 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 3/5] arm: dts: Adjust the 'reg' range for imx287 L2
 switch description
Message-ID: <20250325131958.552fbd0b@wsk>
In-Reply-To: <93c9bc3d-7ad8-438e-966e-cd28a91540af@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-4-lukma@denx.de>
	<93c9bc3d-7ad8-438e-966e-cd28a91540af@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iHkkBmAY=t74XA_T2X_ZYbS";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/iHkkBmAY=t74XA_T2X_ZYbS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 12:57, Lukasz Majewski wrote:
> > The current range of 'reg' property is too small to allow full
> > control of the L2 switch on imx287.
> >=20
> > As this IP block also uses ENET-MAC blocks for its operation, the
> > address range for it must be included as well.
> >  =20
>=20
> Please use subject prefixes matching the subsystem. You can get them
> for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
> directory your patch is touching. For bindings, the preferred
> subjects are explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>=20
> Missing nxp or mxs.

Ok. I will add it.

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/iHkkBmAY=t74XA_T2X_ZYbS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfin24ACgkQAR8vZIA0
zr3N/gf8DYEFypnfPCvqTv0w1mjjvKAqlgERVYVIbxHIpd/6t5B0hhaY3vRUWPyJ
VUqi8YCx8uavVTRzDM59fSfmYcFzOe7rUv9fVvS4+W3AtxqTmtndRXZUrFAtXrPf
LwfMfvqJuoKPiLLcfPZQpNNY6iuzehkmrmcO+0MmOmsPNVHWsXUG/mmoefrSIy/Q
yUysj6v1UeS8nm2XOXYf7Pij0CFaCgMDE7zdzziTkkLtBYywTPxMfUbNv8DjFUSX
Xa6M/GMe39ehOU92VOjF0TRxyiDNXgRZ4kibznKZFpohskhQ1IugoT2tyXDspA6b
JauuHhBMQ/y+Om9HVWaZV3LjzVe05Q==
=TLOn
-----END PGP SIGNATURE-----

--Sig_/iHkkBmAY=t74XA_T2X_ZYbS--

