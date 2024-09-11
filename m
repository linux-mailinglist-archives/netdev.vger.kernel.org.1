Return-Path: <netdev+bounces-127369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3B97537B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B141C22A09
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3E1A304C;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVuuMAxA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EowkjqiW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8719F113;
	Wed, 11 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060684; cv=none; b=GXqbaOnQ7C8qykB37rjuF0j9O4bq1x/MJcZvn+Drw6CPLp/kQH4Lvf5U/438A1gZhaLKozsPg8Nkhn0ktiW5nLSHB/QqEdK29zrX+AhxAG4OdwuWuY89s7gwnMd/RcNQE7CbBAntZQlyA0ZEaS0smzoqGIrhrGSA/qybKhgjrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060684; c=relaxed/simple;
	bh=/7/cQAm6c+VPpGB6sKQdsbs/hZBQbnWXfQzfOGAwiIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1h2AIg14v9gySHmOIjx9yJfEkdCdb6hKDvgicNfhatXB53W9za+SmLJzIO34+jGT319efTIPd9tPlRvZLpCa8awbatVjolbmLWmYpc7TZP/FrjtecsiztNmkRLPt40ju/dBlGQMNSUSCGtzaC3yN37uikDE3xA22pLJvP2ozoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVuuMAxA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EowkjqiW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lZv5r6K6oZyhr+iRfkcuHOJPu2YKVlua/RSxGakRPM=;
	b=hVuuMAxApqiO5ajaHwDX2xjKahenSeZJyrdg8ZKRcngzhIPH3zeyDNY5bLSwIVk9w3BE0w
	YNesnVIoWHcMg6y644BDETXAhttqwoK2s2VjUtQye8ikQcjjX9DhbbKu20K9kcAVXcHeb4
	ecb9fFYusDlgMs4gtMbRNuH6WrXd6yK2ekE6GqkcjZrnGX6JrDPdrpDQWDSVeJbIvJ9r8x
	sBtDCgh5K23nPiX5+dAdWrw9/ug3BA1qOIGtIdLx2fkUHpPA6kNUHxFlwmltSjUJag53BB
	yIFzldYoiCDJTEgW100ffBRHuSL1Y6f0sorD/Afo7NogL/gw+jzHxMU1CfuyZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lZv5r6K6oZyhr+iRfkcuHOJPu2YKVlua/RSxGakRPM=;
	b=EowkjqiWV6bdXsll6744888CaF8nu08CBmOlezXZzMCgjceyDWGuDahiEwZRi8G33mdXyZ
	PrXaxaWUrBJETrCw==
Date: Wed, 11 Sep 2024 15:17:46 +0200
Subject: [PATCH 10/21] ntp: Move time_offset/constant into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 6d87f9889b03..ffe65b0d0a5e 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -29,6 +29,8 @@
  * @tick_length_base:	Base value for @tick_length
  * @time_state:		State of the clock synchronization
  * @time_status:	Clock status bits
+ * @time_offset:	Time adjustment in nanoseconds
+ * @time_constant:	PLL time constant
  *
  * Protected by the timekeeping locks.
  */
@@ -38,12 +40,15 @@ struct ntp_data {
 	u64			tick_length_base;
 	int			time_state;
 	int			time_status;
+	s64			time_offset;
+	long			time_constant;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
 	.time_state		= TIME_OK,
 	.time_status		= STA_UNSYNC,
+	.time_constant		= 2,
 };
 
 #define SECS_PER_DAY		86400
@@ -59,12 +64,6 @@ static struct ntp_data tk_ntp_data = {
  * estimated error = NTP dispersion.
  */
 
-/* time adjustment (nsecs):						*/
-static s64			time_offset;
-
-/* pll time constant:							*/
-static long			time_constant = 2;
-
 /* maximum error (usecs):						*/
 static long			time_maxerror = NTP_PHASE_LIMIT;
 
@@ -128,7 +127,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 	if (ntpdata->time_status & STA_PPSTIME && ntpdata->time_status & STA_PPSSIGNAL)
 		return offset;
 	else
-		return shift_right(offset, SHIFT_PLL + time_constant);
+		return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
 static inline void pps_reset_freq_interval(void)
@@ -211,9 +210,9 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 
 #else /* !CONFIG_NTP_PPS */
 
-static inline s64 ntp_offset_chunk(struct ntp_data *ntp, s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	return shift_right(offset, SHIFT_PLL + time_constant);
+	return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
 static inline void pps_reset_freq_interval(void) {}
@@ -315,17 +314,17 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	 * sampling rate (e.g. intermittent network connection)
 	 * to avoid instability.
 	 */
-	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + time_constant)))
-		secs = 1 << (SHIFT_PLL + 1 + time_constant);
+	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + ntpdata->time_constant)))
+		secs = 1 << (SHIFT_PLL + 1 + ntpdata->time_constant);
 
 	freq_adj    += (offset64 * secs) <<
-			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + time_constant));
+			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + ntpdata->time_constant));
 
 	freq_adj    = min(freq_adj + time_freq, MAXFREQ_SCALED);
 
 	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
-	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+	ntpdata->time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
 
 static void __ntp_clear(struct ntp_data *ntpdata)
@@ -339,7 +338,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	ntp_update_frequency(ntpdata);
 
 	ntpdata->tick_length	= ntpdata->tick_length_base;
-	time_offset		= 0;
+	ntpdata->time_offset	= 0;
 
 	ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
@@ -452,8 +451,8 @@ int second_overflow(time64_t secs)
 	/* Compute the phase adjustment for the next second */
 	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta			 = ntp_offset_chunk(ntpdata, time_offset);
-	time_offset		-= delta;
+	delta			 = ntp_offset_chunk(ntpdata, ntpdata->time_offset);
+	ntpdata->time_offset	-= delta;
 	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
@@ -729,10 +728,10 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = clamp(txc->constant, 0, MAXTC);
+		ntpdata->time_constant = clamp(txc->constant, 0, MAXTC);
 		if (!(ntpdata->time_status & STA_NANO))
-			time_constant += 4;
-		time_constant = clamp(time_constant, 0, MAXTC);
+			ntpdata->time_constant += 4;
+		ntpdata->time_constant = clamp(ntpdata->time_constant, 0, MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI && txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
@@ -773,7 +772,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	} else {
 		/* If there are input parameters, then process them: */
 		if (txc->modes) {
-			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
@@ -781,15 +780,14 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 			process_adjtimex_modes(ntpdata, txc, time_tai);
 
-			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
-		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
-				  NTP_SCALE_SHIFT);
+		txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
 		if (!(ntpdata->time_status & STA_NANO))
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
@@ -803,7 +801,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = ntpdata->time_status;
-	txc->constant	   = time_constant;
+	txc->constant	   = ntpdata->time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
 	txc->tick	   = ntpdata->tick_usec;
@@ -1002,7 +1000,8 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
-		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
+					       NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}

-- 
2.39.2


