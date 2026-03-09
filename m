Return-Path: <netdev+bounces-265456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H7TJ/6armkjGwIAu9opvQ
	(envelope-from <netdev+bounces-265456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:03:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B0236B62
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BDEF3003E9A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C237C113;
	Mon,  9 Mar 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M0XmU0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1733AD94
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050347; cv=pass; b=IG+d/ztAmHnQS0TqFOhCtxThrJLO6bwx6udee9qG1hZt/tJvhFfYa7yI9Fk6KRJXwlXlNU/2otIXVkQuPa4vJPbu5YfC4kNPkD05CcvZvuKp8NlZOmp/srsBfci28YtLDjsZhIOVr4bvbSZ5eXS74iVB2452ymFR7U9KOLhWAbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050347; c=relaxed/simple;
	bh=bq18U3Ea9V2UA2wzh7mgLriKIjtundAxwjNiIgJm+Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENBnuBZJDQpBIM8jZgDt6Bt7mSW/E5mPsJQGopP1DXK65x4k9UUYyU7HAMn20mQCKnCeTT0cX2ee5ke0COQg/82Y3vLCKj7Dzj2gkcBvAZG7oBUtq0zbaiwK5Ev6jWz0VRyKL1/U0E6iKQVXVVBQWCL8DPDBp14iuxtxfTOPuHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4M0XmU0x; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509061dab77so18558371cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050346; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4OtqJkAYZwxXD/2iB+raUn+owoyxAbnsCOwRzq0ESauMvGDdFKmlhhmeee5YSQD5x
         hia+sqHSwLWo+Zg3a/NlJkjJzssAnva1Vxi4c40AgDRmnkzcNv8OK/VrvhZ9yTTKylt1
         1MUnpFsEzW5xsAYHkPaN0nTO+IvHXN6CFAO76GLYSiDxNgKnYCfNvjUB7K7MBCH1yiTd
         lrnhnLhQ9xgzpDEArD3ULVyINHL43emtr4xiWkKv/405B2knQgQjH8CUBG1xFZyJ2Uj2
         DNhlgOjWyCuWPVmD8F5GzdAHDEd8MTcHAGlVGmx+XZekxbUuJjEutsYWihv6GuB+lZV5
         Y06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+MuGhNB5x3UmVih1KqzQ5ypPmYsHyzVxky1d7QCRi0=;
        fh=xB534TFHfNrVO/EE62UX4qrh1qvjiBf1ACyVFPzFCuI=;
        b=jOvSBh9vfYJUmgWw58Hj1L1HiSrWmTGds90g5IsF9loxW1860GM0xFNMKnBW+MY8/C
         85a7CnOLcCvYUxa1KDAckyfwSEmMJOs/Pem30OU+LkTouWwI/gadaIRLpOhHWdifihE9
         I5x0qXBpeUmyOSAt2uAtRukj7lcd/mshhnJEwuxf7g1oaKQD/oelOg/yYOo8Fwa19TCr
         n0qbh+L2MihKaaTMqgpjnHQYaZJrTxtdMAIT2uXVdRW1tcxHRBzeBd20/NAELv+1YC5u
         czDcPuJfRIFpJVkb3fshq29cq/9qsp9f/gxyTfstgi4kbHfM+Va4FpKNdicfNikg3A1B
         Xx6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050346; x=1773655146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+MuGhNB5x3UmVih1KqzQ5ypPmYsHyzVxky1d7QCRi0=;
        b=4M0XmU0xIeli7Xn5UAQ96g9ySlTFC/twS2nz9kWtHR5yeTidKGTAhiYqJvZgKF0RwK
         SHTXLljgWrRSU/koAFdWlX8m5zGPRb2TZ3cvc7c4uv7wvc0dc+lsgTu0tZXR+a+LYWTO
         Ks6XQCvGSI55vAVTP9AJEjPNaZUZhPrce6DBotB0eAoMPRMq8ASpZDu6y0JfUGTLdkKS
         iRB2CU2CF8OKO5n8MJdySawfZFYgLU9OUhULK3y3G2q5/7OIEoHHOQrhu8VhEiqpf1k6
         SxL5oLDNWPYfl21F6JuEuR1I9Z2ehq6Rfq04jX8OgcKeNiZ2/0W/jKAB6RpUC2XxoQ3i
         4ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050346; x=1773655146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+MuGhNB5x3UmVih1KqzQ5ypPmYsHyzVxky1d7QCRi0=;
        b=HiV6LyDGP7cIrU+BVqo+7+BFP1y2CRs0n0SNT+wQ0UtRIdIO2XckXToyFqPuX+WbWt
         7C9fiV2YxlQ92r2vvQ2eOP5CUY6lfti1s5DZ2AGIR5AdhSntaUzI4bw1IdvdvYLHSOFh
         jARmp4vK+r2que2o8kEVcDOIsRNrlyqYt2tNIwp+c1mVhtgMiao5ceAzvzgDsv8MVgd/
         Ku0MqQ1t2JPl0z1hKVk0iSZ3ldfLB6g/cxJWRcM/XUDOPG+SeiTtKF7fXAFpME4Ko6mN
         Ld63o/+vGnWWLy30PnxUxE2qCxVGH4Nd+3OqZq83vWcdx41AhgehB4nd8P/0ocpcQLCf
         GDeg==
X-Forwarded-Encrypted: i=1; AJvYcCWup3LK4PsC7fglLnn4snagWCuHm32KFiIOFSSLhTYNu2/xQkHkGXcalibI1b8qv2Fo/2JUWM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hNTk70MFr7wlTqapzWWP5MDnAPDMKZegK4noUJb+hB61mMP1
	Ys+DVtrqSbTQj3z4+YmIqZWvdM7fS0gnrruY6cxqNAfYVCfz0HOYejsg8tpVwjCCc0JlDXvEXmU
	oT2sPqU/Jy8exFEdTid8lDnkxH0f/x5N6l2zhUcDV
X-Gm-Gg: ATEYQzxPK8rVSMWyvAaPU/6/scWL/f40RqDjjenqWWSCNPJgVJu7EGMtKuoojgD9E/b
	ngm/xk8sMIgmdN2TeIVYj+B7joQy7uNbxGHuhr95GrynySxIpk3xgkxKdB0/AZ+l5AjIBPH2w8J
	iT3dgK6gDrArruEmsXE6eca5Icd2YXsgR7CuKbVDNlVV6sdHmVIc9Tmy2a8W/IKQKcPRb9O4S74
	HJccbFLxmgz7cmVptYYME1Wa2Gio5Viw3w630OS0vbwxJFYd0ezc2v40oMthQwHGIkvD2jTmZTM
	7JsoQoI=
X-Received: by 2002:a05:622a:1449:b0:4ff:c5f7:f812 with SMTP id
 d75a77b69052e-508f493e6a3mr124650021cf.38.1773050345124; Mon, 09 Mar 2026
 02:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309093614.502094-1-kartikey406@gmail.com> <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com>
In-Reply-To: <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:58:54 +0100
X-Gm-Features: AaiRm53mF6_FNXqZF7PdKpUJ9Bl9ZzNWkybf__PbmcpVMGehXVhwtMC95FuvSgM
Message-ID: <CANn89iL9-MyJ2fmtWRXTYG_56wEjK+ptOpYRjtRJjKtw3xv+2w@mail.gmail.com>
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kees@kernel.org, mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F12B0236B62
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
	TAGGED_FROM(0.00)[bounces-265456-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 9, 2026 at 10:36=E2=80=AFAM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
> >
> > A race condition exists between lec_atm_close() setting priv->lecd =3D =
NULL
> > and concurrent access to priv->lecd in send_to_lecd(), lec_handle_bridg=
e(),
> > and lec_atm_send(). When the socket is freed via RCU while another thre=
ad
> > is still using it, a use-after-free occurs in sock_def_readable() when
> > accessing the socket's wait queue.
> >
> > The root cause is that lec_atm_close() clears priv->lecd without holdin=
g
> > lec_arp_lock, while callers dereference priv->lecd without any protecti=
on
> > against concurrent teardown.
> >
> > Fix this by:
> > - Protecting priv->lecd =3D NULL in lec_atm_close() with lec_arp_lock t=
o
> >   synchronize with callers that already hold the lock (e.g. lec_arp_res=
olve)
> > - Using sock_hold/sock_put in send_to_lecd() to pin the socket while in
> >   use. This is safe because send_to_lecd() is called under lec_arp_lock
> >   by lec_arp_resolve(), preventing concurrent NULL assignment of lecd.
> > - Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() and
> >   lec_atm_send() where the lock is not held by the caller, with proper
> >   skb cleanup on early exit to avoid memory leaks.
> >
> > Note: Patch testing via syzbot was attempted but the test VM crashed
> > due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
> > unrelated to this fix. The QEMU crash is caused by syzbot's disk I/O
> > fuzzing triggering a known QEMU NCQ emulation bug, not by this patch.
> > Compile testing with "make W=3D1 net/atm/lec.o" passes cleanly.
> >
> > Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c86925
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >  net/atm/lec.c | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > index fb93c6e1c329..7e051174a92b 100644
> > --- a/net/atm/lec.c
> > +++ b/net/atm/lec.c
> > @@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *skb, =
struct net_device *dev)
> >  {
> >         char *buff;
> >         struct lec_priv *priv;
> > +       unsigned long flags;
> >
> >         /*
> >          * Check if this is a BPDU. If so, ask zeppelin to send
> > @@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff *skb=
, struct net_device *dev)
> >                                         /* 0x01 is topology change */
> >
> >                 priv =3D netdev_priv(dev);
> > -               atm_force_charge(priv->lecd, skb2->truesize);
> > +               spin_lock_irqsave(&priv->lec_arp_lock, flags);
> > +               if (!priv->lecd) {
> > +                       spin_unlock_irqrestore(&priv->lec_arp_lock, fla=
gs);
> > +                       kfree_skb(skb2);
> > +                       return;
> > +               }
> >                 sk =3D sk_atm(priv->lecd);
> > +               sock_hold(sk);
> > +               spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
>
> What prevents priv->lecd to be NULL after you released priv->lec_arp_lock=
 ?

More generally, lec_atm_close() clears the sk_receive_queue.

So allowing providers to queue more packets would be wrong.

So really a better fix is needed.

