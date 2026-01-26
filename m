Return-Path: <netdev+bounces-253373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPclN5Mpd2lzcwEAu9opvQ
	(envelope-from <netdev+bounces-253373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D78596F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3270D3004C4B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F614219A8A;
	Mon, 26 Jan 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsJMi6VM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A213EBF01
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417101; cv=none; b=GDIGJbiHsSSM/D/3ueS4gKmaw4Mwygn8QwBGIMz7302rbxgZbv+7gUk+84oKy1L1xTiyouEAwcIX6EHwlvUFJ9stYc+snLiASsERsoDh2OWfPjrPhy6+TSqd3/DStcHbERnlFy4CO4aQuHhJWiveppHx7Yv27HLlQ2uYuWYcow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417101; c=relaxed/simple;
	bh=s5WhHkpMJph3dnQm9bg/a8IisWZSLUAPtG1shYY9hhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJiNc1PKj5wxjnPGYSyDFhPLEaRums9VCNbpsd1PLGg2DGOW0j7Y0fxC8PDtqEhiQ+9KiOqt8OkjlnaNP4mI6zHeSz+GWz2+6DH+7upvbRO5KBquvF7HAJJYwlkK8Af+TBJPc7gjhUhGBrLH9lax/FFbkAz860n76xNEpe6NOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsJMi6VM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769417100; x=1800953100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s5WhHkpMJph3dnQm9bg/a8IisWZSLUAPtG1shYY9hhA=;
  b=fsJMi6VMvsJgnxR31QLWcRPmeeuHXdWhfrN5d/0H2n1c0sRzBlqMywVt
   6sHxNy13YsRpZcsuCZZFbuzz7/hUCElav3rln6xcMl20quVvFx2pZIGUx
   lvCsWbeYSUdrSecsESvdoPkSJwqekPSnLfNh7RXtc7MgG5kOxBlwTDzTf
   Rnfgv0uDPqns+F7zV8Egw1O+tVfSr0j6zuvZyz0Bt17ZvPDmPWt2zz45O
   ytqc7PAqarTo54HBCuvppzz/CZoNXr91h5i6rPuXl1EAnOGf7kotMNs42
   ioeM9MpPxGdKh+AHU/9c1Guox2+x67HXDMZGcTpiKCvkRSxGdLLPjl4Fv
   Q==;
X-CSE-ConnectionGUID: bCc6ouuoTl2C2ltykF56gg==
X-CSE-MsgGUID: Uf5qf+1lTTy9bVDrOh/F7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74222380"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74222380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 00:44:45 -0800
X-CSE-ConnectionGUID: xJXQvBklQhipYG7K9HT1NA==
X-CSE-MsgGUID: eHL38Au7TDehrMUD7a4NtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207874728"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 26 Jan 2026 00:44:43 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v2] ixgbe: fix unaligned u32 access in
Date: Mon, 26 Jan 2026 09:44:42 +0100
Message-ID: <20260126084442.413230-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253373-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 830D78596F
X-Rspamd-Action: no action

ixgbe_host_interface_command() treats its buffer as a u32 array. The 
local buffer we pass in was a union of byte-sized fields, which gives 
it 1-byte alignment on the stack. On strict-align architectures this 
can cause unaligned 32-bit accesses.

Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte 
aligned, and pass the u32 member when calling ixgbe_host_interface_command().

No functional change on x86; prevents unaligned accesses on 
architectures that enforce natural alignment.
 
Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v1 -> v2 change title and concentrate on alignement issue
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef6..eb5bf3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
 };
 
 union ixgbe_hic_hdr2 {
+	u32 buf[1];
 	struct ixgbe_hic_hdr2_req req;
 	struct ixgbe_hic_hdr2_rsp rsp;
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 76d2fa3..4a0ccbf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1228,7 +1228,7 @@ static int ixgbe_update_flash_X550(struct ixgbe_hw *hw)
 	buffer.req.buf_lenl = FW_SHADOW_RAM_DUMP_LEN;
 	buffer.req.checksum = FW_DEFAULT_CHECKSUM;
 
-	status = ixgbe_host_interface_command(hw, &buffer, sizeof(buffer),
+	status = ixgbe_host_interface_command(hw, buffer.buf, sizeof(buffer),
 					      IXGBE_HI_COMMAND_TIMEOUT, false);
 	return status;
 }
-- 
2.52.0


