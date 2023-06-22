Return-Path: <netdev+bounces-13156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507073A84A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1341D281A7B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5D1F923;
	Thu, 22 Jun 2023 18:32:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3B1E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:32:40 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A136210B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:32:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4007b5bafceso26501cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687458758; x=1690050758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHDpSSoTGdAM3PFtfqJw8IsJG70AiU4TrAFPsOR4mm0=;
        b=rLWus8kT+bA+MNmxUsxqy9oETh7bRYfFKltIb8wZ7Jqqtj9HJbh/qy4ecUi1I6VOzW
         XQUj3u5S/GMjxWtUFLQK05+YYqhGhAdv6RHJVAP6CcWU0LOJB2pB/LOaQWhf0XJGZD5Q
         ckbUdqm7Go76T5OkpfOljDnU4r1asMbXkHq3gPhrJcKqztypk6TMJgs9x82QNfGqkfIe
         0RBUC2F6JDL6rk1fkI+DlpnBEzHm2L18Deiu5cOqO/5wLYAK5VGRshf0bpk9/yQp7vzD
         mVIZ3zsshZmpcoS/B+QLrh7oCn1i7tzo2fqxjX+eCpdJLVoo5DZj0A5zJw9AGxe2Fgcn
         0dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458758; x=1690050758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHDpSSoTGdAM3PFtfqJw8IsJG70AiU4TrAFPsOR4mm0=;
        b=SjIkz+Ebf137nPQtsXjX2pTYST9GrPWU21+S4JCxhxbgAEHj6s0qGdIdJlzmarSMv2
         XbGIm1I2B2hEETKFaSm4v4JhLxR1WLEYoWM3xR3bqmzNRnzIXZpZGd4b4vZH62wgEhAr
         b85eCne2tOpG9OmCzYlzyBLI7YI06C0zzZwl+j/euu1sYt1WVVfdJsDkFgfa0smIAHfC
         ASTL/vg/3sWHZ6GWyUyv0zMtyOYjlaudlBTbcWuh3AIvBeW4OM60KoUKxqn/QiGQ3fYN
         zDKqBpsEOqSs2+UMdcUt424BV1fLpUyVdvu19Rhw7HJTT9pwWbIT9MudFj6E9MuuvVuV
         nRzQ==
X-Gm-Message-State: AC+VfDwN3h0JccCgQrMJPOQJAwfZjhgcB0tClnAjsIxqxNt5m505JT+W
	lxzvUHkrmh+f+aaPFwqi7h8DQIoJzvLR1vlPN/FhpKTkQWKswTFwa8RcjQ==
X-Google-Smtp-Source: ACHHUZ4K3L8F+yOIp0rGlgC0xWIIE9Bgvmhmc7rDm9CQtuiQlFlahNoq3A33hqJDBI0rC7N9GDGG8P7mZvvfHuFSaxM=
X-Received: by 2002:ac8:5954:0:b0:3ef:3083:a437 with SMTP id
 20-20020ac85954000000b003ef3083a437mr535218qtz.18.1687458758393; Thu, 22 Jun
 2023 11:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622152304.2137482-1-edumazet@google.com> <22643.1687456107@famine>
In-Reply-To: <22643.1687456107@famine>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 20:32:27 +0200
Message-ID: <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>, 
	Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 7:48=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>
> Eric Dumazet <edumazet@google.com> wrote:
>
> >Drivers must not assume in their ndo_start_xmit() that
> >skbs have their mac_header set. skb->data is all what is needed.
> >
> >bonding seems to be one of the last offender as caught by syzbot:
> >
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset=
 include/linux/skbuff.h:2913 [inline]
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash=
 drivers/net/bonding/bond_main.c:4170 [inline]
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_=
xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_x=
mit drivers/net/bonding/bond_main.c:5186 [inline]
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_x=
mit drivers/net/bonding/bond_main.c:5442 [inline]
> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmi=
t+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
> >Modules linked in:
> >CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 05/25/2023
> >RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
> >RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
> >RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
> >RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:51=
49 [inline]
> >RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline=
]
> >RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline=
]
> >RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:=
5470
> >Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe =
e9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f=
8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
> >RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
> >RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
> >RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
> >RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
> >R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
> >R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
> >FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000=
000
> >CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >Call Trace:
> ><TASK>
> >[<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [i=
nline]
> >[<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
> >[<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inl=
ine]
> >[<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet=
.c:284
> >[<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
> >[<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c=
:3143
> >[<ffffffff8467a4b2>] sock_sendmsg_nosec net/socket.c:716 [inline]
> >[<ffffffff8467a4b2>] sock_sendmsg net/socket.c:736 [inline]
> >[<ffffffff8467a4b2>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
> >[<ffffffff8467a715>] __do_sys_sendto net/socket.c:2151 [inline]
> >[<ffffffff8467a715>] __se_sys_sendto net/socket.c:2147 [inline]
> >[<ffffffff8467a715>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
> >[<ffffffff8553071f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >[<ffffffff8553071f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
> >[<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> >Fixes: 7b8fc0103bb5 ("bonding: add a vlan+srcmac tx hashing option")
> >Reported-by: syzbot <syzkaller@googlegroups.com>
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Jarod Wilson <jarod@redhat.com>
> >Cc: Moshe Tal <moshet@nvidia.com>
> >Cc: Jussi Maki <joamaki@gmail.com>
> >Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> >Cc: Andy Gospodarek <andy@greyhouse.net>
> >Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> >---
> > drivers/net/bonding/bond_main.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
> >index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1c=
0f26d185dc8ff5e3 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk=
_buff *skb)
> >               return skb->hash;
> >
> >       return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
> >-                              skb_mac_offset(skb), skb_network_offset(s=
kb),
> >+                              0, skb_network_offset(skb),
> >                               skb_headlen(skb));
> > }
>
>         Is the MAC header guaranteed to be at skb->data, then?  If not,
> then isn't replacing skb_mac_offset() with 0 going to break the hash (as
> it might or might not be looking at the actual MAC header)?
>

In ndo_start_xmit(), skb->data points to MAC header by definition.

>         Also, assuming for the moment that this change is ok, this makes
> all callers of __bond_xmit_hash() supply zero for the mhoff parameter,
> and a complete fix should therefore remove the unused parameter and its
> various references.

Not really: bond_xmit_hash_xdp() calls __bond_xmit_hash() with
sizeof(struct ethhdr)

