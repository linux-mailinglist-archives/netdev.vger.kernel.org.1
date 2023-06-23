Return-Path: <netdev+bounces-13449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F296F73BA28
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DF81C2126C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F209466;
	Fri, 23 Jun 2023 14:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05EAD36
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:28:31 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4326A4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:28:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so256131cf.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530508; x=1690122508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o626op6/svLu2/ZptzdDiCwFidzjfZrTqJvzbhu5eac=;
        b=qVw/DpWrkQnnkrSto7O+Z6SskNXWoE2Sos1SK1oAXXLujflonVi6kI9p5QEm0UyQbV
         lOQM3hKmWO0tSWJVVOo4ssxqTkU6UoBVZ1c8GAox+MNBOnkxFefvMVm15ryEmmkhYufm
         1aj9W4ihmlGKhxsLH9ilN0jc5IO3giH8dbdr1asIu+man9bOViZSfMKaaPftI87QbSL5
         kVz+QVblUdEjI85Ch2zwT7a7wZ8nwO4OhJg73infesFY2nDIQF0L5CP5Uh9htNthFeEd
         4zDAnQATRGz1k5EUYgrNpU7r39KsmUHnAxM412RnJOTBKxU1Y3G9onLa27rqLPUiN9un
         ypHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530508; x=1690122508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o626op6/svLu2/ZptzdDiCwFidzjfZrTqJvzbhu5eac=;
        b=U87SQlTZ2k3eii4AaIGO4pGQs/YwRkPA5SCZKs3BplAcqbd0Df9gzv0DcSb1kQDbm7
         BBZ61crOhOhL4R0ImdDv56JHEeuPth/mIDUft/jYDNmTrr6ymYMi4w1RqmoU5Vj7d420
         Hd74wvY6nZkmKIgjVdgrG8brgN6Seg1yZ4+Wxia1aI/UBoRNQ0rAOn8hzn+edwtxrAkp
         2aGFG3b5aQALxkDq7fbC+x+wkckLCTayMsQIlV7pOZaKKRF0eSeLPorq06Y+srVfXJoA
         JHA382yBvb8cbFQPNG8+aHcnJItMXT0Gv9kRVWhSDFAYqAXwSE12OLdeDvyMAOBIFgOC
         xEJQ==
X-Gm-Message-State: AC+VfDyleDzkL5JVOW7FaKoSxsbKpe9RT04zir1/4DuLSyfuEwMyjUgi
	t0hxJLaz0k9VmYONk7SAEuMJ4cJXrpLc96fqGM9yplN6PM2fCpd3kds=
X-Google-Smtp-Source: ACHHUZ7u2XdPhMsZHGibYsgQ1NIRmcx6VdVP7KgCvy5K9E8loPpF2JxT3OSYNWueG+b1VBxkXKJB+2MTNcbYOQj/Q9w=
X-Received: by 2002:a05:622a:1aa8:b0:3ed:210b:e698 with SMTP id
 s40-20020a05622a1aa800b003ed210be698mr120573qtc.7.1687530507746; Fri, 23 Jun
 2023 07:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622152304.2137482-1-edumazet@google.com> <ZJV9B3I0veBOsRYM@nanopsycho>
In-Reply-To: <ZJV9B3I0veBOsRYM@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jun 2023 16:28:16 +0200
Message-ID: <CANn89i+WGsUCUutydoR7cxgZAshAwCOAq=86TaLpVU9G3BQdbg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>, 
	Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 1:07=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jun 22, 2023 at 05:23:04PM CEST, edumazet@google.com wrote:
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
>
> After this change, both callers of __bond_xmit_hash() pass 0 as mhoff.
> Wouldn't it make sense to remove this arg entirely here and in
> bond_vlan_srcmac_hash() and bond_eth_hash()?
>
>
> >                               skb_headlen(skb));
> > }

Yes, this was mentioned by Jay yesterday, and we agreed to remove the
parameter on net-next.

The reason for that is that stable teams might have a hard time,
because of the various commits
in different linux versions that heavily changed this code.

