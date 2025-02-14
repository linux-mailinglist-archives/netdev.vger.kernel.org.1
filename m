Return-Path: <netdev+bounces-166342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D7A359C2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4D7A19B0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A022D4DB;
	Fri, 14 Feb 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE+Z5v5O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D922D793;
	Fri, 14 Feb 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524134; cv=none; b=cxuWRLr4lbhrle0yhGMCcQBL/2h3q56uxteksCprs/V4otcITKc089U5b8bsVv92l7EU/243MQ8F7p1JEZm7GhX9pM6bYdmf+p2+ooKa0xd3IV7p6dpBeNByJP1H3Ib/r6sXvKFDWXM6Zg4Alx7dItP1TkWxExEFMhXN6Hyv/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524134; c=relaxed/simple;
	bh=Eo5DuTvQ0qKs2Jp3vi/N35mfegrhtFBJq5aOGSjyD2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPAB2g4kCcJcEZLq82ivO9y4pXCoJmT/QANp9ZrCkfxs5wZBAQ6aB+V8jXd8fYfA4s4rkq1eT2mYPXj55vKx5eoNREzeQ32NotvwQ3FZf2ghUm8nMzoAeVAStXW8wpKIh2yxJybOM/IMlwprl6lOcjE846x1TykOv06ARvzDTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE+Z5v5O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524133; x=1771060133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eo5DuTvQ0qKs2Jp3vi/N35mfegrhtFBJq5aOGSjyD2I=;
  b=ZE+Z5v5O6jYf5J3H/abx0p6pnhQoVSHc3wxN9M/D4Mmn0oUp5tzLLEuC
   Mz7NfGvnhMedgKy7xY5l1HZ+ZYdQ/9k9hKG8d0j9jS/GJ8QRYNeaxpaaR
   ViqX3xUxxQyN6RP1e9npinRq+vTIRuFV9IPfd1/HdBVagdTXKOXp0DRRy
   ooos4cQyCqM3rJApCl9WQGh+w/I8yB9vUcrp9ToyP29i8ODglvWt+gTqn
   N9ZsCxBazXJsvzHIeHYUwfC2E8ydA22ci8qjtDGV9BXw4Qq3004yKZkZX
   kn3xRacPSL3MXYY6oKfXbo9Pz51MpdgbgfCXi+Rt95baYJN7IKgyWQ3+f
   Q==;
X-CSE-ConnectionGUID: 92jHz167SmWlbQZ06OMJUg==
X-CSE-MsgGUID: bzCd5kikQvebxo4kg+FalQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65617699"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65617699"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:52 -0800
X-CSE-ConnectionGUID: ob2CyOKURkuqgQey6bTE+A==
X-CSE-MsgGUID: l9XtpCizQ6iCBPA9lcT5XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113145423"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2025 01:08:49 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6789F37B80;
	Fri, 14 Feb 2025 09:08:47 +0000 (GMT)
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
Subject: [PATCH iwl-next v4 0/6] ice: LLDP support for VFs
Date: Fri, 14 Feb 2025 09:50:34 +0100
Message-ID: <20250214085215.2846063-1-larysa.zaremba@intel.com>
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

v3->v4:
* add "Return: " to the touched kernel-doc
* reunite return type and declaration for ice_add_cls_flower()
  and ice_del_cls_flower()

v2->v3:
* fix sparse warning caused by part of .sw_act members being initialized
  inside the curly braces and others being initialized directly
* reorder members inside the rinfo initializer according to struct
  definition in ice_drop_vf_tx_lldp(), while fixing the warning above

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
 drivers/net/ethernet/intel/ice/ice_common.c   |  14 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  71 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  63 ++++-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 258 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  17 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  26 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  53 +++-
 18 files changed, 480 insertions(+), 80 deletions(-)

-- 
2.43.0


