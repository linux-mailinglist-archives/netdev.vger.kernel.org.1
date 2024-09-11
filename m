Return-Path: <netdev+bounces-127370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4E97537D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E601F21880
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F01A3059;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsmu3AIr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CekEdgG"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4619F129;
	Wed, 11 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060684; cv=none; b=Dngr5MUlShnhnobwEuwFROmf9a9Y/tRPyee4UWhQBC56pD1Mp+vj0mdwksPpKoI0J/REYY3yQGe2pxgiqponHcLXoW5dT/CHJIEyXPskTGzOPhPIUSs8XYyVVh99/75zUH1IpyrQnRpV/uqzLjbfBwoZ7N+bctOzzbPYN5OVPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060684; c=relaxed/simple;
	bh=jsqZHMaVbEUBlf/RHWWugEVvet0Uz87Fq3mIOLizCU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKkvT/1COwv7N3lnk+52Q8pWt7y+0nKB0LtDRv5pml52M/M+bKrn1bjUaEJx08CeSxbjBgCNh6naXnKhAjjDMBWGX3i4EcR9XEKATgOFdtZ1Ogidon6m2uwR4wTzp0aQGWOZyOnDul9ZnocU13R0pyZVc54sjq8ngLaYIYurBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsmu3AIr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3CekEdgG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESDq10j/CueXRLwup3LiuwuvM4fTxM0INR84EcUb0g=;
	b=lsmu3AIrnf4Htb+DkwSXu1tWpalAoy1gO+im6Xyp4pQ4coqiVMSVC5e4PFZvlvE5kIvHv4
	IRLtj2gmCZ/BYb6lbV70/a9mdsQ9PbQZTZyXmVkyRNN/njd7/QwPbzohu8RxpEc5T2C2ap
	JNZAWZh3rpJXvzm1M93cvuEW7t2O3b4Yb5Cem3r7oIUw46sCcy0XLVXciB93xLBgUPiLh7
	y5CBc+rApmYAp74Hh2+0Af8E4iGO9jTvNZ3yPkviGBPr/LgByBRniWcFosz+n1vMUkLF4P
	zSTPtDgdjH8/zge9C3S/ahokj090t9PpouhN+jYJZWzz8EEN4whKa/4kqC5XBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESDq10j/CueXRLwup3LiuwuvM4fTxM0INR84EcUb0g=;
	b=3CekEdgGcG2y2IC/wtrUsYo6sYVt9qwDf/t5ayct+YjYADewNQoVWhIYBiPDWR+fRGEYfw
	RxAza4UDC7V/8oBA==
Date: Wed, 11 Sep 2024 15:17:49 +0200
Subject: [PATCH 13/21] ntp: Move time_adj/ntp_tick_adj into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 47c4f3e3562c..3897f1e79d8d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -36,6 +36,8 @@
  * @time_esterror:	Estimated error in microseconds holding NTP dispersion
  * @time_freq:		Frequency offset scaled nsecs/secs
  * @time_reftime:	Time at last adjustment in seconds
+ * @time_adjust:	Adjustment value
+ * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
  *
  * Protected by the timekeeping locks.
  */
@@ -51,6 +53,8 @@ struct ntp_data {
 	long			time_esterror;
 	s64			time_freq;
 	time64_t		time_reftime;
+	long			time_adjust;
+	s64			ntp_tick_adj;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -68,11 +72,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-static long			time_adjust;
-
-/* constant (boot-param configurable) NTP tick adjustment (upscaled)	*/
-static s64			ntp_tick_adj;
-
 /* second value of the next pending leapsecond, or TIME64_MAX if no leap */
 static time64_t			ntp_next_leap_sec = TIME64_MAX;
 
@@ -242,7 +241,7 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 
 	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
-	second_length		+= ntp_tick_adj;
+	second_length		+= ntpdata->ntp_tick_adj;
 	second_length		+= ntpdata->time_freq;
 
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
@@ -322,7 +321,7 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
-	time_adjust		= 0;
+	ntpdata->time_adjust	= 0;
 	ntpdata->time_status	|= STA_UNSYNC;
 	ntpdata->time_maxerror	= NTP_PHASE_LIMIT;
 	ntpdata->time_esterror	= NTP_PHASE_LIMIT;
@@ -450,24 +449,24 @@ int second_overflow(time64_t secs)
 	/* Check PPS signal */
 	pps_dec_valid(ntpdata);
 
-	if (!time_adjust)
+	if (!ntpdata->time_adjust)
 		goto out;
 
-	if (time_adjust > MAX_TICKADJ) {
-		time_adjust -= MAX_TICKADJ;
+	if (ntpdata->time_adjust > MAX_TICKADJ) {
+		ntpdata->time_adjust -= MAX_TICKADJ;
 		ntpdata->tick_length += MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	if (time_adjust < -MAX_TICKADJ) {
-		time_adjust += MAX_TICKADJ;
+	if (ntpdata->time_adjust < -MAX_TICKADJ) {
+		ntpdata->time_adjust += MAX_TICKADJ;
 		ntpdata->tick_length -= MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	ntpdata->tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
+	ntpdata->tick_length += (s64)(ntpdata->time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
 				<< NTP_SCALE_SHIFT;
-	time_adjust = 0;
+	ntpdata->time_adjust = 0;
 
 out:
 	return leap;
@@ -750,15 +749,15 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
-		long save_adjust = time_adjust;
+		long save_adjust = ntpdata->time_adjust;
 
 		if (!(txc->modes & ADJ_OFFSET_READONLY)) {
 			/* adjtime() is independent from ntp_adjtime() */
-			time_adjust = txc->offset;
+			ntpdata->time_adjust = txc->offset;
 			ntp_update_frequency(ntpdata);
 
 			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
-			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
+			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	ntpdata->time_adjust);
 		}
 		txc->offset = save_adjust;
 	} else {
@@ -995,7 +994,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
 					       NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
-		time_adjust = 0;
+		ntpdata->time_adjust = 0;
 	}
 	/* Update jitter */
 	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
@@ -1067,11 +1066,11 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtos64(str, 0, &ntp_tick_adj);
+	int rc = kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
 	if (rc)
 		return rc;
 
-	ntp_tick_adj <<= NTP_SCALE_SHIFT;
+	tk_ntp_data.ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
 

-- 
2.39.2


