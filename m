Return-Path: <netdev+bounces-127367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06C975378
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5E1F2288C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04BE1A2844;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESQ6KKtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dt+no9/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3919F116;
	Wed, 11 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060684; cv=none; b=PqThcSbiXbzkPRbJnKVgPCXZOlggufDDiIWZcycpb5vCNHvRGAxbI2qKbIi2aaCutYFBc50r+fRLL64+WKKYj+ZdT9fYAkpyCE8CoV9CEAs6rtYz8Vazvov6QwGMfdkafgoPgEdn692ZD8JKVAajkA7+kwXSr+fzGN1286C0Nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060684; c=relaxed/simple;
	bh=fxuqjESSmaBDIDApA5ps5eZRN5Xh5lwLTP7Vupi8Ek0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btktTa1vFELXY9482Rv1Q2i2pT3IZiUx+aeJXzbftiZ4yXeJ20J/QEoVegphymzyKknnX7Fifj4n3SS0yF/VlhjTGdQ+hHD11y9ypGsgZRpUKY2J5qzUAOjOiQoZo3zhRahQmQHZ34g8JSFSwQE3U3f+JD1dyL46lcAaSzYnn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESQ6KKtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+dt+no9/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdjTQH4O8tthP8ZOo2pIJZpAoNz8pjgmrz7cqZqSXfw=;
	b=ESQ6KKtJ1Y5Z83pTLpTO6l5VQuT7EIJUP8XY3mjcTOv4dDP8TccQv+UK135EEzhx6ukzGB
	JMRPvTXytglK0kiRJlijTpk+UFoDRTryOxkKrzp8Ys0E2NpKqo37JMiT06zOfuUUEAagfP
	WbZ6mnGwyj3tAjBvoOADr3MNnql/pG5SBUY3WAEGMzCL88Wy4MMGzEFjMfxkR+g65UUvgV
	UpSqJAmoTQWbUqe+567g9xuREzn2oXy04iHKcJQdPSJlPmGgkJ/Zzzi0wRdrAuy8UTOIwH
	l3XydmxgFP9sAVUrzDE2m2PxA6wgomTRQLggeMVZoPUJFuntBr7x5tu6DDCVMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdjTQH4O8tthP8ZOo2pIJZpAoNz8pjgmrz7cqZqSXfw=;
	b=+dt+no9/4E3hxgHpPirevZ08xMEJT1t03tsr1gRr/UytzAUZxcynojSuxi1oFJJhh0sKZW
	mkhX7bw46DEWk2Cw==
Date: Wed, 11 Sep 2024 15:17:47 +0200
Subject: [PATCH 11/21] ntp: Move time_max/esterror into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-11-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index ffe65b0d0a5e..15708ac4d0fb 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -31,6 +31,9 @@
  * @time_status:	Clock status bits
  * @time_offset:	Time adjustment in nanoseconds
  * @time_constant:	PLL time constant
+ * @time_maxerror:	Maximum error in microseconds holding the NTP sync distance
+ *			(NTP dispersion + delay / 2)
+ * @time_esterror:	Estimated error in microseconds holding NTP dispersion
  *
  * Protected by the timekeeping locks.
  */
@@ -42,6 +45,8 @@ struct ntp_data {
 	int			time_status;
 	s64			time_offset;
 	long			time_constant;
+	long			time_maxerror;
+	long			time_esterror;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -49,6 +54,8 @@ static struct ntp_data tk_ntp_data = {
 	.time_state		= TIME_OK,
 	.time_status		= STA_UNSYNC,
 	.time_constant		= 2,
+	.time_maxerror		= NTP_PHASE_LIMIT,
+	.time_esterror		= NTP_PHASE_LIMIT,
 };
 
 #define SECS_PER_DAY		86400
@@ -57,19 +64,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/*
- * phase-lock loop variables
- *
- * Note: maximum error = NTP sync distance = dispersion + delay / 2;
- * estimated error = NTP dispersion.
- */
-
-/* maximum error (usecs):						*/
-static long			time_maxerror = NTP_PHASE_LIMIT;
-
-/* estimated error (usecs):						*/
-static long			time_esterror = NTP_PHASE_LIMIT;
-
 /* frequency offset (scaled nsecs/secs):				*/
 static s64			time_freq;
 
@@ -332,8 +326,8 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	/* Stop active adjtime() */
 	time_adjust		= 0;
 	ntpdata->time_status	|= STA_UNSYNC;
-	time_maxerror		= NTP_PHASE_LIMIT;
-	time_esterror		= NTP_PHASE_LIMIT;
+	ntpdata->time_maxerror	= NTP_PHASE_LIMIT;
+	ntpdata->time_esterror	= NTP_PHASE_LIMIT;
 
 	ntp_update_frequency(ntpdata);
 
@@ -442,9 +436,9 @@ int second_overflow(time64_t secs)
 	}
 
 	/* Bump the maxerror field */
-	time_maxerror += MAXFREQ / NSEC_PER_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
-		time_maxerror = NTP_PHASE_LIMIT;
+	ntpdata->time_maxerror += MAXFREQ / NSEC_PER_USEC;
+	if (ntpdata->time_maxerror > NTP_PHASE_LIMIT) {
+		ntpdata->time_maxerror = NTP_PHASE_LIMIT;
 		ntpdata->time_status |= STA_UNSYNC;
 	}
 
@@ -722,10 +716,10 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
 		ntpdata->time_constant = clamp(txc->constant, 0, MAXTC);
@@ -798,8 +792,8 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->maxerror	   = time_maxerror;
-	txc->esterror	   = time_esterror;
+	txc->maxerror	   = ntpdata->time_maxerror;
+	txc->esterror	   = ntpdata->time_esterror;
 	txc->status	   = ntpdata->time_status;
 	txc->constant	   = ntpdata->time_constant;
 	txc->precision	   = 1;

-- 
2.39.2


