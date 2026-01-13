Return-Path: <netdev+bounces-249610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17BD1B857
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52AE03010054
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98550354AF9;
	Tue, 13 Jan 2026 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9nJF/TI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61E352F82
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341754; cv=none; b=CTNUEJ50lw8Fur02iYTE/XBQpVTpJBwZZPeiCxlUGxIjcPFF05agUyvuuJTva+l+Q9TtgeAjC4Y21TfpGaw33wJG3i6hMRy8leXR5NY10HHgYc5wCoXcITIW5g8pWUMRQ99rVQjjjtwTT++D6dx7oQ/B7XpIvpc3gD5IVqUX5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341754; c=relaxed/simple;
	bh=9urtO/0OnmlmE7+3D8dzBvfkOm0JlXS8w7IgqLlJ8io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc0k86Y4TOCslP8hC2eODQSsBymQoVlTGIxtwnotOKCUgR9CmP51DHj5kS4tVUEeQ98b/CIHImvO6JaXOMrSw9Icl/PEl1f9FbTAfKVOkUY5fq1nyUliteAK2L03preKnFB6XUYyoulCnzrHSvS7tgaaX0z+jXkp7ac43iJF3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9nJF/TI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341754; x=1799877754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9urtO/0OnmlmE7+3D8dzBvfkOm0JlXS8w7IgqLlJ8io=;
  b=f9nJF/TIGu/My0//ICi/kVe7+ql7RL0dWmSE756goF7p9vHTCS8GT5o7
   Zx+5zVnUwwrxFdzvtYwBOg+ZLauDSEs+o51dtQRqaAEdupckk5kFDmdOI
   hNZyfCpBVvzaFElCjVwgLlnd2MlOC07aBIZWVunz1dRuJ6SP+7G87hG+y
   njyTsHcz6XcgOnIcsIZL+0e8yc8Q5/Re4Dw65jaJ8HcGWAcK5+TSMP76Q
   otkGHdjcgzWk5OvwbwTV1z/ADcs3Did9m4K7wlxWCNjSmp1e6uMWtvvhB
   SLauK6OjumwrzCeSMucYnit+iI57nbClpNleokL3rfKOBpyrOmeXJpDSj
   g==;
X-CSE-ConnectionGUID: EX+K0ZxtQc2EMvRX+gQCOA==
X-CSE-MsgGUID: ybKDu2urTEeoagwfO0BiVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558691"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558691"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:30 -0800
X-CSE-ConnectionGUID: GY+LL5iQRLGImWkqf2u/ag==
X-CSE-MsgGUID: 5NSaDDW4TbWa1RTWrUmnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388186"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:28 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	richardcochran@gmail.com,
	vinicius.gomes@intel.com,
	yipeng.chai@amd.com,
	alexander.deucher@amd.com,
	Avi Shalev <avi.shalev@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 5/6] igc: fix race condition in TX timestamp read for register 0
Date: Tue, 13 Jan 2026 14:02:18 -0800
Message-ID: <20260113220220.1034638-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
References: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chwee-Lin Choong <chwee.lin.choong@intel.com>

The current HW bug workaround checks the TXTT_0 ready bit first,
then reads TXSTMPL_0 twice (before and after reading TXSTMPH_0)
to detect whether a new timestamp was captured by timestamp
register 0 during the workaround.

This sequence has a race: if a new timestamp is captured after
checking the TXTT_0 bit but before the first TXSTMPL_0 read, the
detection fails because both the "old" and "new" values come from
the same timestamp.

Fix by reading TXSTMPL_0 first to establish a baseline, then
checking the TXTT_0 bit. This ensures any timestamp captured
during the race window will be detected.

Old sequence:
  1. Check TXTT_0 ready bit
  2. Read TXSTMPL_0 (baseline)
  3. Read TXSTMPH_0 (interrupt workaround)
  4. Read TXSTMPL_0 (detect changes vs baseline)

New sequence:
  1. Read TXSTMPL_0 (baseline)
  2. Check TXTT_0 ready bit
  3. Read TXSTMPH_0 (interrupt workaround)
  4. Read TXSTMPL_0 (detect changes vs baseline)

Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
Suggested-by: Avi Shalev <avi.shalev@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 43 ++++++++++++++----------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index b7b46d863bee..7aae83c108fd 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -774,36 +774,43 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter *adapter,
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	u32 txstmpl_old;
 	u64 regval;
 	u32 mask;
 	int i;
 
+	/* Establish baseline of TXSTMPL_0 before checking TXTT_0.
+	 * This baseline is used to detect if a new timestamp arrives in
+	 * register 0 during the hardware bug workaround below.
+	 */
+	txstmpl_old = rd32(IGC_TXSTMPL);
+
 	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
 	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
 		regval = rd32(IGC_TXSTMPL);
 		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
 	} else {
-		/* There's a bug in the hardware that could cause
-		 * missing interrupts for TX timestamping. The issue
-		 * is that for new interrupts to be triggered, the
-		 * IGC_TXSTMPH_0 register must be read.
+		/* TXTT_0 not set - register 0 has no new timestamp initially.
+		 *
+		 * Hardware bug: Future timestamp interrupts won't fire unless
+		 * TXSTMPH_0 is read, even if the timestamp was captured in
+		 * registers 1-3.
 		 *
-		 * To avoid discarding a valid timestamp that just
-		 * happened at the "wrong" time, we need to confirm
-		 * that there was no timestamp captured, we do that by
-		 * assuming that no two timestamps in sequence have
-		 * the same nanosecond value.
+		 * Workaround: Read TXSTMPH_0 here to enable future interrupts.
+		 * However, this read clears TXTT_0. If a timestamp arrives in
+		 * register 0 after checking TXTT_0 but before this read, it
+		 * would be lost.
 		 *
-		 * So, we read the "low" register, read the "high"
-		 * register (to latch a new timestamp) and read the
-		 * "low" register again, if "old" and "new" versions
-		 * of the "low" register are different, a valid
-		 * timestamp was captured, we can read the "high"
-		 * register again.
+		 * To detect this race: We saved a baseline read of TXSTMPL_0
+		 * before TXTT_0 check. After performing the workaround read of
+		 * TXSTMPH_0, we read TXSTMPL_0 again. Since consecutive
+		 * timestamps never share the same nanosecond value, a change
+		 * between the baseline and new TXSTMPL_0 indicates a timestamp
+		 * arrived during the race window. If so, read the complete
+		 * timestamp.
 		 */
-		u32 txstmpl_old, txstmpl_new;
+		u32 txstmpl_new;
 
-		txstmpl_old = rd32(IGC_TXSTMPL);
 		rd32(IGC_TXSTMPH);
 		txstmpl_new = rd32(IGC_TXSTMPL);
 
@@ -818,7 +825,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 
 done:
 	/* Now that the problematic first register was handled, we can
-	 * use retrieve the timestamps from the other registers
+	 * retrieve the timestamps from the other registers
 	 * (starting from '1') with less complications.
 	 */
 	for (i = 1; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
-- 
2.47.1


