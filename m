Return-Path: <netdev+bounces-273670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NwuJPjiy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8E36B651
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 985AA304A8F2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9F401A20;
	Tue, 31 Mar 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9XqX4ig"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D474014BF;
	Tue, 31 Mar 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969351; cv=none; b=hzgU5yY0XvmTVZBUfaNzc0HB9wzwOaaJDcJ1ZUYbLsnvilFAmGUX6XDOFt7mv9+6HQJn+KOiIB69m1+3tHONNxJ35cdmqfRaFKyM7Fl/zG+IXDSlKsgf1hWXXy+Hnu74Pn0/oWF6wD8OQpdlU8KR1ebNzmPXMorRpvL3sy4//og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969351; c=relaxed/simple;
	bh=X8PrLxpZ+jmjF33Q0DKwf3wtH/uAo3H/n+l6f96mISg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phssEa9DiZLMfcYQgKGpz4jjqc4KTwSs21f3yTe5n7kITg7exsHIMXxHapmToVFP2eolwGmhst+wWHJeIytk4R86DM0EyiG0rixJP50dQT04Tyq3oziFUNNO6bIDgas5fFXc8sA5a6ixHxdWg6h2nANgKq57Y2hzastohttwfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9XqX4ig; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969350; x=1806505350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8PrLxpZ+jmjF33Q0DKwf3wtH/uAo3H/n+l6f96mISg=;
  b=f9XqX4ig0tbmeoi6UKgLO0KNUYetMqCpWRV7cx831rerWPfSqRPqQvfN
   Vsr6Uu0Xqtc7Z3jUE1Qp2CCLChkdbZwoQo/wnbRpqjEErpMzQQFig2glo
   1oqKodF+ueGSf+yK/er13T4vh84xGLlIgERezuK6NaXnFSzcm4BUx7l+n
   8r0Jp57z13jrPDyJFVgqwVovhKuLQmvlMHjgZZKz1Ce975SRHC2sqwz0T
   xSMPWgOPaiuojHoywzLpRu/VNs7x/yQJzRrPgaoT2lt3GUe3wxuGgV36w
   RpidWWnxPzR4rJP46tUI3kS6SqlXk9WBQazeLnAfCGBjPe5STZO28y+/x
   Q==;
X-CSE-ConnectionGUID: 1onL1nffTT6sBQ5bcJdDXA==
X-CSE-MsgGUID: 0fytNzYMShSVDDjEesrGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046147"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046147"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:30 -0700
X-CSE-ConnectionGUID: eypYHUfPRQGNtILehxWdVQ==
X-CSE-MsgGUID: p+p7q5ZtSL+cEhH5jqKPag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735574"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 net 04/11] xsk: validate MTU against usable frame size on bind
Date: Tue, 31 Mar 2026 17:02:06 +0200
Message-Id: <20260331150213.550797-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273670-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 90A8E36B651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AF_XDP bind currently accepts zero-copy pool configurations without
verifying that the device MTU fits into the usable frame space provided
by the UMEM chunk.

This becomes a problem since we started to respect tailroom which is
subtracted from chunk_size (among with headroom). 2k chunk size might
not provide enough space for standard 1500 MTU, so let us catch such
settings at bind time. Furthermore, validate whether underlying HW will
be able to satisfy configured MTU wrt XSK's frame size multiplied by
supported Rx buffer chain length (that is exposed via
net_device::xdp_zc_max_segs).

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index d3f087fad551..b55bbc79d3f7 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -10,6 +10,8 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
+#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
+
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
@@ -157,6 +159,9 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
+	u32 needed = netdev->mtu + ETH_PAD_LEN;
+	u32 segs = netdev->xdp_zc_max_segs;
+	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
 	int err = 0;
@@ -178,7 +183,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_SG)
+	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
 
 	if (flags & XDP_USE_NEED_WAKEUP)
@@ -200,8 +205,16 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
+	if (mbuf) {
+		if (segs == 1) {
+			err = -EOPNOTSUPP;
+			goto err_unreg_pool;
+		}
+	} else {
+		segs = 1;
+	}
 	pool->umem->zc = true;
-	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
+	if (needed > xsk_pool_get_rx_frame_size(pool) * segs) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.43.0


