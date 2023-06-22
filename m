Return-Path: <netdev+bounces-13182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A073A8C2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BE31C211E2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD6206BC;
	Thu, 22 Jun 2023 19:03:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375111F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:03:43 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790C9B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:03:42 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MIxF97028343
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pkZAoD5L3xBStAbkZ8c4g5Y7FjKkfK+8rWJAJWYdkpo=;
 b=gGrxiurbSORPmQz7u3dBas9NEB6BkcGz7anbOEniGcPnZogXrW3yjuodiiLVgHD2A1eL
 5yPopCOABNyE6aBOsqE5S6pzzJdKgjNRaUUQIn2kXGutBGKBoIW4T0WKAe44XLN1i4ot
 Is1i/ZaLioh5FxBet77PYdNrb3KCw83Nx2T5qiE4BxzQoDYPECwOg8AE/11vWrMV5oji
 tvOBUDjdIHMeDwpgm/3sIv8Yt49uBKGcLgxcpQLvSmfS938TS5xpyT0FbLoaOhMIvLy6
 BOJUth910NSRG0XNjgk59/66qSdxoC4HxefkrUgLkqYg4hx2tN4rQxBc2KZlEyDObyrm Pg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcum4rp2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:03:41 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGwMAK009539
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:03:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r94f71xk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:03:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MJ3cf550200892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jun 2023 19:03:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8277B5805B;
	Thu, 22 Jun 2023 19:03:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B6415804B;
	Thu, 22 Jun 2023 19:03:38 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jun 2023 19:03:38 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Date: Thu, 22 Jun 2023 14:03:32 -0500
Message-Id: <20230622190332.29223-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cFY7ehC2iG4ljlUTxgPS1M4hO69p_HcD
X-Proofpoint-ORIG-GUID: cFY7ehC2iG4ljlUTxgPS1M4hO69p_HcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_14,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=922 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All ibmvnic resets, make a call to netdev_tx_reset_queue() when
re-opening the device. netdev_tx_reset_queue() resets the num_queued
and num_completed byte counters. These stats are used in Byte Queue
Limit (BQL) algorithms. The difference between these two stats tracks
the number of bytes currently sitting on the physical NIC. ibmvnic
increases the number of queued bytes though calls to
netdev_tx_sent_queue() in the drivers xmit function. When, VIOS reports
that it is done transmitting bytes, the ibmvnic device increases the
number of completed bytes through calls to netdev_tx_completed_queue().
It is important to note that the driver batches its transmit calls and
num_queued is increased every time that an skb is added to the next
batch, not necessarily when the batch is sent to VIOS for transmission.

Unlike other reset types, a NON FATAL reset will not flush the sub crq
tx buffers. Therefore, it is possible for the batched skb array to be
partially full. So if there is call to netdev_tx_reset_queue() when
re-opening the device, the value of num_queued (0) would not account
for the skb's that are currently batched. Eventually, when the batch
is sent to VIOS, the call to netdev_tx_completed_queue() would increase
num_completed to a value greater than the num_queued. This causes a
BUG_ON crash:

ibmvnic 30000002: Firmware reports error, cause: adapter problem.
Starting recovery...
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
ibmvnic 30000002: tx error 600
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:27!
Oops: Exception in kernel mode, sig: 5
[....]
NIP dql_completed+0x28/0x1c0
LR ibmvnic_complete_tx.isra.0+0x23c/0x420 [ibmvnic]
Call Trace:
ibmvnic_complete_tx.isra.0+0x3f8/0x420 [ibmvnic] (unreliable)
ibmvnic_interrupt_tx+0x40/0x70 [ibmvnic]
__handle_irq_event_percpu+0x98/0x270
---[ end trace ]---

Therefore, do not reset the dql stats when performing a NON_FATAL reset.
Simply clearing the queues off bit is sufficient.

Fixes: 0d973388185d ("ibmvnic: Introduce xmit_more support using batched subCRQ hcalls")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c63d3ec9d328..5523ab52ff2b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1816,7 +1816,18 @@ static int __ibmvnic_open(struct net_device *netdev)
 		if (prev_state == VNIC_CLOSED)
 			enable_irq(adapter->tx_scrq[i]->irq);
 		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
-		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
+		/* netdev_tx_reset_queue will reset dql stats and set the stacks
+		 * flag for queue status. During NON_FATAL resets, just
+		 * clear the bit, don't reset the stats because there could
+		 * be batched skb's waiting to be sent. If we reset dql stats,
+		 * we risk num_completed being greater than num_queued.
+		 * This will cause a BUG_ON in dql_completed().
+		 */
+		if (adapter->reset_reason == VNIC_RESET_NON_FATAL)
+			clear_bit(__QUEUE_STATE_STACK_XOFF,
+				  &netdev_get_tx_queue(netdev, i)->state);
+		else
+			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
 	}
 
 	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
-- 
2.31.1


