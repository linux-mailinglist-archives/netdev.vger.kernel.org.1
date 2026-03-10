Return-Path: <netdev+bounces-266336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AlGLi2MsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97D2583B5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CAA9318FCA1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F373EBF36;
	Tue, 10 Mar 2026 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="rqK1drnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D613EAC82
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177773; cv=none; b=UpcMTv+t2oJPSpGaRLpaqXvY29NbKQSM0FtKZGVe0vxH3sjYTQGzYH7u+bQzioNgnt1ROKh75Ajg7k6HU5pEo+ZL5NQM+eUAvzQGkuhVNLDn0bnWFIKdRm1utxtDpAi46kW6HezUwiAaWAACptYp0wQgEntFam7Vqn7pdfphpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177773; c=relaxed/simple;
	bh=IvGII0Yt/19qZKnIYpWtvpz5Dtp/omOYGCRq7UkCRbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMoNKij1h1+hIRxcXDgB7rSwHgRH8Q0oTusChTKS7/0Tv07d+8IRArCF7gmYw1TsBUN3JKbt4xM6h1MpkLlizKPGa/vq4XJne4kqCb6GSB6tKtBWFhkPajUvOsg8rHs3M9yzmSPR/MPy1kfYruPl0T3XcDu/m4L4swyXJmhB5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=rqK1drnd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so88018385ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177769; x=1773782569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgBw4DlbHXB4kGfTTmSAa0HOfHAq4IWmv5ZPrMQMbQQ=;
        b=rqK1drndQjQBW9XCLRKZ+QwP2OHdoTNisYOZTYA0uDK9yGzsn4jFJ2hf58gmqhOLSL
         pLRWtLqstqH6poY6i9xb/EI4CGc4ZkeIkGSbkoDz/1c7T0Vr8noVgjhqXafpzgc4Wu91
         SSabt37VQgz7xoxgRzosO6Pw+/UG2k7FQM6wEkvdsIIHoJsQV5QU07WxVNfsxQZgqU6Q
         B5oMrTt9dyRdiDpG0QELYJXd+12bahpEgv7gFAjEUIczPlRfCYRdSb4uqTnDL4oDhCFD
         3H1ORrw6tNWfaoq1MnJ6kdxsrWIwe18/cfS49lv0EkGz1EEB1WA/t3v2xR+cUsSTKnrm
         Kj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177769; x=1773782569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgBw4DlbHXB4kGfTTmSAa0HOfHAq4IWmv5ZPrMQMbQQ=;
        b=wbVfKsXv9DBuBHv6Tm6z6nRfELlZrrDNe8ypbho/ATZQYAiGVDQqPuLIEj8olj9geK
         V1WdVcTbwD2c8qG1aCK1yuH/DHJdpjRigm8K7Y7jaJiCUyDffgU4wkPXy5dCTMkeIovn
         atc8fiHa9rOEIQgYZJ/vbRJsddxScmucvnwYz8t0mzu+R926TrNeZqacTItvTF6iiaud
         HVdJJnab4d3hzBauhPqj5rS83IZv1tjIlWaz9SM+W38pYzm+9VWzuQMVs5roA3btyGU3
         HzSpHa+Np7tI0M3HQt6w4Oy6852mn8Ach9UrsXoAgjQQozOz+HByNsgif9GU5HD3NI5O
         nMwA==
X-Gm-Message-State: AOJu0YxJ02VWoijKaYA9NxCmn9zIKNhwESahKpunqzIjgN+dmPT+QMMT
	ScYNFpNNbYZgh9/LvPVthqbwvnpMXzVJ7i/jVCeWOHCRMdPnqT/zE/4sivEmDqet/brxrYZWDpC
	5ZPR7dCA=
X-Gm-Gg: ATEYQzzbUFcCfwgz2QJNPrYEddapJ//Cgg6CtOQW0fNdDKB+IuciyXmJ7t9Q1nKwV7h
	f3DZryPcQSh/4Inq0Yq9btF76M4g+hzxqI03ZI29knuxF2EYV+4JFmmYIskQwBsGFN5TcHLKn+c
	5W38K8yxWHUlaoLVlrUTHbx/O0+Cd4zlX97uDrDlBGE8i6to7BvR8V+NGqnsC9t5yu/bNXh7S2L
	+/qiM3QW1sTsa+Ssv245WuvZp7I3Oj43if9baD4QHrBkTqMGJsOWXDe+ZSftpHjSwcFGWv8O9fY
	gGWwCxkOurStAp5A23MsHHHrsoRlAZu1hOibu/g8+7dZMDzDcvQQDjp7wHt5avwwzONqn0w8gCG
	bwEqscxw/98TbYHeWEUTzjaYr6MJUMV4s74f1F/E23eht0fGPMKxCERMcA8q+uKp79HkwEC9e75
	vQwy2h
X-Received: by 2002:a17:903:41d0:b0:2ae:4a74:abdf with SMTP id d9443c01a7336-2aeae767fa3mr2410195ad.9.1773177769437;
        Tue, 10 Mar 2026 14:22:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de20sm1774285ad.60.2026.03.10.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:49 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 04/10] net: bnxt: Add a helper for tx_bd_ext
Date: Tue, 10 Mar 2026 14:21:52 -0700
Message-ID: <20260310212209.2263939-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B97D2583B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

Factor out some code to setup tx_bd_exts into a helper function. This
helper will be used by SW USO implementation in the following commits.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5033aab2d3a6..c52db7135ded 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -664,10 +664,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -694,7 +693,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
-		txbd1->tx_bd_mss = 0;
 	}
 
 	length >>= 9;
@@ -707,9 +705,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flags |= bnxt_lhint_arr[length];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 
-	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
-	txbd1->tx_bd_cfa_action =
-			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 48c91cdf1975..c5dd341e7d95 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2820,6 +2820,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
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


