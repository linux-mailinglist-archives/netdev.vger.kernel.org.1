Return-Path: <netdev+bounces-215244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBDB2DC14
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AC672508F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975282E3B0D;
	Wed, 20 Aug 2025 12:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7D14AA9;
	Wed, 20 Aug 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691678; cv=none; b=dj/V1hoQFdcEVxJc1KIjKltGqOf0yVrP3KoObyluMTuqWQoobh533+cXQ0h2h+ic3NuWftJ8MaRZGQa5UXxwQoMNROVBYIoHR4uCUknqPl1q8VEMzVLX0k+vpnqYNhMzFMiiyqSTx9nLTSMG3B0pUuxaLnYrB4i4wBE6gkQEeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691678; c=relaxed/simple;
	bh=4WlTuZZPqKDf3XYz0wUxCidMfF6+jcgnmxaQa32GEms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqYWraO6dK9hA8t/LYrQCg6+CsC8r/TmqwpcASOF5U4lcuc+qGlK6vjGTwYSy6EOzXuGmH7ZiR5N8h6/LOQEsNLVbLg2x85/JDinRFr1o4s9uKOrlINePDSXj6p1+g7s/53YPlm96ex7Pj+7jDr8Ew35G78gkdmgPyHIwiKEoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6QDG0c02ztTbD;
	Wed, 20 Aug 2025 20:06:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0375F180B58;
	Wed, 20 Aug 2025 20:07:53 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 20:07:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] octeontx2-af: Remove unused declarations
Date: Wed, 20 Aug 2025 20:30:07 +0800
Message-ID: <20250820123007.1705047-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 1845ada47f6d ("octeontx2-af: cn10k: Add RPM LMAC pause frame
support") remove cgx_lmac_[s|g]et_pause_frm() and leave these unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 950231e7ea71..92ccf343dfe0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -161,10 +161,6 @@ int cgx_get_link_info(void *cgxd, int lmac_id,
 		      struct cgx_link_user_info *linfo);
 int cgx_lmac_linkup_start(void *cgxd);
 int cgx_get_fwdata_base(u64 *base);
-int cgx_lmac_get_pause_frm(void *cgxd, int lmac_id,
-			   u8 *tx_pause, u8 *rx_pause);
-int cgx_lmac_set_pause_frm(void *cgxd, int lmac_id,
-			   u8 tx_pause, u8 rx_pause);
 void cgx_lmac_ptp_config(void *cgxd, int lmac_id, bool enable);
 u8 cgx_lmac_get_p2x(int cgx_id, int lmac_id);
 int cgx_set_fec(u64 fec, int cgx_id, int lmac_id);
-- 
2.34.1


