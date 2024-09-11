Return-Path: <netdev+bounces-127406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2C975426
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CEC1F22F8C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE061BA876;
	Wed, 11 Sep 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6cBlxsy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEX4E2RW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA751B29C8;
	Wed, 11 Sep 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061415; cv=none; b=b+F2JeN4PHSHWHgtxyHt3D8hJHXFwwFibur4V+3ialP3wXe5ZrViWek+Ctdh5AoHF1y5ra6ypc3IvYCz/qXSCAD7BzEAmx6hEtMqOZAvKGMoBns1jhWm0gtaQ86Y2sQEbxfw0BYEbO9dczc6IzZiucARnVAUOXPhHf8bJH7FtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061415; c=relaxed/simple;
	bh=2vSTUiy2M2+n/xBK3bnXTwUEf75LYiXCvnS+8X+/mUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRYdgpzLOuqj89yhKz/1Z3JcCPjc4+UZoG9S9O0Q4jrz9qR41pL87R5qSSx6uA+2gJBji8VrxTneRU0NtpssZuNiEZiCqxiVtnVgc5tTfE45jvIx3q0JDKgMdfubpM+hdbUM+15w30AQUug7wFmN7cT+zejxM6lagM59ZoVb19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6cBlxsy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEX4E2RW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLvuVEX65jfPzMF+gnRmcXqdmJBBBrgBEg+xdPrOC4o=;
	b=J6cBlxsyvhK1XfoP7bPr1KpQ7el46f35fm0Ln7Xqx9VVblqf+eX2dHx75+wgpXPxSrgG8u
	iRjZC8sRNVejV0gYyF3GFDBgPUdvf21A6/IwJt8H+EHE6holwEvynylOdfKYPdJz0OY2Xn
	CYqdmZmB2xAnOVXTJ64HoM5VR/jzPWzY7dbA+99PQXj4kUwff/aY3Y4nhXkL11T6yIXLsH
	2t+dDneHDUd5HhL/UZP44BMfYg8bvZeL9Mk3Dzb1ffRT2ql2QJjFFA+4KAjqV7PD4n5fX8
	AHuq4C3AzVF6v3mX56oGCy//grJkElR4x0i8Jxm2YVV+JqSPg/8dBslwgndxjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLvuVEX65jfPzMF+gnRmcXqdmJBBBrgBEg+xdPrOC4o=;
	b=bEX4E2RWg+5y1kkwvvFRpRZwXZiJVbcXOpcFocfMwnJt4+z/qEuDrjD+fecOnYsV3dsuG+
	hEd67BFaX6R5RgDA==
Date: Wed, 11 Sep 2024 15:30:08 +0200
Subject: [PATCH 24/24] timekeeping: Merge timekeeping_update_staged() and
 timekeeping_update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-24-f7cae09e25d6@linutronix.de>
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

timekeeping_update_staged() is the only call site of timekeeping_update().

Merge those functions. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6aa77cec23f8..8e607413efad 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
+ *    timekeeping_update_staged(tkd, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -775,10 +775,21 @@ static void timekeeping_restore_shadow(struct tk_data *tkd)
 	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
 }
 
-static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
+static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+
 	lockdep_assert_held(&tkd->lock);
 
+	/*
+	 * Block out readers before running the updates below because that
+	 * updates VDSO and other time related infrastructure. Not blocking
+	 * the readers might let a reader see time going backwards when
+	 * reading from the VDSO after the VDSO update and then reading in
+	 * the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
 		ntp_clear();
@@ -796,20 +807,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-}
-
-static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
-{
-	/*
-	 * Block out readers before invoking timekeeping_update() because
-	 * that updates VDSO and other time related infrastructure. Not
-	 * blocking the readers might let a reader see time going backwards
-	 * when reading from the VDSO after the VDSO update and then
-	 * reading in the kernel from the timekeeper before that got updated.
-	 */
-	write_seqcount_begin(&tkd->seq);
-
-	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
 
 	/*
 	 * Update the real timekeeper.
@@ -819,7 +816,7 @@ static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
 	 * the cacheline optimized data layout of the timekeeper and requires
 	 * another indirection.
 	 */
-	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	memcpy(&tkd->timekeeper, tk, sizeof(*tk));
 	write_seqcount_end(&tkd->seq);
 }
 

-- 
2.39.2


