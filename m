Return-Path: <netdev+bounces-127361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EB97536D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FC51F27444
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C119C553;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRg0x5V8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="93zpju5x"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F83188924;
	Wed, 11 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060680; cv=none; b=pezYMzQosvks/c6B5acKzdkvmpH48CTlgLMRJ0dHpGSGf7RORinwcviN6BKRS1lrNzooV7DPZuwLBM3guY289n0xxsL2pJWZGrMAisGj7Erdw3I4rtUk8/ivp3EB8JN6oZUgFu0vXRjxEUx8fAFIDgl+m2FSyl7P/ZD/8PsXuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060680; c=relaxed/simple;
	bh=fgDIxovmR+O6gyO4iQm1kvPpi2Rc+D+6v0cg0aS1+4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9ZosJ4PP2B54wWx1MzMdk/Mo0ULQxaaUnAwpZXcTessW1g2agILrNmzG5yWnuBABRAQpU6Bc1h9dupbn+EWtbVcSgNMusa87bTduxwip6nudgTgOZ8cr59e1cdZNXzC3J0ag4CcAUaijxd2Jj/ffZH+6jbZtCVVRPcITxHFZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRg0x5V8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=93zpju5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ8k8a4/pacG0om765Mucc7+Qw1DbjOAO73zMGi/Ls4=;
	b=jRg0x5V8K/B8oeoM9S3q34lKD37vW8aoEmV0VOA98wePzQ9Y2Q6Kl6LIm6rF8FtFOiEOyW
	ZLfhJNWZOsYj4/uqhIY7YRid0cf9TrWXoD6CPu05Ip+QN+d8oLJlN6UP+kIj2XQMsidlki
	6HfiWSsmnO+wLOjz2ej3qawFAitw+sgPtZcpBix3i9vktk7UqRXfSx4ID1usMkpMg8AwOt
	rHWVXt+hsUt4ZrGp4CmolLdwarcdMhnsi6wJUZIXNos4LEw9PEzTemaTL7Cne6HGXY33Wj
	RceY/yOJmBpsUyY405UqPBET1D8Olt9izH89l+N0Q3QGt7u/vfwwBOyKtyCohw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ8k8a4/pacG0om765Mucc7+Qw1DbjOAO73zMGi/Ls4=;
	b=93zpju5xEQSDZvvb9gS9W3dZ5S1hhCy9G/Gh7glqAKTV69s7uLiwP3LRvnJcAX6wOGFw7N
	76RceADw73UDuOBA==
Date: Wed, 11 Sep 2024 15:17:39 +0200
Subject: [PATCH 03/21] ntp: Clean up comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
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

Usage of different comment formatting makes fast reading and parsing the
code harder. There are several multi-line comments which do not follow the
coding style by starting with a line only containing '/*'. There are also
comments which do not start with capitals.

Clean up all those comments to be consistent and remove comments which
document the obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 144 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8e68a85996f7..99213d931f63 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -119,7 +119,8 @@ static long pps_stbcnt;		/* stability limit exceeded */
 static long pps_errcnt;		/* calibration errors */
 
 
-/* PPS kernel consumer compensates the whole phase error immediately.
+/*
+ * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
 static inline s64 ntp_offset_chunk(s64 offset)
@@ -132,8 +133,7 @@ static inline s64 ntp_offset_chunk(s64 offset)
 
 static inline void pps_reset_freq_interval(void)
 {
-	/* the PPS calibration interval may end
-	   surprisingly early */
+	/* The PPS calibration interval may end surprisingly early */
 	pps_shift = PPS_INTMIN;
 	pps_intcnt = 0;
 }
@@ -151,9 +151,9 @@ static inline void pps_clear(void)
 	pps_freq = 0;
 }
 
-/* Decrease pps_valid to indicate that another second has passed since
- * the last PPS signal. When it reaches 0, indicate that PPS signal is
- * missing.
+/*
+ * Decrease pps_valid to indicate that another second has passed since the
+ * last PPS signal. When it reaches 0, indicate that PPS signal is missing.
  */
 static inline void pps_dec_valid(void)
 {
@@ -174,17 +174,21 @@ static inline void pps_set_freq(s64 freq)
 static inline int is_error_status(int status)
 {
 	return (status & (STA_UNSYNC|STA_CLOCKERR))
-		/* PPS signal lost when either PPS time or
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS signal lost when either PPS time or PPS frequency
+		 * synchronization requested
 		 */
 		|| ((status & (STA_PPSFREQ|STA_PPSTIME))
 			&& !(status & STA_PPSSIGNAL))
-		/* PPS jitter exceeded when
-		 * PPS time synchronization requested */
+		/*
+		 * PPS jitter exceeded when PPS time synchronization
+		 * requested
+		 */
 		|| ((status & (STA_PPSTIME|STA_PPSJITTER))
 			== (STA_PPSTIME|STA_PPSJITTER))
-		/* PPS wander exceeded or calibration error when
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS wander exceeded or calibration error when PPS
+		 * frequency synchronization requested
 		 */
 		|| ((status & STA_PPSFREQ)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
@@ -270,8 +274,8 @@ static void ntp_update_frequency(void)
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
 	/*
-	 * Don't wait for the next second_overflow, apply
-	 * the change to the tick length immediately:
+	 * Don't wait for the next second_overflow, apply the change to the
+	 * tick length immediately:
 	 */
 	tick_length		+= new_base - tick_length_base;
 	tick_length_base	 = new_base;
@@ -307,10 +311,7 @@ static void ntp_update_offset(long offset)
 		offset *= NSEC_PER_USEC;
 	}
 
-	/*
-	 * Scale the phase adjustment and
-	 * clamp to the operating range.
-	 */
+	/* Scale the phase adjustment and clamp to the operating range. */
 	offset = clamp(offset, -MAXPHASE, MAXPHASE);
 
 	/*
@@ -349,7 +350,8 @@ static void ntp_update_offset(long offset)
  */
 void ntp_clear(void)
 {
-	time_adjust	= 0;		/* stop active adjtime() */
+	/* Stop active adjtime() */
+	time_adjust	= 0;
 	time_status	|= STA_UNSYNC;
 	time_maxerror	= NTP_PHASE_LIMIT;
 	time_esterror	= NTP_PHASE_LIMIT;
@@ -387,7 +389,7 @@ ktime_t ntp_get_next_leap(void)
 }
 
 /*
- * this routine handles the overflow of the microsecond field
+ * This routine handles the overflow of the microsecond field
  *
  * The tricky bits of code to handle the accurate clock support
  * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
@@ -452,7 +454,6 @@ int second_overflow(time64_t secs)
 		break;
 	}
 
-
 	/* Bump the maxerror field */
 	time_maxerror += MAXFREQ / NSEC_PER_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
@@ -688,7 +689,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 		time_state = TIME_OK;
 		time_status = STA_UNSYNC;
 		ntp_next_leap_sec = TIME64_MAX;
-		/* restart PPS frequency calibration */
+		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
 	}
 
@@ -699,7 +700,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 	if (!(time_status & STA_PLL) && (txc->status & STA_PLL))
 		time_reftime = __ktime_get_real_seconds();
 
-	/* only set allowed bits */
+	/* Only set allowed bits */
 	time_status &= STA_RONLY;
 	time_status |= txc->status & ~STA_RONLY;
 }
@@ -721,7 +722,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_freq = txc->freq * PPM_SCALE;
 		time_freq = min(time_freq, MAXFREQ_SCALED);
 		time_freq = max(time_freq, -MAXFREQ_SCALED);
-		/* update pps_freq */
+		/* Update pps_freq */
 		pps_set_freq(time_freq);
 	}
 
@@ -754,7 +755,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 
 
 /*
- * adjtimex mainly allows reading (and writing, if superuser) of
+ * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
@@ -798,8 +799,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
 
-	result = time_state;	/* mostly `TIME_OK' */
-	/* check for errors */
+	result = time_state;
 	if (is_error_status(time_status))
 		result = TIME_ERROR;
 
@@ -814,7 +814,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->tick	   = tick_usec;
 	txc->tai	   = *time_tai;
 
-	/* fill PPS status fields */
+	/* Fill PPS status fields */
 	pps_fill_timex(txc);
 
 	txc->time.tv_sec = ts->tv_sec;
@@ -845,17 +845,21 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 #ifdef	CONFIG_NTP_PPS
 
-/* actually struct pps_normtime is good old struct timespec, but it is
+/*
+ * struct pps_normtime is basically a struct timespec, but it is
  * semantically different (and it is the reason why it was invented):
  * pps_normtime.nsec has a range of ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ]
- * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC) */
+ * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC)
+ */
 struct pps_normtime {
 	s64		sec;	/* seconds */
 	long		nsec;	/* nanoseconds */
 };
 
-/* normalize the timestamp so that nsec is in the
-   ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval */
+/*
+ * Normalize the timestamp so that nsec is in the
+ * [ -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval
+ */
 static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 {
 	struct pps_normtime norm = {
@@ -871,7 +875,7 @@ static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 	return norm;
 }
 
-/* get current phase correction and jitter */
+/* Get current phase correction and jitter */
 static inline long pps_phase_filter_get(long *jitter)
 {
 	*jitter = pps_tf[0] - pps_tf[1];
@@ -882,7 +886,7 @@ static inline long pps_phase_filter_get(long *jitter)
 	return pps_tf[0];
 }
 
-/* add the sample to the phase filter */
+/* Add the sample to the phase filter */
 static inline void pps_phase_filter_add(long err)
 {
 	pps_tf[2] = pps_tf[1];
@@ -890,8 +894,9 @@ static inline void pps_phase_filter_add(long err)
 	pps_tf[0] = err;
 }
 
-/* decrease frequency calibration interval length.
- * It is halved after four consecutive unstable intervals.
+/*
+ * Decrease frequency calibration interval length. It is halved after four
+ * consecutive unstable intervals.
  */
 static inline void pps_dec_freq_interval(void)
 {
@@ -904,8 +909,9 @@ static inline void pps_dec_freq_interval(void)
 	}
 }
 
-/* increase frequency calibration interval length.
- * It is doubled after four consecutive stable intervals.
+/*
+ * Increase frequency calibration interval length. It is doubled after
+ * four consecutive stable intervals.
  */
 static inline void pps_inc_freq_interval(void)
 {
@@ -918,7 +924,8 @@ static inline void pps_inc_freq_interval(void)
 	}
 }
 
-/* update clock frequency based on MONOTONIC_RAW clock PPS signal
+/*
+ * Update clock frequency based on MONOTONIC_RAW clock PPS signal
  * timestamps
  *
  * At the end of the calibration interval the difference between the
@@ -932,7 +939,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	long delta, delta_mod;
 	s64 ftemp;
 
-	/* check if the frequency interval was too long */
+	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << pps_shift)) {
 		time_status |= STA_PPSERROR;
 		pps_errcnt++;
@@ -943,9 +950,10 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		return 0;
 	}
 
-	/* here the raw frequency offset and wander (stability) is
-	 * calculated. If the wander is less than the wander threshold
-	 * the interval is increased; otherwise it is decreased.
+	/*
+	 * Here the raw frequency offset and wander (stability) is
+	 * calculated. If the wander is less than the wander threshold the
+	 * interval is increased; otherwise it is decreased.
 	 */
 	ftemp = div_s64(((s64)(-freq_norm.nsec)) << NTP_SCALE_SHIFT,
 			freq_norm.sec);
@@ -957,13 +965,14 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
-	} else {	/* good sample */
+	} else {
+		/* Good sample */
 		pps_inc_freq_interval();
 	}
 
-	/* the stability metric is calculated as the average of recent
-	 * frequency changes, but is used only for performance
-	 * monitoring
+	/*
+	 * The stability metric is calculated as the average of recent
+	 * frequency changes, but is used only for performance monitoring
 	 */
 	delta_mod = delta;
 	if (delta_mod < 0)
@@ -972,7 +981,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 				(NTP_SCALE_SHIFT - SHIFT_USEC),
 				NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
-	/* if enabled, the system clock frequency is updated */
+	/* If enabled, the system clock frequency is updated */
 	if ((time_status & STA_PPSFREQ) != 0 &&
 	    (time_status & STA_FREQHOLD) == 0) {
 		time_freq = pps_freq;
@@ -982,17 +991,18 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	return delta;
 }
 
-/* correct REALTIME clock phase error against PPS signal */
+/* Correct REALTIME clock phase error against PPS signal */
 static void hardpps_update_phase(long error)
 {
 	long correction = -error;
 	long jitter;
 
-	/* add the sample to the median filter */
+	/* Add the sample to the median filter */
 	pps_phase_filter_add(correction);
 	correction = pps_phase_filter_get(&jitter);
 
-	/* Nominal jitter is due to PPS signal noise. If it exceeds the
+	/*
+	 * Nominal jitter is due to PPS signal noise. If it exceeds the
 	 * threshold, the sample is discarded; otherwise, if so enabled,
 	 * the time offset is updated.
 	 */
@@ -1003,13 +1013,13 @@ static void hardpps_update_phase(long error)
 		time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (time_status & STA_PPSTIME) {
-		/* correct the time using the phase offset */
+		/* Correct the time using the phase offset */
 		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
 				NTP_INTERVAL_FREQ);
-		/* cancel running adjtime() */
+		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}
-	/* update jitter */
+	/* Update jitter */
 	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
 }
 
@@ -1031,41 +1041,43 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
-	/* clear the error bits, they will be set again if needed */
+	/* Clear the error bits, they will be set again if needed */
 	time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
 
-	/* indicate signal presence */
+	/* Indicate signal presence */
 	time_status |= STA_PPSSIGNAL;
 	pps_valid = PPS_VALID;
 
-	/* when called for the first time,
-	 * just start the frequency interval */
+	/*
+	 * When called for the first time, just start the frequency
+	 * interval
+	 */
 	if (unlikely(pps_fbase.tv_sec == 0)) {
 		pps_fbase = *raw_ts;
 		return;
 	}
 
-	/* ok, now we have a base for frequency calculation */
+	/* Ok, now we have a base for frequency calculation */
 	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, pps_fbase));
 
-	/* check that the signal is in the range
-	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it */
+	/*
+	 * Check that the signal is in the range
+	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it
+	 */
 	if ((freq_norm.sec == 0) ||
 			(freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
 			(freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		time_status |= STA_PPSJITTER;
-		/* restart the frequency calibration interval */
+		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
 
-	/* signal is ok */
-
-	/* check if the current frequency interval is finished */
+	/* Signal is ok. Check if the current frequency interval is finished */
 	if (freq_norm.sec >= (1 << pps_shift)) {
 		pps_calcnt++;
-		/* restart the frequency calibration interval */
+		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		hardpps_update_freq(freq_norm);
 	}

-- 
2.39.2


