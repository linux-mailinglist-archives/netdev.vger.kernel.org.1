Return-Path: <netdev+bounces-274797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDShJuoLz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0984038F8CB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90B72304685F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA7265CA6;
	Fri,  3 Apr 2026 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="UhtktxIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BD2417D9
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176555; cv=none; b=L8QyPvhTOroJNhfgJQRBGpx2YyhW8/ZD4ODNlXXgN5Mm/gWirv4wgbu4b/fxIZ3F8cg8sedHrLjWbna45FOx/mnoBSO0HqMuwW+qJlmHQbWaMaMG/Fz0EeFXBFJMHqdbnIjtfvKymFArS7wjmldDWeD16bIKmNGcrY7lkLGgyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176555; c=relaxed/simple;
	bh=QNzOKPdiy8cSJfr1mCdxlpDpX0PCIjFpk/12ymL9Mjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN0r0TQcU9jugMgFjMB86FMKNumP6PSgvDkaXAB0oN3lMyz/eye1/DyyQ0IpNqG977aD8tj3rkFHjvtcn18pgOsqc/ueV3llnhqJ7x0AzWBU0Vr83ceyop8Sr8lQokPX/9EdYzRM8CZVpAfb/lAEuzsOKlBXs7KzgyW78vsTly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UhtktxIc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so853699a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176553; x=1775781353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=UhtktxIcidHzUonYIpKH7SGelZG1COlIHe35zZ+XB9INrYXj+iKMaaQ+p20k1qCA27
         7qTGCJT4UgSqiPGQgSjqy7btQUct2+EfqiqQ7KxvebJfHUvxt2IonWHiyXJkgKyRlAqj
         ynOQc37Z1DBnN9W5bC5HQSBk2icEQ0EXx5uCP2WFi483niEq3jtQwhhfLA196qWWhV23
         V6V6gr27HBJk5kN5HkbK7Zg+7gz7Th0QgKzwgxITNJdNjqMiP6UacQ/b55E2kKwBdcyv
         4Ypo7gODS4QQuAPJ4K+8ZmO82FxkIFoudJMUEpY4Hi/gmpFM6JgQ7K1bQqENr919N9kp
         W9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176553; x=1775781353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zg+/QcI8r5Qwsw6nUEc3qwhDPUQV4lyYXGZbebKcjco=;
        b=lnq3CUtTje/SEjZe1EXzU7Q1bdLfQTfzE9ArITg4lTq485FSmbQftH9/JiQZakbKnC
         cSeZeHyi5efQ3DgVrUDgS+KWrvgTyjw3HrwzlWWVI6oupnWov7X0wYagqUcXSpqFd+sf
         ORmAd7cHuIhxjWKNfxW8q7sNk3D686jNkSjWlnteXVAgAcWh81zUQl/rgtYBJzzMnUXD
         TbF7hLbUUnCTnE7d+YcWDjxMUlA1r+eksqp4poAiT/9o/TG3wy2jhNbiNcSIy8ufl8ZZ
         NXwBYQXwuxR8XvNizC6njZ8aElVbtyZF4m4Naek4zwGexpLc4wfjaxNRYkUZCQOqa7A2
         A1bA==
X-Gm-Message-State: AOJu0YxpUA6LOk/2HN/+gBTn2rngb56G+GP8B348Y62BJ6i5pbMT5/Tq
	nVKEi58htk5Sd1YHPZuuRITcip6w8Xsm1GFMf7mAyx2CIvk7N6QG685vn7WUHHqx3BWu8BHTPIC
	REr0aCtQ=
X-Gm-Gg: AeBDietk3ATvEcs7uVeWuEgRz+i3yw24KN22DpF/WAx5GRcPy9CSP38doBgzVrNpkRp
	PO+PWsOv4JzUlAQJ1ec/5lqgYo8oWs85eFY5yrUMqTT/S/HkFOt8EAOTvXPe0TguBRi2f4joQWS
	5ed9Cq9l7+yX/gLxLF7NcVAhzhYjSSU13buL+/xD2NnFGPCtAOhehf3aHRItZTz9bLy7T5UfpWz
	HB7G229gjNgLJ/u6l38o2bVg+fWP3sjSpGnL79YXGyHRe8FMZs+bbljJxCpPQAi874qMG7OBxRn
	nLL0XUitplDU3ocUSRxKB59Ll2bruS6BLzKKR9WXH/JNLzdrBZF6s3gJvgh1e/HMdPXjXxhXFEi
	6LUc2ZGNUflUxbyHXQ8nG3pktG85IGpJaleY0mRIZ7sAUkx8ThsLW8R7aMIq2WBdsDn+Fg1mEOE
	Gm9m57
X-Received: by 2002:a17:90b:582b:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35de691b308mr725959a91.23.1775176552800;
        Thu, 02 Apr 2026 17:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm8949063a91.0.2026.04.02.17.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:52 -0700 (PDT)
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
Subject: [net-next v8 03/10] net: bnxt: Add a helper for tx_bd_ext
Date: Thu,  2 Apr 2026 17:35:10 -0700
Message-ID: <20260403003524.2564973-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274797-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,dama-to.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 0984038F8CB
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


