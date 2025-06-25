Return-Path: <netdev+bounces-201104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA9AE8206
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AC64A0AB5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6F25FA2C;
	Wed, 25 Jun 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jf0QIgpK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQym4/yh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBB25F785;
	Wed, 25 Jun 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852351; cv=none; b=kn6yqN/RcmmjqHYUebJ0+3BMT6pySjZNlTuEhnYW/Dt8BQDAEiJdh5rbvj5MdstnIMqb0hn9Cpm9k3+GhLBgVpWfDlnY9KxWjOZJqJEK0CkCRELkzYT6dPp4iCStmpMMQWVH7RMAb8XDgYZZckZEhooNcJxjrCD/ik9GEfUn66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852351; c=relaxed/simple;
	bh=ljThGdaJ+8bZggRE7W2k4xdtzJ6CJjPgFb/3CnAhV20=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sWECjEGpQK2779OT+Aopsm6bfUqJJUP3IwjRvo67mnihpCCaj3nlxtEoWaeuY5Z2TXgqXJspNJ2LSBJtZS131GzyxY9ntNnCDlfszu2lcdIpFpyJo3xmTgka3H34ttsyLG/mUi3nqMHUwN8K8xmnVVxFZu3RnmP44vEdYIgmT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jf0QIgpK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQym4/yh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115132.923803136@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LridM+GG8/BSv3aEB94gi5KWZc4W8nh2yBSdrgoLmc4=;
	b=jf0QIgpK3HzavIASX2dWzVdo3zyLGOuWK/SxX7iBbkquJljhyMa3wtVaba+YLjHmv79wQ8
	jzUbezi0CxrnKh4ltgjUTB/7Afv+5F/aCCRh2VZiglG0qYm7NJOUBrdUhrMT7GHoWPM5Xl
	SiZYdlZF7LnmKAbIEXb8kif7Ac5huqUHX5E6w1MF9OYA9o/9mg8XmqX4qwKUVvSzFDH8xC
	meVQ8jRHRtJJnfV0PAKy+e4TgGOnGzZHC6QmLYMMI8n43cBWWJSjxkT1+4qjZNFvuJEoLS
	Ey+hWDhFm9uNNzd9jPGy213gIoaK0+WQy59BD60Y1tdhxxdk87hnkQN+SgGy4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LridM+GG8/BSv3aEB94gi5KWZc4W8nh2yBSdrgoLmc4=;
	b=kQym4/yhpWSp9fW1c8vDiLtAvPfwqdRGmAZiDGQDHffMQNtqzO/3HgS4nMc4bOzZ1FjBJ9
	5sE5kehAlFZFzKCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 04/13] ptp: Split out PTP_ENABLE_PPS ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:28 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_ENABLE_PPS
ioctl code into a helper function. Convert to a lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

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




