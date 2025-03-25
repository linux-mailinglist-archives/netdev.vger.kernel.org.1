Return-Path: <netdev+bounces-177542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7BA7083A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CD93B3B5B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071B2627F5;
	Tue, 25 Mar 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eYd7Nzep"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D93257AFC;
	Tue, 25 Mar 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923820; cv=none; b=AaVCs4iUGPpXqa3WQkAWEsdPJnMs53sHNOq4m5BMpmIn4msmW8seDq7ouXRLrYcU7MLpSv7DgCRqdmDrgoFvZVRlhAuyTrzdvL1tnzBNbYeiZjdupcwQBMECmRAG2AXC59+B0idef7EEYQNsMcaZ3z8vEj2gXedo+DiHflWdN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923820; c=relaxed/simple;
	bh=af/qHaAv8wr7ohqEEz6YmtWfQIwybjKt+19CY5VMK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKak+AZLfzkM6osG28wthCkNSUuNeYiFMhzHPgbyJuv18wet5Fot4nhagn/5hCE/wC+LQciebpUKGU3gSVWS8vQG3K6Q3I9hpVVmPV+5azB/mACnBpY3h/zA3NGVAXKSgz84/b3ZNYrOa1Euig04JtcaBjXzZOjf9+u1+ByFkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eYd7Nzep; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34D83102F66E4;
	Tue, 25 Mar 2025 18:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742923815; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eI14fRc9SgUgLwy7/SzPwK7ui4N4JuoaWPwp0MI9v1w=;
	b=eYd7NzepKQqK2eSrPI8FEFriEYWhaavSzTZJ4hcetjyIwJx+vVQimsoU9aOfT5VG5+vl6X
	iCDiYqDiDVvvRetIf3pstTAnVGxtuUydTSc8sJUpPWU4ea8nUIFi8sqqK89G22zhBTUCjY
	UegnfTP43buAPi1PaCWNEOfrZgoYRA3tIaOLY446g0RdlGQBSa9B2K1B2z8SWDefqSJTGF
	PrtAMFV08qt85/1bjQOBFE5ud0RGAmt33zkvcC8hQKNmKl5OcvufCWKM29NwWBqhfnnu+B
	BvATIGVovo0wlnzbyerfviUh+4aYAUtqC0HqH0bRbYcCKNG8BUeKXQk4ERDsgQ==
Date: Tue, 25 Mar 2025 18:30:09 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, davem@davemloft.net, Andrew Lunn
 <andrew+netdev@lunn.ch>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 5/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250325183009.3f7e8a1c@wsk>
In-Reply-To: <39ec01b8-c2d7-47c3-90d9-32fe41f08a5d@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-6-lukma@denx.de>
	<32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
	<20250325142810.0aa07912@wsk>
	<0a908dc7-55eb-4e23-8452-7b7d2e0f4289@lunn.ch>
	<20250325173846.4c7db33c@wsk>
	<39ec01b8-c2d7-47c3-90d9-32fe41f08a5d@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mrx3VObtQardV+8O_zt0.CL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/mrx3VObtQardV+8O_zt0.CL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 17:38, Lukasz Majewski wrote:
> >>>>
> >>>> I don't understand this code. Do you want to re-implement
> >>>> get_optional? But why?   =20
> >>>
> >>> Here the get_optional() shall be used.   =20
> >>
> >> This is the problem with trying to use old code. It needs more work
> >> than just making it compile. It needs to be brought up to HEAD of
> >> mainline standard, which often nearly ends in a re-write. =20
> >=20
> > But you cannot rewrite this code from scratch, as the IP block is
> > not so well documented, and there maybe are some issues that you
> > are not aware of.
> >=20
> > Moreover, this code is already in production use, and you don't
> > want to be in situation when regression tests cannot be run. =20
>=20
> This is a good reason to add it to staging, but not to mainline. Just
> because someone has somewhere products with poor code is not the
> reason to accept that poor code.

I've tried to upstream this driver several times. Attempts were
made for 4.19 and 5.12. The reason the code was not accepted was that
conceptually the code had to be written in a different way (exact
discussion is available [1]).

What I've tried to say above - was that I need to have working device
at any point of development.

And, yes "upstream first" is a great policy, but imx287 based HW was in
the kernel long time ago.

> Otherwise all the people and
> companies who upstream BEFORE would be quite disappointed. Why anyone
> would care to work on upstreaming BEFORE hardware release,=20

Yes, this shall be appreciated.

> if you can
> ship whatever to production and then ask mainline to pick up "because
> it is in production use".

Where I've stated this?

My point is that for regression testing I prefer to gradually update
the code and not start from scratch.

I do appreciate your and Andrew's feedback and try to make the driver
eligible for upstreaming.

To sum up:
##########

- Yes, I'm aware that this code needs some more adjustments/update

- Yes, fsl,fec.yaml was the wrong file to use as a starting point

- Yes, bindings are ABI and shall be done right (that was one of the
  reason the driver from 5.12 was not accepted).


Links:
[1] - https://lore.kernel.org/netdev/20210629140104.70a3da1a@ktm/T/

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/mrx3VObtQardV+8O_zt0.CL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfi6CEACgkQAR8vZIA0
zr3NAAgAhtMjYHZz0S6KDjq/IEmqopGlqJgFjvjtklfA8BpjDXNA6Is65pgFd6LH
idHOlhnCV/PAkb0gwJ3VMuG++BluGUsIWV/JZ236mXW9VFoRFYC5zT4IDPJLd4Or
pObbUtxs3V3ZVpn1ZFQ+y4aDcCYZL0iAIiYWdF36F30xJ821EjeCn5Ah43GfyCWk
WSTG/uTuCNkOoGXyjeJHD+GG+YshNwd0GyJrdbSlUaPsSaBy1D4tST0QKinduNWq
nvSvlUXZlL5o7jHPt+XXtWvyfNp3Odh/fdhshgeS4uIjd+3dGFdg0F4jx/TUVoiv
A9YioUZbLh9npLz19KYNKzaGJDLNsw==
=GR0R
-----END PGP SIGNATURE-----

--Sig_/mrx3VObtQardV+8O_zt0.CL--

