Return-Path: <netdev+bounces-201109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB76AE820F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDBF1BC78B3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30A263F41;
	Wed, 25 Jun 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/AG0eaF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kW6tp4+R"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521E262FCC;
	Wed, 25 Jun 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852357; cv=none; b=ugw+YiqnJApbP49pQUvQAHJeh1znhpYku4uXDh3TEgAMOOkZy4xu/NHmgKYanqkyDXc35LoaNOHs5MCG8jdpO6eLstGDlKEvKeUhqAZpAKMx7wmPi3YpqhmvOxiBUYR4WamxzNsFxdMobiASMMl3wLVoiKcSKZYnxaCi1/DL9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852357; c=relaxed/simple;
	bh=JgQmZjayHA4nis9xsH9Vpm8EGU/ElGgS7KAeN5OHtMY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YZOD1An4DEvJpMy+n+i+dOs/FpiBaLVcNTbRtHaW7utiHFom0Thfvh8xqLXiyKztPjPoEoYUHSUMMFLRjCynhU6QR8hx2hXw71sCQlYSxH7QM31GngQRGziXRxa4l0qoQga4hO0eCXaTHzVzkpAxV5G+JYR5eaQH35Drgt3HMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/AG0eaF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kW6tp4+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.241503804@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A70BpkOR1z+kUW7AHjZf3UbavxO72tSUInvKStMocow=;
	b=L/AG0eaFc4NOeCLCnhC93+jHoMW5EQPjx92JUAc9eH2G2DSvryjOgC7/z/RMj5Z1JSHOx0
	3x7YovS45wrxiodXLc2hfYwHHDj8rqWodI1BqVDg4YkkQRc/An8UhHYdPP2Vv2K5AXaX77
	AH3Cnt9vtT0oBX/nLPj01VY4R46fL4gy3zyd33/+VMRWotLw6HlUe51BmdwEmCtH72iTHK
	jHFQgh4/CJivnl/3kyuuCf+zpvhW0pMRhDNJSdSEbgU6KlkC5RaeNdlxiSIn3s/NP26EUe
	htm+5uWmfqFyQ4SdXrbwLYNsfGmUTpX80ivTuwrNstV5DMxZDQvRJxbeiz+QoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A70BpkOR1z+kUW7AHjZf3UbavxO72tSUInvKStMocow=;
	b=kW6tp4+ROO+iLQjc/J6WU8/Mmh6IAjFRaEiSGf6qHYOgAkb/Z7tdhLBSmhqnq0vDlMLwpz
	md8xHCi9EcoRbEAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 09/13] ptp: Split out PTP_PIN_SETFUNC ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:34 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_SETFUNC ioctl
code into a helper function. Convert to lock guard while at it and remove
the pointless memset of the pd::rsv because nothing uses it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
V2: Remove the pointless memset() - Paolo
---
 drivers/ptp/ptp_chardev.c |   58 +++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -415,16 +415,34 @@ static long ptp_pin_getfunc(struct ptp_c
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
@@ -474,37 +492,9 @@ long ptp_ioctl(struct posix_clock_contex
 
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


