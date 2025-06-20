Return-Path: <netdev+bounces-199762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDF3AE1C0F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBC41C20C23
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C698293C62;
	Fri, 20 Jun 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiB6hqbu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMaBQy2l"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7128F52D;
	Fri, 20 Jun 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425877; cv=none; b=UmO+1Fv1a1wTJyC6dIxJuhqy2qNyd4S7DzyPU/cSGEprGTaiuN8XEnAAHOW9MYEJrSuawd/F5qjVbxm71iBv43VJTkjCYHhYpl64n01Bwc6QBeYSOlAIahb3x7qgaxrwF4QSGrsVfLgFKJM7aWkAbYY22IYO2DWjqDjKaSJl1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425877; c=relaxed/simple;
	bh=1ffvVUtDslZFgqARFdSMUvwAUQoQaUnI+ZvOogB8ab0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ksvg8gb+ToN73W7lCo3s5Z7JI3LCoOXu6HQyUhqdjABKUfrsPDVE7z4CNHe0x0y19h9r+kuYFl0VHS/ugXDBZKkTqfYvEq96k0PFNZEgeWgUQat9SvpILQxwgHTlRQySDqV171xJyFtss85N/K0E9oLPPYFtcwK/x+vXeUikB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiB6hqbu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMaBQy2l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131943.967761848@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aMKIuxOkpXMVYGZJ5jyLUcRi2op3oUU+5LAHlOiOAbI=;
	b=hiB6hqbuFB7BENlFQv7JtIVPsDQoynenuxk971GW4g4+1Hd39gpahTf2qMqOrX+NTTKXuA
	htFr4QezvzDuI9eKYSx5WywqUi5TJDjoe69puBrRmUWFK+wRboYNxqfafWwN3fahDAjQJM
	9dSHDx9cT+8SJ8+Cu4la2abG2EBPIuPUUpJThJ74uFEcVEfjZYwp98qPGhlLqHwi5MsT/H
	6kWjbTylxXKP8KsQpz0Pnj6omY6ikJy67ui9T6leLk4SK9Bz/75xbyvRETngMc1IZZLd0G
	PCk9Dnf9lsJ72FWWND7zk+jC1fW/8NhT981X32V/NXpskXarlIgXPwv43TFlvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aMKIuxOkpXMVYGZJ5jyLUcRi2op3oUU+5LAHlOiOAbI=;
	b=fMaBQy2lHnpSEOQeBFC6zc8CzJXhX1mwr3xTd33RqC0K1MrR0g5lLFrB3XRd5YTfPlFwSI
	3eNKojRKrwyHXdCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 04/13] ptp: Split out PTP_ENABLE_PPS ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:32 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_ENABLE_PPS
ioctl code into a helper function. Convert to a lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -278,6 +278,18 @@ static long ptp_perout_request(struct pt
 		return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
 }
 
+static long ptp_enable_pps(struct ptp_clock *ptp, bool enable)
+{
+	struct ptp_clock_request req = { .type = PTP_CLK_REQ_PPS };
+	struct ptp_clock_info *ops = ptp->info;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
+		return ops->enable(ops, &req, enable);
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -290,13 +302,12 @@ long ptp_ioctl(struct posix_clock_contex
 	struct ptp_sys_offset *sysoff = NULL;
 	struct timestamp_event_queue *tsevq;
 	struct ptp_system_timestamp sts;
-	struct ptp_clock_request req;
 	struct ptp_clock_time *pct;
 	unsigned int i, pin_index;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
-	int enable, err = 0;
 	void __user *argptr;
+	int err = 0;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
@@ -323,21 +334,9 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:
-		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
-			err = -EACCES;
-			break;
-		}
-		memset(&req, 0, sizeof(req));
-
-		if (!capable(CAP_SYS_TIME))
-			return -EPERM;
-		req.type = PTP_CLK_REQ_PPS;
-		enable = arg ? 1 : 0;
-		if (mutex_lock_interruptible(&ptp->pincfg_mux))
-			return -ERESTARTSYS;
-		err = ops->enable(ops, &req, enable);
-		mutex_unlock(&ptp->pincfg_mux);
-		break;
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
+			return -EACCES;
+		return ptp_enable_pps(ptp, !!arg);
 
 	case PTP_SYS_OFFSET_PRECISE:
 	case PTP_SYS_OFFSET_PRECISE2:


