Return-Path: <netdev+bounces-292687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HPoAEE7GGo1hggAu9opvQ
	(envelope-from <netdev+bounces-292687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD95F2531
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4893310099D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950D3D093E;
	Thu, 28 May 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEN4v5kO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41343AFAE2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972558; cv=none; b=WD8Vib/atfqPFpXBo3q5zPpPhwpy1gYhbEvwB3pbYfAHw/oifkH9br8fObYPT14nGW7HyaATsJR1amhkKZv3qgajG+2AyPj8XsYEZpeuCEyr3SencXqHmBFgXN7o7E58faxKh7h/FYWfbyBTCzaYM+j5+myXFwE/mnh7tQfFAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972558; c=relaxed/simple;
	bh=squEqL5dkRztRKpG3z2psGrWqwmVqPPejWYTTRa0JbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHKRloTA9yF0R4pPYArRvyZQL98cFWLbmicH6FGJe/n994bq8ZszWohPFK3R1561qaX5OLayrBOjEgZ+ihKMftQXa1p2jAOdJS9+rX4kZm1tlMFEocqE4tn0H5rH+7XL3nNLCbkA3UAunZWAFVi6qIhO8J/ce7Xmi7hOyuhf1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEN4v5kO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EC91F000E9;
	Thu, 28 May 2026 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972556;
	bh=BdTf/XL83BO5DVn2I2t8yIIiGexfhR/e5m10V8sBCrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gEN4v5kOi4MVsq2iPw8fvNqKlquhfthjM1NUH26HV1XQWvwUfdNASDTufaQQpL58r
	 f5GjvQY1g3K9lrokpQ+LlkTdweaBvb2KDHCmQeaFgt6M87lU4xQiPapp6LqOk5GvgH
	 AcOp5B0BzT5BarJzJnYe8qXHAcMdQsC4H2vLZ2W0O03SRqwTalEh/zWJhRV74RPYwp
	 8tXEUAPPLV2/xbtgD8arRi6a5oEjCZsaFBJ+CuJKUL6lKGNB8jqyM/B+UMEbmhDNhn
	 OlQt9pmqO+0mFRTr54cfX+gtvRRXHZzJKMGy3Uyh3bNHTMWettBEyQfrNo/K7hyqdt
	 Fx/yXkIpmGShA==
Date: Thu, 28 May 2026 14:49:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 4/6] net: airoha: Move qos_sq_bmap in
 airoha_gdm_dev struct
Message-ID: <ahg5ykQLOng5muio@lore-desk>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
 <20260527-airoha-eth-multi-serdes-preliminary-v1-4-ec6ed73ef7fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TMO1IBn/tLXifO32"
Content-Disposition: inline
In-Reply-To: <20260527-airoha-eth-multi-serdes-preliminary-v1-4-ec6ed73ef7fc@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,airoha.com:email]
X-Rspamd-Queue-Id: 4CDD95F2531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--TMO1IBn/tLXifO32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Since now multiple net_devices connected to different QDMA blocks can
> share the same GDM port, qos_sq_bmap field can be overwritten with the
> configuration obtained from a net_device connected to a different QDMA
> block. In order to fix the issue move qos_sq_bmap field from
> airoha_gdm_port struct to airoha_gdm_dev one.
> Add qos_channel_map bitmap in airoha_qdma struct to track if a shared
> QDMA channel is already in use by another net_device.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 58 ++++++++++++++++++++------=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |  6 ++--
>  2 files changed, 40 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index c5d25f7640ac..4f77a0c22162 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2602,30 +2602,40 @@ static int airoha_qdma_set_tx_rate_limit(struct n=
et_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
> -					  struct tc_htb_qopt_offload *opt)
> +static int airoha_tc_htb_modify_queue(struct net_device *dev,
> +				      struct tc_htb_qopt_offload *opt)
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
> -	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> -	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> =20
>  	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
>  		return -EINVAL;
>  	}
> =20
> -	err =3D airoha_qdma_set_tx_rate_limit(netdev, channel, rate,
> -					    opt->quantum);
> -	if (err) {
> +	return airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
> +}
> +
> +static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
> +					  struct tc_htb_qopt_offload *opt)
> +{
> +	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
> +	int err, num_tx_queues =3D netdev->real_num_tx_queues;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_qdma *qdma =3D dev->qdma;
> +
> +	/* Here we need to check the requested QDMA channel is not already
> +	 * in use by another net_device running on the same QDMA block.
> +	 */
> +	if (test_and_set_bit(channel, qdma->qos_channel_map)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack,
> -				   "failed configuring htb offload");
> -		return err;
> +				   "qdma qos channel already in use");
> +		return -EBUSY;
>  	}
> =20
> -	if (opt->command =3D=3D TC_HTB_NODE_MODIFY)
> -		return 0;
> +	err =3D airoha_tc_htb_modify_queue(netdev, opt);
> +	if (err)
> +		goto error;
> =20
>  	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
>  	if (err) {
> @@ -2633,13 +2643,17 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
>  					      opt->quantum);
>  		NL_SET_ERR_MSG_MOD(opt->extack,
>  				   "failed setting real_num_tx_queues");
> -		return err;
> +		goto error;
>  	}
> =20
> -	set_bit(channel, port->qos_sq_bmap);
> +	set_bit(channel, dev->qos_sq_bmap);
>  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
> =20
>  	return 0;
> +error:
> +	clear_bit(channel, qdma->qos_channel_map);
> +
> +	return err;
>  }
> =20
>  static int airoha_qdma_set_rx_meter(struct airoha_gdm_dev *dev,
> @@ -2820,11 +2834,13 @@ static int airoha_dev_setup_tc_block(struct net_d=
evice *dev,
>  static void airoha_tc_remove_htb_queue(struct net_device *netdev, int qu=
eue)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
> =20
>  	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
>  	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
> -	clear_bit(queue, port->qos_sq_bmap);
> +
> +	clear_bit(queue, qdma->qos_channel_map);
> +	clear_bit(queue, dev->qos_sq_bmap);
>  }
> =20
>  static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
> @@ -2832,9 +2848,8 @@ static int airoha_tc_htb_delete_leaf_queue(struct n=
et_device *netdev,
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> =20
> -	if (!test_bit(channel, port->qos_sq_bmap)) {
> +	if (!test_bit(channel, dev->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}
> @@ -2847,10 +2862,9 @@ static int airoha_tc_htb_delete_leaf_queue(struct =
net_device *netdev,
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
>  	int q;
> =20
> -	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> +	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
>  	return 0;
> @@ -2861,9 +2875,8 @@ static int airoha_tc_get_htb_get_leaf_queue(struct =
net_device *netdev,
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> =20
> -	if (!test_bit(channel, port->qos_sq_bmap)) {
> +	if (!test_bit(channel, dev->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}
> @@ -2882,6 +2895,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_dev=
ice *dev,
>  	case TC_HTB_DESTROY:
>  		return airoha_tc_htb_destroy(dev);
>  	case TC_HTB_NODE_MODIFY:
> +		return airoha_tc_htb_modify_queue(dev, opt);
>  	case TC_HTB_LEAF_ALLOC_QUEUE:
>  		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
>  	case TC_HTB_LEAF_DEL:
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index f6f59d25abd9..a308a770116b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -533,6 +533,8 @@ struct airoha_qdma {
> =20
>  	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> +
> +	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
>  };
> =20
>  struct airoha_gdm_dev {
> @@ -540,6 +542,8 @@ struct airoha_gdm_dev {
>  	struct airoha_qdma *qdma;
>  	struct net_device *dev;
>  	struct airoha_eth *eth;
> +
> +	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
>  };
> =20
>  struct airoha_gdm_port {
> @@ -549,8 +553,6 @@ struct airoha_gdm_port {
> =20
>  	struct airoha_hw_stats stats;
> =20
> -	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> -
>  	/* qos stats counters */
>  	u64 cpu_tx_packets;
>  	u64 fwd_tx_packets;
>=20
> --=20
> 2.54.0
>=20

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260527-airoha-eth-multi-serdes-preliminary=
-v1-0-ec6ed73ef7fc%40kernel.org
- This isn't a bug introduced by this patch, but does this modify operation
  skip verifying if the requesting net_device actually owns the channel?
  - Since this issue has not been itroduced by this patch, I will fix it wi=
th a
    dedicated patch.

- This is a pre-existing issue, but does this manage real_num_tx_queues as =
an
  active queue counter rather than a bounding limit?
  - Since this issue has not been itroduced by this patch, I will fix it wi=
th a
    dedicated patch.

- This isn't a bug introduced by this patch, but is there an off-by-one err=
or
  when clearing the TX rate limit for the removed queue?
  - Since this issue has not been itroduced by this patch, I will fix it wi=
th a
    dedicated patch.

Regards,
Lorenzo

--TMO1IBn/tLXifO32
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahg5ygAKCRA6cBh0uS2t
rCMNAQDKEnq+mPIApGyg/eAzCagvKa/9cU3MiYuMNdpto75U8QD+N8D5hY8B0IRa
hQCcDndPJZLjewOZ98m1EYGcJpAxtQo=
=9A/b
-----END PGP SIGNATURE-----

--TMO1IBn/tLXifO32--

