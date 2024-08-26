Return-Path: <netdev+bounces-122074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36395FD65
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22201F2246E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E819FA94;
	Mon, 26 Aug 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5KJTXE5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399884A2F
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712423; cv=none; b=Ub8dbm+TsAdxsl6pLaEdlLe6U2lpvPRolwLcuOP71wigX2UtlTBDhw7C6graA0HRf/MokbpR1OUOCznjh6H1G9ASz6lid7gj8zq+1PcWwm5d+g2RhUEbT+tCzo0a/nowadRLKM6lKHT07GHG/mCGjjdHumtQe6xIm6z1AUYpLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712423; c=relaxed/simple;
	bh=FRloS1J3dVkNQRDNRHzR1RTq9/eQ1Na8LgWHdyx29as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmF+0JK4ykLg83AZ6VO80C1kE7PARSvB7j2rfj42sMY41THyW1GEchZLcuJTmAIl9QMNeLeiA1gdbkCXrwPSiuCl+eIv+mL+YPoen1Kwvv4mZLZO4x5a9vA6eiTb4SiyX18aO5+wdGG1g2YneiZudMnhbxu0QOTZUAYmRftMXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5KJTXE5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712422; x=1756248422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRloS1J3dVkNQRDNRHzR1RTq9/eQ1Na8LgWHdyx29as=;
  b=P5KJTXE5C5hBrC1MyvJWKZuFVFj/LvkvaDcvNhKIQNj604SBuvz8UIU4
   A/gzlzUwufRuDTHZVyaXQuCWAArebGmz7dN+8nRBlHIhoFVOnBrTcAvj4
   7U4NBJyg4SJ32bBiwIfpjtYNfHr8rAtdajF5rTU+3uwjLAvz2ToM/9wcr
   AvA+Zo3p+60SkqHYrG4CbAwtbkTMKQWRo2mvLIUoHBaWsjSuVDyyDpLAd
   ibyCRGksIXU9ARnatRJf9+VaPpqHylHjcfLq4pOIiZeVMF2vkXT30lR1h
   g6Q1ksrHi6PSLnRfdwZtrsdnhNweY6cVNVHHRBoFeQnivytuwEeOMgxQv
   w==;
X-CSE-ConnectionGUID: ZQLQuinhR9yxDPcvOgorqA==
X-CSE-MsgGUID: yxmvQ0i5R4WfPiROkUsarA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030951"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:00 -0700
X-CSE-ConnectionGUID: ba42az2ETxGf2fcH8FB/WA==
X-CSE-MsgGUID: CdTti2oTSqqTMJfBUZ3OnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822460"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:46:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/8] ice: implement and use rd32_poll_timeout for ice_sq_done timeout
Date: Mon, 26 Aug 2024 15:46:41 -0700
Message-ID: <20240826224655.133847-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_sq_done function is used to check the control queue head register
and determine whether or not the control queue processing is done. This
function is called in a loop checking against jiffies for a specified
timeout.

The pattern of reading a register in a loop until a condition is true or a
timeout is reached is a relatively common pattern. In fact, the kernel
provides a read_poll_timeout function implementing this behavior in
<linux/iopoll.h>

Use of read_poll_timeout is preferred over directly coding these loops.
However, using it in the ice driver is a bit more difficult because of the
rd32 wrapper. Implement a rd32_poll_timeout wrapper based on
read_poll_timeout.

Refactor ice_sq_done to use rd32_poll_timeout, replacing the loop calling
ice_sq_done in ice_sq_send_cmd. This simplifies the logic down to a single
ice_sq_done() call.

The implementation of rd32_poll_timeout uses microseconds for its timeout
value, so update the CQ timeout macros used to be specified in microseconds
units as well instead of using HZ for jiffies.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 38 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_controlq.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |  4 ++
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index ffaa6511c455..1b1b68a99bb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -933,19 +933,29 @@ static void ice_debug_cq(struct ice_hw *hw, void *desc, void *buf, u16 buf_len)
 }
 
 /**
- * ice_sq_done - check if FW has processed the Admin Send Queue (ATQ)
+ * ice_sq_done - poll until the last send on a control queue has completed
  * @hw: pointer to the HW struct
  * @cq: pointer to the specific Control queue
  *
- * Returns true if the firmware has processed all descriptors on the
- * admin send queue. Returns false if there are still requests pending.
+ * Use read_poll_timeout to poll the control queue head, checking until it
+ * matches next_to_use. According to the control queue designers, this has
+ * better timing reliability than the DD bit.
+ *
+ * Return: true if all the descriptors on the send side of a control queue
+ *         are finished processing, false otherwise.
  */
 static bool ice_sq_done(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 {
-	/* AQ designers suggest use of head for better
-	 * timing reliability than DD bit
+	u32 head;
+
+	/* Wait a short time before the initial check, to allow hardware time
+	 * for completion.
 	 */
-	return rd32(hw, cq->sq.head) == cq->sq.next_to_use;
+	udelay(5);
+
+	return !rd32_poll_timeout(hw, cq->sq.head,
+				  head, head == cq->sq.next_to_use,
+				  20, ICE_CTL_Q_SQ_CMD_TIMEOUT);
 }
 
 /**
@@ -969,7 +979,6 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	struct ice_aq_desc *desc_on_ring;
 	bool cmd_completed = false;
 	struct ice_sq_cd *details;
-	unsigned long timeout;
 	int status = 0;
 	u16 retval = 0;
 	u32 val = 0;
@@ -1063,20 +1072,9 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
-	/* Wait a short time before initial ice_sq_done() check, to allow
-	 * hardware time for completion.
+	/* Wait for the command to complete. If it finishes within the
+	 * timeout, copy the descriptor back to temp.
 	 */
-	udelay(5);
-
-	timeout = jiffies + ICE_CTL_Q_SQ_CMD_TIMEOUT;
-	do {
-		if (ice_sq_done(hw, cq))
-			break;
-
-		usleep_range(100, 150);
-	} while (time_before(jiffies, timeout));
-
-	/* if ready, copy the desc back to temp */
 	if (ice_sq_done(hw, cq)) {
 		memcpy(desc, desc_on_ring, sizeof(*desc));
 		if (buf) {
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 1d54b1cdb1c5..e5b6691436f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -43,7 +43,7 @@ enum ice_ctl_q {
 };
 
 /* Control Queue timeout settings - max delay 1s */
-#define ICE_CTL_Q_SQ_CMD_TIMEOUT	HZ    /* Wait max 1s */
+#define ICE_CTL_Q_SQ_CMD_TIMEOUT	USEC_PER_SEC
 #define ICE_CTL_Q_ADMIN_INIT_TIMEOUT	10    /* Count 10 times */
 #define ICE_CTL_Q_ADMIN_INIT_MSEC	100   /* Check every 100msec */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index a2562f04267f..9882e6f3b26d 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
+#include <linux/iopoll.h>
 #include <linux/pci_ids.h>
 #ifndef CONFIG_64BIT
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -23,6 +24,9 @@
 #define wr64(a, reg, value)	writeq((value), ((a)->hw_addr + (reg)))
 #define rd64(a, reg)		readq((a)->hw_addr + (reg))
 
+#define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
+	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
+
 #define ice_flush(a)		rd32((a), GLGEN_STAT)
 #define ICE_M(m, s)		((m ## U) << (s))
 
-- 
2.42.0


