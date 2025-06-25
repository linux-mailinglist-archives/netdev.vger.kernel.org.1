Return-Path: <netdev+bounces-201301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E1AE8CB3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCF4A5DC6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089D2E173E;
	Wed, 25 Jun 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h+RFuY3I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/+u3PQoh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4792E11D1;
	Wed, 25 Jun 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876730; cv=none; b=quQwpu6yhusF9opyBR1HSEhSkzerrqlpMnrR1Y3cHKj7gJYYHGEDRbLH5Op+qMgVYwhjiucvfAALrZi+Ajh3vw4jnIdeWwjMmKvDZSsXBrqI/Q1qG5lJIPH/BifsdJuCIdOiJZvZMCSHgBIGGGiFwJeuQoH+upFeuQ7+JV7l4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876730; c=relaxed/simple;
	bh=zVJf+MmEC3btYGKcyJeAPT+oFJj0a7vjbezGTwNcPH0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=vA/Yrrxj+HQOWSHkKIrubTVdeFlwUgpd0kiG+F2+ajEXMs84Gk8YAACWJ60r3TCqinSO6KMqt89opDH01+jGOaop9Rn7t4RELZV+9fBF7rWiWyfDFdsF1UncXSeMmxBlqUNASQqERkUYDZGjb5V/T5vTks7QNajHyzV/v/eh4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h+RFuY3I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/+u3PQoh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.317946543@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8ViF+rrLWVVG0MZcV0fafeyznX+ujEDD9BAyqdiPByg=;
	b=h+RFuY3IPFntsBRJwpsBt3oclBiNNWduh3GRIsa3lTE3OAJUwkw/pTqA+pOtIe4jZkTNZo
	JxwIDBKWpwbbrEJD9x6NP+gGFsBh5AwNegtJaNtqHaWbFU/+8Uync6EFNzZLnp8Uodpj5Y
	eoBdS+L2Sn0Z3308opRcKL//94Ae4HImcD3e5yCC3bLA0P7mdtixKhhaYVj1BLjuuwS4sy
	tKMTQ983Uq3IdJWyfI52oDkkAm4E7Etiv+yw+ULnCERe5/O1zaUNo/ICN82PXBcYZnRaR0
	LYJh5WgCjakzmlJhmoCvvURaSn7YbDZ5hhW2J40vEFN4Zy1+6i715BLsgnmYmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8ViF+rrLWVVG0MZcV0fafeyznX+ujEDD9BAyqdiPByg=;
	b=/+u3PQoh5dlc7OOWzjTMReCdVQDGqzeNG7dqERO2V90MCWGtYHl0k6ZWVbm96n0wAU6pEf
	QR1UysI9NI/vitDg==
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
Subject: [patch V3 09/11] timekeeping: Provide adjtimex() for auxiliary clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:46 +0200 (CEST)

The behaviour is close to clock_adtime(CLOCK_REALTIME) with the
following differences:

  1) ADJ_SETOFFSET adjusts the auxiliary clock offset
  
  2) ADJ_TAI is not supported

  3) Leap seconds are not supported

  4) PPS is not supported

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2860,10 +2860,26 @@ static int aux_clock_set(const clockid_t
 	return 0;
 }
 
+static int aux_clock_adj(const clockid_t id, struct __kernel_timex *txc)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
+	struct adjtimex_result result = { };
+
+	if (!tkd)
+		return -ENODEV;
+
+	/*
+	 * @result is ignored for now as there are neither hrtimers nor a
+	 * RTC related to auxiliary clocks for now.
+	 */
+	return __do_adjtimex(tkd, txc, &result);
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
 	.clock_set		= aux_clock_set,
+	.clock_adj		= aux_clock_adj,
 };
 
 static __init void tk_aux_setup(void)




