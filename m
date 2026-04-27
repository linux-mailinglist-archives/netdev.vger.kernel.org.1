Return-Path: <netdev+bounces-281256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK/AD14b72lx6gAAu9opvQ
	(envelope-from <netdev+bounces-281256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:16:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7227B46EE99
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBE353004D21
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111E398911;
	Mon, 27 Apr 2026 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OERswwMI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6A262FF8
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277787; cv=none; b=FipmaduPhmn9U7xrE1XRbkR1b4O4A1ADpuTSMMMRO2UYUcqJ8GESn0fKFiGxuGxvtpp5SK8dejOq9J/PVjvf/Z5rWE0yX6fniACVxkt7L74CuD5OpPvtyz769/GbQHNatCzOfGXRaMKo5fd9kpRFjYENcjCUjpU5tVaJ1srgyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277787; c=relaxed/simple;
	bh=o5oIxsHlOE/So4MA2kNp+bU8sweic87/7sloyxM2M/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqJhTXM+L++bkwQH7mxmyZLB3tN2cLLllJu0qXq3XF3nvctxev7EgivjhzCWmd+U9x7JytnEk8Hn8+ScHjZN00b5AW/ur2sPKO7ytJHFdwd26axkDMHMg9LWQGff6WNAXk9a+nw7+8Ld/2ZiWrnbgkqBwVNJnIvB07siFOTs2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OERswwMI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277786; x=1808813786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5oIxsHlOE/So4MA2kNp+bU8sweic87/7sloyxM2M/I=;
  b=OERswwMIcuNVyxXJGOy/KYTGoLfnk1yZZCwA4dD8tZgwpjahaYCLdPoK
   Up0iiViDgxg9RkIFM6z0rURRwxc6xN72M/M7dDb4necCfl2G7HE0rmv+D
   M4i+G3p6LEtCibis31y6PGmy6NuumR0aaZxVDm049uK0hES5Jz0gMIUZl
   3LUdf8IfB14IH2UlPirSB3aOdkSwzFKTgIpvPbnu3QxZXBBynpG1gjdv3
   9bWCEai9BaeBArhlfsHVehrbL0G0atrJB3wGDy+KzU75EwupO7H708c2S
   nQkxcG+QMH4n0Fh8h93JwlXUgzXKR9a2ke21vtHj0Ob3npKZlMzvPFNmh
   A==;
X-CSE-ConnectionGUID: jRcgpzdLRsiD7RIOtsPuQw==
X-CSE-MsgGUID: zURJWOFdSqCnveC1pITYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78144169"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78144169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:16:26 -0700
X-CSE-ConnectionGUID: k1lYsXpGR2WSeuqwGPDeDg==
X-CSE-MsgGUID: DwvJx5y4RievsFPTwFcfgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="256880296"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Apr 2026 01:16:24 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 28E7D95; Mon, 27 Apr 2026 10:16:23 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] net: thunderbolt: Call tbnet_stop() upon shutdown
Date: Mon, 27 Apr 2026 10:16:22 +0200
Message-ID: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7227B46EE99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281256-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Stopping the rings is not enough for the core driver. It expected that
the service drivers release them as well. For this reason call
tbnet_stop() if the interface has been brought up upon shutdown.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 7aae5d915a1e..631af237998d 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1417,7 +1417,10 @@ static void tbnet_remove(struct tb_service *svc)
 
 static void tbnet_shutdown(struct tb_service *svc)
 {
-	tbnet_tear_down(tb_service_get_drvdata(svc), true);
+	struct tbnet *net = tb_service_get_drvdata(svc);
+
+	if (netif_running(net->dev))
+		tbnet_stop(net->dev);
 }
 
 static int tbnet_suspend(struct device *dev)
-- 
2.50.1


