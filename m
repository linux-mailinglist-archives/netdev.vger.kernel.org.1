Return-Path: <netdev+bounces-269936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBqfCb1dvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F88A2DBFE3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D2E3059358
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE833C9434;
	Fri, 20 Mar 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="lsTw072U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767F3C870B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017721; cv=none; b=U2xa35RpqNP1gMKY163k2crpSHZXJA0oIN3Eb0xH6+YNwajlRXXrWFixR5fksQlcwA+UJnjh2hO3Nbtc69GglvbvnrMs5Ky6cB0PSP/UJ1nxPMn//nw3WdkRSRGepflfwxIXNp8ygHfL7yQh23DbZp0B57xXr6VlBMWnmPD8yT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017721; c=relaxed/simple;
	bh=godTSr6bdicrLv4RTlBef/WCwR5oxIRNe7AE0gxUCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/2Dxhqq5AUW7b0YIGuhf6oKHwovo0KOQ8yGSO+ru5/oZUDyAL3NuwR2+n4vdbbs2livVo9wxkyRrc0q+3IGBX+aioBrv3zLvRw6Iq5pkujuN026vaInD3DKKOjzrM5rVIDykJNCDteenzC/aKU5bD8mIP829hYVg4RTz7eXOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=lsTw072U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04b4974abso19247045ad.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017718; x=1774622518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQm62Y6+YSHQLskIUl4TXD+Tc/f2ddlM4l+yzD6p7gA=;
        b=lsTw072UVGrFIlFgMVdG4e3ip4GrbPp5vFAkqQ2nRwwVvb11lq99p1GpQMiVHbzC1m
         E2qv+JLtkwuaFiVME+b8pStULkSwKRJMjPDXf51gvz7LNrtXs9/VamnBdonapjWwkSFe
         ROtzPqkc3qI7u2txkBaFt0P5lNEKxKHS30J6njPkPI7tSYAaknctNa5TUcvK+/an85s4
         75OLDMr69yQ/mGYay3To1mgqZgGGFOPYCceoe4FD5MqnBP3UYcxnC3Mhw3x/DIMoFcGA
         ZCpUgRvZZb8YUeRIBUPZxmKpV3lKNJNsuu+epIFa8xihPWBG+/eM5p+yHcAI24Bk7Zll
         6y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017718; x=1774622518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQm62Y6+YSHQLskIUl4TXD+Tc/f2ddlM4l+yzD6p7gA=;
        b=jeOAFA8Z30mjdOztyaALtkgkKF+XjkySV6c60QP4MmJy8bTeo+qmxGZouHjsySa2ND
         81DKScYSzTW3DeXw/tKortZ0xErUUSWnqU4iLGw6CLgoN79yHGNrt2pD1OSLnHzxir7v
         UwUyczZrPfan9rx8U9gCdU2tQ+CvcnEWqabLNPEVCfQxdvOFUAB6SkoDKN11os5f9sv/
         kETUngiTGOkUIpRHiM0JxelXAxV6mdiACuWmJoqNJRxtR1XWnoP5wLko+pqNKHbY910X
         9/BzwcQCC69J/sF49esluylo8Eigg8vFCDzPT9S+ToJb/bzr1euGt8y5Fm6JqxCi8Zjg
         cgxA==
X-Gm-Message-State: AOJu0YxZXFgrMdTsqSX2J5CvB4v3KUZKLIy5ORe1YRHDpX6FcGz8b4Ua
	lxVh9lWEVL/X+B248URnCTtWBo8yVqAVZrOgHsnvQxvgNlyd99/GdRpamGj4ApEdp3ag+0s65FI
	4olK9FBk=
X-Gm-Gg: ATEYQzxJqqhAdpfznQPFPmDJk25Qkg1ydyWKtqhuhPUd5hTV9Ofy7iAo4H8igwTlIRA
	VdRCfeyqXcVhkTj5Pf+6s36sm98Nx11TWIRs+L/8Y/jfe2Yw27XX9AmLs2jfU9dbM9Ki0tgouSA
	SD9Uc4DdbtGYGFQ5OQU5AzwGqmjJfpeswqbytqmP2nDrvxnpK01hrdvvMv3ir8RHNHporfFl8e6
	U5PE9CzLvoxUjhucDwEp3rFvEw9n5h5EqjLr7vKpbjaenAJbawmCN3hus+oEA8BtpR+Plt8o2jE
	RpPVlbSa6UetD6R8TAHuHpliufyRoNTv8cjZRl9NUTz5khIzoY2LJDJhu2jXvdSY3tXUWcWkWY6
	OW6W6+GO58sJqA4ELmvJG/oD0+sQX/FAb4AEa/MjGirO9TzR//iV31zmwgYkSOH4EquNTxG5scc
	+vZVr3
X-Received: by 2002:a17:903:2f87:b0:2b0:7ca0:3fe4 with SMTP id d9443c01a7336-2b0827dd702mr30026435ad.43.1774017717849;
        Fri, 20 Mar 2026 07:41:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656df5sm34525935ad.44.2026.03.20.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:41:57 -0700 (PDT)
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
Subject: [net-next v4 04/12] net: bnxt: Add a helper for tx_bd_ext
Date: Fri, 20 Mar 2026 07:41:25 -0700
Message-ID: <20260320144141.260246-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269936-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 8F88A2DBFE3
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


