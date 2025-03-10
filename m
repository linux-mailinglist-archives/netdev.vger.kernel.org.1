Return-Path: <netdev+bounces-173415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F2A58B89
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654EA3AA689
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713114F117;
	Mon, 10 Mar 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lmdk8Bs/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7491BD4E4;
	Mon, 10 Mar 2025 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583332; cv=none; b=DffN7yKLDS8DeWvvIDTQiIiqcMzhQ6za/mnmHMhVK2r7vjsbmPaHu4vVI55rpNkn9O3ipGA/Hllowjkkb/h+4A64fZaU+9e5dxJFxOEeBJp7aBWV/ogtA55W24K8UOHTl9OHxLAnhzTqB3lR4e0ag+UfONpT8I/aZBipNv9727c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583332; c=relaxed/simple;
	bh=vZk5dZKIa4Fkbt7Ox6MVoxXVuECx2sVWiZptJoBL78g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OeeFyJCJJpKgnuzFhStv/mNRsvW7azDnXSTeHjMxwNuraPUFKVnRRuZ8pK/dVOsSuIFQuAt3nN/xPje3Uta0Q2Pp1HM2hBrYIu3Kii+iUWecfsF7LDpn4YV6hdXoKq5kEIJTnN89WyjH8BwzfaT5UYg0aD1gh4D0eUSGJuUfPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lmdk8Bs/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741583330; x=1773119330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZk5dZKIa4Fkbt7Ox6MVoxXVuECx2sVWiZptJoBL78g=;
  b=Lmdk8Bs/XfrwUnaD47WXWwI206/2jp/0kZO0G2M5uktQLENbQ015hPpL
   YovYKcU3m2bbnQ1DqCRTReuNcbiKU6TOe+qsvBqHokA8Waq4R0GNDhBdt
   YVbUt6nIsWTC3Snitdevc23sVIXy/xzu1Ylr/QtYPsHSS1tsaeg5USlc7
   4zUD2jS+RffZ83HXATkYsdoWgX7gtidCxjy/4ASksQiTEgU8VW+Q5BDJn
   AOLnhulrVtrF+mA2IilCuvAdd0IzGuEbapiVNgFoDvbKWb60I3fLUbFAl
   GEBF/PLqZ9ismimAPH8Lc9mlK3x/tFo8Vig5cgLpUKtTjSGZss3+L7CUR
   Q==;
X-CSE-ConnectionGUID: RDViUJghTA25a/DhE+NwXA==
X-CSE-MsgGUID: VV1USEwjRwG1uOwwzBx20A==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42779845"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42779845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 22:08:49 -0700
X-CSE-ConnectionGUID: Gq4sFC+MRZCgyTTGigxMtg==
X-CSE-MsgGUID: HPWWkEnYTUCNLCdy22OdpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124050655"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by fmviesa003.fm.intel.com with ESMTP; 09 Mar 2025 22:08:47 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for return value in intel_tsn_lane_is_available()
Date: Mon, 10 Mar 2025 13:08:35 +0800
Message-Id: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the warning "warn: missing error code? 'ret'" in the
intel_tsn_lane_is_available() function.

The function now returns 0 to indicate that a TSN lane was found and
returns -EINVAL when it is not found.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 9c8de47ee149..5910571a954f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -494,10 +494,10 @@ static int intel_tsn_lane_is_available(struct net_device *ndev,
 			if ((rbuf.buf[0] >>
 				(4 * (intel_priv->tsn_lane_regs[j] % 8)) &
 					B_PCH_FIA_PCR_L0O) == 0xB)
-				return ret;
+				return 0;
 	}
 
-	return ret;
+	return -EINVAL;
 }
 
 static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs)
-- 
2.34.1


