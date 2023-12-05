Return-Path: <netdev+bounces-54069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A7805EBB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DDD1C20FAB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5F6AB96;
	Tue,  5 Dec 2023 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqoSx7pP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4F1B2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 11:39:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1770a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701805182; x=1702409982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2ld4m3MhERUPzTktQlQjP4JXlULIXkqWAkTLoxmcz0=;
        b=qqoSx7pPuMdeAzs9JxbtFBD0v093lEMUT1P/ZtAu0eiWoUZSH8FIyGh3+CLK5MDIWZ
         5RV1yDLoppjAjXJLjMz2YWiTLGVfeXvQZ/wyEf6hQYP9hDq/Mr5Vew8aAb2Lmg0/FvbV
         lV76DnrtMLKRksRhUHALcJD/kRIkPIWHJKu29qh17wN+dDqtoC06KqD86gMwYpaAco5B
         gLCZrObSEyI3CsXRjCIt85IormIACHEPcHYNMbM84PbjEdWMFCM2OZAaMNXQAI5yP6YF
         h/0k2GRf0CFN9pYLY/M7YZgsZ6qBw5mWGcnLpZAcjua9WnazcqCVfywU3PG7OLF25JiB
         5QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701805182; x=1702409982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2ld4m3MhERUPzTktQlQjP4JXlULIXkqWAkTLoxmcz0=;
        b=FfxD4yGAyoeqIO58NTYAodS0yBG7GxLhSTeXJNBi5nIlpgyzmCniqR76AnLfwcB/Xh
         JkH48dCVNPyzOAo3p9sj5tqFDhF5uo4AbHmlBnYnfSeZOiXQYHN/aIrfmXgVIqeQrzME
         9HlQVgsIsRnrO1Q9aJu5lWTyCIxzR9qcUtn3bbqWwZJtSFMEdR8nXqDkWmENeqR3Nx35
         MjeVOn1cEYHzhQ8/KDf+AcF+emTMANHZVVlfb8mU64arynnr4On035TDzbXWcvHSbRdD
         hIVkWHuERGMgaHPk06i8mpHLLQ2o0WGD2YjATVcVzBoJMTtAf42Ay7bbsKaFoRlOwmJq
         g5DQ==
X-Gm-Message-State: AOJu0YzKe+8PiBxYN6vXhcdZTAeaEeJdtowSdXb0/Nppy8/0rMbS7cG4
	4xy9iR+H1nD3ST7bLIfllks2Vo+8pMW4rH3JXOLC1g==
X-Google-Smtp-Source: AGHT+IG22KQbpxLNZILlyWiioOluPpeZuIABSGkhe5oy2RfeUiCtalpZlaYUFGxQsY9Z2DSP5cxTPadCnBZ25d1mRUo=
X-Received: by 2002:a50:c35d:0:b0:54a:ee8b:7a8c with SMTP id
 q29-20020a50c35d000000b0054aee8b7a8cmr12527edb.0.1701805182213; Tue, 05 Dec
 2023 11:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204114322.9218-1-lulie@linux.alibaba.com>
 <CANn89iKUHQHA2wHw9k1SiazJf7ag7i4Tz+FPutgu870teVw_Bg@mail.gmail.com> <1701740897.6795166-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1701740897.6795166-1-xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Dec 2023 20:39:28 +0100
Message-ID: <CANn89i+Xs3sSDQcub9p=YGUp1_XainGQpS=0RVpYTiDjvRN1rw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, guwen@linux.alibaba.com, 
	hengqi@linux.alibaba.com, Philo Lu <lulie@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Mon, 4 Dec 2023 13:28:21 +0100, Eric Dumazet <edumazet@google.com> wro=
te:
> > On Mon, Dec 4, 2023 at 12:43=E2=80=AFPM Philo Lu <lulie@linux.alibaba.c=
om> wrote:
> > >
> > > Add 3 tracepoints, namely tcp_data_send/tcp_data_recv/tcp_data_acked,
> > > which will be called every time a tcp data packet is sent, received, =
and
> > > acked.
> > > tcp_data_send: called after a data packet is sent.
> > > tcp_data_recv: called after a data packet is receviced.
> > > tcp_data_acked: called after a valid ack packet is processed (some se=
nt
> > > data are ackknowledged).
> > >
> > > We use these callbacks for fine-grained tcp monitoring, which collect=
s
> > > and analyses every tcp request/response event information. The whole
> > > system has been described in SIGMOD'18 (see
> > > https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
> > > achieve this with bpf, we require hooks for data events that call bpf
> > > prog (1) when any data packet is sent/received/acked, and (2) after
> > > critical tcp state variables have been updated (e.g., snd_una, snd_nx=
t,
> > > rcv_nxt). However, existing bpf hooks cannot meet our requirements.
> > > Besides, these tracepoints help to debug tcp when data send/recv/acke=
d.
> >
> > This I do not understand.
> >
> > >
> > > Though kretprobe/fexit can also be used to collect these information,
> > > they will not work if the kernel functions get inlined. Considering t=
he
> > > stability, we prefer tracepoint as the solution.
> >
> > I dunno, this seems quite weak to me. I see many patches coming to add
> > tracing in the stack, but no patches fixing any issues.
>
>
> We have implemented a mechanism to split the request and response from th=
e TCP
> connection using these "hookers", which can handle various protocols such=
 as
> HTTP, HTTPS, Redis, and MySQL. This mechanism allows us to record importa=
nt
> information about each request and response, including the amount of data
> uploaded, the time taken by the server to handle the request, and the tim=
e taken
> for the client to receive the response. This mechanism has been running
> internally for many years and has proven to be very useful.
>
> One of the main benefits of this mechanism is that it helps in locating t=
he
> source of any issues or problems that may arise. For example, if there is=
 a
> problem with the network, the application, or the machine, we can use thi=
s
> mechanism to identify and isolate the issue.
>
> TCP has long been a challenge when it comes to tracking the transmission =
of data
> on the network. The application can only confirm that it has sent a certa=
in
> amount of data to the kernel, but it has limited visibility into whether =
the
> client has actually received this data. Our mechanism addresses this issu=
e by
> providing insights into the amount of data received by the client and the=
 time
> it was received. Furthermore, we can also detect any packet loss or delay=
s
> caused by the server.
>
> https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7912288961/9=
732df025beny.svg
>
> So, we do not want to add some tracepoint to do some unknow debug.
> We have a clear goal. debugging is just an incidental capability.
>

We have powerful mechanisms in the stack already that ordinary (no
privilege requested) applications can readily use.

We have been using them for a while.

If existing mechanisms are missing something you need, please expand them.

For reference, start looking at tcp_get_timestamping_opt_stats() history.

Sender side can for instance get precise timestamps.

Combinations of these timestamps reveal different parts of the overall
network latency,

T0: sendmsg() enters TCP
T1: first byte enters qdisc
T2: first byte sent to the NIC
T3: first byte ACKed in TCP
T4: last byte sent to the NIC
T5: last byte ACKed
T1 - T0: how long the first byte was blocked in the TCP layer ("Head
of Line Blocking" latency).
T2 - T1: how long the first byte was blocked in the Linux traffic
shaping layer (known as QDisc).
T3 - T2: the network =E2=80=98distance=E2=80=99 (propagation delay + curren=
t queuing
delay along the network path and at the receiver).
T5 - T2: how fast the sent chunk was delivered.
Message Size / (T5 - T0): goodput (from application=E2=80=99s perspective)

