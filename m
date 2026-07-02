Return-Path: <netdev+bounces-304069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NPxVLJ8yRmpzLgsAu9opvQ
	(envelope-from <netdev+bounces-304069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E36F5682
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CV8Nz1Sq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304069-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304069-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A5403002B0E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CF48A2BD;
	Thu,  2 Jul 2026 09:35:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990B47DD64
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984917; cv=none; b=j2keXswE1XiFMJjbYaEIjpMQ1QUB9zwS+qz/JeEEg5RJxjMUnGCRyWgcHL8ErgWYf97tJwHGCFWK+giR2/CQDN/AmxQxIyf+L7FfU6bU14P7E0ZjZyFjOqf3V1PBP0v6x8gdjVnaXSFXcN+kUirTOEQfIczEceKvSzNKGUXEBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984917; c=relaxed/simple;
	bh=PNrdD3+JtONCzgOT6cHrmuc82I6MuBJsIXVQlfg3hy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+5uSGtgcImMmvkC9sqy/BV1Yw1XWmxBEtxCsu/mJLoLzSlax3OHnsdqStyhpwPX6KG62SvwajaXPJnFXUmwBlatxkFa/B2xzbd/Alu1xrit4obRFmiSylQX3qNYhXdKcQT0cidPoZRge0V+Sjqp8LBjGKvrkmeO1Da200TghXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV8Nz1Sq; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984916; x=1814520916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNrdD3+JtONCzgOT6cHrmuc82I6MuBJsIXVQlfg3hy8=;
  b=CV8Nz1Sq4KseuxMZP+95hN8JeqixU8sKzByWcQh01pwn5Ijowb1s96ph
   DnC5TW8fmfo+seBsN8DCnBRjpDumpS2Yn4VPAoqEkGWpBEocOQPzC0Ps2
   bfZLs311J6jpeLSe9KNHJxGp1jFjJkWJx/91AgSEWUreXFPFaZhz16hHU
   t+dqHjdPtkvMLOvi1CbFunxpWfIztwaCuK2Gxm0gU5ufPgNXsN5g6BlGo
   Q6jjlLi8e9+ZFIQ8VoPhAcZxHqS6y1rSnQ85Ed2uj4zqHwy7emH71dXIt
   5WTY5mPly0VZHOnIzkBbRF3NJuj9hIxTfJEDN95146kXTdtuODKyVhHBU
   w==;
X-CSE-ConnectionGUID: nmwhiJnFQPilEYjnJ/IgzQ==
X-CSE-MsgGUID: xKAV7UnlR0KhhPB8yhlSHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649807"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:16 -0700
X-CSE-ConnectionGUID: Mk5wkfk5RO232oFgLP7r4A==
X-CSE-MsgGUID: KoWGWUTDS+OsTYK5YnRoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476417"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:15 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 3/6] ixgbe: E610: do not disable LSE on driver down/remove
Date: Thu,  2 Jul 2026 11:15:50 +0200
Message-Id: <20260702091553.57112-4-jedrzej.jagielski@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304069-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C6E36F5682

For the first case:
LSE especially shall remain enabled when interface is down and link watchdog
cannot track status of the link. Then the only way for link update is by
handling LSE.

For the second case:
There's no value in disabling LSE when the driver's unloading is about to be
terminated.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2c8968b9b86c..f33a534490b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5979,19 +5979,6 @@ static int ixgbe_enable_link_status_events(struct ixgbe_adapter *adapter)
 	return ixgbe_configure_lse(&adapter->hw, true);
 }
 
-/**
- * ixgbe_disable_link_status_events - disable link status events
- * @adapter: pointer to the adapter structure
- *
- * Disables link status events by invoking ixgbe_configure_lse()
- *
- * Return: the exit code of the operation.
- */
-static int ixgbe_disable_link_status_events(struct ixgbe_adapter *adapter)
-{
-	return ixgbe_configure_lse(&adapter->hw, false);
-}
-
 /**
  * ixgbe_sfp_link_config - set up SFP+ link
  * @adapter: pointer to private adapter struct
@@ -6775,8 +6762,6 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 
 	ixgbe_clean_all_tx_rings(adapter);
 	ixgbe_clean_all_rx_rings(adapter);
-	if (adapter->hw.mac.type == ixgbe_mac_e610)
-		ixgbe_disable_link_status_events(adapter);
 }
 
 /**
@@ -12143,9 +12128,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
-	if (adapter->hw.mac.type == ixgbe_mac_e610)
-		ixgbe_disable_link_status_events(adapter);
-
 	if (adapter->mii_bus)
 		mdiobus_unregister(adapter->mii_bus);
 
-- 
2.31.1


