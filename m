Return-Path: <netdev+bounces-217688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E748BB398EC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F51C27217
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5223019A5;
	Thu, 28 Aug 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIzwNo/D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C83009E1;
	Thu, 28 Aug 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375077; cv=none; b=fDvt1fhSw8poIGmsjXC9j/Z8IC8+tivsIC/zq8grLVCAudoAmmpdXTtJETD2oCTWmmMunqOGRouHXUImCsJGXMJqP/+6DBo1jThSF2fldxTciupL9G2vgeO7535fQClbmoqZtgS9BB9/wXVxJgzvfHENFre9CsJw8uIpRnV+rgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375077; c=relaxed/simple;
	bh=4I8hXM8cu9p2nIU0MIxeEd31GffzsYuGhLCQpjlSPPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYihP5kXp6f6ISONonOpMkghsXB2AWCjIw01+DQnz58GGGd/KapOJ/gj4YZ3LchyNaJUtP3BCzWCxQVvwg5KG4w14iypFpMxOjlA1sgU/8Fei2AGAcZnDg2KkiL15u9LvyKfQijzB1wbm+Ydr67PODXEWSHN/nmQF+16kAZm55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIzwNo/D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375076; x=1787911076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4I8hXM8cu9p2nIU0MIxeEd31GffzsYuGhLCQpjlSPPg=;
  b=lIzwNo/Dddds75lwXlgZu2wxUlccYFvnix+bnLQZQOAkFotkAuzAe/yw
   ulfsINgOLJG5820MefcmGhLXIgliHAdOWzl+9TFvIqdC8OA1cSEIFlALg
   MYaNkOVJPRRwA832i7HiCGjlytNrTjsx+9uj82YYXw0AawkDlzP0t4S/F
   Laowgv4/hcTWehn97VRTrVejvLxUv4y/QoY+88kWU2xB0mWdYMz4UkgRQ
   NKVsywFlghLlr4sho+6rezxzp1arI0gI77ByOBkbWksQg6Z4BitmM48A5
   hNtbFdB22xGBKToYVHqZKetJ98ZvXC7htGNJdx4NfFuyLa8mmn1dMPQLq
   A==;
X-CSE-ConnectionGUID: YG8NVrj+SkeTp69kWykk9g==
X-CSE-MsgGUID: OkNJf/NUSFq2S7si5CgzkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69735027"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69735027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:57:55 -0700
X-CSE-ConnectionGUID: +ti/OfwaReu5HEvNt0PtnA==
X-CSE-MsgGUID: fJB39fa6TyuDx4YLWrziGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170467396"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 02:57:53 -0700
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
Subject: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in ethtool
Date: Thu, 28 Aug 2025 12:02:35 +0200
Message-Id: <20250828100237.4076570-2-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel exception by replacing memcpy with strscpy when used with
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

Fixes: 8bf993a5877e8a0a ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 77758a7299b4..0433be4bd0c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -752,7 +752,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 				if (!stmmac_safety_feat_dump(priv,
 							&priv->sstats, i,
 							NULL, &desc)) {
-					memcpy(p, desc, ETH_GSTRING_LEN);
+					strscpy(p, desc, ETH_GSTRING_LEN);
 					p += ETH_GSTRING_LEN;
 				}
 			}
-- 
2.34.1


