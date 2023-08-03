Return-Path: <netdev+bounces-24218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1E76F3FA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA96282371
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324E263DC;
	Thu,  3 Aug 2023 20:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55637263D9
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:20:18 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF274226
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:20:15 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373KCshO002919
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FsYaVKA1dPZ/VT/qtPdH8Fml8Ba9b1E03zRHSSSVrSg=;
 b=XTtOJV3HtoYHwZGreAGW2eyPfzI02vVekZKmy76FPqQTuZN9AX6be8Ckb5ciut7dAvpw
 UoiZT77g1PClU2SatdYvxwzjbtE0xNsQfscLJc37is+E+IkdzDhHRzGW3ZUjy3DNuHGc
 1VxbJ3RG549Sx2YurqRmWBpS25yYJsWILaDrmdJFmoSlldrXjH3KEbDAAbCQLS07DerE
 mPqdrGBEyoaR+Pa6JXHkRf+hVyn+bNFlS+i7KniH9mjnLnxd/KO5k5oK8Egwkn4IjVeB
 TzewbK7GWTnWP1e46eRyHvvgQhvSXvADFnDSmli1K5wegI2DNtIGsTeSNf3Bl/CF/3K9 ow== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8k2tr7ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373KJ4Om015559
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3ngh68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373KKCod43975108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 20:20:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EF925805C;
	Thu,  3 Aug 2023 20:20:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298FF5805A;
	Thu,  3 Aug 2023 20:20:12 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 20:20:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 5/5] ibmvnic: Ensure login failure recovery is safe from other resets
Date: Thu,  3 Aug 2023 15:20:10 -0500
Message-Id: <20230803202010.37149-5-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Dm9qyCbq3kUh-up_F91OU73BUkD4PFDK
X-Proofpoint-GUID: Dm9qyCbq3kUh-up_F91OU73BUkD4PFDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If a login request fails, the recovery process should be protected
against parallel resets. It is a known issue that freeing and
registering CRQ's in quick succession can result in a failover CRQ from
the VIOS. Processing a failover during login recovery is dangerous for
two reasons:
 1. This will result in two parallel initialization processes, this can
 cause serious issues during login.
 2. It is possible that the failover CRQ is received but never executed.
 We get notified of a pending failover through a transport event CRQ.
 The reset is not performed until a INIT CRQ request is received.
 Previously, if CRQ init fails during login recovery, then the ibmvnic
 irq is freed and the login process returned error. If failover_pending
 is true (a transport event was received), then the ibmvnic device
 would never be able to process the reset since it cannot receive the
 CRQ_INIT request due to the irq being freed. This leaved the device
 in a inoperable state.

Therefore, the login failure recovery process must be hardened against
these possible issues. Possible failovers (due to quick CRQ free and
init) must be avoided and any issues during re-initialization should be
dealt with instead of being propagated up the stack. This logic is
similar to that of ibmvnic_probe().

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 67 ++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8fd9639665a0..77df62511574 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
+static void flush_reset_queue(struct ibmvnic_adapter *adapter);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -1508,7 +1509,7 @@ static const char *adapter_state_to_string(enum vnic_state state)
 static int ibmvnic_login(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
-	unsigned long timeout = msecs_to_jiffies(20000);
+	unsigned long flags, timeout = msecs_to_jiffies(20000);
 	int retry_count = 0;
 	int retries = 10;
 	bool retry;
@@ -1590,27 +1591,52 @@ static int ibmvnic_login(struct net_device *netdev)
 			adapter->init_done_rc = 0;
 			retry_count++;
 			release_sub_crqs(adapter, true);
-			reinit_init_done(adapter);
-			release_crq_queue(adapter);
-			/* If we don't sleep here then we risk an unnecessary
-			 * failover event from the VIOS. This is a known VIOS
-			 * issue caused by a vnic device freeing and registering
-			 * a CRQ too quickly.
+			/* Much of this is similar logic as ibmvnic_probe(),
+			 * we are essentially re-initializing communication
+			 * with the server. We really should not run any
+			 * resets/failovers here because this is already a form
+			 * of reset and we do not want parallel resets occurring
 			 */
-			msleep(1500);
-			rc = init_crq_queue(adapter);
-			if (rc) {
-				netdev_err(netdev, "login recovery: init CRQ failed %d\n",
-					   rc);
-				return -EIO;
-			}
+			do {
+				reinit_init_done(adapter);
+				/* Clear any failovers we got in the previous
+				 * pass since we are re-initializing the CRQ
+				 */
+				adapter->failover_pending = false;
+				release_crq_queue(adapter);
+				/* If we don't sleep here then we risk an
+				 * unnecessary failover event from the VIOS.
+				 * This is a known VIOS issue caused by a vnic
+				 * device freeing and registering a CRQ too
+				 * quickly.
+				 */
+				msleep(1500);
+				/* Avoid any resets, since we are currently
+				 * resetting.
+				 */
+				spin_lock_irqsave(&adapter->rwi_lock, flags);
+				flush_reset_queue(adapter);
+				spin_unlock_irqrestore(&adapter->rwi_lock,
+						       flags);
+
+				rc = init_crq_queue(adapter);
+				if (rc) {
+					netdev_err(netdev, "login recovery: init CRQ failed %d\n",
+						   rc);
+					return -EIO;
+				}
 
-			rc = ibmvnic_reset_init(adapter, false);
-			if (rc) {
-				netdev_err(netdev, "login recovery: Reset init failed %d\n",
-					   rc);
-				return -EIO;
-			}
+				rc = ibmvnic_reset_init(adapter, false);
+				if (rc)
+					netdev_err(netdev, "login recovery: Reset init failed %d\n",
+						   rc);
+				/* IBMVNIC_CRQ_INIT will return EAGAIN if it
+				 * fails, since ibmvnic_reset_init will free
+				 * irq's in failure, we won't be able to receive
+				 * new CRQs so we need to keep trying. probe()
+				 * handles this similarly.
+				 */
+			} while (rc == -EAGAIN);
 		}
 	} while (retry);
 
@@ -1903,7 +1929,6 @@ static int ibmvnic_open(struct net_device *netdev)
 	int rc;
 
 	ASSERT_RTNL();
-
 	/* If device failover is pending or we are about to reset, just set
 	 * device state and return. Device operation will be handled by reset
 	 * routine.
-- 
2.39.3


