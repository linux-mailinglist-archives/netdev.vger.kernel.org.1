Return-Path: <netdev+bounces-289179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEuxIImEC2oZIwUAu9opvQ
	(envelope-from <netdev+bounces-289179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27324573CFA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AB53014FC2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C4A399031;
	Mon, 18 May 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM2mYQoQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202E37702C;
	Mon, 18 May 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139717; cv=none; b=gEsOGpfFCT8yaHlNM65tm5cQ6ofaSqXHGbIQq0p3cg/BpbxV7YzmnPNyBHpCBvtzqooZ0UJJIvYOUJZyH6t5UwgIw8tH0vuE8E3CW/LHCq+ALw3uUeEPKlDb60UgnwsOtdErrNPmh5JCC9tEaVxDcErxD/AXcgL1LZO7Hhqgs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139717; c=relaxed/simple;
	bh=eyDCCuFqDPxb9ufc2iMt/dv8APMsKsrr9czfOUagKUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWYS3MJZU+9a9dzxxEHgFWT8k/TFZvDPACdfb937/B1bEJPhs3emDVmX/0mG6eMjm/QW6GXcOVnL/8lT8GwiENlEQH32TcnCq1tGyeOOTT5Xj/+dGt3/MSMLn8JxeCnUjWky1qYwxYQ2EgtlwpSIYL+70fPj0JLT3jaHxMIAbqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM2mYQoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4682AC2BCB7;
	Mon, 18 May 2026 21:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139716;
	bh=eyDCCuFqDPxb9ufc2iMt/dv8APMsKsrr9czfOUagKUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM2mYQoQuKsr5CeE6ZGXvvSIVt2v7jWedNc6N10pf0FNt4U6htNlHs863SvFtlDjy
	 TcKS0aAWksi32VGLUuGrmRMjrMjP+X0gjTlT9P6dIcPLzxLX/T69JA7ks6CpalgE8j
	 PTeC6SisqI+XelbbySo8+GESuXd0UTPqHSkDC2XqK7Kc+64xjF1YsFtd96PF5BNX2T
	 6t1En6LtfPU0clYT15RMH6ltjcQlmjM1k1L2pxAd/zgPKb/CNJyAW7hwbue//a15Mm
	 tlkdMdz9WUdWniaTLwSyRx6CDCsCEOFmKBZuswQ1rXl1W+VO8K1cvy6Swz84/GbbOy
	 krU5yN1J+ojcQ==
Date: Mon, 18 May 2026 23:28:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/10] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <aguEgmX1FDblt0g5@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-7-99e0093303e2@kernel.org>
 <20260517055813.7DF3AC2BCF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Axhv31oSMd8Sc3vC"
Content-Disposition: inline
In-Reply-To: <20260517055813.7DF3AC2BCF5@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289179-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27324573CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Axhv31oSMd8Sc3vC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Hardware state corruption for shared GDM ports
> --
>=20
> commit 68e8fa8fe02248409d0048f81217cd5cf7eda775
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> This commit introduces support for multiple net_devices connected to the =
same
> Frame Engine GDM port via an external hardware arbiter. Note that issues =
with
> shared hardware state introduced here appear to be addressed in later com=
mits
> such as 28e02ac461157 ("net: airoha: Do not stop GDM port if it is shared=
")
> and 01081daf7ce24 ("net: airoha: Introduce WAN device flag"), which add p=
ort
> user reference counting, aggregate the maximum MTU, and restrict WAN loop=
back
> configuration.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -3035,11 +3043,25 @@ static int airoha_alloc_gdm_device(struct airoh=
a_eth *eth,
> >  			 netdev->dev_addr);
> >  	}
> > =20
> > +	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
> > +	 * and PCIE1 respectively.
> > +	 */
> > +	index =3D nbq;
> > +	if (index && airoha_is_7581(eth) && port->id =3D=3D AIROHA_GDM3_IDX)
> > +		index -=3D 4;
> > +
> > +	if (index >=3D ARRAY_SIZE(port->devs) || port->devs[index]) {
> > +		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	netdev->dev.of_node =3D of_node_get(np);
> >  	dev =3D netdev_priv(netdev);
> >  	dev->dev =3D netdev;
> >  	dev->port =3D port;
> > -	port->dev =3D dev;
> >  	dev->eth =3D eth;
> > +	dev->nbq =3D nbq;
> > +	port->devs[index] =3D dev;
>=20
> With multiple net_devices now sharing a single GDM port, could this cause
> hardware state corruption when configuring shared hardware registers?
>=20
> For example, in airoha_dev_init(), airoha_set_gdm2_loopback() overwrites
> the global REG_FE_WAN_PORT register entirely, which might wipe out the
> configuration of previously initialized devices on the same port:
>=20
> 	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
> 		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
> 		      FIELD_PREP(WAN0_MASK, src_port));

A subsequent patch enforces this constraints, we can have at most one port
configured as WAN.

>=20
> Additionally, in airoha_dev_stop(), unconditionally writing FE_PSE_PORT_D=
ROP
> to REG_GDM_FWD_CFG(port->id) appears to drop all traffic for the entire
> GDM port, breaking other active devices sharing it.

This is fixed by a subsequent patch.

>=20
> Similarly, in airoha_dev_change_mtu(), overwriting REG_GDM_LEN_CFG(port->=
id)
> with a lower MTU could restrict the hardware limit for the entire port, c=
ausing
> packet drops for other devices that require a higher MTU.

This is fixed by a subsequent patch.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D7

--Axhv31oSMd8Sc3vC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaguEggAKCRA6cBh0uS2t
rOGUAP4+h4SnhYv7A5cnc3SGymqWz+mx16+yAngGdIj593XdCQD/ZRFRYAKc8FEw
K+WgUT2j49heWAsMLi22SOayZk6xwAo=
=abbF
-----END PGP SIGNATURE-----

--Axhv31oSMd8Sc3vC--

