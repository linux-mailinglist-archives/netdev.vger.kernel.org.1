Return-Path: <netdev+bounces-223430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B2DB591F4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264EE1892E5C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8828CF6B;
	Tue, 16 Sep 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k347z4iR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DF293C42;
	Tue, 16 Sep 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014422; cv=none; b=iSHbTmyMzD8AW3zcwl31xXYjtWr/xZYLg9iI/mZNgiRJU4YVdD1TAyS+X9+BzEkHw7NJd2f7hnEneaEr1MQjHnEd9PqmeKUWe6Y4akhqXZz954aJR0uD6gS0OdFriRKh/wo4XR0iqtjEto9X9l5aX9g+TEPiAqHFK8sCFHOi4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014422; c=relaxed/simple;
	bh=PYRtsKKlk71SL/z5M5anOiie0aM4UoUdGei9v0FY4Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2xKtocTwfKI2T4SOxEFzjgKNLnEFMOFPHVA0xi0PMCSTQS2qaGzTBoRnfC8jEK7INIrkPRtYPv/RWK4ZS6fkgutm4cAAlTA93ysdZ1bpBH7BXrhTvR7jNBsuEAHNHXsrvHZje4IYBLTMFKoa0KigIkILZWyMF7clHWveaZHcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k347z4iR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758014421; x=1789550421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PYRtsKKlk71SL/z5M5anOiie0aM4UoUdGei9v0FY4Rs=;
  b=k347z4iRSst+msImu4+AInmTHRuB3JZLr98259ZJVQbACjEQ1trcIrgi
   Swegpzlbc/N+nEsAMarQugh5vcOv/xFJ+9MUz2R0WqquLeXKQTcA/x+SI
   hiBTe/BAeX05LQ8UJb9jiXYRu/FybTLQSStOlhJP44ysRU0ZY+vTsfzwY
   qgsNnpDnM4PgHQr4vA0+B5ozf8vx24qZSp6s0q9rSPe9AF4zTWjuRsK94
   U8h6DbkaEs1g6q24q13iNUt8j/bnGjzJUWGNu8sUSDNla21phlHKG6xs4
   i8cYfkBmnHXHyjrYeANjP/Ka2zmEy1uXS73bN+L/dUMtAj/ZfKZWmMRoW
   Q==;
X-CSE-ConnectionGUID: lTiUHeCpRMyG0z+ydwd+8w==
X-CSE-MsgGUID: SezNMtlXQFC/eWwF6WB8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70968787"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70968787"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:20:20 -0700
X-CSE-ConnectionGUID: 1Osfe51tSa24/hA75jk0YA==
X-CSE-MsgGUID: BIBMYOUiQdqaFGstlHjl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175305455"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2025 02:20:18 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net v3 0/2] net: stmmac: misc fixes
Date: Tue, 16 Sep 2025 11:25:05 +0200
Message-Id: <20250916092507.216613-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds two fixes addressing KASAN panic on ethtool usage and
flow stop on TC block setup when interface down.

Patchset has been created as a result of discussion at [1].

v2 can be found at [2].

[1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
[2] https://lore.kernel.org/netdev/20250828100237.4076570-1-konrad.leszczynski@intel.com/

v2 -> v3:
- replace strcpy with ethtool_puts per suggestion
- removed extension patch for printing enhanced descriptors

v1 -> v2:
- add missing Fixes lines
- add missing SoB lines
- removed all non-fix patches. These will be sent in separate series

Karol Jurczenia (1):
  net: stmmac: check if interface is running before TC block setup

Konrad Leszczynski (1):
  net: stmmac: replace memcpy with ethtool_puts in ethtool

 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


