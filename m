Return-Path: <netdev+bounces-109043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5C926A68
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC01C21571
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8B191F80;
	Wed,  3 Jul 2024 21:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17F191F64
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042674; cv=none; b=H0jjIqONa99WcMj4YQhkNKeTgWzvD9XHC8IKq1GGL+tWfHYVmOZlZ9QID0fYg7q6wkgrmjYbEFG8ZCg8gEZt7vGVN+312i7MPN1tgwQ3LS0PxhOJb7V4qa1h+RAZo2HueXJZY6VjHY2mJVkM3LKSXm5di/2NvdBPDNa/cVjZB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042674; c=relaxed/simple;
	bh=yxxyNSw8MvkdbjuWPn09iAiN4C6eaimDpKswbX7243o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rWaUeofDxsu8BxhysFhBkAXDfxKh7ixIgmySSEQ8blU9B5j0rSveRKsjw/hO1SUrQY+PVQL8TmRqjxowGbBThSL6Yp6IBJJeSkBxxJ/lwgm2S9yg54a7WNMbv2xrblsoLunmemKtxUYibSPKsgfyjeXD9GzjlR7CPi8By3VtlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-aHy0r1bTPS-qexqoYqvilg-1; Wed,
 03 Jul 2024 17:37:45 -0400
X-MC-Unique: aHy0r1bTPS-qexqoYqvilg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35BC11955E74;
	Wed,  3 Jul 2024 21:37:44 +0000 (UTC)
Received: from hog (unknown [10.39.192.70])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 732BB1955F21;
	Wed,  3 Jul 2024 21:37:41 +0000 (UTC)
Date: Wed, 3 Jul 2024 23:37:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 08/25] ovpn: introduce the ovpn_peer object
Message-ID: <ZoXEosCwp6-WR7wb@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-9-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-9-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:26 +0200, Antonio Quartulli wrote:
> +/**
> + * struct ovpn_sockaddr - basic transport layer address
> + * @in4: IPv4 address
> + * @in6: IPv6 address
> + */
> +struct ovpn_sockaddr {
> +=09union {
> +=09=09struct sockaddr_in in4;
> +=09=09struct sockaddr_in6 in6;
> +=09};
> +};

nit: wrapping the anonymous union in a struct that contains nothing
else is not that useful.


> +/**
> + * struct ovpn_bind - remote peer binding
> + * @sa: the remote peer sockaddress
> + * @local: local endpoint used to talk to the peer
> + * @local.ipv4: local IPv4 used to talk to the peer
> + * @local.ipv6: local IPv6 used to talk to the peer
> + * @rcu: used to schedule RCU cleanup job
> + */
> +struct ovpn_bind {
> +=09struct ovpn_sockaddr sa;  /* remote sockaddr */

nit: then maybe call it "peer" or "remote" instead of sa?

> +=09union {
> +=09=09struct in_addr ipv4;
> +=09=09struct in6_addr ipv6;
> +=09} local;
> +
> +=09struct rcu_head rcu;
> +};
> +

[...]
> +struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
> +{
> +=09struct ovpn_peer *peer;
> +=09int ret;
> +
> +=09/* alloc and init peer object */
> +=09peer =3D kzalloc(sizeof(*peer), GFP_KERNEL);
> +=09if (!peer)
> +=09=09return ERR_PTR(-ENOMEM);
> +
> +=09peer->id =3D id;
> +=09peer->halt =3D false;
> +=09peer->ovpn =3D ovpn;
> +
> +=09peer->vpn_addrs.ipv4.s_addr =3D htonl(INADDR_ANY);
> +=09peer->vpn_addrs.ipv6 =3D in6addr_any;
> +
> +=09RCU_INIT_POINTER(peer->bind, NULL);
> +=09spin_lock_init(&peer->lock);
> +=09kref_init(&peer->refcount);
> +
> +=09ret =3D dst_cache_init(&peer->dst_cache, GFP_KERNEL);
> +=09if (ret < 0) {
> +=09=09netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
> +=09=09=09   __func__);
> +=09=09kfree(peer);
> +=09=09return ERR_PTR(ret);
> +=09}
> +
> +=09netdev_hold(ovpn->dev, NULL, GFP_KERNEL);

It would be good to add a tracker to help debug refcount issues.


> +
> +=09return peer;
> +}
> +
> +#define ovpn_peer_index(_tbl, _key, _key_len)=09=09\
> +=09(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))=09\

nit: not used in this patch, and even removed by patch 16 as you
convert from index to buckets (that conversion should be squashed into
patch 15)

> +/**
> + * ovpn_peer_transp_match - check if sockaddr and peer binding match
> + * @peer: the peer to get the binding from
> + * @ss: the sockaddr to match
> + *
> + * Return: true if sockaddr and binding match or false otherwise
> + */
> +static bool ovpn_peer_transp_match(const struct ovpn_peer *peer,
> +=09=09=09=09   const struct sockaddr_storage *ss)
> +{

AFAICT ovpn_peer_transp_match is only called with ss from
ovpn_peer_skb_to_sockaddr, so it's pretty much ovpn_bind_skb_src_match
but using peer->bind. You can probably avoid the code duplication
(ovpn_peer_transp_match and ovpn_bind_skb_src_match are very similar).

--=20
Sabrina


