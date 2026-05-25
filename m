Return-Path: <netdev+bounces-291275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLTpCUQbFGoGJwcAu9opvQ
	(envelope-from <netdev+bounces-291275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E45C8CC7
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC52300678C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5453E5A31;
	Mon, 25 May 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VrXw/3Z7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235235DA46
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702593; cv=none; b=Vcn0ppehzUXv+kBQ7eA7NTDODyMQ+7oT+IQVKcIXTbZ4W/J8Db5JCts4aTasbCOTFSCVYbo6WiBvdEASBBCVo85mYPHSnHEuJQfpoGM5pJxG1PrlK9u22WsuQI4Bw8FtN4MXfxnSzcVdpjTGZh3IgoCgqnN1jiqI5ZH/26JITlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702593; c=relaxed/simple;
	bh=Wo8UGg9I7Px0fasWn6ZWzpDltO2pN0p5Rdi91Hfm1U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPJ5e0OoOXC71za70+TCRTb8TQf+eQZ8Na4RSCBAVSK76c3LRgJIwjU1oVJFonvf3Wr/cIc3nyuctW2yCitko9XtW3ea5p8bwP6VZBsWzTk45PFNcgrnazqiQlotLkaHZZJSI5nwcABRAits4q9dNdZbS8/gbZgTWCPz+8CxdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VrXw/3Z7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779702592; x=1811238592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wo8UGg9I7Px0fasWn6ZWzpDltO2pN0p5Rdi91Hfm1U4=;
  b=VrXw/3Z74bagQU4MMx7eZKFYm89CXj+vvC+b6HggHZuQC+eEOwrzcxyz
   eZM9HY/1tQtQNCv1qpQ99KZ1sjUVQrWuxmDvzZxbEGy3MTrgtxNs+MgxI
   Ct034SeTGT+jAU9AeWE/5vwykCR9EJ78aIU543188R+oREgORXtt5evOB
   aO5sqOrDpqPqMQrDnqiztMAuyUdesZ0PHDdfJwUjMYsZeYmVNS8Cx2ey3
   uV57irstJ7Pqr1fc4nQi119FrKPhD4MYhaOPbOU/R2768S79Rr7H76Sbg
   tc74RHxF9CNS+4UIWSjLqZjKcIsORSDOBbI+Z9sPWATDY5ymW5EEIxw+v
   Q==;
X-CSE-ConnectionGUID: 7YuXz1HrTKqI0mDzjl+8hg==
X-CSE-MsgGUID: OU94c9FdQdqN78lbfKCYxw==
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="58412781"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2026 02:49:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 25 May 2026 02:49:50 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 25 May 2026 02:49:47 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<Raju.Lakkaraju@microchip.com>
Subject: [PATCH net 2/2] net: lan743x: ptp: Fix PEROUT event channel assignment on PCI11x1x
Date: Mon, 25 May 2026 15:19:31 +0530
Message-ID: <20260525094931.10371-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525094931.10371-1-thangaraj.s@microchip.com>
References: <20260525094931.10371-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-291275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C03E45C8CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PCI11x1x device supports up to 12 PTP-IO pins as periodic outputs,
but only has 2 hardware event channels (A and B).  The previous code
called lan743x_ptp_reserve_event_ch(adapter, index) where index is the
perout request index (0..11), which fails for any index >= 2 since only
channels 0 and 1 exist.  As a result only two simultaneous periodic
outputs were possible instead of twelve.

Additionally, reserve_event_ch refused to assign a channel already in
use, preventing multiple pins from sharing the same event channel.
release_event_ch unconditionally tore down the hardware channel even
when other outputs were still using it.

Fix by:
- Adding bounds checking to lan743x_ptp_reserve_event_ch() and
  using event_ch_refcnt[] (introduced in the preceding commit),
  allowing multiple perout outputs to share one channel.
- Changing lan743x_ptp_release_event_ch() to return bool and decrement
  the reference count, only clearing the used_event_ch bit and returning
  true when the last user releases.
- Using index % LAN743X_PTP_N_EVENT_CHAN in lan743x_ptp_io_perout() so
  even-indexed outputs map to channel A and odd-indexed to channel B,
  enabling all 12 PTP-IO pins to be driven simultaneously.
- Guarding lan743x_ptp_io_perout_off() with ch_free so the hardware
  event channel is only disabled when the last user releases it.

Fixes: e432dd3bee2c ("net: lan743x: Add support for PTP-IO Event Output (Periodic Output)")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 83 +++++++++++---------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 8453b9d954cf..ffccc4dd06d0 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -159,33 +159,38 @@ static int lan743x_ptp_reserve_event_ch(struct lan743x_adapter *adapter,
 	struct lan743x_ptp *ptp = &adapter->ptp;
 	int result = -ENODEV;
 
+	if (event_channel < 0 || event_channel >= LAN743X_PTP_N_EVENT_CHAN)
+		return -EINVAL;
+
 	mutex_lock(&ptp->command_lock);
-	if (!(test_bit(event_channel, &ptp->used_event_ch))) {
-		ptp->used_event_ch |= BIT(event_channel);
-		result = event_channel;
-	} else {
-		netif_warn(adapter, drv, adapter->netdev,
-			   "attempted to reserved a used event_channel = %d\n",
-			   event_channel);
-	}
+	ptp->used_event_ch |= BIT(event_channel);
+	ptp->event_ch_refcnt[event_channel]++;
+	result = event_channel;
 	mutex_unlock(&ptp->command_lock);
 	return result;
 }
 
-static void lan743x_ptp_release_event_ch(struct lan743x_adapter *adapter,
+static bool lan743x_ptp_release_event_ch(struct lan743x_adapter *adapter,
 					 int event_channel)
 {
 	struct lan743x_ptp *ptp = &adapter->ptp;
+	bool fully_released = false;
 
 	mutex_lock(&ptp->command_lock);
 	if (test_bit(event_channel, &ptp->used_event_ch)) {
-		ptp->used_event_ch &= ~BIT(event_channel);
+		ptp->event_ch_refcnt[event_channel]--;
+		if (ptp->event_ch_refcnt[event_channel] <= 0) {
+			ptp->event_ch_refcnt[event_channel] = 0;
+			ptp->used_event_ch &= ~BIT(event_channel);
+			fully_released = true;
+		}
 	} else {
 		netif_warn(adapter, drv, adapter->netdev,
 			   "attempted release on a not used event_channel = %d\n",
 			   event_channel);
 	}
 	mutex_unlock(&ptp->command_lock);
+	return fully_released;
 }
 
 static void lan743x_ptp_clock_get(struct lan743x_adapter *adapter,
@@ -648,27 +653,30 @@ static void lan743x_ptp_io_perout_off(struct lan743x_adapter *adapter,
 
 	event_ch = ptp->ptp_io_perout[index];
 	if (event_ch >= 0) {
-		/* set target to far in the future, effectively disabling it */
-		lan743x_csr_write(adapter,
-				  PTP_CLOCK_TARGET_SEC_X(event_ch),
-				  0xFFFF0000);
-		lan743x_csr_write(adapter,
-				  PTP_CLOCK_TARGET_NS_X(event_ch),
-				  0);
-
-		gen_cfg = lan743x_csr_read(adapter, HS_PTP_GENERAL_CONFIG);
-		gen_cfg &= ~(HS_PTP_GENERAL_CONFIG_CLOCK_EVENT_X_MASK_
-				    (event_ch));
-		gen_cfg &= ~(HS_PTP_GENERAL_CONFIG_EVENT_POL_X_(event_ch));
-		gen_cfg |= HS_PTP_GENERAL_CONFIG_RELOAD_ADD_X_(event_ch);
-		lan743x_csr_write(adapter, HS_PTP_GENERAL_CONFIG, gen_cfg);
-		if (event_ch)
-			lan743x_csr_write(adapter, PTP_INT_STS,
-					  PTP_INT_TIMER_INT_B_);
-		else
-			lan743x_csr_write(adapter, PTP_INT_STS,
-					  PTP_INT_TIMER_INT_A_);
-		lan743x_ptp_release_event_ch(adapter, event_ch);
+		bool ch_free = lan743x_ptp_release_event_ch(adapter, event_ch);
+
+		if (ch_free) {
+			/* Last user of this channel - disable HW channel */
+			lan743x_csr_write(adapter,
+					  PTP_CLOCK_TARGET_SEC_X(event_ch),
+					  0xFFFF0000);
+			lan743x_csr_write(adapter,
+					  PTP_CLOCK_TARGET_NS_X(event_ch),
+					  0);
+
+			gen_cfg = lan743x_csr_read(adapter, HS_PTP_GENERAL_CONFIG);
+			gen_cfg &= ~(HS_PTP_GENERAL_CONFIG_CLOCK_EVENT_X_MASK_
+					    (event_ch));
+			gen_cfg &= ~(HS_PTP_GENERAL_CONFIG_EVENT_POL_X_(event_ch));
+			gen_cfg |= HS_PTP_GENERAL_CONFIG_RELOAD_ADD_X_(event_ch);
+			lan743x_csr_write(adapter, HS_PTP_GENERAL_CONFIG, gen_cfg);
+			if (event_ch)
+				lan743x_csr_write(adapter, PTP_INT_STS,
+						  PTP_INT_TIMER_INT_B_);
+			else
+				lan743x_csr_write(adapter, PTP_INT_STS,
+						  PTP_INT_TIMER_INT_A_);
+		}
 		ptp->ptp_io_perout[index] = -1;
 	}
 
@@ -715,16 +723,21 @@ static int lan743x_ptp_io_perout(struct lan743x_adapter *adapter, int on,
 		return 0;
 	}
 
-	if (event_ch >= LAN743X_PTP_N_EVENT_CHAN) {
-		/* already on, turn off first */
+	if (event_ch >= 0) {
+		/* already on for this index, turn off this pin first */
 		lan743x_ptp_io_perout_off(adapter, index);
 	}
 
-	event_ch = lan743x_ptp_reserve_event_ch(adapter, index);
+	/* Map perout index to one of the available event channels. Multiple
+	 * perout indices sharing the same channel (even/odd split) allows all
+	 * PTP-IO pins to be driven simultaneously from a single channel.
+	 */
+	event_ch = lan743x_ptp_reserve_event_ch(adapter,
+						index % LAN743X_PTP_N_EVENT_CHAN);
 	if (event_ch < 0) {
 		netif_warn(adapter, drv, adapter->netdev,
 			   "Failed to reserve event channel %d for PEROUT\n",
-			   index);
+			   index % LAN743X_PTP_N_EVENT_CHAN);
 		goto failed;
 	}
 	ptp->ptp_io_perout[index] = event_ch;
-- 
2.34.1


