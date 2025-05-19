Return-Path: <netdev+bounces-191429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91AAABB783
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DFC3B8C8B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE74275852;
	Mon, 19 May 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKY/FgFR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwNnkRGT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0452750E5;
	Mon, 19 May 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643625; cv=none; b=aT1Vaa11t+OH9XQ/lgVemnUe4V/7E/jBdhsUP1lsAObrHDGY18ixiFscyW2LBstWOanXOw+XInbQPDm8zVvXpmblI5O7DFpcsv7Qi5wR94JNojj9lJT1IDUbbaOADyQZQqkJPxMI8pUhSY5ILQxeUd2qInYKtiHW/aulq9jrIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643625; c=relaxed/simple;
	bh=dAeTY3KMBv2SQl7QumOQiobaigHO/XaHRHIJXipOfJ0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FUv/zEg2XL8cN4iCTCox2b4mtY+5rAMMdz8DMsxap/2EBwXt7UGHXA4s+BcDrNv7EHsleZEh/CbDgY41YZOHqFmuf8+4dTD+lAMQFB/Ugp5EHb/x73NPcuQDwu9b/yMrVlpfAOqph7Nmyz/jUITsDg3M5yOCmkZvp2UNtGcKEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKY/FgFR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwNnkRGT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.962968376@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LE5oO6Rh+o+d8C1+DdeABbq86jkYnys4AQ+wx71IDAw=;
	b=WKY/FgFR5XSUTloHAVba0AqaoJCUEx3a9YLyz8g/jNHfCTvu+cpT0Q2dpi6/qrtWUV0CXw
	f8xXOuVWgWyy/ISvElRkXOVMMTPDi4aMnv0wCEdFETV1nbkGonk4gJGC8hE6RuIAMMdZP+
	GBhzO+Epf0oeSmjG3GmBPPS8AHphxvGNPaKeR+MOdSTJ9BbKFDp0HYrVlAGqAgcyi0GDNJ
	ODT41DSNx3N6O1g1Sj62jVoku1G1tpzFKm9XamCpztZ2ikRJfDMqj7EuedV5uXxSIVrNpu
	QuhN7bYFwI1sln3oeiBWNmx0cd0BWE1MtBiOzvrggQW0s9nlRhvoNs8lM/odgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LE5oO6Rh+o+d8C1+DdeABbq86jkYnys4AQ+wx71IDAw=;
	b=VwNnkRGTUT9l3UlwEWRwaTQ6GpLrrASLDTCXlkuKaXdK5E7Vtt6xlwHTmi483/vjde7rJq
	gUCVXzP64ILK5qAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
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
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V2 22/26] timekeeping: Make do_adjtimex() reusable
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:41 +0200 (CEST)

Split out the actual functionality of adjtimex() and make do_adjtimex() a
wrapper which feeds the core timekeeper into it and handles the result
including audit at the call site.

This allows to reuse the actual functionality for auxiliary clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |  110 +++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 50 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2580,17 +2580,18 @@ unsigned long random_get_entropy_fallbac
 }
 EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
-/**
- * do_adjtimex() - Accessor function to NTP __do_adjtimex function
- * @txc:	Pointer to kernel_timex structure containing NTP parameters
- */
-int do_adjtimex(struct __kernel_timex *txc)
+struct adjtimex_result {
+	struct audit_ntp_data	ad;
+	struct timespec64	delta;
+	bool			clock_set;
+};
+
+static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
+			 struct adjtimex_result *result)
 {
-	struct tk_data *tkd = &tk_core;
-	struct timespec64 delta, ts;
-	struct audit_ntp_data ad;
-	bool offset_set = false;
-	bool clock_set = false;
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
+	struct timespec64 ts;
+	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2599,56 +2600,65 @@ int do_adjtimex(struct __kernel_timex *t
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	audit_ntp_init(&ad);
-
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	scoped_guard (raw_spinlock_irqsave, &tkd->lock) {
-		struct timekeeper *tks = &tkd->shadow_timekeeper;
-		s32 orig_tai, tai;
-
-		if (!tks->clock_valid)
-			return -ENODEV;
-
-		if (txc->modes & ADJ_SETOFFSET) {
-			delta.tv_sec  = txc->time.tv_sec;
-			delta.tv_nsec = txc->time.tv_usec;
-			if (!(txc->modes & ADJ_NANO))
-				delta.tv_nsec *= 1000;
-			ret = __timekeeping_inject_offset(tkd, &delta);
-			if (ret)
-				return ret;
-
-			offset_set = delta.tv_sec != 0;
-			clock_set = true;
-		}
-
-		orig_tai = tai = tks->tai_offset;
-		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
-
-		if (tai != orig_tai) {
-			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
-			clock_set = true;
-		} else {
-			tk_update_leap_state_all(&tk_core);
-		}
-
-		/* Update the multiplier immediately if frequency was set directly */
-		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+	guard(raw_spinlock_irqsave)(&tkd->lock);
+
+	if (!tks->clock_valid)
+		return -ENODEV;
+
+	if (txc->modes & ADJ_SETOFFSET) {
+		result->delta.tv_sec  = txc->time.tv_sec;
+		result->delta.tv_nsec = txc->time.tv_usec;
+		if (!(txc->modes & ADJ_NANO))
+			result->delta.tv_nsec *= 1000;
+		ret = __timekeeping_inject_offset(tkd, &result->delta);
+		if (ret)
+			return ret;
+		result->clock_set = true;
+	}
+
+	orig_tai = tai = tks->tai_offset;
+	ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &result->ad);
+
+	if (tai != orig_tai) {
+		__timekeeping_set_tai_offset(tks, tai);
+		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
+		result->clock_set = true;
+	} else {
+		tk_update_leap_state_all(&tk_core);
 	}
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		result->clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+
+	return ret;
+}
+
+/**
+ * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
+ */
+int do_adjtimex(struct __kernel_timex *txc)
+{
+	struct adjtimex_result result = { };
+	int ret;
+
+	ret = __do_adjtimex(&tk_core, txc, &result);
+	if (ret < 0)
+		return ret;
+
 	if (txc->modes & ADJ_SETOFFSET)
-		audit_tk_injoffset(delta);
+		audit_tk_injoffset(result.delta);
 
-	audit_ntp_log(&ad);
+	audit_ntp_log(&result.ad);
 
-	if (clock_set)
+	if (result.clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer(offset_set);
+	ntp_notify_cmos_timer(result.delta.tv_sec != 0);
 
 	return ret;
 }


