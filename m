Return-Path: <netdev+bounces-119163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA159546AD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F431C21754
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42017C9B8;
	Fri, 16 Aug 2024 10:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80917C9AF;
	Fri, 16 Aug 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803700; cv=none; b=hcogB5GHRaNLUimpOPC4+r/Kzgq9LN27jIcNnrKA81l7zXCl9CRpcaWyMDn+8zY4qGxsY25K7yGUwWHWDPwwR2ssWGSt/gpdx9AmFCU12dW6ro48Y0oIufXGuEyM+167xqMgFdgQmE6XLGEFHnubQgvtcMWyDLH8sCgGjd6SVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803700; c=relaxed/simple;
	bh=tEih0bc/qLZzpoH4PWAivHH79Ha5A9qootWZX5jTWsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U93P8BVl92evMY+XtYg0mdMdZcgXWxCcFMyCCOOAxoii39VdRZ2EbJxKOI4Z1bXOgfH/ec/yO7ERnTPoGqo4TyjcZuV0nzPOc6367AptYF7X9APGbO0W5874TNikYuJrItG0XOTM9WHeO2ohzV6r3Wpgxh8q/BJ0Q0pjup4pn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WldFP249gz1S84t;
	Fri, 16 Aug 2024 18:16:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F70714010C;
	Fri, 16 Aug 2024 18:21:36 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:21:35 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jeroendb@google.com>, <pkaligineedi@google.com>, <shailend@google.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <hramamurthy@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] gve: Remove unused declaration gve_rx_alloc_rings()
Date: Fri, 16 Aug 2024 18:19:06 +0800
Message-ID: <20240816101906.882743-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit f13697cc7a19 ("gve: Switch to config-aware queue allocation")
convert this function to gve_rx_alloc_rings_gqi().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/google/gve/gve.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 09a85ed59143..301fa1ea4f51 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1153,7 +1153,6 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 			  int idx);
 void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 			  struct gve_rx_alloc_rings_cfg *cfg);
-int gve_rx_alloc_rings(struct gve_priv *priv);
 int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_free_rings_gqi(struct gve_priv *priv,
-- 
2.34.1


