Return-Path: <netdev+bounces-43094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8887D1655
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798F6282698
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A422326;
	Fri, 20 Oct 2023 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcehIks0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C222323
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:38:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C07D65
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697830683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W3RsnyeipnBfFTo07NnrzIlV7yB7g314ddY+RHz4USc=;
	b=bcehIks0CZEbK0GBey0HZXKkiU+itwfc1TC3defbb+ZEJ9y6JwaYzeRZaWn7yA9OCwL5wf
	wThe4KYRlyJX/99BOxPdq2ngigvISYgH0Oh5rxwFCCzXCOwbH79GzHmyvVmxptKdlwjYSS
	rrQK5nlTMkngiL0ZDbuXl1cWmj6nurE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-Wn8qypecNgCyS0PD6FYezg-1; Fri, 20 Oct 2023 15:37:49 -0400
X-MC-Unique: Wn8qypecNgCyS0PD6FYezg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20A1C3C1016C;
	Fri, 20 Oct 2023 19:37:49 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 341A7C15BB8;
	Fri, 20 Oct 2023 19:37:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	mschmidt@redhat.com,
	dacampbe@redhat.com,
	poros@redhat.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 1/6] i40e: Remove unused flags
Date: Fri, 20 Oct 2023 21:37:37 +0200
Message-ID: <20231020193746.2274379-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The flag I40E_FLAG_RX_CSUM_ENABLED and I40E_HW_FLAG_DROP_MODE are
set and never read. Remove them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 57 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +-
 4 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f86a4241eca2..6e3e2a6d18c4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -501,33 +501,32 @@ struct i40e_pf {
 #define I40E_HW_RESTART_AUTONEG			BIT(18)
 
 	u32 flags;
-#define I40E_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40E_FLAG_MSI_ENABLED			BIT(1)
-#define I40E_FLAG_MSIX_ENABLED			BIT(2)
-#define I40E_FLAG_RSS_ENABLED			BIT(3)
-#define I40E_FLAG_VMDQ_ENABLED			BIT(4)
-#define I40E_FLAG_SRIOV_ENABLED			BIT(5)
-#define I40E_FLAG_DCB_CAPABLE			BIT(6)
-#define I40E_FLAG_DCB_ENABLED			BIT(7)
-#define I40E_FLAG_FD_SB_ENABLED			BIT(8)
-#define I40E_FLAG_FD_ATR_ENABLED		BIT(9)
-#define I40E_FLAG_MFP_ENABLED			BIT(10)
-#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(11)
-#define I40E_FLAG_VEB_MODE_ENABLED		BIT(12)
-#define I40E_FLAG_VEB_STATS_ENABLED		BIT(13)
-#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(14)
-#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(15)
-#define I40E_FLAG_LEGACY_RX			BIT(16)
-#define I40E_FLAG_PTP				BIT(17)
-#define I40E_FLAG_IWARP_ENABLED			BIT(18)
-#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(19)
-#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT(20)
-#define I40E_FLAG_TC_MQPRIO			BIT(21)
-#define I40E_FLAG_FD_SB_INACTIVE		BIT(22)
-#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(23)
-#define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
-#define I40E_FLAG_RS_FEC			BIT(25)
-#define I40E_FLAG_BASE_R_FEC			BIT(26)
+#define I40E_FLAG_MSI_ENABLED			BIT(0)
+#define I40E_FLAG_MSIX_ENABLED			BIT(1)
+#define I40E_FLAG_RSS_ENABLED			BIT(2)
+#define I40E_FLAG_VMDQ_ENABLED			BIT(3)
+#define I40E_FLAG_SRIOV_ENABLED			BIT(4)
+#define I40E_FLAG_DCB_CAPABLE			BIT(5)
+#define I40E_FLAG_DCB_ENABLED			BIT(6)
+#define I40E_FLAG_FD_SB_ENABLED			BIT(7)
+#define I40E_FLAG_FD_ATR_ENABLED		BIT(8)
+#define I40E_FLAG_MFP_ENABLED			BIT(9)
+#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(10)
+#define I40E_FLAG_VEB_MODE_ENABLED		BIT(11)
+#define I40E_FLAG_VEB_STATS_ENABLED		BIT(12)
+#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(13)
+#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(14)
+#define I40E_FLAG_LEGACY_RX			BIT(15)
+#define I40E_FLAG_PTP				BIT(16)
+#define I40E_FLAG_IWARP_ENABLED			BIT(17)
+#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(18)
+#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT(19)
+#define I40E_FLAG_TC_MQPRIO			BIT(20)
+#define I40E_FLAG_FD_SB_INACTIVE		BIT(21)
+#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(22)
+#define I40E_FLAG_DISABLE_FW_LLDP		BIT(23)
+#define I40E_FLAG_RS_FEC			BIT(24)
+#define I40E_FLAG_BASE_R_FEC			BIT(25)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
@@ -549,8 +548,8 @@ struct i40e_pf {
  *   the link is being brought down by clearing bit (I40E_AQ_PHY_ENABLE_LINK)
  *   in abilities field of i40e_aq_set_phy_config structure
  */
-#define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
+#define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(26)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 9ce6e633cc2f..9a5a47b29bb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -555,10 +555,8 @@ static void i40e_set_hw_flags(struct i40e_hw *hw)
 
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 8)) {
+	     aq->api_min_ver >= 8))
 		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
-		hw->flags |= I40E_HW_FLAG_DROP_MODE;
-	}
 
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f24d2e13fcd1..b44d8d8b0474 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12733,9 +12733,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	u16 pow;
 
 	/* Set default capability flags */
-	pf->flags = I40E_FLAG_RX_CSUM_ENABLED |
-		    I40E_FLAG_MSI_ENABLED     |
-		    I40E_FLAG_MSIX_ENABLED;
+	pf->flags = I40E_FLAG_MSI_ENABLED | I40E_FLAG_MSIX_ENABLED;
 
 	/* Set default ITR */
 	pf->rx_itr_default = I40E_ITR_RX_DEF;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 2a5c7aec0bb1..2c791b7342b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -553,8 +553,7 @@ struct i40e_hw {
 #define I40E_HW_FLAG_FW_LLDP_STOPPABLE      BIT_ULL(4)
 #define I40E_HW_FLAG_FW_LLDP_PERSISTENT     BIT_ULL(5)
 #define I40E_HW_FLAG_AQ_PHY_ACCESS_EXTENDED BIT_ULL(6)
-#define I40E_HW_FLAG_DROP_MODE              BIT_ULL(7)
-#define I40E_HW_FLAG_X722_FEC_REQUEST_CAPABLE BIT_ULL(8)
+#define I40E_HW_FLAG_X722_FEC_REQUEST_CAPABLE BIT_ULL(7)
 	u64 flags;
 
 	/* Used in set switch config AQ command */
-- 
2.41.0


