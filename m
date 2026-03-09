Return-Path: <netdev+bounces-265476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK4TJpqprmntHQIAu9opvQ
	(envelope-from <netdev+bounces-265476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:06:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014ED2378B1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABD583059F00
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6DA359A6E;
	Mon,  9 Mar 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vC2gtTyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC2265621
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054143; cv=pass; b=fAktcild4/Cbbd7amNdDdM88kenKtXbkjfS9PXDYl39LWIDaW+MjiwgmoNZkQbwvQcZH43S4UJWVOyYp4DoQWl8uYq48tuDbdSSN2U4sClbmcAXmnQig0V9Igin6nY2/Qgnv/creAeBDL2IjmILMah4EQyw/0YoUzp9Xr0AKcwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054143; c=relaxed/simple;
	bh=XwB4W79h4EipZ5BDPQF5kv7I7YerrBXYb/tggnn4SnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoC5ZrNirRfG8h0kQRSxYb4XoVNLK1wYKONBDHrqzgxsLleBCbeSYDlqqV5zrJTGW7K3bT+Ep+nG0O47tgKVBvvMPA2foXds2m5n768FVAAlv37lNXPBHyDFdZ/k3rbAzjjWZTd177jeSIAzO6oV/sHiHAx4e1YbGbLCAh7Hi0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vC2gtTyo; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5069b3e0c66so163130791cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773054140; cv=none;
        d=google.com; s=arc-20240605;
        b=bKlkI5XNJsGANHVJgxyic6K6TQN5XIJVT+Qudgs9DjU4v35wGNk4oOO92mMwe7m0he
         qhe26NSArNFaYV+D8eUQZrXpvk3ed5M1enBwJQpBNyFWN25GffnKPYDYgUimL5VhFA0r
         pB/vK0cE1AbHqaO+4RpEurg1SnhDEzav5xVZ9aR//g7yRsJ0uKEh67+n5N17eExw1KoC
         Ac28AjU6mkSdS10PsWo99lDoKlOwtr7CVgdKBbg2NBdwB4YJPOpp09BYWcxogOUGABWR
         bmivBkZLW+c9ggDZMa/Uoak+Q5L1Kqdbbz2Tm+hX0n5xdaKJbjpol8KgsFtrz84ncwXa
         PfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4OFoeHoBVPxd+zNA6iAcyedJj3Gl8BuvYYv/ihYHZiI=;
        fh=WFIThbeZ7NV9vIw9uzzmQeo74cR6sMfeH9YVsQJSWmg=;
        b=IC1QeToq0Eg/6RIIy/3Yhuq/gIu20D0trwzqZZJN1fAxkU0hbEVCazUZvSkm4m81CT
         VT3q/eDPXZLIoSFJjqIU0qj2RFNf2e2C+w2S9RpgfO+emTN2Px/htFKPZaoiYvfOgZvF
         yGisYjdAuD5a/9Iu8wgJkf61rtjayIvhEQBV2PSg8opzXMQpiw9qI4p4ebPZxx0JiZwH
         O0O2lXlBOaFVLECMe+oIt92uzUgxkg4AC16rpm4SH1Y84ppJHnmiP0epyGXuETieUwwX
         cW6ucIWtPoMQ+utsGtbafWxiBhxXlW7wnyfuqxXujHFSceL6uUS1m3VMXPKhXbnGGR0S
         nJvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773054140; x=1773658940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OFoeHoBVPxd+zNA6iAcyedJj3Gl8BuvYYv/ihYHZiI=;
        b=vC2gtTyoEXKZaBDyFFMpXyRmPQbbLM6Z9IhhswenjceNz1T2z+5RdiF7Ie4PbS+i4I
         55T6/naLmuQBawvhp86x7PYHGaIIBoJ+4aGM63Xz/xanUuEcIdrM1j9lJ8qu9hoh/on3
         X3UxB+K5b3BKVX/sd3Pzm3L87NRsKMpnoYyhjxlT4WrCkANlI1hqRycMLfqt34uqZrU7
         4G0gZfESWyBgIOlO2dMSr/Tiu/0SUqcRyxNjNt763xtSQpsRd1R21Y7ZUFP6SCC31mfw
         o+fHEhpvLp+AyU3QaYkdKa1ZLydyoHYUtEGTeJHQ/O4M9Yhyhwm6imGwXu+zlRcv/CcC
         mTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054140; x=1773658940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4OFoeHoBVPxd+zNA6iAcyedJj3Gl8BuvYYv/ihYHZiI=;
        b=DseRT63QYeuhizvdUAi+pQ2ii2GJqkC9BYO4s2W0ycyeD8qaaSX/IruT96DIjT/X94
         YSJGv37yf7mq9VoJyPUe1M+f7gOe15qh8/lxcPABU8sJgVYpY5hMtFZAjZiWgbHokxh4
         8PAnSLBKUcMnDD3E/1wTPyVoCatNh59GvPmKUfqDVPzWk1hFPPKhXD7ihZU69R+ply/G
         bmzC2fR4mvQg/cihilPXhB2947op/Dq6L7x5PgZ+3nDkkTDad4WAIIXwad+6YdfokknR
         S0FdDuLGq2K21gl1DuVpT/B4ymcqCX8qBvUKlcGz1F9WaaKnftqD0PtLHycVWZ2qfk48
         QVxA==
X-Forwarded-Encrypted: i=1; AJvYcCXihnrLH7TBjHLpmMFVYg0n4UolGRescYq3y9QNgsYj92U/gY+Y0WK5S/q6eR2iJrLytsV58n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18Rlv9rbZhaYFmsmh57T5GeC95F6q2glu+/phfIb4EkEE7Byt
	vCCIRO1z0aelx5z84UoP8Juatvw3uTtnaGwTcMGchRfrEhs7AgCWD/PfyHvHqTTjDczNs1/Tj5k
	AhipeqZoX3Om5dcrUsLQV98mBLLFqgwd2Q1N1Vof+
X-Gm-Gg: ATEYQzxmye3+mMWXQjJ4qSCLRG+nC2gFNcsh1Xhui/rYeP6Z9RmUrrQja0f47Lr9pbG
	1LgHWg/dE5CwjydE+rY97Q0gvh826bVvXKRYD+smKcU7VhYhpA8ppQ1I3utClIvJwdQBuOcmlu5
	xbgW5PoOXZR8K2TLzBU/w7lRq2R1h7G49AzPm5lUjzT3Mh5bh7Q38ohQuR+uJnVnyIuVmz0Jj0g
	WDbSGv1dfFLPdrn8CZLqFl/8xMluKJ5PdmsJApSdPl841rCEtvJV9jZCUCRKi/ARCYxJ6yp1aSz
	1jZMQXky4MgVH/2dEQ==
X-Received: by 2002:a05:622a:1ba4:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-508f4abdc05mr125096481cf.14.1773054139560; Mon, 09 Mar 2026
 04:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309093614.502094-1-kartikey406@gmail.com>
 <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com>
 <CANn89iL9-MyJ2fmtWRXTYG_56wEjK+ptOpYRjtRJjKtw3xv+2w@mail.gmail.com> <CADhLXY767VTS0ac0UBhCrzKnh=GPkMXM3yrEbiS7ETcfHzfo8A@mail.gmail.com>
In-Reply-To: <CADhLXY767VTS0ac0UBhCrzKnh=GPkMXM3yrEbiS7ETcfHzfo8A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 12:02:08 +0100
X-Gm-Features: AaiRm531uVkPBkyGAvfq6NzMDzObr_h98c2ax54upbdgWloqs6mH_BBT_qJGVSM
Message-ID: <CANn89iL_-FMpLET0qWz9ASa6M5E3EYbfpkQnM2tREV7Vru7Vqg@mail.gmail.com>
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kees@kernel.org, mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 014ED2378B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 11:34=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> On Mon, Mar 9, 2026 at 3:29=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Mon, Mar 9, 2026 at 10:55=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Mar 9, 2026 at 10:36=E2=80=AFAM Deepanshu Kartikey
> > > <kartikey406@gmail.com> wrote:
> > > >
> > > > A race condition exists between lec_atm_close() setting priv->lecd =
=3D NULL
> > > > and concurrent access to priv->lecd in send_to_lecd(), lec_handle_b=
ridge(),
> > > > and lec_atm_send(). When the socket is freed via RCU while another =
thread
> > > > is still using it, a use-after-free occurs in sock_def_readable() w=
hen
> > > > accessing the socket's wait queue.
> > > >
> > > > The root cause is that lec_atm_close() clears priv->lecd without ho=
lding
> > > > lec_arp_lock, while callers dereference priv->lecd without any prot=
ection
> > > > against concurrent teardown.
> > > >
> > > > Fix this by:
> > > > - Protecting priv->lecd =3D NULL in lec_atm_close() with lec_arp_lo=
ck to
> > > >   synchronize with callers that already hold the lock (e.g. lec_arp=
_resolve)
> > > > - Using sock_hold/sock_put in send_to_lecd() to pin the socket whil=
e in
> > > >   use. This is safe because send_to_lecd() is called under lec_arp_=
lock
> > > >   by lec_arp_resolve(), preventing concurrent NULL assignment of le=
cd.
> > > > - Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() an=
d
> > > >   lec_atm_send() where the lock is not held by the caller, with pro=
per
> > > >   skb cleanup on early exit to avoid memory leaks.
> > > >
> > > > Note: Patch testing via syzbot was attempted but the test VM crashe=
d
> > > > due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
> > > > unrelated to this fix. The QEMU crash is caused by syzbot's disk I/=
O
> > > > fuzzing triggering a known QEMU NCQ emulation bug, not by this patc=
h.
> > > > Compile testing with "make W=3D1 net/atm/lec.o" passes cleanly.
> > > >
> > > > Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c86=
925
> > > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > > > ---
> > > >  net/atm/lec.c | 31 +++++++++++++++++++++++++++----
> > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > > > index fb93c6e1c329..7e051174a92b 100644
> > > > --- a/net/atm/lec.c
> > > > +++ b/net/atm/lec.c
> > > > @@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *s=
kb, struct net_device *dev)
> > > >  {
> > > >         char *buff;
> > > >         struct lec_priv *priv;
> > > > +       unsigned long flags;
> > > >
> > > >         /*
> > > >          * Check if this is a BPDU. If so, ask zeppelin to send
> > > > @@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff =
*skb, struct net_device *dev)
> > > >                                         /* 0x01 is topology change =
*/
> > > >
> > > >                 priv =3D netdev_priv(dev);
> > > > -               atm_force_charge(priv->lecd, skb2->truesize);
> > > > +               spin_lock_irqsave(&priv->lec_arp_lock, flags);
> > > > +               if (!priv->lecd) {
> > > > +                       spin_unlock_irqrestore(&priv->lec_arp_lock,=
 flags);
> > > > +                       kfree_skb(skb2);
> > > > +                       return;
> > > > +               }
> > > >                 sk =3D sk_atm(priv->lecd);
> > > > +               sock_hold(sk);
> > > > +               spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
> > >
> > > What prevents priv->lecd to be NULL after you released priv->lec_arp_=
lock ?
> >
> > More generally, lec_atm_close() clears the sk_receive_queue.
> >
> > So allowing providers to queue more packets would be wrong.
> >
> > So really a better fix is needed.
>
> Thank you for the review Eric.
>
> You are correct on both points.
>
> 1. After releasing lec_arp_lock, priv->lecd can be set to NULL
>    by lec_atm_close() concurrently. I should have saved a local
>    copy of priv->lecd before releasing the lock.
>
> 2. The deeper issue is that lec_atm_close() drains sk_receive_queue
>    but my spinlock approach does not prevent new packets from being
>    queued after the drain, since timer and workqueue paths like
>    lec_arp_work bypass netif_stop_queue().
>
> I think the correct fix would be to use RCU:
> - Mark priv->lecd as __rcu in lec.h
> - Use rcu_assign_pointer() in lec_atm_close() and lecd_attach()
> - Use rcu_read_lock/rcu_dereference in all send paths
> - Use synchronize_rcu() in lec_atm_close() before draining
>   the queue, ensuring all senders have completed before drain
>
> This way synchronize_rcu() guarantees no new packets can be
> queued after the drain begins.
>
> Does this approach look correct to you?

This would be good, make sure lec_atm_close() is allowed to sleep.

If this is vcc_destroy_socket(), maybe sk_receive_queue purging
already happens there.

