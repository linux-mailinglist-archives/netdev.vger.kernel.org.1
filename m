Return-Path: <netdev+bounces-286115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN2yKavo/mlCzQAAu9opvQ
	(envelope-from <netdev+bounces-286115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1D4FE9A1
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B7BE3010B93
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB42383C80;
	Sat,  9 May 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0rzUBvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB853537C7;
	Sat,  9 May 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313280; cv=none; b=P5/c4ipWdQJoVK3/HidjMRRGZKdSHTGLsxxLXFnsei73NMppNqDh9QgQXfPmJvJc7o/UdDMLx692pdHABcRBvzyd+hJlShrEq3uMPxETQrOMmgMNbafsmRUlL3V48lRs5a9xHLmrpGxwlhc4fNAG8I4w6g/LwSbqJHXxJvr7Z50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313280; c=relaxed/simple;
	bh=zxyz8FDN5UzWDUVCt3tWqjRCa0K5HokRsZajA9FWsek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK0ioQUI9fytSqsNRQhqeCQz5vtZ74l/eqiuokIJujGle2GrWXOei40GCaZSQfmISnb0zf3vAA9ttVOuKzGJdk5jN2sCXvMzD+1V0saeEmhR2KVcRVd4V9rgoLWq5N7yI1Kl1yNz6iZbq4489+iA14iGkWHTeCSOrv67GMm+t3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0rzUBvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A89AC2BCB2;
	Sat,  9 May 2026 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778313280;
	bh=zxyz8FDN5UzWDUVCt3tWqjRCa0K5HokRsZajA9FWsek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0rzUBvTmVfwTVwe7CTcEVYs2+fRAl+LvX7Voh1dmP5UGx4KZ+7xkZLgR0KsHByP+
	 2WsukQoAQ2WdzXCU4g9J/XIFmPr7qwiCjTok/Sm0ctfGdPq+cW7YULTR7VRzbycW4r
	 mMur2I3fBXKo7hwVWOelVhqGnK4icBPDEVBpgzN6Yng39xHunQM7WlHBCGZ6zvoTRd
	 FGI9eRAYM6GEMIkRLRv0Q8S7gGxf75se8CG0mHWF5Xc0fx7y4H9m/ep+Fsr7VPmwzU
	 YgvczEoW8dyerxHy0ZQGJwNYCBF0Y48vrtYZFeMJbDe//5a9QQ7fSwBklvWfXZzy1O
	 kfVIjRHxOzBcw==
Date: Sat, 9 May 2026 09:54:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 05/10] net: airoha: Move qos_sq_bmap in
 airoha_qdma struct
Message-ID: <af7oPWp43eMDmolL@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
 <20260509014609.3558041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xd5dB8WzQ5hyc0ai"
Content-Disposition: inline
In-Reply-To: <20260509014609.3558041-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 05C1D4FE9A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--Xd5dB8WzQ5hyc0ai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 08, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     net: airoha: Move qos_sq_bmap in airoha_qdma struct
>=20
> The change moves the HTB-offload channel-allocation bitmap from the
> per-netdev airoha_gdm_port to the per-QDMA airoha_qdma, so sibling
> netdevs attached to different QDMA blocks no longer clobber each other's
> bitmap.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 080705e2f58d..69a4c2e0d58b 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2600,7 +2600,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
> >  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
> >  	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> > =20
> >  	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
> >  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> > @@ -2627,7 +2627,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
> >  		return err;
> >  	}
> > =20
> > -	set_bit(channel, port->qos_sq_bmap);
> > +	set_bit(channel, qdma->qos_sq_bmap);
> >  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
> > =20
> >  	return 0;
>=20
> [High]
> Now that qos_sq_bmap is per-QDMA, can two sibling netdevs that share the
> same QDMA block collide on allocation?  On EN7581, GDM2/GDM3/GDM4 all
> select the same qdma pointer via:
>=20
>     drivers/net/ethernet/airoha/airoha_eth.c:
>         /* QDMA0 is used for lan ports while QDMA1 is used for WAN ports =
*/
>         dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
>=20
> and airoha_is_lan_gdm_dev() returns true only for port->id =3D=3D 1, so
> every non-LAN GDM netdev resolves to eth->qdma[1] and shares
> qdma->qos_sq_bmap.
>=20
> The allocation path does not test the bit before setting it:
>=20
>     channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>     ...
>     set_bit(channel, qdma->qos_sq_bmap);
>     opt->qid =3D AIROHA_NUM_TX_RING + channel;
>=20
> If two sibling netdevs on the same QDMA pick classids whose TC_H_MIN
> maps to the same channel, both airoha_qdma_set_tx_rate_limit() calls
> program the same HW TRTCM egress slot, the later caller silently
> overwrites the earlier configuration, and both netdevs receive the same
> opt->qid.  Should this path use test_and_set_bit() (or similar owner
> tracking) to reject a channel already owned by a sibling netdev?

ack, I think we should move qos_sq_bmap in airoha_gdm_dev struct and track =
if a
shared qdma qos channel is already in use. I will fix it in v5.

>=20
> > @@ -2811,11 +2811,11 @@ static int airoha_dev_setup_tc_block(struct net=
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
> > -	clear_bit(queue, port->qos_sq_bmap);
> > +	clear_bit(queue, qdma->qos_sq_bmap);
> >  }
>=20
> [High]
> airoha_tc_remove_htb_queue() operates unconditionally on the caller's
> netdev but clears a bit that may be owned by a sibling netdev on the
> same QDMA.  The effects that follow look like cross-netdev interference:
>=20
>   - netif_set_real_num_tx_queues(netdev, real_num_tx_queues - 1)
>     decrements the caller's tx-queue count for a queue it never
>     allocated, and its return value is discarded (eventually the txq<1
>     EINVAL guard in netif_set_real_num_tx_queues() will trip silently).
>=20
>   - airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0) zeros the
>     egress TRTCM rate-limit registers for a channel that the sibling
>     netdev still considers active.
>=20
>   - clear_bit(queue, qdma->qos_sq_bmap) then hides the channel from the
>     legitimate owner's later test_bit() checks.

This issue will be fixed by the change described above. I will fix it in v5.

>=20
> > @@ -2838,10 +2838,10 @@ static int airoha_tc_htb_delete_leaf_queue(stru=
ct net_device *netdev,
> >  static int airoha_tc_htb_destroy(struct net_device *netdev)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> >  	int q;
> > =20
> > -	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> > +	for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> >  		airoha_tc_remove_htb_queue(netdev, q);
> > =20
> >  	return 0;
> >  }
>=20
> [High]
> Does airoha_tc_htb_destroy() now walk bits owned by sibling netdevs?
> The iteration no longer filters by owning netdev:
>=20
>     for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>         airoha_tc_remove_htb_queue(netdev, q);
>=20
> Previously each netdev had a private bitmap, so destroy could only
> touch its own channels.  After this change, tearing down HTB on one
> GDM netdev appears to remove channels and clear rate-limit HW state
> belonging to every sibling GDM netdev on the same QDMA.  A subsequent
> tc-htb delete or get on the legitimate owner then hits:
>=20
>     if (!test_bit(channel, qdma->qos_sq_bmap)) {
>         NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>         return -EINVAL;
>     }
>=20
> Should the bitmap track the owning netdev alongside the bit (for
> example a per-channel owner pointer, or a per-netdev sub-bitmap inside
> airoha_qdma), so that destroy/delete can only touch channels owned by
> the caller?

This issue will be fixed by the change described above. I will fix it in v5.

Regards,
Lorenzo

>=20
> > @@ -2852,9 +2852,9 @@ static int airoha_tc_get_htb_get_leaf_queue(struc=
t net_device *netdev,
> >  {
> >  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> > =20
> > -	if (!test_bit(channel, port->qos_sq_bmap)) {
> > +	if (!test_bit(channel, qdma->qos_sq_bmap)) {
> >  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
> >  		return -EINVAL;
> >  	}

--Xd5dB8WzQ5hyc0ai
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf7oPQAKCRA6cBh0uS2t
rN3RAQCwaawlr2yErx3LmHhe0E+rMXHt3D2fiJwpOoWIsi7hiQEAi8DO4s7DF7IM
P/IEb6FGOSDFfHmE1ucbwpvLwHIbngg=
=tFrn
-----END PGP SIGNATURE-----

--Xd5dB8WzQ5hyc0ai--

