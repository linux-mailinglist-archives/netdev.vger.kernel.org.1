Return-Path: <netdev+bounces-289929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGWEIv+pDWpr1AUAu9opvQ
	(envelope-from <netdev+bounces-289929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6758DBAD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA13730416C7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057E3DCD8B;
	Wed, 20 May 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRHcG9f0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DB34388D;
	Wed, 20 May 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279853; cv=none; b=ncrPGcKfeyM4S/pfdtidOSjracqRQuV+YqhsGA3rZR5WXJuI9DlLSAV71UxJJJmZNJMC10WXjeFXhB6+Y5X8rtUcUhJ5iSTGZynsHQ2sy7tZMrjryx5d2imOwdgC6jsmWUAi+KkJV9ru5EokK+RoSX3EqrVmyAz43VjxRdKnvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279853; c=relaxed/simple;
	bh=iLcrV8/ggZUCdL7TdrWnbYSSneM0BdAQqMfxCMIE6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJGueuSsYSD2MM0HIgLtOJA8EKqljlmcDDb8LhWO5b+RiKTzTUxLFErMwk/PdBdNtDEWu6tYoUEtawBxAgDoMORjD8NHue4q2QwYSt7nHBmIh1CwMhKFJNWMWUNxhDKRSwl2Qqm0u0CZAwSau17YE4SdbInv+8tx2QUiYTmVCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRHcG9f0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43541F000E9;
	Wed, 20 May 2026 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279852;
	bh=pSHRPJXvSTMYe8OPA4sOaIcHJ3HufqxoppwuZG8gbcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRHcG9f0VSXUDcCR0iLfqB/dB6DvCNnsw2d2eNygC534NyMASmkBkjl7USONdhnqo
	 mH0KSMsa7nkdJ57mMWOY7GVAin7cq0uiCQjmI9A0msE8I65tljW9Q6Iqycp8rDGSd3
	 Vhhkc/RfW9rNIZW8f84JNUNCZ8+xpZRSn6+EFjBawserkQXqprzuxKqICNx6ZOahM9
	 9hWSodaCEzVp3U9tWLdmZXKFCZtPgfingBulv6xCamGn6c4JjOwFnRrm51hpEg/rdz
	 7sWnTmSP8rdX5+olJhUHp04U4E4cW4ebYlIeXhK+/i8YjajN+HNF9jLsyYRW4eHbHT
	 y8akObak2aiWQ==
Date: Wed, 20 May 2026 14:24:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 05/10] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Message-ID: <ag2n6ZI57ibyTIIt@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-5-6bd70e329df6@kernel.org>
 <20260520085926.97A481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cf/DgeyQzB2KERex"
Content-Disposition: inline
In-Reply-To: <20260520085926.97A481F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-289929-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D0E6758DBAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Cf/DgeyQzB2KERex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Off-by-one in airoha_tc_remove_htb_queue() clears the hardware r=
ate limit of the wrong QDMA channel, corrupting cross-device shared state.
> - [High] Dynamic real_num_tx_queues accounting causes out-of-bounds queue=
 indices and bypasses hardware QoS entirely.
> --
>=20
> commit cfd982e85e1dc0ffc8dc017589e1128ecce7248e
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
>=20
> This commit moves the qos_sq_bmap field from airoha_gdm_port to
> airoha_gdm_dev to prevent overwriting configurations from multiple
> net_devices sharing the same GDM port. It also introduces
> qos_channel_map in airoha_qdma to track shared QDMA channel usage.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 847f432b0a2b0..594fbebcb12ce 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > +static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
> > +					  struct tc_htb_qopt_offload *opt)
> > +{
> > +	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> > +	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> [ ... ]
> >  	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
> >  	if (err) {
> [ ... ]
> > -	set_bit(channel, port->qos_sq_bmap);
> > +	set_bit(channel, dev->qos_sq_bmap);
> >  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
>=20
> Can this dynamic real_num_tx_queues accounting cause out-of-bounds queue
> indices?
>=20
> The driver tracks allocated QoS leaf queues by incrementing
> dev->real_num_tx_queues by 1. However, the assigned hardware queue index =
is
> derived from a sparse hash of the user-provided classid.
>=20
> If a user allocates a non-sequential classid that hashes to a higher chan=
nel
> number while having only a few queues active, won't opt->qid exceed the
> incremented dev->real_num_tx_queues?
>=20
> During transmission, would netdev_core_pick_tx() then detect this
> out-of-bounds queue mapping, reset the queue index, and route the traffic=
 to
> the default ring 0, silently bypassing the hardware HTB rate limits?

As pointed out before this issue has not been introduced by this series and=
 I
will fix it with a dedicated patch.

>=20
> [ ... ]
> >  static void airoha_tc_remove_htb_queue(struct net_device *netdev, int =
queue)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> > =20
> >  	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
> >  	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
>=20
> Is there an off-by-one error when clearing the hardware rate limit here?
>=20
> The queue + 1 offset causes it to clear the configuration of the adjacent
> channel instead of the one actually being deleted, as the allocation path
> uses channel without the offset.
>=20
> Since this patch enables multiple net_devices to share the same QDMA bloc=
k,
> could clearing queue + 1 silently destroy the active hardware QoS
> configuration belonging to a completely different net_device?
>=20
> Does this also leave the rate limit for the actual deleted queue active,
> and potentially cause an out-of-bounds register write if the deleted queu=
e is
> the maximum channel index (15)?

As pointed out before this issue has not been introduced by this series and=
 I
will fix it with a dedicated patch.

Regards,
Lorenzo

>=20
> > -	clear_bit(queue, port->qos_sq_bmap);
> > +
> > +	clear_bit(queue, qdma->qos_channel_map);
> > +	clear_bit(queue, dev->qos_sq_bmap);
> >  }
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D5

--Cf/DgeyQzB2KERex
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2n6QAKCRA6cBh0uS2t
rFdqAP933TNbLch9BnsWyT1jSo1pxaVO5L2M/1716Xfyl2hFFwD8DGEkVWNTrHfy
lOBQSUgyoPToXkFFufw4f91NZMXKfAM=
=Cr5h
-----END PGP SIGNATURE-----

--Cf/DgeyQzB2KERex--

