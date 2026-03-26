Return-Path: <netdev+bounces-272286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPGFLvLGxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:53:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905133D432
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72B65304C405
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BA3BF696;
	Thu, 26 Mar 2026 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dTOCrYbf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0A3B7747
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569179; cv=none; b=E6tXTQuxbNkD8AfzVIacbMCkUX85gV59Z34G/q7B48u6cDtSntw3EgilkO4QzIWXzNNpNlFUzN7ihaAtNEb4eZcmLGEjyN8ADc9ryhUtlxF0+bp9+kVUFHiL3gB56HFk/WsvpYy3cfVnXpLrvXLHyXQ9NnzoYyO1LfaHc8iGi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569179; c=relaxed/simple;
	bh=Nq5UYxxNFmSt5vepIgZmRBNNU7FqKFEBLG1AqkhZO/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0+JnzOevHfDAqFriYqvMRP69LEBLRy7FFfe/lz+1vxAW7oG4xJflkjttR5bneYGs8WoWI62mw66oxt79BBzltnTRXxwg1CcYgkNWX/60xxuYo2GJD9M2KOOu+2bVhpA5Dg5ySIajtGR7Rqdek+PfuBB8r8DpgLSGAQuFM3jNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dTOCrYbf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0c8362d93so5832555ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569177; x=1775173977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UPYFeaXBCTnwUC9U7Rpioh/CF/owhvrx8QKdsJhO4I=;
        b=dTOCrYbftR9lgorQnL33KUWCP5FCHDi1W8VZFHCROvrdurdRZNI2iozgFC4LkKKhIb
         C0rLC+PLKCk6Doq498p/MH5MDOAt2T0uping+cXVj6sB4sFlgqgF9/Zbs25NQ3Q8nVV/
         8m8SARgYXpdlkS3KRj9eAyKKLnR6m1VcxslVm4azp2yHQscsytK9oxihvHeYpGK+MBjT
         yBdOU/o2NubeLjUVCmFbj0VqRnf9+7uFbNIfxLBgoVFn8SvHgUD947sJpZBV1XpCCSBs
         I28nA84IFeB++AgDA6nqZ0y1XP9jsjj0l8uLyQcT9izgWyU39Fdyb5IPxAstUVMK4Prd
         3Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569177; x=1775173977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UPYFeaXBCTnwUC9U7Rpioh/CF/owhvrx8QKdsJhO4I=;
        b=bACn9JITm08IknVa6psuIBmVWH0pgMtjfsXzZftuQl5q+1jLEQhMQPa8biWfsXnXgo
         L1ss3dDHa/EFMW05asRUFllpCzX06Y2WPFyee3/uSm/YL2VRx5cOHXfkJ4ukmwvDqz2b
         Fgd6+Oz2ExO53ANXCwaAhi/7VotLvGuyK2I7TgIrrek94rpImaFCiJ6BtIJLV7BimA4M
         88OH/Z/Msb7g3TtdeSSdYwgBp453chJaAvoXt2JX4JLlh4FBhPVIuZ8tVeBS5/LKb2JW
         D1q2fLGRIu8Hlf61N7zxQ7ItAK5VK/twtqYVCTR+m0wMy45ih6QSvSldufkriA9eOohQ
         kLWg==
X-Gm-Message-State: AOJu0YzHhS1wwEAwFniWxEl18k8ElfwsYSrOeTHLPP+/4U0+vg0JAtFl
	LWulPvSqLTVPuUoMNIoEMel06dbmNmHYQ1CpKnhPxNYknreqw3V5uNX8OfB3bhaqZmPIqJRzdHT
	BQX7y
X-Gm-Gg: ATEYQzzu5wcYZAB+Lpo9mXzYHwDJJxXkb1fzlQedPebDVHY4BUg0Dal7ybS67uP1qix
	vDFUEEoyL4aNvDkrqSZSNJYEaFjF9UMZeLF9ffIDp1Q2VDoM1MrWyM67i34I0l89U/FGbIA17Ky
	ZBFiRT5fIZcBLK3PEytIkI/QDhPybxIo81GkiZM6p8BZUJz2ef0yR7UGZ76Nzrp4J5QunWWN/+b
	4DfHu2WUrQkR6Bws/6xqot9Zq9ENQLywBdFl3Jfk5X0M1zQL83Wf4wwEFx7uXX70f+w3zOQtYBJ
	CfO8rVndOXPU02d3NQxThtFFCHbsRXgEV1+C56dqw3kxrWu8fJPHl8seY+tm3YShatDCrU1It0Q
	WLcIo1SjJfimHsXv1VQF+HuJqzX6H7A+XVzqZecWkswXucXN3eQW5ewYdztL++FBfNcJ1YcgMrJ
	zT1+Fr
X-Received: by 2002:a17:902:eccb:b0:2ae:5752:af82 with SMTP id d9443c01a7336-2b0cdcf5b8emr4290015ad.49.1774569177241;
        Thu, 26 Mar 2026 16:52:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76736e54e4sm3263806a12.0.2026.03.26.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:52:56 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 04/12] net: bnxt: Add a helper for tx_bd_ext
Date: Thu, 26 Mar 2026 16:52:23 -0700
Message-ID: <20260326235238.2940471-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272286-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9905133D432
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
index dcc83ccc3bb0..8515cd6e82fc 100644
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
index d82b0899b33d..a6b04652600e 100644
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


