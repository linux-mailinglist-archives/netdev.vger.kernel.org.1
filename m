Return-Path: <netdev+bounces-286504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHv6NaWRAWrTeQEAu9opvQ
	(envelope-from <netdev+bounces-286504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0B50A026
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9403A30BCAD8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577393AC0F5;
	Mon, 11 May 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6J9hkPj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AD3A6EFE;
	Mon, 11 May 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486062; cv=none; b=VhyZfiQJ9PLC0jx9JU92ibahJrHHbu3WFAnpl0Zoay0fl3iaFKWY+/rgjIbBk/2wvP/Rwo5WZ2iLXEHGD28fxAhmdDapfXiXkZRjPiJg8RLH9CP03gulNi39gPmYrALjB/K4D48k4YXGCLSyvmr7cVydCjg93VkhFvw16ssVGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486062; c=relaxed/simple;
	bh=E5OPf2SDqQ00xjJWpfbMQbDpFigCPNo4Of0MT3coKB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfv15CpEIb9sWo/9F7S2dZ94DYSeVgKLpeixHpeL5jeOvn92f3KXR13KDTcr7dqtx3xmx7gLtraL3xsXCc/ZXNkAkYpvp4Y0emCIYNBRX916ct0X9d7BA8pCz4BHhxRxpI83JrDhOknHEop1EQvxkXShtg63Vxw8alkZIRGryLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6J9hkPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B92C2BCB0;
	Mon, 11 May 2026 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778486061;
	bh=E5OPf2SDqQ00xjJWpfbMQbDpFigCPNo4Of0MT3coKB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6J9hkPjKWEbNx+OsdlIBLga2ANasCWijD7hwSoJJZrC2Pbc7+kxM8y5gJvfEQC+1
	 NUQ9gsky83wC01EmUHjv1a/xzsYbMLEsNj88y/0qAL1/3XR7cJQIQScz8Tj+6iM7rA
	 ZEtBTjpSmjp8pJWvJ17IC4fnyoEV5580K30uEhFXtLo/YUJH1fVYbKeJ450F+WRc8i
	 1igBevsIlSchptcloIi3h4TD6uqWnuVkHgbfU3RdZPpYC7qye0q/0e1PryZdUQhKVh
	 PaWEzoK//2D8xlwSLWOcVP55o9BGX7dEtc1MLi07xUHxNYeYtA4vptPONsfiOd0sNQ
	 xkNfoPrdnR7sw==
Date: Mon, 11 May 2026 09:54:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/12] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <agGLKkphZ0VhIywY@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-8-805e38edc2aa@kernel.org>
 <20260510140503.958BDC2BCFF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I86ZFwpODncJaq/I"
Content-Disposition: inline
In-Reply-To: <20260510140503.958BDC2BCFF@smtp.kernel.org>
X-Rspamd-Queue-Id: 3DE0B50A026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286504-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--I86ZFwpODncJaq/I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Bringing up a device overwrites the global WAN port and GDM loop=
back configuration of previously opened devices sharing the same port.
> - [Medium] Standard netdev statistics and ethtool MAC/RMON stats return t=
he combined hardware counters for the entire GDM port instead of per-interf=
ace statistics.
> --
>=20
> commit 6b561eda8762bee9a19daa9304286dbd64cc6eac
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> Introduce support for multiple net_devices connected to the same Frame En=
gine
> (FE) GDM port (GDM3 or GDM4) via an external hw arbiter.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 904f8da936005..be31f639f4be3 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1829,7 +1833,7 @@ static int airoha_set_gdm2_loopback(struct airoha=
_gdm_dev *dev)
> >  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> >  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> > =20
> > -	src_port =3D eth->soc->ops.get_sport(port, port->nbq);
> > +	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
>=20
> Does bringing up a device overwrite the global WAN port and GDM loopback
> configuration of previously opened devices sharing the same port?
>=20
> Since multiple devices can now share the same GDM port and each has a
> different nbq (and therefore a different src_port), wouldn't the
> initialization of the second device clobber the WAN port configuration of=
 the
> first one, breaking its forwarding behavior?
>=20
> I noticed this is fixed later in the series in commit 8e8f8223af5be ("net:
> airoha: Introduce WAN device flag"), but wanted to confirm the regression
> between commits.

Correct, airoha_set_gdm2_loopback() is run just for WAN net_device and a
subsequent patch limits the support to a single WAN device.

>=20
> >  	if (src_port < 0)
> >  		return src_port;
> > =20
> [ ... ]
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index 694e83bfd1e70..8d6887e334130 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> [ ... ]
> > @@ -539,19 +540,20 @@ struct airoha_qdma {
> >  struct airoha_gdm_dev {
> >  	struct airoha_gdm_port *port;
> >  	struct airoha_qdma *qdma;
> > -	struct net_device *dev;
> >  	struct airoha_eth *eth;
> > +	struct net_device *dev;
> > =20
> >  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> >  	/* qos stats counters */
> >  	u64 cpu_tx_packets;
> >  	u64 fwd_tx_packets;
> > +
> > +	int nbq;
> >  };
> > =20
> >  struct airoha_gdm_port {
> > -	struct airoha_gdm_dev *dev;
> > +	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
> >  	int id;
> > -	int nbq;
> > =20
> >  	struct airoha_hw_stats stats;
>=20
> Since standard netdev statistics and ethtool MAC/RMON stats are tied to t=
he
> hardware counters on the GDM port, do they now return the combined hardwa=
re
> counters for the entire GDM port instead of per-interface statistics?
>=20
> Prior to this patch, each GDM port mapped to a single net_device, making
> port-wide hardware stats accurate for the interface. With multiple net_de=
vices
> sharing a single GDM port, querying statistics for one interface might
> incorrectly return the aggregated traffic of all interfaces connected to =
that
> port, violating standard rtnl_link_stats64 semantics.
>=20
> I noticed this is fixed later in the series in commit 29334a9bde18f ("net:
> airoha: Better handle MIB for GDM with multiple port attached").
>=20

Correct, this is fixed by a subsequent patch.

Regards,
Lorenzo

> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D8

--I86ZFwpODncJaq/I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGLKgAKCRA6cBh0uS2t
rMF3AP0RLVH1BUBktGa8mzV8rfg1YVHHkb0u2MSuklmwoqDnxwD/f21aDQk4lpzG
k6fW/ysM0wQA78uX4Sh42xeIMjGA6wQ=
=jThD
-----END PGP SIGNATURE-----

--I86ZFwpODncJaq/I--

