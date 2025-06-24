Return-Path: <netdev+bounces-200849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9BAE717A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D755A2EA7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5C2580C7;
	Tue, 24 Jun 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GqOUvYk7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1652561C2;
	Tue, 24 Jun 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750800172; cv=none; b=Quv4jeA2WDOFQGx7M/dOin9WDkAe2OaiPq8/WQX3AJvIdjN+PboSFdijHr2+hSRPz/Us3I/lCi64S0OCLXKU9PQVClfbma4qyW01sLCUhvBWYex5JYJsxSLIQZdBCwXPLuEpZpZHHruVPoSsjaOdJ5h9OVsxt0REbbT0tAVV0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750800172; c=relaxed/simple;
	bh=FDb/RFUfF05Pk1XRKRUucGe6S4ZEUfT4pGe4O59dr0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4d5Tb2JfjY9bBxF6XtYg2pRpMgXy5hqVlj84apgxqxWbiIMkt0lrvKV+/SsH41FNzQnrS3zh7ghi4dkStqaxZx3oITgHLbxodGB1rX6V5z87M4fO23TCAWlcdVh4N0guS5A5Whu9XwASlJBfJ1T4NfsSH542TXwOoTPzkhQtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GqOUvYk7; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36229102779C2;
	Tue, 24 Jun 2025 23:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750800167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=v7M9kkIPbnh/oS2WYgoA/uL9BgJMPVXdHT1CB9dd2lY=;
	b=GqOUvYk7TRdIkVJDpPiZDuKGtqtlMRl2kkdo7d/15nVe1UhvWsvIhXn0XtMPgnB9m8HrPH
	lXgSUa/HEMsYm0XJo2z0VZSaZtb/ne+sUx0MkOtfrjGAVT2JxRriHvx0A+8nn3USZgT3DT
	9/uSg6TBp8ogoeixA+5p0hP1DgLParzBkQtgapXsA+BBjb8j9bRec6Wp0G/dN6yiae/CpZ
	iYzV4am/wTeAPwsso4A+QHdafNKLn7x3gBxINxC0HBq5htbOgfjFfD8WiboATxxq7vEpfI
	rXj/pgnC656VMAQ8GpXG8D5ekRo8b/za4uJ1zzzkYGvvkOoWx6bm6PNw9IQLVw==
Date: Tue, 24 Jun 2025 23:22:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v13 04/11] net: mtip: The L2 switch driver for imx287
Message-ID: <20250624232242.3448f562@wsk>
In-Reply-To: <17f789c6-cf64-4940-ac7b-0107b7b96031@redhat.com>
References: <20250622093756.2895000-1-lukma@denx.de>
	<20250622093756.2895000-5-lukma@denx.de>
	<17f789c6-cf64-4940-ac7b-0107b7b96031@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//EaqhMPzixC8PHpwvxTq/F2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_//EaqhMPzixC8PHpwvxTq/F2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> > +static void mtip_adjust_link(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct phy_device *phy_dev;
> > +	int status_change =3D 0, idx;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags); =20
>=20
> The above kind of lock look incorrect. In later patch you use
> spin_lock_bh(), and the context here is never irq.
>=20
> Should be spin_lock_bh()

Thanks for spotting. I've changed it.

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//EaqhMPzixC8PHpwvxTq/F2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhbFyIACgkQAR8vZIA0
zr3xWggAzTnSLZzTWSc88/uiBjWC76JrODXHyufYi/Zi5poA968/HtfY2nMHkXks
1LOlDCRdmC2uRuMoaTqiET752MWjddsQKLhXZkw6D8JVm79cbQEibtyFrnQZtRMe
n3EioNBNQyM6HXi/eF5U3P7tDSpVi4XJQgfJ60cQdTJx0ddbmSKcgVNgZOuAbi+a
6kppME91cWcsbaw6hP/v9JcZ8dy8UEIGQtyLnAzezD9xVZUnJosy68HMTQcutXqQ
NnAVV0lmAerViHBV2nNufEGEklk9ZjDZknm0bEat2Ymex9JtWmhCziYm9r097bAP
z+A9f8Mkm5P8N0FOqOdMd5RyeT8Eww==
=5WA7
-----END PGP SIGNATURE-----

--Sig_//EaqhMPzixC8PHpwvxTq/F2--

