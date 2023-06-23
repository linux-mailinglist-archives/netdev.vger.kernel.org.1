Return-Path: <netdev+bounces-13370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837973B5D6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB7C1C21166
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E3230EE;
	Fri, 23 Jun 2023 11:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F59230EC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:07:58 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0692210F4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 04:07:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bea30ccbcso470181a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687518473; x=1690110473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ol78TSXIutFf0d6kJqjkSHWJiaqpUNfS/uxfMotewwg=;
        b=LwQvrkLQYbyW2QB2DymvYkqTqbNzJxAuP9fxOySjeIcliyXBhRe/RF15IjZe4ZdI2k
         G9l2OYy8LsUlIPdy+Wv4eXTt8T9pUjEBpTo+QF36Wf0VtuA5B4Vr8fCNw1GjOa9Ncjzt
         sKtZaZPGsK/CnFYmDKcyant/iASefqBZayMgb2FOdS34dUCOBpkROT1gv8TvnnW0zzOQ
         vVPztrN39ebvV9VggWXbngGVcb4rwjet/nU/aNLkN9p5dRpDGDiKlD/j2ievrJmLnwsN
         fl5XE+K8zJ9EKRD9bHE2HHRRAVGJ0eNVqc6SgP7uZz+gGPTscDLKw8EvMRdT6VLaY0nW
         3UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687518473; x=1690110473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol78TSXIutFf0d6kJqjkSHWJiaqpUNfS/uxfMotewwg=;
        b=jQM8dBez3vNl/Ij8XZ46HLUFtrGHSqJqWppwUt8120bja0WHVV4SjNHbyMfq6IFg4z
         LzCICW1IqrYMUfBO131pmKyyHdNXm3BaZIDiqWD2YA7Y30Ud7oHWcJ2qvM8ZS1kZISP9
         ad8rxzW2tsT1ZgU5Ge5vQEFjePcQF52zHp8G1+JCv7SLSuLEeoI21WbEX0XYSkZSVZFA
         Jz/Flc1umGKwl8HlxEctQ0C2MtvyYwvJBKABSh01z00tbTAXceqXnH+2hUT6dLG9D9oQ
         pE8lN47N2S3iEKJgdt1e5I7le6ROuLPXmlcrmdjAsFnf2pA26pIGOzJG8swa0gF0npZ4
         TCDA==
X-Gm-Message-State: AC+VfDz8YG2wEsbqMYoXjhT2v9KqETZ3DjNuZ+RYgnJJzm1yDSwNjvpZ
	pcBdrEHWhVFzXAQ3sYhoHbiG5A==
X-Google-Smtp-Source: ACHHUZ48dnmQlc46OfAWgLYCyP1FKUzNW3fEwDKEH3TmrZTWR0P6Skc0vnkqRsVZqtEpjQPi00al4Q==
X-Received: by 2002:a17:907:8a15:b0:988:acb4:f58 with SMTP id sc21-20020a1709078a1500b00988acb40f58mr13896792ejc.51.1687518473339;
        Fri, 23 Jun 2023 04:07:53 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q11-20020a1709066b0b00b00988a8b5b6c3sm5828837ejr.120.2023.06.23.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:07:52 -0700 (PDT)
Date: Fri, 23 Jun 2023 13:07:51 +0200
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
Message-ID: <ZJV9B3I0veBOsRYM@nanopsycho>
References: <20230622152304.2137482-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622152304.2137482-1-edumazet@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 05:23:04PM CEST, edumazet@google.com wrote:
>Drivers must not assume in their ndo_start_xmit() that
>skbs have their mac_header set. skb->data is all what is needed.
>
>bonding seems to be one of the last offender as caught by syzbot:
>
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset include/linux/skbuff.h:2913 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
>Modules linked in:
>CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
>RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
>RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
>RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
>RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
>RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
>RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
>RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
>Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe e9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
>RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
>RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
>RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
>RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
>R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
>R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
>FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
>CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
><TASK>
>[<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
>[<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
>[<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inline]
>[<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet.c:284
>[<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
>[<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c:3143
>[<ffffffff8467a4b2>] sock_sendmsg_nosec net/socket.c:716 [inline]
>[<ffffffff8467a4b2>] sock_sendmsg net/socket.c:736 [inline]
>[<ffffffff8467a4b2>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
>[<ffffffff8467a715>] __do_sys_sendto net/socket.c:2151 [inline]
>[<ffffffff8467a715>] __se_sys_sendto net/socket.c:2147 [inline]
>[<ffffffff8467a715>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
>[<ffffffff8553071f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>[<ffffffff8553071f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
>[<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Fixes: 7b8fc0103bb5 ("bonding: add a vlan+srcmac tx hashing option")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jarod Wilson <jarod@redhat.com>
>Cc: Moshe Tal <moshet@nvidia.com>
>Cc: Jussi Maki <joamaki@gmail.com>
>Cc: Jay Vosburgh <j.vosburgh@gmail.com>
>Cc: Andy Gospodarek <andy@greyhouse.net>
>Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>---
> drivers/net/bonding/bond_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1c0f26d185dc8ff5e3 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
> 		return skb->hash;
> 
> 	return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
>-				skb_mac_offset(skb), skb_network_offset(skb),
>+				0, skb_network_offset(skb),

After this change, both callers of __bond_xmit_hash() pass 0 as mhoff.
Wouldn't it make sense to remove this arg entirely here and in
bond_vlan_srcmac_hash() and bond_eth_hash()?


> 				skb_headlen(skb));
> }
> 
>-- 
>2.41.0.178.g377b9f9a00-goog
>
>

