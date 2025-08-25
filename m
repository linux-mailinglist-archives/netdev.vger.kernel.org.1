Return-Path: <netdev+bounces-216670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6EAB34E64
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD531667C0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635828D8D9;
	Mon, 25 Aug 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaXfK0e9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5072989B5
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158626; cv=none; b=IIok2e0Y6sZpBUVAUpt+KLQitpRZtguLa5mH3x4digx6TS1wJO1EzsESP0QYvrrMqtRtu/0AiGxKoDtCWJcvXHq+b27LXY964iQMjlctfUW+Pvq9qHygf3XE7yLNexvUIN+ypoQ5NFOBg3qR4I0pxUQj2f7S6/xS3D44ID3Oa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158626; c=relaxed/simple;
	bh=/0GNxuPuU+6hoRD8qTDxeUO+L1pH9Bo0CAVd9EGz+r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItCIUeYZ24A8FuPBGrBHLotlQ1j4SuKvm5Rv5jy18witMLFqLr2BTrxP77fUD5aeK2nCDbQ1ufAsymqO8eo6acxd6JtS+RUzcbDJwKmnaa81uz7S5MKNBfuSHn9YCFA07gnEEMCo53R7QpvSu0iXsZcRQnf35so8cUo09gx2i24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaXfK0e9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158625; x=1787694625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/0GNxuPuU+6hoRD8qTDxeUO+L1pH9Bo0CAVd9EGz+r8=;
  b=MaXfK0e9iG6BTWkQopBHiToJokokbWjgbE/jOYM0D96MYeFWTLjTEMG/
   xL3frSyX/7vID4WtARW0xwm+QzVjK4IBFWyTDpSRvMNdM6plTQYZbX1U8
   g1W+irhDteoi+fLzbcCRW8KPjPSsIUsHMG4DxtCdOA4gz7XX23W6E6WGV
   6VhenLB0axNxPuavhWx6KsQZoAT8iPKvgDpIcw+p8zaxNnN3mKa7sRsZW
   6aEMBld0FI0NJYS70ADMg/BI/pdxl8nEAmDh6x7/wnFD78PL9gMpc3Yql
   6gjdaIiD7Pnu0Vao/umzfz6SLHuwTAfo+MZY/LS3eddt1aTo5ztAf9JTU
   w==;
X-CSE-ConnectionGUID: OptJkJRAQc65j4gdysjtMg==
X-CSE-MsgGUID: LWjjHnuqT3+RmWleZqx/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651357"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:25 -0700
X-CSE-ConnectionGUID: LuMBI5QcRW+B2GlkDGWDeQ==
X-CSE-MsgGUID: T+T89BBSQqSJ8nKnvKjatg==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-08-25 (ice, ixgbe)
Date: Mon, 25 Aug 2025 14:50:11 -0700
Message-ID: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Emil adds a check to ensure auxiliary device was created before tear
down to prevent NULL a pointer dereference.

Jake reworks flow for failed Tx scheduler configuration to allow for
proper recovery and operation. He also adjusts ice_adapter index for
E825C devices as use of DSN is incompatible with this device.

Michal corrects tracking of buffer allocation failure in
ice_clean_rx_irq().

For ixgbe:
Jedrzej adds __packed attribute to ixgbe_orom_civd_info to compatibility
with device OROM data.

The following are changes since commit ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a:
  atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Emil Tantilov (1):
  ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset

Jacob Keller (2):
  ice: don't leave device non-functional if Tx scheduler config fails
  ice: use fixed adapter index for E825C embedded devices

Jedrzej Jagielski (1):
  ixgbe: fix ixgbe_orom_civd_info struct layout

Michal Kubiak (1):
  ice: fix incorrect counter for buffer allocation failures

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 49 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  4 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 44 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_idc.c      | 10 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 16 ++++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  2 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  2 +-
 9 files changed, 93 insertions(+), 37 deletions(-)

-- 
2.47.1


