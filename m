Return-Path: <netdev+bounces-251209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07FD3B505
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390633005FE3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E03246782;
	Mon, 19 Jan 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="myG8Q4cr"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB32329C4D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845568; cv=none; b=PLwDdAXGmf1lEHrIFBh/svobww8AYDIv1QuWc1Z0+7xCDTPHRUT75LWfnGBM8NCjxLgzsDpPibaSUqKyUXHy85avvg0EQ6ky29gl+Q+aH6Ioc0DtuQH0v73Q9bxuOr7jCiDkl4J1FVI41+MEwcUisRhyTLK/FeISRvaWMHeEPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845568; c=relaxed/simple;
	bh=fqnBmmKNJnxT27ie1o//zlHYXwovFi430BqGDVGM48w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4jQqErVz9KUtfqjWOVCDTNIxnj/LXX5e1Ob78g/KmzJ+5Ht8D+PHBwhRu56Dlkxa/6NGiuNOCo6xsSCP3kv9TX+E3vxYxfMzqVSjYbwxrv9xe4ET0bvAZDDoZWLqizolVWsSc8cparD90cyj7q+8bMD4Y/FBRpXzzPXqXS1/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=myG8Q4cr; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60JHxOXB045334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 20 Jan 2026 02:59:24 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=eWDwRtRTexg9fRSSarLkYLweDMl64Lud9EANHQPjlRk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1768845564; v=1;
        b=myG8Q4crrYCXilnOST2tC5ZSmZEUJqmEVxjKqKr+hL5ADzEMQGC/BrqU+S0D3JsS
         ElfcLK++qAN1hwQqv7Hk9Tdw3cOkzoMqfuySBauxZxTnMOYdOY/0tfS7d+vz0KOD
         vbK5UQvC4ZShEgAvymWqtDvL2Ly/+9Iq3l+hupQGhhG8cfFJcX90E23sgsno3KRG
         dpTUXQbCLYPLLsmHHt57zio+NP6Pib+4/ITtSLLlkOst92vqUCuICQuGgvu2GaaC
         /OfMnpQ5mWL6VoTMS+vdGXATZnJqFAYolowLdlWdEX5vsq+PBSZ1GOc/OHoVrX5K
         wULvXCyzdo0YBJUpZnLUdA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Takashi Kozu <takkozu@amazon.com>, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-next] igb: set skb hash type from RSS_TYPE
Date: Mon, 19 Jan 2026 17:58:27 +0000
Message-ID: <20260119175922.199950-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igb always marks the RX hash as L3 regardless of RSS_TYPE in the
advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
trigger unnecessary SW hash recalculation and breaks toeplitz selftests.

Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*

Tested by toeplitz.py with the igb RSS key get/set patches applied as
they are required for toeplitz.py (see Link below).
 # ethtool -N $DEV rx-flow-hash udp4 sdfn
 # ethtool -N $DEV rx-flow-hash udp6 sdfn
 # python toeplitz.py | grep -E "^# Totals"

Without patch:
 # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0

With patch:
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-takkozu@amazon.com/
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
If a Fixes tag is needed, it would be Fixes: 42bdf083fe70 ("net: igb
calls skb_set_hash").

I'm not sure this qualifies as a fix, since the RX hash marking has been
wrong for a long time without reported issues. So I'm leaning toward
omitting Fixes.
---
 drivers/net/ethernet/intel/igb/e1000_82575.h | 21 ++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 63ec253ac788..a855bc10f5d4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
+#define E1000_RSS_TYPE_NO_HASH		 0
+#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
+#define E1000_RSS_TYPE_HASH_IPV4	 2
+#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
+#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
+#define E1000_RSS_TYPE_HASH_IPV6	 5
+#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
+#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
+#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
+#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
+
+#define E1000_RSS_TYPE_MASK		GENMASK(3, 0) /* 4-bits (3:0) = mask 0x0F */
+
+#define E1000_RSS_L4_TYPES_MASK	\
+	(BIT(E1000_RSS_TYPE_HASH_TCP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6_EX)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6_EX))
+
 #define E1000_RXDADV_HDRBUFLEN_MASK      0x7FE0
 #define E1000_RXDADV_HDRBUFLEN_SHIFT     5
 #define E1000_RXDADV_STAT_TS             0x10000 /* Pkt was time stamped */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8dab133296ca..ef0cbf532716 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8824,10 +8824,20 @@ static inline void igb_rx_hash(struct igb_ring *ring,
 			       union e1000_adv_rx_desc *rx_desc,
 			       struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb,
-			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+	u16 rss_type;
+
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.pkt_info) &
+		   E1000_RSS_TYPE_MASK;
+
+	if (!rss_type)
+		return;
+
+	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
+		     (E1000_RSS_L4_TYPES_MASK & BIT(rss_type)) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
 }
 
 /**
-- 
2.51.0


