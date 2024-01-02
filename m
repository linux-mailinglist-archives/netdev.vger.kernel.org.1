Return-Path: <netdev+bounces-61028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B5D82247F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998501C22CD0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581EE168B0;
	Tue,  2 Jan 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7vq6E1S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22D171A7
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233077; x=1735769077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/7SRSMFnCieveSHewXWuAlV2Mjma2LIn/x2ZT5jleG0=;
  b=b7vq6E1SK8qo1bZdAW8t98mlIK9mpZf0+2r1iLuI1D75US8uLd7s2LD+
   Klicy/rfWZsxzj5ODzP8Hq9x9Jo4mFjdYsx4tVlyO1LFojn3KapN33Jmb
   MKonGTXu2TGqItat10d5Beg+xvf5QjQY0Yt6wms9jJX7oJr4PIkxJ29E/
   nHiGd6jvcJ1qWTGEnR5MoH7z8Of38QrF8JoGIZpY0xxkeTHqXa0jbbdPM
   1RUf3A/+lwSyCfqEuhqNtTacPYZZVpBx7Hc3Fr1aDd2t9MbPimklCXwBW
   CKkFEV8DaAfKubcRZ86Ouyuz5ApdowxJ26qc+Js8680if16ZbpKRI/cfY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567868"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621397"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621397"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:35 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates 2024-01-02 (ice)
Date: Tue,  2 Jan 2024 14:04:16 -0800
Message-ID: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Karol adds support for capable devices to receive timestamp via
interrupt rather than polling to allow for less delay.

Andrii adds support switchdev hardware packet mirroring.

Jake reworks VF rebuild to avoid destroying objects that do not need to
be.

Jan S removes reporting of rx_len_errors as they are incorrectly reported
by hardware.

Jan G adds const modifier to some uses that are applicable.

Kunwu Chan adds some checks for failed memory allocations.

The following are changes since commit 954fb2d2d49f46e1d9861c45731e26bdeb081695:
  Merge branch 'remove-retired-tc-uapi'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Andrii Staikov (1):
  ice: Add support for packet mirroring using hardware in switchdev mode

Jacob Keller (1):
  ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()

Jan Glaza (1):
  ice: ice_base.c: Add const modifier to params and vars

Jan Sokolowski (1):
  ice: remove rx_len_errors statistic

Karol Kolacinski (2):
  ice: Schedule service task in IRQ top half
  ice: Enable SW interrupt from FW for LL TS

Kunwu Chan (1):
  ice: Fix some null pointer dereference issues in ice_ptp.c

 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_base.h     |   4 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 -
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 143 ++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 167 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  24 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |  25 ++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  41 +++++
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  35 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 -
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   1 +
 17 files changed, 381 insertions(+), 89 deletions(-)

-- 
2.41.0


