Return-Path: <netdev+bounces-269161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BVTINP5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCACF2C1E34
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DEE307A0A7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBD3F2100;
	Wed, 18 Mar 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="bBGLqDd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1BB36AB77
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861225; cv=none; b=JtEN1iEaRTeZHf6WGl3FklQLYNRSYjrMhimzHjmZxaewE4fepmgvgu73Pu3f7kmG2BYg1T/XpopEt8TjTuXltWL2cxrfHMl0EFwX+LM1fejPyhnAJbtJQpPcjWNsgjmQ9IZ0HVXAu92Kkmw5SoMcdjq6auDm6771J4W5aaJumEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861225; c=relaxed/simple;
	bh=PuJu+cuvxYyzLYu/heimivKoS0LlknYg8MItINKiTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ2udhLH9cFnI9hDlAxqqjR5g9IOHdi6O4dUmQjFt/IIRJ6dNli1TgOVOtfkS/T/egBsQmeX4Shte1H1bfYPCXrWXWG0F3H6JQT5nwJVPtN7EtYzTi0RB245SpF/pyoHqBVKoKqQI28Zp57xEVIJucYOGltzHAEFQ6nCH0U2Ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=bBGLqDd0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3591cc98871so156753a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861222; x=1774466022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhpU0qTAGa7ThLCGsekUFVuiiOUf0jdr/bUs5nRSlS8=;
        b=bBGLqDd0Xtz5Qan+N91Z1RBmrw3qsZKthWXUG2UDZiRTY+ysomixJWq/dy8wZlwTH4
         p/h7dGPJ0s+ZyNZMHGLGQFCkSt0SsoFcHXRRYrujXXVpPavMvh+cMx8JH0D10bNpKDpx
         q+KV83N5kbdDgRSS1KYH5Qlmdt1Eu2vLdIXO7o8C5CytbVzyP1x1QQpKyq64RnaDhOer
         HYRaSGdeTR8pf2dbWWbVIi+cT/s3GfIIYPAWxGwZ5S6jH+fHYUvy+ASuaQEMjiOkYcsS
         +JBqUXGP37O8U29eiZjIliFFXCqdBy0C+onmqCbdSJyAKE2XUSx4PaUOTRV6u6N1vedq
         uLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861222; x=1774466022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhpU0qTAGa7ThLCGsekUFVuiiOUf0jdr/bUs5nRSlS8=;
        b=qfv2noDNwpuGHQysx64bDLpo4DaH92IkZ6a7X4HUCFEocD4w7uxuc4rSBoFP3TpGGn
         gKU6W4CAmGMGXCBtrfuOkyQHr9tjKq56c+E4qaxJG/J5040qVwbhESzSoEmg+uF3nRFp
         KE2RfBOW+es/8yeyZgYkGR33sxN0lX8rjngP6YcBiBoEwQbeJTuCRk5w2kz2GeOl94lK
         Co234bKbMTInLUIDI7ky4+kNhY6sntviwov0Ug1xMUI7B9dir22L8CfRipCOhzj7RWcU
         wjBC+p0lczNnL5ZLzVKU2Qmi1yiNljMWJmjh6bWU5ql16eJ+vZnCdL7ADHRwn3tXgPdf
         wyJg==
X-Gm-Message-State: AOJu0YyiKOlrYhjl7AKcId2U76sNC3GB1mtJcj8gN6uO6IgaVVZ2+XO4
	0VhsnSnrGLvTKu8uTn65R06xEu09pRObA9anj8TB020zM1GbOcKLSPw//sv8aFVSl6BUnmXpCUz
	eV4rdW+A=
X-Gm-Gg: ATEYQzxMnka3TQCc/x/q4R/BCklb1KUhp2vCpYKAXLLNNtU7jDZHouO4LDU9G4hM/v2
	ychvJDPOkC4dogToLgb3txZOxLqJO9yqHL43pUhm4PJjh5TLSKhE8xJjBXxAbsfADekgZYv+g9W
	Zffv8LCxzvVgQxjHxFuYADDs0S4Bbrl1RlhAyN33/Yna5sHERjeJiLzw5A2gbfpvg89Nvbjfn/G
	XQ0GYzENhlfqc/bZg4FPCREXHfwvfi1K45OOXIrXxwuq4W/wmwAx1gRqhCNpeXwOqF+9JVpU/Dy
	bVwvANybOzaSxx1rrdyByNKhXIspxmhMNzTBo71RuDoj1KtdnZv7vxZPJxaZCwYi+7HZdIZ5BIx
	GzEX0sVp62DCKkTdeHfAthx0R+NXpKUtAiPeW/pUBkDwwIVd/pn9FqaQB0kGjO0oqZuuzucSEPS
	97cOf6
X-Received: by 2002:a17:90b:3f47:b0:359:9016:1e72 with SMTP id 98e67ed59e1d1-35bb9ef6048mr3939616a91.19.1773861222027;
        Wed, 18 Mar 2026 12:13:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e582fa7sm3062628a12.29.2026.03.18.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:41 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v3 04/12] net: bnxt: Add a helper for tx_bd_ext
Date: Wed, 18 Mar 2026 12:13:09 -0700
Message-ID: <20260318191325.1819881-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269161-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DCACF2C1E34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Factor out some code to setup tx_bd_exts into a helper function. This
helper will be used by SW USO implementation in the following commits.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c9206977fd54..d12e4fcd5063 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -663,10 +663,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag);
 
 	prod = NEXT_TX(prod);
-	txbd1 = (struct tx_bd_ext *)
-		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
+				 cfa_action);
 
-	txbd1->tx_bd_hsize_lflags = lflags;
 	if (skb_is_gso(skb)) {
 		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
 		u32 hdr_len;
@@ -693,7 +692,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
-		txbd1->tx_bd_mss = 0;
 	}
 
 	length >>= 9;
@@ -706,9 +704,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flags |= bnxt_lhint_arr[length];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 
-	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
-	txbd1->tx_bd_cfa_action =
-			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 8147f31967b5..a822bbb71146 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2834,6 +2834,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
 	return bp->tx_ring_size - (used & bp->tx_ring_mask);
 }
 
+static inline struct tx_bd_ext *
+bnxt_init_ext_bd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+		 u16 prod, __le32 lflags, u32 vlan_tag_flags,
+		 u32 cfa_action)
+{
+	struct tx_bd_ext *txbd1;
+
+	txbd1 = (struct tx_bd_ext *)
+		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1->tx_bd_hsize_lflags = lflags;
+	txbd1->tx_bd_mss = 0;
+	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
+	txbd1->tx_bd_cfa_action =
+		cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
+
+	return txbd1;
+}
+
 static inline void bnxt_writeq(struct bnxt *bp, u64 val,
 			       volatile void __iomem *addr)
 {
-- 
2.52.0


