Return-Path: <netdev+bounces-24395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E4770099
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ECE282670
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FFBE4E;
	Fri,  4 Aug 2023 12:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A4A940
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:57:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DEC11B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:57:09 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHQgk2jxzzrS4X;
	Fri,  4 Aug 2023 20:56:02 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 20:57:07 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jan.sokolowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] i40e: Remove unused function declarations
Date: Fri, 4 Aug 2023 20:55:25 +0800
Message-ID: <20230804125525.20244-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit f62b5060d670 ("i40e: fix mac address checking") left behind
i40e_validate_mac_addr() declaration.
Also the other declarations are declared but never implemented in
commit 56a62fc86895 ("i40e: init code and hardware support").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 .../net/ethernet/intel/i40e/i40e_prototype.h    | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index fe845987d99a..3eeee224f1fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -18,7 +18,6 @@
 /* adminq functions */
 int i40e_init_adminq(struct i40e_hw *hw);
 void i40e_shutdown_adminq(struct i40e_hw *hw);
-void i40e_adminq_init_ring_data(struct i40e_hw *hw);
 int i40e_clean_arq_element(struct i40e_hw *hw,
 			   struct i40e_arq_event_info *e,
 			   u16 *events_pending);
@@ -51,7 +50,6 @@ i40e_asq_send_command_atomic_v2(struct i40e_hw *hw,
 void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 		   void *desc, void *buffer, u16 buf_len);
 
-void i40e_idle_aq(struct i40e_hw *hw);
 bool i40e_check_asq_alive(struct i40e_hw *hw);
 int i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
 const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
@@ -117,9 +115,6 @@ int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
 int i40e_aq_get_link_info(struct i40e_hw *hw,
 			  bool enable_lse, struct i40e_link_status *link,
 			  struct i40e_asq_cmd_details *cmd_details);
-int i40e_aq_set_local_advt_reg(struct i40e_hw *hw,
-			       u64 advt_reg,
-			       struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_send_driver_version(struct i40e_hw *hw,
 				struct i40e_driver_version *dv,
 				struct i40e_asq_cmd_details *cmd_details);
@@ -269,9 +264,6 @@ int i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_dcb_updated(struct i40e_hw *hw,
 			struct i40e_asq_cmd_details *cmd_details);
-int i40e_aq_config_switch_comp_bw_limit(struct i40e_hw *hw,
-					u16 seid, u16 credit, u8 max_bw,
-					struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw, u16 seid,
 			     struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
 			     struct i40e_asq_cmd_details *cmd_details);
@@ -350,7 +342,6 @@ i40e_aq_configure_partition_bw(struct i40e_hw *hw,
 int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
 int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
 			 u32 pba_num_size);
-int i40e_validate_mac_addr(u8 *mac_addr);
 void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable);
 /* prototype for functions used for NVM access */
 int i40e_init_nvm(struct i40e_hw *hw);
@@ -425,14 +416,6 @@ i40e_virtchnl_link_speed(enum i40e_aq_link_speed link_speed)
 /* prototype for functions used for SW locks */
 
 /* i40e_common for VF drivers*/
-void i40e_vf_parse_hw_config(struct i40e_hw *hw,
-			     struct virtchnl_vf_resource *msg);
-int i40e_vf_reset(struct i40e_hw *hw);
-int i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
-			   enum virtchnl_ops v_opcode,
-			   int v_retval,
-			   u8 *msg, u16 msglen,
-			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_set_filter_control(struct i40e_hw *hw,
 			    struct i40e_filter_control_settings *settings);
 int i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
-- 
2.34.1


