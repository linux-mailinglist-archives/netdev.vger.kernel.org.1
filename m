Return-Path: <netdev+bounces-223431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAECB591F7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E531B1899B69
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595AC29A310;
	Tue, 16 Sep 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yuc44s+B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214728D8F4;
	Tue, 16 Sep 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014424; cv=none; b=VsZ/+jNrbMIxV/TluF0Rz2mFAppJ/HdKdjj69ZGovXCpOTiqXWPfX/zcQpubeMBi0jY/caXi+l+uLOtaUEwbXIu1JQ/CMaZJIlaPColEgzrQM9rdz3QDOicBd+mmYrJIcpz86W18nzM+lgJ4qVIA7oQnl2jEZxW7SE/d7gr27xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014424; c=relaxed/simple;
	bh=m8x360kZGHLGHphewBXxu4SnJ1MPp8ssP/vidrNUQxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SaXqSXxfbaCg3mbqOoBT0Kxy/McxqX9UvDFPruFn6Ibv7Ap8NpuUOuv0K0WecK7MaWLNjJL0HaZ8kccS0iDOuXd98LruLBRv2hBtziO2j8fNwnAZZd9mj38YLVjQzmPdIUKq05VyURig/kINuOqOVXt3PV26BWh8036aEGJhqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yuc44s+B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758014423; x=1789550423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8x360kZGHLGHphewBXxu4SnJ1MPp8ssP/vidrNUQxk=;
  b=Yuc44s+Bccex9WIJE8EwnYbsMeg9aKCw9ahagtrIvJQtmZrqTYKPexuw
   zjrx3qVoyUHrMWco8lMFLxbCdvtBCzPwZAjAcM8GoK49IfaIejwjB/2z0
   Or4oCe8f1nnMi5uHhGUd7k5PkVKso7MR/s8brbDzu1qdTPkdTw55cOeIz
   NZD6faBdXCkrcD8/rhmao92SssoP7T0SDqZg+ncN0Bo0+cOIKYemSpWpr
   jWxo4ODzkVxLBG8AB224cnI4g3jxWt2cXL7jBtDDRXUcoIXJR41o3lLUu
   yzix4BjK9U/EYcHPI8ybHC6yG9WWv1rfapmWzGooHUgZ8OMZFzKmJimNB
   g==;
X-CSE-ConnectionGUID: 57v+SGAJQXWhpxh2m32teg==
X-CSE-MsgGUID: lPBPVjFLR4i4ZjOwZpO2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70968803"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70968803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:20:22 -0700
X-CSE-ConnectionGUID: TggIG4/zT5Wzj5DLutT1tg==
X-CSE-MsgGUID: K6eK5bBeR8qN3m3kttydpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175305462"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2025 02:20:20 -0700
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
Subject: [PATCH net v3 1/2] net: stmmac: replace memcpy with ethtool_puts in ethtool
Date: Tue, 16 Sep 2025 11:25:06 +0200
Message-Id: <20250916092507.216613-2-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916092507.216613-1-konrad.leszczynski@intel.com>
References: <20250916092507.216613-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel exception by replacing memcpy with ethtool_puts when used with
safety feature strings in ethtool logic.

[  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571

[  +0.000005] Call Trace:
[  +0.000004]  <TASK>
[  +0.000003]  dump_stack_lvl+0x6c/0x90
[  +0.000016]  print_report+0xce/0x610
[  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
[  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000101]  kasan_report+0xd4/0x110
[  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000102]  kasan_check_range+0x3a/0x1c0
[  +0.000010]  __asan_memcpy+0x24/0x70
[  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]

Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 77758a7299b4..d5a2b7e9b2a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -752,7 +752,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 				if (!stmmac_safety_feat_dump(priv,
 							&priv->sstats, i,
 							NULL, &desc)) {
-					memcpy(p, desc, ETH_GSTRING_LEN);
+					ethtool_puts(&p, desc);
 					p += ETH_GSTRING_LEN;
 				}
 			}
-- 
2.34.1


