Return-Path: <netdev+bounces-291274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HPqIJcbFGoGJwcAu9opvQ
	(envelope-from <netdev+bounces-291274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:51:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E35C8CEB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C768B301CA73
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CA3DD876;
	Mon, 25 May 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Daqvy/TM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF935DA46
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702586; cv=none; b=C9URaLrNgtkz613EJmFzGLHKKAEciK+h/il/0f2umTRVJyYOhSSyXQjhMpObf3xnVwRJ0pSCeiwgxxHV+A7JbeELZ325YTacZbHrAzRh1H+x5ETeuLKXvtG7HTcveGvCK1Yl4pw5gHOtAai7+HuZTVjzA7R8OP6c84az4HD0NkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702586; c=relaxed/simple;
	bh=C2zcboIgNBjmaqfKYuldAA3Xt3W4wY/aSAUfFu3gLLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9IEb4PQY1ro8X0xafTsqvb4shmdeFYG+oTKiSXKS0p6aXbCF0CTYjOHIxTTj47OEOWLaE253/h4A7GUhTbv6tqtcJxhA2cweYV81k8To1hs/FTXV6pEdjSPkSdyOE8bzoLBZjp2bNcCUUJq7DlVekTmf9mP1e3iJVscfRrT1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Daqvy/TM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779702585; x=1811238585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C2zcboIgNBjmaqfKYuldAA3Xt3W4wY/aSAUfFu3gLLQ=;
  b=Daqvy/TMWYiAqLSduWCGveA366Wn7A+d/1PdWfbWjVs/ZVJtzy2f56iD
   2yclpbgIXFpgmXN115jEws1DAhqAiLj6hqKMyDDJXNDByL9Lfq3xheLNb
   NFgKPdjDKWrPFjqLGFNkdZTqW3F1sIlruzgiZy1OiRTXjvjT+iJfQmsJE
   FWzChApiNYfbHVaBn5YnoGKKhj6LVzAA34VucksoyqWHbHW+IhBjfWkHD
   KlTrEvEr/xMNsr6x1N9qAG0OCXGlT1zU8MX/tPYW+lMCP6cadtpcRyqQA
   WRqs5ADjN5lFrXCz9kswPFTYsL3VQ/o29Us+aPkHdhltEN81OPlZokK98
   A==;
X-CSE-ConnectionGUID: XdfP58jjRPCGLEHsN0dsZQ==
X-CSE-MsgGUID: 7wKgrGUrTM2OHeeB9oCDiQ==
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="58412778"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:49:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 25 May 2026 02:49:43 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 25 May 2026 02:49:40 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<Raju.Lakkaraju@microchip.com>
Subject: [PATCH net 1/2] net: lan743x: ptp: Add PCI11X1X_PTP_N_PEROUT and extend ptp_io_perout array
Date: Mon, 25 May 2026 15:19:30 +0530
Message-ID: <20260525094931.10371-2-thangaraj.s@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-291274-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DD8E35C8CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PCI11x1x hardware supports up to 12 PTP-IO pins as simultaneous
periodic outputs, each independently selecting Timer A or B via its own
PTP_IO_CH_SEL bit in PTP_IO_EVENT_OUTPUT_CFG. However, ptp_io_perout[]
was sized by LAN743X_PTP_N_PEROUT (2), matching only the number of
hardware event channels rather than the number of IO output pins.

Introduce PCI11X1X_PTP_IO_MAX_OUT_PINS (12) for the output pin count
and PCI11X1X_PTP_N_PEROUT as its alias, keeping
PCI11X1X_PTP_IO_MAX_CHANNELS (8) for extts/capture which is limited to
8 channels by the hardware capture logic.

Resize ptp_io_perout[] to PCI11X1X_PTP_N_PEROUT (12) and set n_per_out
conditionally based on is_pci11x1x, so all 12 PTP-IO output pins can be
used simultaneously as periodic outputs.

Fixes: e432dd3bee2c ("net: lan743x: Add support for PTP-IO Event Output (Periodic Output)")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 4 +++-
 drivers/net/ethernet/microchip/lan743x_ptp.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index a3b48388b3fd..8453b9d954cf 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1530,7 +1530,9 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter)
 	ptp->ptp_clock_info.max_adj = LAN743X_PTP_MAX_FREQ_ADJ_IN_PPB;
 	ptp->ptp_clock_info.n_alarm = 0;
 	ptp->ptp_clock_info.n_ext_ts = LAN743X_PTP_N_EXTTS;
-	ptp->ptp_clock_info.n_per_out = LAN743X_PTP_N_EVENT_CHAN;
+	ptp->ptp_clock_info.n_per_out = adapter->is_pci11x1x ?
+					PCI11X1X_PTP_N_PEROUT :
+					LAN743X_PTP_N_EVENT_CHAN;
 	ptp->ptp_clock_info.n_pins = n_pins;
 	ptp->ptp_clock_info.pps = LAN743X_PTP_N_PPS;
 	ptp->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index f33dc83c5700..94373c65d5c8 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -19,6 +19,8 @@
 #define LAN743X_PTP_N_EVENT_CHAN	2
 #define LAN743X_PTP_N_PEROUT		LAN743X_PTP_N_EVENT_CHAN
 #define PCI11X1X_PTP_IO_MAX_CHANNELS	8
+#define PCI11X1X_PTP_IO_MAX_OUT_PINS	12
+#define PCI11X1X_PTP_N_PEROUT		PCI11X1X_PTP_IO_MAX_OUT_PINS
 #define LAN743X_PTP_N_EXTTS		PCI11X1X_PTP_IO_MAX_CHANNELS
 #define LAN743X_PTP_N_PPS		0
 #define PTP_CMD_CTL_TIMEOUT_CNT		50
@@ -83,8 +85,9 @@ struct lan743x_ptp {
 	struct ptp_pin_desc pin_config[LAN743X_PTP_N_GPIO];
 
 	unsigned long used_event_ch;
+	int event_ch_refcnt[LAN743X_PTP_N_EVENT_CHAN]; /* ref count for shared channel usage */
 	struct lan743x_ptp_perout perout[LAN743X_PTP_N_PEROUT];
-	int ptp_io_perout[LAN743X_PTP_N_PEROUT]; /* PTP event channel (0=channel A, 1=channel B) */
+	int ptp_io_perout[PCI11X1X_PTP_N_PEROUT]; /* PTP event channel per perout index */
 	struct lan743x_extts extts[LAN743X_PTP_N_EXTTS];
 
 	bool leds_multiplexed;
-- 
2.34.1


