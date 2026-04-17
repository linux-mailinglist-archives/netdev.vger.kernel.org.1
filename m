Return-Path: <netdev+bounces-279397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCgJFmxz4mm86AAAu9opvQ
	(envelope-from <netdev+bounces-279397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:52:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BADA41DB2A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C2CB301CAA9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D117372EED;
	Fri, 17 Apr 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb7gL7dB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84A30EF7C
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448189; cv=none; b=hObCDToMcENDc1stXuDFBEQ+Ypg0g0JxkemSz+q+mOr0I869G2d5HkI6G3pU4BOboGEsyY8zAbhk4a9AxSEys7i6kEP0Jrq2SIacucyjnSWFRL8zYA/nrQfjrv+nGR98PfXwr/Wjl1fnEtgtNammGkEoLKJUChkdszJt7x50P8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448189; c=relaxed/simple;
	bh=dxnH0f5C5Vn18aTsHsoy3uUPp2cDYyJJW1cVCZr+sro=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=XFExupwrpASVD6Fv+7RMpbGlsNcrspRJfR/YMRXDW0INLTWNZEyMJYnFea9ApaCQVPXjgK0hemEx85h4q2tmmFZQuuDShMKGg6MrSIQEsFTD4e/xk50+Zd/8tfQEjUeRlMrYXrT/vEVxWrnXmslEbogkoJFhwHNz38paVubgq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sb7gL7dB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so485113b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448176; x=1777052976; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/7hfAHCRrvVYNg45OT8U1RufNMowjZzViktq3xYVPo=;
        b=sb7gL7dBJnUW4Xlud/oagSHBKUQLFXZ8OxpAN6mSvVNijq588pQBqpk9r+HodKNSiK
         P0avMcvzkzGTac4jcDbA+GrHubIuW6KdE7bJmS7S8Ace6Pw6TlZOWEebhIXsT1o39FMw
         g4K9e9ab8BlbG7h4SyyzIquaOtl/xt32SWYIzgfYXOipCTsS4Bbfg/JareZYpXOUYoKh
         bKgO9cIlNMaKqbGXgHoIckIWx3Pe6SLxm0eBONVW/MO7intpK9j/gHmmfuvRiGTHFN67
         MD6IIlodiF7G2sRCZankcaGfrPnTBJkf1s4DBoIB9pK8pSSIcYQWAeVHI3qZZvrezdg0
         4GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448176; x=1777052976;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/7hfAHCRrvVYNg45OT8U1RufNMowjZzViktq3xYVPo=;
        b=L5XPYQK62IWShgbCI1zKwQwP3X0g4CfI6jCEwmYufGpTtPjl7QkJ8kYig4ZjR/A3G3
         Lqz2p0D+Q31eet7i+x+0T977W4vjXqmEWPxuFwfTavpGZDnug4vD5bQP9x9yU+MY1wlN
         E32t125wvA7e0PEOSJzemYMaMw+mBjwCs3ajVpGh0vuDq+EsndaYOPFQc6IUTaksWsfF
         Z4TXF7VnX4UU5vuclHsxCkSUbc/cTi5PWT2GS/KgfaHYixrSpq1/BOYH1zOTxqSPW1Rk
         tG6HvVrv46UFBdmAEIjPdDtK8oAlgdk8uRDpbhL8mw4VYeI7sQR5FSFNnpUP7LiJI8/s
         Ug4g==
X-Gm-Message-State: AOJu0YxzSgkKWnAAfRsIQN07UkKeM95/b35NoAFuM7qF8vfqkHEe3Rci
	rOiZDvYH3ua4OpK+uCLpztD2G7bQLrRiUfW/fCvFwT5ecdVpCMWbTSWVjCF2Nw==
X-Gm-Gg: AeBDievVqGNDuwlvctXJUIEO25iEHNQPzDDGuKAq5Nitpzi3N1815X3uKb6r5y2u8qN
	VomuaEpsxWiI7+Sx/hFCsFrOqzuYJ7A627ui2e8IPQX+2SeP3jR2vLkMNOCyQezspoBZ0slamHE
	xby9us80KC1I3giG3yiW7mTGHsncPeKf7uH3XKtMkBRGfLJI+BbZzK4BKVFP0+GLrhuus1FuvSk
	SUCQgwUwXjxXGlDr8emQHsHQmZ68DxG99MH3j3JBkpSdlttP+R66/dqNwWmklopyI5T5cyyYd98
	nos3i8wbTWfmIskS7osx5bUa2/jFdQDHVKull955t4cNXhKzQwGQM+fcWbIfDKXv1E+HX+GpAau
	VgdPeVOBT+VKTYHTaT+3WaXviK3eI3x2mEJ6rudogfLm2jAf7d4ciw9nUz6F6nl58AeP/6SDYyH
	V6dErIzWvnXh1G4UnaxiLHC+8WGj+r9RgXzZew6OMlxspWHmzhy0nTL2JSTjKckFPE2jWK/NQWf
	QbrG/vNS6fgEqlyWjekpS35iCw=
X-Received: by 2002:a05:6a00:3028:b0:82f:6640:7229 with SMTP id d2e1a72fcca58-82f8c91c9femr4140755b3a.23.1776448176202;
        Fri, 17 Apr 2026 10:49:36 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([43.245.86.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec23b19sm2949913b3a.59.2026.04.17.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:49:35 -0700 (PDT)
Message-ID: <4216b149341fb2f38449e33bd7a14fa76b87aec9.1776446840.git.shuvampandey1@gmail.com>
In-Reply-To: <cover.1776446840.git.shuvampandey1@gmail.com>
References: <cover.1776446840.git.shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 17 Apr 2026 23:34:25 +0545
Subject: [PATCH v2 3/3] mISDN: cache stable device names outside the kobject
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279397-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[di.name:url,dn.id:url,dn.name:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BADA41DB2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mISDN prints and exports device names from several paths that are not tied
to the kobject rename internals. device_rename() replaces the kobject name
string, so reading it directly leaves mISDN dependent on that storage
remaining stable while those paths run.

Keep an mISDN-owned copy of the device name, update it on registration and
successful rename, and use that cached name from the socket, sysfs, stack,
and debug paths.

Assisted-by: Codex:GPT-5.3-Codex
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/isdn/mISDN/core.c   | 18 +++++++++++++-----
 drivers/isdn/mISDN/layer1.c |  2 +-
 drivers/isdn/mISDN/socket.c | 12 ++++++++----
 drivers/isdn/mISDN/stack.c  | 36 ++++++++++++++++++------------------
 drivers/isdn/mISDN/tei.c    |  2 +-
 include/linux/mISDNif.h     |  1 +
 6 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index 4e2be8f03119b..d89c9e54cb5fa 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -89,8 +89,15 @@ static DEVICE_ATTR_RO(protocol);
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	strcpy(buf, dev_name(dev));
-	return strlen(buf);
+	struct mISDNdevice *mdev = dev_to_mISDN(dev);
+	ssize_t len;
+
+	if (!mdev)
+		return -ENODEV;
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s", mdev->name);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RO(name);
 
@@ -227,9 +234,10 @@ mISDN_register_device(struct mISDNdevice *dev,
 		dev_set_name(&dev->dev, "%s", name);
 	else
 		dev_set_name(&dev->dev, "mISDN%d", dev->id);
+	strscpy(dev->name, dev_name(&dev->dev), sizeof(dev->name));
 	if (debug & DEBUG_CORE)
 		printk(KERN_DEBUG "mISDN_register %s %d\n",
-		       dev_name(&dev->dev), dev->id);
+		       dev->name, dev->id);
 	dev->dev.class = &mISDN_class;
 
 	err = create_stack(dev);
@@ -258,7 +266,7 @@ void
 mISDN_unregister_device(struct mISDNdevice *dev) {
 	if (debug & DEBUG_CORE)
 		printk(KERN_DEBUG "mISDN_unregister %s %d\n",
-		       dev_name(&dev->dev), dev->id);
+		       dev->name, dev->id);
 	/* sysfs_remove_link(&dev->dev.kobj, "device"); */
 	/*
 	 * Remove the device from sysfs before taking dev->mutex so bind-side
@@ -358,7 +366,7 @@ const char *mISDNDevName4ch(struct mISDNchannel *ch)
 		return msg_no_stack;
 	if (!ch->st->dev)
 		return msg_no_stackdev;
-	return dev_name(&ch->st->dev->dev);
+	return ch->st->dev->name;
 };
 EXPORT_SYMBOL(mISDNDevName4ch);
 
diff --git a/drivers/isdn/mISDN/layer1.c b/drivers/isdn/mISDN/layer1.c
index 3fbc170acf9ab..c5a2e9119e868 100644
--- a/drivers/isdn/mISDN/layer1.c
+++ b/drivers/isdn/mISDN/layer1.c
@@ -100,7 +100,7 @@ l1m_debug(struct FsmInst *fi, char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &va;
 
-	printk(KERN_DEBUG "%s: %pV\n", dev_name(&l1->dch->dev.dev), &vaf);
+	printk(KERN_DEBUG "%s: %pV\n", l1->dch->dev.name, &vaf);
 
 	va_end(va);
 }
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 42cda5b8bbe16..bce71ae5eb7d4 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -499,7 +499,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
+			strscpy(di.name, dev->name, sizeof(di.name));
 			device_unlock(&dev->dev);
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
@@ -826,7 +826,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
+			strscpy(di.name, dev->name, sizeof(di.name));
 			device_unlock(&dev->dev);
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
@@ -846,10 +846,14 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		dev = get_mdevice(dn.id);
 		if (dev) {
 			device_lock(&dev->dev);
-			if (!device_is_registered(&dev->dev))
+			if (!device_is_registered(&dev->dev)) {
 				err = -ENODEV;
-			else
+			} else {
 				err = device_rename(&dev->dev, dn.name);
+				if (!err)
+					strscpy(dev->name, dev_name(&dev->dev),
+						sizeof(dev->name));
+			}
 			device_unlock(&dev->dev);
 			put_device(&dev->dev);
 		} else {
diff --git a/drivers/isdn/mISDN/stack.c b/drivers/isdn/mISDN/stack.c
index 4e96684af0aac..9b39ddb4a0944 100644
--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -165,7 +165,7 @@ send_msg_to_layer(struct mISDNstack *st, struct sk_buff *skb)
 		else
 			printk(KERN_WARNING
 			       "%s: dev(%s) prim(%x) id(%x) no channel\n",
-			       __func__, dev_name(&st->dev->dev), hh->prim,
+			       __func__, st->dev->name, hh->prim,
 			       hh->id);
 	} else if (lm == 0x8) {
 		WARN_ON(lm == 0x8);
@@ -175,12 +175,12 @@ send_msg_to_layer(struct mISDNstack *st, struct sk_buff *skb)
 		else
 			printk(KERN_WARNING
 			       "%s: dev(%s) prim(%x) id(%x) no channel\n",
-			       __func__, dev_name(&st->dev->dev), hh->prim,
+			       __func__, st->dev->name, hh->prim,
 			       hh->id);
 	} else {
 		/* broadcast not handled yet */
 		printk(KERN_WARNING "%s: dev(%s) prim %x not delivered\n",
-		       __func__, dev_name(&st->dev->dev), hh->prim);
+		       __func__, st->dev->name, hh->prim);
 	}
 	return -ESRCH;
 }
@@ -202,7 +202,7 @@ mISDNStackd(void *data)
 	sigfillset(&current->blocked);
 	if (*debug & DEBUG_MSG_THREAD)
 		printk(KERN_DEBUG "mISDNStackd %s started\n",
-		       dev_name(&st->dev->dev));
+		       st->dev->name);
 
 	if (st->notify != NULL) {
 		complete(st->notify);
@@ -238,7 +238,7 @@ mISDNStackd(void *data)
 					printk(KERN_DEBUG
 					       "%s: %s prim(%x) id(%x) "
 					       "send call(%d)\n",
-					       __func__, dev_name(&st->dev->dev),
+					       __func__, st->dev->name,
 					       mISDN_HEAD_PRIM(skb),
 					       mISDN_HEAD_ID(skb), err);
 				dev_kfree_skb(skb);
@@ -281,7 +281,7 @@ mISDNStackd(void *data)
 						     mISDN_STACK_ACTION_MASK));
 		if (*debug & DEBUG_MSG_THREAD)
 			printk(KERN_DEBUG "%s: %s wake status %08lx\n",
-			       __func__, dev_name(&st->dev->dev), st->status);
+			       __func__, st->dev->name, st->status);
 		test_and_set_bit(mISDN_STACK_ACTIVE, &st->status);
 
 		test_and_clear_bit(mISDN_STACK_WAKEUP, &st->status);
@@ -296,17 +296,17 @@ mISDNStackd(void *data)
 #ifdef MISDN_MSG_STATS
 	printk(KERN_DEBUG "mISDNStackd daemon for %s proceed %d "
 	       "msg %d sleep %d stopped\n",
-	       dev_name(&st->dev->dev), st->msg_cnt, st->sleep_cnt,
+	       st->dev->name, st->msg_cnt, st->sleep_cnt,
 	       st->stopped_cnt);
 	task_cputime(st->thread, &utime, &stime);
 	printk(KERN_DEBUG
 	       "mISDNStackd daemon for %s utime(%llu) stime(%llu)\n",
-	       dev_name(&st->dev->dev), utime, stime);
+	       st->dev->name, utime, stime);
 	printk(KERN_DEBUG
 	       "mISDNStackd daemon for %s nvcsw(%ld) nivcsw(%ld)\n",
-	       dev_name(&st->dev->dev), st->thread->nvcsw, st->thread->nivcsw);
+	       st->dev->name, st->thread->nvcsw, st->thread->nivcsw);
 	printk(KERN_DEBUG "mISDNStackd daemon for %s killed now\n",
-	       dev_name(&st->dev->dev));
+	       st->dev->name);
 #endif
 	test_and_set_bit(mISDN_STACK_KILLED, &st->status);
 	test_and_clear_bit(mISDN_STACK_RUNNING, &st->status);
@@ -397,15 +397,15 @@ create_stack(struct mISDNdevice *dev)
 	newst->own.recv = mISDN_queue_message;
 	if (*debug & DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: st(%s)\n", __func__,
-		       dev_name(&newst->dev->dev));
+		       newst->dev->name);
 	newst->notify = &done;
 	newst->thread = kthread_run(mISDNStackd, (void *)newst, "mISDN_%s",
-				    dev_name(&newst->dev->dev));
+				    newst->dev->name);
 	if (IS_ERR(newst->thread)) {
 		err = PTR_ERR(newst->thread);
 		printk(KERN_ERR
 		       "mISDN:cannot create kernel thread for %s (%d)\n",
-		       dev_name(&newst->dev->dev), err);
+		       newst->dev->name, err);
 		delete_teimanager(dev->teimgr);
 		kfree(newst);
 	} else
@@ -424,7 +424,7 @@ connect_layer1(struct mISDNdevice *dev, struct mISDNchannel *ch,
 
 	if (*debug &  DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: %s proto(%x) adr(%d %d %d %d)\n",
-		       __func__, dev_name(&dev->dev), protocol, adr->dev,
+		       __func__, dev->name, protocol, adr->dev,
 		       adr->channel, adr->sapi, adr->tei);
 	switch (protocol) {
 	case ISDN_P_NT_S0:
@@ -461,7 +461,7 @@ connect_Bstack(struct mISDNdevice *dev, struct mISDNchannel *ch,
 
 	if (*debug &  DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: %s proto(%x) adr(%d %d %d %d)\n",
-		       __func__, dev_name(&dev->dev), protocol,
+		       __func__, dev->name, protocol,
 		       adr->dev, adr->channel, adr->sapi,
 		       adr->tei);
 	ch->st = dev->D.st;
@@ -517,7 +517,7 @@ create_l2entity(struct mISDNdevice *dev, struct mISDNchannel *ch,
 
 	if (*debug &  DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: %s proto(%x) adr(%d %d %d %d)\n",
-		       __func__, dev_name(&dev->dev), protocol,
+		       __func__, dev->name, protocol,
 		       adr->dev, adr->channel, adr->sapi,
 		       adr->tei);
 	rq.protocol = ISDN_P_TE_S0;
@@ -570,7 +570,7 @@ delete_channel(struct mISDNchannel *ch)
 	}
 	if (*debug & DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: st(%s) protocol(%x)\n", __func__,
-		       dev_name(&ch->st->dev->dev), ch->protocol);
+		       ch->st->dev->name, ch->protocol);
 	if (ch->protocol >= ISDN_P_B_START) {
 		if (ch->peer) {
 			ch->peer->ctrl(ch->peer, CLOSE_CHANNEL, NULL);
@@ -623,7 +623,7 @@ delete_stack(struct mISDNdevice *dev)
 
 	if (*debug & DEBUG_CORE_FUNC)
 		printk(KERN_DEBUG "%s: st(%s)\n", __func__,
-		       dev_name(&st->dev->dev));
+		       st->dev->name);
 	if (dev->teimgr)
 		delete_teimanager(dev->teimgr);
 	if (st->thread) {
diff --git a/drivers/isdn/mISDN/tei.c b/drivers/isdn/mISDN/tei.c
index 2bad3083be901..876c1194920ef 100644
--- a/drivers/isdn/mISDN/tei.c
+++ b/drivers/isdn/mISDN/tei.c
@@ -990,7 +990,7 @@ create_teimgr(struct manager *mgr, struct channel_req *crq)
 
 	if (*debug & DEBUG_L2_TEI)
 		printk(KERN_DEBUG "%s: %s proto(%x) adr(%d %d %d %d)\n",
-		       __func__, dev_name(&mgr->ch.st->dev->dev),
+		       __func__, mgr->ch.st->dev->name,
 		       crq->protocol, crq->adr.dev, crq->adr.channel,
 		       crq->adr.sapi, crq->adr.tei);
 	if (crq->adr.tei > GROUP_TEI)
diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
index ce26d70c1ebfb..79f6d8f218b13 100644
--- a/include/linux/mISDNif.h
+++ b/include/linux/mISDNif.h
@@ -497,6 +497,7 @@ struct mISDNdevice {
 	u_int			Bprotocols;
 	u_int			nrbchan;
 	u_char			channelmap[MISDN_CHMAP_SIZE];
+	char			name[MISDN_MAX_IDLEN];
 	struct list_head	bchannels;
 	struct mISDNchannel	*teimgr;
 	struct completion	released;
-- 
2.50.1 (Apple Git-155)


