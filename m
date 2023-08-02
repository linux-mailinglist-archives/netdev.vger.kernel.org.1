Return-Path: <netdev+bounces-23609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E076CB4A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067021C208E7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3A63D7;
	Wed,  2 Aug 2023 10:52:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578E5697
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:52:43 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1B1BD;
	Wed,  2 Aug 2023 03:52:42 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3729FC7u015426;
	Wed, 2 Aug 2023 03:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=t4uuEf0Rdqki78Zrbxaj+3q3dQ9rrzkccpAd/gVC1/E=;
 b=Fr/9hpKaFI1U/rUIl+AzcHOmXQqmJhxgfVHUPly5Ta9NwsNTlWnMBLx73SI7XFG5J5kK
 cfJ+j719qMI4D4WM26lw4JjqDQst9OeAOpd3/ddFOtHJ7KXuCmZWJY1fnLaCW5U4Qk4s
 hIKlvtHqjus4oXo1wiv0qfm5clgTxW1cYpl1zjKUCqJKf8XyGGPzKUoR9WrX2fqk8PEa
 EWmg6ZwQdDDs+pmiFGs3HyPsoigN2QPxxPVa54diTV1QhDcB9xlqXXL4uJ0pAoH5ve3j
 KdZGWv1wTRAkubqLJRWHqnxCPC9lUcb8pQdj3LiW+L7r8+FBekEUsjXzz6ZUilMHG27u 0A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529kc918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 03:52:35 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 2 Aug
 2023 03:52:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 2 Aug 2023 03:52:33 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3D42F3F7086;
	Wed,  2 Aug 2023 03:52:29 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Date: Wed, 2 Aug 2023 16:22:27 +0530
Message-ID: <20230802105227.3691713-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Du8bMgPQRCRyS_7yw1zxAB20XxjgtS7q
X-Proofpoint-ORIG-GUID: Du8bMgPQRCRyS_7yw1zxAB20XxjgtS7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

page_pool_init() return error on requesting ring size > 32K.
PF uses page pool for rx. octeon-tx2 Supported queue size
are 16, 64, 256, 1K, 2K, 4K, 16K, 64K. If user try to
configure larger ring size for rx, return error.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index c47d91da32dc..978e371008d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -378,7 +378,7 @@ static void otx2_get_ringparam(struct net_device *netdev,
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	struct otx2_qset *qs = &pfvf->qset;
 
-	ring->rx_max_pending = Q_COUNT(Q_SIZE_MAX);
+	ring->rx_max_pending = 16384; /* Page pool support on RX */
 	ring->rx_pending = qs->rqe_cnt ? qs->rqe_cnt : Q_COUNT(Q_SIZE_256);
 	ring->tx_max_pending = Q_COUNT(Q_SIZE_MAX);
 	ring->tx_pending = qs->sqe_cnt ? qs->sqe_cnt : Q_COUNT(Q_SIZE_4K);
-- 
2.25.1


