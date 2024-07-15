Return-Path: <netdev+bounces-111456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66349311E3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC68280F23
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E024187333;
	Mon, 15 Jul 2024 09:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA31186E5A
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037580; cv=none; b=I2YYsLcz2CacnM7Rh5zLcwyO1BPGPoAPBk6GaMnXYbQqO5YPvli6Q8JDrBlXkSAyYh4IihCbThCTlRt0smdTkiEZx5qdZ3oizWk9yiUFoj5ash49UoHsXkDklLSXlwKuK5Cuyo6pC1yPr2+xLmf/ZpKWk3phUN6HZ2Rjb9UiYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037580; c=relaxed/simple;
	bh=8PHTnGP9YJFHb0LKlPNtyGVyaSnq+2gL2AiNtobiHAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pDSwmGuMb61mI3vR+0irJFpvCwVAKoTlkT/9Ufkgx2t5dEZNB8qxcFcZgmzFfthh+yd/8Zz68QFx7iT2zhO3O/tzoUSFT3hP9mT4DorOnghuQs1uG0D60aBMbJYCO5JtbQ29TSOCrvNppLT5QEa8D3igfRDYASrYvvykYNhjo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-nshjpSUrO3WZDlfmoCcLLw-1; Mon,
 15 Jul 2024 05:59:22 -0400
X-MC-Unique: nshjpSUrO3WZDlfmoCcLLw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E04D61955D45;
	Mon, 15 Jul 2024 09:59:20 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA5FD300018D;
	Mon, 15 Jul 2024 09:59:17 +0000 (UTC)
Date: Mon, 15 Jul 2024 11:59:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 14/25] ovpn: implement TCP transport
Message-ID: <ZpTy860ss-JwT_2W@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-15-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-15-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:32 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 0475440642dd..764b3df996bc 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -21,6 +21,7 @@
>  #include "netlink.h"
>  #include "proto.h"
>  #include "socket.h"
> +#include "tcp.h"
>  #include "udp.h"
>  #include "skb.h"
> =20
> @@ -84,8 +85,11 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>  =09/* PID sits after the op */
>  =09pid =3D (__force __be32 *)(skb->data + OVPN_OP_SIZE_V2);
>  =09ret =3D ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
> -=09if (unlikely(ret < 0))
> +=09if (unlikely(ret < 0)) {
> +=09=09net_err_ratelimited("%s: PKT ID RX error: %d\n",
> +=09=09=09=09    peer->ovpn->dev->name, ret);

nit: this should be part of the "packet processing" patch?


> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index dd4d91dfabb5..86d4696b1529 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -10,8 +10,8 @@
>  #ifndef _NET_OVPN_OVPNPEER_H_
>  #define _NET_OVPN_OVPNPEER_H_
> =20
> -#include <linux/ptr_ring.h>

nit: I think you don't need it at all in this version and forgot to
drop it in a previous patch? (I didn't notice when it was introduced)



> +static int ovpn_tcp_to_userspace(struct ovpn_socket *sock, struct sk_buf=
f *skb)
> +{
> +=09struct sock *sk =3D sock->sock->sk;
> +
> +=09skb_set_owner_r(skb, sk);
> +=09memset(skb->cb, 0, sizeof(skb->cb));

nit: this was just done in ovpn_tcp_rcv

> +=09skb_queue_tail(&sock->peer->tcp.user_queue, skb);
> +=09sock->peer->tcp.sk_cb.sk_data_ready(sk);
> +
> +=09return 0;
> +}
> +
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
[...]
> +=09/* DATA_V2 packets are handled in kernel, the rest goes to user space=
 */
> +=09if (likely(ovpn_opcode_from_skb(skb, 0) =3D=3D OVPN_DATA_V2)) {
> +=09=09/* hold reference to peer as required by ovpn_recv().
> +=09=09 *
> +=09=09 * NOTE: in this context we should already be holding a
> +=09=09 * reference to this peer, therefore ovpn_peer_hold() is
> +=09=09 * not expected to fail
> +=09=09 */
> +=09=09WARN_ON(!ovpn_peer_hold(peer));

drop the packet if this fails? otherwise I suspect we'll crash later on.

> +=09=09ovpn_recv(peer, skb);
> +=09} else {
> +=09=09/* The packet size header must be there when sending the packet
> +=09=09 * to userspace, therefore we put it back
> +=09=09 */
> +=09=09skb_push(skb, 2);
> +=09=09memset(skb->cb, 0, sizeof(skb->cb));
> +=09=09if (ovpn_tcp_to_userspace(peer->sock, skb) < 0) {
> +=09=09=09net_warn_ratelimited("%s: cannot send skb to userspace\n",
> +=09=09=09=09=09     peer->ovpn->dev->name);
> +=09=09=09goto err;
> +=09=09}
> +=09}
[...]


> +void ovpn_tcp_socket_detach(struct socket *sock)
> +{
> +=09struct ovpn_socket *ovpn_sock;
> +=09struct ovpn_peer *peer;
> +
> +=09if (!sock)
> +=09=09return;
> +
> +=09rcu_read_lock();
> +=09ovpn_sock =3D rcu_dereference_sk_user_data(sock->sk);
> +
[...]
> +=09/* cancel any ongoing work. Done after removing the CBs so that these
> +=09 * workers cannot be re-armed
> +=09 */
> +=09cancel_work_sync(&peer->tcp.tx_work);

I don't think that's ok to call under rcu_read_lock, it seems it can
sleep.

> +=09strp_done(&peer->tcp.strp);

And same here, since strp_done also calls cancel_work_sync.

> +=09rcu_read_unlock();
> +}
> +
> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
> +{
> +=09struct sk_buff *skb =3D peer->tcp.out_msg.skb;
> +
> +=09if (!skb)
> +=09=09return;
> +
> +=09if (peer->tcp.tx_in_progress)
> +=09=09return;
> +
> +=09peer->tcp.tx_in_progress =3D true;

I'm not convinced this is safe. ovpn_tcp_send_sock could run
concurrently for the same peer (lock_sock doesn't exclude bh_lock_sock
after the short "grab ownership" phase), so I think both sides could
see tx_in_progress =3D false and then proceed.


> +=09do {
> +=09=09int ret =3D skb_send_sock_locked(peer->sock->sock->sk, skb,
> +=09=09=09=09=09       peer->tcp.out_msg.offset,
> +=09=09=09=09=09       peer->tcp.out_msg.len);
> +=09=09if (unlikely(ret < 0)) {
> +=09=09=09if (ret =3D=3D -EAGAIN)
> +=09=09=09=09goto out;

This will silently drop the message? And then in case of a userspace
message, ovpn_tcp_sendmsg will lie to the user (the openvpn client),
claiming that the control message was sent (ret =3D size just above the
unlock)?

> +
> +=09=09=09net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
> +=09=09=09=09=09     peer->ovpn->dev->name, peer->id,
> +=09=09=09=09=09     ret);
> +
> +=09=09=09/* in case of TCP error we can't recover the VPN
> +=09=09=09 * stream therefore we abort the connection
> +=09=09=09 */
> +=09=09=09ovpn_peer_del(peer,
> +=09=09=09=09      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09peer->tcp.out_msg.len -=3D ret;
> +=09=09peer->tcp.out_msg.offset +=3D ret;
> +=09} while (peer->tcp.out_msg.len > 0);

Another thing that worries me: assume the receiver is a bit slow, the
underlying TCP socket gets stuck. skb_send_sock_locked manages to push
some data down the TCP socket, but not everything. We advance by that
amount, and restart this loop. The socket is still stuck, so
skb_send_sock_locked returns -EAGAIN. We have only pushed a partial
message down to the TCP socket, but we drop the rest? Now the stream
is broken, and the next call to ovpn_tcp_send_sock will happily send
its message.

ovpn_tcp_send_sock with msg_len =3D 1000
iteration 1
  skb_send_sock_locked returns 100
  advance
iteration 2
  skb_send_sock_locked returns -EAGAIN
  goto out


So you'd have to keep that partially-sent message around until you can
finish pushing it out on the socket.


[...]
> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t =
size)
> +{
> +=09struct ovpn_socket *sock;
> +=09int ret, linear =3D PAGE_SIZE;
> +=09struct ovpn_peer *peer;
> +=09struct sk_buff *skb;
> +
> +=09rcu_read_lock();
> +=09sock =3D rcu_dereference_sk_user_data(sk);
> +=09peer =3D sock->peer;
> +=09rcu_read_unlock();

What's stopping the peer being freed here?

--=20
Sabrina


