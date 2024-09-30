Return-Path: <netdev+bounces-130330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F9E98A224
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D4B29D11
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B418E047;
	Mon, 30 Sep 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrBxq51U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBE18E35A
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698235; cv=none; b=soz69fRiAd9DRZt7Kl8fjaBdFGNYtebm/i49bG9iQcq1bFs1cWGrN+Lq04o0e4fAcAHunhcIyBR9rdcn8wKSVvZsS+NvGNpW6ly6fbCbWhBSonfM9rqdhl4VTW4YSi88MtFqoC3nQDpH5qzCccdEgS0nyKAMUqJGXpIZkSmxbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698235; c=relaxed/simple;
	bh=EVp5Bjy7cfQCWkfP5W+N65KqXWcsmRo+GTh5Jlgf0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMmKg5il2rD2C10UdoIs4Qaxr80JdH6tzbMrI+ilDH8aOoedE/4zY3mjxWRdQKxrR1B9rERZrbzjfU2BTKBhuevkLhnsE2+vJp+1/u/9hjoUxjAaS6gb2jcUiZiCchspyN8JvxbYnYtrhyCeFkz+SnhaEZQt/6ZIrMeE/LfCqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrBxq51U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698234; x=1759234234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EVp5Bjy7cfQCWkfP5W+N65KqXWcsmRo+GTh5Jlgf0j4=;
  b=FrBxq51UKBwf6eB/qvnLnySRvJ3FJLA23yb0xni2t/DXXSZvLRcnPScn
   AdnrzCwxF3QXdJpBWCS1BqkPlytMM2gl4aNLj3K0xRUjx+mz5YgPwmv3r
   pOMVnFvOfUtTY0Ga1BxkjQUjfvjP7zBOiVTlshU4AK4hwMMMRkoMlBjF8
   HuH6voQ15IpWXnYfKaYKN1xitrNRm1bHvr3VjhKdcxob5eB2eEeqb9McT
   5NC14rNow6nPp5lDig3yyIMHkDe2EQ2D9SZmaSo5dqLUnNQDjsbiEFQW/
   QtbevDX52ZiHwSGkf6wKWjRcvjU4o3YApnzHw0GSE8C0GhybWOWz9CuB/
   Q==;
X-CSE-ConnectionGUID: +3amZgZcSM+jP0JypyycvA==
X-CSE-MsgGUID: tsp3PKLQRNysOvG49iY6GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26736079"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26736079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:10:33 -0700
X-CSE-ConnectionGUID: u/dZoYUsQcWDgW32izf7IQ==
X-CSE-MsgGUID: axkbeQUSTyqgiCHVUo+dXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78037007"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 05:10:32 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-net 0/5] Fix E825 initialization
Date: Mon, 30 Sep 2024 14:08:38 +0200
Message-ID: <20240930121022.671217-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking the
PHY
revision only for current PHY and adding proper destination device when
reading
port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as a primary
PHY
lane number, which is incorrect.

Jacob Keller (1):
  ice: Remove unnecessary offset calculation for PF scoped registers

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 drivers/net/ethernet/intel/ice/ice_common.c   |  42 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  33 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   5 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 335 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 +--
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 10 files changed, 261 insertions(+), 287 deletions(-)


base-commit: b93cdc8f443a8d1641f6cbd72349f7f877db314e
-- 
2.46.1


