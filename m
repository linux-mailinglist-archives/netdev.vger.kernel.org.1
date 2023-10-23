Return-Path: <netdev+bounces-43669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6D7D430B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3E1281784
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27524203;
	Mon, 23 Oct 2023 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVEmqDSr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D38241EC
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3ED6E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102513; x=1729638513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IF4LtnoFFw474oiyqhttWtt+NSaWvIV7mObjAtNW/uk=;
  b=WVEmqDSr0xs3wQT4vIir1uVX7YV/KanONF83p/ir/aJFYjfmJa2LKWGV
   lLSl0cOoIXG4MD3pNakGO42nDFDN1yGiIvTmObCmjIUf6og26QmgmqlDH
   kkNEvfPFa6EGiN2skbbaG+PT5A3X1CdMKEzmHNwTmDMZxRaKEFinP5X0l
   DGgSTcj3EmnJKZkaPZ0ge97DSrO7jLCdfwXgtNeJfX3RPeie3HPkvJCsP
   ndUYP64PWiyxCSerHgpSrufURwwX906E19AVaWjYZYkJ3oaPuB4Zb/eee
   aay46mRRBszXQfrs9XXOWyJQYrg55194rC5DQWVgQu1yT8FeuuyISzc4k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573699"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288319"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288319"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/9] iavf: fix comments about old bit locks
Date: Mon, 23 Oct 2023 16:08:18 -0700
Message-ID: <20231023230826.531858-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

Bit lock __IAVF_IN_CRITICAL_TASK does not exist anymore since commit
5ac49f3c2702 ("iavf: use mutexes for locking of critical sections").
Adjust the comments accordingly.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7fb7dfe6e13f..8bfa928ab415 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1276,7 +1276,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
  * iavf_up_complete - Finish the last steps of bringing up a connection
  * @adapter: board private structure
  *
- * Expects to be called while holding the __IAVF_IN_CRITICAL_TASK bit lock.
+ * Expects to be called while holding crit_lock.
  **/
 static void iavf_up_complete(struct iavf_adapter *adapter)
 {
@@ -1400,7 +1400,7 @@ static void iavf_clear_adv_rss_conf(struct iavf_adapter *adapter)
  * iavf_down - Shutdown the connection processing
  * @adapter: board private structure
  *
- * Expects to be called while holding the __IAVF_IN_CRITICAL_TASK bit lock.
+ * Expects to be called while holding crit_lock.
  **/
 void iavf_down(struct iavf_adapter *adapter)
 {
-- 
2.41.0


