Return-Path: <netdev+bounces-13463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861573BAFB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9937281C35
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2182AD2D;
	Fri, 23 Jun 2023 15:04:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549BAD24
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:04:19 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A510F6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:04:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f86dbce369so946281e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687532654; x=1690124654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGYHOc5LeADX5+ikNJ6c7uGuBsKey/dp9FbnAG1WZQs=;
        b=UJkdRteLdMQKDEk2ttizfqUK4IPjBHqoryIq2FLXt5GNXxn59YPhTjN8FVyaCUzdra
         CL0gMvRq/e91BYVoXnYNkIwTmawpcdxiI/xEExmaCNPS8WNgaQsFnWJb6qsTl0oZakRH
         6uHxpbu+AcUgFp6//agdpmpxvk8Uotr1LpqvG4Q8dCm+kX6Eelrq8pVJmHyMfv5Yic53
         Q9kDGpW4/N49k8iOj3ivYd827GXw2GPRiUCDMxtKlOX7C74nRljC/2q67VWoptR8UP/q
         tgyJ3ZY+/4BpXHeaD3C8bD64418MF5JYPSo5jK+ND0EYPWM3Nnp+tk2zJg9vN3aACcuZ
         QCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532654; x=1690124654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGYHOc5LeADX5+ikNJ6c7uGuBsKey/dp9FbnAG1WZQs=;
        b=Uy0wCBg9Tn4mftH5N1YlL1lnVyXXOeL5np31cTw6qsmFNLjGSf61i63DJJWr+/xhRz
         OWiO0yzvsUxiv6gzVbHBk/TPaLg1NzfVC9Xy9f46TOk0VK1WVJILe0aKy3PkxRc7c1A2
         l93p417Iu3CrgKCq9QR+mmY2qdUDE7n2ykObO/BP4Z23CBCUjE0MhwN8viw6ga+vrJnO
         F8YVIK/fRjqzqRO+yiLBD6QajyCd5ftvrqiFHHVNOe021OBVhs0BJ/4yjpwdhnIn0tR5
         YKkrwYFqR/6NzsRuuiYdefzyDp4TOjvsYWZc3MFpKbgfIj87mKJJubzBsysi6gqe6wsF
         yADQ==
X-Gm-Message-State: AC+VfDx8WtlnQ1ZfwkbCWXtTVbzjrI45Wz5SpDVkxtpsbdYHBV6dUgGg
	5SyelDn0vAyOwh5ChVkz9Nyy8+hkyPTskhafsTQ=
X-Google-Smtp-Source: ACHHUZ7f4HTDisO67aKloeL1203agw/YmYc4v0fXQ9zcVj1TPahZuDh7yVVB3mS0H7woMlomSs3H6A==
X-Received: by 2002:ac2:4d9a:0:b0:4f8:66ec:6ed7 with SMTP id g26-20020ac24d9a000000b004f866ec6ed7mr12609213lfe.30.1687532654353;
        Fri, 23 Jun 2023 08:04:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l9-20020aa7c309000000b005187a57fba1sm5355606edq.77.2023.06.23.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:04:13 -0700 (PDT)
Date: Fri, 23 Jun 2023 17:04:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Jarod Wilson <jarod@redhat.com>, Moshe Tal <moshet@nvidia.com>,
	Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
Message-ID: <ZJW0bCDv1jr9qBrC@nanopsycho>
References: <20230622152304.2137482-1-edumazet@google.com>
 <ZJV9B3I0veBOsRYM@nanopsycho>
 <CANn89i+WGsUCUutydoR7cxgZAshAwCOAq=86TaLpVU9G3BQdbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+WGsUCUutydoR7cxgZAshAwCOAq=86TaLpVU9G3BQdbg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jun 23, 2023 at 04:28:16PM CEST, edumazet@google.com wrote:
>On Fri, Jun 23, 2023 at 1:07 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 22, 2023 at 05:23:04PM CEST, edumazet@google.com wrote:
>> >Drivers must not assume in their ndo_start_xmit() that
>> >skbs have their mac_header set. skb->data is all what is needed.
>> >
>> >bonding seems to be one of the last offender as caught by syzbot:
>> >
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset include/linux/skbuff.h:2913 [inline]
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
>> >WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
>> >Modules linked in:
>> >CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
>> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
>> >RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
>> >RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
>> >RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
>> >RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
>> >RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
>> >RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
>> >RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
>> >Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe e9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
>> >RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
>> >RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
>> >RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
>> >RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
>> >R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
>> >R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
>> >FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
>> >CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
>> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >Call Trace:
>> ><TASK>
>> >[<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
>> >[<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
>> >[<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inline]
>> >[<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet.c:284
>> >[<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
>> >[<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c:3143
>> >[<ffffffff8467a4b2>] sock_sendmsg_nosec net/socket.c:716 [inline]
>> >[<ffffffff8467a4b2>] sock_sendmsg net/socket.c:736 [inline]
>> >[<ffffffff8467a4b2>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
>> >[<ffffffff8467a715>] __do_sys_sendto net/socket.c:2151 [inline]
>> >[<ffffffff8467a715>] __se_sys_sendto net/socket.c:2147 [inline]
>> >[<ffffffff8467a715>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
>> >[<ffffffff8553071f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> >[<ffffffff8553071f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
>> >[<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> >
>> >Fixes: 7b8fc0103bb5 ("bonding: add a vlan+srcmac tx hashing option")
>> >Reported-by: syzbot <syzkaller@googlegroups.com>
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >Cc: Jarod Wilson <jarod@redhat.com>
>> >Cc: Moshe Tal <moshet@nvidia.com>
>> >Cc: Jussi Maki <joamaki@gmail.com>
>> >Cc: Jay Vosburgh <j.vosburgh@gmail.com>
>> >Cc: Andy Gospodarek <andy@greyhouse.net>
>> >Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >---
>> > drivers/net/bonding/bond_main.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> >index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1c0f26d185dc8ff5e3 100644
>> >--- a/drivers/net/bonding/bond_main.c
>> >+++ b/drivers/net/bonding/bond_main.c
>> >@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
>> >               return skb->hash;
>> >
>> >       return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
>> >-                              skb_mac_offset(skb), skb_network_offset(skb),
>> >+                              0, skb_network_offset(skb),
>>
>> After this change, both callers of __bond_xmit_hash() pass 0 as mhoff.
>> Wouldn't it make sense to remove this arg entirely here and in
>> bond_vlan_srcmac_hash() and bond_eth_hash()?
>>
>>
>> >                               skb_headlen(skb));
>> > }
>
>Yes, this was mentioned by Jay yesterday, and we agreed to remove the
>parameter on net-next.

Yeah, I noticed that after I hit send button. :/

>
>The reason for that is that stable teams might have a hard time,
>because of the various commits
>in different linux versions that heavily changed this code.

Sounds good. Thanks!


