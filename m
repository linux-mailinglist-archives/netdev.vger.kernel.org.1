Return-Path: <netdev+bounces-131413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3498E798
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D969B22DDB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141238C;
	Thu,  3 Oct 2024 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUHB16ew"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18F23D7
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914482; cv=none; b=sH5tbziAcih0sKvMBGtLSFPUu60kFR9H9rTsrmCJm7tJ/mVSr9FSpx4SxqzHNwyj8IwkzzAf+hleAef485hdOyB+ewXC7BYZn7Jh/JRTo5zyQk2p8bYq6wguztOAV32gbkCnayRrtcANAu3gPYaQDmhZyxRiGKEJfAI0wk2P1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914482; c=relaxed/simple;
	bh=DneuTuUYLBE0k951t0HkLFw6jjz7ut0bTKct6HGfE3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvm4Ob5azWCELoseSSFcNONCFq7QBnvPilUYJ89z+sNAP5RD1LlXwXiIM0GFi2tc7UCfarTQxN2NUk0qcKTl5TgZJimB7V5MAzkmVtWI9L/BjzCLkJk+vYMbpne/DYcPk/7ivnOkL+AWyaGCmT27iins00WABy+pRQ39yqMuqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUHB16ew; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727914480; x=1759450480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DneuTuUYLBE0k951t0HkLFw6jjz7ut0bTKct6HGfE3U=;
  b=QUHB16ewOy4nHuA4cY98KeigzGGAIxUJXwDmr9Yl/Wz7r44yBjIHG8ZN
   ERjUiX5SGanFURQ1/zxNHCzfGXA+YlXAP9HzAmU5l9veb/CInAOK9fGUV
   cmfEi+ynITfSmRnUE5OIqxuDV5EXXnHSjVs8QkgHGPYtzj+/Li6ot3JSL
   hech0qLo6oHpkzHCqVaqLPNUnYggIpd38UfDEr+S1C1X6KUz1icW7K5PU
   QGKeS/7YFTngk/AQIwrdnbmWzkT8jWOapAJe9rs8J/ZrbP2JxaJIWmYl3
   Xj+JEHYukZUtGAdqPSzB/mTBM5DxCGHc8WOBD5j6yuIJwXdXzT68jETHM
   w==;
X-CSE-ConnectionGUID: FocG+p8LTcSfEa0/ymoatg==
X-CSE-MsgGUID: P9ZuZZvUSdOqkUHJrJ9+8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30893412"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="30893412"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:14:40 -0700
X-CSE-ConnectionGUID: 6r6NeTnwQHCvAPGbrjN2og==
X-CSE-MsgGUID: uYDMMWQqQVKTXovHezryHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="78594571"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 17:14:38 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.128])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CF50612668;
	Thu,  3 Oct 2024 01:14:36 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 0/2] Refactor sending DDP + E830 support
Date: Thu,  3 Oct 2024 02:10:30 +0200
Message-ID: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors sending DDP segments in accordance to computing
"last" bit of AQ request (1st patch), then adds support for extended
format ("valid" + "last" bits in a new "flags" field) of DDP that was
changed to support Multi-Segment DDP packages needed by E830.

v1:
adjusted authorship, rebase, minor kdoc fix
https://lore.kernel.org/intel-wired-lan/20240911110926.25384-4-przemyslaw.kitszel@intel.com

Przemek Kitszel (2):
  ice: refactor "last" segment of DDP pkg
  ice: support optional flags in signature segment header

 drivers/net/ethernet/intel/ice/ice_ddp.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 292 ++++++++++++-----------
 2 files changed, 160 insertions(+), 137 deletions(-)


base-commit: f2589ad16e14b7102f1411e3385a2abf07076406
-- 
2.46.0


