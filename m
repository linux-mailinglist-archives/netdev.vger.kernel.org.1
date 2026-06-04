Return-Path: <netdev+bounces-295103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9kqGCk6IWq4BQEAu9opvQ
	(envelope-from <netdev+bounces-295103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCDB63E10E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hkUnuWr2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295103-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295103-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FA02300D764
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62813D3329;
	Thu,  4 Jun 2026 08:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD23C199E;
	Thu,  4 Jun 2026 08:33:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562007; cv=none; b=W3ZymFLtZmAy4T2QkhcFNWFj6jdq9WZ2oMpCe94yL1OjUeggKAlnzx627puMIauEy8+Wc4cA28jm1TMsBidrCVxec/j6IdlsMJeWPgJ3Q72xfGaQTZEZLppJGRNlTLg2G4gfv91ClVZzLYLFFJHbv10rszh3tiygnD1/w68cnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562007; c=relaxed/simple;
	bh=fN7QWmBX6UiZ9Jfh+lKcCqexBDWY1iBe5MdOt+/SSyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpeAL+rSaB19o2woXYhghALQY2CKLDLDEXljmZEcZYfAeuHOiIaowCR2C4H5he6vLp6+2USQNM4852rKwr0kQRkLavMOmGCoR29PAo6acqr4Iqu241D8qdDi/8POyN50E830bFlBUtUuZOA0JLg9Q/btB3QjZqWaIetLM06xclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkUnuWr2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F81F00893;
	Thu,  4 Jun 2026 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562006;
	bh=x9K5u8SP5ZGeSxr1oo9OtnVaDCP+qHoYO4mPjYD+CG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hkUnuWr2s6CgeVuGMi9AEipArgipRW2JONlQleVvc+seerS2gQJBeAH+kHKPj6uvK
	 vJSaP7HQcI5eukq+A69Ncl1Pf1vKI7GzYQcun63DKK4NS9xN8vPQsArTZ8SIyHsfUR
	 d/p3d2mFnM0feIu3A0HFh0edUZGoAnFHqgscRnFRFbjILxIrgqD3trNM9nBWUCufiQ
	 PCVSjQikq4DzeZLVaXcjCoA2GnC6hOXBt6cBlyu9vhU02Y04PKWYzcYEOaBTQvrS6K
	 4Ozs3FJeQ+oBbjUyVDmCvhbFAVt4uBgfhibY8btXIpTdCseXk85BT2+MYcEzoJtzjW
	 0TGvXjRkzLZJQ==
Date: Thu, 4 Jun 2026 10:33:23 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/6] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <aiE4U_HOgBpuRZOm@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-3-5d476bc2f426@kernel.org>
 <20260604060125.5B5A11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W5hlnucVWG49UUuI"
Content-Disposition: inline
In-Reply-To: <20260604060125.5B5A11F00898@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:conor+dt@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DCDB63E10E


--W5hlnucVWG49UUuI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> Are there similar issues with the ingress configuration?  Earlier in
> airoha_dev_open(), REG_GDM_INGRESS_CFG(port->id) is modified based on whe=
ther
> the specific netdev uses DSA:
>=20
> 	if (netdev_uses_dsa(netdev))
> 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
> 			      GDM_STAG_EN_MASK);
> 	else
> 		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
> 				GDM_STAG_EN_MASK);

This is not a real issue since just GDM1 can be used as cpu port of the dsa
switch (MT7630) and we do not support multiple net_devices for GDM1.

>=20
> Also, do airoha_dev_stop() and airoha_dev_change_mtu() have similar
> regressions?  They appear to blindly overwrite shared registers like
> REG_GDM_FWD_CFG (setting it to FE_PSE_PORT_DROP) and REG_GDM_LEN_CFG(port=
->id).
>=20
> I noticed the stop() and MTU issues might be fixed in a subsequent patch,=
 but
> should this intermediate patch be self-contained to avoid breaking
> bisectability?

These issues are addressed in subsequent patches on the same series.

>=20
> [ ... ]
> > @@ -3080,15 +3100,51 @@ static int airoha_alloc_gdm_port(struct airoha_=
eth *eth,
> >  	u64_stats_init(&port->stats.syncp);
> >  	spin_lock_init(&port->stats.lock);
> >  	port->id =3D id;
> > -	/* XXX: Read nbq from DTS */
> > -	port->nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : =
0;
> >  	eth->ports[p] =3D port;
> > =20
> >  	err =3D airoha_metadata_dst_alloc(port);
> >  	if (err)
> >  		return err;
> > =20
> > -	return airoha_alloc_gdm_device(eth, port, np);
> > +	/* Default nbq value to ensure backward compatibility */
> > +	nbq =3D id =3D=3D AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
> > +
> > +	for_each_child_of_node(np, node) {
> > +		/* Multiple external serdes connected to the FE GDM port via an
> > +		 * external arbiter.
> > +		 */
> > +		const __be32 *nbq_ptr;
>=20
> [Severity: Medium]
> Will these multiplexed devices report duplicated, incorrect hardware stat=
istics?

hw statistics will be addressed with a dedicated patch not part of the seri=
es.

Regards,
Lorenzo

>=20
> When userspace queries statistics for any single multiplexed device,
> airoha_dev_get_stats64() fetches from port->stats, which is updated by
> airoha_update_hw_stats() reading the clear-on-read MAC hardware counters =
for
> the entire physical GDM port.
>=20
> Since the port->stats structure is shared across all net_devices attached=
 to
> the port, each device will report the total traffic volume of all devices
> sharing the port rather than its own traffic.
>=20
> Should the driver rely on per-queue software counters to provide accurate
> per-device statistics when hardware MACs are multiplexed?
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260603-airoha-eth-=
multi-serdes-v9-0-5d476bc2f426@kernel.org?part=3D3

--W5hlnucVWG49UUuI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiE4UwAKCRA6cBh0uS2t
rNsZAP0fGngKikTPqftV8uTqDHz1LwoBivQnPwVjtaDVyBF8owD/T8DBwL4Vs5wO
ZAdrFgmC3b0Z1skjdTitrNS/9rQQUQw=
=b3/r
-----END PGP SIGNATURE-----

--W5hlnucVWG49UUuI--

