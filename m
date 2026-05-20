Return-Path: <netdev+bounces-289943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKMKG3OvDWrW1QUAu9opvQ
	(envelope-from <netdev+bounces-289943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:56:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6658E52E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34EEE3037D51
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2C3E16A9;
	Wed, 20 May 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMjw0EAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A623E0239;
	Wed, 20 May 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281383; cv=none; b=UfYnHZKzQQi17r5V+WiUE746phIDOKlu9BkjjQzVZRxTDVgsfhHHewHZH8J/uKDytjvj3/rCYXSeqUE1x7XkFTSoaTtPVFYLGbUmytI7H3qslmNxdyyhq+XI0Pq0FCEcuGHZ5g1I5tOf8JneoZGgLGpeZsiDGs0SnT35/INaITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281383; c=relaxed/simple;
	bh=KmVd/ihzkGCoBUrH7xogZ5bUXVvBCR9g1gzy0Vzrm5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IClKradrx96akUw4MiZ2AaEu3lNO3Lr+8RtsqxykVuBME9JwyzpOWvP9X8LR69wwnrnfuorwuKEeH1fSRGlIXgtTd4iiCaq48qRbFQ4m51K4x7bnjnQdsRyfJiapHcY2KryRBxM1UXm9UslEsDta59I30RB+PDhNieAG3LmdvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMjw0EAH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353CB1F000E9;
	Wed, 20 May 2026 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281379;
	bh=XrCDaCldiYBERJ3Kig82Xmfaf3LKcNTJ3g7KcWrZZwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMjw0EAHZuXkZ1bGrSUt5nh8GPVHRaJr22LqFqJwgh3fA70Z+h7IWqrubdEuqwBYn
	 OlFbIoXHbpvBKoQlXie2/ANi7m5qkvshPYJrUh7Obqm1I+1yzyN/MUnlRPffbCIADB
	 X8o2jnr17TrGJtXYSsKPTkKdGQdoTM4CMzyBvqqw7KARkRrkf+cr+WSENzaYzzPGsU
	 Qx9uokjV4W2fhD9eedLbC2yeslfts8AhtoEhw8Eyg7aMshk9lBi5Q3lz+EIaI53yGs
	 o9mAxEI/rcoaZsdDb4CCeaa8QtzfAunCxw1oPmRjh7XxrLzPH73ffaDQoUtjFzNbZK
	 AsRVlu5uiV08Q==
Date: Wed, 20 May 2026 14:49:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <ag2t4eVe4DcfU2yZ@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
 <20260520085934.54AD01F00894@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SVpQXylfY/87TD/I"
Content-Disposition: inline
In-Reply-To: <20260520085934.54AD01F00894@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-289943-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: BBF6658E52E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--SVpQXylfY/87TD/I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Driver probe fails on systems where MAC addresses are randomly g=
enerated.
> - [High] Configuration deadlock prevents users from changing the MAC addr=
ess OUI.
> --
>=20
> commit dbc4f298ffd475d67c32eeea98f201059b73194a
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
> MAC addresses. The hardware design assumes all interfaces configured as L=
AN
> (or WAN) share a common upper MAC address. This patch extends the logic to
> derive the correct minimum and maximum values when two or more interfaces
> are configured.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 328f94fef2e28..9ae1ba4333097 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,69 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> >  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> >  }
> > =20
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
>=20
> [ ... ]
>=20
> > +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> > +				continue;
> > +
> > +			ether_addr_copy(ref_addr, netdev->dev_addr);
> > +			val =3D (netdev->dev_addr[3] << 16) |
> > +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> > +			if (val < lmin)
> > +				lmin =3D val;
> > +			if (val > lmax)
> > +				lmax =3D val;
> > +		}
> > +	}
> > +
> > +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
>=20
> Does this strict OUI validation cause the driver probe to fail when MAC a=
ddresses
> are randomly generated?
>=20
> If a MAC address is not provided in the device tree, the driver generates=
 a random
> one via eth_hw_addr_random(). For multi-port configurations, each port re=
ceives an
> independently generated random MAC address.
>=20
> Since the upper 3 bytes of these random addresses will almost certainly d=
iffer,
> when register_netdev() is called for the second port, its ndo_init callba=
ck
> (airoha_dev_init) will invoke airoha_set_macaddr() and hit this check. Re=
turning
> -EINVAL will fail register_netdev() and abort the entire driver probe, le=
aving
> the system without networking.
>=20
> Does this also prevent users from changing the MAC address OUI?
>=20
> When an administrator attempts to change the MAC address via standard use=
rspace
> tools, only one interface can be modified at a time. The driver will comp=
are the
> new MAC against the existing MAC of the other port.
>=20
> If the MSBs differ, the change is rejected. This makes it impossible to a=
tomically
> change the OUI of both interfaces simultaneously, locking the MAC address=
 OUI
> to its initial probe-time value.

As pointed out before, this is a hw design requirement when multiple
net_devices are configured as LAN.

Regards,
Lorenzo

>=20
> > +		/* According to the HW design, hw mac address MS bits
> > +		 * must be the same for each net_device with the same
> > +		 * LAN/WAN configuration.
> > +		 */
> > +		netdev_err(dev->dev, "wrong mac addr for shared GDM port\n");
> > +		return -EINVAL;
> > +	}
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D10

--SVpQXylfY/87TD/I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2t4QAKCRA6cBh0uS2t
rOw7AQDAteCh5QGqHibuAWWH5Xf4kDNJ+crj2BTAHUViHGV2UgD7B1jGas3OqoLT
2ug1VU7b+Ii+UhVxr021yHiAKUDsFQE=
=/2zb
-----END PGP SIGNATURE-----

--SVpQXylfY/87TD/I--

