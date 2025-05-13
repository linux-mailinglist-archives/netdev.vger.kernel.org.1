Return-Path: <netdev+bounces-190195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A6AB5840
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54471B470B2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446D2BFC9F;
	Tue, 13 May 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0FKeFN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3g9MHmSq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C12BFC7E;
	Tue, 13 May 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149200; cv=none; b=bO0i+LcHmMubzih78rstwJk77K21YOHs39UFOEpo1m6BAHm4D8xCZBkl083gekMiv7ZHSJkjh/i++I+MR56pKgRjUSsnPTsWfam3+wQNx804DDUR7jFEDGKmgj9IW0YKf7mxvLhnFUSBiSqWL0E4rL2tSTdbwyC7Z+PPSmJvQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149200; c=relaxed/simple;
	bh=34XXiqAznQ3sVTAch8u/pFh87au6vUpyvR/l//LqkL8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MXzRqBt4PC6rLva1vCIlcDajlhS/b/Q2mT/z94ACfdxNzeWaDiORsGNLmpnjGNYJUbK5P6+J6Y+kdd+FyM2Ej1J2ewh8Mbdr7Shh4wW/Je1ur4zzghBuzCl5dJX8/AWww0fMVJ/WuCVeqxPSVvyx/p8RMA4Zt8bqDeltze6OwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0FKeFN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3g9MHmSq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.387931544@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tej1oBVu7uusO7XAHaHs2P/TIn7104f6OCHwxQdNvvU=;
	b=e0FKeFN1OMutE5OxmiLzIlUqhIh09qa7uJmBBOY/NBGCxbs2G+aTcGuwuBtt0tOeDwYA9W
	tI7UAHltpnduDpdRYUxmy+2TwSnVHVj/xWIL7FFOrEomnuxduZRiZ0F360Ir/eZjnXEV8P
	22E25B3VOmvweYU/8Yy7q5rBO+cw0DlGLpk5svAh3IOg5wUWdhDaahPsvTjDrIdbm0JHvZ
	0jzIKn6IupuE9tkfJy+/sTrAe2Qw1xlL7p8g5MgCr+BZBN//brj6R05Gg3SAU0/5fO2DPn
	j06+ft1nlSMRXeAb3oBr+m9TZgOBRmtKVKkS47f52AMZrsfoIWEOHzSOw9W1nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tej1oBVu7uusO7XAHaHs2P/TIn7104f6OCHwxQdNvvU=;
	b=3g9MHmSqbYwjPQYDmLN0DwrTFqdY78v1iUMiZR+Ru+A4Autr3ZLst6JiRJCNBpeZrx+LF1
	J8W/NQF84YWBDXCA==
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
Subject: [patch 12/26] timekeeping: Introduce PTP time keepers
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:17 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Provide time keepers for independent PTP clocks and initialize them during
boot.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -53,7 +53,11 @@ struct tk_data {
 	raw_spinlock_t		lock;
 } ____cacheline_aligned;
 
-static struct tk_data tk_core;
+static struct tk_data timekeeper_data[TIMEKEEPERS_MAX];
+
+/* The core timekeeper */
+#define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
+
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -113,6 +117,12 @@ static struct tk_fast tk_fast_raw  ____c
 	.base[1] = FAST_TK_INIT,
 };
 
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+static __init void tk_ptp_setup(void);
+#else
+static inline void tk_ptp_setup(void) { }
+#endif
+
 unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
@@ -1584,7 +1594,6 @@ void ktime_get_raw_ts64(struct timespec6
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
-
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
  */
@@ -1696,6 +1705,7 @@ void __init timekeeping_init(void)
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
+	tk_ptp_setup();
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -2625,3 +2635,11 @@ void hardpps(const struct timespec64 *ph
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+static __init void tk_ptp_setup(void)
+{
+	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)
+		tkd_basic_setup(&timekeeper_data[i], i, false);
+}
+#endif /* CONFIG_POSIX_PTP_CLOCKS */


