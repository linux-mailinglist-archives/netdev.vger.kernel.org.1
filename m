Return-Path: <netdev+bounces-133521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1E9962AF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C781F23247
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650FC18E36C;
	Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gr75EYUI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vi3oOdd+"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0318D643;
	Wed,  9 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462562; cv=none; b=Zm4E/Lr+rG6F6xDW7wbx/Dj6OMOiWmME+NWM9f6mRMv1Qgp8IGuxB8tjA/2UcSyzq0NiAwb4N3Kv77mE0uHpV1ssMtpX41LcyWJYynA/E/8IH88Q3gCpE/1DAMFL2Hem/xzPMMally+/YXHQhT8xvfzn1IZyaH6dcD0XrjyAq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462562; c=relaxed/simple;
	bh=3OUvtUjQqnQDfYli5HJIk26F6ond8cHnb8VAZNno3Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVfcWv56K3QS9HRrO477jglE63B+h+mssM7j2Cer44plDol8qtftj9LPAlz9QqXfeMXxfXmzaJtDHU0LGFAMOx4xEMgLG+XIo8fL6YIFN48IgpwF4s1hO8q/DW7tcy41GK+YvXnJUdBjanR1ODxyVU3nKlWJV14j+Pw8vP1C4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gr75EYUI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vi3oOdd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLAnHBvTjt0WPGqjgr+Qtf2CpGbFQtqVrOAWERdILJk=;
	b=Gr75EYUIRfSAdOMM6xfthBAc7wxWG8pRUV9gAYL/MfG7W6zbHKgHUWpjBkdhipbuOR3wgd
	/aed6k3rhbxPipSb5beClkP6AJojaNmY0JKB8MkGKwIIaTNui2+jXbjp702TVlIEB4ESDY
	FG6Qb6+kvpitOKwq5dZnunMcjCr89csZpr80DDAbguhYD9a64rs79p0hBNzinQubj0n9j7
	VwpC4OqTnCmkWYt8Rl4r8HQeUS1asF5Y3VaquF/XDkgNt0qvlsa2tfKhsiHM9IZHXpVlvi
	lWx/1s/mBWZlzULTzmZzDGBKl5imSs3s3Ke/mufPHs+/ct67VVtWlw5QKZi1rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLAnHBvTjt0WPGqjgr+Qtf2CpGbFQtqVrOAWERdILJk=;
	b=vi3oOdd+CkD4lH2yijlP8toPAAtcFBsJu8SPmKKhNdQ4pfXTq0ur9DRWsAvxfHgcYvfQkG
	kQNKqWV7Fqql8ICg==
Date: Wed, 09 Oct 2024 10:29:04 +0200
Subject: [PATCH v2 11/25] timekeeping: Introduce tkd_basic_setup() to make
 lock and seqcount init reusable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de>
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

Initialization of lock and seqcount needs to be done for every instance of
timekeeper struct. To be able to easily reuse it, create a separate
function for it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: new in v2 - splitted from another patch
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 40c60bb88416..a98f823be6db 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1734,6 +1734,12 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
+static __init void tkd_basic_setup(struct tk_data *tkd)
+{
+	raw_spin_lock_init(&tkd->lock);
+	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+}
+
 /*
  * Flag reflecting whether timekeeping_resume() has injected sleeptime.
  *
@@ -1761,8 +1767,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
 
-	raw_spin_lock_init(&tk_core.lock);
-	seqcount_raw_spinlock_init(&tk_core.seq, &tkd->lock);
+	tkd_basic_setup(&tk_core);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&

-- 
2.39.5


