Return-Path: <netdev+bounces-127359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4504975369
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B661C22164
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BA1922E9;
	Wed, 11 Sep 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0WPTC45";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bD0e7tc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8661865EB;
	Wed, 11 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060680; cv=none; b=FBUDyqQA5NWH6tT+tXVtBoGOMp1kMYnB9r37F/sszpx85aImdYKTcakEqG8h7wT3FYOzxl9muHV13ZpRDjLBftvV35qDlOHFMjrKIez2+7ys1ZBueTnfwTHELIBuZVg5MAEHIbXOmnpzXtuuIg8v8I8Hb/cVfQMzrRxga1ellZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060680; c=relaxed/simple;
	bh=Wf9b5D6j4GtT8RassJRaMpL+mQLmkJWXlGbrXD+YtCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYroOAb9i9VjSbBiF1BmIKHnBmYTYzAb9TYSZsIF7xP1tr5lSrJ/glRB/OVAnD8Mt2YP7ROi+KDHOcPUCRIsgeHt1LP93lr0Z+pmg5C/igKYHgGBEICFTK1emQ366LicnpuprCcSIwGbllEynUHGo2JJqWOntprmc7Q39GqcnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0WPTC45; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bD0e7tc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjMH1BugHsm7FWKzyGipxzR/HsoVCdW/cbwZAnSod9k=;
	b=g0WPTC45M7csLuOht7OIIzcJwhlcn8PVQ/n1bMvOsSR17zDlg6PTtZZX/vYGR3/58ZGDPB
	+lOj0o1m1EAEzN0ksVpHTXqnibYFyAvEl1dr4fpNn0Pdra8ho/ExG5+mJev3Znyhng8S41
	maejdIxqpVI62HWczUdUntpHeCVrdTHFFVYsYzON2PPUW3DLz2t6jZ0+SSl3/PEI7+jUN8
	N+nRzLIZ1aLL5k/JQve41IUVaJEUN00xVISgIZf0a2SUPQY/EcEjDDq0zjzgxktQi8mGjF
	SsPlj0oTbib8i3NXUzhoHvrlE5ah4kfpV7VtPlHTpMXXQhm5qKzlY97ewUCVCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjMH1BugHsm7FWKzyGipxzR/HsoVCdW/cbwZAnSod9k=;
	b=8bD0e7tc6EKtti3u25E6UGo7j5czay2mDcDW/mNTjqwdB1KVvBeBJ8V1AtJSyidWKWg/Mf
	D4g8q2lPci02EnCg==
Date: Wed, 11 Sep 2024 15:17:37 +0200
Subject: [PATCH 01/21] ntp: Remove unused tick_nsec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
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

tick_nsec is only updated in the NTP core, but there are no users.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 arch/x86/include/asm/timer.h | 2 --
 include/linux/timex.h        | 1 -
 kernel/time/ntp.c            | 8 ++------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 7365dd4acffb..23baf8c9b34c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -6,8 +6,6 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 
-#define TICK_SIZE (tick_nsec / 1000)
-
 unsigned long long native_sched_clock(void);
 extern void recalibrate_cpu_khz(void);
 
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 3871b06bd302..7f7a12fd8200 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -145,7 +145,6 @@ unsigned long random_get_entropy_fallback(void);
  * estimated error = NTP dispersion.
  */
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
-extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
 
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8d2dd214ec68..0dba1179d81d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -33,9 +33,6 @@
 /* USER_HZ period (usecs): */
 unsigned long			tick_usec = USER_TICK_USEC;
 
-/* SHIFTED_HZ period (nsecs): */
-unsigned long			tick_nsec;
-
 static u64			tick_length;
 static u64			tick_length_base;
 
@@ -253,8 +250,8 @@ static inline int ntp_synced(void)
  */
 
 /*
- * Update (tick_length, tick_length_base, tick_nsec), based
- * on (tick_usec, ntp_tick_adj, time_freq):
+ * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
+ * time_freq:
  */
 static void ntp_update_frequency(void)
 {
@@ -267,7 +264,6 @@ static void ntp_update_frequency(void)
 	second_length		+= ntp_tick_adj;
 	second_length		+= time_freq;
 
-	tick_nsec		 = div_u64(second_length, HZ) >> NTP_SCALE_SHIFT;
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
 	/*

-- 
2.39.2


