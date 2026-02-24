Return-Path: <netdev+bounces-260270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ak4EDbtnGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F0180292
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52652305184F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1994317D;
	Tue, 24 Feb 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luKelh3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7F23741
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892019; cv=none; b=WFPCtCXVTsdm369glcauJeBkamf0E7D1DAbDV//7eF+OWW9ezK82PyML6E7+yJaEYDSuyb6kleLa1YvYz6nxEwVG0AnGern2QWoFsB8TzXZ1eO+vWI7zgzpXA/KOcPI6IYZpy3qkXs1DHSaoadzNDgQmaXwRFzlqshVNHE+YLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892019; c=relaxed/simple;
	bh=vQ2hfAh3pnvUs9p2rFL4aZs1O16IU1iCGeQsnn/e5lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=prUkYJd8ir2j14N0/WGFdG877ZQ3T2JEkG6vaSmku0GctrNyB5+OM4sRhiQSkIO9G7U10BjgmdIF54RL/aqp16yLKTf84+QXfl8gnL98FY28r2QYGrwMFINPeqX7ncx1Z/Yfy2qjkfTxa25KGelhDu5hZR70KYkjHXxJbFpTp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luKelh3Q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771892017; x=1803428017;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=vQ2hfAh3pnvUs9p2rFL4aZs1O16IU1iCGeQsnn/e5lk=;
  b=luKelh3QjFDBiRkBJXYAC70WuYTHyypBwq7K3VDwUy+EFi31zQAKkcP6
   vKHEfGEqECfZW5cRBeLjc6rYZBgHT6V7uXFK9PZc9HRAfevCpdAOp7mvd
   AHezFSXXIsHImRdGbBYGtDXoVGsES3t9hDEAWh5YDmpMnsUO0CfLgoX//
   606T05u/BB3NmmDxC6lccr1ENHriNWmEf0WC0OqAzksNmUJfkxHTVh+uR
   eBOYRqficGKAE0Y9iE5l3m5YhqCOCdZzSMjbBfDmXpg05IFpz4AsWS3pi
   F1G1+Lq026tBnCz1CbyJxMdKHvI5vU64JrFT9qKg3yRDbB0nlcxiFrai2
   Q==;
X-CSE-ConnectionGUID: 2TFFVuUNSKCxzGwYvgdiMQ==
X-CSE-MsgGUID: W1f3Z5+ZRoWsv4UDqKagEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60476661"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="60476661"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:13:37 -0800
X-CSE-ConnectionGUID: apw5kpZxRpitfj+5ajSKqA==
X-CSE-MsgGUID: g0JgzZe0TgiUMVV6aj+sAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220284297"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:13:36 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Feb 2026 16:12:17 -0800
Subject: [PATCH] ice: mention fw_activate action along with devlink reload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBBEf6Xs2YVuCiL+ingIyVRXaRuyNQql/
 +7qbR7Mm9nIUBVG526jiqamy+wgh47SPc43sGZnCn049kEGfjxZp1KXBh7f/Co5ruCYVm2/MME
 suiTDyfuCFLKQb5WKUT//n8t137/Zg3tfdwAAAA==
X-Change-ID: 20260213-jk-improve-fw-update-activate-message-1382601ec2d1
To: netdev@vger.kernel.org, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.15-dev-cf6a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=vQ2hfAh3pnvUs9p2rFL4aZs1O16IU1iCGeQsnn/e5lk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsw5b3U2lehp67YvmvOm9aHFFW/vmTc3xeYvOhJad/3sl
 Z2/j0e3d5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjARNg+GvxLv51TPKGM6FsLH
 bKevf1yuP1SznUHyYt6W2d8bXHsy4hgZvrxwVM5hE4hef+rdv6xLJ8S19zhEv6h/w7dA6tOahG4
 bDgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260270-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 975F0180292
X-Rspamd-Action: no action

The ice driver reports a helpful status message when updating firmware
indicating what action is necessary to enable the new firmware. This is
done because some updates require power cycling or rebooting the machine
but some can be activated via devlink.

The ice driver only supports activating firmware with the specific action
of "fw_activate" a bare "devlink dev reload" will *not* update the
firmware, and will only perform driver reinitialization.

Update the status message to explicitly reflect that the reload must use
the fw_activate action.

I considered modifying the text to spell out the full command, but felt
that was both overkill and something that would belong better as part of
the user space program and not hard coded into the kernel driver output.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 973a13d3d92a..1f35bb9314cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -726,7 +726,7 @@ static int ice_finalize_update(struct pldmfw *context)
 	switch (priv->reset_level) {
 	case ICE_AQC_NVM_EMPR_FLAG:
 		devlink_flash_update_status_notify(devlink,
-						   "Activate new firmware by devlink reload",
+						   "Activate new firmware by devlink reload action fw_activate",
 						   NULL, 0, 0);
 		break;
 	case ICE_AQC_NVM_PERST_FLAG:

---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260213-jk-improve-fw-update-activate-message-1382601ec2d1

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


