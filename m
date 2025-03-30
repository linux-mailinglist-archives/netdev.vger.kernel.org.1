Return-Path: <netdev+bounces-178217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE28A758BC
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A69188CF74
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D26137C37;
	Sun, 30 Mar 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FQKJ8Z2k"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAD1EB2F;
	Sun, 30 Mar 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743316630; cv=none; b=DM6WItTOvYTcfU+wKaiilBaF7Dcg8Cfq9Mgs+mijd7qpT+zCaT3a4z6pTD9p6BZSyiQjIcLHYTii3mCjg4wU5xFCSydYdJ41TZY7KJl7vm6NRyU50MUz/kDT5fKLVBgczBucPF1jIlC3/uxt5AkY5g7UtG19ngfzS3odk7dR0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743316630; c=relaxed/simple;
	bh=tSyQjbNInGuPtLhkd6iM6BZo/rKoG+GMc8//uk8Y6FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ0c3SSZCGqd95Ylf5mPwz97jmRU0bHls0EPd2vZY1h9iMC5kW3WAt6MRjc2DthcmDz8+vdm4DeS9v7ezZd+VhUxNFkXNlmou0I0MQb/3rQazoKtiJfIAwqF0A75glhMRttk05jQXZsqYgvvJt0LK/rG0hjpXYCBSKgxoF6oxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FQKJ8Z2k; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B28F510290279;
	Sun, 30 Mar 2025 08:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743316625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BRteZqX1GzZD63e0WZQkOLe8JTjQebQr5YPHcAOXdOk=;
	b=FQKJ8Z2kGAokT6ywehaNtgo4kL74MSKFurMp3SWangcCUjXmAxle3cHYj0S2LnQdb2cCSJ
	hj0+HhGzOwvUKc1/AgP+oaeYhfa8e8CdeLsWGDLn11HEBfrpZMcCeEcx11qQ4qCscVaow4
	vBVMNsuLE0QblJKPng56DgnRAjIqSyNW7hPQTBX78IAMTDOBhcL11Qkq1ekIYjt+uS+zpo
	A/NU6/GHm07q9QmQUBWeX1xZ02itODBK8heUFv1pJi2OSmB2gC0B9hVk7FdS9cNMlhx2F5
	n6/+ykOhOLJED1PAOQLyZxfD4wrWhPFQLRYXRrqk0bgOMqMq0QGuueWmi3zbGQ==
Date: Sun, 30 Mar 2025 08:36:59 +0200
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
Message-ID: <20250330083659.61c52d2b@wsk>
In-Reply-To: <45c6cb9d-b329-4b4c-a480-08110a546fb6@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-2-lukma@denx.de>
	<45c6cb9d-b329-4b4c-a480-08110a546fb6@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7c2ovTtNXoWn5CzXtf1gA5K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/7c2ovTtNXoWn5CzXtf1gA5K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +                ethphy0: ethernet-phy@0 {
> > +                        reg =3D <0>;
> > +                        smsc,disable-energy-detect;
> > +                        /* Both PHYs (i.e. 0,1) have the same,
> > single GPIO, */
> > +                        /* line to handle both, their interrupts
> > (AND'ed) */
> > +                        interrupt-parent =3D <&gpio4>;
> > +                        interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>; =20
>=20
> Shared interrupts cannot be edge. They are level, so that either can
> hold the interrupt active until it is cleared.
>=20
> Also, PHY interrupts in general are level, because there are multiple
> interrupt sources within the PHY, and you need to clear them all
> before the interrupt is released.

Good point, I will update it accordingly. Thanks.

>=20
> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7c2ovTtNXoWn5CzXtf1gA5K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfo5osACgkQAR8vZIA0
zr3SIwf9EV3MvkqdhVVWSD+ZO9I/1J4aB76//m6svQ5c9dxHZqk0fkXCLWGOilBb
sm8la7oyGMGoI83LQHg8dPcxjBdxDGA31xCHjuuFFd2DTCfNl4tCvJkarLjsrMmE
Inug1rJoApfOioU5j1tcNnzcoAmERGpfqOhKhVbPRs9izt6m5WvkuD053JjqK5sg
0XRWIlMl1WkVwZ37ju/Tb28U8MeUzDiTPMw06IW6HYP0bplP9lxDaV5RZ+2xaMAx
YQoxlMDe3+kvntv6UrlxGKMUwPwXaV6j3K+NBi9uU0zpIIf/DBa2sJ62LddytSv5
X0P5l5sMgq7Q5iYO1nCW/1AUuuLYBw==
=Epnz
-----END PGP SIGNATURE-----

--Sig_/7c2ovTtNXoWn5CzXtf1gA5K--

