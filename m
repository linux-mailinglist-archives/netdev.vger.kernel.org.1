Return-Path: <netdev+bounces-181120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB45A83B58
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F8466EAA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDB1F1932;
	Thu, 10 Apr 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QLsr4VwH"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BE3D81;
	Thu, 10 Apr 2025 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270518; cv=none; b=COut5ZHucZeYwd0wmpf7Ek9puGqwFDNJICst9CiinNBK5am1Ct8DNUkhwZcrHF5Glz8atQEL6Wx5M2rjJ50hQoa7XbBHjX4BQBB6Kig0cQSFF/KbvC026FK8i+1mpII7/f4QCvpKtIN+faSsf89lk2PpL6DZ47FwIgzM6sP/RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270518; c=relaxed/simple;
	bh=u1jDw4ThOVvMhsBdXXVs+mmc77zbx+Jio0rfY9F8yY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu1fzPIdmyRJLvguV9PU5/Bvt3hG+eyyLiQ8GdZSdBALCvqvEbYpFejDnXkDsuzOL8FuPKzX8pXIb/TG4t1EcEJyHrho+f6yBQ/QTnji9Np/dOnaQs2DVpIRw+tOLMTdxjWULi6tP8tZkXf5W+sHG1qqEQPcintcEdATxNztRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QLsr4VwH; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BF6D102E62AD;
	Thu, 10 Apr 2025 09:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744270513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mLCs9BiAdMlk+yQ3waXQ8IuOID59CiQhKnCO9fzZh/Y=;
	b=QLsr4VwHUrGmJXrOKxr4fge4GMFMNnFlppCn14sMjGMFsaUzUyOIbdbMjG1o/N1J87xs63
	YS92aLv+8SdJ4aoNp7/6UR2wczFJdGRndWbfUZTea4Goos66HzBN6go+EXAcjxcQM7HzAG
	jT0ZE3HbyqsJsOLlCT9yM4JOhcsL4N4agWZjVKgQ7wOFTGa6HmCIHdTWElL/smfNZzdFYF
	5/AE7e35b97TUdUlBaxLUGU03XoGuoNSUntnTlmT1AVWdxzWjUax2j6nmaO9GpoB6hdZVX
	STnDO1jfzQg5AzRbonDpAwad5iE7ZGwkPHxZVMTwyO6hmKPI7WiF246HNhsTnw==
Date: Thu, 10 Apr 2025 09:35:07 +0200
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250410093507.2caeed2e@wsk>
In-Reply-To: <cab89673-6126-43ff-b7eb-1f311fa4498b@lunn.ch>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-5-lukma@denx.de>
	<cab89673-6126-43ff-b7eb-1f311fa4498b@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hdGKkmySF7Xd2rssuDVn3Ri";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/hdGKkmySF7Xd2rssuDVn3Ri
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +static int mtip_ndev_port_link(struct net_device *ndev,
> > +			       struct net_device *br_ndev,
> > +			       struct netlink_ext_ack *extack)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev),
> > *other_priv;
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct net_device *other_ndev;
> > +
> > +	/* Check if one port of MTIP switch is already bridged */
> > +	if (fep->br_members && !fep->br_offload) {
> > +		/* Get the second bridge ndev */
> > +		other_ndev =3D fep->ndev[fep->br_members - 1];
> > +		other_priv =3D netdev_priv(other_ndev);
> > +		if (other_priv->master_dev !=3D br_ndev) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "L2 offloading only
> > possible for the same bridge!");
> > +			return notifier_from_errno(-EOPNOTSUPP); =20
>=20
> This is not an error condition as such. The switch cannot do it, so
> -EOPNOTSUPP is correct,

Ok, so the:

return notifier_from_errno(-EOPNOTSUPP);

is correct.


> but the Linux software bridge can, and it
> will. So there is no need to use NL_SET_ERR_MSG_MOD().
>=20

This NL_SET_ERR_MSG_MOD() only is relevant for two ports managed by
MTIP L2 switch driver.

As a result - other bridges created by other drivers will not follow
this execution path.

Considering the above - I would keep this message - it is informative
for the potential user (similar approach has been taken when HSR driver
was added for KSZ9477 switch).

>=20
> > +		}
> > +
> > +		fep->br_offload =3D 1;
> > +		mtip_switch_dis_port_separation(fep);
> > +		mtip_clear_atable(fep);
> > +	}
> > +
> > +	if (!priv->master_dev)
> > +		priv->master_dev =3D br_ndev;
> > +
> > +	fep->br_members |=3D BIT(priv->portnum - 1);
> > +
> > +	dev_dbg(&ndev->dev,
> > +		"%s: ndev: %s br: %s fep: 0x%x members: 0x%x
> > offload: %d\n",
> > +		__func__, ndev->name,  br_ndev->name, (unsigned
> > int)fep,
> > +		fep->br_members, fep->br_offload);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void mtip_netdevice_port_unlink(struct net_device *ndev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +
> > +	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n",
> > __func__,
> > +		ndev->name, fep->br_members);
> > +
> > +	fep->br_members &=3D ~BIT(priv->portnum - 1);
> > +	priv->master_dev =3D NULL;
> > +
> > +	if (!fep->br_members) {
> > +		fep->br_offload =3D 0;
> > +		mtip_switch_en_port_separation(fep);
> > +		mtip_clear_atable(fep);
> > +	} =20
>=20
> This does not look quite correct. So you disable port separation once
> both ports are a member of the same bridge. So you should enable port
> separation as soon as one leaves. So if fep->br_members has 0 or 1
> bits set, you need to enable port separation.

Yes, the if (!fep->br_members)

shall be replaced with:

if (fep->br_members && fep->br_offload)

to avoid situation when disabling second port would re-enable
separation and clear atable.

>=20
> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hdGKkmySF7Xd2rssuDVn3Ri
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf3dKsACgkQAR8vZIA0
zr2pVQf/aFFQjA0NusZsugz08UlZgCLGROCsjexA0ZPnqGSYfsClnYNxq3D5LjqY
HFplFXaHTbwqXBKYI/9tUXVyEccRnZo/D96Rn9XCQwXpNLS1AOiUmomMQaoRMpbR
6Tp0/DevMgTYi80dajfWIx8LxR2trZUGmWEExF9PT1TroiRqyhp+4Larn+e84xnw
l3WQLyd/asQ+B4zFQoPmyZyJ+tdM7Yz5RaZfyVz6K2oRjJNC5vCAZxLAbySNsWxa
WIg3fMl/puG+NPKCAvLxrcit4siucwIXOp9nAUpbTiVeGzZe5f3obE7xRRaY83Gw
/E3PyaeVIuzc83bsMRa7rpP2Pa4gdQ==
=PxXB
-----END PGP SIGNATURE-----

--Sig_/hdGKkmySF7Xd2rssuDVn3Ri--

