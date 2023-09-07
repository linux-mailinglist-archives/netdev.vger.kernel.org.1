Return-Path: <netdev+bounces-32356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46B796F07
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AD11C20A58
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CEA21;
	Thu,  7 Sep 2023 02:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB57FF
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 02:43:39 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6421997
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 19:43:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7927f241772so18528939f.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694054617; x=1694659417; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6moqqStamRFlXnLC5cGKI/pmCNq6sMjyvV78mFx9aw=;
        b=BA0UHb45GwAjA+GMSRtTZpRLxizBfnFO+n8rZI3iaeFazlMQ71LZZVtiMiqNhsotfx
         Bm/n/AmDZf8iQbMpg/eJ++ShK2Ky60XsERjYWoDPfkfEHQDeQCbq0jeE00HjCiC5xJZQ
         uoqxRQjrwdbaXZhCDC5yeorpzA6pmj5h8kJGJuPdFDEl+slNH/WzplVmc1v2BgV7gKJv
         cc1/7kDV1Ex+Y5zdTb++dWFk1SXTI5Lj5mqNh/idRfH2h2UnHTHAWHilWsyw4IlDBM/7
         5f79R1itNqUyTKTZeXU4QXJsPJsH9xXM/1fotSCEdA/2pH1evoKxZ33X32/j5dcp+Id3
         E07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694054617; x=1694659417;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6moqqStamRFlXnLC5cGKI/pmCNq6sMjyvV78mFx9aw=;
        b=HWBx0DBieMQIM/W1YlMrefYFtNDiNof9rDJbRzSqywAB4EqMCJIyX7iym9MJQQeADr
         XQ3g8ssqq6zduktEV1rOj3W6Jzl1hoZE3lZaO0zLJUbXdj/wA46yZuSDkA3zB4cjzDXn
         ZzQntydDgowcJ7eyyTQPq0aOwN+RjUctU4FhpLnG8vf6RMVws/Di7v7FrggFjDFxGPx+
         6dwroyooXwycZ6gg7j9G0xJEec0BReCoL3EvbSN9PnsmM7Uls9PDlwJlrB/i3tRTDuNh
         qa5hQFEPErHCDIVjCkB8ymW7ogQ2qFaRDFLixszBlhJjnOqa4Td2FOf7tSH5VeKrokoN
         It7w==
X-Gm-Message-State: AOJu0YzW/pMJWfpZadTIjIaqRb5Iz7XRdjOZFPF3upBtslqE2NQdrEyk
	jyCmao3XR21LI6LyY4gHbGA=
X-Google-Smtp-Source: AGHT+IHKlKy8HTl9XFljR8JiA5raSPzGQGyekgd6AKuI7NDxHm9BwHJ4LioaG3WBVExxS8aORKSDOQ==
X-Received: by 2002:a05:6e02:dc2:b0:349:796b:2299 with SMTP id l2-20020a056e020dc200b00349796b2299mr17382202ilj.6.1694054617082;
        Wed, 06 Sep 2023 19:43:37 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a4c8100b002694da8a9cdsm479771pjh.48.2023.09.06.19.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:43:36 -0700 (PDT)
Date: Wed, 6 Sep 2023 19:43:34 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org
Cc: ssuryaextr@gmail.com
Subject: [PATCH] don't assume the existence of skb->dev when trying to reset
 ip_options in ipv4_send_dest_unreach
Message-ID: <ZPk41vtxHK/YnFUs@westworld>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, we assume the skb is associated with a device before calling __ip_options_compile, which is not always the case if it is re-routed by ipvs.
When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
Since we know that all the options will be set to IPOPT_END, which does
not depend on struct net, we pass NULL to it.

KASAN splash:

[    6.289675] general protection fault, probably for non-canonical address 0xdffffc0000000096: 0000 [#1] PREEMPT SMP KASAN NOPTI
[    6.292146] KASAN: null-ptr-deref in range [0x00000000000004b0-0x00000000000004b7]
[    6.293823] CPU: 0 PID: 509 Comm: poc Not tainted 6.1.47+ #59
[    6.294699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    6.295151] RIP: 0010:ipv4_link_failure+0x2dc/0x610
[    6.295423] Code: 80 3c 28 00 48 89 e9 74 12 4c 89 f7 e8 5d e8 bd fd 48 b9 00 00 00 00 00 fc ff df bd b0 04 00 00 49 03 2e 48 89 e8 48 c1 e8 03 <80> 3c 08 00 74 08 48 89 ef e8 36 e8 bd fd 48 8b 7d 00 48 8d 74 24
[    6.296423] RSP: 0018:ffff88800bc87530 EFLAGS: 00010206
[    6.296710] RAX: 0000000000000096 RBX: ffff88800af22c04 RCX: dffffc0000000000
[    6.297096] RDX: dffffc0000000000 RSI: 00000000fffffff8 RDI: ffff88800bc87578
[    6.297482] RBP: 00000000000004b0 R08: dffffc0000000000 R09: ffff88800bc87570
[    6.297868] R10: dfffe91001790eb1 R11: 1ffff11001790eae R12: ffff88800af22b40
[    6.298282] R13: 1ffff110015e4576 R14: ffff88800af22b50 R15: 1ffff110015e4576
[    6.298679] FS:  00000000032493c0(0000) GS:ffff888034e00000(0000) knlGS:0000000000000000
[    6.299123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.299442] CR2: 0000000000404dfe CR3: 000000000d492004 CR4: 0000000000770ef0
[    6.299841] PKRU: 55555554
[    6.299995] Call Trace:
[    6.300137]  <TASK>
[    6.300259]  ? __die_body+0x67/0xb0
[    6.300455]  ? die_addr+0xb2/0xe0
[    6.300641]  ? exc_general_protection+0x27f/0x3c0
[    6.300902]  ? asm_exc_general_protection+0x22/0x30
[    6.301167]  ? ipv4_link_failure+0x2dc/0x610
[    6.301398]  __ip_vs_get_out_rt+0x54a/0x1060
[    6.301629]  ? kasan_save_free_info+0x27/0x40
[    6.301871]  ip_vs_nat_xmit+0x144/0x800
[    6.302114]  ? ip_vs_in_stats+0x1ca/0x2d0
[    6.302334]  ip_vs_in_hook+0xc13/0x1b20
[    6.302546]  ? ip_vs_out_hook+0xd70/0xd70
[    6.302767]  nf_hook_slow+0xb4/0x190
[    6.302963]  __ip_local_out+0x347/0x450
[    6.303171]  ? __ip_local_out+0x450/0x450
[    6.303387]  ip_send_skb+0x48/0x110
[    6.303589]  udp_send_skb+0x6e4/0x1370
[    6.303805]  udp_sendmsg+0x16ba/0x2850
[    6.304016]  ? ip_skb_dst_mtu+0x5e0/0x5e0
[    6.304250]  ? inet_send_prepare+0x2f0/0x2f0
[    6.304492]  ____sys_sendmsg+0x560/0x6d0
[    6.304726]  __sys_sendmsg+0x1bd/0x240
[    6.304959]  do_syscall_64+0x67/0x90
[    6.305165]  ? exit_to_user_mode_prepare+0x12/0xa0
[    6.305429]  ? syscall_exit_to_user_mode+0x28/0x150
[    6.305701]  ? do_syscall_64+0x75/0x90
[    6.305915]  ? exit_to_user_mode_prepare+0x12/0xa0
[    6.306199]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    6.306485] RIP: 0033:0x474087
[    6.306690] Code: ff ff f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[    6.308329] RSP: 002b:00007ffe8e9dce28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[    6.308792] RAX: ffffffffffffffda RBX: 00007ffe8e9dd0a8 RCX: 0000000000474087
[    6.309199] RDX: 0000000000000000 RSI: 00007ffe8e9dce40 RDI: 0000000000000006
[    6.309629] RBP: 00007ffe8e9dcea0 R08: 0000000000000004 R09: 000000000324b480
[    6.310071] R10: 00007ffe8e9dce30 R11: 0000000000000246 R12: 0000000000000001
[    6.310451] R13: 00007ffe8e9dd098 R14: 00000000004fd740 R15: 0000000000000002
[    6.310869]  </TASK>
[    6.311002] Modules linked in:
[    6.311222] ---[ end trace 0000000000000000 ]---
[    6.311493] RIP: 0010:ipv4_link_failure+0x2dc/0x610
[    6.311807] Code: 80 3c 28 00 48 89 e9 74 12 4c 89 f7 e8 5d e8 bd fd 48 b9 00 00 00 00 00 fc ff df bd b0 04 00 00 49 03 2e 48 89 e8 48 c1 e8 03 <80> 3c 08 00 74 08 48 89 ef e8 36 e8 bd fd 48 8b 7d 00 48 8d 74 24
[    6.312941] RSP: 0018:ffff88800bc87530 EFLAGS: 00010206
[    6.313283] RAX: 0000000000000096 RBX: ffff88800af22c04 RCX: dffffc0000000000
[    6.313766] RDX: dffffc0000000000 RSI: 00000000fffffff8 RDI: ffff88800bc87578
[    6.314248] RBP: 00000000000004b0 R08: dffffc0000000000 R09: ffff88800bc87570
[    6.314676] R10: dfffe91001790eb1 R11: 1ffff11001790eae R12: ffff88800af22b40
[    6.315138] R13: 1ffff110015e4576 R14: ffff88800af22b50 R15: 1ffff110015e4576
[    6.315591] FS:  00000000032493c0(0000) GS:ffff888034e00000(0000) knlGS:0000000000000000
[    6.316130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.316501] CR2: 0000000000404dfe CR3: 000000000d492004 CR4: 0000000000770ef0
[    6.316979] PKRU: 55555554
[    6.317146] Kernel panic - not syncing: Fatal exception
[    6.317688] Kernel Offset: disabled
[    6.317910] Rebooting in 1000 seconds..

Fixes: ed0de45 ("ipv4: recompile ip options in ipv4_link_failure")
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d8c99bdc617..fcb8e57b95f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1230,7 +1230,7 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		res = __ip_options_compile(NULL, &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
-- 
2.34.1


