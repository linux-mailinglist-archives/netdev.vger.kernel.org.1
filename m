Return-Path: <netdev+bounces-261386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHBPKZBcoGm3igQAu9opvQ
	(envelope-from <netdev+bounces-261386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:45:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FF1A7D12
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AD8302417C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215743BFE5C;
	Thu, 26 Feb 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVOLwTqv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FD37BE63
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116843; cv=none; b=KhcJyWzgKHoyAyzHcjStWmia82C+3u2fgeISOLGexXlTSbdmU6M8nUs+od7WrULKQQsdWsve7oinQTraoeV5TG0144p2UiKC2n4BDkN+ywQ1YYw/cjgHu1OCY52y2jl49kiBjPNAw/t3LhzxrfwO2Ne4xSzcOT19wU2oFmX/zBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116843; c=relaxed/simple;
	bh=4qJEPQL3k8uWe/F0JSIQRqf5CjPbIYGk3lkjHKeSYrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bLGyoCEYSv5j/VNP2w9wh2Md2CKQz0r5RyocHFJ8KdEyrSCxcmBhnCd1H/u/7P5RfEtZ32GlnNK1W5Qiq73Bd5/S2plAFJhC08XMNm1WzUhCAHEK8HY+yI6shJDgIfVAjVTcVhSp06zww6qfgpHUYuY+d0wbwvHCNWGqIh10G4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVOLwTqv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772116841; x=1803652841;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qJEPQL3k8uWe/F0JSIQRqf5CjPbIYGk3lkjHKeSYrg=;
  b=XVOLwTqvkXgN9Q5gdUNy9jUk/kJoDrE/9RJANTHfGrC5cbeQYiQP+BfV
   bfUB8gQEOO/ux9NDQM+ttRR1J60NpDJiJPIOPtspJoNUIpi+E+5SQKQLo
   uyBqRYj/7Rp39wu3gt4BYH6pZFGYXyKtWPgGIdHKOBuXAGQLfrV6QuTci
   YaU6yliLQwVdan6SsJs7Y0YIZtgp6SZ6ru22S++TaSkYCIliMUYc6M4Ck
   tZLkLnYCWsgwogbaQXAgPR1J9RdTmM9Rt+waXluW2+Shkd7SbLW+ZnjfW
   yDPrxAQ+CRnrKdb2KTSw6GNGIPp5GthfZsWHqd0DJNJYuRUygPImzLWFq
   A==;
X-CSE-ConnectionGUID: NBotsdMRR6iTfvflBdrXRA==
X-CSE-MsgGUID: Kw8J8JC5QqWad7tc0KwBtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="76784549"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="76784549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 06:40:41 -0800
X-CSE-ConnectionGUID: aaCEPmIXQJO5ZJ6yL/eqXQ==
X-CSE-MsgGUID: VRN6VyEbTIuw8KHKaM4V6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="254353834"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2026 06:40:40 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 0/2] ice: implement symmetric RSS hash configuration
Date: Thu, 26 Feb 2026 15:40:35 +0100
Message-ID: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261386-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 155FF1A7D12
X-Rspamd-Action: no action

The ice driver has advertised symmetric RSS support via
supported_input_xfrm since the capability was added, but ice_set_rxfh()
ignored the input_xfrm parameter entirely, so enabling symmetric hashing
had no actual effect.

This series fixes that.  Patch 1 extends the ethtool core so that
drivers hashing GTP flows on TEID can report it honestly without
blocking symmetric-xor configuration.  Patch 2 wires up the ice driver.

The need for patch 1 surfaced because GTP flow profiles in ice always
include TEID in the hash.  ethtool_check_flow_types() calls
get_rxfh_fields() for every hashable flow type before allowing
symmetric-xor; ethtool_rxfh_config_is_sym() rejected any bitmap
containing RXH_GTP_TEID since it has no src/dst counterpart.  TEID
is the same value in both tunnel directions, so this rejection is
incorrect: including it does not break symmetry.

Rather than hiding TEID from the reported fields (which would silently
misrepresent hardware behaviour), patch 1 fixes the validator, and
patch 2 reports TEID honestly.

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
on an E810 card running kernel 6.19-rc8.

---
v3 -> v4:
 - Drop the ICE_HASH_INVALID fallback in ice_get_rxfh_fields() that
   fabricated default L3+L4 hash fields when no hardware RSS config
   exists for a flow type; returning zero fields is more honest and
   avoids misrepresenting hardware state
 - Drop the companion "if (!l3 && !l4)" special case in the
   pair-completion block; it was only necessary to cover the synthetic
   defaults added by the fallback, which is now gone
 - No functional change to ice_set_rxfh() or the ethtool core patch

v2 -> v3:
 - Split into 2 patches: ethtool core fix separate from driver change
 - Drop the RXH_GTP_TEID stripping workaround from the driver; instead
   fix ethtool_rxfh_config_is_sym() to accept TEID as intrinsically
   symmetric (patch 1)
 - Fix ice_get_rxfh_fields(): the v2 unconditional assignment
   "nfc->data = ICE_RSS_ALLOWED_FIELDS" clobbered fields set earlier in
   the same function; replaced with pair-completion using |= so only
   the missing half of a partial pair is filled in
 - Remove ICE_RSS_ALLOWED_FIELDS define (no longer needed)
 - Report RXH_GTP_TEID honestly for GTP flow types

v1 -> v2:
 - Preserve valid symmetric RSS fields instead of overwriting nfc->data
   unconditionally

Aleksandr Loktionov (2):
  ethtool: treat RXH_GTP_TEID as intrinsically symmetric
  ice: implement symmetric RSS hash configuration

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 40 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 net/ethtool/common.c                         |  3 +++
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.43.0

