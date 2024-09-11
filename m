Return-Path: <netdev+bounces-127398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E466B975411
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969BD1F23B38
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F321AD3E3;
	Wed, 11 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="epnJ3ol6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyrFDUBw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355981AB6DE;
	Wed, 11 Sep 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061412; cv=none; b=uE+asqOHpF9MsGQyhc7GCQ/ODAGbKt+ypLgejJeqJMvcFAbb9o+dnZBGQUrxQxyKADhT+QVk3Nq3QxpCa0i73qxEXAYFKXa9PVRaAgqQPtWGnd9SCjexeLTjz/Qgtsse1ad1p8SbaqakjUHWuqwXh5eSvNAUlJzxVmvJWdis1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061412; c=relaxed/simple;
	bh=ox0s9PJXWFpTCrPvfAeVPOVh8wK4ESKTGk2UMgK6/to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsKjPQlNGfL7Fw8+J+AGVHKG6F/2OPNza4zStVX6DmEvwEkJHjMQJRgoEvefTJ2FfnlprjISZAa1vHZD0CBq5S4MgFxIrR27nLD/NYc9UIqn2iW+61ol0sOKtvTIojnt4f2HtKauVMY2jeYWqRn0hk1vwyN5f55As6abPK/Sc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=epnJ3ol6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyrFDUBw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66toSkU2qPO2OJQytBwFOIzsoNiVM6CXHSHR4Cf98KQ=;
	b=epnJ3ol6a8ShnmCJPZbtvdoL+6frs3Xlewbi9i8ccYJ0LGRldmcBrq9MxEvWd7c0GYPogv
	LfrRKDLFV19EUGb/mS0F1y4UPpi6nvPftZ/jqJpAVyeCBQbahKGJZfCjxIknVzPKCXG/TP
	1ZiHCyDWFwi/kdN9oQ+h4VOv1rKWyaw0s3rVbk50w0VyTz5uoAaIUYy+571ZhhHw/yMqCe
	F6Yu3ybYxlMzaUcrv204PQrnNC/rgV8vbCngeLg3VS3+Tlf8XkHTjXCodaUEGcHe9R4TDY
	S6BDII/oz4Q9seNVOk08DTz07Tk/h2ea8ZVHcSHk5vI0A1bgPPRjKOa1OVCxCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66toSkU2qPO2OJQytBwFOIzsoNiVM6CXHSHR4Cf98KQ=;
	b=AyrFDUBwsrGpMfboCXqoPMXzAgEXfrYYmzJQOm1fj2utrMy1uzgagiAB/mSDLkVbatdy4L
	QP9Yt9psxtMBxZDA==
Date: Wed, 11 Sep 2024 15:30:00 +0200
Subject: [PATCH 16/24] timekeeping: Rework timekeeping_inject_offset() to
 use shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-16-f7cae09e25d6@linutronix.de>
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

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert timekeeping_inject_offset() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index efcfb0da351e..8b8d77463f3e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1519,40 +1519,31 @@ EXPORT_SYMBOL(do_settimeofday64);
  */
 static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64 tmp;
-	int ret = 0;
-
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tk), *ts);
-	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		ret = -EINVAL;
-		goto error;
-	}
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
+		struct timespec64 tmp;
 
-	tk_xtime_add(tk, ts);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_forward_now(tk);
 
-error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tk), *ts);
+		if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_xtime_add(tk, ts);
+		tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
-
-	return ret;
+	return 0;
 }
 
 /*

-- 
2.39.2


