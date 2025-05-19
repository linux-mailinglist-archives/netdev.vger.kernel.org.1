Return-Path: <netdev+bounces-191419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB1ABB76B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CF817A0B0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957F270553;
	Mon, 19 May 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyCJknbi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D8Ck+jKI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE22701CF;
	Mon, 19 May 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643614; cv=none; b=Q0UaVytRM7269C7CU9fzc4A8hlmi0H9uHj0zAvNN34ilvJtnzTuE/+HIapBWOD4OX48MDGxPvsl/MbXMIFv2SlKs+OBinjyCpyWqa+NyVhRvijwuu0xaRkri5MvGYQBtso0JMPNCxTIw/w90ECf9w/Mc/LJ3H8ijR8DsxHvGsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643614; c=relaxed/simple;
	bh=PFTKjntnYzQGNP+r1AaA3SG71QP/EDqas/WFTRwWtu8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=TsXUgg47NWrSt8Tzv/IAgUCVcc4dLGD54yjnjhSY5oIYRAfBxZ7C6C+oDxa9nE9vti85DXMgXM0swj3tWjv2kj1/KUf/KV9mAA9ZdSpfLt/W1/L8DWd9q9Z6GKHFQZZPVrfNGCX54zrYcYwrBAGIcu7jcyz0eh3h5tdJBFE9Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyCJknbi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D8Ck+jKI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.472512636@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9QsTzgHBJ42Ub04898XgpgHcyA6q4XFW9DFcftyvhXU=;
	b=jyCJknbipGhq0WYF9kbQEZInAVrWqqTybWVxaxUU3++la/wJ7sLxe9iCSiFq7EydiMz41r
	oSw4ecJ9boJMsAUPUtvODZM/H8OvxH5iysRAZ+JLk3nPTFzUuW+glCsJZ6PUcEpZCs1teO
	qD1RG1gboLnDkVGHgYX69QwTW3VBJevyK+zN5avbf6ubKIZxfvUAfuNG9ZfZNrNmVPR4Hv
	TvOvZJftLxvfXi38HnnMNfcsWSGEo0O2uHVHgpW/c5ApfSpkGWL8jGzYq2KrpqkmbbBMg7
	RD59CH20Usep82I0Fkozxd/mUSA8h26bkKHoo7hAFK2CYWzZw0NXDNYcT7NDnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9QsTzgHBJ42Ub04898XgpgHcyA6q4XFW9DFcftyvhXU=;
	b=D8Ck+jKIrRW+Vf1dowxd3rPU0L3o/MzezbyxFwVtp+OskRxAnezubNYVH4CPPmW3JBQgD4
	OZ7Mk7aeqUIKXVDQ==
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
Subject: [patch V2 14/26] ntp: Use ktime_get_ntp_seconds()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:31 +0200 (CEST)

Use ktime_get_ntp_seconds() to prepare for auxiliary clocks so that
the readout becomes per timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -303,7 +303,7 @@ static void ntp_update_offset(struct ntp
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	real_secs = __ktime_get_real_seconds();
+	real_secs = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 	secs = (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
@@ -710,7 +710,7 @@ static inline void process_adj_status(st
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		ntpdata->time_reftime = __ktime_get_real_seconds();
+		ntpdata->time_reftime = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 
 	/* only set allowed bits */
 	ntpdata->time_status &= STA_RONLY;


