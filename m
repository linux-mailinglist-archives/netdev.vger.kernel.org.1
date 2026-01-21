Return-Path: <netdev+bounces-252029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMlbNjk2cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:25:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F75D26F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ECD8A0FA49
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472727F017;
	Wed, 21 Jan 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFFDNx1S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC9344055
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021110; cv=none; b=gFoXF7o0lHYR/mx1hBiCfNUDqQGA3VqxlTnWj1+p9pAjEz3lQTCPWiMTxwsCO7SiDf5AfVE5LQ7eP8mD3VdM/x6DBsS8egtgCmeQop1YnvlFRLaYlzpRreio0dcBVbjSuxbsoUbO+84TtCyIn6jD//4cEp4sTg6NResTOZTU/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021110; c=relaxed/simple;
	bh=fdPEOI4fS84lKR25tqzd47PtlD0nvo8A1+4VuBxP/tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CNfvyUSBvJwCzVHVKehqLOkxNe5BJXB+rXfO/mAichRnXlgkmcWaP9/xQDR9lO1OeiMJtjaClYnOhd1G7hv7JNy2KYwNn0aM4q/t315YADYLh1UXGnbq/zypxf0K87ufRyvSh4Xq6Cq8XblmzbnLvwBZY/o5ulmt43vya2v2S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFFDNx1S; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769021108; x=1800557108;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=fdPEOI4fS84lKR25tqzd47PtlD0nvo8A1+4VuBxP/tE=;
  b=jFFDNx1S2+X5xqoKvl5xBFjMEGAfnmp4KEpp+++rVGzahInI3CBBIHaL
   VF/2pwvgOEH8arstAc3WAATZcsXpP++PFsKZyFgFuHamfN8kReJh3SNkE
   L5RCDHNHinFtHpS3R9d4uzhBGtKcR7oEui8v1JfgIzlbzjQF5D+poZ1FC
   NjGqcvBZL7WhTZ65bd9eYPNEel/GCfm4c0pj04Znmesac5kawSCW1F1+V
   Puca0yC3n8bUvf/EI2w6Ehiz00LVn3l9uQPzWVU6A8LA+JvpCwe6Vhr4z
   77EO0NmtNzBYqRnV5Cn1515JSv/VuA/XjEFXfMdcXiGRgDw3Dx2dZBw21
   Q==;
X-CSE-ConnectionGUID: P4+8A3iYTkiQEBPgE6JHYw==
X-CSE-MsgGUID: NwG/a31BRmWaltWDUGId5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="73880942"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="73880942"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:45:07 -0800
X-CSE-ConnectionGUID: ig9VBlc5Qka3mQjjI/4tBw==
X-CSE-MsgGUID: hHkzlCX4R4S7nOVwvX8V0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210962923"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:45:06 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Jan 2026 10:44:19 -0800
Subject: [PATCH iwl-net] ice: PTP: fix missing timestamps on E825 hardware
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-jk-e825c-fix-missing-timetamps-v1-1-f090eabfc823@intel.com>
X-B4-Tracking: v=1; b=H4sIAIYecWkC/x2NwQrCMBAFf6Xs2YUkxRL9FfEQmtd2q4klG1Qo/
 XeDx4FhZidFEShdu50K3qLyyg3sqaNxCXkGS2xMzrjBWDvw+mB4dx55ki8nUZU8c5WEGtKmHGM
 Il8l43/egFtkKmvgf3Eg+T86odD+OH437FJp5AAAA
X-Change-ID: 20260116-jk-e825c-fix-missing-timetamps-ddaa9f08833e
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=15912;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=fdPEOI4fS84lKR25tqzd47PtlD0nvo8A1+4VuBxP/tE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxCuZX3lv+anHyjqHaq1qZ72cHJ83Q/OW/8uftmy1Mmp
 c5SRuZvHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExk7VlGhg4e1cg2rlsTV5uu
 1CqUd1LU7ztuF7K4g3FNS8Dprx0rtjH8jzbx09317IvSf06G+EeP/ItfmU05V9QU9+KTWN/sA5N
 ncwIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252029-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 763F75D26F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The E825 hardware currently has each PF handle the PFINT_TSYN_TX cause of
the miscellaneous OICR interrupt vector. The actual interrupt cause
underlying this is shared by all ports on the same quad:

  ┌─────────────────────────────────┐
  │                                 │
  │   ┌────┐ ┌────┐ ┌────┐ ┌────┐   │
  │   │PF 0│ │PF 1│ │PF 2│ │PF 3│   │
  │   └────┘ └────┘ └────┘ └────┘   │
  │                                 │
  └────────────────▲────────────────┘
                   │
                   │
  ┌────────────────┼────────────────┐
  │             PHY QUAD            │
  └───▲────────▲────────▲────────▲──┘
      │        │        │        │
  ┌───┼──┐ ┌───┴──┐ ┌───┼──┐ ┌───┼──┐
  │Port 0│ │Port 1│ │Port 2│ │Port 3│
  └──────┘ └──────┘ └──────┘ └──────┘

If multiple PFs issue Tx timestamp requests near simultaneously, it is
possible that the correct PF will not be interrupted and will miss its
timestamp. Understanding why is somewhat complex.

Consider the following sequence of events:

  CPU 0:
  Send Tx packet on PF 0
  ...
  PF 0 enqueues packet with Tx request          CPU 1, PF1:
  ...                                           Send Tx packet on PF1
  ...                                           PF 1 enqueues packet with Tx request

  HW:
  PHY Port 0 sends packet
  PHY raises Tx timestamp event interrupt
  MAC raises each PF interrupt

  CPU 0, PF0:                                   CPU 1, PF1:
  ice_misc_intr() checks for Tx timestamps      ice_misc_intr() checks for Tx timestamp
  Sees packet ready bit set                     Sees nothing available
  ...                                           Exits
  ...
  ...
  HW:
  PHY port 1 sends packet
  PHY interrupt ignored because not all packet timestamps read yet.
  ...
  Read timestamp, report to stack

Because the interrupt event is shared for all ports on the same quad, the
PHY will not raise a new interrupt for any PF until all timestamps are
read.

In the example above, the second timestamp comes in for port 1 before the
timestamp from port 0 is read. At this point, there is no longer an
interrupt thread running that will read the timestamps, because each PF has
checked and found that there was no work to do. Applications such as ptp4l
will timeout after waiting a few milliseconds. Eventually, the watchdog
service task will re-check for all quads and notice that there are
outstanding timestamps, and issue a software interrupt to recover. However,
by this point it is far too late, and applications have already failed.

All of this occurs because of the underlying hardware behavior. The PHY
cannot raise a new interrupt signal until all outstanding timestamps have
been read.

As a first step to fix this, switch the E825C hardware to the
ICE_PTP_TX_INTERRUPT_ALL mode. In this mode, only the clock owner PF will
respond to the PFINT_TSYN_TX cause. Other PFs disable this cause and will
not wake. In this mode, the clock owner will iterate over all ports and
handle timestamps for each connected port.

This matches the E822 behavior, and is a necessary but insufficient step to
resolve the missing timestamps.

Even with use of the ICE_PTP_TX_INTERRUPT_ALL mode, we still sometimes miss
a timestamp event. The ice_ptp_tx_tstamp_owner() does re-check the ready
bitmap, but does so before re-enabling the OICR interrupt vector. It also
only checks the ready bitmap, but not the software Tx timestamp tracker.

To avoid risk of losing a timestamp, refactor the logic to check both the
software Tx timestamp tracker bitmap *and* the hardware ready bitmap.
Additionally, do this outside of ice_ptp_process_ts() after we have already
re-enabled the OICR interrupt.

Remove the checks from the ice_ptp_tx_tstamp(), ice_ptp_tx_tstamp_owner(),
and the ice_ptp_process_ts() functions. This results in ice_ptp_tx_tstamp()
being nothing more than a wrapper around ice_ptp_process_tx_tstamp() so we
can remove it.

Add the ice_ptp_tx_tstamps_pending() function which returns a boolean
indicating if there are any pending Tx timestamps. First, check the
software timestamp tracker bitmap. In ICE_PTP_TX_INTERRUPT_ALL mode, check
*all* ports software trackers. If a tracker has outstanding timestamp
requests, return true. Additionally, check the PHY ready bitmap to confirm
if the PHY indicates any outstanding timestamps.

In the ice_misc_thread_fn(), call ice_ptp_tx_tstamps_pending() just before
returning from the IRQ thread handler. If it returns true, write to
PFINT_OICR to trigger a PFINT_OICR_TSYN_TX_M software interrupt. This will
force the handler to interrupt again and complete the work even if the PHY
hardware did not interrupt for any reason.

This results in the following new flow for handling Tx timestamps:

1) send Tx packet
2) PHY captures timestamp
3) PHY triggers MAC interrupt
4) clock owner executes ice_misc_intr() with PFINT_OICR_TSYN_TX flag set
5) ice_ptp_ts_irq() returns IRQ_WAKE_THREAD
7) The interrupt thread wakes up and kernel calls ice_misc_intr_thread_fn()
8) ice_ptp_process_ts() is called to handle any outstanding timestamps
9) ice_irq_dynamic_ena() is called to re-enable the OICR hardware interrupt
   cause
10) ice_ptp_tx_tstamps_pending() is called to check if we missed any more
    outstanding timestamps, checking both software and hardware indicators.

With this change, it should no longer be possible for new timestamps to
come in such a way that we lose an interrupt. If a timestamp comes in
before the ice_ptp_tx_tstamps_pending() call, it will be noticed by at
least one of the software bitmap check or the hardware bitmap check. If the
timestamp comes in *after* this check, it should cause a timestamp
interrupt as we have already read all timestamps from the PHY and the OICR
vector has been re-enabled.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  13 ++-
 drivers/net/ethernet/intel/ice/ice_main.c |  20 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 148 +++++++++++++++++-------------
 3 files changed, 103 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 27016aac4f1e..8489bd842710 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -304,8 +304,9 @@ void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
-enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
+void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -345,16 +346,18 @@ static inline void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 
 static inline void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx) { }
 
-static inline bool ice_ptp_process_ts(struct ice_pf *pf)
-{
-	return true;
-}
+static inline void ice_ptp_process_ts(struct ice_pf *pf) { }
 
 static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 {
 	return IRQ_HANDLED;
 }
 
+static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+{
+	return false;
+}
+
 static inline u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 					   struct ptp_system_timestamp *sts)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 08268f1a03da..2e5d7925999c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3314,18 +3314,20 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	if (ice_is_reset_in_progress(pf->state))
 		goto skip_irq;
 
-	if (test_and_clear_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread)) {
-		/* Process outstanding Tx timestamps. If there is more work,
-		 * re-arm the interrupt to trigger again.
-		 */
-		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
-			wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
-			ice_flush(hw);
-		}
-	}
+	if (test_and_clear_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread))
+		ice_ptp_process_ts(pf);
 
 skip_irq:
 	ice_irq_dynamic_ena(hw, NULL, NULL);
+	ice_flush(hw);
+
+	if (ice_ptp_tx_tstamps_pending(pf)) {
+		/* If any new Tx timestamps happened while in interrupt,
+		 * re-arm the interrupt to trigger it again.
+		 */
+		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+		ice_flush(hw);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0b7c2a13ab04..b5cef6396319 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,6 +573,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
+	if (!tx->init)
+		return;
+
 	/* Read the Tx ready status first */
 	if (tx->has_ready_bitmap) {
 		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
@@ -674,14 +677,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
-/**
- * ice_ptp_tx_tstamp_owner - Process Tx timestamps for all ports on the device
- * @pf: Board private structure
- */
-static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
+static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
-	unsigned int i;
 
 	mutex_lock(&pf->adapter->ports.lock);
 	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
@@ -693,49 +691,6 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 		ice_ptp_process_tx_tstamp(tx);
 	}
 	mutex_unlock(&pf->adapter->ports.lock);
-
-	for (i = 0; i < ICE_GET_QUAD_NUM(pf->hw.ptp.num_lports); i++) {
-		u64 tstamp_ready;
-		int err;
-
-		/* Read the Tx ready status first */
-		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
-		if (err)
-			break;
-		else if (tstamp_ready)
-			return ICE_TX_TSTAMP_WORK_PENDING;
-	}
-
-	return ICE_TX_TSTAMP_WORK_DONE;
-}
-
-/**
- * ice_ptp_tx_tstamp - Process Tx timestamps for this function.
- * @tx: Tx tracking structure to initialize
- *
- * Returns: ICE_TX_TSTAMP_WORK_PENDING if there are any outstanding incomplete
- * Tx timestamps, or ICE_TX_TSTAMP_WORK_DONE otherwise.
- */
-static enum ice_tx_tstamp_work ice_ptp_tx_tstamp(struct ice_ptp_tx *tx)
-{
-	bool more_timestamps;
-	unsigned long flags;
-
-	if (!tx->init)
-		return ICE_TX_TSTAMP_WORK_DONE;
-
-	/* Process the Tx timestamp tracker */
-	ice_ptp_process_tx_tstamp(tx);
-
-	/* Check if there are outstanding Tx timestamps */
-	spin_lock_irqsave(&tx->lock, flags);
-	more_timestamps = tx->init && !bitmap_empty(tx->in_use, tx->len);
-	spin_unlock_irqrestore(&tx->lock, flags);
-
-	if (more_timestamps)
-		return ICE_TX_TSTAMP_WORK_PENDING;
-
-	return ICE_TX_TSTAMP_WORK_DONE;
 }
 
 /**
@@ -2666,32 +2621,94 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 		return idx + tx->offset;
 }
 
-/**
- * ice_ptp_process_ts - Process the PTP Tx timestamps
- * @pf: Board private structure
- *
- * Returns: ICE_TX_TSTAMP_WORK_PENDING if there are any outstanding Tx
- * timestamps that need processing, and ICE_TX_TSTAMP_WORK_DONE otherwise.
- */
-enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
+void ice_ptp_process_ts(struct ice_pf *pf)
 {
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		/* This device has the clock owner handle timestamps for it */
-		return ICE_TX_TSTAMP_WORK_DONE;
+		return;
 	case ICE_PTP_TX_INTERRUPT_SELF:
 		/* This device handles its own timestamps */
-		return ice_ptp_tx_tstamp(&pf->ptp.port.tx);
+		ice_ptp_process_tx_tstamp(&pf->ptp.port.tx);
+		return;
 	case ICE_PTP_TX_INTERRUPT_ALL:
 		/* This device handles timestamps for all ports */
-		return ice_ptp_tx_tstamp_owner(pf);
+		ice_ptp_tx_tstamp_owner(pf);
+		return;
 	default:
 		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
 			  pf->ptp.tx_interrupt_mode);
-		return ICE_TX_TSTAMP_WORK_DONE;
+		return;
 	}
 }
 
+static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
+{
+	bool more_timestamps;
+
+	scoped_guard(spinlock_irqsave, &tx->lock) {
+		if (!tx->init)
+			return false;
+
+		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
+	}
+
+	return more_timestamps;
+}
+
+static bool ice_any_port_has_timestamps(struct ice_pf *pf)
+{
+	struct ice_ptp_port *port;
+
+	scoped_guard(mutex, &pf->adapter->ports.lock) {
+		list_for_each_entry(port, &pf->adapter->ports.ports,
+				    list_node) {
+			struct ice_ptp_tx *tx = &port->tx;
+
+			if (ice_port_has_timestamps(tx))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+	unsigned int i;
+
+	/* Check software indicator */
+	switch (pf->ptp.tx_interrupt_mode) {
+	case ICE_PTP_TX_INTERRUPT_NONE:
+		return false;
+	case ICE_PTP_TX_INTERRUPT_SELF:
+		if (ice_port_has_timestamps(&pf->ptp.port.tx))
+			return true;
+		break;
+	case ICE_PTP_TX_INTERRUPT_ALL:
+		if (ice_any_port_has_timestamps(pf))
+			return true;
+		break;
+	default:
+		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
+			  pf->ptp.tx_interrupt_mode);
+		break;
+	}
+
+	/* Check hardware indicator */
+	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
+		u64 tstamp_ready = 0;
+		int err;
+
+		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
+		if (err || tstamp_ready)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ice_ptp_ts_irq - Process the PTP Tx timestamps in IRQ context
  * @pf: Board private structure
@@ -2741,7 +2758,9 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		return IRQ_WAKE_THREAD;
 	case ICE_MAC_E830:
 		/* E830 can read timestamps in the top half using rd32() */
-		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
+		ice_ptp_process_ts(pf);
+
+		if (ice_ptp_tx_tstamps_pending(pf)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -3194,8 +3213,9 @@ static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
 {
 	switch (pf->hw.mac_type) {
 	case ICE_MAC_GENERIC:
-		/* E822 based PHY has the clock owner process the interrupt
-		 * for all ports.
+	case ICE_MAC_GENERIC_3K_E825:
+		/* E82x hardware has the clock owner process timestamps for
+		 * all ports.
 		 */
 		if (ice_pf_src_tmr_owned(pf))
 			pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_ALL;

---
base-commit: d41f8acf7a86de68d8e1d0d5ab288ca5a003ae29
change-id: 20260116-jk-e825c-fix-missing-timetamps-ddaa9f08833e

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


