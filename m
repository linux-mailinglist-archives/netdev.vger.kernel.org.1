Return-Path: <netdev+bounces-162496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09CA27115
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4CB7A4188
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6A20D4F3;
	Tue,  4 Feb 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkKc9eVU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39720CCFB;
	Tue,  4 Feb 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670747; cv=none; b=djSv0q8s/Z0k3zFvb01B6i9bV6y6J8dxCxgM1vW50V7E4UVe8F2Yl5M8oXpWQiemkNgxxfx2WQ4H4HWlNYMBnyG89v+jr+OaXHuIZFLipBrUsnE+aYod0SL6kFZ2PXXji/aNWJj8sQzg6+8Tf38ICxzp52UY1ZCGd6mhQdtjiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670747; c=relaxed/simple;
	bh=xi4sBUQvDSLZfwfFDQG/hOsrvWDhJfv7KlrwKAUi3XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXVzrKti/Uht+5+8V9DEKrjLoytHWFqBNNwQO80jWVsTrFhW1j7pZLqdbmCQVOBK/Lo7SkksvG0W8ySV3pCAZFTg+JKSVREICZBvdBUm5BGL5MLqqTsIqWznnYokslrzDZoe/0gek7I5g73z3NSE+/03xnVIjQArFQbo5SkrnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkKc9eVU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738670745; x=1770206745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xi4sBUQvDSLZfwfFDQG/hOsrvWDhJfv7KlrwKAUi3XA=;
  b=fkKc9eVUEoAwBbobLXUMESW4Vk1NUijT855Lbl4knWoKDW7K6BkOc+/Z
   i0f3iRZTEowko7ibXTxbP+4HkWjzMatOFMcHcmwksth8ou+K5hSnmKi0A
   D/IJxuSrYD1g8hACi2/g2TbRbi48J/usWVZ3Y5dDj7QpesVzm9sJKVFZG
   cvFKCFO63Gbh1+kSPR5NL7a5OYauYD7oLmbPzRqj0JjVqe1FmXwy3hMZc
   7IWkXN2myI0uNQKTIfgA0V5C2J1ZEIz1T+jtSxF6Q/Mwe/4V/ke5yFoxW
   XIvTbyduQc0/bJ0CmatvkWrXYYql+VJ6LLMmb4fG+cM7fIQOnqRNM/GEQ
   g==;
X-CSE-ConnectionGUID: htBkYZmSRpiyMbCuO+mLnA==
X-CSE-MsgGUID: 1Ymso1AURpu07AR/8dUBIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38424788"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="38424788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:05:44 -0800
X-CSE-ConnectionGUID: 9Xc4lbrtTCKZ/HZJSQpMnQ==
X-CSE-MsgGUID: v+LQwvfBRMO6e7lCadO8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147783203"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2025 04:05:41 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 22A3932CA9;
	Tue,  4 Feb 2025 12:05:40 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: [PATCH iwl-next v2 0/6] ice: LLDP support for VFs
Date: Tue,  4 Feb 2025 12:50:50 +0100
Message-ID: <20250204115111.1652453-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to:
* receive LLDP packets on a VF in legacy mode
* receive LLDP packets on a VF in switchdev mode
* transmit LLDP from a VF in switchdev mode

Many VSIs can receive LLDP packets, but only one VSI
per port can transmit LLDP, therefore LLDP TX from VF
requires adding an egress drop rule to the PF, this is
implemented in these series too.

There are no patches that explicitly address LLDP RX in
switchdev mode, because it just works after adding support
in legacy mode.

Usage

To receive LLDP packets on VF in legacy mode:
On host:
ip link set dev <pf_ifname> vf <n> trust on
On VM:
service lldpd restart

To receive LLDP packets on VF in switchdev mode (host config):
tc qdisc add dev <pf_ifname> clsact
tc filter add dev <pf_ifname> protocol lldp ingress \\
   flower skip_sw action mirred egress mirror dev <repr_ifname>

To transmit LLDP packets from VF (host config):
tc qdisc add dev <pf_ifname> clsact
tc qdisc add dev <repr_ifname> clsact
tc filter add dev <pf_ifname> egress protocol lldp \\
   flower skip_sw action drop
tc filter add dev <repr_ifname> ingress protocol lldp \\
   flower skip_sw action mirred egress redirect dev <pf_ifname>

For all abovementioned functionalities to work, private flag
fw-lldp-agent must be off.

v1->v2:
* get rid of sysfs control
* require switchdev for VF LLDP Tx
* in legacy mode, for VF LLDP Rx rely on configured MAC addresses

Larysa Zaremba (4):
  ice: do not add LLDP-specific filter if not necessary
  ice: remove headers argument from ice_tc_count_lkups
  ice: support egress drop rules on PF
  ice: enable LLDP TX for VFs through tc

Mateusz Pacuszka (2):
  ice: fix check for existing switch rule
  ice: receive LLDP on trusted VFs

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  71 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  56 +++-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 243 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  17 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  26 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  48 +++-
 18 files changed, 449 insertions(+), 73 deletions(-)

-- 
2.43.0


