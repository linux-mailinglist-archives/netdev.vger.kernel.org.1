Return-Path: <netdev+bounces-301205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WRVaFsmwOWp/wQcAu9opvQ
	(envelope-from <netdev+bounces-301205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC46B28DB
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=U4jQuc4d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301205-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301205-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0602302979D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755A36B07E;
	Mon, 22 Jun 2026 22:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30C1A681E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165670; cv=none; b=Va6ZbSTkoizWeQs0PGk6d6zN17OAIV4foKTzdSvxTSehMI7T2Izm2qMTx8DuSqUBbF+cwBZDKOBtt29cFT6O4Id7f2tWOuvaaEntQq85K3evBiw3BdEuARWFWvsUUJWGQb7fynm1ScOo8CSVGl/ilgm8dyVPJbCkFqaJie/r/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165670; c=relaxed/simple;
	bh=K2R4+1rgM6BNxvu/JF3CWfY3EzMhBruhzZUMmrG7xng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHR+ixLDilbdNfhV+EBjTJ5X20DrhKb2mr5haiMKAbtnVEvHk9p80hA3YMQI3MT07M1KDr3QG3SU8q/Jgl+s+cdEKQE+rmME7Ekgee6LZn/rSQR8pYu5758Oy29bddB2faS6h0MnlfyCbUbX0hj/JsPRMnYdWainTq+GQp/yiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4jQuc4d; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165668; x=1813701668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2R4+1rgM6BNxvu/JF3CWfY3EzMhBruhzZUMmrG7xng=;
  b=U4jQuc4d1YFQk/ngxrZOP4T5E76al/ohIvWsbJ5jWbMYikv0hdl1FeSW
   vvrtVWQvQADYrPbgp326vtA3qAocaZ+LORNy1UVsNsiAEr+4IVNUftfHl
   04DKENEF+ECMbPg0/zsSsK02DBuRtsGAFhP52wK065k/sHHX9KhEDjD4z
   ETIqeRR5wuxxq5vyUMtG5CkALN3AEduoECn+oscG0KKb0XY/DbIbm2GTR
   bfljFhSYA3QQkHgixEJR3508Ri8IqiWoUQEw+qHZtGCLrsxqs7Bt72+s3
   351FBh5z0BHuUKsUMbKHm+9A7mE7xv3z62lrFOZ/hGfP1F9MybEYxdjx2
   w==;
X-CSE-ConnectionGUID: iDYnQhNXTICnmavwa5O7vw==
X-CSE-MsgGUID: dJnTqEX6RNuZkCgEgoe/tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675553"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675553"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:04 -0700
X-CSE-ConnectionGUID: kg5bhKFvSO+dtNMywtpfKA==
X-CSE-MsgGUID: ehWS+uzhSRufE+K0ukrgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205705"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/8] ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()
Date: Mon, 22 Jun 2026 15:00:48 -0700
Message-ID: <20260622220059.2471844-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301205-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:dawid.osuchowski@linux.intel.com,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:horms@kernel.org,m:rafal.romanowski@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6BC46B28DB

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index b1f46707dcc0..27e4acb1620f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -801,7 +801,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		 * setup only when VF creates its first FDIR rule.
 		 */
 		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
-			ice_vf_ctrl_invalidate_vsi(vf);
+			ice_vf_ctrl_vsi_release(vf);
 
 		ice_vf_pre_vsi_rebuild(vf);
 		if (ice_vf_rebuild_vsi(vf)) {
-- 
2.47.1


