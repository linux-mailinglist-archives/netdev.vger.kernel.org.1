Return-Path: <netdev+bounces-191425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D0AABB774
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D4179EF2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8E274674;
	Mon, 19 May 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzuyXGJH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScG57x8M"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABE2741D0;
	Mon, 19 May 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643621; cv=none; b=JvGwUK2X1xS77+L00IyPPnRWYfAkvf9ByRT/g0UsBFIQYhaS8h/in2bQWOHOKndmt0l4vl/A9BE4109Cf3g2SMoOaslcxsvI8TjEyqqN20njToksrwHMGaYxgKxeojzEy8MKenRgNVNwRcNhZtisxnccGrNoelrOTGRVcTdLILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643621; c=relaxed/simple;
	bh=wcet+KQ7mfGuaicX90+NDM/XbprRB5yDlwpHaOex4Es=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mNm4NW6mpBIex6682JBGtMsYroo5i9j+EZXQd3gam7GDZhVzU8HLBA73feqNwkN+rqi71plj8AYzMyAnI4TQkG8u1og4r7nDw/2wlL2Hrt+o96V7e9VlqbClMRLFcdwUwfaP5eLeigSHNPenuaaxK+j3ybNLkjweSsvdUHkKpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzuyXGJH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScG57x8M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.781170326@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oEIEdaPxk47WUwPdYP4TPLC5Q2UNTcvOI//fl8tbabw=;
	b=QzuyXGJHLdBJh0i2oIW+km+kTYnCMcJbHWQ0qcmREAHYpBKjgtxgYOxlpJy0GEV0nMGRzR
	2yZzEH/Gg7H8rm+NapIMEEMUYOQHtTKT48dmY4jERq+pL/3kvG0hCueLulmWeheKx3aXDn
	EP69OMIiedaz55Y7PJblUtlxZnf8k6yXum0DwPzPBAqJi+XZ4ehGYsLxwh/L46/9WWm603
	VbYVgLlgzSRqjA6265fJNTW5Hy8sFXOcx0Ev7SjxEQ0OuPE3Wtj3JSwluA8XE6Ye+Nq+fw
	lgGGkhIOBXfiKuvVX3XbChzHhCLVPnufYD4uuLvdzJFTC9v4D3e1Ab2dbiWzyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oEIEdaPxk47WUwPdYP4TPLC5Q2UNTcvOI//fl8tbabw=;
	b=ScG57x8Mw4ut+O8DN2G7623GJbptNOuYrYnZFTAZVjMzsctNBIY/vfcNGkftPw/EswiWOD
	MgAC2i4EzCNCWDDg==
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
Subject: [patch V2 19/26] timekeeping: Provide time setter for auxiliary
 clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:37 +0200 (CEST)

Add clock_settime(2) support for auxiliary clocks. The function affects the
AUX offset which is added to the "monotonic" clock readout of these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2757,9 +2757,48 @@ static int aux_get_timespec(clockid_t id
 	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
 }
 
+static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
+	struct timekeeper *tks;
+	ktime_t tnow, nsecs;
+
+	if (!timespec64_valid_settod(tnew))
+		return -EINVAL;
+	if (!tkd)
+		return -ENODEV;
+
+	tks = &tkd->shadow_timekeeper;
+
+	guard(raw_spinlock_irq)(&tkd->lock);
+	if (!tks->clock_valid)
+		return -ENODEV;
+
+	/* Forward the timekeeper base time */
+	timekeeping_forward_now(tks);
+	/*
+	 * Get the updated base time. tkr_mono.base has not been
+	 * updated yet, so do that first. That makes the update
+	 * in timekeeping_update_from_shadow() redundant, but
+	 * that's harmless. After that @tnow can be calculated
+	 * by using tkr_mono::cycle_last, which has been set
+	 * by timekeeping_forward_now().
+	 */
+	tk_update_ktime_data(tks);
+	nsecs = timekeeping_cycles_to_ns(&tks->tkr_mono, tks->tkr_mono.cycle_last);
+	tnow = ktime_add(tks->tkr_mono.base, nsecs);
+
+	/* Calculate the new AUX offset */
+	tks->offs_aux = ktime_sub(timespec64_to_ktime(*tnew), tnow);
+
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	return 0;
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
+	.clock_set		= aux_clock_set,
 };
 
 static __init void tk_aux_setup(void)


