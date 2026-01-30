Return-Path: <netdev+bounces-255227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL56MoH+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74DBE029
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754043036EFB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A2387342;
	Fri, 30 Jan 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cebjrxiC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BC3859ED
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799250; cv=none; b=uTGCkQNaU+/04xlU70jVm0dYI15iDyJLmO4+Rd8nurvsF4FUZ1U5PAr4qEZAJkrC9aDXKRKXxDJsXacLVja4gLOITyjWD+PMMJX1PgBAJZbGUwgcVwRyv7LTS8PQpD2yZ1gih4v0Mpu9h9d79/cHgZtgGi8+GTTQ+LaBX5PuOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799250; c=relaxed/simple;
	bh=bdYRvn4JFNrTUzu3dOvjlhVZ7mSQlMvaUneuEviSs+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=es49nqGgzzHI9XiGJDH1tdRFDg3oJx8ZnKpXFiQE2C0oKZg5oDbjVmgUibuuJNZ8LehiL5VtRJWkXa0Pp3bsrjvLQiTXqQvFg0e0QRCmZ5tpJZUC+3iq162pcTTTKRUyL2pjgvzgvxMkKSMBZL2D3uTWqR+xAs1RXTxVtaHwnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cebjrxiC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799248; x=1801335248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdYRvn4JFNrTUzu3dOvjlhVZ7mSQlMvaUneuEviSs+A=;
  b=cebjrxiCsR2mDutm+qAjYVNQgwgSBzfW84wfAyyPKA+6x84W2e6pem4c
   24x1a+fIenSWzioeN0uoo1izbza323uJ/b3PntgXpXEO1JocdaewbeUl/
   LQ0ZZj7DeBpX0iDFjhxr8Et9nJR9/5Y0d00ypoNkR/k/JF4zixTO2gYp3
   WRinsKDWeJoWR1JkASmUb5uRjZuuJS7wYwAMA4b1KhWkvPe+8prDfhp2H
   lLFQ6bUrxAeHtKOR8s2J+w1QqFfhc5MhQ4YjUPGQ4fwXh5KsSn6mOIwMa
   BQ5jLjWDMjLHhdv/xArWrl3GHaBsde46O1CQ9lNxiaNSiwun2HcywPKl8
   Q==;
X-CSE-ConnectionGUID: Bw6YoH59RJSOJFUQYFY4cg==
X-CSE-MsgGUID: XXfq6PNWTL+t4us79MNUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091278"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:06 -0800
X-CSE-ConnectionGUID: JHfmajGQR+Cx7mYZGs7XAg==
X-CSE-MsgGUID: zShTs4oVQOSMr/dBHkAqRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231841005"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:06 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	grzegorz.nitka@intel.com,
	richardcochran@gmail.com,
	mschmidt@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Vitaly Grinberg <vgrinber@redhat.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 2/5] ice: PTP: fix missing timestamps on E825 hardware
Date: Fri, 30 Jan 2026 10:53:55 -0800
Message-ID: <20260130185401.1091523-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-255227-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF74DBE029
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Tested-by: Vitaly Grinberg <vgrinber@redhat.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  20 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 148 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  13 +-
 3 files changed, 103 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 71c6d53b461e..25cbbe67d992 100644
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
@@ -2666,30 +2621,92 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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
+	default:
+		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
+			  pf->ptp.tx_interrupt_mode);
+		return;
+	}
+}
+
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
 	default:
 		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
 			  pf->ptp.tx_interrupt_mode);
-		return ICE_TX_TSTAMP_WORK_DONE;
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
 	}
+
+	return false;
 }
 
 /**
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
-- 
2.47.1


