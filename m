Return-Path: <netdev+bounces-269492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M8GMTETvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:16:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46D2CD8BB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 583B53065720
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AADD3E022D;
	Thu, 19 Mar 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="joSMu+tX"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CE3D3481;
	Thu, 19 Mar 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933208; cv=none; b=a7C4MA6bbMTi2PJ5T5HIVbGwnFSbraAlx3XZMZ5T/9bztWsfJQAK5cqsWB8CFuyIxDd42w6u/a5US457ZTxxgZkH++DzucXmQV0xdmKS2pRo17rqHQRBWqK4LCZ8baTMUMIIzLCTg+Y9hADZzEb7fB8BF2ksItuSKjhvfK3b9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933208; c=relaxed/simple;
	bh=AdceW1FN4eDUaFa0FYDNgm9vSomij039gshdCZPh0EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov8mGX2UApPSCYIyQmUBh4z9/4MX/EsLspr7XyXx6z6kJeJPq+nlGRvyDp8iLb7kljdNJvZB9ttQ71tw5eSacDScktGRUMpKnw7KVnVh87i9D827sVLEzMV8yueX43NH36y++/P1WatBagw5n1DNUet99QaNmzdiDaqy0hLRWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=joSMu+tX; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4fc8N34JYkzDx5w;
	Thu, 19 Mar 2026 16:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZR5uoZ2ZSYxknGF6muIkL03VVRbFhAx1x3IXKaFjIM=;
	b=joSMu+tX1NoUzw/SJBK1PfA8vYLdRUN54+uWHZJwchWVl8xedbKgqywpjvCuixhrJPB137
	OGjVV/6v5lwRQM8ttZcZ++vAFFNw1Uqp8nV5ugU/w0WzInbsybEK9zyHhB4NjyEOeN1Prn
	eR65FTxDhy7UGoJTH+fkeBFpBKgYqsjY/djP8fHb5etKuXVqYfMEHDqgT9kfikgyvtWfbK
	WasWHJW2SsB5Eq7Ny5f1Cq8yaDG1YhBSh9yuoxJMMY3w82Rx9Wj8GlvTYxQX48/SAagrJG
	p2kLAGWhBxAiEdhifJpMfz/fmAMpKHG4x3eLOXstXk+Ifiazidne3ps6AShDFw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 07/15] ipxlat: add 4to6 and 6to4 TCP/UDP translation helpers
Date: Thu, 19 Mar 2026 16:12:16 +0100
Message-ID: <20260319151230.655687-8-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269492-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mandelbit.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.901];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D46D2CD8BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add protocol-specific transport translation entry points for both
address-family directions.

This wires checksum adjustment for outer and quoted-inner TCP/UDP
headers and provides the transport routines consumed by the translation
engine.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/transport.c | 194 +++++++++++++++++++++++++++++++++
 drivers/net/ipxlat/transport.h |  20 ++++
 2 files changed, 214 insertions(+)

diff --git a/drivers/net/ipxlat/transport.c b/drivers/net/ipxlat/transport.c
index cd786ce84adc..3aa00c635916 100644
--- a/drivers/net/ipxlat/transport.c
+++ b/drivers/net/ipxlat/transport.c
@@ -144,3 +144,197 @@ int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
 		skb_clear_hash_if_not_l4(skb);
 	return 0;
 }
+
+int ipxlat_46_outer_tcp(struct sk_buff *skb, const struct iphdr *in4)
+{
+	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
+	struct tcphdr *tcp_new = tcp_hdr(skb);
+	struct tcphdr tcp_old;
+	__sum16 csum16;
+
+	/* CHECKSUM_PARTIAL keeps a pseudohdr seed in check, not a final
+	 * transport checksum. For 4->6, we only re-seed it with IPv6 pseudohdr
+	 * data and keep completion deferred to offload.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		tcp_new->check = ~tcp_v6_check(ipxlat_skb_datagram_len(skb),
+					       &iph6->saddr, &iph6->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct tcphdr, check));
+	}
+
+	/* zeroing check in old/new headers avoids double-accounting it */
+	csum16 = tcp_new->check;
+	tcp_old = *tcp_new;
+	tcp_old.check = 0;
+	tcp_new->check = 0;
+	tcp_new->check = ipxlat_46_update_csum(csum16, in4,
+					       &tcp_old, iph6, tcp_new,
+					       sizeof(*tcp_new));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_outer_udp(struct sk_buff *skb, const struct iphdr *in4)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
+	struct udphdr *udp_new = udp_hdr(skb);
+	struct udphdr udp_old;
+	__sum16 csum16;
+
+	/* outer path enforces UDP zero-checksum policy in validation */
+	if (skb->ip_summed == CHECKSUM_PARTIAL && likely(udp_new->check != 0)) {
+		udp_new->check = ~udp_v6_check(ipxlat_skb_datagram_len(skb),
+					       &iph6->saddr, &iph6->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct udphdr, check));
+	}
+
+	/* incoming UDP IPv4 has no checksum (legal in IPv4, not in IPv6) */
+	if (unlikely(udp_new->check == 0)) {
+		if (unlikely(!cb->udp_zero_csum_len))
+			return -EINVAL;
+
+		udp_new->check =
+			ipxlat_l4_csum_ipv6(&iph6->saddr, &iph6->daddr, skb,
+					    skb_transport_offset(skb),
+					    cb->udp_zero_csum_len, IPPROTO_UDP);
+		/* 0x0000 on wire means "no checksum"; preserve computed zero */
+		if (udp_new->check == 0)
+			udp_new->check = CSUM_MANGLED_0;
+		skb->ip_summed = CHECKSUM_NONE;
+		return 0;
+	}
+
+	csum16 = udp_new->check;
+	udp_old = *udp_new;
+	udp_old.check = 0;
+	udp_new->check = 0;
+	udp_new->check = ipxlat_46_update_csum(csum16, in4,
+					       &udp_old, iph6, udp_new,
+					       sizeof(*udp_new));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_inner_tcp(struct sk_buff *skb, const struct iphdr *in4,
+			const struct ipv6hdr *iph6, struct tcphdr *tcp_new)
+{
+	struct tcphdr tcp_old;
+	__sum16 csum16;
+
+	csum16 = tcp_new->check;
+	tcp_old = *tcp_new;
+	tcp_old.check = 0;
+	tcp_new->check = 0;
+	tcp_new->check = ipxlat_46_update_csum(csum16, in4, &tcp_old, iph6,
+					       tcp_new, sizeof(*tcp_new));
+	return 0;
+}
+
+int ipxlat_46_inner_udp(struct sk_buff *skb, const struct iphdr *in4,
+			const struct ipv6hdr *iph6, struct udphdr *udp_new)
+{
+	struct udphdr udp_old;
+	__sum16 csum16;
+
+	if (unlikely(udp_new->check == 0))
+		return 0;
+
+	csum16 = udp_new->check;
+	udp_old = *udp_new;
+	udp_old.check = 0;
+	udp_new->check = 0;
+	udp_new->check = ipxlat_46_update_csum(csum16, in4, &udp_old, iph6,
+					       udp_new, sizeof(*udp_new));
+	return 0;
+}
+
+int ipxlat_64_outer_tcp(struct sk_buff *skb, const struct ipv6hdr *in6)
+{
+	struct tcphdr tcp_old, *tcp_new;
+	__sum16 csum16;
+
+	tcp_new = tcp_hdr(skb);
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		tcp_new->check = ~tcp_v4_check(ipxlat_skb_datagram_len(skb),
+					       ip_hdr(skb)->saddr,
+					       ip_hdr(skb)->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct tcphdr, check));
+	}
+
+	csum16 = tcp_new->check;
+	tcp_old = *tcp_new;
+	tcp_old.check = 0;
+	tcp_new->check = 0;
+	tcp_new->check = ipxlat_64_update_csum(csum16, in6, &tcp_old,
+					       sizeof(tcp_old), ip_hdr(skb),
+					       tcp_new, sizeof(*tcp_new));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_64_outer_udp(struct sk_buff *skb, const struct ipv6hdr *in6)
+{
+	struct udphdr udp_old, *udp_new;
+	__sum16 csum16;
+
+	udp_new = udp_hdr(skb);
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		udp_new->check = ~udp_v4_check(ipxlat_skb_datagram_len(skb),
+					       ip_hdr(skb)->saddr,
+					       ip_hdr(skb)->daddr, 0);
+		return ipxlat_set_partial_csum(skb,
+					       offsetof(struct udphdr, check));
+	}
+
+	csum16 = udp_new->check;
+	udp_old = *udp_new;
+	udp_old.check = 0;
+	udp_new->check = 0;
+	udp_new->check = ipxlat_64_update_csum(csum16, in6, &udp_old,
+					       sizeof(udp_old), ip_hdr(skb),
+					       udp_new, sizeof(*udp_new));
+	if (udp_new->check == 0)
+		udp_new->check = CSUM_MANGLED_0;
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_64_inner_tcp(struct sk_buff *skb, const struct ipv6hdr *in6,
+			const struct iphdr *out4, struct tcphdr *tcp_new)
+{
+	struct tcphdr tcp_old;
+	__sum16 csum16;
+
+	csum16 = tcp_new->check;
+	tcp_old = *tcp_new;
+	tcp_old.check = 0;
+	tcp_new->check = 0;
+	tcp_new->check = ipxlat_64_update_csum(csum16, in6, &tcp_old,
+					       sizeof(tcp_old), out4, tcp_new,
+					       sizeof(*tcp_new));
+	return 0;
+}
+
+int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
+			const struct iphdr *out4, struct udphdr *udp_new)
+{
+	struct udphdr udp_old;
+	__sum16 csum16;
+
+	csum16 = udp_new->check;
+	udp_old = *udp_new;
+	udp_old.check = 0;
+	udp_new->check = 0;
+	udp_new->check = ipxlat_64_update_csum(csum16, in6, &udp_old,
+					       sizeof(udp_old), out4, udp_new,
+					       sizeof(*udp_new));
+	if (udp_new->check == 0)
+		udp_new->check = CSUM_MANGLED_0;
+	return 0;
+}
diff --git a/drivers/net/ipxlat/transport.h b/drivers/net/ipxlat/transport.h
index bd228aecfb3b..9b6fe422b01f 100644
--- a/drivers/net/ipxlat/transport.h
+++ b/drivers/net/ipxlat/transport.h
@@ -80,4 +80,24 @@ __sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
 int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
 			    u32 gso_from, u32 gso_to);
 
+/* outer transport translation helpers (packet L3 already translated) */
+int ipxlat_46_outer_tcp(struct sk_buff *skb, const struct iphdr *in4);
+int ipxlat_46_outer_udp(struct sk_buff *skb, const struct iphdr *in4);
+
+/* quoted-inner transport translation helpers for ICMP error payloads */
+int ipxlat_46_inner_tcp(struct sk_buff *skb, const struct iphdr *in4,
+			const struct ipv6hdr *iph6, struct tcphdr *tcp_new);
+int ipxlat_46_inner_udp(struct sk_buff *skb, const struct iphdr *in4,
+			const struct ipv6hdr *iph6, struct udphdr *udp_new);
+
+/* outer transport translation helpers (packet L3 already translated) */
+int ipxlat_64_outer_tcp(struct sk_buff *skb, const struct ipv6hdr *in6);
+int ipxlat_64_outer_udp(struct sk_buff *skb, const struct ipv6hdr *in6);
+
+/* quoted-inner transport translation helpers for ICMP error payloads */
+int ipxlat_64_inner_tcp(struct sk_buff *skb, const struct ipv6hdr *in6,
+			const struct iphdr *out4, struct tcphdr *tcp_new);
+int ipxlat_64_inner_udp(struct sk_buff *skb, const struct ipv6hdr *in6,
+			const struct iphdr *out4, struct udphdr *udp_new);
+
 #endif /* _NET_IPXLAT_TRANSPORT_H_ */
-- 
2.53.0


