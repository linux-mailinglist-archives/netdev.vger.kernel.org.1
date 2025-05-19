Return-Path: <netdev+bounces-191418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFEABB76A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9963D3AE7BB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842082701BE;
	Mon, 19 May 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5BPJZjr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/dRXXhes"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367A26FD8E;
	Mon, 19 May 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643612; cv=none; b=VN+IoTtCvHpRc/aoQknrcTr5Ry2I6nf1pMXuIaRL1ZJGMDpNHbjHVTvQXg6bNhl0XYZZMy3SYd/1pXicFxuUfu7KxckX3P3SJaI3ctyFWSet+m1YTPTQUE7PSahtYql7TE9fzqTUYo7CfjxJsART3T2dviqd3U0MU736120eqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643612; c=relaxed/simple;
	bh=YUzu3k5X/EMVbk9mZye4LenY4n2dKppugU0I7/ADlcg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IQWXDGj01E36la0IE5SEP+v0dXcsgIdUwDvBgM/PHvQoEB0ELz/8Dm9UeOCELP1BBbrKMYBtEL9/SqfBzqsoKxqMxCr7XsfATqQrLj/xh/VneypP8Dc7pK9ZNgGI3xHMuzD1GJb2Bkk7Q72ymEm+hSLmQJ21mpcxODwZGHCJatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5BPJZjr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/dRXXhes; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.350061049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/SRQDM/A5IpK3yyd3ilOVzrwfbDRClBN+BY9c73LlaI=;
	b=c5BPJZjr/m4JBW+rucByllJGl3mYSXES014qyBleX8RBPYOp7ygOFm9d0Y66Wgj//gz4g5
	asTWV8NEenXVDFBqQPMpDm6rIi73XjsOAzWPvKitGaoyzCb1UZkQTrlGBA3Eti4aO0fdHL
	p1SmzIxyvuQwqXdLaV1OSgFYHSN1wifda7ehug1oAc/pN96DFFvH8ooCqr+vUg6nGXY7jp
	I/B5DhiwejF4mlJeLFrhbhWzbAGP1746jGoRGlkSGP8TILBKRRWOwtjy5JIITfyc7it5Hc
	1n7GzfeTCPKgv0wLuf989oz1iEH4rTX6x0mLsw6DtgXkYTR/FyzP8PXAxvMefQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/SRQDM/A5IpK3yyd3ilOVzrwfbDRClBN+BY9c73LlaI=;
	b=/dRXXhesStOgjsrlliity3AFepopBsumjgNq633rxs2bd2NpucQccfeYdajpriN6imooTm
	jRzPPcliupPI3KDA==
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
Subject: [patch V2 12/26] timekeeping: Introduce auxiliary timekeepers
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:28 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Provide timekeepers for auxiliary clocks and initialize them during
boot.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -53,7 +53,11 @@ struct tk_data {
 	raw_spinlock_t		lock;
 } ____cacheline_aligned;
 
-static struct tk_data tk_core;
+static struct tk_data timekeeper_data[TIMEKEEPERS_MAX];
+
+/* The core timekeeper */
+#define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
+
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -113,6 +117,12 @@ static struct tk_fast tk_fast_raw  ____c
 	.base[1] = FAST_TK_INIT,
 };
 
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static __init void tk_aux_setup(void);
+#else
+static inline void tk_aux_setup(void) { }
+#endif
+
 unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
@@ -1589,7 +1599,6 @@ void ktime_get_raw_ts64(struct timespec6
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
-
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
  */
@@ -1701,6 +1710,7 @@ void __init timekeeping_init(void)
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
+	tk_aux_setup();
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -2630,3 +2640,11 @@ void hardpps(const struct timespec64 *ph
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static __init void tk_aux_setup(void)
+{
+	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)
+		tkd_basic_setup(&timekeeper_data[i], i, false);
+}
+#endif /* CONFIG_POSIX_AUX_CLOCKS */


