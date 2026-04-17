Return-Path: <netdev+bounces-279395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOv7Ci5z4mnR5wAAu9opvQ
	(envelope-from <netdev+bounces-279395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:51:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367441DB1A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A30C7303FFC5
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F53B0AD6;
	Fri, 17 Apr 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGtbU6uU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67C284B4F
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448182; cv=none; b=AgBix5OhzsV0MXoREd8z5tc2Yp+xoI1A1wylH4sLc1bhSG3+/ghPp3/BlN48F82FBzLGU8k+6KBxNUXs8yK4RJ7cNKQUCvJeD2RblrZyGkWAk0qCnd+wb7tOsEt16jwfaY5molvMjoQZGzJyDegZAfSHrcaVWD8rXb9KVDBEo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448182; c=relaxed/simple;
	bh=qxM9bpCmMiF5eDc0K+meOikWZg8RKK5rCaP1HFtecsQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=qcqRgVJJEDh1Wniku9mpEyvAvECcRYWAmanZx409pGsNEAa/oEWALc6PW1gzOGmefd2wX2RRJDp5qkq69ZYytpjKpfDrOxAdADjTQJ+04lET/CFLAQNIX0YN3Q8oXhvdakJSG3DaE12rU4jthCtJzfi+/Tlvolt9dLCwhpRmXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGtbU6uU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c79467f128cso396723a12.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448172; x=1777052972; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/po+Uq8euEh6kzAO45zsbl+c3h2HuH6D7bjBdGNC0M=;
        b=RGtbU6uUwgA7fCsN2QSxugINgavDkyaiWngMqgSlKMUbxeke3oSzEC3h7YdB1Q9Jzj
         hg+NQDF3TSau6TuESYdAw90U+FUtXUO+CMIsR8u3i7RfrsGmIlB2+tfYaefQhGshkLwN
         OgK3EC53OjdDV+oUSnX6+fLEQNlpGnucUEwKb8INFKl1W8rjOS+xDCpGKevyOjywHnHy
         K+blXp7cgDmee5Ub8xjMcKPEer2c+B9YCHxYoNKlEaJsbRm2rpz5JtWhWJ1UD1p4DE+j
         /tnJnGcd5P5XpwD6sa/epg6fOdEX7gBZwd4W3xgefoN+EGHd+jgDPiLvF5K7PQue3OyQ
         AxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448172; x=1777052972;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/po+Uq8euEh6kzAO45zsbl+c3h2HuH6D7bjBdGNC0M=;
        b=lW+J5HFL51onFwLMyk2lGyFyXUj/Z6jE0qhL4PI+ATZ7+nPFCgAIyXx1p7gUQvYMU+
         PIIqtCFssQD+K6tP6wluPxjWzbiT/QWuD0nv8PfmpTTeE7+x/+io8/D4M3Wxg+m/qBaB
         vclYMkzdaxDAH1rPSCLcAqqOcBDoEQOJQpWahJ6SNNP+qyElMA5cbvlzt4E8ldnuvDhe
         YK8GjvNgXASiV0MEfNRkqsrZzQcAQjuH5bGELwIq6VRl3MJ6d3lRNxCS8EeFkUIho9o7
         6WuPCN8yHvksYeuTLrY1pCEBizpdBuyYpOXRdK7KXONX3H0OS0NdeXwkKanXD5MESU1+
         YYiA==
X-Gm-Message-State: AOJu0Yy4brSJ2gd5Q47BE+/TSRNXD62NHoZ+DclRj3J2G16mzPiHccF0
	ritIS/wIkGoxBwLLVqRKf86ircshuGe4W1EM0gntHPskX4J5VvsJWBlzd2r9DQ==
X-Gm-Gg: AeBDieu1erjuBe3qSbf9wwdGezQJA5McRJRqYVbQUO3Y9+zr2b1OJbB78PLYbfQFNXe
	VAhZkZXLFxk/4BpSXgiAaJYgieHTSxOhNApn6mBUdu7CwMiCUeEyWDPx5PsziOa2j/OWkr6AQVf
	XmpepRM75UCzDNsKCpVKwZY1I+bt4+/JMshZumhfnU+8G0BiTsnzkqRRW16Y8cNRwyeJLzJc6TA
	gHZCJafDhW+O5dlagolKZBXIeuHdnHkXdjbNbp6queq6kpVNnFRaHQRbHZEXwNSzGZijHsdXb4a
	hvzs8Iwyw4ZAOKE5kh+pk98jZ66sEQYMP+RiMbmRImYjLVXmkC8CYuRWTZyLEhWyQZg+0QD/TfT
	DdAOf2G2sh6FaBQciFHUgnxYLazUjom/pBxEclicQd5SNhvXwtn5UR3m7LvDiHKNl/ALPQKd7Ct
	xsRKJIAHS5H5Irou5GlOItHmfLmKfShOuhnm4oyPXVc1Q+tZ25lWj7sPK6FHGVlX+XiGQngVlyQ
	knNZpP20FTGdACzKQd3t1mRx2M=
X-Received: by 2002:a05:6a20:2450:b0:39f:29ab:b364 with SMTP id adf61e73a8af0-3a08d74fbdcmr3973101637.22.1776448171749;
        Fri, 17 Apr 2026 10:49:31 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([43.245.86.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec23b19sm2949913b3a.59.2026.04.17.10.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:49:31 -0700 (PDT)
Message-ID: <d96524b52e7aea2971fa532d65e4977a7c0afd52.1776446840.git.shuvampandey1@gmail.com>
In-Reply-To: <cover.1776446840.git.shuvampandey1@gmail.com>
References: <cover.1776446840.git.shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 17 Apr 2026 23:34:25 +0545
Subject: [PATCH v2 1/3] mISDN: serialize socket teardown against device
 unregister
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279395-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0367441DB1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_mdevice() returns a referenced struct device, and mISDN sockets keep
that reference in _pms(sk)->dev after bind.

That means mISDN_unregister_device() cannot tear the device down as if no
socket can still reach it. Several teardown paths can otherwise run after
delete_stack() has freed the stack, or after the driver has freed the
embedding object once mISDN_unregister_device() returns.

Close sockets that still point at the device before delete_stack() runs,
wait for the final device release before returning from
mISDN_unregister_device(), and serialize bind against unregister with the
device lock so a new socket cannot attach after unregister has started.

While tightening the close path, reset channel state after CLOSE_CHANNEL so
later socket release does not try to tear the same B-channel down twice,
and make recvmsg/getname tolerate sockets whose device pointer was cleared
by unregister.

Fixes: b36b654a7e82 ("mISDN: Create /sys/class/mISDN")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5.3-Codex
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/isdn/mISDN/core.c   |  19 ++-
 drivers/isdn/mISDN/core.h   |   1 +
 drivers/isdn/mISDN/socket.c | 224 +++++++++++++++++++++++++++++++-----
 include/linux/mISDNif.h     |   1 +
 4 files changed, 216 insertions(+), 29 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index 8ec2d4d4f1352..4e2be8f03119b 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -26,7 +26,9 @@ static DEFINE_RWLOCK(bp_lock);
 
 static void mISDN_dev_release(struct device *dev)
 {
-	/* nothing to do: the device is part of its parent's data structure */
+	struct mISDNdevice *mdev = container_of(dev, struct mISDNdevice, dev);
+
+	complete(&mdev->released);
 }
 
 static ssize_t id_show(struct device *dev,
@@ -219,6 +221,7 @@ mISDN_register_device(struct mISDNdevice *dev,
 		return err;
 	dev->id = err;
 
+	init_completion(&dev->released);
 	device_initialize(&dev->dev);
 	if (name && name[0])
 		dev_set_name(&dev->dev, "%s", name);
@@ -257,12 +260,24 @@ mISDN_unregister_device(struct mISDNdevice *dev) {
 		printk(KERN_DEBUG "mISDN_unregister %s %d\n",
 		       dev_name(&dev->dev), dev->id);
 	/* sysfs_remove_link(&dev->dev.kobj, "device"); */
+	/*
+	 * Remove the device from sysfs before taking dev->mutex so bind-side
+	 * get_mdevice() users will fail the later device_is_registered()
+	 * recheck after they acquire device_lock().
+	 */
 	device_del(&dev->dev);
 	dev_set_drvdata(&dev->dev, NULL);
-
+	device_lock(&dev->dev);
+	misdn_sock_release_device(dev);
 	test_and_clear_bit(dev->id, (u_long *)&device_ids);
 	delete_stack(dev);
+	device_unlock(&dev->dev);
 	put_device(&dev->dev);
+	/*
+	 * Drivers free the enclosing object after unregister returns, so wait
+	 * until the last outstanding device reference is dropped.
+	 */
+	wait_for_completion(&dev->released);
 }
 EXPORT_SYMBOL(mISDN_unregister_device);
 
diff --git a/drivers/isdn/mISDN/core.h b/drivers/isdn/mISDN/core.h
index 5617c06de8e4d..2cd89293bc211 100644
--- a/drivers/isdn/mISDN/core.h
+++ b/drivers/isdn/mISDN/core.h
@@ -41,6 +41,7 @@ extern int	connect_layer1(struct mISDNdevice *, struct mISDNchannel *,
 			       u_int, struct sockaddr_mISDN *);
 extern int	create_l2entity(struct mISDNdevice *, struct mISDNchannel *,
 				u_int, struct sockaddr_mISDN *);
+void		misdn_sock_release_device(struct mISDNdevice *dev);
 
 extern int	create_stack(struct mISDNdevice *);
 extern int	create_teimanager(struct mISDNdevice *);
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 77b900db1cac2..bf3ad0a2a42bc 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mISDNif.h>
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include "core.h"
@@ -57,6 +58,97 @@ static void mISDN_sock_unlink(struct mISDN_sock_list *l, struct sock *sk)
 	write_unlock_bh(&l->lock);
 }
 
+/*
+ * Socket teardown driven by unregister takes device_lock(dev) before
+ * lock_sock(sk). Bind paths take the same order so unregister can close a
+ * socket without racing a new bind onto the same device.
+ */
+static struct sock *
+misdn_sock_get(struct mISDN_sock_list *l, struct mISDNdevice *dev)
+{
+	struct sock *sk;
+
+	read_lock_bh(&l->lock);
+	sk_for_each(sk, &l->head) {
+		if (READ_ONCE(_pms(sk)->dev) != dev)
+			continue;
+		sock_hold(sk);
+		read_unlock_bh(&l->lock);
+		return sk;
+	}
+	read_unlock_bh(&l->lock);
+	return NULL;
+}
+
+static void data_sock_reset_channel(struct sock *sk)
+{
+	_pms(sk)->ch.protocol = ISDN_P_NONE;
+	_pms(sk)->ch.nr = 0;
+	_pms(sk)->ch.addr = 0;
+	_pms(sk)->ch.st = NULL;
+	_pms(sk)->ch.peer = NULL;
+	_pms(sk)->ch.recv = NULL;
+}
+
+static void data_sock_close(struct sock *sk)
+{
+	bool active = _pms(sk)->ch.protocol != ISDN_P_NONE;
+
+	sk->sk_state = MISDN_CLOSED;
+
+	if (active)
+		delete_channel(&_pms(sk)->ch);
+
+	data_sock_reset_channel(sk);
+
+	if (_pms(sk)->dev) {
+		put_device(&_pms(sk)->dev->dev);
+		_pms(sk)->dev = NULL;
+	}
+}
+
+static void base_sock_close(struct sock *sk)
+{
+	sk->sk_state = MISDN_CLOSED;
+
+	if (_pms(sk)->dev) {
+		put_device(&_pms(sk)->dev->dev);
+		_pms(sk)->dev = NULL;
+	}
+}
+
+void
+misdn_sock_release_device(struct mISDNdevice *dev)
+{
+	struct sock *sk;
+
+	if (dev->D.st) {
+		while ((sk = misdn_sock_get(&dev->D.st->l1sock, dev))) {
+			lock_sock(sk);
+			if (_pms(sk)->dev == dev)
+				data_sock_close(sk);
+			release_sock(sk);
+			sock_put(sk);
+		}
+	}
+
+	while ((sk = misdn_sock_get(&data_sockets, dev))) {
+		lock_sock(sk);
+		if (_pms(sk)->dev == dev)
+			data_sock_close(sk);
+		release_sock(sk);
+		sock_put(sk);
+	}
+
+	while ((sk = misdn_sock_get(&base_sockets, dev))) {
+		lock_sock(sk);
+		if (_pms(sk)->dev == dev)
+			base_sock_close(sk);
+		release_sock(sk);
+		sock_put(sk);
+	}
+}
+
 static int
 mISDN_send(struct mISDNchannel *ch, struct sk_buff *skb)
 {
@@ -86,6 +178,14 @@ mISDN_ctrl(struct mISDNchannel *ch, u_int cmd, void *arg)
 	switch (cmd) {
 	case CLOSE_CHANNEL:
 		msk->sk.sk_state = MISDN_CLOSED;
+		if (msk->ch.protocol >= ISDN_P_B_START) {
+			msk->ch.protocol = ISDN_P_NONE;
+			msk->ch.nr = 0;
+			msk->ch.addr = 0;
+			msk->ch.st = NULL;
+			msk->ch.peer = NULL;
+			msk->ch.recv = NULL;
+		}
 		break;
 	}
 	return 0;
@@ -127,18 +227,30 @@ mISDN_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_mISDN *, maddr, msg->msg_name);
+		int dev_id, ch_nr, ch_addr;
+
+		lock_sock(sk);
+		if (!_pms(sk)->dev) {
+			release_sock(sk);
+			skb_free_datagram(sk, skb);
+			return -EBADFD;
+		}
+		dev_id = _pms(sk)->dev->id;
+		ch_nr = _pms(sk)->ch.nr;
+		ch_addr = _pms(sk)->ch.addr;
+		release_sock(sk);
 
 		maddr->family = AF_ISDN;
-		maddr->dev = _pms(sk)->dev->id;
+		maddr->dev = dev_id;
 		if ((sk->sk_protocol == ISDN_P_LAPD_TE) ||
 		    (sk->sk_protocol == ISDN_P_LAPD_NT)) {
 			maddr->channel = (mISDN_HEAD_ID(skb) >> 16) & 0xff;
 			maddr->tei =  (mISDN_HEAD_ID(skb) >> 8) & 0xff;
 			maddr->sapi = mISDN_HEAD_ID(skb) & 0xff;
 		} else {
-			maddr->channel = _pms(sk)->ch.nr;
-			maddr->sapi = _pms(sk)->ch.addr & 0xFF;
-			maddr->tei =  (_pms(sk)->ch.addr >> 8) & 0xFF;
+			maddr->channel = ch_nr;
+			maddr->sapi = ch_addr & 0xFF;
+			maddr->tei =  (ch_addr >> 8) & 0xFF;
 		}
 		msg->msg_namelen = sizeof(*maddr);
 	}
@@ -241,16 +353,14 @@ data_sock_release(struct socket *sock)
 		printk(KERN_DEBUG "%s(%p) sk=%p\n", __func__, sock, sk);
 	if (!sk)
 		return 0;
+
+	lock_sock(sk);
+
 	switch (sk->sk_protocol) {
 	case ISDN_P_TE_S0:
 	case ISDN_P_NT_S0:
 	case ISDN_P_TE_E1:
 	case ISDN_P_NT_E1:
-		if (sk->sk_state == MISDN_BOUND)
-			delete_channel(&_pms(sk)->ch);
-		else
-			mISDN_sock_unlink(&data_sockets, sk);
-		break;
 	case ISDN_P_LAPD_TE:
 	case ISDN_P_LAPD_NT:
 	case ISDN_P_B_RAW:
@@ -259,13 +369,11 @@ data_sock_release(struct socket *sock)
 	case ISDN_P_B_L2DTMF:
 	case ISDN_P_B_L2DSP:
 	case ISDN_P_B_L2DSPHDLC:
-		delete_channel(&_pms(sk)->ch);
+		data_sock_close(sk);
 		mISDN_sock_unlink(&data_sockets, sk);
 		break;
 	}
 
-	lock_sock(sk);
-
 	sock_orphan(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 
@@ -466,6 +574,7 @@ data_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 {
 	struct sockaddr_mISDN *maddr = (struct sockaddr_mISDN *) addr;
 	struct sock *sk = sock->sk;
+	struct mISDNdevice *dev, *lockdev;
 	struct sock *csk;
 	int err = 0;
 
@@ -477,13 +586,35 @@ data_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 		return -EINVAL;
 
 	lock_sock(sk);
+	if (sk->sk_state == MISDN_CLOSED) {
+		release_sock(sk);
+		return -EBADFD;
+	}
+	if (_pms(sk)->dev) {
+		release_sock(sk);
+		return -EALREADY;
+	}
+	release_sock(sk);
+
+	dev = get_mdevice(maddr->dev);
+	if (!dev)
+		return -ENODEV;
+
+	lockdev = dev;
+	device_lock(&dev->dev);
+	lock_sock(sk);
+
+	if (sk->sk_state == MISDN_CLOSED) {
+		err = -EBADFD;
+		goto done;
+	}
 
 	if (_pms(sk)->dev) {
 		err = -EALREADY;
 		goto done;
 	}
-	_pms(sk)->dev = get_mdevice(maddr->dev);
-	if (!_pms(sk)->dev) {
+
+	if (!device_is_registered(&dev->dev)) {
 		err = -ENODEV;
 		goto done;
 	}
@@ -493,7 +624,7 @@ data_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 		sk_for_each(csk, &data_sockets.head) {
 			if (sk == csk)
 				continue;
-			if (_pms(csk)->dev != _pms(sk)->dev)
+			if (READ_ONCE(_pms(csk)->dev) != dev)
 				continue;
 			if (csk->sk_protocol >= ISDN_P_B_START)
 				continue;
@@ -516,15 +647,15 @@ data_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 	case ISDN_P_TE_E1:
 	case ISDN_P_NT_E1:
 		mISDN_sock_unlink(&data_sockets, sk);
-		err = connect_layer1(_pms(sk)->dev, &_pms(sk)->ch,
-				     sk->sk_protocol, maddr);
+		err = connect_layer1(dev, &_pms(sk)->ch, sk->sk_protocol,
+				     maddr);
 		if (err)
 			mISDN_sock_link(&data_sockets, sk);
 		break;
 	case ISDN_P_LAPD_TE:
 	case ISDN_P_LAPD_NT:
-		err = create_l2entity(_pms(sk)->dev, &_pms(sk)->ch,
-				      sk->sk_protocol, maddr);
+		err = create_l2entity(dev, &_pms(sk)->ch, sk->sk_protocol,
+				      maddr);
 		break;
 	case ISDN_P_B_RAW:
 	case ISDN_P_B_HDLC:
@@ -532,19 +663,26 @@ data_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 	case ISDN_P_B_L2DTMF:
 	case ISDN_P_B_L2DSP:
 	case ISDN_P_B_L2DSPHDLC:
-		err = connect_Bstack(_pms(sk)->dev, &_pms(sk)->ch,
-				     sk->sk_protocol, maddr);
+		err = connect_Bstack(dev, &_pms(sk)->ch, sk->sk_protocol,
+				     maddr);
 		break;
 	default:
 		err = -EPROTONOSUPPORT;
 	}
-	if (err)
+	if (err) {
+		data_sock_reset_channel(sk);
 		goto done;
+	}
+	_pms(sk)->dev = dev;
+	dev = NULL;
 	sk->sk_state = MISDN_BOUND;
 	_pms(sk)->ch.protocol = sk->sk_protocol;
 
 done:
 	release_sock(sk);
+	device_unlock(&lockdev->dev);
+	if (dev)
+		put_device(&dev->dev);
 	return err;
 }
 
@@ -555,10 +693,11 @@ data_sock_getname(struct socket *sock, struct sockaddr *addr,
 	struct sockaddr_mISDN	*maddr = (struct sockaddr_mISDN *) addr;
 	struct sock		*sk = sock->sk;
 
-	if (!_pms(sk)->dev)
-		return -EBADFD;
-
 	lock_sock(sk);
+	if (!_pms(sk)->dev) {
+		release_sock(sk);
+		return -EBADFD;
+	}
 
 	maddr->family = AF_ISDN;
 	maddr->dev = _pms(sk)->dev->id;
@@ -623,6 +762,10 @@ base_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	lock_sock(sk);
+	base_sock_close(sk);
+	release_sock(sk);
+
 	mISDN_sock_unlink(&base_sockets, sk);
 	sock_orphan(sk);
 	sock_put(sk);
@@ -700,6 +843,7 @@ base_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 {
 	struct sockaddr_mISDN *maddr = (struct sockaddr_mISDN *) addr;
 	struct sock *sk = sock->sk;
+	struct mISDNdevice *dev, *lockdev;
 	int err = 0;
 
 	if (addr_len < sizeof(struct sockaddr_mISDN))
@@ -709,21 +853,47 @@ base_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 		return -EINVAL;
 
 	lock_sock(sk);
+	if (sk->sk_state == MISDN_CLOSED) {
+		release_sock(sk);
+		return -EBADFD;
+	}
+	if (_pms(sk)->dev) {
+		release_sock(sk);
+		return -EALREADY;
+	}
+	release_sock(sk);
+
+	dev = get_mdevice(maddr->dev);
+	if (!dev)
+		return -ENODEV;
+
+	lockdev = dev;
+	device_lock(&dev->dev);
+	lock_sock(sk);
+
+	if (sk->sk_state == MISDN_CLOSED) {
+		err = -EBADFD;
+		goto done;
+	}
 
 	if (_pms(sk)->dev) {
 		err = -EALREADY;
 		goto done;
 	}
 
-	_pms(sk)->dev = get_mdevice(maddr->dev);
-	if (!_pms(sk)->dev) {
+	if (!device_is_registered(&dev->dev)) {
 		err = -ENODEV;
 		goto done;
 	}
+	_pms(sk)->dev = dev;
+	dev = NULL;
 	sk->sk_state = MISDN_BOUND;
 
 done:
 	release_sock(sk);
+	device_unlock(&lockdev->dev);
+	if (dev)
+		put_device(&dev->dev);
 	return err;
 }
 
diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
index 7aab4a7697369..ce26d70c1ebfb 100644
--- a/include/linux/mISDNif.h
+++ b/include/linux/mISDNif.h
@@ -499,6 +499,7 @@ struct mISDNdevice {
 	u_char			channelmap[MISDN_CHMAP_SIZE];
 	struct list_head	bchannels;
 	struct mISDNchannel	*teimgr;
+	struct completion	released;
 	struct device		dev;
 };
 
-- 
2.50.1 (Apple Git-155)


