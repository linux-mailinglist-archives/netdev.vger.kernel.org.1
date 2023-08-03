Return-Path: <netdev+bounces-24219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BE76F3FB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1742823A0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88226B0A;
	Thu,  3 Aug 2023 20:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165C26B07
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:20:18 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874264229
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:20:16 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373KB6Gp010192
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7sI/QErqFobe3fCHLMewVX2bEwujINCfGqOQpNeK+84=;
 b=n6wMicuHydXGCOzlyRWZs0VA5a308OJYwFi7z0sVQINyZYfn07YJS/MB7kVDFSqSZyQp
 FUIMOWg2dPE196EGJs0ACToLIWBK0nltbCvILdswQzD0RVJJtZodXcJhFpWm/gIL9Jzs
 7o5VJJiLGa9GKPUkZPsJuIKyiq13vow94Cc/d0Xiln1eH3UbEULtYewYvK5oUADvA4nX
 OMPRWablD9IMGI2Hik4c/IBPec8+OCnkvumVmw0HuVlSWkTv7cBXgEZIMRNFBFZaOGMw
 SFtBInZds5VfiTAwjwdGX2DOtPzj5u3d/qWY+UXBQCLhPuLrt8TolOhyDkskwyv7icgS eQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8k23gmm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373JSI2c014553
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5ft1yvs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373KKBOS2097810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 20:20:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2995805C;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CF475805A;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 2/5] ibmvnic: Unmap DMA login rsp buffer on send login fail
Date: Thu,  3 Aug 2023 15:20:07 -0500
Message-Id: <20230803202010.37149-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230803202010.37149-1-nnac123@linux.ibm.com>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u75qdyhIvXuX4S-Xgq87GjbCccYAW0jn
X-Proofpoint-ORIG-GUID: u75qdyhIvXuX4S-Xgq87GjbCccYAW0jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=648 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the LOGIN CRQ fails to send then we must DMA unmap the response
buffer. Previously, if the CRQ failed then the memory was freed without
DMA unmapping.

Fixes: c98d9cc4170d ("ibmvnic: send_login should check for crq errors")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 996f8037c266..fdc0bac029ad 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4830,11 +4830,14 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	if (rc) {
 		adapter->login_pending = false;
 		netdev_err(adapter->netdev, "Failed to send login, rc=%d\n", rc);
-		goto buf_rsp_map_failed;
+		goto buf_send_failed;
 	}
 
 	return 0;
 
+buf_send_failed:
+	dma_unmap_single(dev, rsp_buffer_token, rsp_buffer_size,
+			 DMA_FROM_DEVICE);
 buf_rsp_map_failed:
 	kfree(login_rsp_buffer);
 	adapter->login_rsp_buf = NULL;
-- 
2.39.3


