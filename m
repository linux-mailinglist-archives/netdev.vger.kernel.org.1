Return-Path: <netdev+bounces-255166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB0qAK3CfGmgOgIAu9opvQ
	(envelope-from <netdev+bounces-255166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80017BBA60
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1971303E76F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BF328B69;
	Fri, 30 Jan 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX/qOTPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC83321BF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783896; cv=pass; b=Re1otdNZTB1I2bZa7MHpssxdX7iJn/+AHEWMH3W5ai50QZnCH2z5qD2hLIR8ZaSrAOUrxGA0cW+LTUnXvQHiCBjxOQQQGg/xL+gV5/SgW8WpJXH8t/1uVo+v5BqmC89Enk+1sjCs+mr/OBspzUrI5Gkwz0gp2hiLuQW9rzJ4kAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783896; c=relaxed/simple;
	bh=mfxxitL6rrJmnuvDkS8W7cRfIMe6WLR4mpVU8Vb9L68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW3GiBEmc4Jrbi+JzxaFxzdKDRUdfC6KcrzkIJUinBmd4ca1vYhvrQ1ezikPzwZqAiHTKcjzr2333SymFUBtUHkwdo7DH0jtzk8w9i1ufYQ73vYDZcoOI7MatYxFj8bPrqxVTljArYt0UESi9+JY/u0ASOCNO8ALQWz9/0McvGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AX/qOTPc; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-502a407dabaso15632581cf.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 06:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769783893; cv=none;
        d=google.com; s=arc-20240605;
        b=cuynwIFdwPy6s8Lmeo2a4Scs1Ia+g9igEQV9hQrgCZqcGyONC58cCRAOyMouJF8JDn
         tJ4a9aXUQtJvN1X1wODu4o7WW3QJPa5+AgYq1R0Ak38Kl/9daryp4mKbFvbWb8OHHPeJ
         hDQ80MqE2jlwm2HMu08bCbjAEoL4l+OomahIaMXmyMl2mlSJy0SCoUj2LqNpB89N7scA
         xhK9o143Jb6xZw1AAj3dfYtmfLlFYSpfk+sXb3H3Ue1hngKygkAOWZyDyburHXXlXW9m
         iLOkZVpI8IssQHhbpCfcKrGgWDZLAhTeLTgSzXjfbz2aimfDVmG+gmmBVLGMTk+bL1Qn
         9+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ikjzss8Q/ekoDORadvMQbYW8061OgwSgamYo+BBl/2I=;
        fh=fDhqJ4uV6A2L+aNb9IGCuloKD10LdVyEgTx+Kf9erOw=;
        b=PPR2PNQhSqsfXKI23yrvOXy7tKy6pgm+TYnsNO4SEDS7ucenggJt85EgXNoHrbJRst
         6nF8MOnA1fQAzZpJdpipL7TLAZlHaZvOsp8R4M/ZPUMlTJamUq9qREBFU2eyI0oUp2ST
         zY4AGjYct39NqS2JQlpQgJyc9V++Eari/9TZzWxM/DHxK6aCpUgYlBzqeiaDZJO+sWGj
         wLM9b1vf0ANu+YL55OHXI/5EScaSmrEVZzbJsCJp11ZQ6DjTZ6xgIkeh1fGm41/6iynB
         qjBO9P9EI+93VlUXDs7ddDC2AzOQPuCNpZGQFQ+yDGyx7ZpACwcb+s0ghaLFzT0Vpopa
         mAzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769783893; x=1770388693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikjzss8Q/ekoDORadvMQbYW8061OgwSgamYo+BBl/2I=;
        b=AX/qOTPcwuTMhwhoQKoUPlklSxGbu99olVbOfqvLAqDoBvCJ9eUqaC1X88zqJMn62G
         5XV9RMlh+lcQ8qUa7PIdkmZtdIbm7q+CkE9HfiEzE3S0qIzfd7EBdOtLyfMNihn2BuK9
         QxH3/10fKU0j4z8snBABCgGKW9NuUHZBzmGWWV2naXdIYLnyu7h2Wdx5qBcSWUCufhD4
         KEuY8iG37PW+mHQZm4hsnPZ726aWtYyeEF0XH/fXCeQfAn8X2o53tKxDj6wQkRwDiXqf
         mauhf/Xj5KvZHzK438dGe0vSeG1738rWzXJ82quskMuqTJ5337hwpecCu5TtLuCX7Ifw
         vqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783893; x=1770388693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ikjzss8Q/ekoDORadvMQbYW8061OgwSgamYo+BBl/2I=;
        b=qfRCIhMbBPRHp8KPX0YaMQB1J19RFauSPrc88Qi4xJzmjbEYJWaQU/G9pyyycYq921
         lFglNwfNGaBWUtqi24TmeKhwlTIOrqFLMTamsGuABKal2Tq59fe/TmKJgOyfGfIyaDbt
         7pTVabEwHGjnNGG+gj700FtDwo0h5whufeVByMvZwZJqLLfwr971DNVg4g8wuhPOEfIL
         AgF7vjmddkf5W7BwbcrUg1E7H2n8JBNqjq01ERiJRHsiSmZ7ePSRHrv0hwgfMS2Z+VPX
         Bfa2tJ5AcUTMqKNDe50SzNlaFcHvJAMf1AL2uQQ19jh2uNcBF1QPjfn5ec1UH9Y5n/Pj
         XWDQ==
X-Gm-Message-State: AOJu0YzpoaVE7Fosu1Qz3zAy+jeR38lcSVuRiEkSjA/G2mB69jxQcrrK
	z79XM49K+B0sth0LKHCKL+HcP0ejE6PGMjOQbwVTw8i4C6m2aHJiR3ds9qt7nQqrApzEiO+7ns/
	Hv3tfhHMhArxkqlrNPBeUYJsZQ04Zj+kIKw9Ljt0p
X-Gm-Gg: AZuq6aJaUkwJOXbcT54iQmY/qm7B9RSjFM61OsB1n/cOZ2RZGawIX1HPLYShcmgkotV
	2evuZUyvL3V2XiXqTi+vRNXuFHg+PWH8w6HrMNj1mtj6BaV5nDyMsXrHml3z54yYmqOSnglrFNH
	4KzYG7ALTnN0SwHOz+YlrRVmGXpW7YUtnhaozzp5HAnFosv3BTNdq2G5pLqrLyuol4CtWmyBxeW
	Ii/2JOp1wJfmMvrVX+bN4KspFyUmpKItCxNa/J8bi6pTOVeWz119tf6avPbHqztGFJW2lk=
X-Received: by 2002:a05:622a:15c8:b0:4f4:d295:1f53 with SMTP id
 d75a77b69052e-505d22c7f1bmr35007571cf.84.1769783890690; Fri, 30 Jan 2026
 06:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130141455.63201-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260130141455.63201-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 15:37:59 +0100
X-Gm-Features: AZwV_Qg8CWl0t9g69gnlYFVBbo5C5keR-NPnQPjzIiqUBf17ldnz9_XvW2DqUvE
Message-ID: <CANn89iL6LHc0WQeiOyR-X9-X=Txa9z5_mhy7LEa7N_pNUOrZPQ@mail.gmail.com>
Subject: Re: [PATCH net v2] linkwatch: use __dev_put() in callers to prevent UAF
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255166-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,shopee.com:email,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 80017BBA60
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:15=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> After linkwatch_do_dev() calls __dev_put() to release the linkwatch
> reference, the device refcount may drop to 1. At this point,
> netdev_run_todo() can proceed (since linkwatch_sync_dev() sees an
> empty list and returns without blocking), wait for the refcount to
> become 1 via netdev_wait_allrefs_any(), and then free the device
> via kobject_put().
>
> This creates a use-after-free when __linkwatch_run_queue() tries to
> call netdev_unlock_ops() on the already-freed device.
>
> Note that adding netdev_lock_ops()/netdev_unlock_ops() pair in
> netdev_run_todo() before kobject_put() would not work, because
> netdev_lock_ops() is conditional - it only locks when
> netdev_need_ops_lock() returns true. If the device doesn't require
> ops_lock, linkwatch won't hold any lock, and netdev_run_todo()
> acquiring the lock won't provide synchronization.
>
> Fix this by moving __dev_put() from linkwatch_do_dev() to its
> callers. The device reference logically pairs with de-listing the
> device, so it's reasonable for the caller that did the de-listing
> to release it. This allows placing __dev_put() after all device
> accesses are complete, preventing UAF.
>
> The bug can be reproduced by adding mdelay(2000) after
> linkwatch_do_dev() in __linkwatch_run_queue(), then running:
>
>   ip tuntap add mode tun name tun_test
>   ip link set tun_test up
>   ip link set tun_test carrier off
>   ip link set tun_test carrier on
>   sleep 0.5
>   ip tuntap del mode tun name tun_test
>
> KASAN report:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: use-after-free in netdev_need_ops_lock include/net/netdev_lo=
ck.h:33 [inline]
>  BUG: KASAN: use-after-free in netdev_unlock_ops include/net/netdev_lock.=
h:47 [inline]
>  BUG: KASAN: use-after-free in __linkwatch_run_queue+0x865/0x8a0 net/core=
/link_watch.c:245
>  Read of size 8 at addr ffff88804de5c008 by task kworker/u32:10/8123
>
>  CPU: 0 UID: 0 PID: 8123 Comm: kworker/u32:10 Not tainted syzkaller #0 PR=
EEMPT(full)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1=
.16.3-2 04/01/2014
>  Workqueue: events_unbound linkwatch_event
>  Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0x156/0x4c9 mm/kasan/report.c:482
>   kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
>   netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
>   netdev_unlock_ops include/net/netdev_lock.h:47 [inline]
>   __linkwatch_run_queue+0x865/0x8a0 net/core/link_watch.c:245
>   linkwatch_event+0x8f/0xc0 net/core/link_watch.c:304
>   process_one_work+0x9c2/0x1840 kernel/workqueue.c:3257
>   process_scheduled_works kernel/workqueue.c:3340 [inline]
>   worker_thread+0x5da/0xe40 kernel/workqueue.c:3421
>   kthread+0x3b3/0x730 kernel/kthread.c:463
>   ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Reported-by: syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6824d064.a70a0220.3e9d8.001a.GAE@goog=
le.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/link_watch.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index 212cde35affa..5196f8ea43f1 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -185,10 +185,6 @@ static void linkwatch_do_dev(struct net_device *dev)
>
>                 netif_state_change(dev);
>         }
> -       /* Note: our callers are responsible for calling netdev_tracker_f=
ree().
> -        * This is the reason we use __dev_put() instead of dev_put().
> -        */
> -       __dev_put(dev);
>  }
>
>  static void __linkwatch_run_queue(int urgent_only)
> @@ -243,6 +239,7 @@ static void __linkwatch_run_queue(int urgent_only)
>                 netdev_lock_ops(dev);
>                 linkwatch_do_dev(dev);
>                 netdev_unlock_ops(dev);

I would add a comment here, referring to netdev_tracker_free(dev,
&dev->linkwatch_dev_tracker)
few lines before this __dev_put()


> +               __dev_put(dev);
>                 do_dev--;
>                 spin_lock_irq(&lweventlist_lock);
>         }
> @@ -278,8 +275,10 @@ void __linkwatch_sync_dev(struct net_device *dev)
>  {
>         netdev_ops_assert_locked(dev);
>
> -       if (linkwatch_clean_dev(dev))
> +       if (linkwatch_clean_dev(dev)) {
>                 linkwatch_do_dev(dev);

A comment is needed as well.

> +               __dev_put(dev);
> +       }
>  }
>
>  void linkwatch_sync_dev(struct net_device *dev)
> @@ -288,6 +287,7 @@ void linkwatch_sync_dev(struct net_device *dev)
>                 netdev_lock_ops(dev);
>                 linkwatch_do_dev(dev);
>                 netdev_unlock_ops(dev);

Same, please add a comment to ease future bug hunting.

> +               __dev_put(dev);
>         }
>  }
>
> --
> 2.43.0
>

Thanks !

