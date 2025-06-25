Return-Path: <netdev+bounces-201101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2EDAE8200
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF411BC4AA0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3425E44D;
	Wed, 25 Jun 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAgR/B8k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="465TyfdJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF525D54E;
	Wed, 25 Jun 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852348; cv=none; b=foprUL2CCHUYU1pyxyBWFSClVePFjQlL/miNtOVMQd6s2qbXDd5aqDom3h5fLdwfM1H4MOoiRPHlGbTWUF37QfLhaEDcpjiY4pxkpXTVnE3fEI2lkg/LBWH3EeS6o88tz47192PpT1O2vyiyRgatsOPjAvVXpoC+w7TSoxrh43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852348; c=relaxed/simple;
	bh=lEHlAvuwHbk61hVLfiINRcEUtVc65saw7z56pWvonJw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jMl1uC1gi0KcwD02v8pigUMGbmP6N9+hL05bTTjtXcLOBhy3eCq83e/j4187XZo2lI1HAGIqga3tGyh7lzSGzn8WqK7zyYJjhVtla/NSGHO2yquJkk+UR5C1ol92eHliqjFRTtgDk54yEm3pOVgKZeA6Lk7qbGB9YubOvtcOt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAgR/B8k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=465TyfdJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115132.733409073@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hJNkfKuEr8uIdjN/w9vrjuqj1MLwRZ4soPhuqfiZj4=;
	b=lAgR/B8kThwn29SezeroF9JCmMsz+7VZ8OVtQaFk4NJv/Pm6Zc36fOzZd1AKIfpi7ztU1s
	pLGyHxbP9mqFqaMbLbDJppNAO4YZahjfGCWs32TcgSF681R3AvoJFoqOc7rvLCEiG4Yj18
	Rg2FfoFpKkpLylAxnKbimU43vGanK549Fjga82zMyFPsdorYgWTIZbymVMokkdA3sT4BNq
	l5fQ2VgZmxU8pQOg/z6NbqhSyGc4pRzO0L1ywg772dzN79i4RwpX9zAFA2O0jRnokTE0+W
	gPdYVC4T0+3ZwS0mp6XSnqJYUITPuTKyRhOlIQ9GvlMK4nlWy9yaPoxkNGCLGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hJNkfKuEr8uIdjN/w9vrjuqj1MLwRZ4soPhuqfiZj4=;
	b=465TyfdJSEJjCKYBPhrnvV2OzzFD1Q4z5NXk9t9AEcuWHy8Dp6VnOpM1QEaD2Y0ZtfTPwd
	0u59mWS0Pn51WBDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 01/13] ptp: Split out PTP_CLOCK_GETCAPS ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:24 +0200 (CEST)

ptp_ioctl() is an inpenetrable letter soup with a gazillion of case (scope)
specific variables defined at the top of the function and pointless breaks
and gotos.

Start cleaning it up by splitting out the PTP_CLOCK_GETCAPS ioctl code into
a helper function. Use a argument pointer with a single sparse compliant
type cast instead of proliferating the type cast all over the place.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

---
 drivers/ptp/ptp_chardev.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -157,6 +157,26 @@ int ptp_release(struct posix_clock_conte
 	return 0;
 }
 
+static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_clock_caps caps = {
+		.max_adj		= ptp->info->max_adj,
+		.n_alarm		= ptp->info->n_alarm,
+		.n_ext_ts		= ptp->info->n_ext_ts,
+		.n_per_out		= ptp->info->n_per_out,
+		.pps			= ptp->info->pps,
+		.n_pins			= ptp->info->n_pins,
+		.cross_timestamping	= ptp->info->getcrosststamp != NULL,
+		.adjust_phase		= ptp->info->adjphase != NULL &&
+					  ptp->info->getmaxphase != NULL,
+	};
+
+	if (caps.adjust_phase)
+		caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
+
+	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -171,37 +191,22 @@ long ptp_ioctl(struct posix_clock_contex
 	struct timestamp_event_queue *tsevq;
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
-	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
 	int enable, err = 0;
+	void __user *argptr;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
+	argptr = (void __force __user *)arg;
 
 	tsevq = pccontext->private_clkdata;
 
 	switch (cmd) {
-
 	case PTP_CLOCK_GETCAPS:
 	case PTP_CLOCK_GETCAPS2:
-		memset(&caps, 0, sizeof(caps));
-
-		caps.max_adj = ptp->info->max_adj;
-		caps.n_alarm = ptp->info->n_alarm;
-		caps.n_ext_ts = ptp->info->n_ext_ts;
-		caps.n_per_out = ptp->info->n_per_out;
-		caps.pps = ptp->info->pps;
-		caps.n_pins = ptp->info->n_pins;
-		caps.cross_timestamping = ptp->info->getcrosststamp != NULL;
-		caps.adjust_phase = ptp->info->adjphase != NULL &&
-				    ptp->info->getmaxphase != NULL;
-		if (caps.adjust_phase)
-			caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
-		if (copy_to_user((void __user *)arg, &caps, sizeof(caps)))
-			err = -EFAULT;
-		break;
+		return ptp_clock_getcaps(ptp, argptr);
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:




