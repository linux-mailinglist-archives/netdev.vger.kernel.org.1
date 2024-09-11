Return-Path: <netdev+bounces-127365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EE975374
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BED1F21589
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3E1A2620;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OapWP18H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/5Pzt0E"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9B19E98C;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060683; cv=none; b=OSrdDaywivh47cU2SOhjn6NXEh/mtQstAsIwxGZhn/6M3W4ESWxTMbnVFnMPYda+DVTr/fsaOvfoK8KRk+BLoSJGYZ4/dWX7qiTBX27DGpmtVfymCqD+38ACaq+LxsXxtWdGw8UYAHd8KlDULccAuFopmhpZ8QooMyb+XcYof0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060683; c=relaxed/simple;
	bh=031nbNNh15p2+Nc2smc3wdle/5MlfTElDr4SLgtVumg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4ehWWty9U36SwY1HmJzzitmSz1HvEQ4UMmXbuWdpSffnahHpOSlEa7PPll//2TfaxpbE9f1SbKu4p6undRjzPYfNn0NAbgnkVbFk66gWHwtY7gnieIvbBdVtBn9knAxZh566rzR3A7F2iJJfF1ZnVyT5py8vYFwDDLebkMusaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OapWP18H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/5Pzt0E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gweTRhv1XfM5ayJMavZ8lkpktxTkQkmd6055R9JLJi4=;
	b=OapWP18HiOalUs1pbvw5QGOMrSRsl3bblnRaINDe15jVEreIE7lm7EXXNDSym59VLI67YA
	KD3Jw8NpnarZH2MVmg1HqbGrfTRHuTJqYlBvL0AJ2/czAH+IU4ab+YmW4KyOg87pcf3OAy
	qYEt/IMq6/FaJmMqfviY7XKLe6heBYL92+fGmA4C2Tg/f2/uGaq0ZxPtmtmPzAR0T+QKiR
	qfkXoQyNlN0uaxYjgGor9c8I2Hraz776/4H0/9GsT3A+Ice3sQAq2YC63s4EN74TnrdKrL
	6Tc+wXbeZ7KG7ToNOOGVerzxJ2L5g22t3BqoK7zrhZ0qC6sRFuKBFde2HdKZKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gweTRhv1XfM5ayJMavZ8lkpktxTkQkmd6055R9JLJi4=;
	b=K/5Pzt0EJYWMBxmZJvxEHcfhQGS/AInBYrCXGBoXvBOJ+/Z7wRl8Js+2EW+nWbaErpMEKx
	Oml+QUqSN8WSS8BA==
Date: Wed, 11 Sep 2024 15:17:43 +0200
Subject: [PATCH 07/21] ntp: Introduce struct ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
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

All NTP data is held in static variables. That prevents the NTP code from
being reuasble for non-system time timekeepers, e.g. per PTP clock
timekeeping.

Introduce struct ntp_data and move tick_usec into it for a start.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 65 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 477cb08062bc..0222f8e46081 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -22,16 +22,19 @@
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
 
-
-/*
- * NTP timekeeping variables:
+/**
+ * struct ntp_data - Structure holding all NTP related state
+ * @tick_usec:		USER_HZ period in microseconds
  *
- * Note: All of the NTP state is protected by the timekeeping locks.
+ * Protected by the timekeeping locks.
  */
+struct ntp_data {
+	unsigned long		tick_usec;
+};
 
-
-/* USER_HZ period (usecs): */
-static unsigned long		tick_usec = USER_TICK_USEC;
+static struct ntp_data tk_ntp_data = {
+	.tick_usec		= USER_TICK_USEC,
+};
 
 static u64			tick_length;
 static u64			tick_length_base;
@@ -245,13 +248,11 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
  * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
  * time_freq:
  */
-static void ntp_update_frequency(void)
+static void ntp_update_frequency(struct ntp_data *ntpdata)
 {
-	u64 second_length;
-	u64 new_base;
+	u64 second_length, new_base, tick_usec = (u64)ntpdata->tick_usec;
 
-	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ)
-						<< NTP_SCALE_SHIFT;
+	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
 	second_length		+= ntp_tick_adj;
 	second_length		+= time_freq;
@@ -330,10 +331,7 @@ static void ntp_update_offset(long offset)
 	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
 
-/**
- * ntp_clear - Clears the NTP state variables
- */
-void ntp_clear(void)
+static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
 	time_adjust	= 0;
@@ -341,7 +339,7 @@ void ntp_clear(void)
 	time_maxerror	= NTP_PHASE_LIMIT;
 	time_esterror	= NTP_PHASE_LIMIT;
 
-	ntp_update_frequency();
+	ntp_update_frequency(ntpdata);
 
 	tick_length	= tick_length_base;
 	time_offset	= 0;
@@ -351,6 +349,14 @@ void ntp_clear(void)
 	pps_clear();
 }
 
+/**
+ * ntp_clear - Clears the NTP state variables
+ */
+void ntp_clear(void)
+{
+	__ntp_clear(&tk_ntp_data);
+}
+
 
 u64 ntp_tick_length(void)
 {
@@ -698,7 +704,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 }
 
 
-static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
+static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct __kernel_timex *txc,
 					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
@@ -739,13 +745,12 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		ntp_update_offset(txc->offset);
 
 	if (txc->modes & ADJ_TICK)
-		tick_usec = txc->tick;
+		ntpdata->tick_usec = txc->tick;
 
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
-		ntp_update_frequency();
+		ntp_update_frequency(ntpdata);
 }
 
-
 /*
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
@@ -753,6 +758,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
@@ -761,7 +767,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		if (!(txc->modes & ADJ_OFFSET_READONLY)) {
 			/* adjtime() is independent from ntp_adjtime() */
 			time_adjust = txc->offset;
-			ntp_update_frequency();
+			ntp_update_frequency(ntpdata);
 
 			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
 			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
@@ -774,15 +780,15 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 
-			process_adjtimex_modes(txc, time_tai);
+			process_adjtimex_modes(ntpdata, txc, time_tai);
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
@@ -803,7 +809,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->constant	   = time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
-	txc->tick	   = tick_usec;
+	txc->tick	   = ntpdata->tick_usec;
 	txc->tai	   = *time_tai;
 
 	/* Fill PPS status fields */
@@ -924,7 +930,7 @@ static inline void pps_inc_freq_interval(void)
  * too long, the data are discarded.
  * Returns the difference between old and new frequency values.
  */
-static long hardpps_update_freq(struct pps_normtime freq_norm)
+static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime freq_norm)
 {
 	long delta, delta_mod;
 	s64 ftemp;
@@ -971,7 +977,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	/* If enabled, the system clock frequency is updated */
 	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
-		ntp_update_frequency();
+		ntp_update_frequency(ntpdata);
 	}
 
 	return delta;
@@ -1022,6 +1028,7 @@ static void hardpps_update_phase(long error)
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
 	struct pps_normtime pts_norm, freq_norm;
+	struct ntp_data *ntpdata = &tk_ntp_data;
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
@@ -1062,7 +1069,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
-		hardpps_update_freq(freq_norm);
+		hardpps_update_freq(ntpdata, freq_norm);
 	}
 
 	hardpps_update_phase(pts_norm.nsec);

-- 
2.39.2


