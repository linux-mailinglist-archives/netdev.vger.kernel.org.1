Return-Path: <netdev+bounces-45511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868577DDBE2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 05:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C172817D0
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05515AF;
	Wed,  1 Nov 2023 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6c7XWyu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216911841
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:23:58 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C9107
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:23:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so4344a12.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698812633; x=1699417433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgvHbW/AzZmuaE27d4jC/HnAUjq/JULc2LZSQeqWSVY=;
        b=v6c7XWyuYbmfc3gwm9HOaCe9mrp51w1tiP4vs7xTKh7JwutJHUydsEhi70fw84MD0i
         y3nXTyUIOrJrgAFeHoheS067C6HOgZua4AyG/MIKmjAXQX9uf3pQK3RfnH3YTHLHbpoC
         GGUQGzQPyTjT+tyCaNlNRGI1iDE+7IgTNFgKA6DsQb6oReH79XCCni+m0eINk/u3I0xJ
         5YNQ1MvoSbvxEgFnLlNYE6IH4VDuT+hlN9SMwLdAKKyCCi+kxPw83yz1tULHWn2N9Roa
         Rg1/P6c8LC54JwsjF0lBpSOC3STmoQTsYFrAAOwJ9UJ53zxKVbNlIYQUtkN6cC0hAeBj
         kTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698812633; x=1699417433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgvHbW/AzZmuaE27d4jC/HnAUjq/JULc2LZSQeqWSVY=;
        b=TnOuCEPzrYwoEZQcGlOsChGwtT2Xj6HBynXNvKWVA1LKf0WTpZHIQTIXNC/3ViH6D/
         vQO9edS4hulP04qcW/W12L6iBKs6ZNnPppqXIE2gIducQJpHkO/4l2Yfktv84M+FBDLu
         orlE3Zox+PBtbHpVq9LDfA3w2ThsSddpNBL72Dy3S9ZgmhARGpjEPlKaA2kf2A8qdkct
         OuO1tscxdaWulfdU8BMXKyrslsUwklYqe8y8CxHYjqADXIux+9CsVXI9uS5W3DDH75eN
         D823vefSj6OKM3fYHaMf2WED0KvRNeOSvFeKnlu9yMSxaxu6C16GnG0eGBbhK2euD8l+
         3Nhg==
X-Gm-Message-State: AOJu0YweKftch1O/FG9r1FWIXFFl4I5TKTBtjxCVo5X0Vjsv/C+fCpvc
	By3PZ1Ot6AhtkB/Ad627v8pX9e09OCks8PMP0JB/Fg==
X-Google-Smtp-Source: AGHT+IG3oi4KM7HhpbmidqTpjKbWEeJC6NZOVDxCbLqJoSOFd6tMDlUHKMHDkWPd4W7L+xinBdf1vU7rJ/ptnsLzBkA=
X-Received: by 2002:a05:6402:1943:b0:543:74af:dfee with SMTP id
 f3-20020a056402194300b0054374afdfeemr199996edz.5.1698812633332; Tue, 31 Oct
 2023 21:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030084529.2057421-1-edumazet@google.com> <4053721c-8207-4793-8f43-7207a1454d63@arista.com>
 <b3f9ae14-0cf6-4587-8d2a-9db1661746cc@arista.com> <CANn89iLzYCuUvKmw-4yiB-FBOtLnk0MmzM-h3Kvgn7qDpQg9bQ@mail.gmail.com>
In-Reply-To: <CANn89iLzYCuUvKmw-4yiB-FBOtLnk0MmzM-h3Kvgn7qDpQg9bQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Nov 2023 05:23:39 +0100
Message-ID: <CANn89i+Oru1kXuL+o8p-JPRKJxC9Cc=oXe-002hPoP_Kxq79GQ@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp: fix possible out-of-bounds reads in tcp_hash_fail()
To: Dmitry Safonov <dima@arista.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Francesco Ruggeri <fruggeri05@gmail.com>, Salam Noureddine <noureddine@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 4:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Nov 1, 2023 at 1:02=E2=80=AFAM Dmitry Safonov <dima@arista.com> w=
rote:
> >
> > Hi Eric,
> >
> > On 10/30/23 17:47, Dmitry Safonov wrote:
> > > On 10/30/23 08:45, Eric Dumazet wrote:
> > >> syzbot managed to trigger a fault by sending TCP packets
> > >> with all flags being set.
> > >>
> > >> BUG: KASAN: stack-out-of-bounds in string_nocheck lib/vsprintf.c:645=
 [inline]
> > >> BUG: KASAN: stack-out-of-bounds in string+0x394/0x3d0 lib/vsprintf.c=
:727
> > >> Read of size 1 at addr ffffc9000397f3f5 by task syz-executor299/5039
> > >>
> > >> CPU: 1 PID: 5039 Comm: syz-executor299 Not tainted 6.6.0-rc7-syzkall=
er-02075-g55c900477f5b #0
> > >> Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 10/09/2023
> > >> Call Trace:
> > >> <TASK>
> > >> __dump_stack lib/dump_stack.c:88 [inline]
> > >> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> > >> print_address_description mm/kasan/report.c:364 [inline]
> > >> print_report+0xc4/0x620 mm/kasan/report.c:475
> > >> kasan_report+0xda/0x110 mm/kasan/report.c:588
> > >> string_nocheck lib/vsprintf.c:645 [inline]
> > >> string+0x394/0x3d0 lib/vsprintf.c:727
> > >> vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
> > >> vprintk_store+0x3a0/0xb80 kernel/printk/printk.c:2191
> > >> vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2288
> > >> vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
> > >> _printk+0xc8/0x100 kernel/printk/printk.c:2332
> > >> tcp_inbound_hash.constprop.0+0xdb2/0x10d0 include/net/tcp.h:2760
> > >> tcp_v6_rcv+0x2b31/0x34d0 net/ipv6/tcp_ipv6.c:1882
> > >> ip6_protocol_deliver_rcu+0x33b/0x13d0 net/ipv6/ip6_input.c:438
> > >> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
> > >> NF_HOOK include/linux/netfilter.h:314 [inline]
> > >> NF_HOOK include/linux/netfilter.h:308 [inline]
> > >> ip6_input+0xce/0x440 net/ipv6/ip6_input.c:492
> > >> dst_input include/net/dst.h:461 [inline]
> > >> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> > >> NF_HOOK include/linux/netfilter.h:314 [inline]
> > >> NF_HOOK include/linux/netfilter.h:308 [inline]
> > >> ipv6_rcv+0x563/0x720 net/ipv6/ip6_input.c:310
> > >> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
> > >> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
> > >> netif_receive_skb_internal net/core/dev.c:5727 [inline]
> > >> netif_receive_skb+0x133/0x700 net/core/dev.c:5786
> > >> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
> > >> tun_get_user+0x29e7/0x3bc0 drivers/net/tun.c:2002
> > >> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
> > >> call_write_iter include/linux/fs.h:1956 [inline]
> > >> new_sync_write fs/read_write.c:491 [inline]
> > >> vfs_write+0x650/0xe40 fs/read_write.c:584
> > >> ksys_write+0x12f/0x250 fs/read_write.c:637
> > >> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> > >> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >>
> > >> Fixes: 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited logs"=
)
> > >> Reported-by: syzbot <syzkaller@googlegroups.com>
> > >> Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >> Cc: Dmitry Safonov <dima@arista.com>
> > >> Cc: Francesco Ruggeri <fruggeri@arista.com>
> > >> Cc: David Ahern <dsahern@kernel.org>
> > >
> > > Thanks for fixing this,
> > > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > >
> > >> ---
> > >>  include/net/tcp_ao.h | 5 ++---
> > >>  1 file changed, 2 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> > >> index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..5daf96a3dbee14bd3786=
e19ea4972e351058e6e7 100644
> > >> --- a/include/net/tcp_ao.h
> > >> +++ b/include/net/tcp_ao.h
> > >> @@ -124,7 +124,7 @@ struct tcp_ao_info {
> > >>  #define tcp_hash_fail(msg, family, skb, fmt, ...)                  =
 \
> > >>  do {                                                               =
         \
> > >>      const struct tcphdr *th =3D tcp_hdr(skb);                      =
   \
> > >> -    char hdr_flags[5] =3D {};                                      =
   \
> > >> +    char hdr_flags[5];                                             =
 \
> > >>      char *f =3D hdr_flags;                                         =
   \
> > >>                                                                     =
 \
> > >>      if (th->fin)                                                   =
 \
> > >> @@ -135,8 +135,7 @@ do {                                            =
                         \
> > >>              *f++ =3D 'R';                                          =
   \
> > >>      if (th->ack)                                                   =
 \
> > >>              *f++ =3D 'A';                                          =
   \
> > >> -    if (f !=3D hdr_flags)                                          =
   \
> > >> -            *f =3D ' ';                                            =
   \
> > > Ah, that was clearly typo: I meant "*f =3D 0;"
> >
> > Actually, after testing, I can see that the space was intended as well,
> > otherwise it "sticks" to L3index:
> > [  130.965652] TCP: AO key not found for (10.0.1.1, 56920)->(10.0.254.1=
,
> > 7010) Skeyid: 100 L3index: 0
> > [  131.975116] TCP: AO hash is required, but not found for (10.0.1.1,
> > 52686)->(10.0.254.1, 7011) SL3 index 0
> > [  132.984024] TCP: AO hash mismatch for (10.0.1.1, 51382)->(10.0.254.1=
,
> > 7012) SL3index: 0
> > [  133.992221] TCP: Requested by the peer AO key id not found for
> > (10.0.1.1, 36548)->(10.0.254.1, 7013) SL3index: 0
> >
> >
> > If you don't mind, I'll send an updated version of your patch together
> > with some other small post-merge fixes this week.
>
> I will send a v2, adding the space in the format like this :
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 5daf96a3dbee14bd3786e19ea4972e351058e6e7..b90b4f8fb10fcbb31ddf65b82=
5c098b215a91e67
> 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -137,7 +137,7 @@ do {
>                          \
>                 *f++ =3D 'A';                                            =
 \
>         *f =3D 0;                                                        =
 \
>         if ((family) =3D=3D AF_INET) {                                   =
   \
> -               net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d)
> %s" fmt "\n", \
> +               net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s
> " fmt "\n", \
>                                 msg, &ip_hdr(skb)->saddr, ntohs(th->sourc=
e), \
>                                 &ip_hdr(skb)->daddr, ntohs(th->dest),   \
>                                 hdr_flags, ##__VA_ARGS__);              \


I will also change the format to use tcpdump one:

ACK is represented with a dot.

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b90b4f8fb10fcbb31ddf65b825c098b215a91e67..5ce1f8de0d77a1208bdbe4266e4=
bf2f76089f56c
100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -134,10 +134,10 @@ do {
                         \
        if (th->rst)                                                    \
                *f++ =3D 'R';                                             \
        if (th->ack)                                                    \
-               *f++ =3D 'A';                                             \
+               *f++ =3D '.';                                             \
        *f =3D 0;                                                         \
        if ((family) =3D=3D AF_INET) {                                     =
 \
-               net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s
" fmt "\n", \
+               net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d)
[%s] " fmt "\n", \
                                msg, &ip_hdr(skb)->saddr, ntohs(th->source)=
, \
                                &ip_hdr(skb)->daddr, ntohs(th->dest),   \
                                hdr_flags, ##__VA_ARGS__);              \

