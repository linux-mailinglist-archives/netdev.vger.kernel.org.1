Return-Path: <netdev+bounces-191420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC5EABB76C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B2D188C60B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736C27055B;
	Mon, 19 May 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jToyYKZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AISqXRdl"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189E2701D4;
	Mon, 19 May 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643614; cv=none; b=N9FbtUN+QDUirGa0DQfiZHJ9lZc+6NnYte5RKrH3aHfNzkFmKRjjUxnnxdevrX4gDG2TGJ0zCaFynIEYkEYZ7nrDQUQqip7kVYCYeTdk9x+tFFGpa90wWjKLAi7sxZ6S6Uf9UMkuTL1+jDQQBZBWKf1nA/Y+jev4dfM3Ne1InZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643614; c=relaxed/simple;
	bh=FM9ELVeqz4TUsKpyJHGSgjwI5KFnezd+C6Mvdegl1pE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Mun/nXjYsMEsogU5jeBDuoakyA/nkbbN5+s1wy7eR0olfQU7vaLDhVzf1DB2r1zlM0BxRhm0Gm4xSLa0rwpJ0C0Jlz2ZtDqwrK6ULmSTnTumge8f7hBc5dWJmz8q/PH+o3NivNkRfT6lZ4BKrlmZGEowt3OwwWMzXm+JXmy234M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jToyYKZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AISqXRdl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.411809421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1v1pAT49VMlkOWBDIvngj4OT88UyCqJmnvYZ4oJqhv4=;
	b=jToyYKZvwkC3JcQOhodrq7x/nVjuIB9mBdYySunQp0g1n5qX26/crAoA5zXYHEmdjwvUVn
	eajKLGOK2pYbrlY0xr2ucM/MqO4EdznL9sRpNWLAIB1p8XzI2E4rLHgD/X6j2FQhmH2TlF
	ZYXUxWTVSA3C4MpGMMAFw9FAmnXkQgsBB1lc6QMEGKLlFnLI2cWX9kWWf8Z2qmvS4M73R5
	bRbaiY/EXL2kI5zjDSHYeLjCPRdU3P441Cm6TJcc/jKlczRrcftpA6W7WfClEb0Vj8YEif
	WgSCtRg/flT0MFpAYXvgDvCGazEXQGo8e0mWrQrKYy3WSGMiG2a3357AlXRZrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1v1pAT49VMlkOWBDIvngj4OT88UyCqJmnvYZ4oJqhv4=;
	b=AISqXRdlhD/0o0O59uRlbj36ghoiLIyq+rL/YHfoLNNc8vjLsKt/NNssM2uLaPjWmNo5p8
	ogWD7EKVf6DCt+CQ==
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
Subject: [patch V2 13/26] timekeeping: Provide ktime_get_ntp_seconds()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:30 +0200 (CEST)

ntp_adjtimex() requires access to the actual time keeper per timekeeper
ID. Provide an interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c          |    9 +++++++++
 kernel/time/timekeeping_internal.h |    3 +++
 2 files changed, 12 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2627,6 +2627,15 @@ int do_adjtimex(struct __kernel_timex *t
 	return ret;
 }
 
+/*
+ * Invoked from NTP with the time keeper lock held, so lockless access is
+ * fine.
+ */
+long ktime_get_ntp_seconds(unsigned int id)
+{
+	return timekeeper_data[id].timekeeper.xtime_sec;
+}
+
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -45,4 +45,7 @@ static inline u64 clocksource_delta(u64
 unsigned long timekeeper_lock_irqsave(void);
 void timekeeper_unlock_irqrestore(unsigned long flags);
 
+/* NTP specific interface to access the current seconds value */
+long ktime_get_ntp_seconds(unsigned int id);
+
 #endif /* _TIMEKEEPING_INTERNAL_H */


