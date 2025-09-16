Return-Path: <netdev+bounces-223497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAEEB595B8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C1C189E0FC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BE30C611;
	Tue, 16 Sep 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gg5WpYN2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696328C874;
	Tue, 16 Sep 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024287; cv=none; b=jt/guoGsmB+iTU0fsmfauOV1p8wy4NHHYXe8EhL8uWRzyG6Oh3v13WbOejdMW7YQLeB5HSOW87VRZYEk95h66GKSFCbu84gT6S5OTQMjUSqs6l+IbH4dtiD+/MN3pHcqOmMcZ3HW6BVVQ7QVvJaATu80roZotXd5MeI16Vtd7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024287; c=relaxed/simple;
	bh=091+uRKmME6KAOrpbmaneoVUlfDGKsuRKM67n5HYTPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSM63cyuYITyiN7oIcj7FXz78f8IDQThl94ZPii3U8s1C6nayqku6wAZPjlUM+U0RpaoddRX/fCOndd2m8lleFkKMjC/PEusUJJ3UezYFI8gaPM5fgshYRpczES1O4k0/cHwCDwol7aHojZRQj8QYuLBd6YaV0GmEBzMLNcwNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gg5WpYN2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758024286; x=1789560286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=091+uRKmME6KAOrpbmaneoVUlfDGKsuRKM67n5HYTPY=;
  b=gg5WpYN2+33CUtsqiW28KZ3KVsEzAEnJa/H2u5Rd/BQyHhXy/YJC1viH
   jFv77pBe1ANL8PGTYI5TMGZYH+kYWOL/1F/nuqxdbOzSaze6RIqluWrBk
   HYF9OHIGXGljsR3/8BUNZoVxsngW2I16aZ6JzKkxbsS6jg3Qd4L54agEU
   BoV9SBZluuSxo+Y/+W/YXsKp1K9kDToIC21AUOn+0Gj2CiNiREPOStLw1
   jZryN1KQijC3UlAoBSPEVwBPMsvuy/Sq5wW2wDWB27eXqgNI2yhANdcf6
   El9xZwPPogvjlfLvXvQadgOYUkI+GqVz4L662rrWwoSxIJdmjrYTyYay+
   w==;
X-CSE-ConnectionGUID: WI18KvOURBOUGtjivShIgQ==
X-CSE-MsgGUID: CmVpjYWGT9CYEEgUINlGUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59347160"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="59347160"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:04:45 -0700
X-CSE-ConnectionGUID: qwuYFj+eQYS4YAc6i2UYkg==
X-CSE-MsgGUID: 327GSoTSRwmQNs6VcxgHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="180058272"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa005.jf.intel.com with ESMTP; 16 Sep 2025 05:04:44 -0700
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
Subject: [PATCH net v4 1/2] net: stmmac: replace memcpy with ethtool_puts in ethtool
Date: Tue, 16 Sep 2025 14:09:31 +0200
Message-Id: <20250916120932.217547-2-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916120932.217547-1-konrad.leszczynski@intel.com>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
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
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
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


