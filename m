Return-Path: <netdev+bounces-127387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86079753FB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443C81F25BF5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB91A4F1F;
	Wed, 11 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnLpyDAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/9pxoruL"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E641A302A;
	Wed, 11 Sep 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061408; cv=none; b=jVYJEovc/cnXvuwT7MaxyXM8AJXvgogPyOoD0MOqKbSGBrWV1qCcUMYi70yOT058gU5KmKhVDwHGQYfadMNdIm1i3xUV2y7v0vJu5HKE/cLTQ3oG4fghkXnkfCTnsinDN0cxttq69TihN7xVg5ncDpDgFCIAdNDy6i4QlW2SxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061408; c=relaxed/simple;
	bh=h059DRDIOUm5DG+YjLjsJhhFglZkS1x9w23A7wdranc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4A/LuaY1I6UB259ygi5licMmt8JPMTNF+s2osOj2y7ULwkjOiiZDJ+QDUF5jZjpq+0hFNiEGLUWn6sJKF41Hx1ZlxVZuIra2/O42RPWOS5HelCeeV0nmtULyx5FYWB0B+NJAWAzPSYJX6otHoUUIhogzanRnuW8ZuU+AnOIVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnLpyDAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/9pxoruL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA8zYGtXLl150Y6W6sqapaYVnfPkW2AtTY25TXW2wTM=;
	b=UnLpyDAAqNF2Cn3v8pv985iAs4L5Hd+QWMe7CZf66R+9H7a77XiOlsGojHO43f7kq483u5
	G0ccJKiY/Jdx7amNrRqrLbfO7T5XL9CasYQ/xdpVuvJ0CSz7xW67RFgLGmTDGO/y0EDk++
	XWNYQ29kDSF5rPq4051EOSAVHDijz++xnSVSJ4pAP3BXyutIKzSopgAo/8E6jKfT2FMFzi
	AwQYSZwzIAyyQVE+S5J0UICm19FzQgSM0Ymfh/JrzXvUTSP47GBQkBK52uriSBJ71ZAT4Z
	JnR0IkoCqd6Zilw6agxV0qdJ2RG0XcVEfhAhxMQ52Y8ViD9+3IACl0opg4OfcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA8zYGtXLl150Y6W6sqapaYVnfPkW2AtTY25TXW2wTM=;
	b=/9pxoruLxlvl732jAFd4XHnrophok9RniD7Q//5YHBf48sYL38PU6hMMozt1KVooYc4wC+
	V2QRM+rmz9ruAIAw==
Date: Wed, 11 Sep 2024 15:29:50 +0200
Subject: [PATCH 06/24] timekeeping: Reorder struct timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-6-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

struct timekeeper is ordered suboptimal vs. cachelines. The layout,
including the preceding seqcount (see struct tk_core in timekeeper.c) is:

 cacheline 0:   seqcount, tkr_mono
 cacheline 1:   tkr_raw, xtime_sec
 cacheline 2:   ktime_sec ... tai_offset, internal variables
 cacheline 3:	next_leap_ktime, raw_sec, internal variables
 cacheline 4:	internal variables

So any access to via ktime_get*() except for access to CLOCK_MONOTONIC_RAW
will use either cachelines 0 + 1 or cachelines 0 + 2. Access to
CLOCK_MONOTONIC_RAW uses cachelines 0 + 1 + 3.

Reorder the members so that the result is more efficient:

 cacheline 0:   seqcount, tkr_mono
 cacheline 1:   xtime_sec, ktime_sec ... tai_offset
 cacheline 2:	tkr_raw, raw_sec
 cacheline 3:	internal variables
 cacheline 4:	internal variables

That means ktime_get*() will access cacheline 0 + 1 and CLOCK_MONOTONIC_RAW
access will use cachelines 0 + 2.

Update kernel-doc and fix formatting issues while at it. Also fix a typo
in struct tk_read_base kernel-doc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/timekeeper_internal.h | 102 +++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 41 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff2844df2a..5805c5f61df4 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -26,7 +26,7 @@
  * occupies a single 64byte cache line.
  *
  * The struct is separate from struct timekeeper as it is also used
- * for a fast NMI safe accessors.
+ * for the fast NMI safe accessors.
  *
  * @base_real is for the fast NMI safe accessor to allow reading clock
  * realtime from any context.
@@ -44,33 +44,41 @@ struct tk_read_base {
 
 /**
  * struct timekeeper - Structure holding internal timekeeping values.
- * @tkr_mono:		The readout base structure for CLOCK_MONOTONIC
- * @tkr_raw:		The readout base structure for CLOCK_MONOTONIC_RAW
- * @xtime_sec:		Current CLOCK_REALTIME time in seconds
- * @ktime_sec:		Current CLOCK_MONOTONIC time in seconds
- * @wall_to_monotonic:	CLOCK_REALTIME to CLOCK_MONOTONIC offset
- * @offs_real:		Offset clock monotonic -> clock realtime
- * @offs_boot:		Offset clock monotonic -> clock boottime
- * @offs_tai:		Offset clock monotonic -> clock tai
- * @tai_offset:		The current UTC to TAI offset in seconds
- * @clock_was_set_seq:	The sequence number of clock was set events
- * @cs_was_changed_seq:	The sequence number of clocksource change events
- * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
- * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
- * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
- * @cycle_interval:	Number of clock cycles in one NTP interval
- * @xtime_interval:	Number of clock shifted nano seconds in one NTP
- *			interval.
- * @xtime_remainder:	Shifted nano seconds left over when rounding
- *			@cycle_interval
- * @raw_interval:	Shifted raw nano seconds accumulated per NTP interval.
- * @ntp_error:		Difference between accumulated time and NTP time in ntp
- *			shifted nano seconds.
- * @ntp_error_shift:	Shift conversion between clock shifted nano seconds and
- *			ntp shifted nano seconds.
- * @last_warning:	Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:	Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
+ * @tkr_mono:			The readout base structure for CLOCK_MONOTONIC
+ * @xtime_sec:			Current CLOCK_REALTIME time in seconds
+ * @ktime_sec:			Current CLOCK_MONOTONIC time in seconds
+ * @wall_to_monotonic:		CLOCK_REALTIME to CLOCK_MONOTONIC offset
+ * @offs_real:			Offset clock monotonic -> clock realtime
+ * @offs_boot:			Offset clock monotonic -> clock boottime
+ * @offs_tai:			Offset clock monotonic -> clock tai
+ * @tai_offset:			The current UTC to TAI offset in seconds
+ * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
+ * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
+ * @clock_was_set_seq:		The sequence number of clock was set events
+ * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
+ * @cycle_interval:		Number of clock cycles in one NTP interval
+ * @xtime_interval:		Number of clock shifted nano seconds in one NTP
+ *				interval.
+ * @xtime_remainder:		Shifted nano seconds left over when rounding
+ *				@cycle_interval
+ * @raw_interval:		Shifted raw nano seconds accumulated per NTP interval.
+ * @next_leap_ktime:		CLOCK_MONOTONIC time value of a pending leap-second
+ * @ntp_tick:			The ntp_tick_length() value currently being
+ *				used. This cached copy ensures we consistently
+ *				apply the tick length for an entire tick, as
+ *				ntp_tick_length may change mid-tick, and we don't
+ *				want to apply that new value to the tick in
+ *				progress.
+ * @ntp_error:			Difference between accumulated time and NTP time in ntp
+ *				shifted nano seconds.
+ * @ntp_error_shift:		Shift conversion between clock shifted nano seconds and
+ *				ntp shifted nano seconds.
+ * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @last_warning:		Warning ratelimiter (DEBUG_TIMEKEEPING)
+ * @underflow_seen:		Underflow warning flag (DEBUG_TIMEKEEPING)
+ * @overflow_seen:		Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffie times)
@@ -88,10 +96,25 @@ struct tk_read_base {
  *
  * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
  * accelerate the VDSO update for CLOCK_BOOTTIME.
+ *
+ * The cacheline ordering of the structure is optimized for in kernel usage
+ * of the ktime_get() and ktime_get_ts64() family of time accessors. Struct
+ * timekeeper is prepended in the core timekeeeping code with a sequence
+ * count, which results in the following cacheline layout:
+ *
+ * 0:	seqcount, tkr_mono
+ * 1:	xtime_sec ... tai_offset
+ * 2:	tkr_raw, raw_sec
+ * 3,4: Internal variables
+ *
+ * Cacheline 0,1 contain the data which is used for accessing
+ * CLOCK_MONOTONIC/REALTIME/BOOTTIME/TAI, while cacheline 2 contains the
+ * data for accessing CLOCK_MONOTONIC_RAW.  Cacheline 3,4 are internal
+ * variables which are only accessed during timekeeper updates once per
+ * tick.
  */
 struct timekeeper {
 	struct tk_read_base	tkr_mono;
-	struct tk_read_base	tkr_raw;
 	u64			xtime_sec;
 	unsigned long		ktime_sec;
 	struct timespec64	wall_to_monotonic;
@@ -99,31 +122,28 @@ struct timekeeper {
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
 	s32			tai_offset;
+
+	struct tk_read_base	tkr_raw;
+	u64			raw_sec;
+
+	/* The following members are for timekeeping internal use */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
-	ktime_t			next_leap_ktime;
-	u64			raw_sec;
+
 	struct timespec64	monotonic_to_boot;
 
-	/* The following members are for timekeeping internal use */
 	u64			cycle_interval;
 	u64			xtime_interval;
 	s64			xtime_remainder;
 	u64			raw_interval;
-	/* The ntp_tick_length() value currently being used.
-	 * This cached copy ensures we consistently apply the tick
-	 * length for an entire tick, as ntp_tick_length may change
-	 * mid-tick, and we don't want to apply that new value to
-	 * the tick in progress.
-	 */
+
+	ktime_t			next_leap_ktime;
 	u64			ntp_tick;
-	/* Difference between accumulated time and NTP time in ntp
-	 * shifted nano seconds. */
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
-	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
+
 #ifdef CONFIG_DEBUG_TIMEKEEPING
 	long			last_warning;
 	/*

-- 
2.39.2


