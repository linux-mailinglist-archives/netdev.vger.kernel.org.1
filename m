Return-Path: <netdev+bounces-249605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C3D1B842
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EF973012A85
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CA231AF30;
	Tue, 13 Jan 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD2lHW7D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD82F363E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341750; cv=none; b=TFpa7WFxpB2d12HUWg1SvxOG9dt48r1C7siubHZQuxMFFcoxEUyPQdVeU6T98sJhxMo1UeVnodaGHPZBgqGXYsL4QiW/MA+9jDseQoPniMfB6C+RoL+XTS9KNZb6ZsXMVF92AUcwpCjRwEXBbECOsNyJ4TJ0iDnG22A1rcvIl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341750; c=relaxed/simple;
	bh=oTn1rRjFkoKJSVY1tdUfLmXmMX+bVGMA0ZNDEKvrtkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0Jdjl2BrxxnvJ8/7erv+HqKt4/qQyTsJwaPfwEHlbB1GTghO7iXhYFqqcvITi4Z7NdgmHjfptIawDQkbiCaIFpzKb51dCf1f5N3gbsKd5f0+S0VAAfIY3regxk1TdidMXXnFLNFE+jw27IKxbfN0qcpJD5r4icF6/33Un1cXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD2lHW7D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341749; x=1799877749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oTn1rRjFkoKJSVY1tdUfLmXmMX+bVGMA0ZNDEKvrtkw=;
  b=QD2lHW7DWdV3DyZaJSDhf7fqGIu5f3oyXxjYrnTOFygMSEh+teRGn0ll
   4Qtk4EIs7tWAc78hBLev1jlSoFqbSojiZhG0NxeNboWR+8vvmt610kL7a
   GT7NK95HmrdqtWqAcF+pUiE3PWN57mF2Tql2lTzb461aJABHDvI4LcuKE
   o0oUsrw6hXeGsP3meKpB6he9D/V9+C27Di7bqLNVLJSRXaiYKAUf4hqPD
   fyvzC0q3zW/VHgn39+SSbyiBjEdJEieGce9+vXKLZZkslPLaqichrv3+x
   W+edcXnx1uzG0uZXZ9Z5aUuqs5BrfDxW+k0maZC5S+82oEaLtjQSF/SEe
   Q==;
X-CSE-ConnectionGUID: jo0dBDHlT7Kymiptsv3c2A==
X-CSE-MsgGUID: aPVvhFC3RMeEDRzveoXAaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558652"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558652"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:28 -0800
X-CSE-ConnectionGUID: ZAn4oT7ZRJGlqT5wqgJzDA==
X-CSE-MsgGUID: wKNu7LyBQ+2kXXe4gSkmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388161"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-01-13 (ice, igc)
Date: Tue, 13 Jan 2026 14:02:13 -0800
Message-ID: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Jake adds missing initialization calls to u64_stats_init().

Dave stops deletion of VLAN 0 from prune list when device is primary
LAG interface.

Ding Hui adds a missed unit conversion function for proper timeout
value.

For igc:
Kurt Kanzenbach adds a call to re-set default Qbv schedule when number
of channels changes.

Chwee-Lin Choong reworks Tx timestamp detection logic to resolve a race
condition and reverts changes to TSN packet buffer size causing Tx
hangs under heavy load.

The following are changes since commit ffe4ccd359d006eba559cb1a3c6113144b7fb38c:
  net: add net.core.qdisc_max_burst
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Chwee-Lin Choong (2):
  igc: fix race condition in TX timestamp read for register 0
  igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue

Dave Ertman (1):
  ice: Avoid detrimental cleanup for bond during interface stop

Ding Hui (1):
  ice: Fix incorrect timeout ice_release_res()

Jacob Keller (1):
  ice: initialize ring_stats->syncp

Kurt Kanzenbach (1):
  igc: Restore default Qbv schedule when changing channels

 drivers/net/ethernet/intel/ice/ice_common.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     | 29 +++++++++----
 drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  5 +++
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 43 ++++++++++++--------
 6 files changed, 57 insertions(+), 31 deletions(-)

-- 
2.47.1


