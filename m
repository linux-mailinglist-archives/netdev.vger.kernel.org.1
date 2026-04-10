Return-Path: <netdev+bounces-277290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHoLERes2GkmgwgAu9opvQ
	(envelope-from <netdev+bounces-277290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5463D3997
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A12303CE3E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCA38BF67;
	Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHkC06Bx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0337BE62
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807373; cv=none; b=mVDZ+BfUMzZ/q3sGkcfuKUtWQITp05nINrkHu/eqNpq0EB1aB0fjOIuKhb8yq+H9AEdLPWQxsTxBSR6abjG0MhbNyvOUKtrd2azmgnZwXGQyXjDNqbh4NUIPQ9KOar94hmcylnhCj849v92rD3YbtHOC1wjdKlGeb8Elp4ka5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807373; c=relaxed/simple;
	bh=Uhe/PktKStkc0D01ZpH8sxDrD5w8h5fmFb/KK/CAeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UunZivSWD1debtMB0sv7nAww5zXwfBRl6b30O6pClv/EaeR9isxar1NqtMnEFU158oINgJFhDFTQAGagwkjmtCy39lqr9u0M2IcXQFvcIwpqR1Ald6kyr0CAXfxbICKhPwre5SLj1wR5TA/+IgK3+qwbTo9uf8awXKO1r6C/m4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHkC06Bx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807371; x=1807343371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uhe/PktKStkc0D01ZpH8sxDrD5w8h5fmFb/KK/CAeOs=;
  b=BHkC06BxFgIW8qVx24qRBoCTFqUcLmvS4jJ41bywID1h/kxKDBA5O+RZ
   WAyKjT7sdV/uZJ/0EA7BFYHyxNThZtVX0CYDENKOagz/fOMom8t+wUKcQ
   KwLp/RV+3IkpEA02KUo56kPaprDNjd7jk95+EbRUMJyTcRFncQKaf8b/n
   u+a2R7XMdb4PC44UcdAng5hYCHBBm0tVUaT1nCEEkw+pYIruITFLDdVLE
   ct2IzphvjD2Z0yYWM+U28ScVWN/3L4o8uYOn9iAtri1tuab4lZyk/fuxd
   BZvfm4Rc4sN3JqbukWiHN/nSCdRJvz5fYbuw+GPMJEv6fjtESZWNY4z+4
   w==;
X-CSE-ConnectionGUID: pgGhCDqbTkCX6UYV3jaxhg==
X-CSE-MsgGUID: sH94iL9fSDmk0xLs3mqTow==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007928"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:31 -0700
X-CSE-ConnectionGUID: /RWNk6lCSh25lLrZmfr0eA==
X-CSE-MsgGUID: seFQ7vbSTnC3GDmNti/PXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941872"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:29 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 4/10] ice: reorder ice_flash_info fields to eliminate padding
Date: Fri, 10 Apr 2026 09:49:15 +0200
Message-ID: <20260410074921.1254213-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277290-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5463D3997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_flash_info structure has a u16 sr_words field before a u32
flash_size value. This creates a 2-byte hole as well as 3 bytes of
padding at the end of the structure due to the blank_nvm_mode bitfield.

Re-order the structure to place flash_size first, which gives a better
layout and reduces padding.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index cb47127..97bf601 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -968,8 +968,8 @@ struct ice_flash_info {
 	struct ice_nvm_info nvm;	/* NVM version information */
 	struct ice_netlist_info netlist;/* Netlist version info */
 	struct ice_bank_info banks;	/* Flash Bank information */
-	u16 sr_words;			/* Shadow RAM size in words */
 	u32 flash_size;			/* Size of available flash in bytes */
+	u16 sr_words;			/* Shadow RAM size in words */
 	u8 blank_nvm_mode;		/* is NVM empty (no FW present) */
 };
 
-- 
2.52.0

