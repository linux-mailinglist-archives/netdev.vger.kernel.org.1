Return-Path: <netdev+bounces-44813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF2C7D9F2F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F047B211E4
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C43B783;
	Fri, 27 Oct 2023 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ7RnIW9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FF3B2B5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0C11B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429591; x=1729965591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rfvDaIHQOXJzi53BicUwM3OOOylKJNFeP4xAsxHLEY=;
  b=kJ7RnIW9Qw8pg2PfBRtNcKLuAmZkIuOdsSZ1fz/yhCcEzx5TOCKksYSd
   TQAba/rdBGzb6RW5IDxVjUSLD+gtnrx2z5G1VFgIckvCnk7HY+/WvcxNq
   f9urb9lggs2IekHVhaoKXsOiFsv5O/L6VaF1sIjaQE73fIfqPlesJxhxn
   OlHup6c1RCRepo1pYNuM0e+dVQ4QU8wKyK7/c6+JKaukzWlauC/0zrJs5
   Kd/BzEHWOWOPB8QXMgVEfqDHDURhyKiynw5L+d+oCpHfl12F2eTUmJ695
   atNMEvMJB9SsLPjD989U91HiLjB7KMvGjS4+hquB9fApJCcsVyQ4Ao7TB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695507"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695507"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064617"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064617"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:47 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 1/8] iavf: fix comments about old bit locks
Date: Fri, 27 Oct 2023 10:59:34 -0700
Message-ID: <20231027175941.1340255-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027175941.1340255-1-jacob.e.keller@intel.com>
References: <20231027175941.1340255-1-jacob.e.keller@intel.com>
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
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3431d9b064f8..fefed96f8035 100644
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


