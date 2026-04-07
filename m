Return-Path: <netdev+bounces-276189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMR0FX9/1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C83B532D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D675E305CDBA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B933803EA;
	Tue,  7 Apr 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="bRkpStui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BB37FF57
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599411; cv=none; b=VX9xWOrZEOmCV41EFiH0SXqjCmojHnDRk3tiakzecjRwOyfOOAnkd42b+n0SJyzhbgoPx4S0KIowkXrOeJ/l7A2YztuV7QQNUnRSrNpmH9Zfi55L2v1w+wPkCikwT8S8g78td8lFAijtmvh3EjqlzSW4w8LDyjgakhst6tDQrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599411; c=relaxed/simple;
	bh=QNzOKPdiy8cSJfr1mCdxlpDpX0PCIjFpk/12ymL9Mjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prT2iTKCPj3qTQpnXchyrH9FokqFLxoAN89VcGzej49tUj26dk2V+vR06iufVtJsBDPT6Y9j1gzXJh2GhKaTsvFKfcai/YLbz+bUIIIq/hVfRtjQH/9NWyAq0DT+xAtyxEN8lXKsI8VzfR4HEn7cbDyNg375INhDI1Gd65wVQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bRkpStui; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so3186411a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599409; x=1776204209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=bRkpStuipj5keikD7FmBOUNoW0RhKV9wJBw8DwrMcsi7keymgVLWC9ctbOyekjGTYs
         DWERBBDaXxoPokE+3H1RurOHsdnGN/hTb6k3wIozIU/wol9DI81TiuX+JLtHLGlXRCBs
         K5oNz9YMLTCXIic2TchL3G24eenLQY7rAz7k6vkNl4CdN4gWMY84kv487pzC1uH0ZefQ
         Oy1wBkT85NvW7G2AtK6yYKa5oPvYiy4enA8SjK5YMUM1/MJUcZ1XBGjH+M8k4x9w2T30
         YdU7ON0HQyA2NlOsPozFcrjlDYOnmB5occam7Oe32chdo6G8nFtZEzAQYQtSA0akG9om
         M90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599409; x=1776204209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=XNhJNZSC4MndTqklfodLhA1aq7lFl+eWM9v40h1eArxqEBtz1pulAhjgKAH5XeKqPP
         q+Qml5wtn1Vb+ti+hw2U+545yedLFNet85t0BHNtGOq4qdAzIJZ7rLxtb6uY1bUhn3R3
         1gmay+n25t0ZB/ewkWEj1/QMebuRrYQB5sjgn/dfodtY/aoEaLIPyMvXMW7QdTcqF2Wd
         yrr+IT9cvmXdwCKwiOV2jxwS9yCQLUlgnzxUV97eU+cRJe41+Fa7qaB0kt5w53fcY1hE
         YIngWnGnXkKVHFBvJ9C3SaT7aPS6pLbPld1wEEbYv6FGLbdGhkPINDubdnwzhiLxgalb
         Yrbw==
X-Gm-Message-State: AOJu0Yy8AmwYkUGTn2z7DwOGJ1cD+5WcqG2sQLRBmmU4rIwbkfPbcZAY
	hl8FTfaUTLTGGsC5cbOpaErXeIPkeMwEqrqQJZZ8/kQya5VmhxDrQzS1fMk2dfv0YOqv64C8ywG
	l9aic
X-Gm-Gg: AeBDieuhBQ6asHQ82wOiDGpbVlL7xbVGYBt6cUfrA1RQBasvV8PqmZsSISaCApoBLCC
	YfsBhO9wao5MURSPYisKlbqUkDo0bLDRpr1VAh5lumUap5pY3Z1vEpsoM6GED2IDURNLIRnfzVd
	BvumonXRS2D739B9BrLKdgtRrdrSWmFBzUYYu6Bm5MBOpaFA9hEaN87UTOeKkW1/OAzPWhfJuLQ
	FmtJkJTwNfMfBr99zeOKIAPijsHidNSkkip2v5EH6NvXnLiEwULVgcojHULZqrbbGB4ERWGM4+9
	g7KgOrp3F0h5mLT7nPd3bQVxJGEg0w2wM2AjG9vDLTj2icP/qukcpderB67NYhbXeHIyPgik8xt
	eZyux1nuB2wZiiqt67PjdAXEaVNrirKzbvZ6VCxxga6HBrlwHLuDJ/2b1GPShlvs3JXKJ7QReiw
	Br1oT9
X-Received: by 2002:a17:903:fa6:b0:2b0:673a:7c90 with SMTP id d9443c01a7336-2b28176a3dbmr200029855ad.28.1775599408982;
        Tue, 07 Apr 2026 15:03:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27473583dsm182385395ad.9.2026.04.07.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:28 -0700 (PDT)
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
Subject: [net-next v9 03/10] net: bnxt: Add a helper for tx_bd_ext
Date: Tue,  7 Apr 2026 15:02:59 -0700
Message-ID: <20260407220313.3990909-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276189-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid,dama-to.20251104.gappssmtp.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: BE7C83B532D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Factor out some code to setup tx_bd_exts into a helper function. This
helper will be used by SW USO implementation in the following commits.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d4288c458576..d1f0969b781c 100644
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
index 2b40a5bd57af..83b4136ccd31 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2836,6 +2836,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
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


