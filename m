Return-Path: <netdev+bounces-23897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AEF76E0DF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D9281FD0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F78F76;
	Thu,  3 Aug 2023 07:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C68F5A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:07:24 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E020EE
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:07:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso213381cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691046442; x=1691651242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyLecZNTz+bMKgRPHTjaHj02gSpXlqkDatbkyrIZ4CQ=;
        b=xSTzt9YFgG0onxuXtTl/UuEVnabFZmsTxcSumtvqvavMnHKe973kJNeKV+NAlAyqTk
         VSOsinaewLCiYkd3KGMDaPDsjN6ZVlgpUT1+oCPKhj41Zr2NR/+fKPXSAIfqIaEW8Oy1
         PivKQzU4X3fgH5c9bOmeZMQWO055YzJwKkCNo+Yge79rj3u1RC2lPRGFNdqHI3mJ0Cu1
         zgt9tWZwZf3ZNxGSrhdHQG+cjfbEg0LRho7q/BML3RLa7O7dY4v7WkL3iFT9kE8HKjy1
         BzmolRbqnbNGGQ/YwVJ9TfIPTY2ulN/z5GBy1yT0hSp/WL7hiFztYSuloDC72TZtTDSp
         nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046442; x=1691651242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyLecZNTz+bMKgRPHTjaHj02gSpXlqkDatbkyrIZ4CQ=;
        b=TbP8Sjlh3+91LUYypvyKyiTbuBEKr461dpH76TPMCCJLHzW7uXaDpzIRZJJl/nXC6m
         hvQG5UrgP7iadelk4XXQ6w+W4tsvYf0Hy4B0aF3nrP0kXPHfsTVaV/jaD/+LnSSdq9ll
         vlnjE6KvkE8VfvbjvAO+FBNnMn+Qz6BkCnVnHwVOgGx6o4EHtqdwmBtg8bAMcaLWogrl
         uv4ugVRu1TehLEA4zJQw4wLDb7u50nw6Xfc9WLDF1GcvfP3ifsV51usIjSp5KB3itQDi
         hVEBPr3N4cUL5dzK9XjiEz/89jqIivWH+pB+axZSjZ9fK5bkoygR47xk3mh5wLW3+Mx0
         8T1g==
X-Gm-Message-State: ABy/qLZyNzskOyBcGnyE96jgX0JdR2FXjLlQo8/ygN42aj8nwarEf+YC
	bbnsYc2VWE4oORVfyXqiNLIUqBWhBy3l4NsX/Vc2Xw==
X-Google-Smtp-Source: APBJJlFcdSFyUxXT0H0o0tjm0Bh+oDou5y+SJH+mq5fTsce8nnYWDeYA7Lfnvn0/hrYjSgDqfZlph/qoyExDweGxwOA=
X-Received: by 2002:a05:622a:182:b0:3f5:2006:50f1 with SMTP id
 s2-20020a05622a018200b003f5200650f1mr1268886qtw.12.1691046442028; Thu, 03 Aug
 2023 00:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803042214.38309-1-kuniyu@amazon.com> <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
 <58f719e442b92a37eb764685bf3d5c3cbae627f3.camel@redhat.com>
In-Reply-To: <58f719e442b92a37eb764685bf3d5c3cbae627f3.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Aug 2023 09:07:10 +0200
Message-ID: <CANn89i+OR9fDEN6w385KP1ZSO4qjcU7TAbO7p0jiKnqjKAH+bg@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Enable header prediction for active open
 connections with MD5.
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 8:59=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2023-08-03 at 08:44 +0200, Eric Dumazet wrote:
> > On Thu, Aug 3, 2023 at 6:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > TCP socket saves the minimum required header length in tcp_header_len
> > > of struct tcp_sock, and later the value is used in __tcp_fast_path_on=
()
> > > to generate a part of TCP header in tcp_sock(sk)->pred_flags.
> > >
> > > In tcp_rcv_established(), if the incoming packet has the same pattern
> > > with pred_flags, we enter the fast path and skip full option parsing.
> > >
> > > The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> > > again later in tcp_rcv_established() unless other options exist.  Thu=
s,
> > > MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
> > > slow path.
> > >
> > > For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> > > to tcp_header_len in tcp_create_openreq_child() after 3WHS.
> > >
> > > On the other hand, we do it in tcp_connect_init() for active open
> > > connections.  However, the value is overwritten while processing
> > > SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
> > >
> > >   1) SYN+ACK
> > >
> > >     tcp_rcv_synsent_state_process
> > >       tp->tcp_header_len =3D sizeof(struct tcphdr) or
> > >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALI=
GNED
> > >       tcp_finish_connect
> > >         __tcp_fast_path_on
> > >       tcp_send_ack
> > >
> > >   2) Crossed SYN and the following ACK
> > >
> > >     tcp_rcv_synsent_state_process
> > >       tp->tcp_header_len =3D sizeof(struct tcphdr) or
> > >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALI=
GNED
> > >       tcp_set_state(sk, TCP_SYN_RECV)
> > >       tcp_send_synack
> > >
> > >     -- ACK received --
> > >     tcp_v4_rcv
> > >       tcp_v4_do_rcv
> > >         tcp_rcv_state_process
> > >           tcp_fast_path_on
> > >             __tcp_fast_path_on
> > >
> > > So these two cases will have the wrong value in pred_flags and never
> > > go into the fast path.
> > >
> > > Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
> > > to enable header prediction for active open connections.
> >
> > I do not think we want to slow down fast path (no MD5), for 'header
> > prediction' of MD5 flows,
> > considering how slow MD5 is anyway (no GSO/GRO), and add yet another
> > ugly #ifdef CONFIG_TCP_MD5SIG
> > in already convoluted code base.
>
> Somewhat related, do you know how much header prediction makes a
> difference for plain TCP? IIRC quite some time ago there was the idea
> to remove header prediction completely to simplify the code overall -
> then reverted because indeed caused regression in RR test-case. Do you
> know if that is still true? would it make sense to re-evaluate that
> thing (HP removal) again?
>

I think Florian did this, he might recall the details.

