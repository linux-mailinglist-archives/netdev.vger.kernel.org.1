Return-Path: <netdev+bounces-268911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKYVOCRfumnFUgIAu9opvQ
	(envelope-from <netdev+bounces-268911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDF2B7AB6
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0E883139BE0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A936C587;
	Wed, 18 Mar 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngq3gtGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8C366DB5
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821261; cv=none; b=sPSg9iMGFZUN28mS0Fe+oK02DRUGwbLTQL4kg2Q9FFC5SbRDGHh2Hk0pVwBpNISDHGL4XBKuA+TPz8DSIJzjZc7hQnKO4bts/q/SD0OJjPnk6XNMlmbhf/yWBWUgVWiOhHWIsr5jFw1dNeRJPngxFi+a68wsFDytqEEvFOf5SYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821261; c=relaxed/simple;
	bh=fdLI0Ko6mtrlnwt0ohoaLVU0GX5WeN1MsPSScgcpLXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j55kfB4LknvIyaYr1D74I14Zto9xcc/ufO0rid2UA+iLidXnRYuzdNYXg2iCqixBS5gL0x5TcgRz6Vlxs615ByS+eU4oFyergP99fPocv6RJ49WAkt39h4W1SrhC0i/n4GvdAgPHqCX1C0Uecfd2RCSobpbMxDFeI9cflF8c9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngq3gtGl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821260; x=1805357260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fdLI0Ko6mtrlnwt0ohoaLVU0GX5WeN1MsPSScgcpLXY=;
  b=Ngq3gtGl+20uTYROgqTJ894yBNNiYF712piSV22I+5wkdJhPXFpodkZO
   ioqnwfbKqwOZ0QtXWYjVHvvnSF6shmAnuaDBGFLgjZEYEPYtQtXsM8ale
   M1u5axyeyL0clnD8yaTbln3mWjXvoqf1cg/vHam0sL6oCGU5uEJVnuwmD
   EJ8SPfxSl2E/r+1Y0nMLEeVT5igPENU3J9+Q0YY06AaKTVJFiF1rOWrSd
   wTD570nHAG6z3awMw5Gew/lykgIgpyr3eCnS2E4y97Yobe/1dxLV0CvUz
   tEqEqJ5JSS/mD0NFtu47A7S+ae6MsvKmiYjk1VY9OQiQn2v2fi2ops6y7
   A==;
X-CSE-ConnectionGUID: wKEswRqBSCu7W84e3Tc5gA==
X-CSE-MsgGUID: ePJKJGXBSIC47HwDHl/THA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74755242"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74755242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:07:39 -0700
X-CSE-ConnectionGUID: 2Op16dLKS82lmlB/t7murQ==
X-CSE-MsgGUID: IcmXUWE4SkyEN7qw+RC/Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221628539"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 18 Mar 2026 01:07:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v1 0/2] virtchnl/ice: add IEEE 802.1ah (0x88E7) VLAN ethertype support
Date: Wed, 18 Mar 2026 09:07:34 +0100
Message-ID: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268911-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 57FDF2B7AB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IEEE 802.1ah (Provider Backbone Bridging) defines the Backbone Service
Tag (B-TAG) with ethertype 0x88E7. In environments that combine Provider
Backbone Bridging with virtualisation, VFs may receive or transmit frames
carrying a B-TAG and need to install matching VLAN filters on the PF.

The existing virtchnl VLAN v2 capability handshake (via
VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS) has dedicated bitmask entries for
each supported ethertype (0x8100, 0x88A8, 0x9100) but lacked one for
0x88E7, making it impossible for a VF driver to advertise or negotiate
B-TAG support.

This series adds the missing capability flag and wires up the three
software-path checks in the ice PF driver that guard VLAN filter
installation:

  Patch 1 adds VIRTCHNL_VLAN_ETHERTYPE_88E7 = BIT(3) to the shared
  virtchnl_vlan_support enum in include/linux/avf/virtchnl.h.

  Patch 2 updates ice's TC TPID validation, VSI VLAN filter validation,
  and the bidirectional virtchnl VLAN v2 translation functions to
  accept/translate ETH_P_8021AH (0x88E7).

No hardware offload changes, no datapath modifications.

Tested on E810 with an iavf VF requesting 0x88E7-tagged VLAN filters:
  Verified that a TC flower rule matching on VLAN TPID 0x88E7 is now
  accepted and offloaded by the driver without returning -EINVAL:

    tc qdisc add dev $VF clsact
    tc filter add dev $VF ingress protocol 802.1Q flower \
        vlan_ethtype 0x88e7 action pass
    # (previously: Error: Failed to offload TC filter - vlan_type was 0)

  Also verified VF transparent passthrough of triple-tagged frames with
  0x88E7 as middle and innermost tag using scapy on a back-to-back E810
  pair (kernel 6.19.0-rc8+, FW 4.91, ICE Triple VLAN Comms DDP 1.3.88.88).

Aleksandr Loktionov (2):
  virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
  ice: add 0x88E7 handling to SW validation paths

 drivers/net/ethernet/intel/ice/ice_tc_lib.c       | 1 +
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 3 ++-
 drivers/net/ethernet/intel/ice/virt/virtchnl.c    | 6 ++++++
 include/linux/avf/virtchnl.h                      | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.52.0


