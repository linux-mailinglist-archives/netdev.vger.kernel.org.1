Return-Path: <netdev+bounces-13146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D153173A79C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5191C21130
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F2200CE;
	Thu, 22 Jun 2023 17:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2791F16A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:48:36 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263E1FC6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:48:33 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2F5D4241D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687456110;
	bh=WyTLBpUa/zc7exXrdYAj9AUMhoL+yJuFPn6TJ/+py4U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=pNkCMaAOWtH70DCdvRxVjywOKeOUcHX8B8aE0SwwzODo6oNa43uE/KuxJnyePcsQW
	 WmQdx+ttTPQwH6vwW9ZTsIfwM8pTenzgfwPjBRD+IKjKLNnVWNQm/JUNvTXpu9D1PZ
	 UAnYSslkK+qNEv9MFE+oqEZm+n6NbrG/ZF1bn8WB3PapmpCgwPaF1s32CsBDPBjNcr
	 DGl0lkfRMmWrligh+fKonYDVT9jgva+WspoB9Mw+fvak8tPLGUBkYoX0R0yfXUSuC3
	 PdlGJVsKmE5n+Zp+H+Y/GCI5EvloLZ9YWTMbTIll0XCsQzhXLC+5k4r5T9AuA85rBC
	 ewpEcJ0cRiV1w==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25eaf3c7348so3464131a91.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456109; x=1690048109;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyTLBpUa/zc7exXrdYAj9AUMhoL+yJuFPn6TJ/+py4U=;
        b=N/W9ud6JcnAvolyLRtrvoeY1NGPQzhnZoAXB94nAYq3tbhNRNRfUHTsaDQAm7sGoYU
         sEDAZKoxkQRuUV7TH4U3LiGC2nX+D3OIECPnBnNwZJ9FFJFrjUbSbJCmdBC1VAU177ed
         vWx5Olc/N9Pya2ckwjR55IXMnsYa2/5a7lpWAE2cBuZlENG233xBlBCev2aWFCKsFIO3
         od/i2CfPVLc/3y50nxnNuiMjNGENZqwkvIAcqfqtWYqBdQ1A1tfummx6/fSSHkIGmmey
         axdfOTBRdAJOug3rvgjfgFeYZQsdnihsMreEG2bjw/59O+XhYrNg/ewgOrCBZbAJ6cko
         ANJA==
X-Gm-Message-State: AC+VfDwJNB2TTF5xNspGcUfY4jhFms3sGaX8RCxtfsYaQfBfbDSDGT8S
	FVkN8L6fRChOwWdB6l6kRoWGCnQuedUTZzGeZBamOuKGNPvNH5HRGJwU8wSCKm9fgkEFw5smVGW
	IGXESZ1DeYfA1d/+64yCGO7aHZaKQcMFC0g==
X-Received: by 2002:a17:90b:4397:b0:261:21a0:95bb with SMTP id in23-20020a17090b439700b0026121a095bbmr1608087pjb.47.1687456108753;
        Thu, 22 Jun 2023 10:48:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bUXfnzF4ajMh4L83iU2QYU0kFk7kN4qkWLxtJrpBDH3of1bMIKWHGWLsR7wh8wEpPNWurlA==
X-Received: by 2002:a17:90b:4397:b0:261:21a0:95bb with SMTP id in23-20020a17090b439700b0026121a095bbmr1608074pjb.47.1687456108447;
        Thu, 22 Jun 2023 10:48:28 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b002532ddc3a00sm39560pjy.15.2023.06.22.10.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2023 10:48:28 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 9ED565FEAC; Thu, 22 Jun 2023 10:48:27 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 996AE9FAF8;
	Thu, 22 Jun 2023 10:48:27 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org, eric.dumazet@gmail.com,
    syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>,
    Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
In-reply-to: <20230622152304.2137482-1-edumazet@google.com>
References: <20230622152304.2137482-1-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Thu, 22 Jun 2023 15:23:04 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22642.1687456107.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 10:48:27 -0700
Message-ID: <22643.1687456107@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> wrote:

>Drivers must not assume in their ndo_start_xmit() that
>skbs have their mac_header set. skb->data is all what is needed.
>
>bonding seems to be one of the last offender as caught by syzbot:
>
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 skb_mac_offset =
include/linux/skbuff.h:2913 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_hash =
drivers/net/bonding/bond_main.c:4170 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_xmit_3ad_x=
or_slave_get drivers/net/bonding/bond_main.c:5149 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_3ad_xor_xm=
it drivers/net/bonding/bond_main.c:5186 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 __bond_start_xm=
it drivers/net/bonding/bond_main.c:5442 [inline]
>WARNING: CPU: 1 PID: 12155 at include/linux/skbuff.h:2907 bond_start_xmit=
+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5470
>Modules linked in:
>CPU: 1 PID: 12155 Comm: syz-executor.3 Not tainted 6.1.30-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/25/2023
>RIP: 0010:skb_mac_header include/linux/skbuff.h:2907 [inline]
>RIP: 0010:skb_mac_offset include/linux/skbuff.h:2913 [inline]
>RIP: 0010:bond_xmit_hash drivers/net/bonding/bond_main.c:4170 [inline]
>RIP: 0010:bond_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:514=
9 [inline]
>RIP: 0010:bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:5186 [inline]
>RIP: 0010:__bond_start_xmit drivers/net/bonding/bond_main.c:5442 [inline]
>RIP: 0010:bond_start_xmit+0x14ab/0x19d0 drivers/net/bonding/bond_main.c:5=
470
>Code: 8b 7c 24 30 e8 76 dd 1a 01 48 85 c0 74 0d 48 89 c3 e8 29 67 2e fe e=
9 15 ef ff ff e8 1f 67 2e fe e9 10 ef ff ff e8 15 67 2e fe <0f> 0b e9 45 f=
8 ff ff e8 09 67 2e fe e9 dc fa ff ff e8 ff 66 2e fe
>RSP: 0018:ffffc90002fff6e0 EFLAGS: 00010283
>RAX: ffffffff835874db RBX: 000000000000ffff RCX: 0000000000040000
>RDX: ffffc90004dcf000 RSI: 00000000000000b5 RDI: 00000000000000b6
>RBP: ffffc90002fff8b8 R08: ffffffff83586d16 R09: ffffffff83586584
>R10: 0000000000000007 R11: ffff8881599fc780 R12: ffff88811b6a7b7e
>R13: 1ffff110236d4f6f R14: ffff88811b6a7ac0 R15: 1ffff110236d4f76
>FS: 00007f2e9eb47700(0000) GS:ffff8881f6b00000(0000) knlGS:00000000000000=
00
>CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 0000001b2e421000 CR3: 000000010e6d4000 CR4: 00000000003526e0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
><TASK>
>[<ffffffff8471a49f>] netdev_start_xmit include/linux/netdevice.h:4925 [in=
line]
>[<ffffffff8471a49f>] __dev_direct_xmit+0x4ef/0x850 net/core/dev.c:4380
>[<ffffffff851d845b>] dev_direct_xmit include/linux/netdevice.h:3043 [inli=
ne]
>[<ffffffff851d845b>] packet_direct_xmit+0x18b/0x300 net/packet/af_packet.=
c:284
>[<ffffffff851c7472>] packet_snd net/packet/af_packet.c:3112 [inline]
>[<ffffffff851c7472>] packet_sendmsg+0x4a22/0x64d0 net/packet/af_packet.c:=
3143
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
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facbaf1c0=
f26d185dc8ff5e3 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_=
buff *skb)
> 		return skb->hash;
> =

> 	return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
>-				skb_mac_offset(skb), skb_network_offset(skb),
>+				0, skb_network_offset(skb),
> 				skb_headlen(skb));
> }

	Is the MAC header guaranteed to be at skb->data, then?  If not,
then isn't replacing skb_mac_offset() with 0 going to break the hash (as
it might or might not be looking at the actual MAC header)?

	Also, assuming for the moment that this change is ok, this makes
all callers of __bond_xmit_hash() supply zero for the mhoff parameter,
and a complete fix should therefore remove the unused parameter and its
various references.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

