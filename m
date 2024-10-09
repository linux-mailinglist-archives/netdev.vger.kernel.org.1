Return-Path: <netdev+bounces-133528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BEC9962C5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF441F22D5E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855E19066D;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbFCoVzy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxM2Z8Xy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6018EFEE;
	Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=hhyQBHn4VUHY2Mt00SvbFtUbyDe5gDSelxeAKO342W/cUcBiErwtwqplbZCe1fLDv2xDbS+5TfM/LKsY1UF5eYmUb9uYZHcp7paBYvGTl8um+fCKNcksSd8qqNqkyAWz8S0bjIbAf1jKpANWGCAXiHA2WQWo0oBRCjpTkskVrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=XoVZht3tq9m+uvk+V3rIk/CgzvWibAz49VRlt28j31k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oleKk4uigzqTDjjzPPN5Hgdq72vr/RxKC5XiwXviAEhsl5xgRLZ/+2LG4JlYU+9mhvWTM+IpBBWydxGnT47DpiErZ/MpBwgj44jTjw83F833fUlu6YV+HvQjDp92xPlo3ECDqhmcwqpZADSlxjIpKPaRDUXH+5epwYq1OLv8zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbFCoVzy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxM2Z8Xy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqW3zmJXjELGAb9g+xJ2OjtrPdNRM2dHq+mEGEowas=;
	b=BbFCoVzyV/TqIrjEIvLd6bnJyqYUJmfWc8s/wtVTFPUrqdW6iLbkj44VATGbsRYjXuhGbE
	WKJedPjPoz+gLIUbMQMo4egwaa36rv/cy7VS9e/vBXFxqt3nqnVxEldCxizqJLYBfMCJpH
	IC4PMSYSLIPJTGakNnG3jWLMWajoOE83xgel+pHXa2wgvkXay6UNsVEv7+bCC8eWAEYUpq
	FNkGaEu3hAGOa6qxUvzii/Sac/UCHWvdlM73o8zMphoEG5EtiRCh6cgS9oV2drjhfZvlAU
	qaqNHs+sx2oa091ETME/m2jYWl0+auRXks8y1CLpNeC8E4PPJg7ZjobxjFfkzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqW3zmJXjELGAb9g+xJ2OjtrPdNRM2dHq+mEGEowas=;
	b=GxM2Z8XyhHzI7/Dxom3uy6qboysuzOYBEYBt6EbmLC2VvdgOZ/sHrGPvgHJAD3BBkzA7uB
	cWyDPseFg/9TQoDg==
Date: Wed, 09 Oct 2024 10:29:08 +0200
Subject: [PATCH v2 15/25] timekeeping: Provide timekeeping_restore_shadow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-15-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

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
index 5a747afe64b4..41d88f645868 100644
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
2.39.5


