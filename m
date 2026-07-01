Return-Path: <netdev+bounces-303831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bx2KBrSBRWpWBQsAu9opvQ
	(envelope-from <netdev+bounces-303831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF476F1BF7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:08:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HC8ZC6IQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303831-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303831-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C598E31381FB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE023B2FCC;
	Wed,  1 Jul 2026 21:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CED3AC0CC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939794; cv=none; b=XXn+QzLjcZtojjjEG64QOVL+smS4o166nLVztES2H2d+gyraGJhwsu7WVDwIOPKi62fQ99OYl69iMvXr8zkqefiNH9vXgIs6GyC8inYBQtOacBx/sNN/VQ0OST6ll2lgZIWsM0BOqYSdGyaoFWBSoHQijHfth+tWZwHDoEoMGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939794; c=relaxed/simple;
	bh=hVZa4sKrgm+8IkgpermvUSLuaWbWtlJxQXviPpT3uQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MahP74/6x+GxnyhS3hxXWJslUUy99bYtA/3BDv99fJC0U0/88hTI4/oPyZcO22A2utcLp6qWV+jMvK3QfQGK59JUNnyD2tSwdAKU7Nc0FJK98Coo5tM27HWrcNFFAXwgKNe33K1sVPqruyIiMcVmbNb7xJhknj8gVENky4qVyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HC8ZC6IQ; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939793; x=1814475793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVZa4sKrgm+8IkgpermvUSLuaWbWtlJxQXviPpT3uQc=;
  b=HC8ZC6IQoco922rTTqm00H3HWxuA+khJ/030HEseIfcWyKOeQW27GUJb
   t6vA6chEAMqdZvRj8nzQzaAiaYqHDpr879v12dtaBlvEeeT8H4NKadexO
   hRrCiA/QPYnUS2JQSJRPzD7jJA0gZmmWI1ds8cmIrn7U49TdNy4W52MYQ
   8ewAMAMgs77gv85DS1hY7mnoREwMXuU9QRz2PGrdvLd69/xt+OT689MLZ
   Cvi1RaY0Fhd+dMR7o6wDNRwL5UpYCVTQ5/Z+n+L70FbdpMZ/d58NJXSHX
   mn+vr6qxZrSoPaLvISypfVYHBYXU9nToyxdVW8FJhsaqkPFL98bCzL59Y
   A==;
X-CSE-ConnectionGUID: WW2c1QjpQwSkcCMTf6sAnQ==
X-CSE-MsgGUID: qi874qZwSdyASzAzLBM+aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069112"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:11 -0700
X-CSE-ConnectionGUID: 2Yk0uUnvRqqqvVYyWI1FbQ==
X-CSE-MsgGUID: IKupehCcS0iAPHKy8UIwUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561413"
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 05/11] igb: expose RSS key via ethtool get_rxfh
Date: Wed,  1 Jul 2026 14:02:54 -0700
Message-ID: <20260701210303.1745310-6-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-303831-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:takkozu@amazon.com,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:enjuk@amazon.com,m:kohei.enju@gmail.com,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amazon.com,intel.com,kernel.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CF476F1BF7

From: Takashi Kozu <takkozu@amazon.com>

Implement igb_get_rxfh_key_size() and extend
igb_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 9a105e59f432..47fc620026a9 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3297,10 +3297,12 @@ static int igb_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
+	if (rxfh->indir)
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 
 	return 0;
 }
@@ -3340,6 +3342,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
 	}
 }
 
+static u32 igb_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGB_RSS_KEY_SIZE;
+}
+
 static int igb_set_rxfh(struct net_device *netdev,
 			struct ethtool_rxfh_param *rxfh,
 			struct netlink_ext_ack *extack)
@@ -3504,6 +3511,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_module_eeprom	= igb_get_module_eeprom,
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
+	.get_rxfh_key_size	= igb_get_rxfh_key_size,
 	.set_rxfh		= igb_set_rxfh,
 	.get_rxfh_fields	= igb_get_rxfh_fields,
 	.set_rxfh_fields	= igb_set_rxfh_fields,
-- 
2.47.1


