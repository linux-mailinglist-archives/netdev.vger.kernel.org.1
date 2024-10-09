Return-Path: <netdev+bounces-133531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C496D9962CA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019491C20CBD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0818FC9D;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/+xvFBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymrGE37r"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EED18F2FD;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=mCgROfNJbr+7g9mO/sUcQZGJ6aXkN0oLfto3t4lhwOrxEYZF9maKvdOZq8Qx8BCgOCnvtF08OLFGymW+dPCuoQZ6gxooYwlcP0f2migLsxYNJOQbFgderQ5QiPC6ie7/Olg2ePjsJhFBOL7+AkYzRFmoJBa2AJvvJgvRLwV5L84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=OV2RbWL3lOHjlv0YduQhmOvwG+FZWlmHlXI0HnvVwFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+7e/R/TisshshP2CeCJOz46Uyd2DDLunO4MV9oH7N73tllGdH1A3rCZ6kGpaFoCpXDurIbu3HSpj0nLo2NhHEBsZeNIH2edpOVBQVx3mk16Inmi/IRePjAXKPEB0jGrdfDo+MTGh2LCEQDnla0DgsYVYVSh9a1ggT0sR8r7kh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/+xvFBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymrGE37r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdm7e41dOSBQbrRJct9Hds0vyLBx4funvYTF+LlLDVI=;
	b=o/+xvFBgQoIfomFZbTU/LtvQKz6jAg8xWVov+tlMaCaj3MNyLHUpE/ULwLuSErOK2eKFHF
	74RyDXnj4lf1kwHiGGzOnX99AJ3WwZXoNY7INQcU1phBMvGa5n8RY+NouUj1KIUKGDaM/P
	U/Y7WwtqoyDaNa+EjLwO3kr9OEIfzQZ+ovqEn+UjPyDfehzE7lnrgaKlHl8m+cVVeGjHV4
	kP8ZAe3GNWkKP0XCrZF6LLeIJUtz08rtqqg84TuQH12Ay3quhBlp9c1GzMR820JhICU4Vi
	Jqfqm7fV4NlrHvNnhAAWkyWEA86PIuFfyOIaoddGrAKZ+OmQsQDZKjKXXeWArA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tdm7e41dOSBQbrRJct9Hds0vyLBx4funvYTF+LlLDVI=;
	b=ymrGE37rt5+5av0iME01J140p7PuSkX1xQeH/lgQpRljwmE6tsaDlRcPYPy/qML4T8N5Yw
	JR0RBE7ogiwAJdDQ==
Date: Wed, 09 Oct 2024 10:29:12 +0200
Subject: [PATCH v2 19/25] timekeeping: Rework timekeeping_init() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de>
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

For timekeeping_init() the sequence count write held time is not relevant
and it could keep working on the real timekeeper, but there is no reason to
make it different from other timekeeper updates.

Convert it to operate on the shadow timekeeper.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6d21e9bf5c35..bb225534fee1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1778,7 +1778,7 @@ static bool persistent_clock_exists;
 void __init timekeeping_init(void)
 {
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core);
@@ -1802,7 +1802,7 @@ void __init timekeeping_init(void)
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	write_seqcount_begin(&tk_core.seq);
+
 	ntp_init();
 
 	clock = clocksource_default_clock();
@@ -1815,9 +1815,7 @@ void __init timekeeping_init(void)
 
 	tk_set_wall_to_mono(tk, wall_to_mono);
 
-	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, TK_CLOCK_WAS_SET);
 }
 
 /* time in seconds when suspend began for persistent clock */

-- 
2.39.5


