Return-Path: <netdev+bounces-286534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DlXOp+XAWq9fQEAu9opvQ
	(envelope-from <netdev+bounces-286534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:47:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7AE50A4D8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89CD13001308
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E83B27D0;
	Mon, 11 May 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy2DNjps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6F33689F;
	Mon, 11 May 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489244; cv=none; b=Evgv1QSy0wAoA/wvC/uNxFyCZxiezyuoLeHtr5CNkvEmZVv8X5hil9uWp3nyNIiIojiLI5PCNDdn1cye4G7nscpi/UhXlF+8/MFDwhcqD0zjrnxDCQK48hPIGmL5A1QFRtQeY+xD7sOkjs44L6Lq1x45UfsJMSi1EoT5SLbuEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489244; c=relaxed/simple;
	bh=CXTt0tSeCFW4xBtUicag62EoWcQIhZ48Jxj24qD9sFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzYutsZ+4QxlYwfawGhPO97Ok4R1DdQl5JcgoU6dL171o8Jnsi5BLNUG+fDv4wU4udoyhNU5lflaUiCtk/VqbEzcjXrx+jfaPXS1OuIirXSNTKI4dfA8FTziaC9EAh+Lxk4WCa+3fd2XLPsXBKZ+O6l0Zx7k9Crkv05koIbXiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy2DNjps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55008C2BCB0;
	Mon, 11 May 2026 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778489243;
	bh=CXTt0tSeCFW4xBtUicag62EoWcQIhZ48Jxj24qD9sFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fy2DNjpsc6zpNJyyl8e+ziX2OC1dUkqm4wqEY0LGp+JhAkXtoFptptSuN3721jJ7I
	 2qg9kRWqLW2GymTX6R4Y4ZdItM5EgRyXV3CUlYiwofwnnQjRmjJ220lFWBFNZ/mGfx
	 12U+52KgO8QoiWP9J3GXyJ7rNppi+ZXNtxXB5QsQfN/vl7w86bP7M8oad16YkFOihz
	 cDOSTWpkpAFlHI8ig0FAjGYwvH8KYJPu83ByqscnOWhJrknfiGoilQtD56ZA7V+LTz
	 wfY8RjXUup7yS2xJYde7FDEQRC8ZoPFg38Tk+HEUhlvnX5yCLXd75WLHZoGGq6EuqE
	 +maFGGDJcoD0Q==
Date: Mon, 11 May 2026 10:47:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Message-ID: <agGXmZ4mVqn8BPU8@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-6-805e38edc2aa@kernel.org>
 <20260510140504.5D5A6C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIdAEi/jQ2SpOuYP"
Content-Disposition: inline
In-Reply-To: <20260510140504.5D5A6C2BCC9@smtp.kernel.org>
X-Rspamd-Queue-Id: 8C7AE50A4D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286534-lists,netdev=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--EIdAEi/jQ2SpOuYP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] HTB node modification unconditionally fails with -EBUSY and its =
error path can silently corrupt global channel ownership.
> - [High] Hardware teardown failures cause a permanent leak of shared QDMA=
 channels.
> --
>=20
> commit 1b146a034660fa016267e6a142564dd1ddeb17b1
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
>=20
> This commit moves the qos_sq_bmap field from airoha_gdm_port to airoha_gd=
m_dev
> to prevent configuration overwrites when multiple net_devices share a GDM=
 port.
> It also adds a qos_channel_map bitmap to airoha_qdma to track shared QDMA
> channels.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index f9cb49f0529a0..33a0f7b98d52e 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2606,19 +2606,28 @@ static int airoha_tc_htb_alloc_leaf_queue(struc=
t net_device *netdev,
> >  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
> >  	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> > =20
> >  	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
> >  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> >  		return -EINVAL;
> >  	}
> > =20
> > +	/* Here we need to check the requested QDMA channel is not already
> > +	 * in use by another net_device running on the same QDMA block.
> > +	 */
> > +	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
> > +		NL_SET_ERR_MSG_MOD(opt->extack,
> > +				   "qdma qos channel already in use");
> > +		return -EBUSY;
> > +	}
> > +
>=20
> Since this function handles both TC_HTB_LEAF_ALLOC_QUEUE and
> TC_HTB_NODE_MODIFY, won't the bit already be set in qdma->qos_channel_map
> for modify operations?
>=20
> If so, will modify operations now always fail with -EBUSY here,
> breaking HTB rate limit updates?

ack, I will fix it in v6

>=20
> >  	err =3D airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
> >  					    opt->quantum);
> >  	if (err) {
> >  		NL_SET_ERR_MSG_MOD(opt->extack,
> >  				   "failed configuring htb offload");
> > -		return err;
> > +		goto error;
> >  	}
> > =20
> >  	if (opt->command =3D=3D TC_HTB_NODE_MODIFY)
> > @@ -2630,13 +2639,17 @@ static int airoha_tc_htb_alloc_leaf_queue(struc=
t net_device *netdev,
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
> > =20
> >  	return 0;
> > +error:
> > +	clear_bit(channel, qdma->qos_channel_map);
> > +
> > +	return err;
> >  }
>=20
> If a modify operation (TC_HTB_NODE_MODIFY) fails at
> airoha_qdma_set_tx_rate_limit(), it jumps to the error label.
>=20
> Won't this unconditionally clear the bit in the shared qdma->qos_channel_=
map?
>=20
> Could this accidentally release ownership of the shared QDMA channel while
> the device is still using it, allowing another net_device to claim it?

ack, I will fix it in v6

>=20
> [ ... ]
>=20
> > @@ -2814,14 +2827,28 @@ static int airoha_dev_setup_tc_block(struct net=
_device *dev,
> >  	}
> >  }
> > =20
> > -static void airoha_tc_remove_htb_queue(struct net_device *netdev, int =
queue)
> > +static int airoha_tc_remove_htb_queue(struct net_device *netdev, int q=
ueue)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_qdma *qdma =3D dev->qdma;
> > +	int err;
> > =20
> > -	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
> > -	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
> > -	clear_bit(queue, port->qos_sq_bmap);
> > +	err =3D netif_set_real_num_tx_queues(netdev,
> > +					   netdev->real_num_tx_queues - 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
> > +	if (err) {
> > +		netif_set_real_num_tx_queues(netdev,
> > +					     netdev->real_num_tx_queues + 1);
> > +		return err;
> > +	}
> > +
> > +	clear_bit(queue, qdma->qos_channel_map);
> > +	clear_bit(queue, dev->qos_sq_bmap);
> > +
> > +	return 0;
> >  }
>=20
> If a hardware teardown failure occurs and airoha_tc_remove_htb_queue()
> returns early with an error, the bits in qdma->qos_channel_map and
> dev->qos_sq_bmap are never cleared.

ack, I will fix it in v6

>=20
> >  static int airoha_tc_htb_destroy(struct net_device *netdev)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> >  	int q;
> > =20
> > -	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> > -		airoha_tc_remove_htb_queue(netdev, q);
> > +	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS) {
> > +		int err;
> > +
> > +		err =3D airoha_tc_remove_htb_queue(netdev, q);
> > +		if (err)
> > +			return err;
> > +	}
> > =20
> >  	return 0;
> >  }
>=20
> In this loop, an error on a single queue immediately aborts the loop, lea=
ving
> any remaining queues unprocessed.
>=20
> Since the core networking stack (net/sched/sch_htb.c) ignores the return =
value
> of TC_HTB_DESTROY and fully destroys the software qdisc regardless, will =
this
> permanently leak the limited QDMA hardware channels?
>=20
> Could these bits remain set forever in the globally shared qdma->qos_chan=
nel_map,
> preventing other net_devices from using them until the driver is reloaded?

ack, I will fix it in v6

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D6

--EIdAEi/jQ2SpOuYP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGXmQAKCRA6cBh0uS2t
rJOjAP9rhs2kkxiegggDAlgI+bM+WZGoB/Xx5QWTbM9uCJ8DugD9EItJYotJxs5T
Xb4rPMkMCQMxoSR3AqzGAxWEC/W21AM=
=Oupv
-----END PGP SIGNATURE-----

--EIdAEi/jQ2SpOuYP--

