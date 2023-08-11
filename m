Return-Path: <netdev+bounces-26751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAC778C70
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457302821A0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5D5693;
	Fri, 11 Aug 2023 10:50:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F61865
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:50:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9347F9
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:50:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMgVC6FWGzqSff;
	Fri, 11 Aug 2023 18:47:31 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:50:23 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: e1000: Remove unused declarations
Date: Fri, 11 Aug 2023 18:50:05 +0800
Message-ID: <20230811105005.7692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 675ad47375c7 ("e1000: Use netdev_<level>, pr_<level> and dev_<level>")
declared but never implemented e1000_get_hw_dev_name().
Commit 1532ecea1deb ("e1000: drop dead pcie code from e1000")
removed e1000_check_mng_mode()/e1000_blink_led_start() but not the declarations.
Commit c46b59b241ec ("e1000: Remove unused function e1000_mta_set.")
removed e1000_mta_set() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000.h    | 1 -
 drivers/net/ethernet/intel/e1000/e1000_hw.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 4817eb13ca6f..75f3fd1d8d6e 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -347,6 +347,5 @@ bool e1000_has_link(struct e1000_adapter *adapter);
 void e1000_power_up_phy(struct e1000_adapter *);
 void e1000_set_ethtool_ops(struct net_device *netdev);
 void e1000_check_options(struct e1000_adapter *adapter);
-char *e1000_get_hw_dev_name(struct e1000_hw *hw);
 
 #endif /* _E1000_H_ */
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.h b/drivers/net/ethernet/intel/e1000/e1000_hw.h
index b57a04954ccf..95cdd17134e5 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.h
@@ -343,7 +343,6 @@ struct e1000_host_mng_dhcp_cookie {
 };
 #endif
 
-bool e1000_check_mng_mode(struct e1000_hw *hw);
 s32 e1000_read_eeprom(struct e1000_hw *hw, u16 reg, u16 words, u16 * data);
 s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw);
 s32 e1000_update_eeprom_checksum(struct e1000_hw *hw);
@@ -352,7 +351,6 @@ s32 e1000_read_mac_addr(struct e1000_hw *hw);
 
 /* Filters (multicast, vlan, receive) */
 u32 e1000_hash_mc_addr(struct e1000_hw *hw, u8 * mc_addr);
-void e1000_mta_set(struct e1000_hw *hw, u32 hash_value);
 void e1000_rar_set(struct e1000_hw *hw, u8 * mc_addr, u32 rar_index);
 void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value);
 
@@ -361,7 +359,6 @@ s32 e1000_setup_led(struct e1000_hw *hw);
 s32 e1000_cleanup_led(struct e1000_hw *hw);
 s32 e1000_led_on(struct e1000_hw *hw);
 s32 e1000_led_off(struct e1000_hw *hw);
-s32 e1000_blink_led_start(struct e1000_hw *hw);
 
 /* Adaptive IFS Functions */
 
-- 
2.34.1


