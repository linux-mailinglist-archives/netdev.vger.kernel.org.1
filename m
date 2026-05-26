Return-Path: <netdev+bounces-291777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKhsOJXEFWoAagcAu9opvQ
	(envelope-from <netdev+bounces-291777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:04:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72A5D9456
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAC4307B248
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10043932C0;
	Tue, 26 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoRjyv2k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92D3932DC;
	Tue, 26 May 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811054; cv=none; b=L9FQggPAAYJhUCfrfB1iwMf2jbIqSv3FNsH0850hyVfHPbJXkMuu5Sgipb5OoO29+lVNj66uFnOCs8UWAUEyCISZ38I6jLFn6kh4q7BbvDPwONcurhEgu1cqtYRTQNMW36QSU2o5hoXxDIB6U76YibRZXiitO3/sCw9giVPdtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811054; c=relaxed/simple;
	bh=7BUnKQlQnsSRu76MaXbERMZocERHqHq+PaCl/0/8YWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkvIVhFNjklES3d0JJsbXQnM7va+iVwTAkMuDkvQ0pwMxfTQSqHzvwJKKeWBTNASikAkakerElOMHaji9e/8eO/N8q65J7QUTBnpckP0pl1iD1jO5JZNv7u5esVltCsOkppcKId8AbF0Lz9z88BqJ7nEbXyKWC8+vWplYHBz3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoRjyv2k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77871F000E9;
	Tue, 26 May 2026 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811053;
	bh=GnLT08qG5QSAn28bNc5BTlLJ/q7kSOQ3CElbUNqFIlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AoRjyv2kuRklJ8YQ4HDwUfMtfZm+kxvDlqWu2M4B4mgLEjB7KVl9FcLHiEKTJrG1p
	 OPAZ6PGRbd/Yrxm6QDBI53Joiilp9+v5T1ElbJ3FS16mVyKC4M5IuuWnB99kgkgUW7
	 ux+ftXWxNb4uVO8RJ4/UDPqvH3RBhXRNCSEikE5WQadc5QexCBsFwdLufUbJfEWboR
	 Bff9aH8PyS0iVGAymB4z8QnOaBh2MHddvrAqzuYnVoUwT+gU+DSq1XGvNIG90iyPJs
	 grhR3HrsTlLiDWufZ1ppFUMBU5l5B1Rw+shJlQZmneBgzBV+efl3MDmNDh8T89gnfs
	 wP+GTAp0g0DSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	linux-doc@vger.kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] docs: page_pool: drop the mention of the legacy stats API
Date: Tue, 26 May 2026 08:57:21 -0700
Message-ID: <20260526155722.2790742-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C72A5D9456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Netlink support for querying page pool stats has been
proven out in production, let's remove the mention of the
helper meant for dumping page pool stats into ethtool -S
from the docs.

Call out in the kdoc that this API is deprecated.
Some drivers may not be able to use the Netlink API
(if page pool is shared across netdevs). So the old API
is not _completely_ dead. But we shouldn't advertise it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/page_pool.rst | 46 +++++++-------------------
 net/core/page_pool.c                   |  3 ++
 2 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 5409c68be3fc..817f8b78d246 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -43,8 +43,17 @@ Architecture overview
 
 Monitoring
 ==========
-Information about page pools on the system can be accessed via the netdev
-genetlink family (see Documentation/netlink/specs/netdev.yaml).
+Information about allocated page pools, their memory use, recycling statistics
+etc. can be accessed via the netdev genetlink family
+(see Documentation/netlink/specs/netdev.yaml).
+
+Statistics
+----------
+
+.. kernel-doc:: include/net/page_pool/types.h
+   :identifiers: struct page_pool_recycle_stats
+		 struct page_pool_alloc_stats
+		 struct page_pool_stats
 
 API interface
 =============
@@ -74,7 +83,7 @@ that NAPI context, the page pool may safely access consumer-side resources
 		 page_pool_get_dma_addr page_pool_get_dma_dir
 
 .. kernel-doc:: net/core/page_pool.c
-   :identifiers: page_pool_put_page_bulk page_pool_get_stats
+   :identifiers: page_pool_put_page_bulk
 
 DMA sync
 --------
@@ -109,22 +118,6 @@ Unless the driver author really understands page pool internals
 it's recommended to always use ``offset = 0``, ``max_len = PAGE_SIZE``
 with fragmented page pools.
 
-Stats API and structures
-------------------------
-If the kernel is configured with ``CONFIG_PAGE_POOL_STATS=y``, the API
-page_pool_get_stats() and structures described below are available.
-It takes a  pointer to a ``struct page_pool`` and a pointer to a struct
-page_pool_stats allocated by the caller.
-
-Older drivers expose page pool statistics via ethtool or debugfs.
-The same statistics are accessible via the netlink netdev family
-in a driver-independent fashion.
-
-.. kernel-doc:: include/net/page_pool/types.h
-   :identifiers: struct page_pool_recycle_stats
-		 struct page_pool_alloc_stats
-		 struct page_pool_stats
-
 Coding examples
 ===============
 
@@ -178,21 +171,6 @@ NAPI poller
         }
     }
 
-Stats
------
-
-.. code-block:: c
-
-	#ifdef CONFIG_PAGE_POOL_STATS
-	/* retrieve stats */
-	struct page_pool_stats stats = { 0 };
-	if (page_pool_get_stats(page_pool, &stats)) {
-		/* perhaps the driver reports statistics with ethool */
-		ethtool_print_allocation_stats(&stats.alloc_stats);
-		ethtool_print_recycle_stats(&stats.recycle_stats);
-	}
-	#endif
-
 Driver unload
 -------------
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6e576dec80db..9a87062134d4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -76,6 +76,9 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
  * @pool:	pool from which page was allocated
  * @stats:	struct page_pool_stats to fill in
  *
+ * Deprecated driver API for querying stats. Page pool stats can be queried
+ * via netdev Netlink.
+ *
  * Retrieve statistics about the page_pool. This API is only available
  * if the kernel has been configured with ``CONFIG_PAGE_POOL_STATS=y``.
  * A pointer to a caller allocated struct page_pool_stats structure
-- 
2.54.0


