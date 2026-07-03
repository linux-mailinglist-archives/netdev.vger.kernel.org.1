Return-Path: <netdev+bounces-304309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uxw1D1D+RmpFgQsAu9opvQ
	(envelope-from <netdev+bounces-304309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7606FD8F1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GBhCMeQv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304309-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0822D305EFE4
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C901AC44D;
	Fri,  3 Jul 2026 00:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A01A6807
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037420; cv=none; b=Nmv09wAQwtOWwqoEwtxvudQejkPCYwshVbQojeH1HDUPhPiHdoE5r5dGeEHpKI2Zx+S+Y9KXHnVhLOv5Hfw6hJAZ5TtatfpmK/ZD6FFR50XYra3lwGvruNUehPFygMIK3vkJ3H+jIftgz/AY7NjSW0MJ6PolllrOfEnqG/yzRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037420; c=relaxed/simple;
	bh=m+26+mhYbngzVvwljCrfF+totBfayLKfacbQ4yJyHyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ev384jo7BVv8wCjM83ouqIGC4aCUnZB9rHBib4+KmkQZWN24xBmcoy2YTMlaiFCw3VRbbbvjYdh55u3zBKQsSTwn3/m/9z4mDQL0g8OlkIzvO4E/SjD/ud7N7R9zPO3DbXM6w6ZzewZ/+tCk/O4YWhuP0QCoSh+VbzXnIw91N/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBhCMeQv; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37fec599568so3158560a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037418; x=1783642218; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Am3hdWBm3fjQqJl/GcjuCawMjEOMQ9wJEeWwevCk0Yk=;
        b=GBhCMeQvxV8cz8PNThE2A/eGRTXSG6/mTESQpFFpqzOKqFgociW1+kRWDJEfE2ulnb
         upaisAXD20qfxAXq/x8W6AEpTYzBWIik8fLXc1+7cVXZ87g5bnzx/z9R2eCpJqFAfNv8
         o8zuwclZpQZAzVSVDamOQ9QvVZXWlL7izjsWV2aYY4iukTK6bWdgOb42ytQRfVoXU57i
         ANV34rvxarwe2v8rDF2hkBmeikA7wyLhToNCoNN5jb/guo4r1fxYt0ciKRaydZIoPmPF
         a9mLq0yYlizhZYTSvmNlMlABfem8QiU+2mcXQ5lqgDxTdevL/eiHhFbu1TWwfMkAwAeQ
         lbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037418; x=1783642218;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Am3hdWBm3fjQqJl/GcjuCawMjEOMQ9wJEeWwevCk0Yk=;
        b=Z+RggxX2H9w0b9/xhpbaR8/LeBniZYs3Fl57VUs1Bk4b+rwVWusMZrSF0Y5WSjv+Cx
         oQdDnSTQfcBVA3dQvhX1ItpW6KStRZfOQIXWMlwhkMKzLYR7IjDoAc+SOvhSuiV1axNO
         3M9m8Rqen3ZHapvGcV/j/cSrUKH+lgzWvUGUww5F81mj1LHHsdjoE6x8vHFV6loMVmCR
         xeIGJ4d03tErbPaTKMt6ZxjsugU9bNj1JbcgPbrX22XIZI/le9b5KJbgrRa1xtTvf6UL
         0gkFI8b8IvV2jDkjLXAtco+XAh6HMmgf07N0/+16oRDO/pP0eodAhBpIWllKG14Njj+S
         qT2w==
X-Forwarded-Encrypted: i=1; AHgh+RrlWSmgSsfM5KgXYXp1cFsbvCrvAp9kvV+pmY++3gX8gtQL9ZAq58DOUjpyiGvVGNSYInscVN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9L9GyqY0ogVDrk46SODvpUdFP5wLui+jZYysBgApYDQWgalur
	Ekhke0cN+IUrxX78CAfw62MBo1V5hYp/dfCZi7NnDjSVAAPA7muCZU1L84ZiYiL7P/Y+el42Uie
	9V7/46A==
X-Received: from pjon4.prod.google.com ([2002:a17:90a:9284:b0:37d:253:914f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510c:b0:37e:1609:b304
 with SMTP id 98e67ed59e1d1-380aa07e321mr9071504a91.1.1783037417720; Thu, 02
 Jul 2026 17:10:17 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:19 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/14] veth: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304309-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E7606FD8F1

Currently, veth_dellink() unregisters both local and peer devices
synchronously under RTNL.

Once RTNL is removed, it can be called concurrently from different
netns.

Let's use xchg() and unregister_netdevice_queue_net() to support
per-netns device unregistration.

This way, each device is queued for destruction only once by
the winner of the race.

Note that the extra netdev_hold() ensures that @peer obtained by
the first xchg() is not freed during the subsequent access to
netdev_priv(peer).  The 2nd xchg() overwrites @dev to balance
the refcount.

Tested:

1. Create two veth pairs (veth1-2, veth3-4) between two netns
   (ns1 & ns2).

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add veth1 type veth peer veth2 netns ns2
  # ip -n ns1 link add veth3 type veth peer veth4 netns ns2

2. Run bpftrace to check if the same process does NOT
   unregister the paired veth devices

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove veth2 in ns2 and check bpftrace output

  # ip -n ns2 link del veth2

  PID: 2194 | DEV: veth2
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
  ...
  PID: 448 | DEV: veth1
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

4. Remove ns2 (thus veth4) and check bpftrace output

  # ip netns del ns2

  PID: 571 | DEV: veth4
          free_netdev+5
          netdev_run_todo+4798
          default_device_exit_batch+2271
          ops_undo_list+993
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 441 | DEV: veth3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/veth.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..8170bf33ccf9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -77,6 +77,7 @@ struct veth_priv {
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
 	unsigned int		requested_headroom;
+	netdevice_tracker	peer_tracker;
 };
 
 struct veth_xdp_tx_bq {
@@ -1901,15 +1902,17 @@ static int veth_newlink(struct net_device *dev,
 
 	priv = netdev_priv(dev);
 	rcu_assign_pointer(priv->peer, peer);
+	netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
 	err = veth_init_queues(dev, tb);
 	if (err)
 		goto err_queues;
 
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
+	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
 	err = veth_init_queues(peer, tb);
 	if (err)
-		goto err_queues;
+		goto err_peer_queues;
 
 	veth_disable_gro(dev);
 	/* update XDP supported features */
@@ -1918,7 +1921,11 @@ static int veth_newlink(struct net_device *dev,
 
 	return 0;
 
+err_peer_queues:
+	netdev_put(dev, &priv->peer_tracker);
+	priv = netdev_priv(dev);
 err_queues:
+	netdev_put(peer, &priv->peer_tracker);
 	unregister_netdevice(dev);
 err_register_dev:
 	/* nothing to do */
@@ -1933,24 +1940,25 @@ static int veth_newlink(struct net_device *dev,
 
 static void veth_dellink(struct net_device *dev, struct list_head *head)
 {
-	struct veth_priv *priv;
+	netdevice_tracker *peer_tracker;
 	struct net_device *peer;
+	struct veth_priv *priv;
 
 	priv = netdev_priv(dev);
-	peer = rtnl_dereference(priv->peer);
+	peer_tracker = &priv->peer_tracker;
+	peer = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (!peer)
+		return;
 
-	/* Note : dellink() is called from default_device_exit_batch(),
-	 * before a rcu_synchronize() point. The devices are guaranteed
-	 * not being freed before one RCU grace period.
-	 */
-	RCU_INIT_POINTER(priv->peer, NULL);
 	unregister_netdevice_queue(dev, head);
 
-	if (peer) {
-		priv = netdev_priv(peer);
-		RCU_INIT_POINTER(priv->peer, NULL);
-		unregister_netdevice_queue(peer, head);
-	}
+	priv = netdev_priv(peer);
+	dev = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (dev)
+		unregister_netdevice_queue_net(dev_net(dev), peer, head);
+
+	netdev_put(peer, peer_tracker);
+	netdev_put(dev, &priv->peer_tracker);
 }
 
 static const struct nla_policy veth_policy[VETH_INFO_MAX + 1] = {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


