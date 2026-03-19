Return-Path: <netdev+bounces-269499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLU4I0kUvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:20:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BABA2CD9A0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C583F3028EA3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAF3DEAD8;
	Thu, 19 Mar 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="S9ZWqsKa"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FC3DD52A;
	Thu, 19 Mar 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933613; cv=none; b=f/8muDkM1COxmVmRmDgApT/vXbSzv+Pk440VMm9BUFbjKxubRs3w55oS7gwsvapE8E3YKS7BqdAdXth4DPJOzlaCcKOo1wBD66rMxEnZveP3jbp72f5VFdWpCYMfhAMidnWsUxa7cCYWjwu1rkf+sMs67VwMAeX59YE9+iw0NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933613; c=relaxed/simple;
	bh=cWaW2hJHEcFomAfoes8Q2TkBrG47FpwnOq1LEspkmBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJfm8VPsBZqbTRNuTC0eJbuX2m4hspxRmEOreKnsWpq7I6HruR/7X6s2NfZ54jbnitt3HR54YF8M5ZX/MkXo0Hcp0zAn1NaCkCCV3U9Qynnx9qSuHppSwBNvGJnfiUFO/cUi36Ci+BPF5og9qQO1iiHDz3SW2/mb7d2cfpMf1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=S9ZWqsKa; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4fc8My6FJVz9xB0;
	Thu, 19 Mar 2026 16:13:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mkPPwP2E8HVu98S0M2DSu5QibU7KhMmUvb3wWQT4RE=;
	b=S9ZWqsKahzaZ8gYBVvFBcoh4GNrqfpB5K63u6XVJr3gFZZ8+a9HHZmsfmHsolnmDqQH9Eu
	6YDTHbPQpQSpvIyDvngp2LqdtdO0OY5qKiweHciyKUwiGa64q2YzUKuylYd6c0PiKfEnjH
	by8BdewRcZh0BffHBOKlTtDWDcmj4abep46C5F4A408oouiMSNMewoIm5N5BSrrYNMavEw
	Uy99of3scZMPwPnmtfE3GutqlBoMnd6yigYjgOtEEepwhCLEyj3hPZhWFC/EovV4Nhgc1N
	dizS/Rq1NTig145YpjDmKAwQPn8n/DBQkNIm4XYROBBQMqsd+2wD9hT5LakQSg==
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
Subject: [RFC net-next 06/15] ipxlat: add transport checksum and offload helpers
Date: Thu, 19 Mar 2026 16:12:15 +0100
Message-ID: <20260319151230.655687-7-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269499-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[darkboxed.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid]
X-Rspamd-Queue-Id: 4BABA2CD9A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add shared transport-layer helpers for checksum manipulation and offload
metadata normalization across family translation.

This introduces incremental and full checksum utilities plus generic
ICMP relayout/offload finalization routines reused by later 4->6 and
6->4 transport translation paths.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/transport.c | 146 +++++++++++++++++++++++++++++++++
 drivers/net/ipxlat/transport.h |  83 +++++++++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 drivers/net/ipxlat/transport.c
 create mode 100644 drivers/net/ipxlat/transport.h

diff --git a/drivers/net/ipxlat/transport.c b/drivers/net/ipxlat/transport.c
new file mode 100644
index 000000000000..cd786ce84adc
--- /dev/null
+++ b/drivers/net/ipxlat/transport.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <net/ip.h>
+#include <net/ip6_checksum.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+
+#include "packet.h"
+#include "transport.h"
+
+/* set CHECKSUM_PARTIAL metadata for transport checksum completion */
+int ipxlat_set_partial_csum(struct sk_buff *skb, u16 csum_offset)
+{
+	if (likely(skb_partial_csum_set(skb, skb_transport_offset(skb),
+					csum_offset)))
+		return 0;
+	return -EINVAL;
+}
+
+static __wsum ipxlat_pseudohdr6_csum(const struct ipv6hdr *hdr)
+{
+	return ~csum_unfold(csum_ipv6_magic(&hdr->saddr, &hdr->daddr, 0, 0, 0));
+}
+
+static __wsum ipxlat_pseudohdr4_csum(const struct iphdr *hdr)
+{
+	return csum_tcpudp_nofold(hdr->saddr, hdr->daddr, 0, 0, 0);
+}
+
+static __sum16 ipxlat_46_update_csum(__sum16 csum16,
+				     const struct iphdr *in_ip4,
+				     const void *in_l4_hdr,
+				     const struct ipv6hdr *out_ip6,
+				     const void *out_l4_hdr, size_t l4_hdr_len)
+{
+	__wsum csum;
+
+	csum = ~csum_unfold(csum16);
+
+	/* replace pseudohdr and L4 header contributions, payload unchanged */
+	csum = csum_sub(csum, ipxlat_pseudohdr4_csum(in_ip4));
+	csum = csum_sub(csum, csum_partial(in_l4_hdr, l4_hdr_len, 0));
+	csum = csum_add(csum, ipxlat_pseudohdr6_csum(out_ip6));
+	csum = csum_add(csum, csum_partial(out_l4_hdr, l4_hdr_len, 0));
+	return csum_fold(csum);
+}
+
+static __sum16 ipxlat_64_update_csum(__sum16 csum16,
+				     const struct ipv6hdr *in_ip6,
+				     const void *in_l4_hdr,
+				     size_t in_l4_hdr_len,
+				     const struct iphdr *out_ip4,
+				     const void *out_l4_hdr,
+				     size_t out_l4_hdr_len)
+{
+	__wsum csum;
+
+	csum = ~csum_unfold(csum16);
+
+	/* only address terms matter because L4 length/proto are unchanged */
+	csum = csum_sub(csum, ipxlat_pseudohdr6_csum(in_ip6));
+	csum = csum_sub(csum, csum_partial(in_l4_hdr, in_l4_hdr_len, 0));
+
+	csum = csum_add(csum, ipxlat_pseudohdr4_csum(out_ip4));
+	csum = csum_add(csum, csum_partial(out_l4_hdr, out_l4_hdr_len, 0));
+
+	return csum_fold(csum);
+}
+
+__sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
+			    const struct in6_addr *daddr,
+			    const struct sk_buff *skb, unsigned int l4_off,
+			    unsigned int l4_len, u8 proto)
+{
+	return csum_ipv6_magic(saddr, daddr, l4_len, proto,
+			       skb_checksum(skb, l4_off, l4_len, 0));
+}
+
+/* Normalize checksum/offload metadata after address-family translation.
+ *
+ * Translation changes protocol family but keeps transport payload semantics
+ * intact, so TCP GSO only needs type remap (gso_from -> gso_to), while ICMP
+ * must clear stale GSO state because there is no ICMP GSO transform here.
+ *
+ * This mirrors forwarding expectations: reject LRO on xmit and clear hash
+ * when tuple semantics may have changed (fragments and non-TCP/UDP).
+ */
+int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
+			    u32 gso_from, u32 gso_to)
+{
+	struct skb_shared_info *shinfo;
+
+	if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE))
+		skb->ip_summed = CHECKSUM_NONE;
+
+	if (!skb_is_gso(skb))
+		goto out_hash;
+
+	/* align with forwarding paths that reject LRO skbs before xmit */
+	if (unlikely(skb_warn_if_lro(skb)))
+		return -EINVAL;
+
+	shinfo = skb_shinfo(skb);
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		/* segment payload size is unchanged by address-family
+		 * translation so there's no need to touch gso_size
+		 */
+		if (shinfo->gso_type & gso_from) {
+			shinfo->gso_type &= ~gso_from;
+			shinfo->gso_type |= gso_to;
+		} else if (unlikely(!(shinfo->gso_type & gso_to))) {
+			return -EOPNOTSUPP;
+		}
+		break;
+	case IPPROTO_UDP:
+		break;
+	case IPPROTO_ICMP:
+		/* for ICMP there is no GSO transform; clear stale offload
+		 * metadata so the stack treats it as a normal frame
+		 */
+		skb_gso_reset(skb);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+out_hash:
+	if (unlikely(is_fragment ||
+		     (l4_proto != IPPROTO_TCP && l4_proto != IPPROTO_UDP)))
+		skb_clear_hash(skb);
+	else
+		skb_clear_hash_if_not_l4(skb);
+	return 0;
+}
diff --git a/drivers/net/ipxlat/transport.h b/drivers/net/ipxlat/transport.h
new file mode 100644
index 000000000000..bd228aecfb3b
--- /dev/null
+++ b/drivers/net/ipxlat/transport.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_TRANSPORT_H_
+#define _NET_IPXLAT_TRANSPORT_H_
+
+#include <linux/icmp.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+/**
+ * ipxlat_l4_min_len - minimum transport header size for protocol
+ * @protocol: transport protocol identifier
+ *
+ * Return: minimum header length for @protocol, or 0 when unsupported.
+ */
+static inline unsigned int ipxlat_l4_min_len(u8 protocol)
+{
+	switch (protocol) {
+	case IPPROTO_TCP:
+		return sizeof(struct tcphdr);
+	case IPPROTO_UDP:
+		return sizeof(struct udphdr);
+	case IPPROTO_ICMP:
+		return sizeof(struct icmphdr);
+	default:
+		return 0;
+	}
+}
+
+/**
+ * ipxlat_set_partial_csum - program CHECKSUM_PARTIAL metadata on skb
+ * @skb: packet with transport checksum field
+ * @csum_offset: offset of checksum field within transport header
+ *
+ * Return: 0 on success, negative errno on invalid skb state.
+ */
+int ipxlat_set_partial_csum(struct sk_buff *skb, u16 csum_offset);
+
+/**
+ * ipxlat_l4_csum_ipv6 - compute full L4 checksum with IPv6 pseudo-header
+ * @saddr: IPv6 source address
+ * @daddr: IPv6 destination address
+ * @skb: packet buffer
+ * @l4_off: transport header offset
+ * @l4_len: transport span (header + payload)
+ * @proto: transport protocol
+ *
+ * Return: folded checksum value covering pseudo-header and transport payload.
+ */
+__sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
+			    const struct in6_addr *daddr,
+			    const struct sk_buff *skb, unsigned int l4_off,
+			    unsigned int l4_len, u8 proto);
+
+/**
+ * ipxlat_finalize_offload - normalize checksum/GSO metadata after translation
+ * @skb: translated packet
+ * @l4_proto: resulting transport protocol
+ * @is_fragment: resulting packet is fragmented
+ * @gso_from: input TCP GSO type bit
+ * @gso_to: output TCP GSO type bit
+ *
+ * Converts TCP GSO family bits and clears stale checksum/hash state when
+ * offload metadata cannot be preserved across address-family translation.
+ *
+ * Return: 0 on success, negative errno on unsupported/offload-incompatible
+ * input.
+ */
+int ipxlat_finalize_offload(struct sk_buff *skb, u8 l4_proto, bool is_fragment,
+			    u32 gso_from, u32 gso_to);
+
+#endif /* _NET_IPXLAT_TRANSPORT_H_ */
-- 
2.53.0


