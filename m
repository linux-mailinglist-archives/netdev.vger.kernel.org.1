Return-Path: <netdev+bounces-48653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76B7EF1B1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC52B209F8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE421A5B6;
	Fri, 17 Nov 2023 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB35129
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 03:26:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 24E3E20861;
	Fri, 17 Nov 2023 12:26:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTDVtJgFAS5C; Fri, 17 Nov 2023 12:26:25 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 21F7F20754;
	Fri, 17 Nov 2023 12:26:25 +0100 (CET)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 162FB80004A;
	Fri, 17 Nov 2023 12:26:25 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 12:26:24 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 17 Nov
 2023 12:26:24 +0100
Date: Fri, 17 Nov 2023 12:26:16 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: [PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <6a62426745e9689ab18ca60a1560e047f78884f9.1700220201.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
in 2004 [2], has remained inactive and obsolete for an extended period.

This mode was originally defined in an early version of an IETF draft
[1] from 2001. By the time it was integrated into the kernel in 2004 [2],
it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.

Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
known use cases.

With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
simplifying the codebase and eliminating unnecessary complexity.
Actually, we remove the functionality and wrap  UDP_ENCAP_ESPINUDP_NON_IKE
defination in "#ifndef __KERNEL__". If it is used again in kernel code
your build will fail.

References:
[1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt

[2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
    repository.

    Author: Andreas Gruenbacher <agruen@suse.de>
    Date: Fri Apr 9 01:47:47 2004 -0700

   [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.

[3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
    repository.

    Author: Derek Atkins <derek@ihtfp.com>
    Date: Wed Apr 2 13:21:02 2003 -0800

    [IPSEC]: Implement UDP Encapsulation framework.


Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
RFC -> v1
- keep removed defination wrapped in #ifndef __KERNEL__
---
 include/uapi/linux/udp.h |  5 ++++-
 net/ipv4/esp4.c          | 12 ------------
 net/ipv4/udp.c           |  2 --
 net/ipv4/xfrm4_input.c   | 13 -------------
 net/ipv6/esp6.c          | 12 ------------
 net/ipv6/xfrm6_input.c   | 13 -------------
 6 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 4828794efcf8..66344971d955 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,7 +36,10 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */

 /* UDP encapsulation types */
-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
+#ifndef __KERNEL__
+#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* (obsolete) draft-ietf-ipsec-nat-t-ike-00/01 */
+#endif
+
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
 #define UDP_ENCAP_GTP0		4 /* GSM TS 09.60 */
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4ccfc104f13a..eea61260d902 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -347,7 +347,6 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 					       __be16 dport)
 {
 	struct udphdr *uh;
-	__be32 *udpdata32;
 	unsigned int len;

 	len = skb->len + esp->tailen - skb_transport_offset(skb);
@@ -362,12 +361,6 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,

 	*skb_mac_header(skb) = IPPROTO_UDP;

-	if (encap_type == UDP_ENCAP_ESPINUDP_NON_IKE) {
-		udpdata32 = (__be32 *)(uh + 1);
-		udpdata32[0] = udpdata32[1] = 0;
-		return (struct ip_esp_hdr *)(udpdata32 + 2);
-	}
-
 	return (struct ip_esp_hdr *)(uh + 1);
 }

@@ -423,7 +416,6 @@ static int esp_output_encap(struct xfrm_state *x, struct sk_buff *skb,
 	switch (encap_type) {
 	default:
 	case UDP_ENCAP_ESPINUDP:
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		esph = esp_output_udp_encap(skb, encap_type, esp, sport, dport);
 		break;
 	case TCP_ENCAP_ESPINTCP:
@@ -775,7 +767,6 @@ int esp_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1179,9 +1170,6 @@ static int esp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len += sizeof(struct udphdr);
 			break;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
-			x->props.header_len += sizeof(struct udphdr) + 2 * sizeof(u32);
-			break;
 #ifdef CONFIG_INET_ESPINTCP
 		case TCP_ENCAP_ESPINTCP:
 			/* only the length field, TCP encap is done by
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..31727d2c13c6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2693,8 +2693,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
 			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
-			fallthrough;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index c54676998eb6..067a422e5e40 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -113,19 +113,6 @@ static int __xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 			/* Must be an IKE packet.. pass it through */
 			return 1;
 		break;
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
-		/* Check if this is a keepalive packet.  If so, eat it. */
-		if (len == 1 && udpdata[0] == 0xff) {
-			return -EINVAL;
-		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
-			   udpdata32[0] == 0 && udpdata32[1] == 0) {
-
-			/* ESP Packet with Non-IKE marker */
-			len = sizeof(struct udphdr) + 2 * sizeof(u32);
-		} else
-			/* Must be an IKE packet.. pass it through */
-			return 1;
-		break;
 	}

 	/* At this point we are sure that this is an ESPinUDP packet,
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 2cc1a45742d8..39d94638398d 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -383,7 +383,6 @@ static struct ip_esp_hdr *esp6_output_udp_encap(struct sk_buff *skb,
 					       __be16 dport)
 {
 	struct udphdr *uh;
-	__be32 *udpdata32;
 	unsigned int len;

 	len = skb->len + esp->tailen - skb_transport_offset(skb);
@@ -398,12 +397,6 @@ static struct ip_esp_hdr *esp6_output_udp_encap(struct sk_buff *skb,

 	*skb_mac_header(skb) = IPPROTO_UDP;

-	if (encap_type == UDP_ENCAP_ESPINUDP_NON_IKE) {
-		udpdata32 = (__be32 *)(uh + 1);
-		udpdata32[0] = udpdata32[1] = 0;
-		return (struct ip_esp_hdr *)(udpdata32 + 2);
-	}
-
 	return (struct ip_esp_hdr *)(uh + 1);
 }

@@ -459,7 +452,6 @@ static int esp6_output_encap(struct xfrm_state *x, struct sk_buff *skb,
 	switch (encap_type) {
 	default:
 	case UDP_ENCAP_ESPINUDP:
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		esph = esp6_output_udp_encap(skb, encap_type, esp, sport, dport);
 		break;
 	case TCP_ENCAP_ESPINTCP:
@@ -822,7 +814,6 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1232,9 +1223,6 @@ static int esp6_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len += sizeof(struct udphdr);
 			break;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
-			x->props.header_len += sizeof(struct udphdr) + 2 * sizeof(u32);
-			break;
 #ifdef CONFIG_INET6_ESPINTCP
 		case TCP_ENCAP_ESPINTCP:
 			/* only the length field, TCP encap is done by
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 6e36e5047fba..093cff85f61f 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -109,19 +109,6 @@ static int __xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 			/* Must be an IKE packet.. pass it through */
 			return 1;
 		break;
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
-		/* Check if this is a keepalive packet.  If so, eat it. */
-		if (len == 1 && udpdata[0] == 0xff) {
-			return -EINVAL;
-		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
-			   udpdata32[0] == 0 && udpdata32[1] == 0) {
-
-			/* ESP Packet with Non-IKE marker */
-			len = sizeof(struct udphdr) + 2 * sizeof(u32);
-		} else
-			/* Must be an IKE packet.. pass it through */
-			return 1;
-		break;
 	}

 	/* At this point we are sure that this is an ESPinUDP packet,
--
2.30.2


