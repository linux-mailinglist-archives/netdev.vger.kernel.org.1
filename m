Return-Path: <netdev+bounces-289935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ArxHA2pDWpr1AUAu9opvQ
	(envelope-from <netdev+bounces-289935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4958DA83
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 846F8300E178
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA03DE43A;
	Wed, 20 May 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL3me7op"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C33DE427;
	Wed, 20 May 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280123; cv=none; b=FuCxnQE3kdBWh8pvPA8e+GqPM4mF0TyKM+0liRJq7DcnN+Pr6GNcVQdBkcRlGhfgP54cHrOqF33ElEFO0txwIgvHFBky0mYBluZDzdQlc4Pxd/x2x3QAbOr7B+RQ5iA0zDVWrZJUkQoli87LReEGn/U5p96eIKyo0hTYilXPob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280123; c=relaxed/simple;
	bh=u0M4354NcRaRw6UV2ZqR75Z7RSZiD8Qk15kGhL8vtIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVSEUBKwy6SfLnbyStr/226n+FQgReUpT3FnPGetdjO4dDqiHmORMTgJ8BRYZkH43MWOTJT9clAuQSHBadCwxplu4ouo5huNg/vktLlqRq5dDM3OBKExqXqBhtSHSb1Nnix199KqUE1LgXr5Q6Lj2uLcVnELmobDzK3QOV9h9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL3me7op; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B41F000E9;
	Wed, 20 May 2026 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280120;
	bh=9QGGlk3LDXhixnD+kizSU53+b+n8Av5GKm/+8vIIvWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RL3me7op5+Ne284qNANnRtEVsnHsTWjWIztw4vNU3VsQ2GOxCYonftnAgUARHgGOo
	 ySQpBay1EpB6b4guqnOMA4uatrGwNyYmAd5DHgpW79Qrg+58hsdoTJtOPWRkR2TSnl
	 GNtZG2YwTWfjeEvYave3oE8OWSoH4tnvQTtc8s1tEE6t+lTIYbbhmflEiVPZmdE19b
	 Vuv5CRlatIzI3GldO2Fdz2qq/TwBc9HXoXpYw9UJ8CUuD5EZs2pzcdNZ9so2658oXA
	 DpGlXxziOQV8WF0nn9HWcBkVgbDTTPoWPh/7b/0KQ1iLrK76aFUe5wRga606fKzy0H
	 V0GR+Ce39u1tw==
Date: Wed, 20 May 2026 14:28:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 07/10] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <ag2o9qLAa2HXN5es@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-7-6bd70e329df6@kernel.org>
 <20260520085933.35D171F00897@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdgogd+ttgvpRBQT"
Content-Disposition: inline
In-Reply-To: <20260520085933.35D171F00897@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Rspamd-Queue-Id: 15F4958DA83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hdgogd+ttgvpRBQT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Port-wide hardware configuration is improperly modified via per-=
net_device callbacks, breaking the newly introduced 1:N relationship.
> - [High] Sequential initialization of multiple net_devices sharing a GDM =
port silently overwrites singleton hardware loopback and WAN configuration =
registers.
> --
>=20
> commit d922e17d3b113696fc139ac4b2b3ef81e2b9ad50
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> This commit introduces support for multiple net_devices connected to the
> same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw arbiter.
> It updates the airoha_gdm_port structure to hold an array of devices inst=
ead
> of a single device.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index fbb50dc73af84..fc49f0049983e 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> [ ... ]
> > @@ -540,19 +541,20 @@ struct airoha_qdma {
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
>=20
> This introduces a 1:N relationship between a GDM port and net_devices, but
> are the net_device lifecycle and MTU callbacks updated to account for sha=
red
> ports?
>=20
> Looking at airoha_dev_stop(), the driver unconditionally drops all traffic
> for the port:
>=20
> airoha_dev_stop()
>     airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id), FE_=
PSE_PORT_DROP);
>    =20
> Since this modifies the forwarding configuration for the entire GDM port,
> does stopping just one net_device silently drop all traffic for the port,
> breaking any other active net_devices sharing it?
>=20
> Similarly, airoha_dev_change_mtu() overwrites port-wide hardware registers
> such as REG_GDM_LEN_CFG. Could this lower the port MTU while another devi=
ce
> still requires a larger MTU?
>=20
> I note this regression is addressed later in the series by commit
> 646f1e7bb6021 (net: airoha: Do not stop GDM port if it is shared).

as pointed out here, this is resolved from a patch in the same series.

>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 27b214ce2a4ed..8d36ab6cd7854 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1830,7 +1831,7 @@ static int airoha_set_gdm2_loopback(struct airoha=
_gdm_dev *dev)
> >  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> >  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> > =20
> > -	src_port =3D eth->soc->ops.get_sport(port, port->nbq);
> > +	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
> >  	if (src_port < 0)
> >  		return src_port;
> > =20
>=20
> When multiple net_devices sharing a GDM port are sequentially initialized
> via ndo_init (airoha_dev_init()), they unconditionally call
> airoha_set_gdm2_loopback().
>=20
> Inside this function, global singleton hardware registers are modified:
>=20
> airoha_set_gdm2_loopback()
>     airoha_fe_rmw(eth, REG_FE_WAN_PORT,
>                   WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
>                   FIELD_PREP(WAN0_MASK, src_port));
>=20
> Does initializing the second device on the same port silently overwrite
> the hardware loopback and WAN configuration of the previously initialized
> device?
>=20
> I see this regression is resolved later in the series by commit
> 8a565b44990bb (net: airoha: Introduce WAN device flag).

as pointed out here, this is resolved from a patch in the same series.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D7

--hdgogd+ttgvpRBQT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2o9gAKCRA6cBh0uS2t
rKsLAQCTKSY91GpYjO0OdC90ZCeNmsb/wVXSqWIzNa6HMKz23gD/X3yJnMzsvJgg
vTiV8EEIEjiuSBUZ3pzo0yDDhflWiwA=
=6JIv
-----END PGP SIGNATURE-----

--hdgogd+ttgvpRBQT--

