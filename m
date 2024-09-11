Return-Path: <netdev+bounces-127397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED962975410
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15C11F2241B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE91AE862;
	Wed, 11 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWeolac5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Znd8wQZa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58C1A4B70;
	Wed, 11 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061412; cv=none; b=Kc6AucarlHvFl2bOM548ya80jOmV8F2KrN7bNMjz0K5X7DZEAEcx6A06z59XailtpR4IoZ/ZYC1ITPrezJkeMCFU1oZjQ61KeumiVpEP3hlsMxTBsXw4F3CvbSO+O2fII+iDOxYRl5TzUaEhas73v2pJZZvucyf19ES8vzP5vsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061412; c=relaxed/simple;
	bh=Hcnpfq43P0r406C0KqrzhFRGnzGoOGa7FAO1+nTIPdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ogm1iJ4A3J2yenms3/jgnZCbXl8Aerqxii9dQAx6r8YhI1XcnjbsfyXvL+wwxUZLAKCiixMETXjqu2v85yqJq40Gxfw3V/ETh7WoJloJI5K2rSrqRcLAKZv7sLCb9B1c9CeMFfV5KVQXo9FLsvlIN1SDDB2WA2615nh/+iqyGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWeolac5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Znd8wQZa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gq4WxA36B6P8L3S4KfzH2ULeNi1uLh9jaG6BaCuUoNo=;
	b=UWeolac5pPgCZibLv8hUQg9mpfA/U5bpagha86EMPx97FtY14mnqiFGYUDOeylScyMnvbw
	LTrQkRYOCsXhOUNEsP/3Wgfb3wb6g1HHfr755WCmH1zW2eWHux8YYBwu9tbbvUWAZRMXEm
	Vq1kOFNjuFDXU5OB8w5kjO1xdinoPJYGBfH85tC5590To91XaQ/bEie0tBlc6J2ztDV23I
	o2sT+AAHLLAtIO4ou2G3PYK4Ps856qarLl/+5O5GfYvD3cHdpbf0sMQZw8/I43+8KqLpvr
	K5LXsgCbO5AAzg4/++r6e/qwzAEHU+gI81gVwchZYsCcRuoxNg2i4v2ewnoTsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gq4WxA36B6P8L3S4KfzH2ULeNi1uLh9jaG6BaCuUoNo=;
	b=Znd8wQZa6buFroSclP/dd2ojhqrdEdZr1ybZBmWj9vEiICHgZQG898RCnsXE066MdZbc1x
	U11SMP7LXttF1bAQ==
Date: Wed, 11 Sep 2024 15:29:58 +0200
Subject: [PATCH 14/24] timekeeping: Provide timekeeping_restore_shadow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-14-f7cae09e25d6@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Functions which operate on the real timekeeper, e.g. do_settimeofday(),
have error conditions. If they are hit a full timekeeping update is still
required because the already committed operations modified the timekeeper.

When switching these functions to operate on the shadow timekeeper then the
full update can be avoided in the error case, but the modified shadow
timekeeper has to be restored.

Provide a helper function for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a69850429fb4..345117ff665d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -755,6 +755,15 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
+/*
+ * Restore the shadow timekeeper from the real timekeeper.
+ */
+static void timekeeping_restore_shadow(struct tk_data *tkd)
+{
+	lockdep_assert_held(&tkd->lock);
+	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
+}
+
 static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
 {
 	lockdep_assert_held(&tkd->lock);
@@ -782,7 +791,7 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)

-- 
2.39.2


