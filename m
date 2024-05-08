Return-Path: <netdev+bounces-94664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3168C01AB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3173EB22936
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84A128812;
	Wed,  8 May 2024 16:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA8663E
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184428; cv=none; b=JxZlDvctweqmGo3dej0EMofTXUfuSEtVf6dfvBYJkJh478t0QlLkguXA8sgfkD+VMc9MBWpcILTrQSDk+zzDnSszBwXHbc3ax6s97I2MIwR6Bnj2HYmQ8rd+gks/BMaf1GsxIabUUp9yHoCR0zX9J5Ob0cVdqh+MBAxsIssJC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184428; c=relaxed/simple;
	bh=zEKlJflpk4dbTFaBrSHL/7hVNhpiwGXDz5jAPIZET/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HSvpJU4GHQfTASv8ejfHCRgGxFbASQTskYTV+LmgzvqUhq5hgMx0oJxpXke2Fijy1OwkgT3V+ORMyv6NrT9um8UDwLnPi1xw9Xds+BgXxxhW8GGyG5pGp9yAyQwiFdDjUVXm+OyovsWvZciry+ymeMxqdpL09lytzkNfvRWaW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-CmsRY9WzM6ijhcAxOkEQog-1; Wed, 08 May 2024 12:06:58 -0400
X-MC-Unique: CmsRY9WzM6ijhcAxOkEQog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A49D80253B;
	Wed,  8 May 2024 16:06:58 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16E3128E2;
	Wed,  8 May 2024 16:06:56 +0000 (UTC)
Date: Wed, 8 May 2024 18:06:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <ZjujHw6eglLEIbxA@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-8-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:20 +0200, Antonio Quartulli wrote:
> An ovpn_peer object holds the whole status of a remote peer
> (regardless whether it is a server or a client).
>=20
> This includes status for crypto, tx/rx buffers, napi, etc.
>=20
> Only support for one peer is introduced (P2P mode).
> Multi peer support is introduced with a later patch.
>=20
> Along with the ovpn_peer, also the ovpn_bind object is introcued
                                                         ^
typo: "introduced"

> as the two are strictly related.
> An ovpn_bind object wraps a sockaddr representing the local
> coordinates being used to talk to a specific peer.

> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> new file mode 100644
> index 000000000000..c1f842c06e32
> --- /dev/null
> +++ b/drivers/net/ovpn/bind.c
> +static void ovpn_bind_release_rcu(struct rcu_head *head)
> +{
> +=09struct ovpn_bind *bind =3D container_of(head, struct ovpn_bind, rcu);
> +
> +=09kfree(bind);
> +}
> +
> +void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
> +{
> +=09struct ovpn_bind *old;
> +
> +=09spin_lock_bh(&peer->lock);
> +=09old =3D rcu_replace_pointer(peer->bind, new, true);
> +=09spin_unlock_bh(&peer->lock);
> +
> +=09if (old)
> +=09=09call_rcu(&old->rcu, ovpn_bind_release_rcu);

Isn't that just kfree_rcu? (note kfree_rcu doesn't need the NULL check)

> +}


> diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
> new file mode 100644
> index 000000000000..61433550a961
> --- /dev/null
> +++ b/drivers/net/ovpn/bind.h
[...]
> +static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
> +=09=09=09=09=09   struct sk_buff *skb)

nit: I think skb can also be const here


> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 338e99dfe886..a420bb45f25f 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -13,6 +13,7 @@
>  #include "io.h"
>  #include "ovpnstruct.h"
>  #include "netlink.h"
> +#include "peer.h"
> =20
>  int ovpn_struct_init(struct net_device *dev)
>  {
> @@ -25,6 +26,13 @@ int ovpn_struct_init(struct net_device *dev)
>  =09if (err < 0)
>  =09=09return err;
> =20
> +=09spin_lock_init(&ovpn->lock);
> +
> +=09ovpn->events_wq =3D alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLA=
IM,
> +=09=09=09=09=09  0, dev->name);

I'm not convinced this will get freed consistently if
register_netdevice fails early (before ndo_init).  After talking to
Paolo, it seems this should be moved into a new ->ndo_init instead.

> +=09if (!ovpn->events_wq)
> +=09=09return -ENOMEM;
> +
>  =09dev->tstats =3D netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
>  =09if (!dev->tstats)
>  =09=09return -ENOMEM;
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index cc8a97a1a189..dba35ecb236b 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -37,6 +39,9 @@ static void ovpn_struct_free(struct net_device *net)
>  =09rtnl_unlock();
> =20
>  =09free_percpu(net->tstats);
> +=09flush_workqueue(ovpn->events_wq);
> +=09destroy_workqueue(ovpn->events_wq);

Is the flush needed? I'm not an expert on workqueues, but from a quick
look at destroy_workqueue it calls drain_workqueue, which would take
care of flushing the queue?

> +=09rcu_barrier();
>  }
> =20

[...]
> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.=
h
> index ee05b8a2c61d..b79d4f0474b0 100644
> --- a/drivers/net/ovpn/ovpnstruct.h
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -17,12 +17,19 @@
>   * @dev: the actual netdev representing the tunnel
>   * @registered: whether dev is still registered with netdev or not
>   * @mode: device operation mode (i.e. p2p, mp, ..)
> + * @lock: protect this object
> + * @event_wq: used to schedule generic events that may sleep and that ne=
ed to be
> + *            performed outside of softirq context
> + * @peer: in P2P mode, this is the only remote peer
>   * @dev_list: entry for the module wide device list
>   */
>  struct ovpn_struct {
>  =09struct net_device *dev;
>  =09bool registered;
>  =09enum ovpn_mode mode;
> +=09spinlock_t lock; /* protect writing to the ovpn_struct object */

nit: the comment isn't really needed since you have kdoc saying the same th=
ing

> +=09struct workqueue_struct *events_wq;
> +=09struct ovpn_peer __rcu *peer;
>  =09struct list_head dev_list;
>  };
> =20
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> new file mode 100644
> index 000000000000..2948b7320d47
> --- /dev/null
> +++ b/drivers/net/ovpn/peer.c
[...]
> +/**
> + * ovpn_peer_free - release private members and free peer object
> + * @peer: the peer to free
> + */
> +static void ovpn_peer_free(struct ovpn_peer *peer)
> +{
> +=09ovpn_bind_reset(peer, NULL);
> +
> +=09WARN_ON(!__ptr_ring_empty(&peer->tx_ring));

Could you pass a destructor to ptr_ring_cleanup instead of all these WARNs?

> +=09ptr_ring_cleanup(&peer->tx_ring, NULL);
> +=09WARN_ON(!__ptr_ring_empty(&peer->rx_ring));
> +=09ptr_ring_cleanup(&peer->rx_ring, NULL);
> +=09WARN_ON(!__ptr_ring_empty(&peer->netif_rx_ring));
> +=09ptr_ring_cleanup(&peer->netif_rx_ring, NULL);
> +
> +=09dst_cache_destroy(&peer->dst_cache);
> +
> +=09dev_put(peer->ovpn->dev);
> +
> +=09kfree(peer);
> +}

[...]
> +void ovpn_peer_release(struct ovpn_peer *peer)
> +{
> +=09call_rcu(&peer->rcu, ovpn_peer_release_rcu);
> +}
> +
> +/**
> + * ovpn_peer_delete_work - work scheduled to release peer in process con=
text
> + * @work: the work object
> + */
> +static void ovpn_peer_delete_work(struct work_struct *work)
> +{
> +=09struct ovpn_peer *peer =3D container_of(work, struct ovpn_peer,
> +=09=09=09=09=09      delete_work);
> +=09ovpn_peer_release(peer);

Does call_rcu really need to run in process context?

> +}

[...]
> +/**
> + * ovpn_peer_transp_match - check if sockaddr and peer binding match
> + * @peer: the peer to get the binding from
> + * @ss: the sockaddr to match
> + *
> + * Return: true if sockaddr and binding match or false otherwise
> + */
> +static bool ovpn_peer_transp_match(struct ovpn_peer *peer,
> +=09=09=09=09   struct sockaddr_storage *ss)
> +{
[...]
> +=09case AF_INET6:
> +=09=09sa6 =3D (struct sockaddr_in6 *)ss;
> +=09=09if (memcmp(&sa6->sin6_addr, &bind->sa.in6.sin6_addr,
> +=09=09=09   sizeof(struct in6_addr)))

ipv6_addr_equal?

> +=09=09=09return false;
> +=09=09if (sa6->sin6_port !=3D bind->sa.in6.sin6_port)
> +=09=09=09return false;
> +=09=09break;

[...]
> +struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer=
_id)
> +{
> +=09struct ovpn_peer *peer =3D NULL;
> +
> +=09if (ovpn->mode =3D=3D OVPN_MODE_P2P)
> +=09=09peer =3D ovpn_peer_get_by_id_p2p(ovpn, peer_id);
> +
> +=09return peer;
> +}
> +
> +/**
> + * ovpn_peer_add_p2p - add per to related tables in a P2P instance
                              ^
typo: peer?


[...]
> +/**
> + * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
> + * @peer: the peer to delete
> + * @reason: reason why the peer was deleted (sent to userspace)
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> +=09=09=09     enum ovpn_del_peer_reason reason)
> +{
> +=09struct ovpn_peer *tmp;
> +=09int ret =3D -ENOENT;
> +
> +=09spin_lock_bh(&peer->ovpn->lock);
> +=09tmp =3D rcu_dereference(peer->ovpn->peer);
> +=09if (tmp !=3D peer)
> +=09=09goto unlock;

How do we recover if all those objects got out of sync? Are we stuck
with a broken peer?

And if this happens during interface deletion, aren't we leaking the
peer memory here?

> +=09ovpn_peer_put(tmp);
> +=09tmp->delete_reason =3D reason;
> +=09RCU_INIT_POINTER(peer->ovpn->peer, NULL);
> +=09ret =3D 0;
> +
> +unlock:
> +=09spin_unlock_bh(&peer->ovpn->lock);
> +
> +=09return ret;
> +}

[...]
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> new file mode 100644
> index 000000000000..659df320525c
> --- /dev/null
> +++ b/drivers/net/ovpn/peer.h
[...]
> +/**
> + * struct ovpn_peer - the main remote peer object
> + * @ovpn: main openvpn instance this peer belongs to
> + * @id: unique identifier
> + * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
> + * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
> + * @tx_ring: queue of outgoing poackets to this peer
> + * @rx_ring: queue of incoming packets from this peer
> + * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
> + * @dst_cache: cache for dst_entry used to send to peer
> + * @bind: remote peer binding
> + * @halt: true if ovpn_peer_mark_delete was called
> + * @delete_reason: why peer was deleted (i.e. timeout, transport error, =
..)
> + * @lock: protects binding to peer (bind)
> + * @refcount: reference counter
> + * @rcu: used to free peer in an RCU safe way
> + * @delete_work: deferred cleanup work, used to notify userspace
> + */
> +struct ovpn_peer {
> +=09struct ovpn_struct *ovpn;
> +=09u32 id;
> +=09struct {
> +=09=09struct in_addr ipv4;
> +=09=09struct in6_addr ipv6;
> +=09} vpn_addrs;
> +=09struct ptr_ring tx_ring;
> +=09struct ptr_ring rx_ring;
> +=09struct ptr_ring netif_rx_ring;
> +=09struct dst_cache dst_cache;
> +=09struct ovpn_bind __rcu *bind;
> +=09bool halt;
> +=09enum ovpn_del_peer_reason delete_reason;
> +=09spinlock_t lock; /* protects bind */

nit: the comment isn't really needed, it's redundant with kdoc.

> +=09struct kref refcount;
> +=09struct rcu_head rcu;
> +=09struct work_struct delete_work;
> +};

--=20
Sabrina


