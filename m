Return-Path: <netdev+bounces-43767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5197D4AB2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2057A1C20ADA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514311701;
	Tue, 24 Oct 2023 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD2125B0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:43:02 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF399
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:43:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5997B208D5;
	Tue, 24 Oct 2023 10:42:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNWwzhssP0Rc; Tue, 24 Oct 2023 10:42:57 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 610D520853;
	Tue, 24 Oct 2023 10:42:57 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 5E93A80004A;
	Tue, 24 Oct 2023 10:42:57 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 10:42:57 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 24 Oct
 2023 10:42:56 +0200
Date: Tue, 24 Oct 2023 10:42:50 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Florian Westphal
	<fw@strlen.de>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: [RFC PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
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
simplifying the code base and eliminating unnecessary complexity.

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

Should I leave the '#define UDP_ENCAP_ESPINUDP_NON_IKE' in the uapi/linux/udp.h?
since it is a chnage to ABI?

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/uapi/linux/udp.h |  1 -
 net/ipv4/esp4.c          | 12 ------------
 net/ipv4/udp.c           |  2 --
 net/ipv4/xfrm4_input.c   | 13 -------------
 net/ipv6/esp6.c          | 12 ------------
 net/ipv6/xfrm6_input.c   | 13 -------------
 6 files changed, 53 deletions(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 4828794efcf8..1516f53698e0 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,7 +36,6 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */

 /* UDP encapsulation types */
-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
 #define UDP_ENCAP_GTP0		4 /* GSM TS 09.60 */
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2be2d4922557..f6ab7eef1513 100644
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
@@ -773,7 +765,6 @@ int esp_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1177,9 +1168,6 @@ static int esp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
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
index 7fdc250e0679..04c5b77f555c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2688,8 +2688,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
 			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
-			fallthrough;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 42879c5e026a..7a2b16aef71e 100644
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
index fddd0cbdede1..08d71131fd7b 100644
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
@@ -820,7 +812,6 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1230,9 +1221,6 @@ static int esp6_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
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
index ccf79b84c061..6e254cb64237 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -112,19 +112,6 @@ static int __xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
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


