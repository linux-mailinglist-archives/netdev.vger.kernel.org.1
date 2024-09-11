Return-Path: <netdev+bounces-127390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9E975400
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC13B20E45
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6271940B2;
	Wed, 11 Sep 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWgYzHzA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPcm/mSM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC81A4AD0;
	Wed, 11 Sep 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061409; cv=none; b=i4s1VJgvq9EatsGzVovZbuk+BRQywVHRJ8AzNTzNaUMLij7d2CqFcO46OWQBJc0lQhU4KwKwUFL6taJzUj2gtnBYhGtOCrCQTL4YtE2dEXV7Tqd5OhC44pMmc1BVawlJ306HrI0I7XvHAKIH8tslODecekuKKL03+AAhvyEkNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061409; c=relaxed/simple;
	bh=aeBtCMLHwDjW5RjaS1UYpwEZIfdhF+bv3HGtKlY3PgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1S9I+HHwxobPfUcTCNITjqqgkfDgoSmeyzSbbZnqSy0P3vVdINu7RQwwSjLA0Pxzz1MHO4V0S3HOBeKBdTILTXXxAZj+9yUQDpSzfUuz3g0dXhttR2niDiCDYgvWSr7Yz2NiSmrXzPR3Xk5Alwz8mESKtCJiONGlCLQWcvv9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWgYzHzA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPcm/mSM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/yMD3R9spIxspDFxWIwUYuBkiPd/L8Pz+d/L53r+ac=;
	b=YWgYzHzA3cdcMVwu+fdQIrFpnLkcCN0OlsSOISqzfWICO6UKbEiK1kQl2PACalSFub+BI5
	Kg2Fdb7XLrnLjnmjqWN2BtWOGGMD4GZKFRTEVK5McJidKvEYTYZ/Qqpp2U5TRXpUVhuE8D
	5srfhmTjBt87jCYED5Q3E3+uBKoGP3UH6iYdgbn8zGs6o2dgpBqcTYkHAGX2gPavzJt0QF
	0KjyZAWjYhRhZ6jCyJ/8Y/pxP+z1at/8IAHjdEUHnmF7R8R9fyZgGRTgdWnODXTCiov5yD
	XKzLE+a2sCFe3XEMLhZrRXouQLmTCWtt+GaL/MKrKZePwuZUzt4o8HuHWyeycg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/yMD3R9spIxspDFxWIwUYuBkiPd/L8Pz+d/L53r+ac=;
	b=EPcm/mSMh42WIpzTvEpDqkN/t/wYov8XMzK5usKO1dt+oW8x3Y4OctekoHgUZm0G4Q+dDW
	psi2LeGVSgAD0zCw==
Date: Wed, 11 Sep 2024 15:29:54 +0200
Subject: [PATCH 10/24] timekeeping: Define a struct type for tk_core to
 make it reusable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-10-f7cae09e25d6@linutronix.de>
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

The struct tk_core uses is not reusable. As long as there is only a single
timekeeper, this is not a problem. But when the timekeeper infrastructure
will be reused for per ptp clock timekeepers, an explicit struct type is
required.

Define struct tk_data as explicit struct type for tk_core.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f8ffab5bb790..be939ce3bcfc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -45,12 +45,14 @@ enum timekeeping_adv_mode {
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
-static struct {
+struct tk_data {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
 	raw_spinlock_t		lock;
-} tk_core ____cacheline_aligned;
+} ____cacheline_aligned;
+
+static struct tk_data tk_core;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;

-- 
2.39.2


