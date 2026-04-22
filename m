Return-Path: <netdev+bounces-280405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AnoE+bB6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED244613F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496633025730
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B23DC4B2;
	Wed, 22 Apr 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0/hLPoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C643DBD52
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861352; cv=none; b=K6zfqbKoF8wUHEHY6DsKC+MXlvQlug6opWFRhxm1L7si8DDZY5AFdzMlUfLfyasxakPuqPaxuV6DXlS9AKxkMYBbOguluOIiQQbPHye51hCX+MTDP20arOzpHrpXRZVUyc1UV1Nn2Me0ivGwDyInjSsdx3tevEZgCwZjWcOU7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861352; c=relaxed/simple;
	bh=5Rx8FzAFlkPbSNLE1tihtAPpSgQCtHK0fEk6lBOaH3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHwmntsX+t10BClxltSBC+A/7SLhbs5W7jinHSKgOQKCfVPU47v4WFsGhXmXpCnX/rCUX2lqfzMGjFRMqlsd6sAGZ0aRSYrp3lzf3KVE5RCfqCH+VTxUNwBwpMoX+WjnLxePCzepHjQDH1JQ36LhbZKytAiwJphSdN1g0+WNa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0/hLPoJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776861350; x=1808397350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Rx8FzAFlkPbSNLE1tihtAPpSgQCtHK0fEk6lBOaH3I=;
  b=I0/hLPoJ/mBd/PytWgC3rQI0oMNOHuq1p2GZwwR4lTT4xjPChLn1yE7V
   xocuFOaeak1l6ZNN+IbGEYnibggHf+7lovDKLi3Pvei8qBWMLTAIF4tzt
   qPwzLL73k9FRe2kvHGNKXL96eqgeAEa0IqoETy5JRnLNnUzuhVAbYfJTt
   Wu17nHo7UBXwTgzjc3mBQnJgFqRYQP/O8eSCqkKb9ExNvd/C70rJp3Y5G
   KyErA/GsR0tER4vnKsJdKmKdfGXWU+sJSqngHse9fSwGoIkQfeMlZPrfh
   xyq2tPGcgdnLaN0RXT2Xm5hl/edgDNXQvyiCoEb1yKB9GO0AsZjNRbX4c
   w==;
X-CSE-ConnectionGUID: PO/wvlmwRryOZLSbhcOFiw==
X-CSE-MsgGUID: sdoCXhGGS1uCJquUGL4rEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77826152"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77826152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:35:48 -0700
X-CSE-ConnectionGUID: xUojld6nRtKRTMQ5LXjtZA==
X-CSE-MsgGUID: t98CEG3SR5yuPoqjPZs11g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229167424"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2026 05:35:46 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH 0/2] ice: ptp: fix E825 timer synchronization and locking
Date: Wed, 22 Apr 2026 14:31:42 +0200
Message-Id: <20260422123144.485930-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
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
	TAGGED_FROM(0.00)[bounces-280405-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADED244613F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These two fixes address E825 PTP synchronization issues in
ice_ptp_hw.c.

The first patch serializes PHY timer start against concurrent PTP
command paths by holding the global PTP semaphore while programming
TIMETUS registers and issuing INIT_INCVAL.

The second patch fixes semaphore access for E825 2xNAC configurations by
making ice_ptp_lock() and ice_ptp_unlock() use the primary NAC register
block, matching the rest of the primary-only PTP register access path.

Together, the series closes two locking gaps in E825 timer control: one
during PHY timer initialization and one in 2xNAC semaphore selection.

Grzegorz Nitka (2):
  ice: ptp: serialize E825 PHY timer start with PTP lock
  ice: ptp: use primary NAC semaphore on E825

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 24 +++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


base-commit: 3662329d3f304a421e0230ee3913dab021ec3a3d
-- 
2.39.3


