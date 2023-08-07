Return-Path: <netdev+bounces-24990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901F772786
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E713B281322
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55041096A;
	Mon,  7 Aug 2023 14:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5180FC16
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:20:11 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885510D4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:20:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso463381cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691418004; x=1692022804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/22JZjyzmTPowrwDf0aWQTwiV29hTfY9LBfaaAzpCOc=;
        b=kQkkTkomqoQgnmdCjKFqcKsG4FMV5xgL9PgnfekqFcaBbWAVcGkrF+DNOrnVBTyUWl
         0kNSME1RN3CHU113+ikghGQZHl8GA+kKicaS/ir24Z4tLEat0KODjUjOGUW4SqMvCy1O
         YHNGzdSi48ifylDeb4UnmgtjSylQMsnoxvGb60JZ1B/Z3uybmFHQmWM4UJuYI0YE/9kK
         ljuOYBTp6cQaEx/+7DihWddgBiTyt+bnUjBwEV0uONnH3yJJDyP0JM68iEy4E/ctyCmS
         xjJzVPq9JaCc0bX2j2KKBqVocXEpQ3sOTlZadPAQvoCVxX2xLgNYXy4Xc7z6esF7e0nz
         t3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418004; x=1692022804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/22JZjyzmTPowrwDf0aWQTwiV29hTfY9LBfaaAzpCOc=;
        b=HDUj7aNTqGvfR5JBxbXlgZ3DdFhKKMB2Z2UjkIPLP+k8rfkxvLtm88eO7dgGJk85z0
         Gjj6J+k2dFb0vnyzLUGAA0V/p6jkNWC1B6Wu4Sif2wRI4estHJh/k93a47pM+F5SC6B5
         sgrcyMYJOrk2s8ag4cAMvRNKK3ClsHg8Eqjel5ca4zxrPrD+76RL4k/pwSsU3lbqI5fJ
         GgOcTX/2zQKAhLDX9CsgSx5FNl8gPLWXSUcRv+5aY+RJpCwYE2BO9i4OYKIoZ5J3K769
         KZqXXxXwv4kDW0mCi021LUdNO2T9AfJXFrF6ZPxnoKrPj0hLEB3K7rehR+i8AE+t/hqi
         Iipw==
X-Gm-Message-State: AOJu0YydzutdESBI9iXKfgAXF6EL1tbsHO4z7cDq3NlKRoZkqwrzhPFa
	Wajm7oyJWdZODljKC5TOe9/IPQIwJOXrHoHn/3fycA==
X-Google-Smtp-Source: AGHT+IEvs04uw4bF9mUDTPFwLeLAcPFK7k8/SNwJQbcPN8JRvQ2GkRLjRRFLLDYoEKjNUCBm6OH2NUaeIY6gg06T7fY=
X-Received: by 2002:a05:622a:116:b0:405:432b:9973 with SMTP id
 u22-20020a05622a011600b00405432b9973mr542416qtw.0.1691418003516; Mon, 07 Aug
 2023 07:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807134547.2782227-1-imagedong@tencent.com> <20230807134547.2782227-4-imagedong@tencent.com>
In-Reply-To: <20230807134547.2782227-4-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Aug 2023 16:19:52 +0200
Message-ID: <CANn89iKLXu1axtg9vMpbWv1CRYh=U_r38dJ8Q2s3togZcXqJ6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 3:47=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In tcp_retransmit_timer(), a window shrunk connection will be regarded
> as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
> right all the time.
>
> The retransmits will become zero-window probes in tcp_retransmit_timer()
> if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> TCP_RTO_MAX sooner or later.
>
> However, the timer is not precise enough, as it base on timer wheel.

> Sorry that I am not good at timer, but I know the concept of time-wheel.

Can you remove this line, can we keep focused on the actual patch instead ?

Regardless of timer-wheel, a timer can be delayed under load.

> The longer of the timer, the rougher it will be. So the timeout is not
> triggered after TCP_RTO_MAX, but 122877ms as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX, and the socket will die.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout. Meanwhile, using
> "max(tp->retrans_stamp, tp->rcv_tstamp)" as the last updated timestamp in
> the receiving path, as "tp->rcv_tstamp" can restart from idle, then
> tp->rcv_tstamp could already be a long time (minutes or hours) in the
> past even on the first RTO.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gS=
D2XT8pyAMM096pg@mail.gmail.com/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v2:
> - consider the case of the connection restart from idle, as Neal comment
> ---
>  net/ipv4/tcp_timer.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d45c96c7f5a4..e4b2d8706cae 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -454,6 +454,14 @@ static void tcp_fastopen_synack_timer(struct sock *s=
k, struct request_sock *req)
>                           req->timeout << req->num_timeout, TCP_RTO_MAX);
>  }
>
> +static bool tcp_rtx_probe0_timed_out(struct sock *sk)
> +{
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +       u32 last_ts;
> +
> +       last_ts =3D max(tp->retrans_stamp, tp->rcv_tstamp);

u32     retrans_stamp;  /* Timestamp of the last retransmit,
u32     rcv_tstamp;     /* timestamp of last received ACK (for keepalives) =
*/

Both fields receive tcp_jiffies32 values, which wrap every 2^32 ticks.

So max(A, B) won't work as you expect...

You need to use before(), after() or something like that.

https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution


> +       return inet_csk(sk)->icsk_timeout - last_ts > TCP_RTO_MAX;
> +}
>
>  /**
>   *  tcp_retransmit_timer() - The TCP retransmit timeout handler
> @@ -519,7 +527,7 @@ void tcp_retransmit_timer(struct sock *sk)
>                                             tp->snd_una, tp->snd_nxt);
>                 }
>  #endif
> -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> +               if (tcp_rtx_probe0_timed_out(sk)) {
>                         tcp_write_err(sk);
>                         goto out;
>                 }
> --
> 2.40.1
>

