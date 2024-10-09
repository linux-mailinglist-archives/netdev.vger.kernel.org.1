Return-Path: <netdev+bounces-133527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A419962C1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D092817C9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE1190482;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2IZTJVh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaqATKZP"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5718E779;
	Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462564; cv=none; b=JbTOR80bENSgw3lp5WSnd33vv3sbEA0qGSJBNxTcyYFjqlXZBIuq/AVBpVmF2+0cst9iVcNpxquea2qfcwFDVGTu65Dz9CVqsrZwgissxUpFxT3OluXYwT79yAmIoLKS/VDvWNbWQ4fTCMSth1hI/yfjA/4yit63EvPGTTDnyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462564; c=relaxed/simple;
	bh=2b3V099iyYcM42QJJZx9RFoxOEkUlAcOJ9jaApElm5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7JV1snv1ai26easA6Qt/mGI1oWMLF8B68/uBIrt9/wQljs8mz3pL9eOwUFT6NrCIuJW6HP2lcT2PUBOIWMHgFbjVT1Kes8QsPK0mBNLh1yVkTBb7jsxX7l27bpAJ/B4EsnR9IKlzMJJDGctSqSCvp0JxJ6GAAT393ec5BEzXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2IZTJVh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AaqATKZP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWVP22ee0N3hgHNE8ntTO7usiiv5V20D1YtJX5nx4VY=;
	b=S2IZTJVhScM9Fgm0PTu+PI9ANaNuZG4BGdeuwTpN4sWhd0IgZWLTUHW4X1JvNgoTK4nEwm
	KNKOqOSwIS7ylLVOLrCv6pTvNk33M+kZW0IBIrG4wKmI8J2+QcuQWbRrw6OBpKl3i0cUrR
	VHmhXVm2miIfaMyn2UyIrM6wzm72UiD5xM7nl4In4tGl0BJIC+5cYWsHXRD6kr+c/tWzXe
	VNZtmSsWnGop5taboVpP17rV2x6GaCK5s1KGJ+dNwFyofkXQ7/54x1TdDRZgM8qGrhLovF
	LwwwlulqzOQI9w0oGh4/bNYR1LqwY9SBSolbybMXOQArxgByP58hBb0sRM1Dtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWVP22ee0N3hgHNE8ntTO7usiiv5V20D1YtJX5nx4VY=;
	b=AaqATKZPnYtnZd5BwO0ZDj3RjxUgoOt0x2i8T9sCwocCOLHEBHMNBvjL/jgm5aN+d2whl7
	MXySXMfV5eatESBA==
Date: Wed, 09 Oct 2024 10:29:09 +0200
Subject: [PATCH v2 16/25] timekeeping: Rework do_settimeofday64() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert do_settimeofday64() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 41d88f645868..cc01ad53d96d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1479,45 +1479,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
  */
 int do_settimeofday64(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 ts_delta, xt;
-	unsigned long flags;
-	int ret = 0;
 
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	xt = tk_xtime(tk);
-	ts_delta = timespec64_sub(*ts, xt);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
-	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
-		ret = -EINVAL;
-		goto out;
-	}
+		timekeeping_forward_now(tk);
 
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		xt = tk_xtime(tk);
+		ts_delta = timespec64_sub(*ts, xt);
 
-	tk_set_xtime(tk, ts);
-out:
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		tk_set_xtime(tk, ts);
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
 
-	if (!ret) {
-		audit_tk_injoffset(ts_delta);
-		add_device_randomness(ts, sizeof(*ts));
-	}
-
-	return ret;
+	audit_tk_injoffset(ts_delta);
+	add_device_randomness(ts, sizeof(*ts));
+	return 0;
 }
 EXPORT_SYMBOL(do_settimeofday64);
 

-- 
2.39.5


