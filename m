Return-Path: <netdev+bounces-223526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F02B5966A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB6D4E4E92
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577D3101AE;
	Tue, 16 Sep 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrnXy6MV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A230E820;
	Tue, 16 Sep 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026604; cv=none; b=qxXk7md5lb+HDSldmtMAkpP6qjw9zdI46IxpVRB6niOY6glAGfnEmAaUteO1Jgu5lwc/yTmkI5w39JcsTdJ3zaJy/v/ADY8q6QMMcsM1ZE2tO7b7FTnD0Y/1tv6NlB1AcMOx0G7GCmJ19SjdI5Trd7/p/OsoM9n9rihqR2aZNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026604; c=relaxed/simple;
	bh=aImNmXjsN2O2aGFxgJn2xM8g3wIE4iAJiPsnA1ZcdCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mH9ojj2KS+7V3byN3sFB0+iC3Kf5EdpEGzrG2LxAaeVHR509N8zAw97f9RmryQ/GpHrs0h1gmmOCxE4oDqn+sucKD0Uw/UZwCGIM13w2Q1megyxrbZxleZG9qL7uDBA+qHr5zs7mkFTES7HkSI1pZVObURQW4cMXO0bxMalRLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrnXy6MV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026603; x=1789562603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aImNmXjsN2O2aGFxgJn2xM8g3wIE4iAJiPsnA1ZcdCs=;
  b=FrnXy6MVYrVPqAzu1bi8OTk4UFCXcYyOGhXbD3fNorX2wH/BlfOsKpAV
   NEgakyaf8Vjm6lQnuVhU8xZ9YlodweRdzvEqzXT3ZZUsoerAvxJ8v9JXR
   l+24/dqUquPySm8YPLRq986raBtFVMFcE3pLdKEs/iLe32GDXksb0312q
   rHwM7CHpcQGqDTVW9bPJi29Vx8NC3cYdH8e53+ycJYCpZhj8XKNTI5gv4
   1U3OZR7oJo4F95m7rEOTKlOQinOBY/crEWu0gtfapByTOpJSLse8iZASw
   RuKt7AKPlG0YUbglOJuulYQZxiYqRn5YP8dS8WMEDSRzOWi28SyZSL0Jz
   A==;
X-CSE-ConnectionGUID: 0HbWdJhbRtGbktWnr0+epQ==
X-CSE-MsgGUID: tvRztKeLQIW8ltphVlNwBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85742004"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85742004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:43:23 -0700
X-CSE-ConnectionGUID: FLW3iRpvRQOWzKNrB2aRig==
X-CSE-MsgGUID: 4Yb2Ds/sQripu548mqWIhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174043163"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa006.jf.intel.com with ESMTP; 16 Sep 2025 05:43:20 -0700
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
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next v3 1/3] net: stmmac: enhance VLAN protocol detection for GRO
Date: Tue, 16 Sep 2025 14:48:06 +0200
Message-Id: <20250916124808.218514-2-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916124808.218514-1-konrad.leszczynski@intel.com>
References: <20250916124808.218514-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Warpechowski <piotr.warpechowski@intel.com>

Enhance protocol extraction in stmmac_has_ip_ethertype() by introducing
MAC offset parameter and changing:

__vlan_get_protocol() ->  __vlan_get_protocol_offset()

Add correct header length for VLAN tags, which enable Generic Receive
Offload (GRO) in VLAN.

Co-developed-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa3d26c28502..4df967500cd3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4566,13 +4566,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
  */
 static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
 {
-	int depth = 0;
+	int depth = 0, hlen;
 	__be16 proto;
 
-	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
-				    &depth);
+	proto = __vlan_get_protocol_offset(skb, skb->protocol,
+					   skb_mac_offset(skb), &depth);
+	hlen = eth_type_vlan(skb->protocol) ? VLAN_ETH_HLEN : ETH_HLEN;
 
-	return (depth <= ETH_HLEN) &&
+	return (depth <= hlen) &&
 		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
 }
 
-- 
2.34.1


