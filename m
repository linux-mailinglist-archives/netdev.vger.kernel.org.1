Return-Path: <netdev+bounces-21866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB67651CC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235D61C215E4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D815AC1;
	Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E53156DA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A169271D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id D3FE2321B81;
	Thu, 27 Jul 2023 11:41:26 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQw-0002Yc-Lg;
	Thu, 27 Jul 2023 11:41:26 +0100
Subject: [PATCH net-next 09/11] sfc: Miscellaneous comment removals
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:26 +0100
Message-ID: <169045448657.9625.18095001657720834912.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove comments that only apply to Falcon and Siena.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_common.c |    5 -----
 drivers/net/ethernet/sfc/filter.h     |    7 -------
 drivers/net/ethernet/sfc/nic_common.h |    4 +---
 drivers/net/ethernet/sfc/selftest.c   |    7 +------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index c8d8f1e9a21a..175bd9cdfdac 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -35,11 +35,6 @@ MODULE_PARM_DESC(debug, "Bitmapped debugging message enable value");
 
 /* This is the time (in jiffies) between invocations of the hardware
  * monitor.
- * On Falcon-based NICs, this will:
- * - Check the on-board hardware monitor;
- * - Poll the link state and reconfigure the hardware as necessary.
- * On Siena-based NICs for power systems with EEH support, this will give EEH a
- * chance to start.
  */
 static unsigned int efx_monitor_interval = 1 * HZ;
 
diff --git a/drivers/net/ethernet/sfc/filter.h b/drivers/net/ethernet/sfc/filter.h
index 5f201a547e5b..0d45900afa76 100644
--- a/drivers/net/ethernet/sfc/filter.h
+++ b/drivers/net/ethernet/sfc/filter.h
@@ -30,13 +30,6 @@
  *
  * Only some combinations are supported, depending on NIC type:
  *
- * - Falcon supports RX filters matching by {TCP,UDP}/IPv4 4-tuple or
- *   local 2-tuple (only implemented for Falcon B0)
- *
- * - Siena supports RX and TX filters matching by {TCP,UDP}/IPv4 4-tuple
- *   or local 2-tuple, or local MAC with or without outer VID, and RX
- *   default filters
- *
  * - Huntington supports filter matching controlled by firmware, potentially
  *   using {TCP,UDP}/IPv{4,6} 4-tuple or local 2-tuple, local MAC or I/G bit,
  *   with or without outer and inner VID
diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
index 47b1c46c069d..466df5348b29 100644
--- a/drivers/net/ethernet/sfc/nic_common.h
+++ b/drivers/net/ethernet/sfc/nic_common.h
@@ -79,9 +79,7 @@ int efx_enqueue_skb_tso(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
 
 /* Decide whether to push a TX descriptor to the NIC vs merely writing
  * the doorbell.  This can reduce latency when we are adding a single
- * descriptor to an empty queue, but is otherwise pointless.  Further,
- * Falcon and Siena have hardware bugs (SF bug 33851) that may be
- * triggered if we don't check this.
+ * descriptor to an empty queue, but is otherwise pointless.
  * We use the write_count used for the last doorbell push, to get the
  * NIC's view of the tx queue.
  */
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 96d856b9043c..40d9bf642408 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -38,8 +38,7 @@
 /*
  * Loopback test packet structure
  *
- * The self-test should stress every RSS vector, and unfortunately
- * Falcon only performs RSS on TCP/UDP packets.
+ * The self-test should stress every RSS vector.
  */
 struct efx_loopback_payload {
 	char pad[2]; /* Ensures ip is 4-byte aligned */
@@ -581,10 +580,6 @@ efx_test_loopback(struct efx_tx_queue *tx_queue,
 	return 0;
 }
 
-/* Wait for link up. On Falcon, we would prefer to rely on efx_monitor, but
- * any contention on the mac lock (via e.g. efx_mac_mcast_work) causes it
- * to delay and retry. Therefore, it's safer to just poll directly. Wait
- * for link up and any faults to dissipate. */
 static int efx_wait_for_link(struct efx_nic *efx)
 {
 	struct efx_link_state *link_state = &efx->link_state;



