Return-Path: <netdev+bounces-257643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMFiAZsqhmnMKAQAu9opvQ
	(envelope-from <netdev+bounces-257643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:53:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385B10181D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1819308699D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10657427A05;
	Fri,  6 Feb 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7xAM/lt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF393426EB5
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400160; cv=none; b=j6BaoKp4XpmQQM7HJTA6iJUOZceC08EX4QePjOoOAzafYIz5Y3v2aYNtRT4c4JrJpuu6oa4J1HecJECwbE5YxFnaR29EEwTDG3Vilm2rAG6qXAz9M2XgVpWPHiR+bRCdAOHw2x2GUpoWqv2UBimZj3fDM/dcxCj0V1wd7EfqV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400160; c=relaxed/simple;
	bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOW3VK6W20yqb3pmF8TUEzQQjq0h809GsrgvIs3PmHBPYzlkcH9Ri27RLcGhby9HkTBhNAr6vd8oazQ6eed+Bqs+BH2WfJFpEAXr3KYqmJiC09lY/WBz9+NGYJgeTwm8mzZYJp4XmFEBpA9o90/EvEpL10kFrDvkpYbRofR0EJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7xAM/lt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770400160; x=1801936160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
  b=b7xAM/lt5+O5XLrf54sMx1HWtx97iG/UA9pRbO8EKHDPnuL1tJeCdWAM
   ByRCP7x2LU0OHSp3Bq+B/XZAES9DMSc0MaBBXWhOD1Eg8rKK+oRKuAVSS
   /kHKNcRjI3F3VSRsP3dZFoIxfgxNisEk3Sb6pdE6iRWO2J9yIhUbju68M
   jDnxL2BeyGdYbLXqEycQ0yBTcSJYqhECvvbku1D9rYjaeHZmoMqAPNbZw
   Pipl/DuAn2BY8NyaVt6zzinl9QMOrIignWMPJcdZdjZtSqbwjOOAgFMAy
   uPxYeQmHpAezhlgEXA0yLGX4DID67CipBZDzppHPXUPMc3Mi/cYlWj8hY
   g==;
X-CSE-ConnectionGUID: ZWO2H3PUQ1ekU9zVSvMm8w==
X-CSE-MsgGUID: lvqMLh43SIO/9f9zv5L13A==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71793143"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71793143"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:49:20 -0800
X-CSE-ConnectionGUID: GRD94m6tTZSl6rEypIAHXw==
X-CSE-MsgGUID: yJ8e/+CMRcetwkAnYFFDDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215495413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 09:49:19 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 6/9] ice: Make name member of struct ice_cgu_pin_desc const
Date: Fri,  6 Feb 2026 09:49:03 -0800
Message-ID: <20260206174910.4066255-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
References: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,molgen.mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257643-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7385B10181D
X-Rspamd-Action: no action

From: Simon Horman <horms@kernel.org>

The name member of struct ice_cgu_pin_desc never modified.
Make it const.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5896b346e579..9bfd3e79c580 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
 };
 
 struct ice_cgu_pin_desc {
-	char *name;
+	const char *name;
 	u8 index;
 	enum dpll_pin_type type;
 	u32 freq_supp_num;
-- 
2.47.1


