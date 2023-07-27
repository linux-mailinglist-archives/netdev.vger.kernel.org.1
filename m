Return-Path: <netdev+bounces-21865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1687651C8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC36428223B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DFB156C8;
	Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AD154AD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38BC22710
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id D7226321AC7;
	Thu, 27 Jul 2023 11:40:48 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQK-0002XT-Mn;
	Thu, 27 Jul 2023 11:40:48 +0100
Subject: [PATCH net-next 02/11] sfc: Remove siena_nic_data and stats
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:40:48 +0100
Message-ID: <169045444861.9625.12040773949640122124.stgit@palantir17.mph.net>
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

These are no longer used, and the two  Siena specific functions are
no longer present in sfc.ko.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/nic.h |   95 ----------------------------------------
 1 file changed, 95 deletions(-)

diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index bd17962436ba..1db64fc6e909 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -23,97 +23,6 @@ enum {
 	PHY_TYPE_SFT9001B = 10,
 };
 
-enum {
-	SIENA_STAT_tx_bytes = GENERIC_STAT_COUNT,
-	SIENA_STAT_tx_good_bytes,
-	SIENA_STAT_tx_bad_bytes,
-	SIENA_STAT_tx_packets,
-	SIENA_STAT_tx_bad,
-	SIENA_STAT_tx_pause,
-	SIENA_STAT_tx_control,
-	SIENA_STAT_tx_unicast,
-	SIENA_STAT_tx_multicast,
-	SIENA_STAT_tx_broadcast,
-	SIENA_STAT_tx_lt64,
-	SIENA_STAT_tx_64,
-	SIENA_STAT_tx_65_to_127,
-	SIENA_STAT_tx_128_to_255,
-	SIENA_STAT_tx_256_to_511,
-	SIENA_STAT_tx_512_to_1023,
-	SIENA_STAT_tx_1024_to_15xx,
-	SIENA_STAT_tx_15xx_to_jumbo,
-	SIENA_STAT_tx_gtjumbo,
-	SIENA_STAT_tx_collision,
-	SIENA_STAT_tx_single_collision,
-	SIENA_STAT_tx_multiple_collision,
-	SIENA_STAT_tx_excessive_collision,
-	SIENA_STAT_tx_deferred,
-	SIENA_STAT_tx_late_collision,
-	SIENA_STAT_tx_excessive_deferred,
-	SIENA_STAT_tx_non_tcpudp,
-	SIENA_STAT_tx_mac_src_error,
-	SIENA_STAT_tx_ip_src_error,
-	SIENA_STAT_rx_bytes,
-	SIENA_STAT_rx_good_bytes,
-	SIENA_STAT_rx_bad_bytes,
-	SIENA_STAT_rx_packets,
-	SIENA_STAT_rx_good,
-	SIENA_STAT_rx_bad,
-	SIENA_STAT_rx_pause,
-	SIENA_STAT_rx_control,
-	SIENA_STAT_rx_unicast,
-	SIENA_STAT_rx_multicast,
-	SIENA_STAT_rx_broadcast,
-	SIENA_STAT_rx_lt64,
-	SIENA_STAT_rx_64,
-	SIENA_STAT_rx_65_to_127,
-	SIENA_STAT_rx_128_to_255,
-	SIENA_STAT_rx_256_to_511,
-	SIENA_STAT_rx_512_to_1023,
-	SIENA_STAT_rx_1024_to_15xx,
-	SIENA_STAT_rx_15xx_to_jumbo,
-	SIENA_STAT_rx_gtjumbo,
-	SIENA_STAT_rx_bad_gtjumbo,
-	SIENA_STAT_rx_overflow,
-	SIENA_STAT_rx_false_carrier,
-	SIENA_STAT_rx_symbol_error,
-	SIENA_STAT_rx_align_error,
-	SIENA_STAT_rx_length_error,
-	SIENA_STAT_rx_internal_error,
-	SIENA_STAT_rx_nodesc_drop_cnt,
-	SIENA_STAT_COUNT
-};
-
-/**
- * struct siena_nic_data - Siena NIC state
- * @efx: Pointer back to main interface structure
- * @wol_filter_id: Wake-on-LAN packet filter id
- * @stats: Hardware statistics
- * @vf: Array of &struct siena_vf objects
- * @vf_buftbl_base: The zeroth buffer table index used to back VF queues.
- * @vfdi_status: Common VFDI status page to be dmad to VF address space.
- * @local_addr_list: List of local addresses. Protected by %local_lock.
- * @local_page_list: List of DMA addressable pages used to broadcast
- *	%local_addr_list. Protected by %local_lock.
- * @local_lock: Mutex protecting %local_addr_list and %local_page_list.
- * @peer_work: Work item to broadcast peer addresses to VMs.
- */
-struct siena_nic_data {
-	struct efx_nic *efx;
-	int wol_filter_id;
-	u64 stats[SIENA_STAT_COUNT];
-#ifdef CONFIG_SFC_SRIOV
-	struct siena_vf *vf;
-	struct efx_channel *vfdi_channel;
-	unsigned vf_buftbl_base;
-	struct efx_buffer vfdi_status;
-	struct list_head local_addr_list;
-	struct list_head local_page_list;
-	struct mutex local_lock;
-	struct work_struct peer_work;
-#endif
-};
-
 enum {
 	EF10_STAT_port_tx_bytes = GENERIC_STAT_COUNT,
 	EF10_STAT_port_tx_packets,
@@ -302,8 +211,4 @@ int efx_ef10_tx_tso_desc(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
 extern const struct efx_nic_type efx_hunt_a0_nic_type;
 extern const struct efx_nic_type efx_hunt_a0_vf_nic_type;
 
-/* Global Resources */
-void siena_prepare_flush(struct efx_nic *efx);
-void siena_finish_flush(struct efx_nic *efx);
-
 #endif /* EFX_NIC_H */



