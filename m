Return-Path: <netdev+bounces-49741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D87F3506
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5539E28263A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17723D390;
	Tue, 21 Nov 2023 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9PFj/IL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C580126
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:37:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so18444a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700588249; x=1701193049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqbzBJGy9XkjHDkPMr6F39OpVI/ClMjw4Rc5jgSf31E=;
        b=y9PFj/IL9aKLwKhWuqTIv58DnCd7m5FEXgpAlA4BqADH8huWDGJu7oL1n7ykKwNlvv
         7jA33rWdC30E4SmX56yqrzAc28zFVcnX1CvnaKKeovhKdWtaB5F5ch7Pn8+lf68JcQJi
         E9r/LS81HYrro6FGAYp+cmpRiEbxNtcxIipxEXnNi/POSBfuNbnqUSotXzGQWa1ReC3R
         DtyUZ7u4npP1Hoq6Ds4HC5yDqJ/WhagKvhJj/Mdzn09jS4YmrTatfpfvF244Orh0K3aU
         8bGfwcZdpTW1eQnDgG0SEl8jMdeluJiflrbLqVM1s4zG/zmATyllVPg4IRtfq+9+Vhjn
         6ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588249; x=1701193049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqbzBJGy9XkjHDkPMr6F39OpVI/ClMjw4Rc5jgSf31E=;
        b=mG6QXl+a9ylvUvbaGrfCAbHtkhUnBqaODR+pUJLZ5tHGZ407/rZuvNiAuEZ8Vz+Xbm
         sM7ErJbnbTdOzgSEt0QzZ7nHNCE4zfLKNACARU5TK0VoJDR+H8nrAa1CQIWgQ2sR2AlQ
         JWqpt8vfROZoDI37jjiTgTKhLV86p1uyvzDrO+5SAvt7wq3h2q857rCRcmRF6dA58d8d
         1CE/KdE62Pt4ubonPj1CyUTVYZod4mvp2vYhjiRNo2UiERLX0vgOZC1EdwqPj11D34mv
         NIsruWypm9tkxEoStPZmcca1gx/rv+mmlTjQSOnSQ4DyvuqHkxU+BNVYKOalBP1x+Pfg
         Bthw==
X-Gm-Message-State: AOJu0Yxt9XvNKL3rL/d9zepYOjjI8WT4JaVR5kyTBA8LWQVXAOFX5ms7
	i/gVfcGeM3OJXcvPBFMUQ4f9ypUxCKdrEAcBWrVmXg==
X-Google-Smtp-Source: AGHT+IHdoRsEsNgFc2g/2m6NdLOTt8MyB2nbNLGhomW46oVEwMAqbUEo7OldGanUJxDgqYrdDwzx+6ft8+d/uO9tG4I=
X-Received: by 2002:a05:6402:2911:b0:544:f741:62f4 with SMTP id
 ee17-20020a056402291100b00544f74162f4mr1327edb.0.1700588248497; Tue, 21 Nov
 2023 09:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020558.240321-1-shaozhengchao@huawei.com>
In-Reply-To: <20231121020558.240321-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Nov 2023 18:37:15 +0100
Message-ID: <CANn89i+zX5-xdXo0nezZiXS2+JXvcr-nsmaCmc8gNzuB5Xg5hQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: igmp: fix refcnt uaf issue when receiving igmp
 query packet
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 2:53=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I perform the following test operations:
> 1.ip link add br0 type bridge
> 2.brctl addif br0 eth0
> 3.ip addr add 239.0.0.1/32 dev eth0
> 4.ip addr add 239.0.0.1/32 dev br0
> 5.ip addr add 224.0.0.1/32 dev br0
> 6.while ((1))
>     do
>         ifconfig br0 up
>         ifconfig br0 down
>     done
> 7.send IGMPv2 query packets to port eth0 continuously. For example,
> ./mausezahn ethX -c 0 "01 00 5e 00 00 01 00 72 19 88 aa 02 08 00 45 00 00
> 1c 00 01 00 00 01 02 0e 7f c0 a8 0a b7 e0 00 00 01 11 64 ee 9b 00 00 00 0=
0"
>
> The preceding tests may trigger the refcnt uaf isuue of the mc list. The
> stack is as follows:
>         refcount_t: addition on 0; use-after-free.
>         WARNING: CPU: 21 PID: 144 at lib/refcount.c:25 refcount_warn_satu=
rate+0x78/0x110
>         CPU: 21 PID: 144 Comm: ksoftirqd/21 Kdump: loaded Not tainted 6.7=
.0-rc1-next-20231117-dirty #57
>         RIP: 0010:refcount_warn_saturate+0x78/0x110
>         Call Trace:
>         <TASK>
>         ? __warn+0x83/0x130
>         ? refcount_warn_saturate+0x78/0x110
>         ? __report_bug+0xea/0x100
>         ? report_bug+0x24/0x70
>         ? handle_bug+0x3c/0x70
>         ? exc_invalid_op+0x18/0x70
>         igmp_heard_query+0x221/0x690
>         igmp_rcv+0xea/0x2f0
>         ip_protocol_deliver_rcu+0x156/0x160
>         ip_local_deliver_finish+0x77/0xa0
>         __netif_receive_skb_one_core+0x8b/0xa0
>         netif_receive_skb_internal+0x80/0xd0
>         netif_receive_skb+0x18/0xc0
>         br_handle_frame_finish+0x340/0x5c0 [bridge]
>         nf_hook_bridge_pre+0x117/0x130 [bridge]
>         __netif_receive_skb_core+0x241/0x1090
>         __netif_receive_skb_list_core+0x13f/0x2e0
>         __netif_receive_skb_list+0xfc/0x190
>         netif_receive_skb_list_internal+0x102/0x1e0
>         napi_gro_receive+0xd7/0x220
>         e1000_clean_rx_irq+0x1d4/0x4f0 [e1000]
>         e1000_clean+0x5e/0xe0 [e1000]
>         __napi_poll+0x2c/0x1b0
>         net_rx_action+0x2cb/0x3a0
>         __do_softirq+0xcd/0x2a7
>         run_ksoftirqd+0x22/0x30
>         smpboot_thread_fn+0xdb/0x1d0
>         kthread+0xe2/0x110
>         ret_from_fork+0x34/0x50
>         ret_from_fork_asm+0x1a/0x30
>         </TASK>


Please include symbols in stack traces, otherwise they are not precise enou=
gh.

scripts/decode_stacktrace.sh is your friend.

git grep -n scripts/decode_stacktrace.sh -- Documentation/admin-guide

>
> The root causes are as follows:
> Thread A                                        Thread B
> ...                                             netif_receive_skb
> br_dev_stop                                     ...
>     br_multicast_leave_snoopers                 ...
>         __ip_mc_dec_group                       ...
>             __igmp_group_dropped                igmp_rcv
>                 igmp_stop_timer                     igmp_heard_query     =
    //ref =3D 1
>                 ip_ma_put                               igmp_mod_timer
>                     refcount_dec_and_test                   igmp_start_ti=
mer //ref =3D 0
>                         ...                                     refcount_=
inc //ref increases from 0
> When the device receives an IGMPv2 Query message, it starts the timer
> immediately, regardless of whether the device is running. If the device i=
s
> down and has left the multicast group, it will cause the mc list refcount
> uaf issue.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv4/igmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 76c3ea75b8dd..f217581904d6 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1044,6 +1044,8 @@ static bool igmp_heard_query(struct in_device *in_d=
ev, struct sk_buff *skb,
>         for_each_pmc_rcu(in_dev, im) {
>                 int changed;
>
> +               if (!netif_running(im->interface->dev))
> +                       continue;

This seems racy to me.

I guess igmp_start_timer() should use refcount_inc_not_zero() instead.

>                 if (group && group !=3D im->multiaddr)
>                         continue;
>                 if (im->multiaddr =3D=3D IGMP_ALL_HOSTS)
> --
> 2.34.1
>

