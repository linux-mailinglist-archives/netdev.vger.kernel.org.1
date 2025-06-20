Return-Path: <netdev+bounces-199768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC0AE1C1C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89465A154E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E029DB84;
	Fri, 20 Jun 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMM44mpP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVfFRNuz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3B29C325;
	Fri, 20 Jun 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425886; cv=none; b=lR4izOAevLhW/WVTQDgmeA0GjjQgtj4cyOdbtcYqMREf7HVgScjfvi840bIvXTAlPrS0TrwkzfZWBeu75pUjiS5QEWYPeQmecz19lyCoe66DkMm5MmPLK+G8mh//zF6UM0fLbUHozp2Nb/Hivlm88e7fxP/A8aS/IoM/eGqnUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425886; c=relaxed/simple;
	bh=tD8KcHkGGJjZu7lBwsNaUG+Ryvqhvm7u9NBLinKQndk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=g0PBL3BhidVHwPVNbJsxiqeFp95K0bGgNu/W1fWJ8OMZvJ6kb38E4EaOUL/J0KHtTQcx58IznNFgttJvw1Yxr3HkHllKLTf/sGmYduEUbcZ1/YMkxzQ1suWI+HBMoOfbrq//njx/wmEQcDd3IR0G0dKgZVhyHmxZzTWU7bR/110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMM44mpP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVfFRNuz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.281928614@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o6RvzwrSSybDkGE9Gbix1ouiqfsEbC1375kHUnRbTI0=;
	b=lMM44mpPQTUfT0sFUE+x/lxisq6Sf4irMi5eIOpIXsbXjjSdrdSxXbFWvW6hODVYKiPZrS
	eo8F8W0OqwTg/ZSQ4QGOQXqWYUNFrwn81oGq3tCCp/lV/CyOPEjr/v2npH40qL9wu5i5GN
	wt8Gq/A6cqy4KXYuwrVRKCnm9vcKYVR06BeLV7k4qvUWDVLDIyJ1vA4mEw8S91OU/82LiF
	z52dqH7KRmui8FR4NUGd4do7T2S/H4wI7nqB55/Is7KYsNIbmmrgcR3Uex8PtFflPCTfXJ
	4jDihPwUFQAwcIyI2fV3kIJEf+n/fH2BNRGITASVcfYAxYEqkoZmWrUK6lC6JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o6RvzwrSSybDkGE9Gbix1ouiqfsEbC1375kHUnRbTI0=;
	b=LVfFRNuzCZHs1Ntomr/0OMkg+rm9urFSm+39tsZqXCQ0EanuFu09Q/92K9VELeg15E85ew
	50wQ+6TbNaE/Y6Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 09/13] ptp: Split out PTP_PIN_SETFUNC ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:42 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_SETFUNC ioctl
code into a helper function. Convert to lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   60 +++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -420,16 +420,36 @@ static long ptp_pin_getfunc(struct ptp_c
 	return copy_to_user(arg, &pd, sizeof(pd)) ? -EFAULT : 0;
 }
 
+static long ptp_pin_setfunc(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
+{
+	struct ptp_clock_info *ops = ptp->info;
+	struct ptp_pin_desc pd;
+	unsigned int pin_index;
+
+	if (copy_from_user(&pd, arg, sizeof(pd)))
+		return -EFAULT;
+
+	if (cmd == PTP_PIN_SETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
+		return -EINVAL;
+	else
+		memset(pd.rsv, 0, sizeof(pd.rsv));
+
+	if (pd.index >= ops->n_pins)
+		return -EINVAL;
+
+	pin_index = array_index_nospec(pd.index, ops->n_pins);
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
+		return ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct ptp_clock_info *ops = ptp->info;
 	struct timestamp_event_queue *tsevq;
-	unsigned int i, pin_index;
-	struct ptp_pin_desc pd;
 	void __user *argptr;
+	unsigned int i;
 	int err = 0;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
@@ -479,37 +499,9 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:
-		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
-			err = -EACCES;
-			break;
-		}
-		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
-			err = -EFAULT;
-			break;
-		}
-		if ((pd.rsv[0] || pd.rsv[1] || pd.rsv[2]
-				|| pd.rsv[3] || pd.rsv[4])
-			&& cmd == PTP_PIN_SETFUNC2) {
-			err = -EINVAL;
-			break;
-		} else if (cmd == PTP_PIN_SETFUNC) {
-			pd.rsv[0] = 0;
-			pd.rsv[1] = 0;
-			pd.rsv[2] = 0;
-			pd.rsv[3] = 0;
-			pd.rsv[4] = 0;
-		}
-		pin_index = pd.index;
-		if (pin_index >= ops->n_pins) {
-			err = -EINVAL;
-			break;
-		}
-		pin_index = array_index_nospec(pin_index, ops->n_pins);
-		if (mutex_lock_interruptible(&ptp->pincfg_mux))
-			return -ERESTARTSYS;
-		err = ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
-		mutex_unlock(&ptp->pincfg_mux);
-		break;
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
+			return -EACCES;
+		return ptp_pin_setfunc(ptp, cmd, argptr);
 
 	case PTP_MASK_CLEAR_ALL:
 		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);


