Return-Path: <netdev+bounces-281699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG32BYpm8GmWSwEAu9opvQ
	(envelope-from <netdev+bounces-281699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086847F404
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A3523017F30
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00A2DF701;
	Tue, 28 Apr 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1k9xf50"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3222E7162
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362526; cv=none; b=fTtGR3AKuuIM6j6Zxttvek6BnYjPHrJ9iICI1F0DmbmXutQ0ptM2S+L4BdAovQzCTWY2Q2qswF0ai4j6TpIT9/fvkuwH8IcIoMUeBL9I4KUlyn6u5tIuEvzpMOwjLao1O6DBkEJKfOFHrCm6Aq3Q/eZNgV8Te/6NP47Tgofj5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362526; c=relaxed/simple;
	bh=v7FR8f9Bf7hDGtGHvqy69oIKLKN59GzoNuO6jFdL1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoLEWEbsMDZIgXESzKy+ykmgUjfraDrJy36RDk66SDzL+nNfzsIELgg63cbAsG7t/oB/VBwFVa0myCmc3XtiTuCaf3z3VY8kLcwSogZYrRzVEl9d98ZNfV++rMsrA0mFFV1bONxSyTmqePUIwflTheKKQIBPCf8PguHg9ztpij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1k9xf50; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362525; x=1808898525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v7FR8f9Bf7hDGtGHvqy69oIKLKN59GzoNuO6jFdL1vk=;
  b=U1k9xf50Axv5y4i013Pq/mG7tIlto8+pXuM5a2KLV7IxRivc2UpFvMTq
   hUTbQLWGxg+2x520xXjFydZQL0mBpYPdrq2T0LtoQUxzAssQGPQnbqzxP
   bMt3zCQfLUALxIBzkd27fbTHM5oVK1aA19aDxB2yKPK8YKB176mfoYKND
   KWzyYbj/LmiYokAuXgLvEQbu55Y1moX0AtteSMP7z9LRFo39US1NqXhVJ
   yu+hqJKFFX9fL58pkKN/yv8pCXY3EJHk9zky2uA0ACJmMslgFsqxDPPN6
   IO3J5B1C1do2tMJ9KurLNb98sZVlGiz2loFrPJHbbl+KItDeV/jv75tgL
   Q==;
X-CSE-ConnectionGUID: NKiJhNM1SUmzbWVk1OtoLw==
X-CSE-MsgGUID: 8mtNdCRnT6KXbuPubICFqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82114986"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82114986"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:48:43 -0700
X-CSE-ConnectionGUID: Wk4hzHRfT0iqPGSytiMW/A==
X-CSE-MsgGUID: srlJlaO7Tty0WggEyj2/eA==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 00:48:41 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jramaseu@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Date: Tue, 28 Apr 2026 09:06:47 +0200
Message-ID: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3086847F404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281699-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]

The hardware is capable of calculating checksum for IPV6 packets with
extension header. To not drop such packets switch from IP/IPV6 checksum
to HW_CSUM.

HW_CSUM is also used in previous generation (i40e).

Previously HW_CSUM was used to indicate that hardware supports general
checksum. Drop it assuming that if the hardware supports it, it is used.

Disabling offload for E830 in case of TSO isn't needed anymore as the
check for TSO is done in Tx path just before preparation of the special
GCS descriptor.

The commit from Fixes didn't introduce a bug, it just shown that the
driver is doing sth wrong with the checksum features.

Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 15550216fbf0..0f2f949af536 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3500,9 +3500,8 @@ void ice_set_netdev_features(struct net_device *netdev)
 			NETIF_F_RXHASH;
 
 	csumo_features = NETIF_F_RXCSUM	  |
-			 NETIF_F_IP_CSUM  |
 			 NETIF_F_SCTP_CRC |
-			 NETIF_F_IPV6_CSUM;
+			 NETIF_F_HW_CSUM;
 
 	vlano_features = NETIF_F_HW_VLAN_CTAG_FILTER |
 			 NETIF_F_HW_VLAN_CTAG_TX     |
@@ -3564,12 +3563,6 @@ void ice_set_netdev_features(struct net_device *netdev)
 	/* Allow core to manage IRQs affinity */
 	netif_set_affinity_auto(netdev);
 
-	/* Mutual exclusivity for TSO and GCS is enforced by the set features
-	 * ndo callback.
-	 */
-	if (ice_is_feature_supported(pf, ICE_F_GCS))
-		netdev->hw_features |= NETIF_F_HW_CSUM;
-
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
@@ -6489,18 +6482,6 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_LOOPBACK)
 		ret = ice_set_loopback(vsi, !!(features & NETIF_F_LOOPBACK));
 
-	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with GCS
-	 * (NETIF_F_HW_CSUM) is not supported.
-	 */
-	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
-	    ((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO))) {
-		if (netdev->features & NETIF_F_HW_CSUM)
-			dev_err(ice_pf_to_dev(pf), "To enable TSO, you must first disable HW checksum.\n");
-		else
-			dev_err(ice_pf_to_dev(pf), "To enable HW checksum, you must first disable TSO.\n");
-		return -EIO;
-	}
-
 	return ret;
 }
 
-- 
2.49.0


