Return-Path: <netdev+bounces-276734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJlODqff1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB63C4A6A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C443067C86
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAD39FCC4;
	Wed,  8 Apr 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="oC7/0SVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA6351C05
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689579; cv=none; b=J+Rl0FrlYFkRJnjZuiXiXyFsbfpsth3+OGraP4YbQQ/s4eksa+T2JZm4v26c9ifW1GSQqOBlt7bnqvqPQn8CTQVBI4HNogw4GqBo01ITQTQJva3xcecD7trdXvHBrEMOdOpls8yJ6ECZdyu+bBIggJSZgpu5nGRAyqpD/ZjyQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689579; c=relaxed/simple;
	bh=iQ727465s3Aho370Tuxfm2rIvW+aDujPQFCVr+k8Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N47NrM8h/dTr+yPe/HED9mUAPirPB1JoqVfLT3EcaJJNbsQhAIcdnJkKMgd/ZJEpGdBGFl9IDn9txhD6UtwLR71uR7YlCdsaYuU51RCpSNyxxQ5U6BJ6LpplxeEZQ2S+RvyGV7+7nvftqRxSm1w8yrJoLj+PcIKTOK2Kd11jIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=oC7/0SVK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76e702e01aso98698a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689577; x=1776294377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=oC7/0SVKdwYANoxlUzEID2Ps3IGo4jPsKP7rVf0MT3E7ZvFzmHVIaxL9hjCYpEcGMu
         9wKF6N4K2afil2v6nZwdlDf8b9pMutMwBd4LCKEUEW9tRtryughgWcAGosg6M/FneCFC
         j6a3byuyRecGkxJhUpx+CCxBEAiJRMIF+f5aLgx1N+yAZ/f7apAHCVSdu2gsAlahul2t
         87QoIH/qxsIS8pdKsp0oJyMFUel3gXK1RzIHKmNFmut/gCC6ZpbBcIAhyvtOOxVsz90K
         0P2DoX2BpQFOou2zHLQFex2oVLlQVcq2f8vbcRpl7ugXVPZZu9zJNHiJdwSjyOD3wUfA
         2/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689577; x=1776294377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=LFH9+AzyfZjDdVAEosnG+uxK4iJhhPXFGtXNqCBsvltxCZX2DSF5kgVaCihniS9cqU
         BabF6HYzyzBL43bWd/A8EFIIcEisILFbF4PioeLh6i7HL1lD5fph1vuNip8a+LidjZVT
         TDcWiJtG3vdgPKGSL6MXeWTecZw50Mxw+l2FVdXyypEdbnNHGAe46FtH75vfu6xogAG2
         C1rcwrxHv+Zb1knxchD8ysyWvj61fYjmeoocgsep/cOfenF0x7DtxlqObUJSKJBt2M/n
         mnVS4ngqECf/lL03fY8PV2gZdfPgSNPeeLKaF6obAKHLF4ht7HeCXpkgKAQIOsdoMTex
         mpNA==
X-Gm-Message-State: AOJu0Yx/IKya0Yln0osAv6ZZuMgkqE736xrL1Glfg4RaQO2vo3qJ+Um7
	MLYhNsj8MeyVTQZYdhVlDXU7MaW+sd9iYHL5E78l3jFKgnFt6E00VQSZAqXDT7/c5toVJ6ERSwt
	UbcraEDY=
X-Gm-Gg: AeBDievsaVYsFP6vieoKPXBLOExc4tAe+sZgGmhABqGxy2jbbm8RF8+RPkqoYoevaGv
	nnVREvoQ+i46EwHUyL5w30HAx4v0n0Llog1YFQvXDJQfSgxefJeojd/WrnAGdSaJhnPD4fyHC2V
	0ov1nWNGW3i4+dsIwZZ+FJ5/bQjGEOQ0axZu9ddkwwpRTF8XC1gzHOAyTXgTPH3y9I+L+yRRxUo
	w0gNlQ4XfHM5JAu1o5ULTPgOo1QLZ2isFvXyW2W+iHX92ZHNeWfNqh76aEdorLsXJaEM87KBBtZ
	Lhy0dXxHZ2KwBCrmx09hD8BFX/8WvCuM9Jh6LGT/xt8D3N5XlxAUdB8ohQIWzO/XvPfjCbb8SP1
	G1vo06JlIImvBbGjqNMiRRd7UECHHFsUBO/uDmp572t4/q06NoflVZfHH12nw2kSFDXPc3TKQWf
	LD4Nw=
X-Received: by 2002:a05:6a20:1582:b0:39b:81bf:15e9 with SMTP id adf61e73a8af0-39fc836ad66mr1704962637.51.1775689576830;
        Wed, 08 Apr 2026 16:06:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657e5f3sm18819347a12.23.2026.04.08.16.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:16 -0700 (PDT)
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
Subject: [net-next v10 02/10] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Wed,  8 Apr 2026 16:05:51 -0700
Message-ID: <20260408230607.2019402-3-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-276734-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CCBB63C4A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fe8b886ff82e..d4288c458576 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3558a36ece12..2b40a5bd57af 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2969,6 +2969,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0


