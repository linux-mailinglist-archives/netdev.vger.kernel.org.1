Return-Path: <netdev+bounces-286182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIq4HM8x/2lb3QAAu9opvQ
	(envelope-from <netdev+bounces-286182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E474FFC4C
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5D0730071E4
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C338AC65;
	Sat,  9 May 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Rzhe0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EC38A715;
	Sat,  9 May 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332100; cv=none; b=Hjtwo8jE0qAjN3OGPYLmRW4N8tCLbt7QzAojU2UYaeQ5Xap7U5rZs8giKjxyebtaqCFkICAT+xtcpGkPvYn4Sy4CUBwEOpvB8npHfJJxr5c3bEn4zH8EPhtUkLuO5RvUiS9ay10UWHNOqG7pOmO1H/n7nP7TBfvcNr8ugatqUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332100; c=relaxed/simple;
	bh=BnXg7oDTKGqcvqPrItjaoCjleu1iH4Sghq/W+/2oNE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuYk2+hKTIgvFRYjCATSS0wL6Hgl8r9J4CcJQioz3OteQMTn9bbiCE7QVBWIDreATWQVgyQJe7U8TJ0l4GxBDVrzMs0ArIpWqBdIjqocKihgwp4dSb1oySAyfZ8VsO30Pd0LrWijL8Mnt5vU/QVNA9Zu47KJgubXBeRRMRgJ5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Rzhe0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4289DC2BCB2;
	Sat,  9 May 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778332099;
	bh=BnXg7oDTKGqcvqPrItjaoCjleu1iH4Sghq/W+/2oNE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7Rzhe0FpJSKpeKTuYfkF0Xw9kOvuVZlJlx3x33ZsadDuO8HdWWlunAgb7wc94EnR
	 F6J04L49kAFzfKpAlcztxNrAslS4FtAw9U5uLel5LD8giYwTw34or3D8NYukmJPKnf
	 EQPk9MP0blnwafKSG8fG25DfZ9lM1okwabjOB7EKB9CGhp57WBSMCWFU1tGnqDd0zC
	 oncvDbNBlzsCOVv/542TJxF0FInWCM6ZxMpHTgnRNd33PWjTF0noOvJ89PPzM5zhM5
	 J6Ly3gE8UcP4L7Hg85unMrKvmWRBYTaO/0usBQq5ZYMUQ2iUFUBjGU+l/WMhGDl7TG
	 NqVJT7AfNKDFw==
Date: Sat, 9 May 2026 15:08:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/10] net: airoha: Move qos_sq_bmap in
 airoha_qdma struct
Message-ID: <af8xwXjDQ1vHz0dd@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
 <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dHDRJGPLDrB0Lpqz"
Content-Disposition: inline
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
X-Rspamd-Queue-Id: 08E474FFC4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286182-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--dHDRJGPLDrB0Lpqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 07, Lorenzo Bianconi wrote:
> Since now multiple net_devices connected to different QDMA blocks can
> share the same GDM port, qos_sq_bmap field can be overwritten with the
> configuration obtained from a net_device connected to a different QDMA
> block. In order to fix the issue move qos_sq_bmap field from
> airoha_gdm_port struct to airoha_qdma one.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 20 ++++++++++----------
>  drivers/net/ethernet/airoha/airoha_eth.h |  4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 080705e2f58d..69a4c2e0d58b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2600,7 +2600,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct ne=
t_device *netdev,
>  	u32 rate =3D div_u64(opt->rate, 1000) << 3; /* kbps */
>  	int err, num_tx_queues =3D netdev->real_num_tx_queues;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
> =20
>  	if (opt->parent_classid !=3D TC_HTB_CLASSID_ROOT) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> @@ -2627,7 +2627,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct ne=
t_device *netdev,
>  		return err;
>  	}
> =20
> -	set_bit(channel, port->qos_sq_bmap);
> +	set_bit(channel, qdma->qos_sq_bmap);
>  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
> =20
>  	return 0;
> @@ -2811,11 +2811,11 @@ static int airoha_dev_setup_tc_block(struct net_d=
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
> +	clear_bit(queue, qdma->qos_sq_bmap);
>  }
> =20
>  static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
> @@ -2823,9 +2823,9 @@ static int airoha_tc_htb_delete_leaf_queue(struct n=
et_device *netdev,
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
> =20
> -	if (!test_bit(channel, port->qos_sq_bmap)) {
> +	if (!test_bit(channel, qdma->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}
> @@ -2838,10 +2838,10 @@ static int airoha_tc_htb_delete_leaf_queue(struct=
 net_device *netdev,
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
>  	int q;
> =20
> -	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> +	for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
>  	return 0;
> @@ -2852,9 +2852,9 @@ static int airoha_tc_get_htb_get_leaf_queue(struct =
net_device *netdev,
>  {
>  	u32 channel =3D TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
> =20
> -	if (!test_bit(channel, port->qos_sq_bmap)) {
> +	if (!test_bit(channel, qdma->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 18a9dfd75d44..34f1fef51640 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -531,6 +531,8 @@ struct airoha_qdma {
> =20
>  	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> +
> +	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
>  };
> =20
>  struct airoha_gdm_dev {
> @@ -547,8 +549,6 @@ struct airoha_gdm_port {
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

commenting on sashiko report:
https://sashiko.dev/#/patchset/20260507-airoha-eth-multi-serdes-v4-0-af613b=
61ae02%40kernel.org

- Following up on the real_num_tx_queues logic above, does blindly decremen=
ting
  this by 1 dynamically shrink the queue range and instantly invalidate oth=
er
  active queues whose qid might now fall out of bounds?
  - This issue has not been introduced by this series and I will fix it wit=
h a
    separated patch

--dHDRJGPLDrB0Lpqz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf8xwQAKCRA6cBh0uS2t
rJdFAP4uuTScfjUpWbrBtp7/7/oQvyzht9ogH7+h+si7G95UhgEAx5Y05bUEo5tp
Gk8fZnS6hq3dyXyA6blQHy2/5uS2YgE=
=vwfA
-----END PGP SIGNATURE-----

--dHDRJGPLDrB0Lpqz--

