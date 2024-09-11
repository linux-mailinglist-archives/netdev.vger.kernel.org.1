Return-Path: <netdev+bounces-127378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9A97538A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2216D1C22D2B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB41AB6C7;
	Wed, 11 Sep 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uljgJJMj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEYsffcZ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EC1A38DB;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060688; cv=none; b=B+u+pPOelYkiyGgXHwGuC1Dh1zx2JoJZL4ni5o3QvrPaKnL/uUo/SBtkQ07uYmaZbtuJnZHhAocTlEhGdmJYREocRVtZJUasmBH1e3LO1+j5EFULfXZ4tkp5+FRLAC/x/8Y4ZPK4MIzyUnMvRTGY6EtaKWhAGKGC2HHHyvvU4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060688; c=relaxed/simple;
	bh=kzKWAP0j/HyYybXXxBLd7Q5U6wtVkXfbHlOu03qp20k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hrc5NdHl04HFCno0iJBMfvXqvlw+68upsUU+tmJ5akrWyCo2J0SQF15pZql2wHA1H4j+3mcqzoh37gl2eYoZYR2nz0dMdRXCYq0hHpYxnq1yn/QY0HbtYSmGbZh/vM4sdQ2hEJ3PN3k/l6B3RVX2cEfdF+FlUVQ0gSBUtoH9Z+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uljgJJMj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEYsffcZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhnQyQlNdW/rX+y0sX1hWAWJJZILP74ZXR46RGRAe+I=;
	b=uljgJJMj8dvi/J8wR2g2zx8zngPS8R9cAFW+x0uDZVcZJZvEtDwdzYt/91RIpgn09V9SKv
	gBKQZZrYfnMBlyr0BobtV+TmDCN97Aj83xGWNdHRSc9ntvTMbtjVEE9iSRR8BWP9QTITQi
	tFSFCDJxBjhzPh2i9O/WvKTNuDBKrSjw8lM/1kUV7xQOLCOLXk+XzrBVmV4u2cBG01vawT
	MhfBW3hEExVMiSVK6AQGUF8dg/TGLXG6GtpO4gtjr2ji9GrXdGwo78Ig7qMNflgFJmg/CR
	gSTkS3a/UEPWF1tM9+lWj9f8ZeA1+V0r+icnHtvUWtmB6h+CmUlaa8jjE9TnHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhnQyQlNdW/rX+y0sX1hWAWJJZILP74ZXR46RGRAe+I=;
	b=KEYsffcZdOoDj9FuxFPEiAtnisngBH3XUWejyR6aJEsqNX/Dws5kTpcBO4OdZSv/NrTZCP
	WuvHz+HJAVQrDKCQ==
Date: Wed, 11 Sep 2024 15:17:56 +0200
Subject: [PATCH 20/21] ntp: Move pps_freq/stabil into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-20-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a9103b08d1ec..c3089d8be0f7 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -46,6 +46,8 @@
  * @pps_fbase:		PPS beginning of the last freq interval
  * @pps_shift:		PPS current interval duration in seconds (shift value)
  * @pps_intcnt:		PPS interval counter
+ * @pps_freq:		PPS frequency offset in scaled ns/s
+ * @pps_stabil:		PPS current stability in scaled ns/s
  *
  * Protected by the timekeeping locks.
  */
@@ -71,6 +73,8 @@ struct ntp_data {
 	struct timespec64	pps_fbase;
 	int			pps_shift;
 	int			pps_intcnt;
+	s64			pps_freq;
+	long			pps_stabil;
 #endif
 };
 
@@ -106,9 +110,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static s64 pps_freq;		/* frequency offset (scaled ns/s) */
-static long pps_stabil;		/* current stability (scaled ns/s) */
-
 /*
  * PPS signal quality monitors
  */
@@ -148,7 +149,7 @@ static inline void pps_clear(struct ntp_data *ntpdata)
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
 	ntpdata->pps_fbase.tv_sec = ntpdata->pps_fbase.tv_nsec = 0;
-	pps_freq = 0;
+	ntpdata->pps_freq = 0;
 }
 
 /*
@@ -166,9 +167,9 @@ static inline void pps_dec_valid(struct ntp_data *ntpdata)
 	}
 }
 
-static inline void pps_set_freq(s64 freq)
+static inline void pps_set_freq(struct ntp_data *ntpdata)
 {
-	pps_freq = freq;
+	ntpdata->pps_freq = ntpdata->time_freq;
 }
 
 static inline bool is_error_status(int status)
@@ -196,13 +197,13 @@ static inline bool is_error_status(int status)
 
 static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
-	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->ppsfreq	   = shift_right((ntpdata->pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = ntpdata->pps_shift;
-	txc->stabil	   = pps_stabil;
+	txc->stabil	   = ntpdata->pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
@@ -219,7 +220,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 static inline void pps_reset_freq_interval(struct ntp_data *ntpdata) {}
 static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
-static inline void pps_set_freq(s64 freq) {}
+static inline void pps_set_freq(struct ntp_data *ntpdata) {}
 
 static inline bool is_error_status(int status)
 {
@@ -719,7 +720,7 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		ntpdata->time_freq = min(ntpdata->time_freq, MAXFREQ_SCALED);
 		ntpdata->time_freq = max(ntpdata->time_freq, -MAXFREQ_SCALED);
 		/* Update pps_freq */
-		pps_set_freq(ntpdata->time_freq);
+		pps_set_freq(ntpdata);
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
@@ -948,8 +949,8 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	 */
 	ftemp = div_s64(((s64)(-freq_norm.nsec)) << NTP_SCALE_SHIFT,
 			freq_norm.sec);
-	delta = shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
-	pps_freq = ftemp;
+	delta = shift_right(ftemp - ntpdata->pps_freq, NTP_SCALE_SHIFT);
+	ntpdata->pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
@@ -967,12 +968,12 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	delta_mod = delta;
 	if (delta_mod < 0)
 		delta_mod = -delta_mod;
-	pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
-			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
+	ntpdata->pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
+				     NSEC_PER_USEC) - ntpdata->pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
 	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
-		ntpdata->time_freq = pps_freq;
+		ntpdata->time_freq = ntpdata->pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
 

-- 
2.39.2


