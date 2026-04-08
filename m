Return-Path: <netdev+bounces-276735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJA7Itnf1mm4JQgAu9opvQ
	(envelope-from <netdev+bounces-276735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D73C4A98
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B58C730869C2
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090FB37B40E;
	Wed,  8 Apr 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Yu4GHqHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198D3A451E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689580; cv=none; b=Mkr0iQkewE4eiVn/HV9a74C/Ef0T7d6mZh8vSsncG7JjDLe6GDBsi2hGvsIc0hvkEWeyeP9SYECuIP1OoE5j7Y8UaVZJ2bFo1VsB4Qjni2OKwrxJ4AqhLTVCaje8AuRSCeX6aZ/Luf8m0CZYHO0I1/RU4wa9jQfBQxHpa12F9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689580; c=relaxed/simple;
	bh=QNzOKPdiy8cSJfr1mCdxlpDpX0PCIjFpk/12ymL9Mjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzWybe6VzLdAckihHkLLxjFMDfGxfLR1oe4w2OoFHlL1GI7jp/5YCoXM20aHJPFkkrsYoWvPBm+18TxpXn3vehdqPbRLCNYdSlOczLLJ0FIXt0nSXuZ3eJL+ssQYrYGo8ESiUdzdj3qy4q0eIpSZ9vCuRAPDxnhEOSbjTdUK1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Yu4GHqHx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9a9be502so2127005ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689579; x=1776294379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=Yu4GHqHxwec14DKmN/vD3ZDMghhh3b8/fpdhJW3CzVn2/ZZynrjyffrP9qS/qyt6bt
         cCyrxKMTCHlUV4bpGlxoadz7xiA6MQ92YHDlnJ1BrYBEGfC8FBj/I6hLUVlkh7LUx/bM
         IctFAKFeGb6yI3ba9TaSVnf5uP0jnDN288G6lMypytDnLUtoQQ1aBDjkFJJdbpJSC4Cv
         K/DS4qad+nWlnnzCDNvSNyQlZogULfB10/q9KLS38dwGxbRJCxKs4Q63H7bJYiuFrv9A
         YpX03turW7SXUmMXIkkeKfDXRFkrgAsqDmOzcBl23G9dDMMgn/SFxIi5t8hrDgN/DP5x
         /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689579; x=1776294379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=mmbb6plf3syXdc3v9HnoGEcF3DdvnqfDKha6cj3IHN5MiOfE5S/Fz7h6L2vCWAq9qv
         3Z13/YHyUZu40QXeSx7shuZd81KA72eWciqkGWrMSiDVNnWEw0Ky7wlMYCDqBGd0Cx+J
         3G8Cxo1j0XG9wfbuBQItWaVHqdctmD5N5Y+EKVCcw7Db1P/Kykjmquo8rQq/q7rgJ281
         fngsZhw1Mha/KVypAKERCdu9hTC0ODFg/kU20BqLZRp+UyfdMckA6ccXqe6L8LZp3AKJ
         Vf/lwZOKZpXzwPmhg08cha8zLmH4j90Nr3fNga+puwitzWoHDQVizwGJMUJbo5pKN09c
         21gA==
X-Gm-Message-State: AOJu0YwdEAN9jLQ4WgEBJxEcOpWcMTSGS9QaOrt7FDuJZ05euNkylwef
	VV4PQFwU8Q9F+sUfF5PTgDmrgROlJlzwms66Zh8AYPuq1NqZPXHDnMiLny578ffVYcgB5OFB+wr
	6ityIeUo=
X-Gm-Gg: AeBDieuWOCS+oDXoKBevJLr1c16dx/cvAARr5X/qGQ9eNBIEGZa6cUB3v6e2Fl4kWWs
	0f0qJyHYEs1LdShpI/Sx6hqFegQZLZNi5TqjSrsNNuuFTiS64dC2xss2+BFItapiWDx3xBFRWd6
	QnT/6xUB/XpS9gBPTFlM3T6crSpFfVvG6IfTFyA4SjNGoJ2o8cetaN93p0q1Q5pBd3PWZ7kdYq9
	CfL+Mt9mOUT2wmZhBMLiUfWmP7yTE3/ZfmihyWNSCbadmLyfOafIDnQhVBkG+/SEg/G7dc9ez4J
	Pj/NEHL+WSvqcpzxdSX3/cb7f6jl4gvt5TbCHVb3+ZGo1Ab8vq/84SkjVx4axeS+z3pHBEFuUkt
	JD7NYOIY3FH6kriXEAOtv3i6CP93yFmy03lRcsYlEPERirDiKd5/gjkhT78UVSMeEMcoHcviYr0
	ezJtpU
X-Received: by 2002:a17:902:cec3:b0:2b2:42da:25cd with SMTP id d9443c01a7336-2b2c73b7809mr11898445ad.45.1775689578634;
        Wed, 08 Apr 2026 16:06:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2ae05991bsm67534355ad.70.2026.04.08.16.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:18 -0700 (PDT)
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
Subject: [net-next v10 03/10] net: bnxt: Add a helper for tx_bd_ext
Date: Wed,  8 Apr 2026 16:05:52 -0700
Message-ID: <20260408230607.2019402-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276735-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: E37D73C4A98
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


