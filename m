Return-Path: <netdev+bounces-303832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qmKON7eBRWpYBQsAu9opvQ
	(envelope-from <netdev+bounces-303832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E06F1BFD
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="aQKXeQ/k";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303832-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1D1313AF03
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E813B3C18;
	Wed,  1 Jul 2026 21:03:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24E3AEF3B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939794; cv=none; b=WpZZcz/OG9sKJ943UwAyNCYtYeT5IU92fjPSvxre8yJm63q0Ys1ueBqrpPmM2s1wW2ZdlYsZotwGqwC9a8qGAUFRk/dijUAyjkqNfYNX2wUMcyVjjGAPI6LvBGc9ODqWXN96E2B3aj3JE7YQEIA509iJOau21I2+FG7ANjJodgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939794; c=relaxed/simple;
	bh=zhW/Hy1C31k/FPGGYk5y5DXgtGtanlTGErcBuXQZsGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJZmgxCWGRgDH+RIqHxptnSWRVbkfldhIqHJKqpS0Z9QanxFkVH1kWkMNDlEysEJLpdY+HzUtl0nzwZMm6j/g4xoqhLeHljdnXbwUH0n7PsHMJf3g4ktP31mvMbsiyOVxKRGaDYH4f8lUzKxeO25DTs1BHcATzVdzfb7SQWNaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQKXeQ/k; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939793; x=1814475793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhW/Hy1C31k/FPGGYk5y5DXgtGtanlTGErcBuXQZsGk=;
  b=aQKXeQ/kdNuU8CKZkqxFQby9MFsUVjhvGRYuJ+kmaQHHadGvgdTX7dlP
   fW1IDgNdGy762vc9YjcaMba2D1diyg/7S6c9zgoUR1bFcXLBtftC449Im
   IkEQPrPC4ZR3zZsju8n1phcwzeRQ7kpfRGKrBTLQncEYiqXw1pal7O7SE
   1HujpL6lwyruFezbmvyjK6Iw+aGIUVS86QK1/dc8MQ8+rCl+TQgx6aFe0
   AnAJDBG20nlSiZSRzALzXtbnnSlP3jV5So3XL+6/NRCyBJvGmIQ7DFmJk
   V9oTdhldWcLy99f6tIoWbEPzN+QYBUAOkQYXCuh0DvCZHAluxOnkjup1N
   Q==;
X-CSE-ConnectionGUID: bpjg8YrcTJKC7GL72bHQOw==
X-CSE-MsgGUID: maLdE45PT9eXN5aRq9SuWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069122"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069122"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:12 -0700
X-CSE-ConnectionGUID: kQl4JCXxTmycduT+aF6IZA==
X-CSE-MsgGUID: 67Fw7YDzQpC2pzdwMIZjGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561418"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Takashi Kozu <takkozu@amazon.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	enjuk@amazon.com,
	kohei.enju@gmail.com,
	Kohei Enju <kohei@enjuk.jp>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 06/11] igb: allow configuring RSS key via ethtool set_rxfh
Date: Wed,  1 Jul 2026 14:02:55 -0700
Message-ID: <20260701210303.1745310-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303832-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:takkozu@amazon.com,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:enjuk@amazon.com,m:kohei.enju@gmail.com,m:kohei@enjuk.jp,m:sx.rinitha@intel.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amazon.com,intel.com,kernel.org,gmail.com,enjuk.jp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,enjuk.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C0E06F1BFD

From: Takashi Kozu <takkozu@amazon.com>

Change igb_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
E1000 registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
Tested-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 48 +++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 47fc620026a9..65014a54a6d1 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3357,35 +3357,39 @@ static int igb_set_rxfh(struct net_device *netdev,
 	u32 num_queues;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	switch (hw->mac.type) {
-	case e1000_82576:
-		/* 82576 supports 2 RSS queues for SR-IOV */
-		if (adapter->vfs_allocated_count)
-			num_queues = 2;
-		break;
-	default:
-		break;
-	}
+		switch (hw->mac.type) {
+		case e1000_82576:
+			/* 82576 supports 2 RSS queues for SR-IOV */
+			if (adapter->vfs_allocated_count)
+				num_queues = 2;
+			break;
+		default:
+			break;
+		}
 
-	/* Verify user input. */
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
 
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
+
+		igb_write_rss_indir_tbl(adapter);
+	}
 
-	igb_write_rss_indir_tbl(adapter);
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igb_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.47.1


