Return-Path: <netdev+bounces-127396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8897540E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF561F21329
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF81AD9FF;
	Wed, 11 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d8LaImBH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDFzFhUh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345CF1AB6DA;
	Wed, 11 Sep 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061412; cv=none; b=KgL5yYTh9/0MS+x2KH720eGn6c9Xv9Ov9jujqaFlx+QKcnRWpQ86HkLqYZpp3QJ1T8a2VBWkTF9xCZFCEzCnzbBUYFmOLuW0H6FPvwI8kd1Wdiq9xMnDgc3XsjFNJT2kKLPpr5Lv1ev43OAkzaEP3OGjBx5b6B3VTviigR+HUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061412; c=relaxed/simple;
	bh=BvRw9iUIRqPjUujjNVsDLcQWcwHAFdeMgcXUK80VR0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJM2CE4jHURamsbuwkwxMIxDHNg2HiGYGPZEoLemPggJ9TCsPyijHv33ub4Wqaz6I4ZhgNWTVJ5xrYTXhiyiRyGby2c/rYplXcpjZGqeG96A5zBt6SwJYIKQ7RETRKT5As7T7wd9RuukYqawKm6cqHTLoiBmYu5/derb4GHXKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d8LaImBH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDFzFhUh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eQu+IcDEW2uo6h8G1deirSpZoVIHYB6Kt5NtOYSq4c=;
	b=d8LaImBHpXoY80T9g5KuWjTOo2sxiXdY/KtJzJloTC8Hk5l3H4MXwoYpIQqizic829LnLS
	miYlt9yEtREvqmjjuO/MvZ4B0qbHmC2CXsQsGn0ZZzFqZumGpWamiSrie1pzisFJWCClNX
	4L5BfpjAnJN4QtscdwvGxd0BEKz2wEOIzvIs5CdyA3adTda2FaKsYMLskQPBNHlGGP1kk0
	9tO/yHQM/VM4GuhwhsWfiRY68LBmjZuVaY4No7olYfD0tDE+dh9fzWr7nIMtGUYmRTkcyf
	dQ+Pr0fehyYaKyuCV5X72uqlD8sWh1cbFG1YwkMvHCQT7hyvXUbMgk9Sh1kg5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eQu+IcDEW2uo6h8G1deirSpZoVIHYB6Kt5NtOYSq4c=;
	b=BDFzFhUh/pTPtZzxT3gFRZbV1zYJd+DV2vDv/Llg7KJ3AMIDO3CCUFqHfSP7a8ZDJNdaif
	8dxhVoFR6843kdDw==
Date: Wed, 11 Sep 2024 15:30:01 +0200
Subject: [PATCH 17/24] timekeeping: Rework change_clocksource() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-17-f7cae09e25d6@linutronix.de>
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

Convert change_clocksource() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8b8d77463f3e..9b4fd620f895 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1596,9 +1596,7 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
  */
 static int change_clocksource(void *data)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *new = data, *old = NULL;
-	unsigned long flags;
 
 	/*
 	 * If the clocksource is in a module, get a module reference.
@@ -1614,16 +1612,14 @@ static int change_clocksource(void *data)
 		return 0;
 	}
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-	old = tk->tkr_mono.clock;
-	tk_setup_internals(tk, new);
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		timekeeping_forward_now(tk);
+		old = tk->tkr_mono.clock;
+		tk_setup_internals(tk, new);
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	if (old) {
 		if (old->disable)

-- 
2.39.2


