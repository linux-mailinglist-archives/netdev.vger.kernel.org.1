Return-Path: <netdev+bounces-57548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33E8135B4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF241C20BB4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B355EE9C;
	Thu, 14 Dec 2023 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVHbuW+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989E10F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:07:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso74435e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702570036; x=1703174836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rss776ebVNab3qi+o01oFkqobYUOCwzUH/ammBAnXis=;
        b=DVHbuW+oIAUCqROYEdmsaJD7xPfr23Zut06BKDtB+Ab0pXy6y3hANq9AseKmtSjcp8
         CxpcXpbe2i7AJ9JoeX4+Eiy6v0pvaDsalUHLtT5ix+y3I7n2k3+bA7dAqigHaenoYlS9
         zcrHXYd93oO89oiXRTtrhmQ3znRZUWLlqa07wTpOHsF1GKWT9iiWN0uSqcn9FMf5tVdd
         GrhAU8EGWeB7OQFvbXeDLuo1grrKoOlqixkZn9Wrrpc+DEIHf7LCh0IDgve+R2tHD26m
         Rq2IqPSVDqthrQQ7Y8WcQMntYg1/1lL1/IlSIPT8Je84wkcY6qiWr2nfoIakrdkAiVsW
         Ving==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570036; x=1703174836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rss776ebVNab3qi+o01oFkqobYUOCwzUH/ammBAnXis=;
        b=Rt6cVeKoxuaZ/OAZ/O9+IihIr+JLsYE2n7MCVQipqWQCJ+6k0rFC+5ZrgJh6nF0YAT
         EZ62c1byw7sRh7jeD4v5ojPkauDXxvDBIN6gy+zC1eABPe4mTiaIyo6fjamRctbKE28n
         Uh4kn29KpPI/n2azueMuJC7UC7WHfBkRBlVzhvTA5W9aRd8bvQB/41f+5qtnH7uvrWVG
         iTAVHsTiWjOBpYkXX+54nuWyDBG7ZgzxZvBKTb4YXwD7tJU8aE9pbTXoSvZODYYgAi4N
         wvmP/uiSTYE1fSEfi4JpxEw44DpFnpOFXGFIck6GzhJQfwfPBAMNVKihkX3hh1OwzGmf
         dCbA==
X-Gm-Message-State: AOJu0Yw9FgLREMxTqg0cEl9i62zkxNOXRpFn3AgCbA/CwW6ker+a1qVF
	EYgxdHHj17Sy9796IWQ6e5PC4kzvyiNoOdgmm+JSMw==
X-Google-Smtp-Source: AGHT+IEB5O/tw3dcvrfH+guOoGbL6cugbu+XNOTdLxTFwHGda9+SP7OLySQg6QlF3ZAsW4fBwnNDwVzCUcK3W3hiKts=
X-Received: by 2002:a05:600c:600a:b0:40a:483f:f828 with SMTP id
 az10-20020a05600c600a00b0040a483ff828mr539392wmb.4.1702570036173; Thu, 14 Dec
 2023 08:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
 <20231213213006.89142-1-dipiets@amazon.com> <CANn89i+xtQe9d6YJH7useqY+v31kpHkeg-MxCqtWD90nLrYNXQ@mail.gmail.com>
 <3baf5407-34b1-d616-9552-19696933e0c2@amazon.com>
In-Reply-To: <3baf5407-34b1-d616-9552-19696933e0c2@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:07:02 +0100
Message-ID: <CANn89iJwokqZC9P3Ycy4ZWpmT1QhC0qD79y1K1eg2UUAcAj-Lw@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Geoff Blake <blakgeof@amazon.com>
Cc: Salvatore Dipietro <dipiets@amazon.com>, alisaidi@amazon.com, benh@amazon.com, 
	davem@davemloft.net, dipietro.salvatore@gmail.com, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:52=E2=80=AFPM Geoff Blake <blakgeof@amazon.com> w=
rote:
>
> Thanks for helping dig in here Eric, but what is supposed to happen on TX
> completion? We're unfamiliar with TCP small queues beside finding your ol=
d
> LKML listing that states a tasklet is supposed to run if there is pending
> data.  So need a bit more guidance if you could.
>
> I think its supposed to call tcp_free() when the skb is destructed and
> that invokes the tasklet?  There is also sock_wfree(), it does not appear
> to have the linkage to the tasklet by design.
>
> We did attach probes at one point to look at whether there was a chance a=
n
> interrupt went missing (but don't have them on-hand anymore), but we
> always saw the TX completion happen. When the 40ms latency happened
> we'd see that the completion had happened just after the other packet dec=
ided to
> be corked.  But it certainly doesn't hurt to double check.

When TX completion happens, while autocorking was setup, TSQ_THROTTLED
bit was set on sk->sk_tsq_flags, so TSQ logic should call
tcp_tsq_handler() -> tcp_tsq_write() -> tcp_write_xmit()

tcp_write_xmit() should send the pending packet (if CWND and other
constraints allows this)

autocorking is all about giving chance to the application to
add more bytes on the pending skb before TX completion happens
(typically in less  than 100 usec on an idle qdisc/nic)

If your life depends on not waiting for this delay, you have two options :

1) use MSG_EOR
2) disable autocorking (/proc/sys/net/ipv4/tcp_autocorking



>
> - Geoff Blake
>
> On Thu, 14 Dec 2023, Eric Dumazet wrote:
>
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you can confirm the sender and know=
 the content is safe.
> >
> >
> >
> > On Wed, Dec 13, 2023 at 10:30=E2=80=AFPM Salvatore Dipietro <dipiets@am=
azon.com> wrote:
> > >
> > > > It looks like the above disables autocorking even after the userspa=
ce
> > > > sets TCP_CORK. Am I reading it correctly? Is that expected?
> > >
> > > I have tested a new version of the patch which can target only TCP_NO=
DELAY.
> > > Results using previous benchmark are identical. I will submit it in a=
 new
> > > patch version.
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -716,7 +716,8 @@
> > >
> > >         tcp_mark_urg(tp, flags);
> > >
> > > -       if (tcp_should_autocork(sk, skb, size_goal)) {
> > > +       if (!(nonagle & TCP_NAGLE_OFF) &&
> > > +           tcp_should_autocork(sk, skb, size_goal)) {
> > >
> > >                 /* avoid atomic op if TSQ_THROTTLED bit is already se=
t */
> > >                 if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
> > >
> > >
> > >
> > > > Also I wonder about these 40ms delays, TCP small queue handler shou=
ld
> > > > kick when the prior skb is TX completed.
> > > >
> > > > It seems the issue is on the driver side ?
> > > >
> > > > Salvatore, which driver are you using ?
> > >
> > > I am using ENA driver.
> > >
> > > Eric can you please clarify where do you think the problem is?
> > >
> >
> > Following bpftrace program could double check if ena driver is
> > possibly holding TCP skbs too long:
> >
> > bpftrace -e 'k:dev_hard_start_xmit {
> >  $skb =3D (struct sk_buff *)arg0;
> >  if ($skb->fclone =3D=3D 2) {
> >   @start[$skb] =3D nsecs;
> >  }
> > }
> > k:__kfree_skb {
> >  $skb =3D (struct sk_buff *)arg0;
> >  if ($skb->fclone =3D=3D 2 && @start[$skb]) {
> >   @tx_compl_usecs =3D hist((nsecs - @start[$skb])/1000);
> >   delete(@start[$skb]);
> > }
> > } END { clear(@start); }'
> >
> > iroa21:/home/edumazet# ./trace-tx-completion.sh
> > Attaching 3 probes...
> > ^C
> >
> >
> > @tx_compl_usecs:
> > [2, 4)                13 |                                             =
       |
> > [4, 8)               182 |                                             =
       |
> > [8, 16)          2379007 |@@@@@@@@@@@@@@@                              =
       |
> > [16, 32)         7865369 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [32, 64)         6040939 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      =
       |
> > [64, 128)         199255 |@                                            =
       |
> > [128, 256)          9235 |                                             =
       |
> > [256, 512)            89 |                                             =
       |
> > [512, 1K)             37 |                                             =
       |
> > [1K, 2K)              19 |                                             =
       |
> > [2K, 4K)              56 |                                             =
       |
> >

