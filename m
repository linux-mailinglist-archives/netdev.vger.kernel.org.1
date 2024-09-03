Return-Path: <netdev+bounces-124519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8C969D79
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1283E28575F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE71D096C;
	Tue,  3 Sep 2024 12:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4F1C986A
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366371; cv=none; b=N7GBqCKiNRM8vcpHyLYg7CUdw62cleuFyyzL4cQenAcYp3lGwvlfKNcgI5k5Q8r5d2gVGKN3bQXdTmgDT5Kr0rL/+aKbjvvAwJMvo5h2Yxv1kF2z6te6pk9xpidgNjKeSjmih+re5Q3gj3fCYwP/X6N8HHeHMVlCun58v9CWVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366371; c=relaxed/simple;
	bh=QHfFBXEGPu5n+fWZsBKVMLqXVG2PukqNplc7NDkvSbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7viLfAhNoVs73hp4Qc1ACgb2+Ljigy4u88YbeDixrg96ERbUWo84ONLW7QYp92595MmqwT7JbZ3sZtsRUP2Z7V871aQc8+DwMxTjGqSIBqCVgzYckqNatdkXh+3yFoN1QIg0vxd2GUtGwxC4NS8TLPdDfhSMvW0XYRSlw71I3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WylFj6h4XzyRNt;
	Tue,  3 Sep 2024 20:25:29 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id F015018010A;
	Tue,  3 Sep 2024 20:26:06 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 20:26:06 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ahmed.zaki@intel.com>, <yuehaibing@huawei.com>, <richardcochran@gmail.com>,
	<michal.swiatkowski@linux.intel.com>, <amritha.nambiar@intel.com>,
	<mateusz.polchlopek@intel.com>, <jacob.e.keller@intel.com>,
	<maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/3] igb: Cleanup unused declarations
Date: Tue, 3 Sep 2024 20:22:33 +0800
Message-ID: <20240903122234.964218-3-yuehaibing@huawei.com>
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

e1000_init_function_pointers_82575() is never implemented and used since
commit 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver").
And commit 9835fd7321a6 ("igb: Add new function to read part number from
EEPROM in string format") removed igb_read_part_num() implementation.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.h | 1 -
 drivers/net/ethernet/intel/igb/e1000_nvm.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.h b/drivers/net/ethernet/intel/igb/e1000_mac.h
index 6e110f28f922..529b7d18b662 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.h
@@ -63,6 +63,5 @@ enum e1000_mng_mode {
 
 #define E1000_MNG_DHCP_COOKIE_STATUS_VLAN	0x2
 
-void e1000_init_function_pointers_82575(struct e1000_hw *hw);
 
 #endif
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.h b/drivers/net/ethernet/intel/igb/e1000_nvm.h
index 091cddf4ada8..4f652ab713b3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.h
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.h
@@ -7,7 +7,6 @@
 s32  igb_acquire_nvm(struct e1000_hw *hw);
 void igb_release_nvm(struct e1000_hw *hw);
 s32  igb_read_mac_addr(struct e1000_hw *hw);
-s32  igb_read_part_num(struct e1000_hw *hw, u32 *part_num);
 s32  igb_read_part_string(struct e1000_hw *hw, u8 *part_num,
 			  u32 part_num_size);
 s32  igb_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data);
-- 
2.34.1


