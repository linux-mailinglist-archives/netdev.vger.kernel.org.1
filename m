Return-Path: <netdev+bounces-270692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPjjG1OUwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:28:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5582FC40E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92626307239C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587A386C2B;
	Mon, 23 Mar 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVXHK1od"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D53ACF1D;
	Mon, 23 Mar 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293921; cv=none; b=ExtvQmxiW6/bOCSLki7L4fYEtZlEK45KOi4hVEc9EnFgYDBJ5Yyhp5y1NuyiudCxWX3l7RZd0qIbbbg7bdkZWowWrgb9lwpGXyDnqA+w8qZPrxwOCpAXUBjhFD7zg6sNLNI6Y1jS8jusacGgt3fkXUw8Gctp4LiwjsS0fDaZyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293921; c=relaxed/simple;
	bh=8CzaosurMRtgB81F/KmyRSFPxwTfxVG34kCryDenqCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtAYEhefNmljk2dfIvsA0EM7vnTY9GXEF6/d8n6+P0cE0rSOFA+FA0gefnHJ2WtIKOt6C75smfMtIBF6K6ZgMT/zb+E/sP4RlebC3PTEr3rnhsLBBz2T1CwqChFBmlqZCkqkhwVSrSnDV0QUHf02jYtY+Xbwz7hnwiViGJUFcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVXHK1od; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293920; x=1805829920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8CzaosurMRtgB81F/KmyRSFPxwTfxVG34kCryDenqCE=;
  b=MVXHK1od87w7X4wvXqceSJ/cawdmS42s/LtCeWLyxNOuhii2wr1IP71n
   2ShHQCUsvah4axWl4ilVEFNrB2Hrpw6IzpHFgZg/73FAACD4R4+ihPAUm
   M3jcEAiLD4ogSI8w9N57LzLKSLHW1jD6kVTg9eAUusDNQGEYKQGSahbw5
   fgWj1IPTWazAi52R67LN4t6Js/DkshYKXdqTSSCl7IWYS7pEOPUrZtO+A
   h/ojJkwvxJuWMWilxwirqm/4yNxMiF+qJmQ9vH0iWKqEYBEcCM1QCCzI9
   Jt7pE35RBL6yNt6tDtYAvIBWxgcqFv0btK2SfjT8ZTKwWjc03QRAKiOYn
   Q==;
X-CSE-ConnectionGUID: N+q8x0FMQ1CgMGXcrWc0Kw==
X-CSE-MsgGUID: V9q+Vi7bQNC3thG0bAZ2Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013327"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:19 -0700
X-CSE-ConnectionGUID: HN1+rJvMSYyxIr55KEVJNw==
X-CSE-MsgGUID: FSrzb/GJRASPX0UCuRwJXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187889"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:16 -0700
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
Subject: [PATCH v3 net 3/8] xsk: fix XDP_UMEM_SG_FLAG issues
Date: Mon, 23 Mar 2026 20:24:52 +0100
Message-Id: <20260323192457.504631-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270692-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DB5582FC40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
to flags so set it in order to preserve mtu check that is supposed to be
done only when no multi-buffer setup is in picture.

Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
get unexpected SG setups for software Tx checksums. Since csum flag is
UAPI, modify value of XDP_UMEM_SG_FLAG.

Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing umem")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock.h  | 2 +-
 net/xdp/xsk_buff_pool.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..95b00b940a3c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,7 +14,7 @@
 #include <linux/mm.h>
 #include <net/sock.h>
 
-#define XDP_UMEM_SG_FLAG (1 << 1)
+#define XDP_UMEM_SG_FLAG (1 << 3)
 
 struct net_device;
 struct xsk_queue;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..729602a3cec0 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,6 +247,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	struct xdp_umem *umem = umem_xs->umem;
 
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
+
+	if (umem->flags & XDP_UMEM_SG_FLAG)
+		flags |= XDP_USE_SG;
+
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
 
-- 
2.43.0


