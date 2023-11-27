Return-Path: <netdev+bounces-51191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46E7F97CA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A1280E0E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD041FD2;
	Mon, 27 Nov 2023 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aA8LJwFe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3458111;
	Sun, 26 Nov 2023 19:05:07 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQMgDf8013706;
	Sun, 26 Nov 2023 19:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=h/R/dVUGgxW3ENwZfZqJ0RIXBUZJtaPBzkXTFm9h7lY=;
 b=aA8LJwFe0V/m9ivVvRlOO8OmLjtTyDekuVBa4CbqeMa9S7YPAykn2ixGZsUQvtJrSzCD
 Hx1nobL9WPNH0tgPDijawhyEfBH9Np4O9gjkxNtVcspM+vhWmcV6bdND8JKI0fSlsG+d
 oF+mNKd4rupV2OSmxOspenRLp+kOUSlA9s4o+NmMTNyYhLiyTOmC3v78uVYklRyqs5LV
 W4+oLWnyU00lxnGKLNVFX2GaXCREcv1fkN8zYyX9TIS+zHzhUbdY/73p8K/hfoCBISX6
 FAylLWnrapJMRxzF1WsWEiJEanIgtYaXf5K6bcD63dB0FvOpj9owKzg9cCYk6SRBuDmR QA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ukf5x3bm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 19:05:00 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Nov
 2023 19:04:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 26 Nov 2023 19:04:58 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 6A2C83F7080;
	Sun, 26 Nov 2023 19:04:55 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v2 PATCH 5/5] octeontx2-af: Update Tx link register range
Date: Mon, 27 Nov 2023 08:34:35 +0530
Message-ID: <20231127030435.17278-6-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231127030435.17278-1-gakula@marvell.com>
References: <20231127030435.17278-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: cKfJYs99TnZuIPhDApsUyfbNlHPn67AC
X-Proofpoint-ORIG-GUID: cKfJYs99TnZuIPhDApsUyfbNlHPn67AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02

From: Rahul Bhansali <rbhansali@marvell.com>

On new silicons the TX channels for transmit level has increased.
This patch fixes the respective register offset range to
configure the newly added channels.

Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v1-v2:
 Fixed autor name.

 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
index b3150f053291..d46ac29adb96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
@@ -31,8 +31,8 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
 	{NIX_TXSCH_LVL_TL4, 3, 0xFFFF, {{0x0B00, 0x0B08}, {0x0B10, 0x0B18},
 			      {0x1200, 0x12E0} } },
 	{NIX_TXSCH_LVL_TL3, 4, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
-			      {0x1610, 0x1618}, {0x1700, 0x17B0} } },
-	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
+			      {0x1610, 0x1618}, {0x1700, 0x17C8} } },
+	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17C8} } },
 	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
 };
 
-- 
2.25.1


