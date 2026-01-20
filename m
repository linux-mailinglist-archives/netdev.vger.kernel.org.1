Return-Path: <netdev+bounces-251443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9ECD3C5E1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 640FF5C4B87
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F1407573;
	Tue, 20 Jan 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwCiG1cp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38E407568;
	Tue, 20 Jan 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905286; cv=none; b=rVdp0apkwTo8kVkLszXTGNcFkFf0M0rO/0w/mn1dtWNarOiPlbIueM/wWq9xUFFmS05y0NO+G9B+8iyZuKRPzb1qoIJ1GMopZN/Ak4y4X7inti45um9oTdroX/akPCg017PLA9gqjUca4JwFq3VrYjTtCJtexRmP4jXwGi1XL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905286; c=relaxed/simple;
	bh=2JpWh8dIf4yeI7M+/s717Byn0Z1WOd8UO8wUvY6ozzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cs7u4hIyWUzyYJfY5QtUh0JQEXzeDVEbofRAlVbvPUblZQhOA5QXJwuijiAWiBf12lqsDGiD1Dnr+AV8P7hsHAPn8aj+JfRvm8rl/1vIvVpGZ5Kr6ssiJ9IETvuFoTjNiGegK39Kr1dTtts8k34bwRIak7uNXCwCkV577KUgTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwCiG1cp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768905284; x=1800441284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2JpWh8dIf4yeI7M+/s717Byn0Z1WOd8UO8wUvY6ozzg=;
  b=FwCiG1cpvEAu2wIv+6rvv2/WowrnUhqcyxDFziHnSRNARj15nzCW/qAG
   PHi7ynUrc5rLTBfE0EMbWXsUs99Tqm5O9/tyWCk4RjZLPLUJrgbipoefe
   CiPNN/RsbuftxxItprn83OKeLqwF4MOzpSmGgGFqL1wv/4fXT4IFrngCa
   e8HnqBUvKPcEE9l7xb2nYrfuRGOPLq8/zflNrUk6VLAggaRPcRWhhb6xl
   jFcubHcYISrm3U/svstWjFn1yF+PT66N6bwKox7p7E5Z3ayjEPY3B4lex
   7jdT40lSKVw14CqdwOaPjFoD1dRL2jfGVbiYo5Mvwxnpz6AGgz29JspyA
   Q==;
X-CSE-ConnectionGUID: OL3ZQqUXQYy67BSaEe9+4w==
X-CSE-MsgGUID: abXXecePTryF9l3yK5yXqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70161725"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70161725"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:34:43 -0800
X-CSE-ConnectionGUID: qiPffr16S3aR977f0cT+zA==
X-CSE-MsgGUID: STtrC8BySFmzypuaoBOerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210935839"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 02:34:41 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 0/8] ice: in VEB, prevent "cross-vlan" traffic
Date: Tue, 20 Jan 2026 11:34:31 +0100
Message-ID: <20260120103440.892326-1-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Currently, packets that match MAC address of a VF will be sent to loopback
even if they would cross VLAN boundaries.  Effectively, this drops them.
In this patch series, we aim to address this behaviour by adding MAC,VLAN
to complement what MAC-only filters do to select packets for loopback.

To reproduce the issue have an E810 ($pfa) connected to another adapter
($pfb), then:

    # echo 2 >/sys/class/net/$pfa/device/sriov_numvfs
    # ip l set $pfa vf 0 vlan 4
    # ip l set $pfa vf 1 vlan 7
    # ip l set $pfa_vf0 netns $pfa_vf0_netns up
    # ip l set $pfa_vf1 netns $pfa_vf1_netns up
    # ip netns exec $pfa_vf0_netns ip a add 10.0.0.1/24 dev $pfa_vf0
    # ip netns exec $pfa_vf1_netns ip a add 10.0.0.2/24 dev $pfa_vf1

And for the $pfb:

    # echo 2 >/sys/class/net/$pfb/device/sriov_numvfs
    # ip l set $pfb vf 0 trust on spoof off vlan 4
    # ip l set $pfb vf 1 trust on spoof off vlan 7
    # ip l add $br type bridge
    # ip l set $pfb_vf0 master $br up
    # ip l set $pfb_vf1 master $br up
    # ip l set $br up

We expect $pfa_vf0 to be able to reach $pfa_vf1 through the $br on
the link partner.  Instead, ARP is unable to resolve 10.0.0.2/24.
ARP request is fine because it's broadcastd and bounces off $br, but
ARP reply is stuck in the internal switch because the destination MAC
matches $pfa_vf0 and filter restricts it to the loopback.

In testing I used: ip utility, iproute2-6.1.0, libbpf 1.3.0

Changes in v3:
  - Improve structure of reproduction description in cover letter.
  - LB_LAN masks and values no longer rely on boolean promotion.
  - ice_fill_sw_info() deals with u8 the entire time instead of building
    building lb_en and lan_en values at the end from booleans.
  - Refer to reproduction in cover letter in current 5/8.
  - Fixed some slip-ups "this patch" and "this commit" in commit
    messages across the series.  I did not consider this change for
    reviewed-by drop.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/ s/_MASK/_M/ because one of uses would need to break
    line.
  - Close open parenthesis in ice_vsi_update_bridge_mode() description.
  - Explain returns in ice_vsi_update_bridge_mode().

v2: https://lore.kernel.org/intel-wired-lan/20251125083456.28822-1-jakub.slepecki@intel.com/T/
v1: https://lore.kernel.org/intel-wired-lan/20251120162813.37942-1-jakub.slepecki@intel.com/T/

Jakub Slepecki (7):
  ice: in dvm, use outer VLAN in MAC,VLAN lookup
  ice: allow creating mac,vlan filters along mac filters
  ice: do not check for zero mac when creating mac filters
  ice: allow overriding lan_en, lb_en in switch
  ice: update mac,vlan rules when toggling between VEB and VEPA
  ice: add functions to query for vsi's pvids
  ice: in VEB, prevent "cross-vlan" traffic from hitting loopback

Michal Swiatkowski (1):
  ice: add mac vlan to filter API

 drivers/net/ethernet/intel/ice/ice_fltr.c     | 104 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fltr.h     |  10 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  56 ++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  56 +++++++---
 drivers/net/ethernet/intel/ice/ice_switch.c   |  79 +++++++++----
 drivers/net/ethernet/intel/ice/ice_switch.h   |  13 ++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   8 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  12 ++
 9 files changed, 295 insertions(+), 45 deletions(-)

-- 
2.43.0


