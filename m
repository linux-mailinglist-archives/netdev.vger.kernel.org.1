Return-Path: <netdev+bounces-25424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228D773EFB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9204B280F27
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558A171D5;
	Tue,  8 Aug 2023 16:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310F171CD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:38:04 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4211387C9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:37:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3490b737f9aso985ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691512645; x=1692117445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGjHzRfbCCkNjNIAknClWHbX+0mqrJSn4alogR9LmE=;
        b=n6shj/s6/EJi5Co0wLrbf3WdztkjnOvvpYHdU8mT58bo9kozOGGYnoTXtMr2wEknwf
         GmOgPBJ0oBOIr0EXLFF3+z3HtKEHp9zjZnNiwDVtCPQu5BUOPPOKpafaS1HAP9Qllos3
         /1M9a4RcrCvbvrYs0WSl91lKi9E75R3gNtAZjUOhkwYLCWpC3FLKAwmr6sNBL7vV/4ws
         bZ/JBVvwBs3IzOXm1WT74vsQ/NlnkAvdltBZyyfvPGtQpFNMuj4YZHNK40N8h/JE3WnE
         LXynqdqoH+Yz1obF5OAMS8u4CjAJC9TgYAN/KRL23JamgyFusHQkf0i9cPYnRGEtEbL7
         frhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512645; x=1692117445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGjHzRfbCCkNjNIAknClWHbX+0mqrJSn4alogR9LmE=;
        b=foVXvpienLbM1ZTdxObBDAG7V1EqO4GZ7B4ludeBq0X5XgLTt4xdub3DNqzUsbhIJ0
         zaO4yh3IWWfLSPD/Ivyw6KaPqsxPWToYn9kSVO1Jbv+TierQvDIVmduBqiYTPZRdTXVX
         +JnIjKZSHRixzFukRj6IwyqtMbDUNFOEf2OqhvnEnSgI87Jgr9L5fMUBBtAlevRiceSn
         5rpQq2nsXDVY0VOjD56T/Bh+tFViBeVOlJRMD7zrinAdipavA04MUg+TtobJODjLm/6M
         B8JjE+sLdgy41wOF6XoSkftkAymiUv6eMSHjnF82+dT3BrlBy92iEO2d+xpBaQvl2WYs
         G6Yg==
X-Gm-Message-State: AOJu0YxpONmAB5lC0t4qaCiutYpaGi6nIpigJkiAF7CpwCi7K/zo9/jz
	rRgSKObhVYvKYsWqj6h5g9XMeUPTw1CH1D1eLwpga3XlGlfB/k/gB9+D4w==
X-Google-Smtp-Source: AGHT+IEcS2KttxAPl/PPlr9cHN2Zs39UZYwywvRTTc3RHtQ/HQ3pnOJ/bgTkgnT/sABlEgq3j7CobXhoy9f1jtaGAKI=
X-Received: by 2002:a05:622a:1456:b0:3fa:45ab:22a5 with SMTP id
 v22-20020a05622a145600b003fa45ab22a5mr631672qtx.27.1691498976444; Tue, 08 Aug
 2023 05:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808115835.2862058-1-imagedong@tencent.com> <20230808115835.2862058-4-imagedong@tencent.com>
In-Reply-To: <20230808115835.2862058-4-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Aug 2023 14:49:25 +0200
Message-ID: <CANn89iK16069CvbA+p=WyZVYftvHs=FviQp1GSWUTG2ihRfKDA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, flyingpeng@tencent.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 1:59=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
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
> However, the timer can be delayed and be triggered after 122877ms, not
> TCP_RTO_MAX, as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX, and the socket will die.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout. Meanwhile, using the later
> one of tp->retrans_stamp and tp->rcv_tstamp as the last updated timestamp
> in the receiving path, as "tp->rcv_tstamp" can restart from idle, then
> tp->rcv_tstamp could already be a long time (minutes or hours) in the
> past even on the first RTO.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gS=
D2XT8pyAMM096pg@mail.gmail.com/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v3:
> - use after() instead of max() in tcp_rtx_probe0_timed_out()
> v2:
> - consider the case of the connection restart from idle, as Neal comment
> ---
>  net/ipv4/tcp_timer.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d45c96c7f5a4..f30d1467771c 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -454,6 +454,18 @@ static void tcp_fastopen_synack_timer(struct sock *s=
k, struct request_sock *req)
>                           req->timeout << req->num_timeout, TCP_RTO_MAX);
>  }
>
> +static bool tcp_rtx_probe0_timed_out(struct sock *sk)

const struct sock *sk

> +{
> +       struct tcp_sock *tp =3D tcp_sk(sk);

const struct tcp_sock *tp =3D tcp_sk(sk);

> +       u32 timeout_ts, rtx_ts, rcv_ts;
> +
> +       rtx_ts =3D tp->retrans_stamp;
> +       rcv_ts =3D tp->rcv_tstamp;
> +       timeout_ts =3D after(rtx_ts, rcv_ts) ? rtx_ts : rcv_ts;
> +       timeout_ts +=3D TCP_RTO_MAX;

If we are concerned with a socket dying too soon, I would suggest
adding 2*TCP_RTO_MAX instead of TCP_RTO_MAX

When a receiver is OOMing, it is possible the ACK RWIN 0 can not be sent al=
l,
so tp->rcv_tstamp will not be refreshed. Or ACK could be lost in the
network path.

This also suggests the net_dbg_ratelimited("Peer %pI4:%u/%u
unexpectedly shrunk window %u:%u (repaired)\n"...) messages
are slightly wrong, because they could be printed even if we did not
receive a new ACK packet from the remote peer.

Perhaps we should change them to include delays (how long @skb stayed
in rtx queue, how old is the last ACK we received)

> +
> +       return after(inet_csk(sk)->icsk_timeout, timeout_ts);
> +}
>
>  /**
>   *  tcp_retransmit_timer() - The TCP retransmit timeout handler
> @@ -519,7 +531,7 @@ void tcp_retransmit_timer(struct sock *sk)
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

