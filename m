Return-Path: <netdev+bounces-178396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C48A76D5F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF593A81D2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045D216E24;
	Mon, 31 Mar 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ErTQUikq"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3B21884B;
	Mon, 31 Mar 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448322; cv=none; b=tvAzX+dkKxYetCAmOv2p6eIbOgIv0fOEhtS+rN42nZvKru10qfSav1AcpYFbAxx+6wIDTJL8z/4/js8FTqh7jZzF06bFLKZJFbD/Dy95FO4fLcPPSw20eQm91uC4aLUjQaaniCNkZA8/WO724zj6Hy8x3v7Odr/MNxvF7BvfAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448322; c=relaxed/simple;
	bh=m3RDnstX2gx0HhE5shg3bJBMpeePFQ2Yih6a2y+tM+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ2bASnAiOy6DxcR/Gizo0rY8nzHowCPS9FwHR1zZjkZEzt/CXHw3iI7nlu+8I0eBo3vD9VmiUwyR7WG4YMgErooLfPmo2vMGJY7n7XhUke7JIQhdU1hMHr95+REIPhIYAYQlRHYeFtgJWGhvkZXHZGleMp/xXJOi6Ch2NgDMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ErTQUikq; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA0D610252BE4;
	Mon, 31 Mar 2025 21:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743448318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9/SHOmvheFUaxFxBZZI7R6pWQfCAUUDodtSq/v4HDjc=;
	b=ErTQUikq8Yq1gbsG42OM7WOuS/wFDQR3u/62VzEkp4h+LO9+Qsr6jM3CXMy1VtU0AwAWsC
	5bd/zrrEuJIi8bYAbNK7x6Y47RmZcQf5lVtk/KARkQY0U0hjwIDXuW9qggrn2OiXbuaIx/
	zTyfPkDIQlFwiwvD1vQUPWzMme4QIy/tcRrB4dEGLDW6PlCdt2DCFRuGuMR3jWWjPjfqzP
	ouCIX7zWiJK8PpJKGTqv0lSPNgqUWtJSpji3e0oDCUBftWGUI1lb6Tt5O0W1hy5DDMDE5x
	BMligRAUNuvWKjlB+LMfLMj0EFkIF/PXDrBHN/5BFIUbj7xu4O5g40J9ChpRRQ==
Date: Mon, 31 Mar 2025 21:11:56 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250331211156.5ed247a4@wsk>
In-Reply-To: <CAOMZO5A4P=JbmXRyz91e3DSFbXjG7aRxMyBaTMsfB9jpVG9tww@mail.gmail.com>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331103116.2223899-2-lukma@denx.de>
	<CAOMZO5A4P=JbmXRyz91e3DSFbXjG7aRxMyBaTMsfB9jpVG9tww@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hmMXF+Ye_GiLI=a_V4UguL=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/hmMXF+Ye_GiLI=a_V4UguL=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Mar 31, 2025 at 7:31=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>=20
> > +properties:
> > +  compatible:
> > +    const: nxp,imx287-mtip-switch =20
>=20
> For consistency, please use "nxp,imx28-mtip-switch" instead.
>=20
> imx287 is not used anywhere in the kernel.

Ok. Thanks for the info.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hmMXF+Ye_GiLI=a_V4UguL=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfq6PwACgkQAR8vZIA0
zr0b+wf/VzyowjhouF6JR3WeSp7yXgH7z8RnuEMkuhmmxnMRHdWg27ciMWanNTuJ
2lZbqG9jDifMh4TUGrcp15UZUvHXHrCiXVUu+Vb7s+SlQ54AWSqw4Lrx5NUwRARC
0Qg5UAvlzdINusmiMg1/e7O08e2n/1778Qj/9QHangd/mGKbUpnqgbcRvjWaXHy5
Hs/fVc9PowiXcb4lfG5pnbxajk4/KTekDgdgPRNl2Fwu2UQEOgM7FqoZiNEExAH8
SewXSt/DZreOqHffMFs+NRQB8KjPGAwAtP1m4m44salTi+4aNEHiMbFogj4gVIJW
Ns3oNfBz5Wxakq4qzhaweo7D10biug==
=uXKq
-----END PGP SIGNATURE-----

--Sig_/hmMXF+Ye_GiLI=a_V4UguL=--

