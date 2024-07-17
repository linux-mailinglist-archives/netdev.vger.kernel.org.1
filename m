Return-Path: <netdev+bounces-111907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D0934144
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB581F221B8
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEE1E526;
	Wed, 17 Jul 2024 17:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E879D2
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236536; cv=none; b=DW5V33XokVrKr5NRnyPQAOjUSsiFOM9pWYfRSWD5SN7O68uPglGlrNM9xD8QGSRwH5ADrVl7nFIyUe6FLwbxcqYQl7pnWPwGx1foMDQ80dv0JcZCEz+N3XkcwHdLWahbrOTp5h65Ahox524diUMb1+JnT9/bFYE8GctITzysrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236536; c=relaxed/simple;
	bh=UZiN4wANs8UJk1RF8rYE1QYGJgBmg3XL3CDn34q3RLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Cf1vUxgUA4lDrzXwN4V1we3bEQMHLgd+8PpbVYBlAPoVpXjOs0TvzaDU126jY/yv4l5DFrrsQqUyy1IVTqXfj8/FBkdXhPBBpaCo21TrLjyn2auez9pfMFP1uej3aD/n7f68iLdLsIkwEz1fCuKv762MytL4GDuqATO7wWyZano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-LjMXfukSPByXa2UryfAkTg-1; Wed,
 17 Jul 2024 13:15:22 -0400
X-MC-Unique: LjMXfukSPByXa2UryfAkTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC4461955D60;
	Wed, 17 Jul 2024 17:15:20 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D46CA19560B2;
	Wed, 17 Jul 2024 17:15:17 +0000 (UTC)
Date: Wed, 17 Jul 2024 19:15:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 19/25] ovpn: add support for peer floating
Message-ID: <Zpf8I5HdJFgehunO@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-20-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-20-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:37 +0200, Antonio Quartulli wrote:
> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +=09struct sockaddr_storage ss;
> +=09const u8 *local_ip =3D NULL;
> +=09struct sockaddr_in6 *sa6;
> +=09struct sockaddr_in *sa;
> +=09struct ovpn_bind *bind;
> +=09sa_family_t family;
> +=09size_t salen;
> +
> +=09rcu_read_lock();
> +=09bind =3D rcu_dereference(peer->bind);
> +=09if (unlikely(!bind))
> +=09=09goto unlock;

Why are you aborting here? ovpn_bind_skb_src_match considers
bind=3D=3DNULL to be "no match" (reasonable), then we would create a new
bind for the current address.

> +
> +=09if (likely(ovpn_bind_skb_src_match(bind, skb)))

This could be running in parallel on two CPUs, because ->encap_rcv
isn't protected against that. So the bind could be getting updated in
parallel. I would move spin_lock_bh above this check to make sure it
doesn't happen.

ovpn_peer_update_local_endpoint would also need something like that, I
think.

> +=09=09goto unlock;
> +
> +=09family =3D skb_protocol_to_family(skb);
> +
> +=09if (bind->sa.in4.sin_family =3D=3D family)
> +=09=09local_ip =3D (u8 *)&bind->local;
> +
> +=09switch (family) {
> +=09case AF_INET:
> +=09=09sa =3D (struct sockaddr_in *)&ss;
> +=09=09sa->sin_family =3D AF_INET;
> +=09=09sa->sin_addr.s_addr =3D ip_hdr(skb)->saddr;
> +=09=09sa->sin_port =3D udp_hdr(skb)->source;
> +=09=09salen =3D sizeof(*sa);
> +=09=09break;
> +=09case AF_INET6:
> +=09=09sa6 =3D (struct sockaddr_in6 *)&ss;
> +=09=09sa6->sin6_family =3D AF_INET6;
> +=09=09sa6->sin6_addr =3D ipv6_hdr(skb)->saddr;
> +=09=09sa6->sin6_port =3D udp_hdr(skb)->source;
> +=09=09sa6->sin6_scope_id =3D ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
> +=09=09=09=09=09=09=09 skb->skb_iif);
> +=09=09salen =3D sizeof(*sa6);
> +=09=09break;
> +=09default:
> +=09=09goto unlock;
> +=09}
> +
> +=09netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__=
,
> +=09=09   peer->id, &ss);
> +=09ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
> +=09=09=09=09 local_ip);
> +
> +=09spin_lock_bh(&peer->ovpn->peers->lock);
> +=09/* remove old hashing */
> +=09hlist_del_init_rcu(&peer->hash_entry_transp_addr);
> +=09/* re-add with new transport address */
> +=09hlist_add_head_rcu(&peer->hash_entry_transp_addr,
> +=09=09=09   ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
> +=09=09=09=09=09      &ss, salen));

That could send a concurrent reader onto the wrong hash bucket, if
it's going through peer's old bucket, finds peer before the update,
then continues reading after peer is moved to the new bucket.

This kind of re-hash can be handled with nulls, and re-trying the
lookup if we ended up on the wrong chain. See for example
__inet_lookup_established in net/ipv4/inet_hashtables.c (Thanks to
Paolo for the pointer).

> +=09spin_unlock_bh(&peer->ovpn->peers->lock);
> +
> +unlock:
> +=09rcu_read_unlock();
> +}

--=20
Sabrina


