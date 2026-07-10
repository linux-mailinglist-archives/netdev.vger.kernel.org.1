Return-Path: <netdev+bounces-306684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyK2K/xLUWo9CAMAu9opvQ
	(envelope-from <netdev+bounces-306684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AED73DE97
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:46:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JVk6oxba;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306684-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4554301BF69
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98038AC61;
	Fri, 10 Jul 2026 19:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD938AC64;
	Fri, 10 Jul 2026 19:45:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712705; cv=none; b=GIu/fsou8NLZUXitfl7901sW2MXLjGPstS0bq8rSiz8cYkUWeKCksbUduyyjhLG6zjLphJc9zMsWnDVOAFK4DlRqD3cf3XJ3opCvJE/2LR6m/2xOvlqCeVMntVfSvJf+gW8sZy9Xh+dzjYTzduxf6RtCFxkJgBg1DRMSkFty47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712705; c=relaxed/simple;
	bh=T14auuWp4LpZ+GEVrhfVTCOgD1wNpXN0wa4rzRyJ+Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ph5aHZUiGuc8UNJxftxc3Vn3z5RIQMopw6rNmHMYPgFvjEyIq7sbGOennohAWbbLhVhSgmYu827MRBLVjK9WZw/So25/RjOwOzwnJyDD/QDeSOBRWRk7E0eBpfsp6hy0+6haVw1IKEcCNUCAp21AJnF8JpSxKOMpJ7cpep6p6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVk6oxba; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712702; x=1815248702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T14auuWp4LpZ+GEVrhfVTCOgD1wNpXN0wa4rzRyJ+Vs=;
  b=JVk6oxbabmOVsnfhqIUKD8sPeRrGJgvcfJPkHQdCV4VIbh+qf0HlGeZd
   tqcN1I4v3J1eLodGwz3b0dSrTnv2EuB/iILqzhjALSX5fKEDyTBS8a7ca
   5TWTedA/Nsm5cNT1i143/zzd6ATNBL39FfvbSg8LI+YAQfKtisFrBbiOY
   N7TlcbpgiwT+pDuz0aJm358f4gkLMdDEdy129mUhzmi39IswaSfCkrlEq
   SYvQnWfv9NvMKzN4692iKbuDKUBrS4FwWzzdWaU9/P7yCbW+hAHOPm00M
   TOg7agGFVvYdndeLD1v+M931YMrBoU+8kOT2ZvlIIWmpL4ErzfQ3ga2iE
   g==;
X-CSE-ConnectionGUID: 1v0pfAfMQg2BwgUcr8GEEQ==
X-CSE-MsgGUID: EmxYlTFBT5Ooz8HvaHH81g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965213"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965213"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:44:59 -0700
X-CSE-ConnectionGUID: oG/9TzZKRtO6tOr91lKxlQ==
X-CSE-MsgGUID: V7IIfV3OQ5yRXEfgmjcXpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157267"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:44:56 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 2/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Fri, 10 Jul 2026 21:44:21 +0200
Message-Id: <20260710194424.84844-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306684-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,tencent.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:kernelxing@tencent.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12AED73DE97

From: Jason Xing <kernelxing@tencent.com>

Fix generic xmit path multi-buffer logic when packets are either too big
(count of descriptors exceed MAX_SKB_FRAGS) or an invalid descriptor is
included in fragmented packet. Introduce xdp_sock::drain_cont and act
upon this flag - when it is set, keep on consuming descriptors from
AF_XDP Tx ring and put them directly onto Cq. Previously these
descriptors were silently lost and could never be reached again.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # wrapped cq addr submission onto routine
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ebac60a3d8a1..8b51876efbed 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -80,6 +80,7 @@ struct xdp_sock {
 	 * call of __xsk_generic_xmit().
 	 */
 	struct sk_buff *skb;
+	bool drain_cont;
 
 	struct list_head map_list;
 	/* Protects map_list */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a7a83dc4546a..43791647cf18 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -737,6 +737,19 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
+static void xsk_cq_submit_addr_single_locked(struct xsk_buff_pool *pool,
+					     struct xdp_desc *desc)
+{
+	unsigned long flags;
+	u32 idx;
+
+	spin_lock_irqsave(&pool->cq_prod_lock, flags);
+	idx = xskq_get_prod(pool->cq);
+	xskq_prod_write_addr(pool->cq, idx, desc->addr);
+	xskq_prod_submit_n(pool->cq, 1);
+	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
+}
+
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq->cq_cached_prod_lock);
@@ -1063,11 +1076,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
+			xs->tx->invalid_descs++;
+			xskq_cons_release(xs->tx);
+			xs->drain_cont = xp_mb_desc(&desc);
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
 				goto out;
+			if (xp_mb_desc(&desc))
+				xs->drain_cont = true;
 			err = 0;
 			continue;
 		}
@@ -1101,9 +1125,24 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 	if (xskq_has_descs(xs->tx)) {
+		bool reclaim_desc = xs->skb || xs->drain_cont;
+
+		if (reclaim_desc) {
+			err = xsk_cq_reserve_locked(xs->pool);
+			if (err) {
+				err = -EAGAIN;
+				goto out;
+			}
+		}
+
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
+
+		if (reclaim_desc)
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.0


