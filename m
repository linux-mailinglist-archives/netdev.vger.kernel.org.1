Return-Path: <netdev+bounces-28316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7A77F06E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD041C2127C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEEE395;
	Thu, 17 Aug 2023 06:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D6A4A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:18:09 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682C12B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:18:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so130011cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692253086; x=1692857886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ujWPUDxBGgKL9MASr9SW4G6iTD5c2hfYcHFvHs4Wsg=;
        b=vpOonIuky7VObM4fnOuJ2GDlM9cq1PWXAJniajWEWbTR3nszlucRhv0Vt6bqk2y4oH
         H4/9MP8R4wTCHbw5jy0DbN3qkTZ8cwN7dloCUL2SkM8Rg3tyANscpOZCvDZm72pNALwp
         HuSXM3osHsqIzihwIK1YrC77cL+zchyblMp9DiKrwZDm7DNgIugi334Nf2NrdXVhlwYd
         zGuu2S/tQj5bIrDC2jdhgQxaK24mOkIEin0UGFFFis0tMZqzRa5k2ClgxuR2B5JHlR7M
         7N+b2WJGFhnw/4JaNPU2z+cbJNNhiuuPDMyugZgl6rJmF73KCy6hmOjpdvyXRqh5v7bI
         qfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692253086; x=1692857886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ujWPUDxBGgKL9MASr9SW4G6iTD5c2hfYcHFvHs4Wsg=;
        b=SVd1Yc1Xerv/xu3uyTUBIHCKY2RTmrAzMUKDQ6vDBq52CDXolSUTCsw5Q+pFgwbRxs
         H9TTFIvU3hQ59pK1mVVsWcxDOhty1qnDSGqG557MD2FehLuqJk8g5d3uu7YmI7UwQl13
         HclSZSF3f8ekUcBHX4aEzquG6d9OP1xuzX0r3UnTU0sIWfMmvWFTrv6P6SdmfCdTMoVH
         A2csdW03gUkpwGOqWbSWBtL8RNbHGte3LczREBMxxUZZ19fx16UxxEqDGtE+3EyAGJ5L
         8jp6Ha0wU5bBNrrTzOPPeRogo0h2sJJnJzYwDD6ayEP8mKxz8Lbv1Kogu1urrduirsJw
         4e4w==
X-Gm-Message-State: AOJu0Yww4v6sUDBUZdie7/GNzWLEITzUgqYgmk1PRzrNzPrksNmLAFmJ
	E+1kb8TiFwhIjApvaF8CR/S/oDvHDMHz65knnZsvqBU9s5QtwcCYY20=
X-Google-Smtp-Source: AGHT+IHDIVO1yVcwJZgGDlkd99+NZde5k3wxaWWA348E57o28+1Y8doTEvwIHcQJXmXZ84RVrJrUMdjIoOuAJaJ+uN0=
X-Received: by 2002:a05:622a:1488:b0:40f:db89:5246 with SMTP id
 t8-20020a05622a148800b0040fdb895246mr106756qtx.21.1692253086322; Wed, 16 Aug
 2023 23:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816142158.1779798-1-edumazet@google.com> <1692238784.742549-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692238784.742549-1-xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 17 Aug 2023 08:17:55 +0200
Message-ID: <CANn89iLNH2_kL8SeAdr84Am9nW4tgk0XQC37mEWkaCf8n6hf7w@mail.gmail.com>
Subject: Re: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 4:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 16 Aug 2023 14:21:58 +0000, Eric Dumazet <edumazet@google.com> wr=
ote:
> > One missing check in virtio_net_hdr_to_skb() allowed
> > syzbot to crash kernels again [1]
> >
> > Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
> > because this magic value is used by the kernel.
> >
> > [1]
> > general protection fault, probably for non-canonical address 0xdffffc00=
0000000e: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-20230=
809-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/26/2023
> > RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
> > Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 48=
 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 =
84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
> > RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
> > RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
> > RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
> > R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
> > R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
> > FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:000000000000=
0000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> > <TASK>
> > udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
> > ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
> > skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
> > __skb_gso_segment+0x339/0x710 net/core/gso.c:124
> > skb_gso_segment include/net/gso.h:83 [inline]
> > validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
> > __dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
> > dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> > packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> > packet_snd net/packet/af_packet.c:3087 [inline]
> > packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
> > sock_sendmsg_nosec net/socket.c:727 [inline]
> > sock_sendmsg+0xd9/0x180 net/socket.c:750
> > ____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
> > ___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
> > __sys_sendmsg+0x117/0x1e0 net/socket.c:2579
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7ff27cdb34d9
> >
> > Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index bdf8de2cdd935d31449b78e1b9c67fdcdc537bf2..7b4dd69555e497497460dcf=
5d72737fe5c09fd53 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -155,6 +155,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_=
buff *skb,
> >               if (gso_type & SKB_GSO_UDP)
> >                       nh_off -=3D thlen;
> >
> > +             /* Kernel has a special handling for GSO_BY_FRAGS. */
> > +             if (gso_size =3D=3D GSO_BY_FRAGS)
> > +                     return -EINVAL;
> > +
>
>
> I guess the crash happens when user sends packets via af_packet and gso i=
s set
> to GSO_BY_FRAGS by user.
>
> But I wonder is 0xffff also an invalid value on the rx path?
>
> We know that this function virtio_net_hdr_to_skb is also used by the virt=
io-net
> driver on the rx path. This change means that virtio-net devices should n=
ot set
> gso to 0xffff. But the virtio spec doesn't say that the rx gso value 0xff=
ff is
> invalid.
>
> So I think we should not add check in this function.


I think we do.

Think about it, how gso_size =3D=3D 0xffff , or even 0xfff0 could be valid =
?

We are not going to add more core in core network fast path, for
something that can not happen with kernel stacks.

It is time someone clarifies virtio_specs, because 0xffff is
absolutely a no go, even before blamed commit.

