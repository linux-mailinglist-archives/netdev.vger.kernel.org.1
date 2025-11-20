Return-Path: <netdev+bounces-240476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41DFC755AC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E0C3E2BCB3
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C433644D8;
	Thu, 20 Nov 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epYihk9K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F33112B2;
	Thu, 20 Nov 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656099; cv=none; b=V5zz7rmja6vPamkYHPRp4xeYryfGGDe/y5MNtdtZriLFYsJyK0wb2t3lU3K87BdO2GMSSrJFylSqUS5tJ3HOggbo7fuQPJ7XVVBR3yPWzfgp5Y8ANOxik58Zd5s0vRWwo5Ly8xp32o01py42i/B2laNjTm5Uz+MX9OU0lgV7w8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656099; c=relaxed/simple;
	bh=8JIE/NAhqf0XKlA4PBiWOtHObaDWqMMcngXrjCqMSKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLPezKY4Rx+n2t285pJYIkE64fswcWVpp4GwQcLvJrCDZADvW+B8xbsdfmUIvgNAXgDFwYzLaNmU4/m/lZ+4T+W7u9Y8p0NTDy0zlEutOpI8+IxI4UGA3Oz4ICdRwc/wyaLeFNq2VY7pQ23nv3npyipbsGkS8Yi9LB5RNsbTes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epYihk9K; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656097; x=1795192097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8JIE/NAhqf0XKlA4PBiWOtHObaDWqMMcngXrjCqMSKE=;
  b=epYihk9KFqha+DCWGGG/1s7Ron54VAVnDoSvom+XJLWYyR9YU1C2kBlX
   9fkSDMyHSiLsS9pS2wWH6E8D714OtS9HjxeFCBH3fR2NNuDaGzG8kM0I2
   ZzvWhgn+b8N2r3V1EYnK9c8+Zru9dmzZCRIjR6DFRqESGRpkvmcYpkgB9
   x/PGybciiStfyD9CqwTM8jAx/1zaG4NtL4YgjKGstv36De3JMM0hZdEuv
   u8YtSKEViSZyeBGYerbjYL27bAJMW/q44D1vYiWsW/Z+AXupT0MkSjwrO
   UaQdxAnDr8k7AcqUCfaR3NPeetZrupMdkZdInH/P9/vYQSikbcCKJrnw+
   g==;
X-CSE-ConnectionGUID: KNOxq+LURS+u/FcIA7Laow==
X-CSE-MsgGUID: M5E89kbIQcmji3yUc2FotQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599279"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599279"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:17 -0800
X-CSE-ConnectionGUID: tq7KI/JMR3+ujQjtikJ/Cw==
X-CSE-MsgGUID: 9U5BzslsQqmc6nn8awrjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531277"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:15 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 0/8] ice: in VEB, prevent "cross-vlan" traffic
Date: Thu, 20 Nov 2025 17:28:05 +0100
Message-ID: <20251120162813.37942-1-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Currently, packets that match MAC address of a VF will be sent to loopback
even if they would cross VLAN boundaries.  Effectively, this drops them.
In this patch series, we aim to address this behaviour by adding MAC,VLAN
to complement what MAC-only filters do to select packets for loopback.

To reproduce the issue have E810 connected to another adapter, then:

    ip l set $pfa vf 0 vlan 4
    ip l set $pfa vf 1 vlan 7
    ip l set $pfb vf 0 trust on spoof off vlan 4
    ip l set $pfb vf 1 trust on spoof off vlan 7
    ip l set $vfa0 netns $netns0 up
    ip l set $vfa1 netns $netns1 up
    ip netns exec $netns0 ip a add 10.0.0.1/24 dev $vfa0
    ip netns exec $netns1 ip a add 10.0.0.2/24 dev $vfa1
    ip l add $br type bridge
    ip l set $vfb0 master $br up
    ip l set $vfb1 master $br up
    ip l set $br up

Where $pfa is the E810 and $pfb is its link partner.  Send the packets
between $vfa0 and $vfa1.  We expect to see ICMP packets at the $br.
Instead, ARP is unable to resolve the 10.0.0.1 because the reply is
stuck in the internal switch.

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
 drivers/net/ethernet/intel/ice/ice_main.c     |  46 ++++++--
 drivers/net/ethernet/intel/ice/ice_switch.c   |  79 +++++++++----
 drivers/net/ethernet/intel/ice/ice_switch.h   |  12 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   8 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  12 ++
 9 files changed, 285 insertions(+), 44 deletions(-)

-- 
2.43.0


