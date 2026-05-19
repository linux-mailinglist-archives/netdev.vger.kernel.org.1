Return-Path: <netdev+bounces-289329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNhLJ8QfDGqoWgUAu9opvQ
	(envelope-from <netdev+bounces-289329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9357A135
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49E7D309D95E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C23E121F;
	Tue, 19 May 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnqIQAei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034EE3E0C7C;
	Tue, 19 May 2026 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178984; cv=none; b=PrGB6PTpNpGNCSG4hFzRTow1b1hLpQPGdqoO3J8/ztFBsReG/1z+cD5We5fiO03RmNU1xlE6t42zv8ifDY8oGWmEx8GkI9DOQ5LVos3kGoNgWorTZqgVBJWDeFkfpSX7IPGZ0IQyroOccV9DV4iKyINRpJ3eh9I4N7Em4jx7gpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178984; c=relaxed/simple;
	bh=thro7mnnhW+9WpBCb+tmj8k0b2t2H/Tbbq/LQowUuzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC4CXu7KLihkY3Ve6755DYkBzihrabeBUQ0BWZBWBfPHoWSRsHafNpU+tiNUg2RGT2n6Jtbyshp1Xs0nzEd4VqTc7XfUchtJ9AiDREelHte41oh2PYYqZMmbHgnEEogZEwGSsz+tkv/z66luPXVVsOGVYYAh6ZeheTRb5lw7B/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnqIQAei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A118C2BCC6;
	Tue, 19 May 2026 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779178983;
	bh=thro7mnnhW+9WpBCb+tmj8k0b2t2H/Tbbq/LQowUuzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnqIQAeiE0wWG0PKpbs0JJDlHfOX2se3rwtV+2/IYDYdblD7l7jeA6GJ6z47X1EvO
	 748WHBIR6gAyB05SMxBvcKPZWrjsR8CYFYYfHjcsNeGerr4F85xOnq9Tfft06OmymK
	 n4JEZSz6kvNndOH7P+XiLeRXzHfGd2Buszbi+S94qLTIBkAUA6Q0dV7subE+wnH6Ic
	 ks+dwxQ/y2em70bv6xWfTO87MsFRByrTHQS+Atw3yoMumswq56ZBHv1N5ztf2RZ1aq
	 yhu25IrR0jnp+xL4Fty4iDPvS+xeBNFi+aoVXqVPqq7Nga/MMUL+3lGetZILPSy3mW
	 UU0jwbfKZgWYA==
Date: Tue, 19 May 2026 10:23:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Message-ID: <agwd5avrCT3qqyqd@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-5-99e0093303e2@kernel.org>
 <20260517055814.3D107C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S4iYFzht4X/oMccC"
Content-Disposition: inline
In-Reply-To: <20260517055814.3D107C2BCB0@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289329-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 44E9357A135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--S4iYFzht4X/oMccC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Off-by-one error in airoha_tc_remove_htb_queue when clearing har=
dware rate limit.
> - [High] Blind increment/decrement of real_num_tx_queues breaks HTB offlo=
ad for non-sequential queue IDs.
> --
>=20
> commit 7088e1abda5f2f9f4a048fc5586684fdaf382845
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
>=20
> This commit moves the qos_sq_bmap field from airoha_gdm_port to
> airoha_gdm_dev to prevent overwrites when multiple net_devices share a GDM
> port. It also adds qos_channel_map to track QDMA channels in use.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index b90fc1cbfbc48..2a2a30dbad27e 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2597,44 +2597,61 @@ static int airoha_qdma_set_tx_rate_limit(struct=
 net_device *netdev,
>=20
> [ ... ]
>=20
> >  	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
> >  	if (err) {
> >  		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
> >  					      opt->quantum);
> >  		NL_SET_ERR_MSG_MOD(opt->extack,
> >  				   "failed setting real_num_tx_queues");
> > -		return err;
> > +		goto error;
> >  	}
> > =20
> > -	set_bit(channel, port->qos_sq_bmap);
> > +	set_bit(channel, dev->qos_sq_bmap);
> >  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
>=20
> This problem wasn't introduced by this patch, but is a logic flaw that
> breaks the offload functionality.
>=20
> When allocating a QoS channel, real_num_tx_queues is blindly incremented =
by
> 1 while the qid is derived from the channel. If a user allocates a
> non-sequential classid (for example, mapping to channel 3 when it is the
> first allocated queue), real_num_tx_queues will become
> AIROHA_NUM_TX_RING + 1, but qid will be AIROHA_NUM_TX_RING + 3.
>=20
> When transmitting, netdev_cap_txqueue() strictly validates that the packe=
t's
> queue_mapping is < real_num_tx_queues.
>=20
> Since qid exceeds the blindly incremented count, will the stack log a war=
ning
> and forcefully route the packet to queue 0, silently bypassing the HTB
> hardware rate limit?
>=20
> Additionally, does blindly decrementing the count when deleting queues
> immediately invalidate any active higher-indexed queues?

Since this issue has not been introduced by this series, I will fix it with=
 a
dedicated patch.

>=20
> > @@ -2815,11 +2832,13 @@ static int airoha_dev_setup_tc_block(struct net=
_device *dev,
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
> This problem wasn't introduced by this patch, but the patch exposes it to
> cross-device corruption.
>=20
> In airoha_tc_remove_htb_queue(), the driver attempts to disable the hardw=
are
> rate limit for the removed queue by calling airoha_qdma_set_tx_rate_limit=
()
> with queue + 1. However, the queue is originally allocated and configured
> using the channel index (where channel equals queue).
>=20
> Passing queue + 1 fails to clear the rate limit of the actually deleted q=
ueue,
> permanently leaking its hardware state. Furthermore, it incorrectly zeros=
 out
> the rate limit of the adjacent queue.
>=20
> Because this patch allows multiple net_devices to share the same QDMA blo=
ck
> and its channels, could deleting a QoS queue on one interface unexpectedly
> corrupt the QoS hardware state of another interface actively using the
> adjacent channel?

Since this issue has not been introduced by this series, I will fix it with=
 a
dedicated patch.

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
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D5

--S4iYFzht4X/oMccC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagwd5QAKCRA6cBh0uS2t
rIoLAP9kDup7PnCYbTDJInYAN6wTDToDw40cWk0vYDIL9MLpyQD+JKxaxReqK8Di
Vz4jItOr+heMuSHJMaUEr9VSv3yM0wY=
=vqYP
-----END PGP SIGNATURE-----

--S4iYFzht4X/oMccC--

