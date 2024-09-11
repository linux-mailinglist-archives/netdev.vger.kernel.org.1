Return-Path: <netdev+bounces-127366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80686975376
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426072871A7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3A1A2655;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACObcXxr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gu01vqI9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAA19E985;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060684; cv=none; b=Nt1QSHmiw8izJZJFYeb2Y/lcGLZBqPQISE40frM9e/bYHf5yyT60FsCRu3doAa7nMERgx0J1gC3wSe2WO2f4Y1Ny0AlSnUTnqR/Md0F6YJVQVotAiA8RXR+Lj1P93qO9ZOVqP8ipujq6SzM8XDfC/P1sPDYX1Wy6Di9vbTGDYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060684; c=relaxed/simple;
	bh=DxyIwMaHDieZQX7yhTkZsEz0L/cwOK2r+4KMCcUTp34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNLIYMImwjDIw3+Ac9AswA9cz8ZBDWyJWiDQ/bQD7FILEAfsAhscODJCQfKdTsWUK22Lsl3jqinJ8+KmqqCPgGQrC4xSS3MVPX+PYrxxIE7tWDH1VtORHj4g1YtB58n65pxsFOdTH6A5nt3z5IYW+Qx0tr3svRogdQZ+tQ1lGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACObcXxr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gu01vqI9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2PJShJDr/Fg/BGDALZOu0lQbepTLwabMWlBkQ3Alb4=;
	b=ACObcXxryO2USimGGyer3fpm6vQHX6CCHJpT9Ut1FNwBFBz8CmwLxqn8wQj+0ldwsYy3Pm
	scaxEB9s4XyaY0DXzF3ym+cSh7EVlVEm26yXVDq3gP647tPWFggu6t+RHydcKnpGMMZOYc
	krX84IYs50bPhS28QRwgZHL+TindZnpTiE/yKszAkTJCTCiITKVlox6rUu5FVJBVjAOT4g
	M6LvIQcpNSsvVlUO4ajRrfR4OKHFGM3E+qT4+isQN3mwWpbYsE6eCiEYUOdZJBw/Y2Q+fD
	pLbnHyHY1GYgFyJViS1IoBOtndKbLu0FwNJWoO9dPzaqEUsFOWL6qwmVbCtZ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2PJShJDr/Fg/BGDALZOu0lQbepTLwabMWlBkQ3Alb4=;
	b=gu01vqI9Byw4mFkdag5m6SLPYo4JsLvtlOlNZOH+eCwSOT5KMSq3LL0sl/q2VoxsVAX3/p
	uMydbqtJ//hkIGDg==
Date: Wed, 11 Sep 2024 15:17:42 +0200
Subject: [PATCH 06/21] ntp: Read reference time only once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

The reference time is required twice in ntp_update_offset(). It will not
change in the meantime as the calling code holds the timekeeper lock. Read
it only once and store it into a local variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index ef758aafdfd5..477cb08062bc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -283,9 +283,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
 
 static void ntp_update_offset(long offset)
 {
-	s64 freq_adj;
-	s64 offset64;
-	long secs;
+	s64 freq_adj, offset64;
+	long secs, real_secs;
 
 	if (!(time_status & STA_PLL))
 		return;
@@ -303,11 +302,12 @@ static void ntp_update_offset(long offset)
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	secs = (long)(__ktime_get_real_seconds() - time_reftime);
+	real_secs = __ktime_get_real_seconds();
+	secs = (long)(real_secs - time_reftime);
 	if (unlikely(time_status & STA_FREQHOLD))
 		secs = 0;
 
-	time_reftime = __ktime_get_real_seconds();
+	time_reftime = real_secs;
 
 	offset64    = offset;
 	freq_adj    = ntp_update_offset_fll(offset64, secs);

-- 
2.39.2


