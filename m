Return-Path: <netdev+bounces-181631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FCA85DEB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9D918988C2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899F2367D5;
	Fri, 11 Apr 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ORXkI7Ty"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB72367B7;
	Fri, 11 Apr 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376081; cv=none; b=bV7y6pPPRNoMpYQS8d6fdmToPdy0BwyXedfJBER8UjPaRbo/2fto1DJhsWM0wD9xeTmsaY49LQ3RrkRUnyFzhHhmnd39FOXGldK2TRvVkEReZJzLZNUY87QtJaNOS/zwUPht2YILydiIA7h6zwRzx9puwgSRHmmfLV9gk5kaFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376081; c=relaxed/simple;
	bh=Q4jxB9ZrVGxAJUQQh1yJ586UOZiG9G2p9tGKu+B+EwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gum/IXR8Tmc57ROXN1MNtIBceGZPApSIEivYlZCjLB5kkXnQPFvGPumkX+j8bna9O2QPPIvrx09iYnT9Fth4yVFYVqK58gCB4R84xpEnCczjZYNX8/VK7Olvy6PF1wce5ZouSb3d4TLEiFsYTORi505NsBww/DrU//JFnWMmj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ORXkI7Ty; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B916C102E4621;
	Fri, 11 Apr 2025 14:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744376076; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hAJSv9h5wRcXrptqovOOWtspStxTbyq+MpU6paZIMew=;
	b=ORXkI7Tys/+aHAwaPzH3zrM4L5cGkNhSVzUbIDX0YfMWN2nmpnVIdNGWdw1/8legxzCPD1
	wtxw+ELgb18/QG6eSReH1fXjuApQuStP+GTgStG2YHP2bngukJjBylJWSNlGZnVTHVDxUC
	RrGPy0ilcuVPtmar0YlqFU1otWHJv3I8NLc3CN8bq8J+9JV1x3q6S+yGHvI9GjcISdlgwT
	SoA3YKJFln0pH9iS36F/46RRRzRKIxuzOrXxN7x1xISn4EM4ZRQ8cCSysEFxMeHI1TFoN5
	o5Sno3HBfomj0RLS+u1bhaQIAtaxERGudlso5SFwuuZq/u59w/0Jbe/vftu0vw==
Date: Fri, 11 Apr 2025 14:54:30 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250411145430.3001f1db@wsk>
In-Reply-To: <20250409162854.069abe88@wsk>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-5-lukma@denx.de>
	<20250408151447.GX395307@horms.kernel.org>
	<20250409162854.069abe88@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EDd9PYuJ_JPMOcH6VsFq/w0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/EDd9PYuJ_JPMOcH6VsFq/w0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> > It is unclear why hwentry, which is a pointer, is being cast to an
> > integer and then back to a pointer. I see pointer arithmetic, but
> > that can operate on pointers just as well as integers, without
> > making assumptions about how wide pointers are with respect to
> > longs.
> >=20
> > And in any case, can't the types be used to directly access the
> > offsets needed like this?
> >=20
> > 	atable =3D fep->hwentry.mtip_table64b_entry;
> >=20
> > 	*read_lo =3D readl(&atable[index].lo);
> > 	*read_hi =3D readl(&atable[index].hi);
> >  =20
>=20
> The code as is seems to be OK.
>=20
> The (atable) memory structure is as follows:
>=20
> 1. You can store 2048 MAC addresses (2x32 bit each).
>=20
> 2. Memory from point 1 is addressed as follows:
> 	2.1 -> from MAC address the CRC8 is calculated (0x00 - 0xFF).
> 	This is the 'index' in the original code.
> 	2.2 -> as it may happen that for two different MAC address the
> 	same CRC8 is calculated (i.e. 'index' is the same), each
> 	'index' can store 8 entries for MAC addresses (and it is
> 	searched in a linear way if needed).
>=20
> IMHO, the index above shall be multiplied by 8.

I've double check it and it turned out that you were right :-)

The following code:

struct addr_table64b_entry *atable_base =3D
fep->hwentry->mtip_table64b_entry;

*read_lo =3D readl(&atable_base[index].lo);
*read_hi =3D readl(&atable_base[index].hi);

Is more readable than the current code.

The same would be used for atable_write()

I will change it for v5.

>=20
> > Also, and perhaps more importantly, readl expects to be passed
> > a pointer to __iomem. But the appropriate annotations seem
> > to be missing (forcing them with a cast is not advisable here IMHO).
> >  =20
>=20
> I think that the code below:
> unsigned long atable_base =3D (unsigned long)fep->hwentry;
>=20
> could be replaced with
> void __iomem *atable_base =3D fep->hwentry;
>=20
> and the (index << 3) with (index * ATABLE_ENTRY_PER_SLOT)




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/EDd9PYuJ_JPMOcH6VsFq/w0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf5EQYACgkQAR8vZIA0
zr3A6Qf9GXE29Y/XpPCVSfPKZ01QAhFm6OWDn29Hd19Xc5zaiBO3NFgCJzxJpCM/
hv949OWXQbxs2glV9RSPxw1OJAIUL+Kub2pt23XEMkkobCV0XzuAW/VqPfjjv8in
Za9ur5L7E840u1z8uu24NbWBDdoRJBCxLy7Z9YSSxPA9UDMytwLWDwelSQADb1lj
FhdpA0swhuzHJsTUfu0NL9NZcbQbVapyKUsNZ+OzZJV682VIOSw7DGrwazG9NWYX
KpHcwfAMp2iiEbVVjjjl5n0VXMXO/Lth4LuGGJaAUd+4ZyZk7n8qoTRldy/PjdJZ
WPYNyrpUjZEEzphLwmzo6N/RRxxp3Q==
=QEuc
-----END PGP SIGNATURE-----

--Sig_/EDd9PYuJ_JPMOcH6VsFq/w0--

