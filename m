Return-Path: <netdev+bounces-289932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJLcIzyqDWpr1AUAu9opvQ
	(envelope-from <netdev+bounces-289932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E862858DC24
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B112E30F8A14
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B73DB313;
	Wed, 20 May 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+ojCrma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82026F28D;
	Wed, 20 May 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279954; cv=none; b=Qn56vB+llJSrB5+rz97ZDRDjUB3snyuaL7TySJukJOuA+2EjDbcUGYkgDCDmyw8vhbg4Uh/083IZcC0pN6NsBc3wVCwSlDCjx9Xfa2wDQ8qr86/LKiooxjoxzju7t2gIlQTia03nRShXW7HyU8tnWM2WmJAYBYCuKoNWK3IHUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279954; c=relaxed/simple;
	bh=00xGP0BzPdJRHepMbqm55Z+KZ+W/QgS1/gDEJJSQkTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy/y4c03XRZILFu+i5ZOH5hu2m7nmrSDhLTOKgeBxv6RBCLPgd2zpVCjaVEIZt6fMPEZVZO4Vw2hcGB+aSaQfo7qKi8iQpy5ZLG3byJLsHXtSuTR8ehimGl+tSrXt+QdIXfx5DdsVZtGRQlIghPHRoGr1oyquwj6xcfW+THQrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+ojCrma; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3381F000E9;
	Wed, 20 May 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279952;
	bh=U/iO0K8rFrV5vPGL0yDrSRUFyUemQmMGMqF0WV96rIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+ojCrmaN8AP7i+sWBUj1fVwysTta55kacncM90ONUaW/M13xlH8KsGbKc8r6c6On
	 Znqn1/fAR37IPy3SKZ0kxDgNBS2OLPiL/aUp2QVEH8nEgrgFB+X1iFLwRL0hkbnIZW
	 d/eNuHzuO8E/g3kS5ArtJNX40cwjcoM0aBI7TCVVdYzHHsAbjpJ/rZaTGW1wJ1DpYZ
	 BlX+XIAXBz9uelSKwbB7rgNKeKmMxUhQBqpLHei/c3c6kOXUUXvmIaZ3x2ng8QXUne
	 d0AcpsMhA5xNBB7ppkdr6k9O9nCU88He1gCmG1+LuERst3GNSW68au9coYHfqFjmob
	 +mF+m1UnDHK4Q==
Date: Wed, 20 May 2026 14:25:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 02/10] net: airoha: Introduce airoha_gdm_dev
 struct
Message-ID: <ag2oTmr_G9gGl0UM@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-2-6bd70e329df6@kernel.org>
 <20260520085932.9473C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VWW411jV3j9OGq9a"
Content-Disposition: inline
In-Reply-To: <20260520085932.9473C1F000E9@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: E862858DC24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--VWW411jV3j9OGq9a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Potential deadlock in `airoha_update_hw_stats()` due to using `s=
pin_lock()` instead of `spin_lock_bh()`.
> --
>=20
> commit 6823c137925a562390270eb1ce7967caaa011b7b
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Introduce airoha_gdm_dev struct
>=20
> This commit introduces the airoha_gdm_dev struct to collect net_device re=
lated
> info, accommodating future support for connecting multiple external SerDe=
s to
> GDM3 or GDM4 ports via a hardware arbiter.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 5a027cc7ffcb1..5335271ea8654 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -1877,10 +1888,11 @@ static int airoha_dev_init(struct net_device *d=
ev)
> >  	return 0;
> >  }
> > =20
> > -static void airoha_dev_get_stats64(struct net_device *dev,
> > +static void airoha_dev_get_stats64(struct net_device *netdev,
> >  				   struct rtnl_link_stats64 *storage)
> >  {
> > -	struct airoha_gdm_port *port =3D netdev_priv(dev);
> > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	struct airoha_gdm_port *port =3D dev->port;
> >  	unsigned int start;
> > =20
> >  	airoha_update_hw_stats(port);
>=20
> This isn't a bug introduced by this patch, but could this lead to a deadl=
ock?
>=20
> Because airoha_dev_get_stats64() is registered as the ndo_get_stats64 cal=
lback,
> it can be called from both process context (e.g., via user-space netlink =
dumps)
> and software interrupt context (BH) (e.g., via bonding or teaming drivers=
).
>=20
> Looking at airoha_update_hw_stats(), it uses spin_lock() to protect the
> hardware statistics update:
>=20
> drivers/net/ethernet/airoha/airoha_eth.c:airoha_update_hw_stats() {
> 	...
> 	spin_lock(&port->stats.lock);
> 	u64_stats_update_begin(&port->stats.syncp);
> 	...
> }
>=20
> Because spin_lock() disables preemption but not softirqs, if a process co=
ntext
> call is interrupted by a BH call on the same CPU, the BH handler will att=
empt
> to acquire the already-held lock.
>=20
> Should this be upgraded to spin_lock_bh() to prevent a potential deadlock?

As pointed out before, according to my understanding, ndo_get_stats64()
callback can't run from software interrupt context (BH), so this is not a r=
eal
issue.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D2

--VWW411jV3j9OGq9a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2oTgAKCRA6cBh0uS2t
rHrdAPwKjmJ3hSpOQFwuaydvqe3BXRMyCUMQkqtovLh/38mO6gD+Km7+pOOWAeSv
6eVr1vwwV8QA/aBkRPJMpztti7y+pww=
=unIj
-----END PGP SIGNATURE-----

--VWW411jV3j9OGq9a--

