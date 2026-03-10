Return-Path: <netdev+bounces-266156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JspIa8psGn/ggIAu9opvQ
	(envelope-from <netdev+bounces-266156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF2251DDD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3A733AB10C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437EF40DFBE;
	Tue, 10 Mar 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWCE5Qzi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEC40DFB1;
	Tue, 10 Mar 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149439; cv=none; b=DIvGy6y8IRV5bZ/7A5BKBOZ6hhoHaEUQnllkv6uLNvzcm/eyC4VCGgP1bZUr4PMf6Nj0r+Smk4BK1KomxgdvnErG/jMNDy9iMi9WtnMRDzUCiYFcSI5sYIiLzyx28F7ij5BY8zRMQqGC0EJD39daln9zIupJvruoPWKXB2s9Lp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149439; c=relaxed/simple;
	bh=wAgP81tiv/PiHJTcio8XQe8G4vn0BUIrqqgy6i4uR1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqjcF4wJEuzEwSKgbizW/hl1eobB/2pl2HrU21WWtus0EoXLR3GDfITzvdLXEYSnpkUECh+2L2umyQ8BoxTmLEJlN1H5FYAzqXf36x6w6ouRR4GXUpzgNjXLTqHcYuIC0reLh5XC6CVX/8Sbbhck/qqgDW/LQnZEpxojUsSTMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWCE5Qzi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773149438; x=1804685438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAgP81tiv/PiHJTcio8XQe8G4vn0BUIrqqgy6i4uR1s=;
  b=KWCE5QziscbMqgp3EelpXgRaNPkvxKFD0CrmtYdLAsWeDDgXGpUpxiYE
   l/NWZi/BtY9efoq1BSSPM4q2rWP1eLti4vXYy18RO1ngs7sS/6mu+rk5z
   YU4q0EId+U+hWfOCbWQzaxpN0zxmx5W36185OMJ97OJ1xsmJgxYQqD3+h
   6YwoqzceNsaw8zqn8fi/jCt9PnzVwPPc7i6IR5hVVjQ6BVI6c+vSM/Grc
   9GeUOpnBzFPMpworm8kFqROHGvesNqyPDc/APhjMUqYZoUPKXa+TfVBmo
   pa0hlcxwQeuMEBHikRYfkqUIWlYk8Z5wk+EN5IyaRzD0UsFCZOgG00E9i
   w==;
X-CSE-ConnectionGUID: yYKDTaKCQgKHoOnaaSJcTw==
X-CSE-MsgGUID: u2P3LZ6RRrOFxMaWwZO0XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74311728"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74311728"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:30:37 -0700
X-CSE-ConnectionGUID: cKapl1+/RIuazSXqacHlJw==
X-CSE-MsgGUID: xg+1VjlpT4arHJpsmBy1nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219352083"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 10 Mar 2026 06:30:36 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing
Date: Tue, 10 Mar 2026 14:30:24 +0100
Message-Id: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAEF2251DDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266156-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Commit f620af11c27b ("xsk: avoid double checking against rx queue being
full") addressed a case in copy mode, when working with multi-buffer
xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
there is a space to produce descriptors.

Adjust ZC path to follow the same principle.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ef265e45810c..cdf93728fcba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -196,13 +196,13 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		goto err;
 	}
 
-	__xsk_rcv_zc(xs, xskb, len, contd);
+	__xsk_rcv_zc_safe(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		__xsk_rcv_zc(xs, pos, len, contd);
+		__xsk_rcv_zc_safe(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
-- 
2.43.0


