Return-Path: <netdev+bounces-285159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHXsEJg3/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF94E3CA1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A422300E701
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2534678C;
	Thu,  7 May 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="iJnVQPgO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD752F12DA;
	Thu,  7 May 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778136871; cv=none; b=Fcmx56ljmwJ+2DG/U8zVgLqoa8I3CW3nlsKIBEQZ5Eh1nK98ardalHcLFEChUVkxUMqLUzE5ouQa/d4UddA9KXjPGs+pHcEJSlcs7DI6IRvNo6ViEEGcs+d1cuNhlXJxuP6Sg24xT0eixOVLB2WkgKq4JBNzx0FyYx1hne9xn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778136871; c=relaxed/simple;
	bh=8SAmx8Ok1JK3fepgR6uqWCUWeULEgKNuV0+B6q85Fj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUAQ48A/grOWKyST4pnolyjdAJ94XvfiLUkN+FMya9ngS6zGoyxcboCe6zy1cqnTMZkTMC5lHbwfgEuUarKpE8HAzqYy96oSETYHmbAYGXP+Brdq5N0/J6/v5i7nSDeTMMe8Phuq2xXnbxpqQp68AJSnPV8CXO7kOCcNj0icAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=iJnVQPgO; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778136860; x=1778741660; i=simon@schippers-hamm.de;
	bh=0s0anbYrKCWTkGQXUN0hZBGeLkkRLnTSX3TgI/yhcOQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iJnVQPgOqVgBmY1TqYIQPJ7Qz7pSX2b+qV7vzJaL8oE9j2opwz8e8BTC91H7zwb0
	 6r3aLpRlbiGMZGODWfSV2B2jKvCOh+7kAN+UxSAQ4F3RBkRpS/yhvZKH98dd0LHfF
	 liEOt6OFsE91fuqYjt8I7gtRTxx8kubj8od5gQwnTcwlleyup+TVV59mGAH/XoHNh
	 e/Ee9eSe6Sxuoxdm2KK5sAob4EoovZ9Oyb/N7+GmyxMxpLMCAXiFU3alioZHhFlAU
	 +zAKEom8eVsv7WL9DSTEYvLReURnvnxJO4TWvgOT+qDiksCwo4PUo1bHKcOdle/ia
	 WR3TJAZa7JMhCXcIYQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1MJn4B-1w1QtZ2xtR-00MMe9; Thu, 07
 May 2026 08:54:20 +0200
Message-ID: <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Date: Thu, 7 May 2026 08:54:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <20260505132159.241305-4-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xLLwt4XY0mBO0B//rPm46MMNitIhIIuGJyuK0d+Zp3/COd9D3Yq
 NsBVD6qoAjX3cSbdQIl74TEWkl7khC4qfI3/A1sY/9pUPJXCrNetbNNm3Ipd9xxE0OxW8PL
 PVy18dwRVll2/hls2fcJiKzEU9X4yCrPGqalZKFNqElUd8iuqyDcY+Qv5bEl8eomGuh3sLu
 0h56njnwzcE0har0sI9NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+GwmJoW9sDc=;QLbKVJXyZlf0ZOP4Y51en+Ojso5
 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
 WDP4j21AFHuNykPlkCSqvLQfhKZwgFaR
X-Rspamd-Queue-Id: 96FF94E3CA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon@schippers-hamm.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schippers-hamm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 15:21, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
>=20
> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") gave qdiscs control over veth by returning
> NETDEV_TX_BUSY when the ptr_ring is full (DRV_XOFF).  That commit noted
> a known limitation: the 256-entry ptr_ring sits in front of the qdisc as
> a dark buffer, adding base latency because the qdisc has no visibility
> into how many bytes are already queued there.
>=20
> Add BQL support so the qdisc gets feedback and can begin shaping traffic
> before the ring fills.  In testing with fq_codel, BQL reduces ping RTT
> under UDP load from ~6.61ms to ~0.36ms (18x).
>=20
> Charge a fixed VETH_BQL_UNIT (1) per packet rather than skb->len, so
> the DQL limit tracks packets-in-flight.  Unlike a physical NIC, veth
> has no link speed -- the ptr_ring drains at CPU speed and is
> packet-indexed, not byte-indexed, so bytes are not the natural unit.
> With byte-based charging, small packets sneak many more entries into
> the ring before STACK_XOFF fires, deepening the dark buffer under
> mixed-size workloads.  Testing with a concurrent min-size packet flood
> shows 3.7x ping RTT degradation with skb->len charging versus no
> change with fixed-unit charging.
>=20
> Charge BQL inside veth_xdp_rx() under the ptr_ring producer_lock, after
> confirming the ring is not full.  The charge must precede the produce
> because the NAPI consumer can run on another CPU and complete the SKB
> the instant it becomes visible in the ring.  Doing both under the same
> lock avoids a pre-charge/undo pattern -- BQL is only charged when
> produce is guaranteed to succeed.
>=20
> BQL is enabled only when a real qdisc is attached (guarded by
> !qdisc_txq_has_no_queue), as HARD_TX_LOCK provides serialization
> for TXQ modification like dql_queued(). For lltx devices, like veth,
> this HARD_TX_LOCK serialization isn't provided.  The ptr_ring
> producer_lock provides additional serialization that would allow
> BQL to work correctly even with noqueue, though that combination
> is not currently enabled, as the netstack will drop and warn.
>=20
> Track per-SKB BQL state via a VETH_BQL_FLAG pointer tag in the ptr_ring
> entry.  This is necessary because the qdisc can be replaced live while
> SKBs are in-flight -- each SKB must carry the charge decision made at
> enqueue time rather than re-checking the peer's qdisc at completion.
>=20
> Complete per-SKB in veth_xdp_rcv() rather than in bulk, so STACK_XOFF
> clears promptly when producer and consumer run on different CPUs.
>=20
> BQL introduces a second independent queue-stop mechanism (STACK_XOFF)
> alongside the existing DRV_XOFF (ring full).  Both must be clear for
> the queue to transmit.  Reset BQL state in veth_napi_del_range() after
> synchronize_net() to avoid racing with in-flight veth_poll() calls.
> Clamp the reset loop to the peer's real_num_tx_queues, since the peer
> may have fewer TX queues than the local device has RX queues (e.g. when
> veth is enslaved to a bond with XDP attached).
>=20
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c | 86 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 75 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0cfb19b760dd..86b78900c48e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -34,9 +34,13 @@
>  #define DRV_VERSION	"1.0"
> =20
>  #define VETH_XDP_FLAG		BIT(0)
> +#define VETH_BQL_FLAG		BIT(1)
>  #define VETH_RING_SIZE		256
>  #define VETH_XDP_HEADROOM	(XDP_PACKET_HEADROOM + NET_IP_ALIGN)
> =20
> +/* Fixed BQL charge: DQL limit tracks packets-in-flight, not bytes */
> +#define VETH_BQL_UNIT		1
> +
>  #define VETH_XDP_TX_BULK_SIZE	16
>  #define VETH_XDP_BATCH		16
> =20
> @@ -280,6 +284,21 @@ static bool veth_is_xdp_frame(void *ptr)
>  	return (unsigned long)ptr & VETH_XDP_FLAG;
>  }
> =20
> +static bool veth_ptr_is_bql(void *ptr)
> +{
> +	return (unsigned long)ptr & VETH_BQL_FLAG;
> +}
> +
> +static struct sk_buff *veth_ptr_to_skb(void *ptr)
> +{
> +	return (void *)((unsigned long)ptr & ~VETH_BQL_FLAG);
> +}
> +
> +static void *veth_skb_to_ptr(struct sk_buff *skb, bool bql)
> +{
> +	return bql ? (void *)((unsigned long)skb | VETH_BQL_FLAG) : skb;
> +}
> +
>  static struct xdp_frame *veth_ptr_to_xdp(void *ptr)
>  {
>  	return (void *)((unsigned long)ptr & ~VETH_XDP_FLAG);
> @@ -295,7 +314,7 @@ static void veth_ptr_free(void *ptr)
>  	if (veth_is_xdp_frame(ptr))
>  		xdp_return_frame(veth_ptr_to_xdp(ptr));
>  	else
> -		kfree_skb(ptr);
> +		kfree_skb(veth_ptr_to_skb(ptr));
>  }
> =20
>  static void __veth_xdp_flush(struct veth_rq *rq)
> @@ -309,19 +328,33 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>  	}
>  }
> =20
> -static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
> +static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb, bool do=
_bql,
> +		       struct netdev_queue *txq)
>  {
> -	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
> +	struct ptr_ring *ring =3D &rq->xdp_ring;
> +
> +	spin_lock(&ring->producer_lock);
> +	if (unlikely(!ring->size) || __ptr_ring_full(ring)) {
> +		spin_unlock(&ring->producer_lock);
>  		return NETDEV_TX_BUSY; /* signal qdisc layer */
> +	}
> +
> +	/* BQL charge before produce; consumer cannot see entry yet */
> +	if (do_bql)
> +		netdev_tx_sent_queue(txq, VETH_BQL_UNIT);
> +
> +	__ptr_ring_produce(ring, veth_skb_to_ptr(skb, do_bql));
> +	spin_unlock(&ring->producer_lock);
> =20
>  	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>  }
> =20
>  static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb=
,
> -			    struct veth_rq *rq, bool xdp)
> +			    struct veth_rq *rq, bool xdp, bool do_bql,
> +			    struct netdev_queue *txq)
>  {
>  	return __dev_forward_skb(dev, skb) ?: xdp ?
> -		veth_xdp_rx(rq, skb) :
> +		veth_xdp_rx(rq, skb, do_bql, txq) :
>  		__netif_rx(skb);
>  }
> =20
> @@ -348,10 +381,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, =
struct net_device *dev)
>  {
>  	struct veth_priv *rcv_priv, *priv =3D netdev_priv(dev);
>  	struct veth_rq *rq =3D NULL;
> -	struct netdev_queue *txq;
> +	struct netdev_queue *txq =3D NULL;
>  	struct net_device *rcv;
>  	int length =3D skb->len;
>  	bool use_napi =3D false;
> +	bool do_bql =3D false;
>  	int ret, rxq;
> =20
>  	rcu_read_lock();
> @@ -375,8 +409,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, s=
truct net_device *dev)
>  	}
> =20
>  	skb_tx_timestamp(skb);
> -
> -	ret =3D veth_forward_skb(rcv, skb, rq, use_napi);
> +	if (rxq < dev->real_num_tx_queues) {
> +		txq =3D netdev_get_tx_queue(dev, rxq);
> +		/* BQL charge happens inside veth_xdp_rx() under producer_lock */
> +		do_bql =3D use_napi && !qdisc_txq_has_no_queue(txq);
> +	}
> +	ret =3D veth_forward_skb(rcv, skb, rq, use_napi, do_bql, txq);
>  	switch (ret) {
>  	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>  		if (!use_napi)
> @@ -412,6 +450,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
>  		net_crit_ratelimited("%s(%s): Invalid return code(%d)",
>  				     __func__, dev->name, ret);
>  	}
> +
>  	rcu_read_unlock();
> =20
>  	return ret;
> @@ -900,7 +939,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_=
rq *rq,
> =20
>  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
> -			struct veth_stats *stats)
> +			struct veth_stats *stats,
> +			struct netdev_queue *peer_txq)
>  {
>  	int i, done =3D 0, n_xdpf =3D 0;
>  	void *xdpf[VETH_XDP_BATCH];
> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int bud=
get,
>  			}
>  		} else {
>  			/* ndo_start_xmit */
> -			struct sk_buff *skb =3D ptr;
> +			bool bql_charged =3D veth_ptr_is_bql(ptr);
> +			struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
> =20
>  			stats->xdp_bytes +=3D skb->len;
> +			if (peer_txq && bql_charged)
> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);

In the discussion with Jonas [1], I left a comment explaining why I think
this doesn=E2=80=99t work.

I still think first that adding an option to modify the hard-coded
VETH_RING_SIZE is the way to go.

Thanks!

[1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b6292=
0df@tu-dortmund.de/

> +
>  			skb =3D veth_xdp_rcv_skb(rq, skb, bq, stats);
>  			if (skb) {
>  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
> @@ -976,7 +1020,7 @@ static int veth_poll(struct napi_struct *napi, int =
budget)
>  		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> =20
>  	xdp_set_return_frame_no_direct();
> -	done =3D veth_xdp_rcv(rq, budget, &bq, &stats);
> +	done =3D veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
> =20
>  	if (stats.xdp_redirect > 0)
>  		xdp_do_flush();
> @@ -1074,6 +1118,7 @@ static int __veth_napi_enable(struct net_device *d=
ev)
>  static void veth_napi_del_range(struct net_device *dev, int start, int =
end)
>  {
>  	struct veth_priv *priv =3D netdev_priv(dev);
> +	struct net_device *peer;
>  	int i;
> =20
>  	for (i =3D start; i < end; i++) {
> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device=
 *dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
> =20
> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
> +	 * synchronize_net(), and NAPI can no longer clear it.
> +	 * Only wake when the device is still up.
> +	 */
> +	peer =3D rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end =3D min_t(int, end, peer->real_num_tx_queues);
> +
> +		for (i =3D start; i < peer_end; i++) {
> +			struct netdev_queue *txq =3D netdev_get_tx_queue(peer, i);
> +
> +			netdev_tx_reset_queue(txq);
> +			if (netif_running(dev))
> +				netif_tx_wake_queue(txq);
> +		}
> +	}
> +
>  	for (i =3D start; i < end; i++) {
>  		page_pool_destroy(priv->rq[i].page_pool);
>  		priv->rq[i].page_pool =3D NULL;
> @@ -1741,6 +1804,7 @@ static void veth_setup(struct net_device *dev)
>  	dev->priv_flags |=3D IFF_PHONY_HEADROOM;
>  	dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
>  	dev->lltx =3D true;
> +	dev->bql =3D true;
> =20
>  	dev->netdev_ops =3D &veth_netdev_ops;
>  	dev->xdp_metadata_ops =3D &veth_xdp_metadata_ops;

