Return-Path: <netdev+bounces-242176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F52C8D1C9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 102D74E383A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA931ED97;
	Thu, 27 Nov 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxkGDK4n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9D31ED6F;
	Thu, 27 Nov 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228694; cv=none; b=E/Kc7Yzy+zzwwiR1HwQzZd0s/NLOLNRpATb2XFtdar4jIbEEGAuakTvyKttt4FOheeNG/2nxu7MP8nnz/ir//0Aqy9lXMkrHFKuZF7Yu4871rcAeXPDnEQoS5s2S5B4iQoi06vNcLltihjngudmUtwjf3TIu4TwLu6aLBjkfCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228694; c=relaxed/simple;
	bh=djXtYfwiJE1XkDQF2b0MRN7mvLoJ5ybRSLF+cotldH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fk5HqDPnE3mQOGQzf3qYXpSjYhYY1PT0rpTJrWWOgA33HNXfuNsdFWtSU6cD4H6akGhIpoaC6PpIOiOKj6xShNLo8gM0S4UPQ3bh75KjS66ksRCWOWfFTpqyGCApoczIJ9RPDV0bnnDEFnKrUx+eWBwe4PxnoY0sjwFtgycgjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxkGDK4n; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764228693; x=1795764693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=djXtYfwiJE1XkDQF2b0MRN7mvLoJ5ybRSLF+cotldH8=;
  b=SxkGDK4nj2bK4w9oKeVGbC94AxfUTL1iFD+Gsg1UpsaBnZYJMIo6tIK5
   YzmBIP4nqEvnmGYr7KV0zqriJd7WN7z4mdt36U+QQHGGM/D4yO/+5yeRP
   tzoLS9bXhqqnOgBGcmgZp1/7it2MHNIa+RdNYjmEEEAaQp0IbJSIECdoj
   NvVnGmZigi9QKIQR6m+YDvN78PIlC6czRyjDgtGjatUrnXVBqXAMUn+Yp
   ViEWfGcvMIv9O18JQnx7ipFke2RHHJFAvbQ1JEzMaTkwma/0lwkS7ndno
   2mWwe5dDz2n0d1EVBXlabzT3vDnTvNChOjD6LGDeOFgAm5mbl/fOw5KTq
   Q==;
X-CSE-ConnectionGUID: OMwVApq2T6Gf8hKmfADQ+g==
X-CSE-MsgGUID: 1gc2rQ4XSXuVqHX50h4kpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70133702"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="70133702"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 23:31:31 -0800
X-CSE-ConnectionGUID: H9TNPFCSSpiXQUhEiAlhAQ==
X-CSE-MsgGUID: dLEH+f6zSG26Rkgtl16qQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="197487869"
Received: from p2dy149cchoong.png.intel.com ([10.107.243.50])
  by fmviesa005.fm.intel.com with ESMTP; 26 Nov 2025 23:31:23 -0800
From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Avi Shalev <avi.shalev@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH iwl-net v3] igc: fix race condition in TX timestamp read for register 0
Date: Thu, 27 Nov 2025 23:11:37 +0800
Message-ID: <20251127151137.2883-1-chwee.lin.choong@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current HW bug workaround checks the TXTT_0 ready bit first,
then reads TXSTMPL_0 twice (before and after reading TXSTMPH_0)
to detect whether a new timestamp was captured by timestamp
register 0 during the workaround.

This sequence has a race: if a new timestamp is captured after
checking the TXTT_0 bit but before the first TXSTMPL_0 read, the
detection fails because both the “old” and “new” values come from
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
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
---
v1: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250918183811.31270-1-chwee.lin.choong@intel.com/
v2: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20251127134927.2133-1-chwee.lin.choong@intel.com/

changelog:
v1 -> v2 
- Added detailed comments explaining the hardware bug workaround and race
    detection mechanism
v2 -> v3
- Removed extra export file added by mistake	
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
2.43.0


