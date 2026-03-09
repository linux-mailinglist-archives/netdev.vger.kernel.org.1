Return-Path: <netdev+bounces-265473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HYMLwWjrmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:37:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7B237393
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15000306415B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E63921F1;
	Mon,  9 Mar 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp9Beew4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45339020F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052441; cv=pass; b=Ifn3Ps3a9FwenLJ4YPHQ1yJslxLKTO6RaHRq7GnNN7eCZawdNoqXuS7SMHUPfc/J2f3NDcGXMI9qhy4A33vcMZtuX/+N+u72UpJDysV+trv7HUboBA3B8OpBnL9D8QjDAJXbXxN4tMEV2SGoaGdyUoLZ09D7HhQyXcTliwot6+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052441; c=relaxed/simple;
	bh=9iFdKyLEWvGmcSzHqSf5jIIGrROnq1G+xy/6b2xjmV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKhN+U0fHplWV5duuaWKgD2wFGv9eKBxbOJKPN91RaxA/mYvtgGul2XO3XEqBHhCsGmmPrFbQfWzBj4syPl1ZgQWo0sZss500KvhRsXGkYVs5VmgXnsmLNw0MFTuHRBgkDwdz8MQ4Ui9iFf1W/jBqOoQJYpXO3pQa+UsF1DH3vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp9Beew4; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79902e1fb71so3704447b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 03:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052439; cv=none;
        d=google.com; s=arc-20240605;
        b=Zw+ZYclSfmC9h2oqFiaKrgQmpI+Km3pihqZk9sPdytSn2RDXgsgbcvOR71kZAHf0w/
         /MNypWWbr8vTY1cIh+RSkJsb8sofYMkdardstVi5/4FcNeb8XUk/P8W4+6xbgg0A6aM1
         /uP6LzxwyohsPZHzVnKaWzOmNOh2/hzR4qxYyzt4SXyqiG1Tvlu8AgeV2524Yu8pW/cg
         FuSRPYuN3ti5Hqczs4Tc2L3h4/oD4OCzLyaNqtri7dDrWpVZQ1rM+Y2T9iankqwGp2/1
         A0bp9YAyj3qQVEFud9hDA+WEqjhdi74Ny1MtpoDK/5+tkATyJp8fXcJJypeMFL/kw1Q/
         j18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s+J+xWUFgRZVNBpjwC90S46f1y9jy0SkM4UDUpgCess=;
        fh=14mIkBwO9XAkxVd7+HHsLbVdYt8L5/aPGu540H3cLxg=;
        b=SJ3fOJXblC8Xo3J0W1nT2GTLrZorSVAY4aByguuvTVgVJ+3V17/tJDcNMXjCjgRcbZ
         nA0ly/RCkhaS0bPLvqlhIFwejaxCn0HedXYWubdkL/RNYh/XADvTwflLRZgqtGYfuP7R
         DauzWaxi/JmbxwUwHHtA66k2XDY/mMUmV8VPh3frGG+XB8eg2XwVjzfsjKRkXchIEq53
         JmoPTEi09DqEt7fPywi1cK2QP6PJQXhiRoFp63UM2/P6DoU7DjbJoMYWWVhtbhxND6xH
         VJzWCYeVQzmwv/DYJxngwxRA/KNx8BhdqyMxU9FL+B5XsJ0JS6M8Kz4si/XCKmuq1QWe
         /vOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052439; x=1773657239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+J+xWUFgRZVNBpjwC90S46f1y9jy0SkM4UDUpgCess=;
        b=Mp9Beew4slVN272QfoHhMhut0gZpehBiYnp/cn1PrUqe0XbADjrczFHaxP6tw8x2Gn
         vvJSYGjs9nQmfuHceS+431+bqyMGh0S182FQqdTKNwoKNXTsbiY8VKe7dwR8dvX4SyZU
         hyebapj4GAjueicgHzXKYHYxAFTwDqLCvmySYRm6c7/jqLOL9qCRscW1LZXfBPMXkyT0
         cIRfvRuLT3b8yxUNqvVrj7KPcQQK7ai134hkGusN2SMoXFxYFnyUjnk3NDCyv62EvnYV
         p67PdjUB9c3JwPreMTCKHqzW7rjnGZAXGtnC4sme1LHjbwJlyDi15p+Di7bBxBVc0R4s
         5p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052439; x=1773657239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s+J+xWUFgRZVNBpjwC90S46f1y9jy0SkM4UDUpgCess=;
        b=w86GNv0gSXuFuEGdHWHGKg0Eboft12hXaPS+F8RUUX9dP5aR2vugrpzqv95zFYrizD
         iT/8dmkU3mqlLmSuvKS0AukKSkC5HphKvIJNOy8a9PT/ESOFfFjJjpIRZqyKngwNr4rT
         0vID5Bhr7CcLTfQnfii6jFBE8kBCOrWszyGPWAReODhUClXVzq5A+uFTlzDxQZMd4B9u
         hebuM53GJS/sM8ht+KvIL9v0C6aApUY91rDgYmS2lDMU6nxw9zoW9ApVIDPlktNvKO3L
         gVuLNVPWB2NbNQ5211kCrjY4Vqy+g1cNUhCDyIvYeyGR8Ldq1ZqA/RR6aqC1ws+V2T9V
         i0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKbFNxGEjNqRGYz0fYFSVRU1+yKm09/2cH2XQTV67/ybbuq2ykSh3af9YbAZKfzbtaPum4QVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylkemgX4SD/e7wUDviLPJEFVaFNjw8izmzli7WPvRM5yo4xoUv
	eLO7DiJ0N1mMwudf7mUy8cLtzOeLYLfEaBDWhherTNm+ouKM39lcclYd1dmcHQdZSWLEAjlVj1g
	Prj8K7ApfSvmPuKV22o3FzvwSEv2HL4w=
X-Gm-Gg: ATEYQzzl3im2q9uXFQ95lF1vEQDaGiR7IRJHBWh7LthBbiwQf9ob69NHMtWpLDnpQiX
	NMCZx1ThKPpN5Uq8Wel/jk3s1mNx3EZwCa60SoFpXOPFJG/IiV31VcQMWUuiLYw7D/ix7iMS/1X
	dujvai6nOrzkzibfPmQgD89dH0ivGTXlYodGz9AiHXSVABbKkw+ew7v146QnS7bL7n0xEyAPtmk
	vBvLJFEXvbZyOe2J8tvLVMPI7A9+dwe69fuMC4ghwgcCS2at2FpTXRGNvkkDsprd2hPBgfo21I/
	VhClplC2xVPoWyhQ7OL7kg4TtmwNY+D6uh5FOS0FG4dSybESpen3xUtCMCOzemh7BtH8QvtH
X-Received: by 2002:a05:690c:6983:b0:799:266:83dc with SMTP id
 00721157ae682-79902668d56mr7841717b3.8.1773052438692; Mon, 09 Mar 2026
 03:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309093614.502094-1-kartikey406@gmail.com>
 <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com> <CANn89iL9-MyJ2fmtWRXTYG_56wEjK+ptOpYRjtRJjKtw3xv+2w@mail.gmail.com>
In-Reply-To: <CANn89iL9-MyJ2fmtWRXTYG_56wEjK+ptOpYRjtRJjKtw3xv+2w@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 9 Mar 2026 16:03:46 +0530
X-Gm-Features: AaiRm513lr0DjqjsG2XnphuJ2tMxDv1Pi8eEuzMtObGTt-Wki_JUxP__EaA8ZY8
Message-ID: <CADhLXY767VTS0ac0UBhCrzKnh=GPkMXM3yrEbiS7ETcfHzfo8A@mail.gmail.com>
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kees@kernel.org, mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27B7B237393
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Mar 9, 2026 at 10:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Mar 9, 2026 at 10:36=E2=80=AFAM Deepanshu Kartikey
> > <kartikey406@gmail.com> wrote:
> > >
> > > A race condition exists between lec_atm_close() setting priv->lecd =
=3D NULL
> > > and concurrent access to priv->lecd in send_to_lecd(), lec_handle_bri=
dge(),
> > > and lec_atm_send(). When the socket is freed via RCU while another th=
read
> > > is still using it, a use-after-free occurs in sock_def_readable() whe=
n
> > > accessing the socket's wait queue.
> > >
> > > The root cause is that lec_atm_close() clears priv->lecd without hold=
ing
> > > lec_arp_lock, while callers dereference priv->lecd without any protec=
tion
> > > against concurrent teardown.
> > >
> > > Fix this by:
> > > - Protecting priv->lecd =3D NULL in lec_atm_close() with lec_arp_lock=
 to
> > >   synchronize with callers that already hold the lock (e.g. lec_arp_r=
esolve)
> > > - Using sock_hold/sock_put in send_to_lecd() to pin the socket while =
in
> > >   use. This is safe because send_to_lecd() is called under lec_arp_lo=
ck
> > >   by lec_arp_resolve(), preventing concurrent NULL assignment of lecd=
.
> > > - Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() and
> > >   lec_atm_send() where the lock is not held by the caller, with prope=
r
> > >   skb cleanup on early exit to avoid memory leaks.
> > >
> > > Note: Patch testing via syzbot was attempted but the test VM crashed
> > > due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
> > > unrelated to this fix. The QEMU crash is caused by syzbot's disk I/O
> > > fuzzing triggering a known QEMU NCQ emulation bug, not by this patch.
> > > Compile testing with "make W=3D1 net/atm/lec.o" passes cleanly.
> > >
> > > Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c8692=
5
> > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > > ---
> > >  net/atm/lec.c | 31 +++++++++++++++++++++++++++----
> > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > > index fb93c6e1c329..7e051174a92b 100644
> > > --- a/net/atm/lec.c
> > > +++ b/net/atm/lec.c
> > > @@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *skb=
, struct net_device *dev)
> > >  {
> > >         char *buff;
> > >         struct lec_priv *priv;
> > > +       unsigned long flags;
> > >
> > >         /*
> > >          * Check if this is a BPDU. If so, ask zeppelin to send
> > > @@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff *s=
kb, struct net_device *dev)
> > >                                         /* 0x01 is topology change */
> > >
> > >                 priv =3D netdev_priv(dev);
> > > -               atm_force_charge(priv->lecd, skb2->truesize);
> > > +               spin_lock_irqsave(&priv->lec_arp_lock, flags);
> > > +               if (!priv->lecd) {
> > > +                       spin_unlock_irqrestore(&priv->lec_arp_lock, f=
lags);
> > > +                       kfree_skb(skb2);
> > > +                       return;
> > > +               }
> > >                 sk =3D sk_atm(priv->lecd);
> > > +               sock_hold(sk);
> > > +               spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
> >
> > What prevents priv->lecd to be NULL after you released priv->lec_arp_lo=
ck ?
>
> More generally, lec_atm_close() clears the sk_receive_queue.
>
> So allowing providers to queue more packets would be wrong.
>
> So really a better fix is needed.

Thank you for the review Eric.

You are correct on both points.

1. After releasing lec_arp_lock, priv->lecd can be set to NULL
   by lec_atm_close() concurrently. I should have saved a local
   copy of priv->lecd before releasing the lock.

2. The deeper issue is that lec_atm_close() drains sk_receive_queue
   but my spinlock approach does not prevent new packets from being
   queued after the drain, since timer and workqueue paths like
   lec_arp_work bypass netif_stop_queue().

I think the correct fix would be to use RCU:
- Mark priv->lecd as __rcu in lec.h
- Use rcu_assign_pointer() in lec_atm_close() and lecd_attach()
- Use rcu_read_lock/rcu_dereference in all send paths
- Use synchronize_rcu() in lec_atm_close() before draining
  the queue, ensuring all senders have completed before drain

This way synchronize_rcu() guarantees no new packets can be
queued after the drain begins.

Does this approach look correct to you?

Deepanshu Kartikey

