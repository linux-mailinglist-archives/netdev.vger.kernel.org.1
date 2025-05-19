Return-Path: <netdev+bounces-191422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA459ABB770
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5FA1883C6D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145B272E69;
	Mon, 19 May 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2vL4TTp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHv/QDiy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759E270EAC;
	Mon, 19 May 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643616; cv=none; b=DDNag+ahCBVCeDVs9TZgog0fGDqNDlWBonQP2y0Jg8ZmQ5zvaRKHqDVEjd/fXzjbtvFxIE9CkgsisCiGgi+aSdD0Vdh9xz+6ewWeonwqcspw5XpLGeVHnoctJwXHt7KqHpw+iBZIspbBYp9Vevg7mIGUMHf9RV/g/b9YZyvGsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643616; c=relaxed/simple;
	bh=T65jdGNGXmtGGOUz33OVaG2sLwQXgcw4amezguV8uno=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Wi3BHGktrF1w8SzLZ2Eknrr1M8XMgr2z6cX3CqLG5ISL/Wuq8wGuxZ3fE4MRCcDu7Fme0TIWam3E9MCEETLWY8A6cti2dgaYoKrJC0JpqZIZNqT304f0PtbiqJRDFhofaEtvHkA8bI/NNoDXFJe/UpSS/rG0MRnWR9GFgfbCj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2vL4TTp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHv/QDiy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.594820760@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yjQaFwdaDWpoRr2nUd9ek6VPNntBmypVCgJfP9Yy+oE=;
	b=J2vL4TTpCXrbQKebRBKYDVM8auCSWgsulFyNaaREeAeCADoGgqX9zevvy0xHZPfJq525i2
	B2jEh2ov5tphqOAS7BxVXqNfMlNA87t4DdyJl1WHCcticae/6kadKMPGsEPGz6Iftm2H0G
	UhuQQcFRm8b/vdMybxY7t7FH7+6AFucWOJw97wlcdYVq3xcyTCAovSPKlBduMDi1RcuEwv
	D7PyKYqcEJJw1gxrVW1c0t+P7Vh+sgNvRsX2Ms+5dyaMaKBuyA1/bLH5o8VkHz+3aOoUwc
	Kpo1kZWyX0i3SSPwB+zmiR4l+WjjV/vWdluWahmBvbEEjuSCb+gjI1BtrKL6GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yjQaFwdaDWpoRr2nUd9ek6VPNntBmypVCgJfP9Yy+oE=;
	b=nHv/QDiynJCZgeKZePdVc/U0d5EE3NBxCuwXDa2BTlfcQManZZAAsoHYZKZvv7geiYMEH6
	i9qhdRunDEO0nIAw==
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
Subject: [patch V2 16/26] timekeeping: Update auxiliary timekeepers on
 clocksource change
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:33 +0200 (CEST)

Propagate a system clocksource change to the auxiliary timekeepers so that
they can pick up the new clocksource.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -119,8 +119,10 @@ static struct tk_fast tk_fast_raw  ____c
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
 static __init void tk_aux_setup(void);
+static void tk_aux_update_clocksource(void);
 #else
 static inline void tk_aux_setup(void) { }
+static inline void tk_aux_update_clocksource(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -1548,6 +1550,8 @@ static int change_clocksource(void *data
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
 
+	tk_aux_update_clocksource();
+
 	if (old) {
 		if (old->disable)
 			old->disable(old);
@@ -2651,6 +2655,30 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
+
+/* Bitmap for the activated auxiliary timekeepers */
+static unsigned long aux_timekeepers;
+
+/* Invoked from timekeeping after a clocksource change */
+static void tk_aux_update_clocksource(void)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_AUX];
+		struct timekeeper *tks = &tkd->shadow_timekeeper;
+
+		guard(raw_spinlock_irqsave)(&tkd->lock);
+		if (!tks->clock_valid)
+			continue;
+
+		timekeeping_forward_now(tks);
+		tk_setup_internals(tks, tk_core.timekeeper.tkr_mono.clock);
+		timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	}
+}
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)


