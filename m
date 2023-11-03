Return-Path: <netdev+bounces-45846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2447DFEBE
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 06:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDA61C21032
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8A2D639;
	Fri,  3 Nov 2023 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KBzYBERU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7D17CA;
	Fri,  3 Nov 2023 05:33:35 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF71AD;
	Thu,  2 Nov 2023 22:33:32 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2Ls1h0012385;
	Thu, 2 Nov 2023 22:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=UReJLMLrvpJIa4FY1T75cC81B7xyCL36z25xAsooeqc=;
 b=KBzYBERUqyPLv09zJTmVwlH/8aSqrzWRRH2xISuN9VYsMTvi477PuWy6/Dh0p60AYhSP
 2flmh7Vx8AVm8ft06L51+638MQdk4BRUBHdPDSCqK/0nbz+eUUqP79P/CAtEwu7SY8QA
 hPIgvSPbivOnwn9Vm4QbtwNHkHamD9QP/uLImrFspTNQHJ1Cn3/7i/wMvHurO37rCtJ3
 44Zg+nau1tvkeTp/hlVu408537mwImhv1oDvf4pTQi/M+ZRX2Xfjh7PY8bNjLdkD0kDX
 NrvSS8kqB8TCXDxbdyf/CsoWfKeCfAou5cA9eBu1dwlmOjNYiKrLpN8FApF493AUqfgn Kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u4m34980w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 22:33:16 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 2 Nov
 2023 22:33:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 2 Nov 2023 22:33:14 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 590C83F7057;
	Thu,  2 Nov 2023 22:33:11 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <kuba@kernel.org>, <ndabilpuram@marvell.com>,
        <sgoutham@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v1 01/10] crypto: octeontx2: remove CPT block reset
Date: Fri, 3 Nov 2023 11:02:57 +0530
Message-ID: <20231103053306.2259753-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103053306.2259753-1-schalla@marvell.com>
References: <20231103053306.2259753-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nCuRpvPT4pSQO_aoFIjVQTeLPhTfIAtE
X-Proofpoint-GUID: nCuRpvPT4pSQO_aoFIjVQTeLPhTfIAtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_05,2023-11-02_03,2023-05-22_02

CPT block reset in CPT PF erase all the CPT configuration which is
done in AF driver init. So, remove CPT block reset from CPT PF as
it is also being done in AF init and not required in PF.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../marvell/octeontx2/otx2_cptpf_main.c       | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index e34223daa327..5436b0d3685c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -587,45 +587,6 @@ static int cpt_is_pf_usable(struct otx2_cptpf_dev *cptpf)
 	return 0;
 }
 
-static int cptx_device_reset(struct otx2_cptpf_dev *cptpf, int blkaddr)
-{
-	int timeout = 10, ret;
-	u64 reg = 0;
-
-	ret = otx2_cpt_write_af_reg(&cptpf->afpf_mbox, cptpf->pdev,
-				    CPT_AF_BLK_RST, 0x1, blkaddr);
-	if (ret)
-		return ret;
-
-	do {
-		ret = otx2_cpt_read_af_reg(&cptpf->afpf_mbox, cptpf->pdev,
-					   CPT_AF_BLK_RST, &reg, blkaddr);
-		if (ret)
-			return ret;
-
-		if (!((reg >> 63) & 0x1))
-			break;
-
-		usleep_range(10000, 20000);
-		if (timeout-- < 0)
-			return -EBUSY;
-	} while (1);
-
-	return ret;
-}
-
-static int cptpf_device_reset(struct otx2_cptpf_dev *cptpf)
-{
-	int ret = 0;
-
-	if (cptpf->has_cpt1) {
-		ret = cptx_device_reset(cptpf, BLKADDR_CPT1);
-		if (ret)
-			return ret;
-	}
-	return cptx_device_reset(cptpf, BLKADDR_CPT0);
-}
-
 static void cptpf_check_block_implemented(struct otx2_cptpf_dev *cptpf)
 {
 	u64 cfg;
@@ -643,10 +604,6 @@ static int cptpf_device_init(struct otx2_cptpf_dev *cptpf)
 
 	/* check if 'implemented' bit is set for block BLKADDR_CPT1 */
 	cptpf_check_block_implemented(cptpf);
-	/* Reset the CPT PF device */
-	ret = cptpf_device_reset(cptpf);
-	if (ret)
-		return ret;
 
 	/* Get number of SE, IE and AE engines */
 	ret = otx2_cpt_read_af_reg(&cptpf->afpf_mbox, cptpf->pdev,
-- 
2.25.1


