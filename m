Return-Path: <netdev+bounces-133515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7619962A0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D263E282D9A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664118A92C;
	Wed,  9 Oct 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qshuilf2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7feMh+FY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CC1885BF;
	Wed,  9 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462558; cv=none; b=fHW6KjVfL1MA/Z2jiFT5HQBFOHhKAgpSYvmapefgI4cJ/ESOOv+qXySfW+G/Z7A2ZYPaRAACaOSgIfqUs77ja8FW4tCL9U1892JBYcvn9G0+59IGlp6UQqWKOWTRAu7CW40ge86IDU+UFvsyAB5aXi1E1wewGgCAQPutLIvk5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462558; c=relaxed/simple;
	bh=6NsryiVtEAAtoUHSfTYQER7IlKdE4VbXYKGa6hiaALk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pN8ndaN2kE4ZmDU2AQRk8WDKf5chiYz7MLjmGtmEDjXl3TG/YZMDVmdK5ACtLHSN69kI+1F63qEwm9Mks8HV4hlY7xoj3Cp8GnWKAtx6cM72RNSn2WKUDt2Ot/WkOLO3xz1XEe7FZ8dd4Tub7TVcM2EXmTrk5br+jmGK1+u9jTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qshuilf2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7feMh+FY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kj9PA1CgwjnhqQ8xTBpdTyX7M4shxiowM3IXmHkmtUY=;
	b=qshuilf2Hm1GrjlDTPIQe41ua/iADXA5rvntWoXADVfzi1GaOi3JVqnvonaCiHF84TG7hM
	6WqLWQvHaYBGAkORg8f03kuElDqBh2XqCRM99vOaOKRv2sZ/w7znPWhDA+3tsh3DWQdPyW
	S8R4/H13RX7cgFuC1xvPxO7hy+DPZo/i3qZyJXtvfFVMoHTet9jW+IpksffEPXZ9MBxAvf
	x2wLDCWTia4R0ZzRs+TJce67diiIQTtj5DUx8S2xrExHeuOF8lw7iPIFu7I5IYlB1qzRL+
	dkqcydeSwRfeh1G/zgOyDlJCGZ64n4AAZD33vRv1L192WIq/glj/6jEYl9Oxag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kj9PA1CgwjnhqQ8xTBpdTyX7M4shxiowM3IXmHkmtUY=;
	b=7feMh+FY3I6dThEI0O+O6COLM0+O0x3V55Qk2usZZlD06lJpnGbW8iiwba9FkZtVkmIMKq
	wa9Wh3qxmP/TceBA==
Date: Wed, 09 Oct 2024 10:28:55 +0200
Subject: [PATCH v2 02/25] timekeeping: Don't stop time readers across
 hard_pps() update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-2-554456a44a15@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

hard_pps() update does not modify anything which might be required by time
readers so forcing readers out of the way during the update is a pointless
exercise.

The interaction with adjtimex() and timekeeper updates which call into the
NTP code is properly serialized by timekeeper_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6acff4cb7b1c..4e3afe22d28c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2627,11 +2627,7 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
 	__hardpps(phase_ts, raw_ts);
-
-	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);

-- 
2.39.5


