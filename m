Return-Path: <netdev+bounces-223432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E659B591FB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8B7482336
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB85296BB0;
	Tue, 16 Sep 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vxd4kuen"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8F29BDB4;
	Tue, 16 Sep 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014428; cv=none; b=M4ND4yBDx+V8vi0kpfE1VE+0vk+RVOaZ05mO9DeV2jdUhwDcK56XNSSl/sXQoe+Vpd3yib9DOsuKyy66OgqNJ2279Pl6DojurNv9xKgp0MPwosi8i0QmHJUWl3VjOrvHQcdpgRHUz6rx0utSM3hAGaTYBjGEwI7fd369bpQrICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014428; c=relaxed/simple;
	bh=aWLd47MRoI/sjNgau3RpO0j0qsjD6QkgQ11E2+SOxIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEDK7nb2tOVnYo5chz3Xzm/WlbI6Is4YnTAZIg939O91J0eYAB1gLbsoDM0UbQVwmhCStxy6IjDoKLCIfYNV1rB+YFIk/QFWVsS5hYm1MtZa9O8xLaS7wVFUBRCXhT2BBD8e+aCj4wtoLIF+UtCQVb1HzpW8BNBybzlL0YaDqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vxd4kuen; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758014427; x=1789550427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWLd47MRoI/sjNgau3RpO0j0qsjD6QkgQ11E2+SOxIA=;
  b=Vxd4kuen5vTifKTAtULgYzh9AJMSjcHJMF2oSUIbxVb6JP8C4JE2iNVa
   F232w5UJTP9WKr4fbN9uSaW4bhwc/OFNfIcaogObUS1rv3j2bhWCFG9cV
   ML5EHw+Njuf4rii8/5ZK/x3WFvBbpvgoVMtP6Zpv1GzSYYyEuXwoz+oxe
   8SQwRSOtaGBSPEDheAhOuHSd5bJ3noY9L8Qg5MmFyo9uYMTFAp9LRQXv8
   9lviKwBJHUBEWtM6zO17gjo4eEkEc4xE5SE8phiireC6y+hX1eaBN5G6T
   KpFanBpmV/+BOtDXpHC3acJvShcZWVxlslu+M6QRt0zQSN6eqftC5QQaG
   A==;
X-CSE-ConnectionGUID: GlsMhUFkRKKpfFhUGRzYvg==
X-CSE-MsgGUID: X8VwbWSOTmGiIGKFT5nWzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70968809"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70968809"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:20:25 -0700
X-CSE-ConnectionGUID: tJ61g1MGTxqtjrUcSIXGIA==
X-CSE-MsgGUID: pD4hyALmSeCx2udQBKU0xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175305467"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2025 02:20:22 -0700
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
Subject: [PATCH net v3 2/2] net: stmmac: check if interface is running before TC block setup
Date: Tue, 16 Sep 2025 11:25:07 +0200
Message-Id: <20250916092507.216613-3-konrad.leszczynski@intel.com>
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

From: Karol Jurczenia <karol.jurczenia@intel.com>

If the interface is down before setting a TC block, the queues are already
disabled and setup cannot proceed.

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b16d1207b80..133ffdc91153 100644
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


