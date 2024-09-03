Return-Path: <netdev+bounces-124520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DED969D7A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FFB285765
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDE1D1F65;
	Tue,  3 Sep 2024 12:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D201C7688
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366371; cv=none; b=ijQEe9lnWmBTKSzWgvp5GWkO9xuHPou1ogdx0tOnPEWmnD7IWVG/tBIXDQ2KFtGHVLnP3EJu53L7XZ/W6vlp0n0iqiG/AfPEi9eg3htCbXe/XWzcy4dizpZdDsm5Z4WKiSXRq6kohbUEPs9F38LmwSgoi+6R9BSGJQdscZkVnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366371; c=relaxed/simple;
	bh=VUNx6WChmy6oNiK4yYR4fkCLYhLNDwgt/fMffk5GBeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTzlDK7S+qgqEjlE79wIpsmUGy6uQ1+726bX5WZs+2F/6Xu87l8gr9QxI3QfFN4n8mx4w6oiauVd1msQKMeS9tkcy7nwj6zdJx2MPUoIHYwMiqk8K7FSfrRM1MKFjDwPHJpjOTau5z9+RokSwIAALUm/1l6iFOFDmQ99dQXBdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WylD56MpSz1xwpy;
	Tue,  3 Sep 2024 20:24:05 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4118114011F;
	Tue,  3 Sep 2024 20:26:06 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 20:26:05 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ahmed.zaki@intel.com>, <yuehaibing@huawei.com>, <richardcochran@gmail.com>,
	<michal.swiatkowski@linux.intel.com>, <amritha.nambiar@intel.com>,
	<mateusz.polchlopek@intel.com>, <jacob.e.keller@intel.com>,
	<maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/3] iavf: Remove unused declarations
Date: Tue, 3 Sep 2024 20:22:32 +0800
Message-ID: <20240903122234.964218-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903122234.964218-1-yuehaibing@huawei.com>
References: <20240903122234.964218-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

There is no caller and implementation in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h           | 10 ----------
 drivers/net/ethernet/intel/iavf/iavf_prototype.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 48cd1d06761c..95b1d8f62304 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -529,22 +529,16 @@ static inline void iavf_change_state(struct iavf_adapter *adapter,
 		iavf_state_str(adapter->state));
 }
 
-int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
-void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
-void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
-void iavf_napi_add_all(struct iavf_adapter *adapter);
-void iavf_napi_del_all(struct iavf_adapter *adapter);
-
 int iavf_send_api_ver(struct iavf_adapter *adapter);
 int iavf_verify_api_ver(struct iavf_adapter *adapter);
 int iavf_send_vf_config_msg(struct iavf_adapter *adapter);
@@ -555,11 +549,9 @@ void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
 void iavf_configure_queues(struct iavf_adapter *adapter);
-void iavf_deconfigure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-int iavf_request_queues(struct iavf_adapter *adapter, int num);
 void iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
@@ -579,8 +571,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
 int iavf_config_rss(struct iavf_adapter *adapter);
-int iavf_lan_add_device(struct iavf_adapter *adapter);
-int iavf_lan_del_device(struct iavf_adapter *adapter);
 void iavf_enable_channels(struct iavf_adapter *adapter);
 void iavf_disable_channels(struct iavf_adapter *adapter);
 void iavf_add_cloud_filter(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 48c3901381b4..cac9d1a35a52 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -18,7 +18,6 @@
 /* adminq functions */
 enum iavf_status iavf_init_adminq(struct iavf_hw *hw);
 enum iavf_status iavf_shutdown_adminq(struct iavf_hw *hw);
-void iavf_adminq_init_ring_data(struct iavf_hw *hw);
 enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 					struct iavf_arq_event_info *e,
 					u16 *events_pending);
@@ -33,8 +32,6 @@ bool iavf_asq_done(struct iavf_hw *hw);
 void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask,
 		   void *desc, void *buffer, u16 buf_len);
 
-void iavf_idle_aq(struct iavf_hw *hw);
-void iavf_resume_aq(struct iavf_hw *hw);
 bool iavf_check_asq_alive(struct iavf_hw *hw);
 enum iavf_status iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading);
 const char *iavf_aq_str(struct iavf_hw *hw, enum iavf_admin_queue_err aq_err);
-- 
2.34.1


