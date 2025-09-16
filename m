Return-Path: <netdev+bounces-223498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13DB595BF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26997B0BFD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EA30F7E4;
	Tue, 16 Sep 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdzFwBk9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519130DECC;
	Tue, 16 Sep 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024290; cv=none; b=ftR/h/u+c5ZHQh1DpTQzNEW+UBBpGMZNbhnKapeVwa/Vs5urmkFHn8uaVHHAE6ggsdAUW7DSqdpDF/C+N4cu38Nk2OejiordDs05IWupESMK9rZo3xXogKlSbZ+muSiuEZ3msfIKirFkU03epdyJ0Ul+r9lIL/qpLbv7uX43lbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024290; c=relaxed/simple;
	bh=b3IOQESW/mIXTD/yKAxdQFbR5Vp6zP2+u9V9iRgwxT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPR84LHbnGQsIIqX8KrnZ8sauaLHHzL9u3Cs7eBTS2CXQ8y6bS0XRsQU9FgfVjHlA61MmlLzCw9cdtjGMl/otWQSXIkbwHNgmMacrN7sln28i+fv7oMlpNP5VzMsnlPWgIxSOL/AFyr65RE/cs7t3hhrudIW4fucgh0ZiTG7yUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdzFwBk9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758024288; x=1789560288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b3IOQESW/mIXTD/yKAxdQFbR5Vp6zP2+u9V9iRgwxT0=;
  b=kdzFwBk9Jphqz6jUd5WtkhEuVB/6bEJImtK8nNCoSfAROgutmAjH71Nx
   ktyQnCe7Ow/AimGga+KgpCk0GU6HPlO9B7MjRT+rUQTN2rXwT4/ilSLG5
   YhZMB30HrBUvyyiAxF0g6kvIVry7HtHJvuuX2eoAaDsslqgvR/Ihi3coi
   NLfO6yYtEQ8sRZYKBZYNZLMK6PTBoDD5n1adSVZam7Tzw5QDvzigvgoPA
   Z5iVTTS43ElHUVU3xHqp3e70KpXG1hcQs2+9+49/HKQ6O5P1QGqc/L10W
   dgnij/MAzOmkzbsILodqBHUfeEKX1OVzW99zTuJ2I5zeHmWeuz7QrX7fM
   w==;
X-CSE-ConnectionGUID: 9YyGI2C+QZqYPdHoWjZAhQ==
X-CSE-MsgGUID: 1bD8nDRKSNKhgqLdPbRgqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59347171"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="59347171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:04:48 -0700
X-CSE-ConnectionGUID: ARg0KeKPT3y0lw2xkMzUOw==
X-CSE-MsgGUID: gAcgNXJuTP2ybjktJX/vkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="180058286"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa005.jf.intel.com with ESMTP; 16 Sep 2025 05:04:46 -0700
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
Subject: [PATCH net v4 2/2] net: stmmac: check if interface is running before TC block setup
Date: Tue, 16 Sep 2025 14:09:32 +0200
Message-Id: <20250916120932.217547-3-konrad.leszczynski@intel.com>
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

From: Karol Jurczenia <karol.jurczenia@intel.com>

If the interface is down before setting a TC block, the queues are already
disabled and setup cannot proceed.

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
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


