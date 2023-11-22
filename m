Return-Path: <netdev+bounces-50077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517377F4895
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ADA1C209D0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A3F4C3B6;
	Wed, 22 Nov 2023 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQCzOAF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6797
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 06:13:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so15561a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700662412; x=1701267212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUh/q6b7rhIOY6W4Y7ygddG31KtFPwXanCKhNs12CO4=;
        b=pQCzOAF59bC6cC/qjGFvcx8F62eftNiav7lyNewWA3KGpg1RqV3VkUTn6nPrPP9QvY
         aFjOUEcFpEc7LqL7RbiwXlDUy7WM0vf0+rclVt5OXB6Oo9ZFj+3P8h18DgPEX+lpRxQG
         KJrsr7DOQA04E802Kq4sTSDvvUCYyDBE+9YNIbA0KAMS9xa/JrYYhCEHxXNi1jCMWSmD
         I3en9BTxC/hQAjBKDotRKqUN49dYzFdfuW2rtLMPZRa4yOhUbwh/EJD6SPQNOMRg0Us8
         HqGTPWm6GGZ5KsCyw5YGS4Z7sMK2N5vUZmO9Uuf3515SJKmyRLmByNXXFjxyUBvgQzWO
         WrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662412; x=1701267212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUh/q6b7rhIOY6W4Y7ygddG31KtFPwXanCKhNs12CO4=;
        b=UNalcsA4PnWSQti6IDaT5P0reHfRagOINM6ZD00KQHhEGH3gzGrCxOGCN0Nx9TnVdx
         Q7TPfXh938ZI+W9bR2ruR36GU1WBkKq74c2kj4hzZcYN2cNrbEbCeiuxxL1fKtI8T7Zh
         t7Xhq4/UdjWoavEYSqd62x6wOyF0aeMV5x7iK+mwnROY3ZV2Rzx3SNi2AZUXZ99wpanR
         Sfh9wmNz2drrKrxcCxUyx4gS/B5+3TVjIcjkKlHqF5cWfAzKCBdXhjKqBZbwqPWOI4oZ
         16siD+oGpGktG27QHvad+xXjqzixIulQYqF1f4/kw/OoTDs0paHlsb5eyuq1lN7R6fHM
         S6OA==
X-Gm-Message-State: AOJu0YwcoKoKDgIMD7MMDK9dY2xX0Ni5nWIpQ7mzxfoxVLvPNqYz5dTX
	h5YbNVz14w6GHNNKp2SWikYHeKHuEZyUjsQSmIOAQ35fUkChTQpsIkoh2w==
X-Google-Smtp-Source: AGHT+IGEeW/c4DGpgAw3e0gUHzN1NkXwYZIGfLe5MWadb7Uor0hzuxRVYQXqzU3likiDRTMTkHuPr2CHsSEYO5JU0Ks=
X-Received: by 2002:a05:6402:3815:b0:544:466b:3b20 with SMTP id
 es21-20020a056402381500b00544466b3b20mr108231edb.5.1700662411805; Wed, 22 Nov
 2023 06:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122042936.1831735-1-shaozhengchao@huawei.com>
In-Reply-To: <20231122042936.1831735-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 15:13:18 +0100
Message-ID: <CANn89i+5+UA3bVb_RxpY_fW_7KcFJXjR-SGV29USLZ77psG9fQ@mail.gmail.com>
Subject: Re: [PATCH net,v2] ipv4: igmp: fix refcnt uaf issue when receiving
 igmp query packet
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:17=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
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
> The preceding tests may trigger the refcnt uaf issue of the mc list. The
> stack is as follows:
>         refcount_t: addition on 0; use-after-free.
>         WARNING: CPU: 21 PID: 144 at lib/refcount.c:25 refcount_warn_satu=
rate+0x78/0x110
>         CPU: 21 PID: 144 Comm: ksoftirqd/21 Kdump: loaded Not tainted 6.7=
.0-rc1-next-20231117-dirty #57
>         RIP: 0010:refcount_warn_saturate+0x78/0x110
>         Call Trace:
>         <TASK>
>         __warn+0x83/0x130
>         refcount_warn_saturate+0x78/0x110
>         igmp_start_timer
>         igmp_mod_timer
>         igmp_heard_query+0x221/0x690
>         igmp_rcv+0xea/0x2f0
>         ip_protocol_deliver_rcu+0x156/0x160
>         ip_local_deliver_finish+0x77/0xa0
>         __netif_receive_skb_one_core+0x8b/0xa0
>         netif_receive_skb_internal+0x80/0xd0
>         netif_receive_skb+0x18/0xc0

Yet no symbols...

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
> v2: use cmd "cat messages |/root/linux-next/scripts/decode_stacktrace.sh
>     /root/linux-next/vmlinux" to get precise stack traces and check wheth=
er
>     the im is destroyed before timer is started.

I do not think you understood the point I made.

Look at commit 9fce92f050f448a ("mptcp: deal with large GSO size")
for a good example of what a stack trace should look like.


> ---
>  net/ipv4/igmp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 76c3ea75b8dd..efeeca2b1328 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -216,8 +216,10 @@ static void igmp_start_timer(struct ip_mc_list *im, =
int max_delay)
>         int tv =3D get_random_u32_below(max_delay);
>
>         im->tm_running =3D 1;
> -       if (!mod_timer(&im->timer, jiffies+tv+2))
> -               refcount_inc(&im->refcnt);
> +       if (refcount_inc_not_zero(&im->refcnt)) {
> +               if (mod_timer(&im->timer, jiffies + tv + 2))
> +                       ip_ma_put(im);
> +       }
>  }
>
>  static void igmp_gq_start_timer(struct in_device *in_dev)
> --
> 2.34.1
>

