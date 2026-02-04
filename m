Return-Path: <netdev+bounces-256678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JFbKZcsg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:25:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4EE50B5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CB443008447
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2123E9F86;
	Wed,  4 Feb 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y27eDy8H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LK4vcQGk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07313E9F7A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204296; cv=none; b=cHZw7OkTsR5jTy7WbSZokIjhzdfqDe7c3Z1GlMTyoXN0DGi4EHNlpdhzN7Q92bE36PpDRE2RXNCkqs8VCU3pdNuwCYZ0aG9NVDOjW1vFN3vLBXRurNi8LoVS31qi4WqZ/RECVE3zMKZKK5y+n+qFTsD+fXtL21azLaRXfLeDANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204296; c=relaxed/simple;
	bh=94r3l1/v6dS6EVGjIjDz1ATmJ/ZjBDtSATnkH9RYJTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG28SF3ZOz/eGna4/09YfFoxhlsswhJl32vNBtl2pv9V4hpDrSzl6/L+MHVj8ypiujwK+RxsDJS61M2ebDI3lGNNZjtQdh6hB8MdrIKquiMTwcMM8uo40pRgASmno53LIWtJRNQWV00Zqoivqn4DYXJoJOU8Uky0MIe4os83gSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y27eDy8H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LK4vcQGk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770204294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svaP8lXGqW5UNMNny9CvOoSkLNVzhbDdKSmMOKzvBbE=;
	b=Y27eDy8HzaNV5yn8UrosSpYysku+mwMeeBBO+hSBOQpgL0G+7YVV/WIxwKTS+JpyfKXj3K
	1S66fK6S664xA147OuxqbUIEkQLYBjP7fmotdZ7n1V3n8ReaBY0pwVNf4/dJpM2tmyqH8u
	IJB3gzOf9vycK25+7DVyRway/H2LVdW9ziJi+a0GvyuqLLQDoYJ+dM/sxxoxRo7/CKrzjb
	qz+G94aRFfLlqnemOz/ai6dtSNrfcTaiZJKto3lhxDEKXtjesM2loyUZnnG2VDNRdR22st
	uZx8Vc8mpLcez5DrbZLTrCMOUrKTaQ0WQhrh+uBFSwrPwV5GPNr19JFMeRWQzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770204294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svaP8lXGqW5UNMNny9CvOoSkLNVzhbDdKSmMOKzvBbE=;
	b=LK4vcQGkMIQ5OOX4sDiZWAq2xzYoW+J3aiEycU3zxHtqdJjXSQU5FwyUyjmtow4598S25g
	t9imiEQ3b+0hPPAA==
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC net-next 2/2] af_packet: Add port specific handling for HSR
Date: Wed,  4 Feb 2026 12:24:04 +0100
Message-ID: <20260204-hsr_ptp-v1-2-b421c69a77da@linutronix.de>
In-Reply-To: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-256678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: CAF4EE50B5
X-Rspamd-Action: no action

linuxptp/ ptp4l uses a AF_PACKET with a RAW socket to send and receive
PTP packets. Extend the interface with the ability to bind the socket to
one of the two HSR ports and add a flag for sendmsg() to indicate that
the packet already contains a HSR header.

Once PACKET_HSR_BIND_PORT is set, the socket will be bound to requested
slave port. All incoming packets without a set port will be discarded.
This limits receiving packet to PTP only packets. The packet will be
forwarded to userland with the HSR header.

For control messages used by sendmsg(), PACKET_HSR_INFO is added with
PACKET_HSR_INFO_HAS_HDR as the only option. This option sets
HSR_SKB_INCLUDES_HEADER on the outgoing skb to indicate that the packet
already contains a HSR header. This requires that the socket is bound to
a specific HSR port so that the packet is sent only on one of the two
ports.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/uapi/linux/if_packet.h |   9 ++++
 net/packet/af_packet.c         | 103 +++++++++++++++++++++++++++++++++++++=
++++
 net/packet/internal.h          |   1 +
 3 files changed, 113 insertions(+)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 6cd1d7a41dfb7..3443eeac8470e 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -60,6 +60,7 @@ struct sockaddr_ll {
 #define PACKET_FANOUT_DATA		22
 #define PACKET_IGNORE_OUTGOING		23
 #define PACKET_VNET_HDR_SZ		24
+#define PACKET_HSR_BIND_PORT		25
=20
 #define PACKET_FANOUT_HASH		0
 #define PACKET_FANOUT_LB		1
@@ -74,6 +75,14 @@ struct sockaddr_ll {
 #define PACKET_FANOUT_FLAG_IGNORE_OUTGOING     0x4000
 #define PACKET_FANOUT_FLAG_DEFRAG	0x8000
=20
+/* For HSR, bind port */
+#define PACKET_HSR_BIND_PORT_AB		0
+#define PACKET_HSR_BIND_PORT_A		1
+#define PACKET_HSR_BIND_PORT_B		2
+/* HSR, CMSG */
+#define PACKET_HSR_INFO			1
+#define PACKET_HSR_INFO_HAS_HDR		1
+
 struct tpacket_stats {
 	unsigned int	tp_packets;
 	unsigned int	tp_drops;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 494d628d10a51..cd7c4ad034bc5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -82,6 +82,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <linux/virtio_net.h>
 #include <linux/errqueue.h>
@@ -1938,6 +1939,36 @@ static void packet_parse_headers(struct sk_buff *skb=
, struct socket *sock)
 	skb_probe_transport_header(skb);
 }
=20
+static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
+			    unsigned int *hsr_setting)
+{
+	struct cmsghdr *cmsg;
+	int ret =3D -EINVAL;
+	u32 val;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			goto out;
+		if (cmsg->cmsg_level !=3D SOL_PACKET)
+			continue;
+		if (cmsg->cmsg_type !=3D PACKET_HSR_INFO)
+			continue;
+		if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
+			goto out;
+
+		val =3D *(u32 *)CMSG_DATA(cmsg);
+		if (val !=3D PACKET_HSR_INFO_HAS_HDR)
+			goto out;
+		if (!po->hsr_bound_port)
+			goto out;
+
+		*hsr_setting =3D HSR_SKB_INCLUDES_HEADER;
+	}
+	ret =3D 0;
+out:
+	return ret;
+}
+
 /*
  *	Output a raw packet to a device layer. This bypasses all the other
  *	protocol layers and you must therefore supply it with a complete frame
@@ -1947,6 +1978,7 @@ static int packet_sendmsg_spkt(struct socket *sock, s=
truct msghdr *msg,
 			       size_t len)
 {
 	struct sock *sk =3D sock->sk;
+	struct packet_sock *po =3D pkt_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_pkt *, saddr, msg->msg_name);
 	struct sk_buff *skb =3D NULL;
 	struct net_device *dev;
@@ -1954,6 +1986,7 @@ static int packet_sendmsg_spkt(struct socket *sock, s=
truct msghdr *msg,
 	__be16 proto =3D 0;
 	int err;
 	int extra_len =3D 0;
+	u32 hsr_setting =3D 0;
=20
 	/*
 	 *	Get and verify the address.
@@ -2044,6 +2077,9 @@ static int packet_sendmsg_spkt(struct socket *sock, s=
truct msghdr *msg,
 		err =3D sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto out_unlock;
+		err =3D packet_cmsg_send(msg, po, &hsr_setting);
+		if (unlikely(err))
+			goto out_unlock;
 	}
=20
 	skb->protocol =3D proto;
@@ -2052,6 +2088,7 @@ static int packet_sendmsg_spkt(struct socket *sock, s=
truct msghdr *msg,
 	skb->mark =3D sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid=
);
 	skb_setup_tx_timestamp(skb, &sockc);
+	skb_shinfo(skb)->hsr_ptp =3D hsr_setting | po->hsr_bound_port;
=20
 	if (unlikely(extra_len =3D=3D 4))
 		skb->no_fcs =3D 1;
@@ -2131,6 +2168,13 @@ static int packet_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		goto drop;
=20
+	if (po->hsr_bound_port) {
+		struct skb_shared_info *si =3D skb_shinfo(skb);
+
+		if (po->hsr_bound_port !=3D si->hsr_ptp)
+			goto drop;
+	}
+
 	skb->dev =3D dev;
=20
 	if (dev_has_header(dev)) {
@@ -2260,6 +2304,13 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		goto drop;
=20
+	if (po->hsr_bound_port) {
+		struct skb_shared_info *si =3D skb_shinfo(skb);
+
+		if (po->hsr_bound_port !=3D si->hsr_ptp)
+			goto drop;
+	}
+
 	if (dev_has_header(dev)) {
 		if (sk->sk_type !=3D SOCK_DGRAM)
 			skb_push(skb, skb->data - skb_mac_header(skb));
@@ -2731,6 +2782,7 @@ static int tpacket_snd(struct packet_sock *po, struct=
 msghdr *msg)
 	int len_sum =3D 0;
 	int status =3D TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen =3D 0;
+	u32 hsr_setting =3D 0;
 	long timeo;
=20
 	mutex_lock(&po->pg_vec_lock);
@@ -2775,6 +2827,10 @@ static int tpacket_snd(struct packet_sock *po, struc=
t msghdr *msg)
 		err =3D sock_cmsg_send(&po->sk, msg, &sockc);
 		if (unlikely(err))
 			goto out_put;
+
+		err =3D packet_cmsg_send(msg, po, &hsr_setting);
+		if (unlikely(err))
+			goto out_put;
 	}
=20
 	if (po->sk.sk_socket->type =3D=3D SOCK_RAW)
@@ -2863,6 +2919,7 @@ static int tpacket_snd(struct packet_sock *po, struct=
 msghdr *msg)
 				goto out_status;
 			}
 		}
+		skb_shinfo(skb)->hsr_ptp =3D hsr_setting | po->hsr_bound_port;
=20
 		if (vnet_hdr_sz) {
 			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
@@ -2952,6 +3009,7 @@ static int packet_snd(struct socket *sock, struct msg=
hdr *msg, size_t len)
 	int vnet_hdr_sz =3D READ_ONCE(po->vnet_hdr_sz);
 	int hlen, tlen, linear;
 	int extra_len =3D 0;
+	u32 hsr_setting =3D 0;
=20
 	/*
 	 *	Get and verify the address.
@@ -2988,6 +3046,10 @@ static int packet_snd(struct socket *sock, struct ms=
ghdr *msg, size_t len)
 		err =3D sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto out_unlock;
+
+		err =3D packet_cmsg_send(msg, po, &hsr_setting);
+		if (unlikely(err))
+			goto out_unlock;
 	}
=20
 	if (sock->type =3D=3D SOCK_RAW)
@@ -3047,6 +3109,7 @@ static int packet_snd(struct socket *sock, struct msg=
hdr *msg, size_t len)
 	}
=20
 	skb_setup_tx_timestamp(skb, &sockc);
+	skb_shinfo(skb)->hsr_ptp =3D hsr_setting | po->hsr_bound_port;
=20
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
@@ -4044,6 +4107,31 @@ packet_setsockopt(struct socket *sock, int level, in=
t optname, sockptr_t optval,
 		packet_sock_flag_set(po, PACKET_SOCK_QDISC_BYPASS, val);
 		return 0;
 	}
+	case PACKET_HSR_BIND_PORT:
+	{
+		int val;
+
+		if (optlen !=3D sizeof(val))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
+			return -EFAULT;
+
+		switch (val) {
+		case 0:
+			po->hsr_bound_port =3D 0;
+			break;
+		case PACKET_HSR_BIND_PORT_A:
+			po->hsr_bound_port =3D HSR_PT_SLAVE_A;
+			break;
+		case PACKET_HSR_BIND_PORT_B:
+			po->hsr_bound_port =3D HSR_PT_SLAVE_B;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -4164,6 +4252,21 @@ static int packet_getsockopt(struct socket *sock, in=
t level, int optname,
 	case PACKET_QDISC_BYPASS:
 		val =3D packet_sock_flag(po, PACKET_SOCK_QDISC_BYPASS);
 		break;
+	case PACKET_HSR_BIND_PORT:
+		switch (po->hsr_bound_port) {
+		case 0:
+			val =3D 0;
+			break;
+		case HSR_PT_SLAVE_A:
+			val =3D PACKET_HSR_BIND_PORT_A;
+			break;
+		case HSR_PT_SLAVE_B:
+			val =3D PACKET_HSR_BIND_PORT_B;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/packet/internal.h b/net/packet/internal.h
index b76e645cd78d1..24d63275d432f 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -114,6 +114,7 @@ struct packet_sock {
 	unsigned long		flags;
 	int			ifindex;	/* bound device		*/
 	u8			vnet_hdr_sz;
+	u8			hsr_bound_port;
 	__be16			num;
 	struct packet_rollover	*rollover;
 	struct packet_mclist	*mclist;

--=20
2.51.0

