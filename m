Return-Path: <netdev+bounces-133512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D199629A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F81F237B0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9018890B;
	Wed,  9 Oct 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttBTealN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkmTdHlI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9417C21C;
	Wed,  9 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462558; cv=none; b=P3BF1aMsgMnkUYJHsUC7aqdNOFpMNrpV9FzQC2P1LWWDgKVoJlh1n5A3b4Bwijvy3zaXrTooqsj3WX3vQiAGgUGdvXVjvvA5n6Pco6Cla68eU+0tklvsqtT6nVBOUzut9R4pzsW+EGkBYWVi/7E/dqUijUlNCwfFyPqOosPedEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462558; c=relaxed/simple;
	bh=Pl7pdohjpPDKyUfFmJNI/2UJnAbjeJXL7fXYMd1H+ko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m1/GkNapCV/ZL8KWTI0Kg/Lho9p6uAkI37X79thpeSMtwMhC/oxNT6lkbdE9uyFijKn36YsbJRCo2vZeES+wPjJdV7rxwIC+CWYaYpvKPB0Ae3sT+2iJP3d1zWqyWzFdTBy+n1EGbJu3ed9YuhKCBxPDnRiQ3ow5PyCI8D8qqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttBTealN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkmTdHlI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=riTF4PCJV2xPvz0IFOvjGOnVWz7omVWNFSat9ZbNqzI=;
	b=ttBTealNtYJSxhRF5yFzo3sZEHorLfxr8gOupBuMfUXe1qWwx+hwFS7spGzmh9frAD7Lbx
	mvVxj7nVkOcCe+cj+bDGCg5fhjfffI5SGdxetp4o/h0FiY994mV79hHYfvTnMxf+LCtgY3
	q+R2kypWVb+HIxZeAiCqvM53aoShSDMNMPNd8oKQH8YII4KEBxPusFUnErP1rabTW8rub6
	WLOSkS5HgcOsEopHBGdSk6b5qY56d9Z5EbnPCsHZ7dklPCfIOAVZizizGuLTyISk8d9u9r
	9OW0xojWBS6O0BKhmMCW+PKETgN/r4nXTf6wBuJOdLwBLMBjbW2xUGe94K/IOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=riTF4PCJV2xPvz0IFOvjGOnVWz7omVWNFSat9ZbNqzI=;
	b=OkmTdHlIv4MuLk01xLKEbp6vVGj7VJLE4SFr7zqVYQ+fsJ9+4vHnA4HiQh85BPR+ZX+mV4
	D8pvepH0Cp+mGyCQ==
Subject: [PATCH v2 00/25] timekeeping: Rework to prepare support of
 indenpendent PTP clocks
Date: Wed, 09 Oct 2024 10:28:53 +0200
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMU+BmcC/52NQQ6CMBBFr0K6dsy0VgmuvIdhUegAE6E0bW0wh
 LuLHMHdf3/x3ioiBaYo7sUqAmWOPLsd1KkQ7WBcT8B2Z6FQaaykBEuZRjDOGZhMYAONhsQThQg
 ++WO+iDy7HlqNeGlK1Aql2IU+UMfLEXvWOw8c0xw+RzvL3/tXJktA6MrWEFakrvb2GNm9U5gdL
 2dLot627QubZyyS6AAAAA==
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

The generic clock and timekeeping infrastructure supports only the already
defined clocks and as they are not independent there is no need of
generalization of data structures. But PTP clocks can be independent from
CLOCK_TAI.

PTP clocks already have clock_gettime() support via the file descriptor
based posix clocks. These interfaces access the PTP hardware and are
therefore slow and cannot be used from within the kernel, e.g. TSN
networking.

This problem can be solved by emulating clock_gettime() via the system
clock source e.g. TSC on x86. Such emulation requires:

1. timekeeping mechanism similar to the existing system timekeeping
2. clock steering equivalent to NTP/adjtimex()

In the already existing system timekeeping implementation the lock and
shadow timekeeper are separate from the timekeeper and sequence
counter. Move this information into a new struct type "tk_data" to be able
to recycle it for the above explained approach.

NTP/adjtimex() related information is all stored in static variables. Move
all of them into the new struct type ntp_data to make it reusable. (See
https://lore.kernel.org/r/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de)

Even without the future support for independent PTP clocks, the
generalization of timekeeping and NTP/adjtimex() improves the structure and
readability of the already existing code.

Once this is implemented clock_gettime() support for these clocks via vdso
can be implement as well but this is an orthogonal task.

This queue covers only the generalization of timekeeping:

- Patch 1-5:   Basic cleanups
- Patch 6-11:  Generalization of tk_data
- Patch 12-25: Use always shadow timekeeper for updates

The queue is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/ptp/timekeeping

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
Changes in v2:
- Fix build problem reported by Simon Horman
- Link to v1: https://lore.kernel.org/r/20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (17):
      timekeeping: Avoid duplicate leap state update
      timekeeping: Move timekeeper_lock into tk_core
      timekeeping: Define a struct type for tk_core to make it reusable
      timekeeping: Introduce tkd_basic_setup() to make lock and seqcount init reusable
      timekeeping: Add struct tk_data as argument to timekeeping_update()
      timekeeping: Split out timekeeper update of timekeeping_advanced()
      timekeeping: Introduce combined timekeeping action flag
      timekeeping: Rework do_settimeofday64() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper
      timekeeping: Rework change_clocksource() to use shadow_timekeeper
      timekeeping: Rework timekeeping_init() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_sleeptime64() to use shadow_timekeeper
      timekeeping: Rework timekeeping_resume() to use shadow_timekeeper
      timekeeping: Rework timekeeping_suspend() to use shadow_timekeeper
      timekeeping: Rework do_adjtimex() to use shadow_timekeeper
      timekeeping: Remove TK_MIRROR timekeeping_update() action
      timekeeping: Merge timekeeping_update_staged() and timekeeping_update()

Thomas Gleixner (8):
      timekeeping: Read NTP tick length only once
      timekeeping: Don't stop time readers across hard_pps() update
      timekeeping: Abort clocksource change in case of failure
      timekeeping: Simplify code in timekeeping_advance()
      timekeeping: Reorder struct timekeeper
      timekeeping: Move shadow_timekeeper into tk_core
      timekeeping: Encapsulate locking/unlocking of timekeeper_lock
      timekeeping: Provide timekeeping_restore_shadow()

 include/linux/timekeeper_internal.h | 102 ++++++----
 kernel/time/timekeeping.c           | 369 +++++++++++++++++-------------------
 kernel/time/timekeeping_internal.h  |   3 +-
 kernel/time/vsyscall.c              |   5 +-
 4 files changed, 238 insertions(+), 241 deletions(-)


