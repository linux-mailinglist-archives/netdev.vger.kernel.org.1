Return-Path: <netdev+bounces-217690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A5B398F0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6521C362A50
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC070304966;
	Thu, 28 Aug 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjfAi3HO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F943043C6;
	Thu, 28 Aug 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375081; cv=none; b=P+GMxbvqs+S6Rj3W6irHpLlTd4C1s/rnRoyImSy4ED3mnUYUoyFXq/ZIuY2rNpzQy8qyCk+kFxR3y00YYtMLjMhFjycxVYqt3iYJx+axI72Qu2CZdHgkPQ8CK1MxBtw8ydfvF921FHDdLDVRISEc9Vt+Gf0DGnOAK8E7B8JTewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375081; c=relaxed/simple;
	bh=6Rpzd2bCzeU18tHUglFTTigNymZLIvAxuOf1baLDvqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7OrfZTHEefamdQZSdh/KCN5oG7+o+JKj1F8Z1xc0cB97V+zxrO+ukcoAgkXAXcyB3Ycfw32qUgF7sUBQOD2mtGshVVkqTqj9N3hFfsi2z9Y8Z+ho6iBUqi8fxrNeyzSrrE8so65dgzx9nr36Y++VWRYsPcwgbU8oBfvygTSFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjfAi3HO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375080; x=1787911080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Rpzd2bCzeU18tHUglFTTigNymZLIvAxuOf1baLDvqE=;
  b=NjfAi3HO+0a8lw5A1t8rhLR8wjvl9EMMD41HtS1HeMzetfOyFiOTquSk
   6LF+Lv1h05XCTRjdormYarjWLILFhsBP2xNBIBmO+L6tPAyPcJK8avSks
   OREK/WIVI9ffuB7A2CyLKdPMrjqkKl6ZzpN7vqKSl5h8oNFiC4VEYNXjU
   6jawJ/w6CKzDet1YPDank9lFlNMxnZ0oWV7Gvrocg7AkV4EeCDVMzeEn8
   v6tkW8StM/Gkqm8m+7XlmfNamdGZjJFs0Kbg+sko8LkV82/RhC/Ie3coM
   uE7rBR3/sfm+c9lIqyfZei4ZIS+cTO+NZ5SDM3CsA/m/shjwKqTRxXRST
   w==;
X-CSE-ConnectionGUID: PGknEm2ZSKexEYi6ao1PCQ==
X-CSE-MsgGUID: Pq7lrk3GTNyoi6GcrOC/CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69735041"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69735041"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:58:00 -0700
X-CSE-ConnectionGUID: oCtXkiiIRMaepyz+z9LSTQ==
X-CSE-MsgGUID: nHGCfUf5RoOqch4YxiUugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170467422"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 02:57:58 -0700
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
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net 3/3] net: stmmac: check if interface is running before TC block setup
Date: Thu, 28 Aug 2025 12:02:37 +0200
Message-Id: <20250828100237.4076570-4-konrad.leszczynski@intel.com>
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

From: Karol Jurczenia <karol.jurczenia@intel.com>

If the interface is down before setting a TC block, the queues are already
disabled and setup cannot proceed.

Fixes: 4dbbe8dde8485b89 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 70c3dd88a749..202a157a1c90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6247,6 +6247,9 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 	struct stmmac_priv *priv = cb_priv;
 	int ret = -EOPNOTSUPP;
 
+	if (!netif_running(priv->dev))
+		return -EINVAL;
+
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
 		return ret;
 
-- 
2.34.1


