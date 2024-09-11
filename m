Return-Path: <netdev+bounces-127368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFE97537A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B0A1F2178D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B01A304E;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Xkh/odF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZByxKeqt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8419F118;
	Wed, 11 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060684; cv=none; b=N5XbKZAUKXhm0eO4faiCqjZitA6kBI5jNERWaifgIvaIV/LKCDeEDWzH6z6AkJPRh4GN79rhPEPx1x1nnP2oU5DARyEuHwVYvqfE9Y8cn4c3+wQJGJZs7BPfSDzjtkpQrNTx4YekQblAVUileB1pQx9mILlOlhYUDp4XtbGSVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060684; c=relaxed/simple;
	bh=Rj4Iu1ivde6gV8wW8KPvKBS5NFsza5Un5CoSREx1120=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlkRPaiMzLxkXfwgdLQnQLdG7OykFxMeFc8CoepBExD4tIEZLJFhXZ+BnSpTvsNvW/lhPuz1BPPPzKEOVLokPIMBAy8buU73I57lo9ISMMxaGYMeG3d6Nk6KcM27b8SorNXfgsQaZe9ApDjbtpsuDPjpTCIuk4fYd/4c/4M82Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Xkh/odF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZByxKeqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JbFFqKg305Ne707gN78UaOX7MWoUKFNnyExemYAgsE=;
	b=2Xkh/odFz/6wodewFhveVTTfuam42vNGd4E5/YG3fMvTqvauHBE5wmm0jJm7WTPrYcwHtC
	qMK5Mf9ivfhuBLsESdmj/1EwW/exVNm3noZz6m99y4Fv8VmnA65S2tk7nJOJeWB+CtVQDI
	IyCNPbI5SF67YPakcl10GzDGgI9N8H5Fe+c4JDlXP/w8O/DSsVfgIgpLbQTOHFn7BwRfzj
	gWl6qQStwYXZ9WQu0QrQ5B4sARJVuUWbGT//zWsJQBgefSo7f3HIp+bM/blC6aa35pIlmw
	H3fTNrTF6+qQARLRMoKkj6HyX32zSDWJMg0W06BGf3LBsfmE7VJOauliRK/1mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JbFFqKg305Ne707gN78UaOX7MWoUKFNnyExemYAgsE=;
	b=ZByxKeqtp0dfEgwHe+Y2euLo7oytXy7Xu17awyydeQ81XkAKxpH26BVpFZP1siUOdKTr2b
	CpfOP15jsJPpVCDw==
Date: Wed, 11 Sep 2024 15:17:48 +0200
Subject: [PATCH 12/21] ntp: Move time_freq/reftime into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 15708ac4d0fb..47c4f3e3562c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -34,6 +34,8 @@
  * @time_maxerror:	Maximum error in microseconds holding the NTP sync distance
  *			(NTP dispersion + delay / 2)
  * @time_esterror:	Estimated error in microseconds holding NTP dispersion
+ * @time_freq:		Frequency offset scaled nsecs/secs
+ * @time_reftime:	Time at last adjustment in seconds
  *
  * Protected by the timekeeping locks.
  */
@@ -47,6 +49,8 @@ struct ntp_data {
 	long			time_constant;
 	long			time_maxerror;
 	long			time_esterror;
+	s64			time_freq;
+	time64_t		time_reftime;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -64,12 +68,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/* frequency offset (scaled nsecs/secs):				*/
-static s64			time_freq;
-
-/* time at last adjustment (secs):					*/
-static time64_t		time_reftime;
-
 static long			time_adjust;
 
 /* constant (boot-param configurable) NTP tick adjustment (upscaled)	*/
@@ -245,7 +243,7 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
 	second_length		+= ntp_tick_adj;
-	second_length		+= time_freq;
+	second_length		+= ntpdata->time_freq;
 
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
@@ -294,11 +292,11 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	 * and in which mode (PLL or FLL).
 	 */
 	real_secs = __ktime_get_real_seconds();
-	secs = (long)(real_secs - time_reftime);
+	secs = (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
 
-	time_reftime = real_secs;
+	ntpdata->time_reftime = real_secs;
 
 	offset64    = offset;
 	freq_adj    = ntp_update_offset_fll(ntpdata, offset64, secs);
@@ -314,9 +312,9 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	freq_adj    += (offset64 * secs) <<
 			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + ntpdata->time_constant));
 
-	freq_adj    = min(freq_adj + time_freq, MAXFREQ_SCALED);
+	freq_adj    = min(freq_adj + ntpdata->time_freq, MAXFREQ_SCALED);
 
-	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
+	ntpdata->time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
 	ntpdata->time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
@@ -688,7 +686,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		time_reftime = __ktime_get_real_seconds();
+		ntpdata->time_reftime = __ktime_get_real_seconds();
 
 	/* only set allowed bits */
 	ntpdata->time_status &= STA_RONLY;
@@ -708,11 +706,11 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		ntpdata->time_status &= ~STA_NANO;
 
 	if (txc->modes & ADJ_FREQUENCY) {
-		time_freq = txc->freq * PPM_SCALE;
-		time_freq = min(time_freq, MAXFREQ_SCALED);
-		time_freq = max(time_freq, -MAXFREQ_SCALED);
+		ntpdata->time_freq = txc->freq * PPM_SCALE;
+		ntpdata->time_freq = min(ntpdata->time_freq, MAXFREQ_SCALED);
+		ntpdata->time_freq = max(ntpdata->time_freq, -MAXFREQ_SCALED);
 		/* Update pps_freq */
-		pps_set_freq(time_freq);
+		pps_set_freq(ntpdata->time_freq);
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
@@ -767,7 +765,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		/* If there are input parameters, then process them: */
 		if (txc->modes) {
 			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
-			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
@@ -775,7 +773,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			process_adjtimex_modes(ntpdata, txc, time_tai);
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
-			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
@@ -790,7 +788,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	if (is_error_status(ntpdata->time_status))
 		result = TIME_ERROR;
 
-	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->freq	   = shift_right((ntpdata->time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->maxerror	   = ntpdata->time_maxerror;
 	txc->esterror	   = ntpdata->time_esterror;
@@ -965,7 +963,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 
 	/* If enabled, the system clock frequency is updated */
 	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
-		time_freq = pps_freq;
+		ntpdata->time_freq = pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
 

-- 
2.39.2


