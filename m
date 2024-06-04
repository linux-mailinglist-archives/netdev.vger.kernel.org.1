Return-Path: <netdev+bounces-100567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5FB8FB383
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9D81F21B2C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA95146A7B;
	Tue,  4 Jun 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErLKTYxK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142E1459E5
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507331; cv=none; b=KOc60pDRHfivUYbZQNJNA697Nvlk0ZGV5Xjb8vBEVyL0uQOx2N7m56Vxb1xMIxcoj8kzv2ENegIhB9Xf4lFOjidmVpLbwYtcecj+pZ17LjpTFiqJelfb0D7rclp5qNHMaDzEhBhsVzVrL5qf3bcPOjz16bNwYTHKXonFPlN7CuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507331; c=relaxed/simple;
	bh=bjzwZh4LunZ2cpdfC/fNWkWwzMQXMBwkURvSvjTCarI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M0oPbttvOM0FCwoj01Zfu4L0X5nQ2w7Mx9T8U2hm2qNajOdhbQN/m91Nx0zN70/sF3J/ozFQghW0X3gt2FZa+Ew+ZCvsFb7TKn0pp0QKSRv9IpUVsu8PT3Mt6ligqnSOrlx6vWiamdFlXirCMPMyU7a3RPpdJrQHhLhwQhJstB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErLKTYxK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507329; x=1749043329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjzwZh4LunZ2cpdfC/fNWkWwzMQXMBwkURvSvjTCarI=;
  b=ErLKTYxK7Q0Muz0997f0SNblof56qgsqKp33EDidQB27+Gp8p+EAjgpG
   GP/Rtt/izQmi7h+dnF/OZVzbX/4MDWYGTFe2ffRkQbLyjdEWMcJuEI+Mh
   9++A/TdPNVWCV/j4FY+ZVIAhbxPyFwHxLOXsSqmx0fGBZRu2GjmHnxaYI
   v20nKmXEZ0XG7pt/cQdO+V2JVRjFAn01Wkgk4Xnv/q2M3kfXcrc23Cvvv
   AJG0KicNE8dtOSGWkdgGldlaAVX5cpUjJks4y/pjXfblGTj1jNV7WqEyz
   KdSeE0bBVwUyBOZJefCUrmZ0REkygypOEsKvJF9Ts2Q2AWoc60OqHtMFQ
   Q==;
X-CSE-ConnectionGUID: NoAeeIMWQIaV2slR1LNJpg==
X-CSE-MsgGUID: iEM5DrNHQKa+XIkCjEh98g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31552834"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31552834"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:22:09 -0700
X-CSE-ConnectionGUID: 8Hm37LyARG2LAxP12L0XDw==
X-CSE-MsgGUID: 5UvhuG29TNqg6ELoUKN1VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37350091"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 06:22:07 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 iwl-net 0/8] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Tue,  4 Jun 2024 15:21:47 +0200
Message-Id: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

changes included in this patchset address an issue that customer has
been facing when AF_XDP ZC Tx sockets were used in combination with flow
control and regular Tx traffic.

After executing:
ethtool --set-priv-flags $dev link-down-on-close on
ethtool -A $dev rx on tx on

launching multiple ZC Tx sockets on $dev + pinging remote interface (so
that regular Tx traffic is present) and then going through down/up of
$dev, Tx timeout occured and then most of the time ice driver was unable
to recover from that state.

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

Thanks,
Maciej

v2->v3:
- drop redundant braces in patch 3 [Shannon]
- fix naming of ice_xsk_pool() in patch 6 [Shannon]
- add review and test tags

v1->v2:
- fix kdoc issues in patch 6 and 8
- drop Larysa's patches for now

Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t,r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 153 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 6 files changed, 104 insertions(+), 76 deletions(-)

-- 
2.34.1


