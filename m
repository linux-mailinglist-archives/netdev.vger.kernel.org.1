Return-Path: <netdev+bounces-285600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDnyI0Fd/WmLbgAAu9opvQ
	(envelope-from <netdev+bounces-285600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1304F144C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8775A30160C8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239B2494D8;
	Fri,  8 May 2026 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BstbNkEo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F028635D;
	Fri,  8 May 2026 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212118; cv=none; b=UBLC+W89ReG/CX9oCRpNDut0VqJflwAZirVU3+PHf+eARx8mDL0sQmgBBQ80Rj+jf2e60CDE2CGJwLQV1D3nGx869jIeIrvPzCrI/M4SjALs35bCCUbzUWQ60+0mfq26rdSbCk5m8om8NAj9TYEm8uHwoYJbXRGqi2AaK8L8mjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212118; c=relaxed/simple;
	bh=9sJ6IMJ5LymCVMvZk1BOFaSeUfznGdj4PM9e7IORzXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7NHfvynempVK4FPjR6lhu7gS5h5/R0fJ8N5lKDoXmKALWkuYQR9JoKJQUDQlZyJ5dKFfv/2ks6Jc6AFq0/W9lPJChUbPsJ6SKuqh8yu7oGdXOVW1yMpESiBGOhnG5QlGRuOFxuJV184DorYl8/ja5+ZP2vzHB2cujkuWIzd31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BstbNkEo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778212117; x=1809748117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9sJ6IMJ5LymCVMvZk1BOFaSeUfznGdj4PM9e7IORzXI=;
  b=BstbNkEol6PKFvwo4roml50on75yx8RovZSbl3bPqXdl3VkNOdu2RWvt
   s+BTp9QBZGlj/4Z+dBIvr4oElmqkv5hKXCNgKU0iW2YNDwzAQ379KN94G
   Xnwt8iK4NZTIfQHc9txC8IAXLHsEgw26gWcesI1PvAoFzwjPNXH7t5W52
   HglkDQHjnjBtzFN+uCPT1ko/tLWacwSBM6SeAI0mY852RRXu2GDyXJ8Lf
   qL7JZXD1b+H/DRvtNdmVMZgaoSTId0mm8ofxMZjXXRco8zZ0KFY2pOnVM
   vrbfOMnBwztDONQ2YuPTG+yeNf+AVOPt6A95y6sXR+LFhrT3yzboL6BWN
   w==;
X-CSE-ConnectionGUID: cfxDBxSIT6eTumH+R4z6pA==
X-CSE-MsgGUID: vylcYzYGS9iT+utoGioAig==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90278832"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90278832"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:48:36 -0700
X-CSE-ConnectionGUID: 3/Z9CBXmTRSYCygsnAIrvw==
X-CSE-MsgGUID: JiV19TWjR6mRUIHunpGUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="236767290"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2026 20:48:32 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-next v5 0/4] igc: add support for forcing link speed without autonegotiation
Date: Fri,  8 May 2026 05:47:02 +0800
Message-ID: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA1304F144C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285600-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[ozlabs.org:query timed out,intel.com:query timed out];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ozlabs.org:url,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v5:
- add removal justification to include copper context in commit
  description for igc: remove unused autoneg_failed field (Paul)
- check that cmd->base.duplex is either DUPLEX_HALF or DUPLEX_FULL
  in igc_ethtool_set_link_ksettings() (Simon)
- dynamically override hw->fc.current_mode to igc_fc_none during
  link configuration instead of mutating requested_mode (Simon)

Changes in v4:
- Validate that autoneg is AUTONEG_ENABLE or AUTONEG_DISABLE early
  in igc_ethtool_set_link_ksettings() to avoid passing unexpected
  values to igc_handle_autoneg_disabled(). (Simon Horman)

Changes in v3:
- Modify condition from "if (duplex == DUPLEX_HALF)" to
  "if (duplex != DUPLEX_FULL)". (Simon Horman)

Changes in v2:
- When forcing half-duplex, set hw->fc.requested_mode = igc_fc_none,
  since half-duplex cannot support flow control per IEEE 802.3.
  (Simon Horman)
- Split the original single patch into three patches for clarity:
  patches 1 and 2 are preparatory cleanups; patch 3 carries the
  functional change.

v4 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260428060009.311393-1-khai.wen.tan@linux.intel.com/

v3 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260422155701.7420-1-khai.wen.tan@linux.intel.com/

v2 at:
https://patchwork.kernel.org/project/netdevbpf/patch/20260416015520.6090-4-khai.wen.tan@linux.intel.com/

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (4):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: replace goto out with direct returns in
    igc_config_fc_after_link_up()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 210 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  35 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 268 insertions(+), 99 deletions(-)

--
2.43.0

