Return-Path: <netdev+bounces-276361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGoMC84T1mngAwgAu9opvQ
	(envelope-from <netdev+bounces-276361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D63B92C2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E03B8300BCAE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032A3A5E6C;
	Wed,  8 Apr 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMwBDzd8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DF3A6EE4
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637408; cv=none; b=SlBosbqBbfw1AiHbK0qWkcdOAuNqR32sCPNJpzyN0/37IPQ+pg7U3lk4Oa/DAeaiM4P7E321SZhlfcEZU03Odz7fKzQg1QXqFGoH2YQAGVSEGNzS3X2nFP3L9KRbAA2G+azNgnPRhG2hbZe7oKOBjV6ZSqoefBAFoBT+Vmu/WLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637408; c=relaxed/simple;
	bh=d9Ajbx6LsBUa9X4iAjGw1/xij99LWKnrBr224q3C75M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbVnF6nguPRjkPEe2/DfYd6CM16c6wFoZuNrf6MEsecbfFfmm8UMAGD1AXNwNDtAhJHgKRqXdrrj3NIMGLL9lcT0oaDfDrdtndOU8Z7nv3aho/Wq+D38Gvsh36prOFkEKCN46ixXvWAPeOrrESfzhLQV5XBDb0LOp+lwS+ZNdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMwBDzd8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637407; x=1807173407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d9Ajbx6LsBUa9X4iAjGw1/xij99LWKnrBr224q3C75M=;
  b=BMwBDzd8xSAfVXlFk2pNPkV7c2y843TwAUVCxO9lFzwsVpOnCD7WHsHn
   NK7L/+PLwxAy5fRxtjczwNmTRsdT68vGCMo0QwXIwo4TkD8iH0LlyblP9
   nFrJ2N1QkI/e07/DFlFbrpWEUGN/9b8ZBTo7Mf0UWJ+FbwHZizz/GXTuV
   mnUN4PzkwN4smxwjxVWFWrJaRWggSGQnhrlyoO40p+9NzjbXesuA5qtfE
   Gzs5DJfhTsbU9Oaeby1qmrm8E/J9clF7mzcIaLjPFX7ITzRxL/0eWCtle
   zTZp2LmvglzzHuFm8m7JMZQVDLQ4aNtkoa+aTGpJQIhJtpK/Tolhxj5Cz
   w==;
X-CSE-ConnectionGUID: LVL1vd6UR1uSLw5phJBr0A==
X-CSE-MsgGUID: wkkDSvUnSs+ycQzM7MCtgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80208261"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="80208261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:36:47 -0700
X-CSE-ConnectionGUID: rPOyspMFTTWNYo+dVU66Pw==
X-CSE-MsgGUID: +wHkq7bcTv2LvQTKevC5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228308647"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 08 Apr 2026 01:36:45 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next] e1000e: use ktime_get_real_ns() in e1000e_systim_reset()
Date: Wed,  8 Apr 2026 10:36:44 +0200
Message-ID: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276361-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 282D63B92C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() in e1000e_systim_reset().  Using the combined helper
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdac..6278ce9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3943,7 +3943,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 	/* reset the systim ns time counter */
 	spin_lock_irqsave(&adapter->systim_lock, flags);
 	timecounter_init(&adapter->tc, &adapter->cc,
-			 ktime_to_ns(ktime_get_real()));
+			 ktime_get_real_ns());
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
-- 
2.52.0


