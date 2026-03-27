Return-Path: <netdev+bounces-272396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNtNI0gwxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A073404EA
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A044A300DDE0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79763BE64D;
	Fri, 27 Mar 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2H947/L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B634F244
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596164; cv=none; b=JZgvlCe6G0efGJwd83No9olZJ8GHUZuE2VpO6x8EU/dlRvTBTQZHCel9IQrZODJBEl5FilX61pOufcNQkYAauUMIKuYGmUMWoogvmgD2ygFaNGWVmarL+fCNRKz4VyJfLSvkmCPOH7U7bUrcVRVc+hCtHL6Vp+d4JOmA5Ei4kog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596164; c=relaxed/simple;
	bh=D+s5dkR7PiyUUKF6dt62fXzb5w6vmdnbxG390mMhAoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyN/GXh9AcgGw6vfBcJQtIRCewDBIw7CMru7XZfdfH6AK+AoueU3FQ87msW7bSo+VI4NHKf4uXR4EphmSh94UL7onNFXlIdRgzEgVzf6DvEeE1W5IQRI4ELM9kz3JoU7bZJsrhc36bo1zJbKEaBthuwfdWzHuxEckvC9OF6z6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2H947/L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596159; x=1806132159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+s5dkR7PiyUUKF6dt62fXzb5w6vmdnbxG390mMhAoY=;
  b=h2H947/LbZSFboT5p4tGUXqp5C4Cw0uARWu9NiiAxWqfkaXXgmiiIiuC
   gZBEgpxeNGn91cGileFsP86yCQT3tJhCnsyC6kvKmBzjGcsuhYvdDUtq+
   38mNL4djkA/wsMShx2iPyt0ZPhz2YWK+hnzcRJf4DcWLBhfrzIwQsnBzu
   v/eTsvT9jsHiOwmRqMw9/lUp7+q7HPqnohlOkvQAquRZKjp0lcorDQMkh
   JGI/C5DkztGG/1Qpm05NpPHUmKDTyszWW5IRpggNWJ3otnHOs+8U+KLg5
   HyqdBB/8k8Id7pD2DlpMkBdYdgwuIlcaixelghkggl4MR4+pnPsGu/10D
   A==;
X-CSE-ConnectionGUID: ZrNDm/nSRf+K0NoB6zRu6w==
X-CSE-MsgGUID: xcUbgEuxR/G6lRpW2YJbZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848614"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74848614"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:22:38 -0700
X-CSE-ConnectionGUID: 6/9e78DSS/GRznaHMWAXsw==
X-CSE-MsgGUID: ntREl+RURPirFn3v7oSxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222359329"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH iwl-next] ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()
Date: Fri, 27 Mar 2026 08:22:32 +0100
Message-ID: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272396-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 00A073404EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Resetting all VFs causes resource leak on VFs with FDIR filters
enabled as CTRL VSIs are only invalidated and not freed. Fix by using
ice_vf_ctrl_vsi_release() instead of ice_vf_ctrl_invalidate_vsi() which
aligns behavior with the ice_reset_vf() function.

Reproduction:
  echo 1 > /sys/class/net/$pf/device/sriov_numvfs
  ethtool -N $vf flow-type ether proto 0x9000 action 0
  echo 1 > /sys/class/net/$pf/device/reset

Fixes: da62c5ff9dcd ("ice: Add support for per VF ctrl VSI enabling")
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c8bc952f..7d33f09 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -801,7 +801,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		 * setup only when VF creates its first FDIR rule.
 		 */
 		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
-			ice_vf_ctrl_invalidate_vsi(vf);
+			ice_vf_ctrl_vsi_release(vf);
 
 		ice_vf_pre_vsi_rebuild(vf);
 		ice_vf_rebuild_vsi(vf);
-- 
2.52.0


