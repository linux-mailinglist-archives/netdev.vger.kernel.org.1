Return-Path: <netdev+bounces-191414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC4ABB753
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48D17A88A6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE826E146;
	Mon, 19 May 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZuxHFWy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCB6uxOl"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098226C3BB;
	Mon, 19 May 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643607; cv=none; b=FmjDR20bFmFr5idWhCh9WK5KavRsYIcNAPJpSsoPZRYX/hcnTvD2zl+iIH8ydcQGrL3GqNM10WHO+HbKNDVC06/8DWDivExCnnOV4J5XlQFnBdIqHwq7YL40ZSRx0KHWICnAIsy/b25k1BCZ+/EupVmhAmL4krvF8zHT3IYC84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643607; c=relaxed/simple;
	bh=aep2icN5cFnOirjS2mGyNdZUKxHqz9ryb7dHiUjfhEg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tauS4w0w0oH0z9NW/rflChlmYkeBBfCrLO2TWYYQu2BBtWHbmGurJHxz4x+N4zJ8qMWbbyS0ZybMwF6/cGQFu8W9mvc2ZUW358Hi+Zte3WqAOykDZ4SQfqym50bHV1Gj6fe/bv8g4Jwe/zBzrObee8rguFbobz+wemMa8MPqHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZuxHFWy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCB6uxOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.095637820@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YLdik8p+akr6/2708As9+5DTo8ghQQC0aWkttak5lwc=;
	b=PZuxHFWyzUI2RPQL4MItkc8RoECK9eR35GUIazGT0LO0tHrSFXDB/3Fxh3vwkum8PhhXTy
	906pq2WQrf5ijKyzsUtS8LfCO5HJ3rNUdbQ8F1ZWr4va4VrLDuiYkzpFYnQLC64wGjhzZ8
	oBmAJY7o4wQPhUCiVyLLtadDy61POYHX3bBMy28iD3PsbuK+eLevcNORBQpP5U4D4HxvJK
	w3IpPkQpv2K5M+AsZavulxP64oTxrGPGySt1z02p7izs20l2xS+eLVn2BHZRm+h+QPV4eo
	Z7j1MarYKQnbOTa84jcfiJN54wJp9dGfurNMKBvwsFCuAiWRGLWXd7k7mW2+3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YLdik8p+akr6/2708As9+5DTo8ghQQC0aWkttak5lwc=;
	b=WCB6uxOljqyHX7LCc52+jcpcAFaqK1DiC0sWAkBvo5C/ZCAZ6s1ZNJnQzub9IWmGFwTp+D
	vRGKUAFAqG0htBBg==
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
Subject: [patch V2 08/26] ntp: Rename __do_adjtimex() to ntp_adjtimex()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:23 +0200 (CEST)

Clean up the name space. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c          |    4 ++--
 kernel/time/ntp_internal.h |    4 ++--
 kernel/time/timekeeping.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -767,8 +767,8 @@ static inline void process_adjtimex_mode
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-		  s32 *time_tai, struct audit_ntp_data *ad)
+int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+		 s32 *time_tai, struct audit_ntp_data *ad)
 {
 	struct ntp_data *ntpdata = &tk_ntp_data[tkid];
 	int result;
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,8 +8,8 @@ extern void ntp_clear(unsigned int tkid)
 extern u64 ntp_tick_length(unsigned int tkid);
 extern ktime_t ntp_get_next_leap(unsigned int tkid);
 extern int second_overflow(unsigned int tkid, time64_t secs);
-extern int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-			 s32 *time_tai, struct audit_ntp_data *ad);
+extern int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+			s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2586,7 +2586,7 @@ int do_adjtimex(struct __kernel_timex *t
 		}
 
 		orig_tai = tai = tks->tai_offset;
-		ret = __do_adjtimex(tks->id, txc, &ts, &tai, &ad);
+		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);


