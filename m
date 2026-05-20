Return-Path: <netdev+bounces-289940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFKgIb+uDWrW1QUAu9opvQ
	(envelope-from <netdev+bounces-289940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C568958E427
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DA1A3066BE4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0113E00A9;
	Wed, 20 May 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+QefKMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E62E3397;
	Wed, 20 May 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281200; cv=none; b=J7YYQ90HY3esLfL6MlemifnzT+hr0hVtf0xZXBJGK5lTvjbRDnw1P8uduCkA3jTMoUFuIhdjlh1sO204gK+etpIC2FNE0NtRXsMDhK3DAdmqr6nDwInAEdW4z/S7U3fRC6AuauPBJ24FF9p9P3GD2rTIl3JFgyee5EXfjbqk8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281200; c=relaxed/simple;
	bh=Oj8acMtU2G9Hnr5h1H8D/0eXrcjQ+7flWUVC72yYfbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI5us3bPC931Mw/hwIKKEb4DNi6ZyEv9G050gApqtj+uYqiL7gJxT3rONHtM2Cb4KqeUC1ehaYzK+ngIugSkzlROe8TVK41W1QHIvK8szS1TEe67Z+8FtkBWMkm1XLAMOnEtdjyxSbVeK/2kez7LlNDRBue+S68kn2XuDU6p8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+QefKMA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D031F000E9;
	Wed, 20 May 2026 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281199;
	bh=HA5J7j3Eq/ArC7Y7uw56ulwYKzG7952DMvsvOBRob3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c+QefKMAKzne3Mn1HFG8sfm1Z3y4hPEnQ8ELclV5VI7KM22VA9XLkzzUhIjarjDSc
	 LKETPW3khf6THLBZaT36f9sXsxB7cCfUILoDC2L8Xf80T1vRH2gugYWUZstK/6OI77
	 je1FR7UvZadmKoRlgV5Gt8US3JIjr/k+C6TMVr2x/Qeit2ZhQTJiT1oufSiu4Vr1zO
	 giq5Nhz4UDyAq83Djie7WTdqew4MSvGO9WmPr4Y28BhvyFwN2Op9NVp+1hzfFja2nC
	 Yzr99ZXTYXDI68ORc8IWqpfAgYrTydaCR9E1UUGez6nOY/uf0rb/am+tP4IMSydDNl
	 N/FeLLP2r9LfA==
Date: Wed, 20 May 2026 14:46:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 09/10] net: airoha: Introduce WAN device flag
Message-ID: <ag2tLKJfVLV82o7t@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-9-6bd70e329df6@kernel.org>
 <20260520085933.C009F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aIJq2R5uZPRpkgYw"
Content-Disposition: inline
In-Reply-To: <20260520085933.C009F1F00893@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C568958E427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--aIJq2R5uZPRpkgYw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> [ ... ]
> > +static int airoha_dev_init(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	struct airoha_gdm_port *port =3D dev->port;
> > =20
> >  	switch (port->id) {
> >  	case AIROHA_GDM3_IDX:
> > +	case AIROHA_GDM4_IDX: {
> > +		struct airoha_eth *eth =3D dev->eth;
> > =20
> > +		/* GDM2 supports a single net_device */
> > +		if (eth->ports[1] && eth->ports[1]->devs[0])
> > +			break;
>=20
> Is there a strict probe-order dependency for these interfaces?
>=20
> If GDM3 or GDM4 is probed before GDM2, eth->ports[1]->devs[0] will be NUL=
L.
> This leads GDM3/GDM4 to assume GDM2 is inactive, take the WAN role, and f=
orce
> GDM2 into loopback mode.
>=20
> Later, when GDM2 initializes:
>=20
> > +	case AIROHA_GDM2_IDX:
> > +		/* GDM2 is always used as wan */
> > +		dev->flags |=3D AIROHA_PRIV_F_WAN;
> >  		break;
>=20
> It unconditionally assigns itself the WAN role.
>=20
> Does this probe ordering create multiple WAN devices and leave GDM2's
> hardware silently misconfigured since its routing capabilities were disab=
led
> by GDM3's loopback configuration?

This is not a real issue since GDM2 is always registered before GDM3/GDM4.

>=20
> >  	default:
> >  		break;
> >  	}
> > =20
> > +	airoha_dev_set_qdma(dev);
> > +	airoha_set_macaddr(dev, netdev->dev_addr);
>=20
> When setting the MAC address, airoha_set_macaddr() does the following:
>=20
> static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
> {
> 	...
> 	reg =3D airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
> 	...
> 	airoha_fe_wr(eth, reg, val);
> }
>=20
> Since REG_FE_LAN_MAC_H is a global forwarding engine register rather than
> per-port, will initializing subsequent LAN devices overwrite the hardware
> MAC filter configured by the first LAN device?
>=20
> Might this cause the hardware to drop packets for LAN interfaces that do =
not
> match the single overwritten MAC address?
>=20
> (Note: This was observed to be fixed later in the series by commit "net:
> airoha: Support multiple LAN/WAN interfaces for hw MAC address configurat=
ion",
> but is mentioned here as it appears to introduce a regression in this com=
mit.)

As pointed out here, this is resolved in a subsequent patch in the series.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D9

--aIJq2R5uZPRpkgYw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2tLAAKCRA6cBh0uS2t
rCJ4AQDOp+QE+KOzGLeo06yV7X68jypkI6k1608m+Gw8zmz3ewD/Wa7eJ5k9/V09
hqlXwG29615S1lPJYE8PZp/HISn3iwA=
=9rTp
-----END PGP SIGNATURE-----

--aIJq2R5uZPRpkgYw--

