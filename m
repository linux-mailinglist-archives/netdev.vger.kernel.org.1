Return-Path: <netdev+bounces-42785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79D7D0251
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C7B21264
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F7374D4;
	Thu, 19 Oct 2023 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qwilt.com header.i=@qwilt.com header.b="mmHaRQSc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD132C64
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:14:08 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9164112
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:14:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso108577401fa.2
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qwilt.com; s=google; t=1697742845; x=1698347645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLoZAJ7PbXG/UYY6q4I/F3ZenxbYYfRWR4yq+dWyvbA=;
        b=mmHaRQScryJ4X2IKDT+HVANNorw42N8M9smwSDSEQjfvcYkkdbjjoFrIQXahM6V8pS
         1y6/JFhJwK4Rw2Cs6XG+hwX1l483Qgga7zOFYADTgrLrfIKsrJ25ToAAfDNHz7qpVcZY
         yma/TumlhtryyILJAOfOeA3VJeRcjN6rikwpgVQuWiKat1bB9ACMSj04s04udtOaaawT
         dKo+Q5ojQxBsUHId0nPFpaS4P2P9xczQQd9hwcDhgsmEJvYWVmDOjLkVdu2UEH/KpPvo
         67dgnBb1Y8BqLnezfx4ADcRskZzo914QFc1GidtyHlXGjKo4+BnYmvSR0umPTAUgZh/y
         ENbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742845; x=1698347645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLoZAJ7PbXG/UYY6q4I/F3ZenxbYYfRWR4yq+dWyvbA=;
        b=Fgbs6GVc9/YHpMYVh208OM9WJEQjVQ3M0yptx/86owQ5EOuoA47dP4kZNATNw3TjUj
         DqM6MBctA0WAgXDYAT0CwANj278/va+jpqab7rzdpWlb8fMNsCBKBxHTloBuoUSVvH2Q
         XY400S59U408K/8ltn4DgDW+C2V3mOLOT429eklXAjCYJpudngsdXhPcp1ZZsM1teOsx
         5HTuCo1kb5isldtkhkeypC0TA3okAv43CkYm1Ua25+gYGTVXq34nTgyd9xMO66mBepTZ
         v9vSf93m2PXd1sM7SWSdi0ZuODvBaspEJMcSGcsc5If2nW+Ira1Lf0AjsEflbD5iur9R
         1qMw==
X-Gm-Message-State: AOJu0YxHiAfWQHEjZbKomAcloqNjzINIVAINxNvM9v778pB/o2bRJTNu
	oHHG2ln/ur3IxLZGg+q0aOjuV0fRw0cAmpQwFdXz7w==
X-Google-Smtp-Source: AGHT+IH9wqTKkU+XFiwLfgD+i7tW3j3K243QWQXzQHrKT5QSX8PliE8nfwR89ah+N9y10fCwHlVhFTfHC4+xKGIIDck=
X-Received: by 2002:ac2:52ab:0:b0:503:200f:47a9 with SMTP id
 r11-20020ac252ab000000b00503200f47a9mr1958212lfm.15.1697742844966; Thu, 19
 Oct 2023 12:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019112457.1190114-1-edumazet@google.com> <CALvZod4PiVHUvsWuLcv=1r9HWGj+my49Xy676AMG4=qFZbcfSw@mail.gmail.com>
In-Reply-To: <CALvZod4PiVHUvsWuLcv=1r9HWGj+my49Xy676AMG4=qFZbcfSw@mail.gmail.com>
From: Dmitry Kravkov <dmitryk@qwilt.com>
Date: Thu, 19 Oct 2023 22:13:54 +0300
Message-ID: <CAAvCjhhPYeAVzisrjWJ052USt-7LtADAYQbH6QoGyisLnWJX9g@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: do not leave an empty skb in write queue
To: Shakeel Butt <shakeelb@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 9:01=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> +Abel Wu
>
> On Thu, Oct 19, 2023 at 4:24=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Under memory stress conditions, tcp_sendmsg_locked()
> > might call sk_stream_wait_memory(), thus releasing the socket lock.
> >
> > If a fresh skb has been allocated prior to this,
> > we should not leave it in the write queue otherwise
> > tcp_write_xmit() could panic.

Eric, do you have a panic trace accidentally? Thanks

> >
> > This apparently does not happen often, but a future change
> > in __sk_mem_raise_allocated() that Shakeel and others are
> > considering would increase chances of being hurt.
> >
> > Under discussion is to remove this controversial part:
> >
> >     /* Fail only if socket is _under_ its sndbuf.
> >      * In this case we cannot block, so that we have to fail.
> >      */
> >     if (sk->sk_wmem_queued + size >=3D sk->sk_sndbuf) {
> >         /* Force charge with __GFP_NOFAIL */
> >         if (memcg_charge && !charged) {
> >             mem_cgroup_charge_skmem(sk->sk_memcg, amt,
> >                 gfp_memcg_charge() | __GFP_NOFAIL);
> >         }
> >         return 1;
> >     }
> >
> > Fixes: fdfc5c8594c2 ("tcp: remove empty skb from write queue in error c=
ases")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Shakeel Butt <shakeelb@google.com>
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> > ---
> > v2: call tcp_remove_empty_skb() before tcp_push()
> >
> >  net/ipv4/tcp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index d3456cf840de35b28a6adb682e27d426b0a60f84..3d3a24f795734eecd60fc76=
1f25f48b7a27714d4 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -927,10 +927,11 @@ int tcp_send_mss(struct sock *sk, int *size_goal,=
 int flags)
> >         return mss_now;
> >  }
> >
> > -/* In some cases, both sendmsg() could have added an skb to the write =
queue,
> > - * but failed adding payload on it.  We need to remove it to consume l=
ess
> > +/* In some cases, sendmsg() could have added an skb to the write queue=
,
> > + * but failed adding payload on it. We need to remove it to consume le=
ss
> >   * memory, but more importantly be able to generate EPOLLOUT for Edge =
Trigger
> > - * epoll() users.
> > + * epoll() users. Another reason is that tcp_write_xmit() does not lik=
e
> > + * finding an empty skb in the write queue.
> >   */
> >  void tcp_remove_empty_skb(struct sock *sk)
> >  {
> > @@ -1289,6 +1290,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >
> >  wait_for_space:
> >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > +               tcp_remove_empty_skb(sk);
> >                 if (copied)
> >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> >                                  TCP_NAGLE_PUSH, size_goal);
> > --
> > 2.42.0.655.g421f12c284-goog
> >
>

