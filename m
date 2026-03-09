Return-Path: <netdev+bounces-265616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMImBCHurmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:58:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F523C43E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0488D3091094
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A03E0C61;
	Mon,  9 Mar 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oN+wpO4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H49ozuFx"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9793DEAE2
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071601; cv=none; b=HV1uubzg/9mm3wKbX6/7WQwNnKYfx7wy30IzzHh9bTBhT27EWgiWXbaGjc/JuYcEvTBkV+OG8+Pu7DvXpGs/YDiRf6w0fOBOVhI/sK65/xu9oN7ZCA6hBWHIM0PJEwb17WvqyUHDArVRJo3jXZSehDPzB4Ho6QdPfcnd32yGO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071601; c=relaxed/simple;
	bh=NVRaZdAtqm5pwMlygo6QViY6BFmQoxpsCJjfzKwLwhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irGecDfuN7bzVFH50h9nIAM78kaN0Cbl6M9OmKyb+CMo/xtXuWbymkix2lfo2Uv2EZrMc0upK8cICRlQR9vGFqEVhEeDLr/xwEtvfnVT5ITFhBLVJrlyQcdF5kpNWXENEqgYGGwy+dxIk8FH3cDh6/oXdFQfmS2DbLeXR6P6PeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oN+wpO4h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H49ozuFx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773071598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnBuRTHtOxWFgPG/kWjm6m6fYQ2Teh+YiPWuWimeTTA=;
	b=oN+wpO4hoECPk11+v4x8v5Icx7EYWNnvxk/6P5oC9x7jDP9p+reNlexpkNJW44VV6JZSqn
	AL7Al6YZVsqUnOOndnucwaAu13YDKQOK9nbg/I60wnkodpMuIid88SdYtiSFbNC7OMYyjQ
	p7mJHVwMzw9PyvacYNZTEPa1aWnlbuCWDsgASUiEkNCkdo690vmzdu57wIvVh3AkHBt0iE
	5EqAd1a9OGNLBJnGxM9O7gC/pPjU8GgCqCrWihIbk73Pf6g+wttsZmLsuEs75cSiqg60s1
	NX2Nby7s3TKCt3Kgrl5qULbJh2sUBxK+LP9UXa335msycB1o351rHxByYygIfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773071598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnBuRTHtOxWFgPG/kWjm6m6fYQ2Teh+YiPWuWimeTTA=;
	b=H49ozuFxGvUymnhSGCfMzoJBFkVIiFIvz8uQrrrT53gQIJCGm6RxFUstSOpa5AObOEBfxt
	fFYvmKf8xJ0+gYCA==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH RFC net-next v2 2/2] af_packet: Add port specific handling for HSR
Date: Mon,  9 Mar 2026 16:52:36 +0100
Message-ID: <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
In-Reply-To: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 683F523C43E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265616-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

linuxptp/ ptp4l uses a AF_PACKET with a RAW socket to send and receive
PTP packets. Extend the interface with the ability to bind the socket to
one of the two HSR ports and a flag for sendmsg() to indicate that the
packet already contains a HSR header.

Once PACKET_HSR_BIND_PORT is set, the socket will be bound to requested
slave port. All incoming packets without a set port will be discarded.
This limits receiving packet to PTP only packets since only those get
the tagging by the HSR stack.

For the control message used by sendmsg(), type PACKET_HSR_INFO is added
with PACKET_HSR_INFO_HAS_HDR as the only option. If this is used, the
skb will be known as containing the HSR header. This option can only be
used if the socket is bound to a specific HSR port.

To lower the impact for non-PTP-HSR/PRP user, a static branch is used to
to avoid a compare & branch if the socket was not bound to a hsr-slave
device. If CONFIG_HSR is not set, the compiler will be smart enough to
remove the code entirely (keeping only PACKET_HSR_BIND_PORT for
getsockopt()).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/uapi/linux/if_packet.h |   9 +++
 net/packet/af_packet.c         | 167 +++++++++++++++++++++++++++++++++++++=
++++
 net/packet/internal.h          |   1 +
 3 files changed, 177 insertions(+)

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
index 72d0935139f0f..98322ad57a234 100644
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
@@ -284,6 +285,94 @@ static int packet_xmit(const struct packet_sock *po, s=
truct sk_buff *skb)
 	return dev_direct_xmit(skb, packet_pick_tx_queue(skb));
 }
=20
+#if IS_ENABLED(CONFIG_HSR)
+
+static DEFINE_STATIC_KEY_FALSE(hsr_ptp_support_enabled);
+
+static inline bool packet_add_ptp_settings(struct sk_buff *skb,
+					   bool header, unsigned int port)
+{
+	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
+		return true;
+
+	if (!port)
+		return true;
+
+	return hsr_skb_add_header_port(skb, header, port);
+}
+
+static inline bool packet_filter_hsr_port(struct packet_sock *po, struct s=
k_buff *skb)
+{
+	unsigned int req_port;
+	bool req_hdr;
+
+	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
+		return false;
+
+	if (!po->hsr_bound_port)
+		return false;
+
+	if (!hsr_skb_get_header_port(skb, &req_hdr, &req_port))
+		return true;
+
+	if (req_port =3D=3D po->hsr_bound_port)
+		return false;
+	return true;
+}
+
+static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
+			    bool *hsr_has_hdr)
+{
+	struct cmsghdr *cmsg;
+	int ret =3D -EINVAL;
+	u32 val;
+
+	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
+		return 0;
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
+		*hsr_has_hdr =3D true;
+	}
+	ret =3D 0;
+out:
+	return ret;
+}
+
+#else
+
+static bool packet_add_ptp_settings(struct sk_buff *skb,
+				    bool header, unsigned int port)
+{
+	return true;
+}
+
+static bool packet_filter_hsr_port(struct packet_sock *po, struct sk_buff =
*skb)
+{
+	return false;
+}
+
+static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
+			    bool *hsr_has_hdr)
+{
+	return 0;
+}
+#endif
+
 static struct net_device *packet_cached_dev_get(struct packet_sock *po)
 {
 	struct net_device *dev;
@@ -2131,6 +2220,9 @@ static int packet_rcv(struct sk_buff *skb, struct net=
_device *dev,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		goto drop;
=20
+	if (packet_filter_hsr_port(po, skb))
+		goto drop;
+
 	skb->dev =3D dev;
=20
 	if (dev_has_header(dev)) {
@@ -2260,6 +2352,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		goto drop;
=20
+	if (packet_filter_hsr_port(po, skb))
+		goto drop;
+
 	if (dev_has_header(dev)) {
 		if (sk->sk_type !=3D SOCK_DGRAM)
 			skb_push(skb, skb->data - skb_mac_header(skb));
@@ -2731,6 +2826,7 @@ static int tpacket_snd(struct packet_sock *po, struct=
 msghdr *msg)
 	int len_sum =3D 0;
 	int status =3D TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen =3D 0;
+	bool hsr_has_hdr =3D false;
 	long timeo;
=20
 	mutex_lock(&po->pg_vec_lock);
@@ -2775,6 +2871,10 @@ static int tpacket_snd(struct packet_sock *po, struc=
t msghdr *msg)
 		err =3D sock_cmsg_send(&po->sk, msg, &sockc);
 		if (unlikely(err))
 			goto out_put;
+
+		err =3D packet_cmsg_send(msg, po, &hsr_has_hdr);
+		if (unlikely(err))
+			goto out_put;
 	}
=20
 	if (po->sk.sk_socket->type =3D=3D SOCK_RAW)
@@ -2863,6 +2963,10 @@ static int tpacket_snd(struct packet_sock *po, struc=
t msghdr *msg)
 				goto out_status;
 			}
 		}
+		if (!packet_add_ptp_settings(skb, hsr_has_hdr, po->hsr_bound_port)) {
+			err =3D -ENOMEM;
+			goto out_status;
+		}
=20
 		if (vnet_hdr_sz) {
 			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
@@ -2950,6 +3054,7 @@ static int packet_snd(struct socket *sock, struct msg=
hdr *msg, size_t len)
 	int offset =3D 0;
 	struct packet_sock *po =3D pkt_sk(sk);
 	int vnet_hdr_sz =3D READ_ONCE(po->vnet_hdr_sz);
+	bool hsr_has_hdr =3D false;
 	int hlen, tlen, linear;
 	int extra_len =3D 0;
=20
@@ -2988,6 +3093,10 @@ static int packet_snd(struct socket *sock, struct ms=
ghdr *msg, size_t len)
 		err =3D sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto out_unlock;
+
+		err =3D packet_cmsg_send(msg, po, &hsr_has_hdr);
+		if (unlikely(err))
+			goto out_unlock;
 	}
=20
 	if (sock->type =3D=3D SOCK_RAW)
@@ -3047,6 +3156,10 @@ static int packet_snd(struct socket *sock, struct ms=
ghdr *msg, size_t len)
 	}
=20
 	skb_setup_tx_timestamp(skb, &sockc);
+	if (!packet_add_ptp_settings(skb, hsr_has_hdr, po->hsr_bound_port)) {
+		err =3D -ENOMEM;
+		goto out_free;
+	}
=20
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
@@ -3166,6 +3279,11 @@ static int packet_release(struct socket *sock)
 		fanout_release_data(f);
 		kvfree(f);
 	}
+
+#if IS_ENABLED(CONFIG_HSR)
+	if (po->hsr_bound_port)
+		static_branch_dec(&hsr_ptp_support_enabled);
+#endif
 	/*
 	 *	Now the socket is dead. No more input will appear.
 	 */
@@ -4044,6 +4162,40 @@ packet_setsockopt(struct socket *sock, int level, in=
t optname, sockptr_t optval,
 		packet_sock_flag_set(po, PACKET_SOCK_QDISC_BYPASS, val);
 		return 0;
 	}
+	case PACKET_HSR_BIND_PORT:
+	{
+#if IS_ENABLED(CONFIG_HSR)
+		int old_val;
+		int val;
+
+		if (optlen !=3D sizeof(val))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
+			return -EFAULT;
+
+		old_val =3D !!po->hsr_bound_port;
+		switch (val) {
+		case PACKET_HSR_BIND_PORT_AB:
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
+		if (old_val !=3D !!po->hsr_bound_port) {
+			if (po->hsr_bound_port)
+				static_branch_inc(&hsr_ptp_support_enabled);
+			else
+				static_branch_dec(&hsr_ptp_support_enabled);
+		}
+		return 0;
+#endif
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -4164,6 +4316,21 @@ static int packet_getsockopt(struct socket *sock, in=
t level, int optname,
 	case PACKET_QDISC_BYPASS:
 		val =3D packet_sock_flag(po, PACKET_SOCK_QDISC_BYPASS);
 		break;
+	case PACKET_HSR_BIND_PORT:
+		switch (po->hsr_bound_port) {
+		case 0:
+			val =3D PACKET_HSR_BIND_PORT_AB;
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
2.53.0


