Return-Path: <netdev+bounces-190207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91DAB5860
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6103E1B61009
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270B2C2FCD;
	Tue, 13 May 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iinsoVwS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weCmPHnU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600B2C2FB9;
	Tue, 13 May 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149221; cv=none; b=LiqbL2Bs1JPsRqXp/OoNWA0GVSej937aJ2j73lPGapQjE5sulqQmm2auFMIXKXN+pqTxZCLAGaphlcE2IiIq7N7m3LxpXNyWGFBDgRhBIP2fWgtR6zP4SXVEFCRJqVP+hLCe5doIqQn9EJqfO96hBYFKLbfB2Jx6uMZeodprIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149221; c=relaxed/simple;
	bh=iJJ9ph2Xb8jo5inYrka+dOkNKYSGMVeqGO5dfJupNQc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sdgeN+LnHNgIvIhIQx3phPj++1c5uekKsUtSAiqsxnPTiKHb8kDzS1eEATsmWgO3kfw4SuR7uXmnSjBRHrxp8Neh6rDbzINxI/tYb4L4JJBWJBYZX4alhtgCPdyLftEaBa9QLAj/G95bR/SMnRu52dUW2opBGAVBU+zkvZAP7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iinsoVwS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weCmPHnU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145138.036707094@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sshZ83NzzE8YwIcZ21KwrOb8k7lJw16Y76dziNXGJq4=;
	b=iinsoVwSSQ4rno6wgH/7CG/WCmCFxpqZZmIKf1CPSZOJgHPIPU59l7aK19zeTxRXQdTBDW
	Hp+JEG8zFoLX2Q7ty9lx5hjSRvQjr7pc0MH21OdBVHeDa1v/c588FtuEfY0Mt5Hbqv0hzY
	UXKRDluebUe4ojqFLUe5ZwBtPedG9tRVcH6lSQaKbrmyFAOVQ2DTBJE4tvKN+8GcHxa5lg
	5A5eAH99OmjY0fGGGFfHei2Ff7VW+wWHBA9vX3/DocRLkx+1iHK3Yp97Q+uB+gLBZlJ1v2
	okQBZo6o3DoCet1APS5tgew2p+9kiEXCCAyVuOFE3emPOK4MK98I77QGTXjnhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sshZ83NzzE8YwIcZ21KwrOb8k7lJw16Y76dziNXGJq4=;
	b=weCmPHnU4cCjXT4IfsvBFa8s1G9nBz9jDWQZJePA3J01e4Y7JWwktrD+G91tgGoXWJ/eEq
	30GlzevJ35SOOxBw==
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
Subject: [patch 23/26] timekeeping: Prepare do_adtimex() for PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:37 +0200 (CEST)

Exclude ADJ_TAI, leap seconds and PPS functionality and provide a time
stamp based on the actual clock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -58,6 +58,17 @@ static struct tk_data timekeeper_data[TI
 /* The core timekeeper */
 #define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
 
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+static inline bool tk_get_ptp_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return ktime_get_ptp_ts64(CLOCK_PTP + tkid - TIMEKEEPER_PTP, ts);
+}
+#else
+static inline bool tk_get_ptp_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return false;
+}
+#endif
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -2503,7 +2514,7 @@ ktime_t ktime_get_update_offsets_now(uns
 /*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(const struct __kernel_timex *txc)
+static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool ptp_clock)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
@@ -2562,6 +2573,21 @@ static int timekeeping_validate_timex(co
 			return -EINVAL;
 	}
 
+	if (!ptp_clock)
+		return 0;
+
+	/* PTP clocks are TAI based and do not have leap seconds */
+	if (txc->status & (STA_INS | STA_DEL))
+		return -EINVAL;
+
+	/* No TAI offset setting */
+	if (txc->modes & ADJ_TAI)
+		return -EINVAL;
+
+	/* No PPS support either */
+	if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2592,15 +2618,22 @@ static int __do_adjtimex(struct tk_data
 	struct timekeeper *tks = &tkd->shadow_timekeeper;
 	struct timespec64 ts;
 	s32 orig_tai, tai;
+	bool ptp_clock;
 	int ret;
 
+	ptp_clock = IS_ENABLED(CONFIG_POSIX_PTP_CLOCKS) && tkd->timekeeper.id != TIMEKEEPER_CORE;
+
 	/* Validate the data before disabling interrupts */
-	ret = timekeeping_validate_timex(txc);
+	ret = timekeeping_validate_timex(txc, ptp_clock);
 	if (ret)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	ktime_get_real_ts64(&ts);
+	if (!ptp_clock)
+		ktime_get_real_ts64(&ts);
+	else
+		tk_get_ptp_ts64(tkd->timekeeper.id, &ts);
+
 	add_device_randomness(&ts, sizeof(ts));
 
 	guard(raw_spinlock_irqsave)(&tkd->lock);


