Return-Path: <netdev+bounces-41909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897117CC2AF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76A81C208A3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3541E57;
	Tue, 17 Oct 2023 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnHP0mR/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CF36AF6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:13:20 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1749618A
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:09:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079fe57721so2573e87.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697544548; x=1698149348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JEcCB1VGk62ZsePlKZIFX4dqdTLllXQG+vqvXqnA9k=;
        b=tnHP0mR/g/Pi/2ZRMtbE54KZJx1WLlOit2Ib0/Gu0EiQ5ATO+yR+uGEaNoRe5tMEkr
         9/xwMk1WW51qxe0iyCEDi0e1Y+FYe7z6smqn+XsAJPJ8Xa8neWuhEXdYUx/O2yp02z3p
         tzPwQ5afOoV8AUuF2qCiIR75FNUT8aahFvBEqyBSqr4+P88i9vU6LoSyRQFhNiKGzALr
         +u3azoBSZL9jEZqWjeKSEEXiTczE/Ops5Nig9EcWgqSHrlMpMkeDyWMFjr4O2iDIC+jS
         7m3Dqps4vxRh0LlSF6j01gYczrpsEtJ0Ix8Wz6k4T+w5dCtVMbq4Ss+FVPrJWJMCMjRp
         aVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544548; x=1698149348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JEcCB1VGk62ZsePlKZIFX4dqdTLllXQG+vqvXqnA9k=;
        b=QM4VcHSNqoHvXzQTkvv6VhdMOQ7DGplyV1XJAM6ytheO+uktU3BaBMl6yucfuIl8PC
         hUx+CfqxLPwT4uDa7++vHV8f0Rk74Q/u1UsBwH+XGlOrtSokUQTA1hvMS/D8GRABSv2c
         z33mRqkAgM6WhLemNA1t5LS73eWCquxDEy2XVX7escwmD/AFCNltE3WvnC8GOgN02+Ur
         2bLkYSZpvqyiKlj5WJuISKa0I9ZrkSDIgSedKdMMFabgEH8rHx/XfGQuQ5U4x86F3s8k
         BEK1qvXKJ1H9cQ1IlRxhRwNO7kOxnkvU1ZhcvG1HN+Kc8agFmlA4HHjiIN0q3qzhQnwm
         J3yg==
X-Gm-Message-State: AOJu0Yya9Ct7DOt6G+df82ljR5l+8wb4uRH+mE37FmbJHo8ODYMoYACo
	1t0TOnZ4bE2hJr0oLP8vV93FPRIbTxNuguuG5WeJkQ==
X-Google-Smtp-Source: AGHT+IGrFyU6A9w1gzliIAUtInvKMZuF51sdjxkm7/1Y1DrzeMQmCLEPgpQix9q86QX92tEWwKAzwHww6Ybu9TA2NY8=
X-Received: by 2002:ac2:5e33:0:b0:505:715f:d36b with SMTP id
 o19-20020ac25e33000000b00505715fd36bmr56315lfg.5.1697544548129; Tue, 17 Oct
 2023 05:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net> <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net> <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
 <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
 <CANn89iJUBujG2AOBYsr0V7qyC5WTgzx0GucO=2ES69tTDJRziw@mail.gmail.com>
 <76a0c751-c827-4b6e-b27f-ced3ba2834fb@gmx.net> <CANn89i+6VuixihW4YyHntjj_GOKOOyXt8hHF8TJtB3bm07CZ6w@mail.gmail.com>
 <ea9578d1-be40-48ab-b9d3-826bb5006756@gmx.net>
In-Reply-To: <ea9578d1-be40-48ab-b9d3-826bb5006756@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Oct 2023 14:08:52 +0200
Message-ID: <CANn89i+kcnSDTJ5E5Rrmvk-V3Oqg8NbAyG=LWWVLc+_CF_kLjA@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:53=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> w=
rote:
>
> Hi Eric,
>
> Am 16.10.23 um 20:47 schrieb Eric Dumazet:
> > On Mon, Oct 16, 2023 at 8:25=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net=
> wrote:
> >> Hi Eric,
> >>
> >> Am 16.10.23 um 12:35 schrieb Eric Dumazet:
> >>> On Mon, Oct 16, 2023 at 11:49=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >>> Speaking of TSQ, it seems an old change (commit 75eefc6c59fd "tcp:
> >>> tsq: add a shortcut in tcp_small_queue_check()")
> >>> has been accidentally removed in 2017 (75c119afe14f "tcp: implement
> >>> rb-tree based retransmit queue")
> >>>
> >>> Could you try this fix:
> >>>
> >>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >>> index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec844=
0928e22a290712f0b6b
> >>> 100644
> >>> --- a/net/ipv4/tcp_output.c
> >>> +++ b/net/ipv4/tcp_output.c
> >>> @@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
> >>>           return true;
> >>>    }
> >>>
> >>> +static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
> >>> +{
> >>> +       const struct rb_node *node =3D sk->tcp_rtx_queue.rb_node;
> >>> +
> >>> +       /* No skb in the rtx queue. */
> >>> +       if (!node)
> >>> +               return true;
> >>> +
> >>> +       /* Only one skb in rtx queue. */
> >>> +       return !node->rb_left && !node->rb_right;
> >>> +}
> >>> +
> >>>    /* TCP Small Queues :
> >>>     * Control number of packets in qdisc/devices to two packets / or =
~1 ms.
> >>>     * (These limits are doubled for retransmits)
> >>> @@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock
> >>> *sk, const struct sk_buff *skb,
> >>>                   limit +=3D extra_bytes;
> >>>           }
> >>>           if (refcount_read(&sk->sk_wmem_alloc) > limit) {
> >>> -               /* Always send skb if rtx queue is empty.
> >>> +               /* Always send skb if rtx queue is empty or has one s=
kb.
> >>>                    * No need to wait for TX completion to call us bac=
k,
> >>>                    * after softirq/tasklet schedule.
> >>>                    * This helps when TX completions are delayed too m=
uch.
> >>>                    */
> >>> -               if (tcp_rtx_queue_empty(sk))
> >>> +               if (tcp_rtx_queue_empty_or_single_skb(sk))
> >>>                           return false;
> >>>
> >>>                   set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
> >> This patch applied on top of Linux 6.1.49, TSO on, gso_max_size 65535,
> >> CONFIG_HZ_100=3Dy
> >>
> >> root@tarragon:/boot# iperf -t 10 -i 1 -c 192.168.1.129
> >> ------------------------------------------------------------
> >> Client connecting to 192.168.1.129, TCP port 5001
> >> TCP window size:  192 KByte (default)
> >> ------------------------------------------------------------
> >> [  3] local 192.168.1.12 port 59714 connected with 192.168.1.129 port =
5001
> >> [ ID] Interval       Transfer     Bandwidth
> >> [  3]  0.0- 1.0 sec  11.5 MBytes  96.5 Mbits/sec
> >> [  3]  1.0- 2.0 sec  11.4 MBytes  95.4 Mbits/sec
> >> [  3]  2.0- 3.0 sec  11.1 MBytes  93.3 Mbits/sec
> >> [  3]  3.0- 4.0 sec  11.2 MBytes  94.4 Mbits/sec
> >> [  3]  4.0- 5.0 sec  11.1 MBytes  93.3 Mbits/sec
> >> [  3]  5.0- 6.0 sec  11.2 MBytes  94.4 Mbits/sec
> >> [  3]  6.0- 7.0 sec  11.2 MBytes  94.4 Mbits/sec
> >> [  3]  7.0- 8.0 sec  11.1 MBytes  93.3 Mbits/sec
> >> [  3]  8.0- 9.0 sec  11.4 MBytes  95.4 Mbits/sec
> >> [  3]  9.0-10.0 sec  11.2 MBytes  94.4 Mbits/sec
> >> [  3]  0.0-10.0 sec   113 MBytes  94.4 Mbits/sec
> >>
> >> The figures are comparable to disabling TSO -> Good
> >>
> >> Thanks
> > Great. I suspect a very slow TX completion from fec then.
> >
> > Could you use the following bpftrace program while your iperf is runnin=
g ?
> unfortuntely there is no bpftrace and most of its dependencies on my
> platform. I looked at some guides and it seems to have a lot of (build)
> dependencies. On a PC this won't be a problem, but on my ARM platform
> there is only 1 GB eMMC space left.
>
> Before investing a lot of time to get bpftrace running, is there an
> alternative solution?

No worries Stefan, I think we do not have to get precise numbers, I
will try to provide a debug patch (since you are able to build custom
kernels)

In the meantime, I will submit the official TCP patch, as you said it
was helping a lot.

Just to confirm, have you tried the patch on top of the latest net tree ?

Thanks.

> >
> > .bpftrace -e '
> > k:__dev_queue_xmit {
> >   $skb =3D (struct sk_buff *)arg0;
> >   if ($skb->fclone =3D=3D 2) {
> >    @start[$skb] =3D nsecs;
> >   }
> > }
> > k:__kfree_skb {
> >   $skb =3D (struct sk_buff *)arg0;
> >   if ($skb->fclone =3D=3D 2 && @start[$skb]) {
> >    @tx_compl_usecs =3D hist((nsecs - @start[$skb])/1000);
> >    delete(@start[$skb]);
> >   }
> > }
> > END { clear(@start); }'
>

