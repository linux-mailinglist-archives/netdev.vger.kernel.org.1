Return-Path: <netdev+bounces-178112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762ACA74BE1
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18CF8823F2
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A91DB13A;
	Fri, 28 Mar 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XQ83om8/"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6E1AF0D6;
	Fri, 28 Mar 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169754; cv=none; b=epwBIS/ULEvSV3uorlCstWratL56dwQWtc8xPM/edTkDThBBxerzakdrY4Cv8Js0P7+z3wNJNujKaPQ9rSMB+Udy4bYEyMGEfzhRLYUtGLT8aB8cfoyRJzQ/f4QjYa8o0oO74C0g0mRqOaYYprcIB+dCj6chuHPQhSHeXXmjjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169754; c=relaxed/simple;
	bh=3lILFWgnhkstxB3o9g5m0XIUuZylKnf8J5zc5fKNkJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aebfc4UOw3n8HrrCWDAYdGDX78xiFRa4P2pUpWhaqZX2HRZLOGLU0OAZbjjXltxaOzyrMCoIWEF+gTMmExieYKkYfgr6J0sgcatpLTzWqGugGHmeB+KmEl6kTsewOj+3zWNoXgm8pJDAr+WqZY394LSA72CHHWc7zLbAh1UElpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XQ83om8/; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81C34101DC310;
	Fri, 28 Mar 2025 14:49:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743169749; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JVwkVrfyGE5jNI5m8RpdSOR/P9iTL3WO9FAc4h/G4jI=;
	b=XQ83om8/DM3sqB2fArlp7DnJFKCtr2Gv2USp+87UVmuQ26qoHiAtMU4VoXbxqSMa/BMI8G
	6E7oPPbILVMKplyRByzgDl6FaaOGsJj4zF7ld87uApL5820/mxGdsyo/gTMPDMocEZzJ8B
	NhGlrd70IfV/Yrpq62xkDJnxPwE8czJOJwBm9/86EtEvORK0Iu3+XynIuRYIPovnD6uxYh
	u+XwWufYnUG/isY0d/u6RIcJv+/T5AipbHYcRrcVlUT/5k2D79jpJkLb3UKmDlMX+kHPok
	KXs+o4ip3Xx6GIpPMrc0WD5+CP5fZ3DURVSnMDQRResDTf8pyq3+XM9kqbk49A==
Date: Fri, 28 Mar 2025 14:49:06 +0100
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
Message-ID: <20250328144906.62323a6b@wsk>
In-Reply-To: <20250328064353.33828cd2@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328064353.33828cd2@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lpezb_=T1N_DAZZjyrP30mM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/lpezb_=T1N_DAZZjyrP30mM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Fri, 28 Mar 2025 14:35:40 +0100 Lukasz Majewski wrote:
> > This patch series adds support for More Than IP's L2 switch driver
> > embedded in some NXP's SoCs. =20
>=20
> ## Form letter - net-next-closed
>=20
> Linus already pulled net-next material v6.15 and therefore net-next
> is closed for new drivers, features, code refactoring and
> optimizations. We are currently accepting bug fixes only.
>=20
> Please repost when net-next reopens after Apr 7th.
>=20

:-/

> RFC patches sent for review only are obviously welcome at any time.
>=20

I hope, that I will receive some feedback regarding this driver, so I
can repost (hopefully) final version at 07.04.2025.

> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/lpezb_=T1N_DAZZjyrP30mM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfmqNIACgkQAR8vZIA0
zr39+gf+PnMP4baRM3Pye2pJkO6dcXzrP69VEz0RJFuksfJE+oZrtyLeel3iEdjs
D4fsoDvxwgFjX11+7ggdUVjUgwHW0bxDsuAr1FLBrIh4hrzlzLkfdX4k2URWKoxk
0bPF7IJpjD8/eCtKh9nX+FhYdjogrfre1npCwxixcC2i3jxnjwCqEOgLbKkiADfq
M2SVJvq+An+OJwAVnKxmzKjEkKSkB6DIcyKIWae9g8lcnRkzuAcraSpOgUdOOU+6
E7fMyIkYSy5R6cWSRzYQZDfyifH6GrIM1aTyqwgHrKHOCjJvqNM536fwrhrVYxpi
GcFqr75XS4DhdMUvefB9aZ6Dkn80rg==
=33fD
-----END PGP SIGNATURE-----

--Sig_/lpezb_=T1N_DAZZjyrP30mM--

