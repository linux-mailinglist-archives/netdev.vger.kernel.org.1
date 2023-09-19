Return-Path: <netdev+bounces-35034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3C7A695D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6C2281744
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928CD36B09;
	Tue, 19 Sep 2023 17:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD454347B4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:04:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8BC6
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695143094; x=1726679094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aip84ohK6VsM/gFOdcb7Z5Fcgpux6G0e6pdJx9Pzbug=;
  b=A05ESYjscoQ8elablnh5T5fj1QAD6cvr9quRanta1n09i4nU21u2IgMd
   19gCK4ZZgLTCoVpN/aV7c8D2dgJe3MpiioStsz1AIZaSiv74sUKkFzZ0v
   SXXMX/5mZ9VxvXdPYNtFQzszGeT+W/lFp0PIyPC+JJpQtYxwOYEhtW75y
   /CZ/KyuCEP61WldV9XqJLnp7y/Ig3TlSryLdf/hIaTNqEkpMZcwXeT4yL
   602Zs3a/Zo2M9hfanwXCtTW1CBHHolB6WqftKxMWKNFcUawFZkXHgdk1o
   JMTP5jUpMJTVi+5anF4Q7hE/dEAIyNIBf4bEtK2gLiURx+6dwo2NEWjsa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446468586"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="446468586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 10:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746311718"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746311718"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 10:04:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next] ethernet/intel: Use list_for_each_entry() helper
Date: Tue, 19 Sep 2023 10:04:09 -0700
Message-Id: <20230919170409.1581074-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinjie Ruan <ruanjinjie@huawei.com>

Convert list_for_each() to list_for_each_entry() where applicable.

No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c      | 7 ++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 76b34cee1da3..2ac9dffd0bf8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7857,7 +7857,6 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
-	struct list_head *pos;
 	struct vf_mac_filter *entry = NULL;
 	int ret = 0;
 
@@ -7878,8 +7877,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	switch (info) {
 	case E1000_VF_MAC_FILTER_CLR:
 		/* remove all unicast MAC filters related to the current VF */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -7889,8 +7887,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 		break;
 	case E1000_VF_MAC_FILTER_ADD:
 		/* try to find empty slot in the list */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->free)
 				break;
 		}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 29cc60988071..4c6e2a485d8e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -639,12 +639,10 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
 	struct vf_macvlans *entry;
-	struct list_head *pos;
 	int retval = 0;
 
 	if (index <= 1) {
-		list_for_each(pos, &adapter->vf_mvs.l) {
-			entry = list_entry(pos, struct vf_macvlans, l);
+		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -664,8 +662,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 
 	entry = NULL;
 
-	list_for_each(pos, &adapter->vf_mvs.l) {
-		entry = list_entry(pos, struct vf_macvlans, l);
+	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 		if (entry->free)
 			break;
 	}
-- 
2.38.1


