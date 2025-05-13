Return-Path: <netdev+bounces-190189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E935DAB5833
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439C21B450F8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343002BE7BF;
	Tue, 13 May 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qQzYXnP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cve6WldI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E32BEC4A;
	Tue, 13 May 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149190; cv=none; b=qAEy5sW6OOt5HrgMg+RetMZwzS0P2SZAYXEQ4cB5msMaECmhdhSPJfdo1DEXbKtQBLfpJZCcIOrmq0HJ3M6q+P0MY7Hj31c7PtL/J0NxCS8p3lteNIV/DMj27pYV4w05J4jRQNkyVEwBMQxGeFvZEkGNRQu0VyT/cpGlzteHsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149190; c=relaxed/simple;
	bh=DwwKEIuus+UdOr5RIQ8TMS6/CPXHoaDA2h/kN43G7Ms=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YJFb4gs/OIEw31EN/PWtoU4VpwkJm3ReCNpo/iKCOm4Lfc+DTujdXZOKQIhyglY359GJiptAL8SUoBYiYNAe/A4a9WxqRcE0PXnIJ0WlDuEuwkkIPaNquH1L8L8i6kl74+QFrzClfOuJZ+t5bKF7MToemWASJ4BK4LIUmngyqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qQzYXnP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cve6WldI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.028405706@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Lnxo/7P6rkACSSzndKZtUnq8tJQo2w4xcXNLeCMUnV4=;
	b=qQzYXnP6asRHxkwKy2GJe25QDCWky7oP20bfra8XqZh6Cz6yiV2trxwm/XzwFjDuxf0B2F
	JPg0QVTL+SK7ZOVwP3iTyQWxKI3NsdqBaCmVxFWKJj2Es30G1WTAqXu2O3TjAw38CSScyP
	EkynQ/xiKZTNLpFZdVcr7IK3dzghzZcVB0YuVOGNpAXs6Qz8NT3xwjS7FIGAnqqn7jjQ/K
	HnsqViysSkaDijQ7j76VtgUKzU7WzvLbWW3V/KTGb7fRuJFjRp8st1vpHfZgHWEVUZZMq0
	wChlSxINsLKRtL2U77Kz3pSHZ+hoFjcGqeROR3ck2aLhrTv9UhaKjY6fWBEFPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Lnxo/7P6rkACSSzndKZtUnq8tJQo2w4xcXNLeCMUnV4=;
	b=Cve6WldIVPzJkHqLlQDetVQlalP53aIeqgWIn3SZYNbpZdPFGOcMna+ajoxX6XAug8xliD
	/+DGlosGWbMQI6Cw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 06/26] ntp: Add support for PTP timekeepers
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:05 +0200 (CEST)

If PTP clocks are enabled, provide an array of NTP data so that independent
PTP clock timekeepers can be steered accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/audit.h>
+#include <linux/timekeeper_internal.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -86,14 +87,16 @@ struct ntp_data {
 #endif
 };
 
-static struct ntp_data tk_ntp_data = {
-	.tick_usec		= USER_TICK_USEC,
-	.time_state		= TIME_OK,
-	.time_status		= STA_UNSYNC,
-	.time_constant		= 2,
-	.time_maxerror		= NTP_PHASE_LIMIT,
-	.time_esterror		= NTP_PHASE_LIMIT,
-	.ntp_next_leap_sec	= TIME64_MAX,
+static struct ntp_data tk_ntp_data[TIMEKEEPERS_MAX] = {
+	[ 0 ... TIMEKEEPERS_MAX - 1 ] = {
+		.tick_usec		= USER_TICK_USEC,
+		.time_state		= TIME_OK,
+		.time_status		= STA_UNSYNC,
+		.time_constant		= 2,
+		.time_maxerror		= NTP_PHASE_LIMIT,
+		.time_esterror		= NTP_PHASE_LIMIT,
+		.ntp_next_leap_sec	= TIME64_MAX,
+	},
 };
 
 #define SECS_PER_DAY		86400
@@ -351,13 +354,13 @@ static void __ntp_clear(struct ntp_data
  */
 void ntp_clear(void)
 {
-	__ntp_clear(&tk_ntp_data);
+	__ntp_clear(&tk_ntp_data[TIMEKEEPER_CORE]);
 }
 
 
 u64 ntp_tick_length(void)
 {
-	return tk_ntp_data.tick_length;
+	return tk_ntp_data[TIMEKEEPER_CORE].tick_length;
 }
 
 /**
@@ -368,7 +371,7 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	ktime_t ret;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
@@ -389,7 +392,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -605,7 +608,7 @@ static inline int update_rtc(struct time
  */
 static inline bool ntp_synced(void)
 {
-	return !(tk_ntp_data.time_status & STA_UNSYNC);
+	return !(tk_ntp_data[TIMEKEEPER_CORE].time_status & STA_UNSYNC);
 }
 
 /*
@@ -762,7 +765,7 @@ static inline void process_adjtimex_mode
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
@@ -1031,8 +1034,8 @@ static void hardpps_update_phase(struct
  */
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	struct pps_normtime pts_norm, freq_norm;
-	struct ntp_data *ntpdata = &tk_ntp_data;
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
@@ -1083,18 +1086,18 @@ void __hardpps(const struct timespec64 *
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
+	int rc = kstrtos64(str, 0, &tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj);
 	if (rc)
 		return rc;
 
-	tk_ntp_data.ntp_tick_adj <<= NTP_SCALE_SHIFT;
+	tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
-
 __setup("ntp_tick_adj=", ntp_tick_adj_setup);
 
 void __init ntp_init(void)
 {
-	ntp_clear();
+	for (int id = 0; id < TIMEKEEPERS_MAX; id++)
+		__ntp_clear(tk_ntp_data + id);
 	ntp_init_cmos_sync();
 }


