Return-Path: <netdev+bounces-267699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFFmNTwttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01B28C6DC
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A79AC301220E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739E34EF11;
	Sat, 14 Mar 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Dutbwka9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="V85RkQTA"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E24284686;
	Sat, 14 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481268; cv=none; b=U7C9YB3uHoCSnw1hmtjVd4t01pogFJLu1m8jIcIVW4A24rZePtpXDmPSUK3v3/unV4EJXaF9tLv5CX7P7aDhYMCwbMac1DQx6xIfNjaFU4VLjQ6dGBSRO6DVai5QlQxWj6C3FvNCjXOsxz3rrgXGD5RrJoLAgrUXOUWkArbvKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481268; c=relaxed/simple;
	bh=RnnK7oFh5Fvk+YmVsyzNpaRHi+lsOqqdptNagFNY/xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/OqIDmnitS0leyqaukzCX05G9+bWtViisa/j0+C/k9vKmhjO6dMEMutGJDV54d+Zx/dOvKh1DvSA8t6R9e0JHtwV2I3G9+Lx3eF2vWQt6tJiiFYxOxrSn+0WIAn4+yNrKWXOfuk5v7rZl8IvTs0NfQtOVzWW+dEIMT/XyJBrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Dutbwka9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=V85RkQTA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480704;
	bh=RnnK7oFh5Fvk+YmVsyzNpaRHi+lsOqqdptNagFNY/xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dutbwka9BCVj8LoI+jYmsaPLJ39tD1AS8NE9/9ektpCUlURjDKL1gYx3lVkz+BTZF
	 MayCgv16PzhXnimzCOMiAoNapI8N1ogkQ4cjgWkZdaazvNgqfB+nBj/K5lo/+hG39f
	 cMWtvFeH176lRh15NZyURsIHi17ozQqGjQ5DB6KhjxDz82GkBa/EJSXBp3JjIiLHcF
	 QB8aCBCnIxufmC5+iQEYR0XvxlMB+449pLSXmdcXnbvUu2ZuMWaaTo0Ebnzt9cEMe0
	 uL86sEfVw76QHeteuKGFoPbDjss9i6Na4ITxeJzmQFajusvxYzJ4CwlfYHSx5IU3Rw
	 t2TCIE1fOl1Hg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F12903FCEA; Sat, 14 Mar 2026 09:31:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480702;
	bh=RnnK7oFh5Fvk+YmVsyzNpaRHi+lsOqqdptNagFNY/xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V85RkQTAgNgmgcMsPItM2d/XbwKWvKu0E1crEmica+jWrkX0OiOYlXOK1nwNnHVIp
	 nowmRhTL19U6PqS44EeBaP5S6NEwhPrxY6VsiDwJryCGz90gQUnh57Cbh1rpZTE2JK
	 VDCIgrVM/0yQYwIb1vkhOsqK2LJpNgthqt89hmd6ObBUTfeY4CkiMXizdqprHPFaCd
	 4HKamPXqbBj+6hirnWk88zbp2BFvTjwBhX337SFVeQqkRydr9gtPgpP8nlRTIyStMR
	 qboWMUR5BrumtLaVeVuJZE6VDtIUjI5ziNl6Dwhb8TDG+Aay7z6Wb4HPpSvi5YoP9T
	 57WNJ2gCecxJw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5974C3FC9B;
	Sat, 14 Mar 2026 09:31:42 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:37 +0100
Subject: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
In-Reply-To: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267699-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF01B28C6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 uses a different packet descriptor format compared to the
previous generation of chips. Add support for this format by adding a
descriptor format structure into the r8152 structure and corresponding
desc_ops functions which abstract the vlan-tag, tx/rx len and
tx/rx checksum algorithms.

Adapt the previous functions for the first chip generation to support
abstraction and add additional functions for the second generation.

Replace all calls to the descriptor functions with abstracted functions.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 268 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 230 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3b6d4252d34c63ead8f11a120e212325a5f7d505..cefc08fd15c824025ae10426dcf41609687a723e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -743,8 +743,6 @@ enum rtl_register_content {
 #define RTL8152_MAX_TX		4
 #define RTL8152_MAX_RX		10
 #define INTBUFSIZE		2
-#define TX_ALIGN		4
-#define RX_ALIGN		8
 
 #define RTL8152_RX_MAX_PENDING	4096
 #define RTL8152_RXFG_HEADSZ	256
@@ -756,7 +754,6 @@ enum rtl_register_content {
 #define RTL8152_TX_TIMEOUT	(5 * HZ)
 #define mtu_to_size(m)		((m) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 #define size_to_mtu(s)		((s) - VLAN_ETH_HLEN - ETH_FCS_LEN)
-#define rx_reserved_size(x)	(mtu_to_size(x) + sizeof(struct rx_desc) + RX_ALIGN)
 
 /* rtl8152 flags */
 enum rtl8152_flags {
@@ -841,6 +838,40 @@ struct tx_desc {
 #define TX_VLAN_TAG		BIT(16)
 };
 
+struct rx_desc_v2 {
+	__le32 opts1;
+#define RX_LEN_MASK_2			0xfffe0000
+#define rx_v2_get_len(x)		(((x) & RX_LEN_MASK_2) >> 17)
+#define RX_VLAN_TAG_2			BIT(3)
+#define RX_VER_MASK			0x3
+
+	__le32 opts2;
+
+	__le32 opts3;
+#define IPF_2				BIT(26) /* IP checksum fail */
+#define UDPF_2				BIT(25) /* UDP checksum fail */
+#define TCPF_2				BIT(24) /* TCP checksum fail */
+#define RD_IPV6_CS_2			BIT(15)
+#define RD_IPV4_CS_2			BIT(14)
+#define RD_UDP_CS_2			BIT(11)
+#define RD_TCP_CS_2			BIT(10)
+
+	__le32 opts4;
+};
+
+struct tx_desc_v2 {
+	__le32 opts1;
+
+	__le32 opts2;
+#define TCPHO_MAX_2		0x3ffU
+
+	__le32 opts3;
+#define tx_v2_set_len(x)	((x) << 4)
+
+	__le32 opts4;
+#define TX_SIG			(0x15 << 27)
+};
+
 struct r8152;
 
 struct rx_agg {
@@ -914,6 +945,19 @@ struct r8152 {
 		u32 ctap_short_off:1;
 	} ups_info;
 
+	struct desc_info {
+		void (*vlan_tag)(void *desc, struct sk_buff *skb);
+		u8 align;
+		u8 size;
+	} rx_desc, tx_desc;
+
+	struct desc_ops {
+		void (*tx_len)(struct r8152 *tp, void *desc, u32 len);
+		u32 (*rx_len)(struct r8152 *tp, void *desc);
+		u8 (*rx_csum)(struct r8152 *tp, void *desc);
+		int (*tx_csum)(struct r8152 *tp, void *desc, struct sk_buff *skb, u32 len);
+	} desc_ops;
+
 #define RTL_VER_SIZE		32
 
 	struct rtl_fw {
@@ -1201,7 +1245,7 @@ enum tx_csum_stat {
 static const int multicast_filter_limit = 32;
 static unsigned int agg_buf_sz = 16384;
 
-#define RTL_LIMITED_TSO_SIZE	(size_to_mtu(agg_buf_sz) - sizeof(struct tx_desc))
+#define RTL_LIMITED_TSO_SIZE	(size_to_mtu(agg_buf_sz) - tp->tx_desc.size)
 
 /* If register access fails then we block access and issue a reset. If this
  * happens too many times in a row without a successful access then we stop
@@ -2017,14 +2061,14 @@ static void intr_callback(struct urb *urb)
 	}
 }
 
-static inline void *rx_agg_align(void *data)
+static inline void *rx_agg_align(struct r8152 *tp, void *data)
 {
-	return (void *)ALIGN((uintptr_t)data, RX_ALIGN);
+	return (void *)ALIGN((uintptr_t)data, tp->rx_desc.align);
 }
 
-static inline void *tx_agg_align(void *data)
+static inline void *tx_agg_align(struct r8152 *tp, void *data)
 {
-	return (void *)ALIGN((uintptr_t)data, TX_ALIGN);
+	return (void *)ALIGN((uintptr_t)data, tp->tx_desc.align);
 }
 
 static void free_rx_agg(struct r8152 *tp, struct rx_agg *agg)
@@ -2142,9 +2186,9 @@ static int alloc_all_mem(struct r8152 *tp)
 		if (!buf)
 			goto err1;
 
-		if (buf != tx_agg_align(buf)) {
+		if (buf != tx_agg_align(tp, buf)) {
 			kfree(buf);
-			buf = kmalloc_node(agg_buf_sz + TX_ALIGN, GFP_KERNEL,
+			buf = kmalloc_node(agg_buf_sz + tp->tx_desc.align, GFP_KERNEL,
 					   node);
 			if (!buf)
 				goto err1;
@@ -2160,7 +2204,7 @@ static int alloc_all_mem(struct r8152 *tp)
 		tp->tx_info[i].context = tp;
 		tp->tx_info[i].urb = urb;
 		tp->tx_info[i].buffer = buf;
-		tp->tx_info[i].head = tx_agg_align(buf);
+		tp->tx_info[i].head = tx_agg_align(tp, buf);
 
 		list_add_tail(&tp->tx_info[i].list, &tp->tx_free);
 	}
@@ -2247,8 +2291,17 @@ static void r8152_csum_workaround(struct r8152 *tp, struct sk_buff *skb,
 	}
 }
 
-static inline void rtl_tx_vlan_tag(struct tx_desc *desc, struct sk_buff *skb)
+static void r8152_tx_len(struct r8152 *tp, void *tx_desc, u32 len)
+{
+	struct tx_desc *desc = tx_desc;
+
+	desc->opts1 |= cpu_to_le32(len);
+}
+
+static void r8152_tx_vlan_tag(void *d, struct sk_buff *skb)
 {
+	struct tx_desc *desc = d;
+
 	if (skb_vlan_tag_present(skb)) {
 		u32 opts2;
 
@@ -2257,8 +2310,10 @@ static inline void rtl_tx_vlan_tag(struct tx_desc *desc, struct sk_buff *skb)
 	}
 }
 
-static inline void rtl_rx_vlan_tag(struct rx_desc *desc, struct sk_buff *skb)
+static void r8152_rx_vlan_tag(void *d, struct sk_buff *skb)
 {
+	struct rx_desc *desc = d;
+
 	u32 opts2 = le32_to_cpu(desc->opts2);
 
 	if (opts2 & RX_VLAN_TAG)
@@ -2266,9 +2321,10 @@ static inline void rtl_rx_vlan_tag(struct rx_desc *desc, struct sk_buff *skb)
 				       swab16(opts2 & 0xffff));
 }
 
-static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
+static int r8152_tx_csum(struct r8152 *tp, void *d,
 			 struct sk_buff *skb, u32 len)
 {
+	struct rx_desc *desc = d;
 	u32 mss = skb_shinfo(skb)->gso_size;
 	u32 opts1, opts2 = 0;
 	int ret = TX_CSUM_SUCCESS;
@@ -2354,6 +2410,73 @@ static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
 	return ret;
 }
 
+static u32 r8152_rx_len(struct r8152 *tp, void *d)
+{
+	struct rx_desc *desc = d;
+
+	return le32_to_cpu(desc->opts1) & RX_LEN_MASK;
+}
+
+static u32 r8157_rx_len(struct r8152 *tp, void *d)
+{
+	struct rx_desc_v2 *desc = d;
+
+	return rx_v2_get_len(le32_to_cpu(desc->opts1));
+}
+
+static void r8157_rx_vlan_tag(void *desc, struct sk_buff *skb)
+{
+	struct rx_desc_v2 *d = desc;
+	u32 opts1 = le32_to_cpu(d->opts1);
+
+	if (opts1 & RX_VLAN_TAG_2) {
+		u32 opts2 = le32_to_cpu(d->opts2);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+				       swab16((opts2 >> 16) & 0xffff));
+	}
+}
+
+static int r8157_tx_csum(struct r8152 *tp, void *tx_desc, struct sk_buff *skb, u32 len)
+{
+	u32 mss = skb_shinfo(skb)->gso_size;
+
+	if (!mss && skb->ip_summed == CHECKSUM_PARTIAL) {
+		u32 transport_offset = (u32)skb_transport_offset(skb);
+
+		if (transport_offset > TCPHO_MAX_2) {
+			netif_warn(tp, tx_err, tp->netdev,
+				   "Invalid transport offset 0x%x\n",
+				   transport_offset);
+			return TX_CSUM_NONE;
+		}
+	}
+
+	return r8152_tx_csum(tp, tx_desc, skb, len);
+}
+
+static void r8157_tx_len(struct r8152 *tp, void *tx_desc, u32 len)
+{
+	struct tx_desc_v2 *desc = tx_desc;
+
+	desc->opts3 = cpu_to_le32(tx_v2_set_len(len));
+	desc->opts4 = cpu_to_le32(TX_SIG);
+}
+
+static int rtl_tx_csum(struct r8152 *tp, void *desc, struct sk_buff *skb,
+		       u32 len)
+{
+	int ret = TX_CSUM_SUCCESS;
+
+	WARN_ON_ONCE(len > TX_LEN_MAX);
+
+	ret = tp->desc_ops.tx_csum(tp, desc, skb, len);
+	if (!ret)
+		tp->desc_ops.tx_len(tp, desc, len);
+
+	return ret;
+}
+
 static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 {
 	struct sk_buff_head skb_head, *tx_queue = &tp->tx_queue;
@@ -2370,33 +2493,33 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	agg->skb_len = 0;
 	remain = agg_buf_sz;
 
-	while (remain >= ETH_ZLEN + sizeof(struct tx_desc)) {
-		struct tx_desc *tx_desc;
+	while (remain >= ETH_ZLEN + tp->tx_desc.size) {
 		struct sk_buff *skb;
 		unsigned int len;
+		void *tx_desc;
 
 		skb = __skb_dequeue(&skb_head);
 		if (!skb)
 			break;
 
-		len = skb->len + sizeof(*tx_desc);
+		len = skb->len + tp->tx_desc.size;
 
 		if (len > remain) {
 			__skb_queue_head(&skb_head, skb);
 			break;
 		}
 
-		tx_data = tx_agg_align(tx_data);
-		tx_desc = (struct tx_desc *)tx_data;
+		tx_data = tx_agg_align(tp, tx_data);
+		tx_desc = (void *)tx_data;
 
-		if (r8152_tx_csum(tp, tx_desc, skb, skb->len)) {
+		if (rtl_tx_csum(tp, tx_desc, skb, skb->len)) {
 			r8152_csum_workaround(tp, skb, &skb_head);
 			continue;
 		}
 
-		rtl_tx_vlan_tag(tx_desc, skb);
+		tp->tx_desc.vlan_tag(tx_desc, skb);
 
-		tx_data += sizeof(*tx_desc);
+		tx_data += tp->tx_desc.size;
 
 		len = skb->len;
 		if (skb_copy_bits(skb, 0, tx_data, len) < 0) {
@@ -2404,7 +2527,7 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 
 			stats->tx_dropped++;
 			dev_kfree_skb_any(skb);
-			tx_data -= sizeof(*tx_desc);
+			tx_data -= tp->tx_desc.size;
 			continue;
 		}
 
@@ -2414,7 +2537,7 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 
 		dev_kfree_skb_any(skb);
 
-		remain = agg_buf_sz - (int)(tx_agg_align(tx_data) - agg->head);
+		remain = agg_buf_sz - (int)(tx_agg_align(tp, tx_data) - agg->head);
 
 		if (tp->dell_tb_rx_agg_bug)
 			break;
@@ -2452,8 +2575,9 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	return ret;
 }
 
-static u8 r8152_rx_csum(struct r8152 *tp, struct rx_desc *rx_desc)
+static u8 r8152_rx_csum(struct r8152 *tp, void *d)
 {
+	struct rx_desc *rx_desc = d;
 	u8 checksum = CHECKSUM_NONE;
 	u32 opts2, opts3;
 
@@ -2481,6 +2605,30 @@ static u8 r8152_rx_csum(struct r8152 *tp, struct rx_desc *rx_desc)
 	return checksum;
 }
 
+static u8 r8157_rx_csum(struct r8152 *tp, void *desc)
+{
+	struct rx_desc_v2 *d = desc;
+	u8 checksum = CHECKSUM_NONE;
+	u32 opts3;
+
+	if (!(tp->netdev->features & NETIF_F_RXCSUM))
+		goto return_result;
+
+	opts3 = le32_to_cpu(d->opts3);
+
+	if ((opts3 & (RD_IPV4_CS_2 | IPF_2)) == (RD_IPV4_CS_2 | IPF_2)) {
+		checksum = CHECKSUM_NONE;
+	} else if (opts3 & (RD_IPV4_CS_2 | RD_IPV6_CS_2)) {
+		if ((opts3 & (RD_UDP_CS_2 | UDPF_2)) ==  RD_UDP_CS_2)
+			checksum = CHECKSUM_UNNECESSARY;
+		else if ((opts3 & (RD_TCP_CS_2 | TCPF_2)) == RD_TCP_CS_2)
+			checksum = CHECKSUM_UNNECESSARY;
+	}
+
+return_result:
+	return  checksum;
+}
+
 static inline bool rx_count_exceed(struct r8152 *tp)
 {
 	return atomic_read(&tp->rx_count) > RTL8152_MAX_RX;
@@ -2556,10 +2704,10 @@ static int rx_bottom(struct r8152 *tp, int budget)
 	spin_unlock_irqrestore(&tp->rx_lock, flags);
 
 	list_for_each_safe(cursor, next, &rx_queue) {
-		struct rx_desc *rx_desc;
 		struct rx_agg *agg, *agg_free;
 		int len_used = 0;
 		struct urb *urb;
+		void *rx_desc;
 		u8 *rx_data;
 
 		/* A bulk transfer of USB may contain may packets, so the
@@ -2582,7 +2730,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 
 		rx_desc = agg->buffer;
 		rx_data = agg->buffer;
-		len_used += sizeof(struct rx_desc);
+		len_used += tp->rx_desc.size;
 
 		while (urb->actual_length > len_used) {
 			struct net_device *netdev = tp->netdev;
@@ -2593,7 +2741,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 
 			WARN_ON_ONCE(skb_queue_len(&tp->rx_queue) >= 1000);
 
-			pkt_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
+			pkt_len = tp->desc_ops.rx_len(tp, rx_desc);
 			if (pkt_len < ETH_ZLEN)
 				break;
 
@@ -2603,7 +2751,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 
 			pkt_len -= ETH_FCS_LEN;
 			len = pkt_len;
-			rx_data += sizeof(struct rx_desc);
+			rx_data += tp->rx_desc.size;
 
 			if (!agg_free || tp->rx_copybreak > len)
 				use_frags = false;
@@ -2634,8 +2782,8 @@ static int rx_bottom(struct r8152 *tp, int budget)
 				goto find_next_rx;
 			}
 
-			skb->ip_summed = r8152_rx_csum(tp, rx_desc);
-			rtl_rx_vlan_tag(rx_desc, skb);
+			skb->ip_summed = tp->desc_ops.rx_csum(tp, rx_desc);
+			tp->rx_desc.vlan_tag(rx_desc, skb);
 
 			if (use_frags) {
 				if (rx_frag_head_sz) {
@@ -2672,10 +2820,10 @@ static int rx_bottom(struct r8152 *tp, int budget)
 			}
 
 find_next_rx:
-			rx_data = rx_agg_align(rx_data + len + ETH_FCS_LEN);
-			rx_desc = (struct rx_desc *)rx_data;
+			rx_data = rx_agg_align(tp, rx_data + len + ETH_FCS_LEN);
+			rx_desc = rx_data;
 			len_used = agg_offset(agg, rx_data);
-			len_used += sizeof(struct rx_desc);
+			len_used += tp->rx_desc.size;
 		}
 
 		WARN_ON(!agg_free && page_count(agg->page) > 1);
@@ -2918,13 +3066,14 @@ static netdev_features_t
 rtl8152_features_check(struct sk_buff *skb, struct net_device *dev,
 		       netdev_features_t features)
 {
+	struct r8152 *tp = netdev_priv(dev);
 	u32 mss = skb_shinfo(skb)->gso_size;
 	int max_offset = mss ? GTTCPHO_MAX : TCPHO_MAX;
 
 	if ((mss || skb->ip_summed == CHECKSUM_PARTIAL) &&
 	    skb_transport_offset(skb) > max_offset)
 		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
-	else if ((skb->len + sizeof(struct tx_desc)) > agg_buf_sz)
+	else if ((skb->len + tp->tx_desc.size) > agg_buf_sz)
 		features &= ~NETIF_F_GSO_MASK;
 
 	return features;
@@ -3015,7 +3164,7 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 
 static void set_tx_qlen(struct r8152 *tp)
 {
-	tp->tx_qlen = agg_buf_sz / (mtu_to_size(tp->netdev->mtu) + sizeof(struct tx_desc));
+	tp->tx_qlen = agg_buf_sz / (mtu_to_size(tp->netdev->mtu) + tp->tx_desc.size);
 }
 
 static inline u16 rtl8152_get_speed(struct r8152 *tp)
@@ -3248,9 +3397,14 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 	}
 }
 
+static u32 rx_reserved_size(struct r8152 *tp, u32 mtu)
+{
+	return mtu_to_size(mtu) + tp->rx_desc.size + tp->rx_desc.align;
+}
+
 static void r8153_set_rx_early_size(struct r8152 *tp)
 {
-	u32 ocp_data = tp->rx_buf_sz - rx_reserved_size(tp->netdev->mtu);
+	u32 ocp_data = tp->rx_buf_sz - rx_reserved_size(tp, tp->netdev->mtu);
 
 	switch (tp->version) {
 	case RTL_VER_03:
@@ -6603,7 +6757,7 @@ static void rtl8156_change_mtu(struct r8152 *tp)
 	/* TX share fifo free credit full threshold */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, 512 / 64);
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_FULL,
-		       ALIGN(rx_max_size + sizeof(struct tx_desc), 1024) / 16);
+		       ALIGN(rx_max_size + tp->tx_desc.size, 1024) / 16);
 }
 
 static void rtl8156_up(struct r8152 *tp)
@@ -9473,6 +9627,38 @@ static void rtl8153b_unload(struct r8152 *tp)
 	r8153b_power_cut_en(tp, false);
 }
 
+static int r8152_desc_init(struct r8152 *tp)
+{
+	tp->rx_desc.size = sizeof(struct rx_desc);
+	tp->rx_desc.align = 8;
+	tp->rx_desc.vlan_tag = r8152_rx_vlan_tag;
+	tp->desc_ops.rx_csum = r8152_rx_csum;
+	tp->desc_ops.rx_len = r8152_rx_len;
+	tp->tx_desc.size = sizeof(struct tx_desc);
+	tp->tx_desc.align = 4;
+	tp->tx_desc.vlan_tag = r8152_tx_vlan_tag;
+	tp->desc_ops.tx_csum = r8152_tx_csum;
+	tp->desc_ops.tx_len = r8152_tx_len;
+
+	return 0;
+}
+
+static int r8157_desc_init(struct r8152 *tp)
+{
+	tp->rx_desc.size = sizeof(struct rx_desc_v2);
+	tp->rx_desc.align = 16;
+	tp->rx_desc.vlan_tag = r8157_rx_vlan_tag;
+	tp->desc_ops.rx_csum = r8157_rx_csum;
+	tp->desc_ops.rx_len = r8157_rx_len;
+	tp->tx_desc.size = sizeof(struct tx_desc_v2);
+	tp->tx_desc.align = 16;
+	tp->tx_desc.vlan_tag = r8152_tx_vlan_tag;
+	tp->desc_ops.tx_csum = r8157_tx_csum;
+	tp->desc_ops.tx_len = r8157_tx_len;
+
+	return 0;
+}
+
 static int rtl_ops_init(struct r8152 *tp)
 {
 	struct rtl_ops *ops = &tp->rtl_ops;
@@ -9496,6 +9682,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->rx_buf_sz		= 16 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX;
+		r8152_desc_init(tp);
 		break;
 
 	case RTL_VER_03:
@@ -9520,6 +9707,7 @@ static int rtl_ops_init(struct r8152 *tp)
 			tp->rx_buf_sz	= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		r8152_desc_init(tp);
 		break;
 
 	case RTL_VER_08:
@@ -9539,6 +9727,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		r8152_desc_init(tp);
 		break;
 
 	case RTL_VER_11:
@@ -9561,6 +9750,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->change_mtu		= rtl8156_change_mtu;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
+		r8152_desc_init(tp);
 		break;
 
 	case RTL_VER_12:
@@ -9584,6 +9774,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
 		tp->rx_buf_sz		= 48 * 1024;
+		r8152_desc_init(tp);
 		break;
 
 	case RTL_VER_14:
@@ -9602,6 +9793,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
+		r8152_desc_init(tp);
 		break;
 
 	default:

-- 
2.47.3


