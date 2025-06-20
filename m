Return-Path: <netdev+bounces-199760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FEAE1C0B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97D516C8CF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601928C01C;
	Fri, 20 Jun 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dc4m4j+/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfeo3p7P"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F828E576;
	Fri, 20 Jun 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425875; cv=none; b=RAmFdfBtWrfpna1gsIKUJICwEBfrEvxCIYiRf2Ajtj+VY42JNKFeT553MoEQF38Xvdi+k5VaP6q1jJUwS/iLDPHDVMatYnrtAAe7CwPt8nXBKK0tmlnrbJcDNsSbsotIal0lcqBt+D0XVuMxq8laTW8cuSa5+mBXrhLlc7VQXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425875; c=relaxed/simple;
	bh=4uSa6gwPUParCICWn+l34Lh046IYe02V7OwC7v6mlB0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pyXjU7U3ekE/RFQsUOnCE/EgdS56Jw+jQfR1sSBzhruglPEfeYZ5fyLdz8QoL5NGUY6tKgnAB0TItcNAl8p0FCQgwhiuRNndYNFblAm7jp5ZsB76kCf358zxHVz2zRobRMcwSPRiouf+rckD77OaijaLo8GESzebx5G/ZMa81dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dc4m4j+/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfeo3p7P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131943.842871495@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TAfEr+4WrC24WCfcf0MBVVB3Is+yKhCwqq1vSI7Px4s=;
	b=Dc4m4j+/6yV/Umqw0A9//E+w1S69XgmBI2bUMGROhs4Lft0bAOx/avy+pNiRE7kuJtgm6b
	xyRW/PWXQnvPdIp92MiCO0yLBQGGJM2GdpYNmdra5YzTMrqDkBYJDX+wj/pWfuepkdLwXb
	8xL8lzK4PzvZiX6sSvPlFENoi5bpO18G8UUKIzXqGqdKmOM6HZKb20WsX8UvHChIEBiUrm
	NSyHkFCbQXyEScYmcaphpesq9c3TzqY7C1NgNsJg2aPN9J1Fu2sLIUO9Tn7y9HyqPfbAN9
	XnaHxsW6JYdfpbKHuXzWHeEAvXKqBBRQCZkPP4TWHpAYknt0lKccdp9n916zLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TAfEr+4WrC24WCfcf0MBVVB3Is+yKhCwqq1vSI7Px4s=;
	b=qfeo3p7PZCAeJTt3W4Q4JzUXu0dAuCiC6s6ZVuj9hEUhiiSTU8u9tcfCtUm09sv1X4fT0S
	JSGmqv5C/ZSePrBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 02/13] ptp: Split out PTP_EXTTS_REQUEST ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:29 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_EXTTS_REQUEST
ioctl code into a helper function. Convert to a lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |  105 +++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -177,12 +177,57 @@ static long ptp_clock_getcaps(struct ptp
 	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
 }
 
+static long ptp_extts_request(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
+{
+	struct ptp_clock_request req = { .type = PTP_CLK_REQ_EXTTS };
+	struct ptp_clock_info *ops = ptp->info;
+	unsigned int supported_extts_flags;
+
+	if (copy_from_user(&req.extts, arg, sizeof(req.extts)))
+		return -EFAULT;
+
+	if (cmd == PTP_EXTTS_REQUEST2) {
+		/* Tell the drivers to check the flags carefully. */
+		req.extts.flags |= PTP_STRICT_FLAGS;
+		/* Make sure no reserved bit is set. */
+		if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
+		    req.extts.rsv[0] || req.extts.rsv[1])
+			return -EINVAL;
+
+		/* Ensure one of the rising/falling edge bits is set. */
+		if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
+		    (req.extts.flags & PTP_EXTTS_EDGES) == 0)
+			return -EINVAL;
+	} else {
+		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
+		memset(req.extts.rsv, 0, sizeof(req.extts.rsv));
+	}
+
+	if (req.extts.index >= ops->n_ext_ts)
+		return -EINVAL;
+
+	supported_extts_flags = ptp->info->supported_extts_flags;
+	/* The PTP_ENABLE_FEATURE flag is always supported. */
+	supported_extts_flags |= PTP_ENABLE_FEATURE;
+	/* If the driver does not support strictly checking flags, the
+	 * PTP_RISING_EDGE and PTP_FALLING_EDGE flags are merely hints
+	 * which are not enforced.
+	 */
+	if (!(supported_extts_flags & PTP_STRICT_FLAGS))
+		supported_extts_flags |= PTP_EXTTS_EDGES;
+	/* Reject unsupported flags */
+	if (req.extts.flags & ~supported_extts_flags)
+		return -EOPNOTSUPP;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
+		return ops->enable(ops, &req, req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0);
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
-	unsigned int i, pin_index, supported_extts_flags;
 	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
@@ -192,6 +237,7 @@ long ptp_ioctl(struct posix_clock_contex
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
 	struct ptp_clock_time *pct;
+	unsigned int i, pin_index;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
 	int enable, err = 0;
@@ -210,60 +256,9 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:
-		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
-			err = -EACCES;
-			break;
-		}
-		memset(&req, 0, sizeof(req));
-
-		if (copy_from_user(&req.extts, (void __user *)arg,
-				   sizeof(req.extts))) {
-			err = -EFAULT;
-			break;
-		}
-		if (cmd == PTP_EXTTS_REQUEST2) {
-			/* Tell the drivers to check the flags carefully. */
-			req.extts.flags |= PTP_STRICT_FLAGS;
-			/* Make sure no reserved bit is set. */
-			if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
-			    req.extts.rsv[0] || req.extts.rsv[1]) {
-				err = -EINVAL;
-				break;
-			}
-			/* Ensure one of the rising/falling edge bits is set. */
-			if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
-			    (req.extts.flags & PTP_EXTTS_EDGES) == 0) {
-				err = -EINVAL;
-				break;
-			}
-		} else if (cmd == PTP_EXTTS_REQUEST) {
-			req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
-			req.extts.rsv[0] = 0;
-			req.extts.rsv[1] = 0;
-		}
-		if (req.extts.index >= ops->n_ext_ts) {
-			err = -EINVAL;
-			break;
-		}
-		supported_extts_flags = ptp->info->supported_extts_flags;
-		/* The PTP_ENABLE_FEATURE flag is always supported. */
-		supported_extts_flags |= PTP_ENABLE_FEATURE;
-		/* If the driver does not support strictly checking flags, the
-		 * PTP_RISING_EDGE and PTP_FALLING_EDGE flags are merely
-		 * hints which are not enforced.
-		 */
-		if (!(supported_extts_flags & PTP_STRICT_FLAGS))
-			supported_extts_flags |= PTP_EXTTS_EDGES;
-		/* Reject unsupported flags */
-		if (req.extts.flags & ~supported_extts_flags)
-			return -EOPNOTSUPP;
-		req.type = PTP_CLK_REQ_EXTTS;
-		enable = req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0;
-		if (mutex_lock_interruptible(&ptp->pincfg_mux))
-			return -ERESTARTSYS;
-		err = ops->enable(ops, &req, enable);
-		mutex_unlock(&ptp->pincfg_mux);
-		break;
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
+			return -EACCES;
+		return ptp_extts_request(ptp, cmd, argptr);
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:


