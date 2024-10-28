Return-Path: <netdev+bounces-139664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21D9B3C33
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61856B218E3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249C1DE2DF;
	Mon, 28 Oct 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkLseHLO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046E18D649
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148510; cv=none; b=bNLpw7YjkQ7n/+nP1FnRNjRM24waaUftrOxKP6tp7IVk0wdu/f3aVwV1s4QWiaAll05zG2u8xqeSjZSRnIEYRPFRNb0XBtIcwTz5g8G60mnPF9N5IUKNoAUlcmTSjzmIZyS5gRzsk6Ul2V4xejG1WMyxzNIs4gAhW/1o0v3ERzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148510; c=relaxed/simple;
	bh=SvRvHWEPkL1s1/bhNIhAxLbUg0uF/huboOQbYt9COnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQ9r1PuR3pliY/MVs7Xia4cRHiVChyq0XceCJsaq7vdI+AhuUAor4GFfSofQ883UrpSeza+rsnAB2LAsnc0YEz4+jmWBkdYWGEVFprn8d03XthIhSgk4CVy7MS5c8TskvLyF3TiYdGPNgGbp2RPHItmWnryyKge1Gb9QSQYXzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkLseHLO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148508; x=1761684508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SvRvHWEPkL1s1/bhNIhAxLbUg0uF/huboOQbYt9COnI=;
  b=TkLseHLOGl0XMALjSd0nvhsfWGTQefHSxXPP6YrJ6ipMgVq51VRpbRqQ
   4vu7GtLiiTLu9h4gEmp8gJd7p/5zBc19h6U7E7c3mgN9Og0TqH0VzqDQo
   F7+eBm0IvfqoKVJxmyDboOLBfTwmTTazniuft2ym0YzJKV+3Tg4Ygrh2j
   yEuN1AFKPk4+NGItY9nwCHczz30vG5LpA//uglRQKFGsmr2NXxA4gKvUc
   +/vrVzGVJKGqAYlW3dVBXHj2IDVCq0HVGkdFuiFp8ZibfC6yQN/kSiIrd
   ZXbroLjf2NueVwB24jwRC+BwlkWbpzmhqVFOUIw4bXxOB8SzzTGMfuH+f
   w==;
X-CSE-ConnectionGUID: wtnZt6/vRz+IJRMFmgBFBw==
X-CSE-MsgGUID: L7zjMj4nS7aOsn2VbgnhPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33685463"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="33685463"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:48:28 -0700
X-CSE-ConnectionGUID: GS9LcOXoQBWErAqTgD1Sxw==
X-CSE-MsgGUID: plqjDdVbRYuw60lBlggk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86529740"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2024 13:48:26 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v3 iwl-net 0/4] Fix E825 initialization
Date: Mon, 28 Oct 2024 21:45:39 +0100
Message-Id: <20241028204543.606371-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking
the PHY revision only for current PHY and adding proper destination
device when reading port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as
a primary PHY lane number, which is incorrect.

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  47 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 281 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  37 ++-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 11 files changed, 247 insertions(+), 239 deletions(-)

V2 -> V3: Removed net-next hunks from "ice: Fix E825 initialization",
          replaced lower/upper_32_bits calls with lower/upper_16_bits
          in "ice: Fix quad registers read on E825",
          improved ice_get_phy_lane_number function in "ice: Add correct
          PHY lane assignment"
V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
          whole "ice: Remove unnecessary offset calculation for PF
          scoped registers" patch and fixed kdoc in "ice: Fix quad
          registers read on E825"

base-commit: 19acd6818aa7404d96cd5d0e4373d4ebe71448c2
-- 
2.39.3


