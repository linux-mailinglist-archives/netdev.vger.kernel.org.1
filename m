Return-Path: <netdev+bounces-190196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19CAB5844
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0249C3BD977
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F972C0311;
	Tue, 13 May 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JnqjwGYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAJMli80"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38402BE0ED;
	Tue, 13 May 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149201; cv=none; b=E5HmflG53fWS9S+jKBLvtl4W9joCwqvV4Tu0XnlPI2qWwykSpbd3O3QpbQ7e9NxwBCYlYPcSte3hVEIoTeehIiq280wf/QayLkL6W6/k+Q1AnTgLojlevlQAyMP1uydz1hJ11BNmYkTojX4LTEFVy45B9ZxMRxqnvnn68ghKCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149201; c=relaxed/simple;
	bh=7rlVhwwEK7pkxbrm97gviPqsq5eXgHWjvV7zgZ/ryjU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=m9VgQLHUF98x6DEmXKDr0sNxh1uoNVgPe14dw2o5SRt/glJ2HC+0k0MFM0DnISm7SVLlcT1ZacDBH9HNRoBaG9PseAk9tk/buDQfFdk54TXIJR8xB9JmApVgZKgx9ZpcrVmJRSVb41E0ZUDw2qCBZlaCUetllSnltShD5C9Xm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JnqjwGYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAJMli80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.328165847@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gX7iCiYfGsRnCTExZfiSGn2FqWTPgxe9dSFWPNxUFpM=;
	b=JnqjwGYsicjKTm11h6ZHQLG/XWQbUnX1ZGRNnWpHzc66X+rLNe0gH1ugL9iSMjhpdc6afO
	we55p6loqkNALj/P1dQsuiRI32WZ5RrgTVGuS0QRbT4MslSf9SQdhTgtfRgsC4hHSTrTvp
	GTtCm91rCw/ebH14iZAg7k4tX2nlSWK/KYo9IdCWleD0BS5g+dD1h3o8KZSCY692yEB/b8
	u8OHhKBEmM7VG3WmS75C/MDawaQsXVMTPjKQx/DLalEOoeD9R++KpYVQa5aLxCO2RTW6uV
	4CLHFul5bMOtrZbEjt5ytS2SQhmFmyt5umGEHrD+S/Bw7k/MJTSvzXew2HHDDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gX7iCiYfGsRnCTExZfiSGn2FqWTPgxe9dSFWPNxUFpM=;
	b=qAJMli802AqcheEh48q9iwOEaFdFiSHfEGKer7k4Zmxuoo+d6aZBfVObm4uIsgPTrN0uw4
	FcocIFbCv3BBP/DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
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
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 11/26] timekeeping: Add clock_valid flag to timekeeper
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:15 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation for supporting independent PTP clock timekeepers, add a
clock valid field and set it to true for the system timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeper_internal.h |    2 ++
 kernel/time/timekeeping.c           |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -73,6 +73,7 @@ struct tk_read_base {
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
  * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
@@ -149,6 +150,7 @@ struct timekeeper {
 	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			clock_valid;
 
 	struct timespec64	monotonic_to_boot;
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1660,11 +1660,12 @@ read_persistent_wall_and_boot_offset(str
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
-static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id, bool valid)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
 	tkd->timekeeper.id = tkd->shadow_timekeeper.id = tk_id;
+	tkd->timekeeper.clock_valid = tkd->shadow_timekeeper.clock_valid = valid;
 }
 
 /*
@@ -1694,7 +1695,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&


