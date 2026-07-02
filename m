Return-Path: <netdev+bounces-304072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ruLlADM0RmruLgsAu9opvQ
	(envelope-from <netdev+bounces-304072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E36F5804
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:49:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jsx1JaVX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304072-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07B2316B0C2
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D0480974;
	Thu,  2 Jul 2026 09:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2248AE1B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984921; cv=none; b=R1xMjqCYTIv1MI/SrzZoI3Ta9bW6JcOGpQT3YP9BcUadkvyA2qi1N2jcoRY6Xviqc2NzApkWPWT37PjhFaPVetHzTkR3WMfiuehqqgfgVZCskunkVnHYtiOL/eCVKx3+fjwNhxgkbp+JzfgIUGa8s/Bd7Z2tZ7IroNJRSynY5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984921; c=relaxed/simple;
	bh=0Io7Eaz/4tR3x0fiwuKyeOXFsOgPAMXA57TCUl/iwAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqurzMYRix130cE543+3pqh2U363/aZDEQn0U+0LZY45T2cCF9tC4He2zInaz1MGkJtqtfz75lcbEvVNwXS+AAVW54BpwELZePcPthweeiztIOZCldhZhn75PzHlPmrCI5Y4uxEvmPRKCOCSedH4kNUHFwnloGrptMfYhu6uy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsx1JaVX; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984920; x=1814520920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Io7Eaz/4tR3x0fiwuKyeOXFsOgPAMXA57TCUl/iwAo=;
  b=jsx1JaVXV0c1GPPZZBDqtBXqj5U/mHjhW9JgaFbdwIWRswgv0f25j51O
   C+hdxn++ZAjDMlaqR8/ysWDdRL23iuPdk7xT8uxczGPC5ALuQFUySBZar
   pRfEAbHyAJ/DC5iZLMQAUQ2aaeVxsVesvMaEvEud1FGZFUI7hTjUowd6a
   B9NNmlaRg3eCEqVYO2gbsSEeDgkFjhNJYHvTCqP5Im5PvJjk6Kv7rr8BF
   rhMQfU/zwKrODd2xmOPoqpkJMKMaes2QvZD8AaLhg9U+EKsOVBVSdTfZ6
   Glz2vjG0949bhnfIDmeYOTGeNWK5/v4dOM8cklCowYqdiBRtrzegDX8Xn
   g==;
X-CSE-ConnectionGUID: eVFPgzcdRhKH8Z9ydVUDFw==
X-CSE-MsgGUID: OmO1nwIJTUWzdBuiy5hDDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649822"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649822"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:20 -0700
X-CSE-ConnectionGUID: dC6QQ3GTTYeosAnFjlAB2A==
X-CSE-MsgGUID: X5rN/ANmTfavT+FPs02Rog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476433"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:20 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock before ixgbe_reset() is called
Date: Thu,  2 Jul 2026 11:15:53 +0200
Message-Id: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
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
	TAGGED_FROM(0.00)[bounces-304072-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C9E36F5804

Previous commit introduced ixgbe_mac_addr_refresh which touches netdev
struct by updating mac addr. It should operate after taking rtnl lock.
One of the callers is ixgbe_reset(). Most of scenarios when ixgbe_reset()
is called met taking lock requirement, but there is a ixgbe_resume() path
which calls ixgbe_reset() -> ixgbe_mac_addr_refresh() without taking
the lock. So there is a risk of race.

Move rtnl_lock() before ixgbe_reset() is called.

Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ce2b1e208c0f..c7261eb0e9b0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7574,11 +7574,11 @@ static int ixgbe_resume(struct device *dev_d)
 
 	device_wakeup_disable(dev_d);
 
+	rtnl_lock();
 	ixgbe_reset(adapter);
 
 	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
 
-	rtnl_lock();
 	err = ixgbe_init_interrupt_scheme(adapter);
 	if (!err && netif_running(netdev))
 		err = ixgbe_open(netdev);
-- 
2.31.1


