Return-Path: <netdev+bounces-28109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571AB77E3F5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8CE2819FE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6316419;
	Wed, 16 Aug 2023 14:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C516400
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:26 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B172716
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76d70fb1369so39997285a.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692196823; x=1692801623;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRvimqdODs5dfsHClt55xzbu7Kf0Ndf+hWVT1PUJTUY=;
        b=IFJgPnlocbGlAb15qTh5t+ddFj5cC6DKO0vSFR8VyZxWzUNgpPWjrv9n8RPvI88Z9v
         nbU5r8MZvF4gY1yMrKgd5TaUg2/t9jEcfW0qul9TXZOaq9bP3FQoJpJ6jOEz7q+7qYe5
         kMTGOsg7DscnxDvxuP5mBu+V/eYob4UaJ3Q7hwFmE5hE7x2gpEXCTPZd32f2Zh4hsbXT
         Ywyt/l5Hvc3xdi7vS871BFaR5e+iQOLwRtFXdxN+9l14wCyK1+zWH3M+LXSUUMBJHR7E
         xUSLEdbiTcqBX08dcQ5WRvzWTCON0U2sHhELY93vvj50dsZqqqmqRKecrgFx36mhyxnZ
         4BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196823; x=1692801623;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BRvimqdODs5dfsHClt55xzbu7Kf0Ndf+hWVT1PUJTUY=;
        b=cOqGN6F12HrQeIRKXtTwoooOJLwqN4yu2o2YE/5kzS3f76J1uX/gzzxaszleoti4qS
         4FJheeV/UqWZmXJNkNPyD5t8fEc9B/vvUxup9OYBlCUq6h+L+R5IQzWTRCP0DsfS824r
         ozGhebpY8UZ6KYWP2qK74nLcezT1OnMr616P5PwHaXH//fT5ee7mE5uUTC3vpM0PlnH4
         LJETTEgy+m2hZd9arj+mZaIh7B2C9ddG7I6jooSQp2Mf4rUDsn5Ksx9GfZgXFZpuEdyR
         GRs4mlLgBsLPclYpOvCvvUVSNFkhprg+aze6Y8VD5aEk53jqdntg2CF/Y1+SwtaPYSwH
         A+0w==
X-Gm-Message-State: AOJu0Yw7YeQHfE/0n3hvVuMScXU1663+fclxqaiWB0rHEYss/yWYR3WP
	5ACBEyp5Sl6TAcTD64cuMgE=
X-Google-Smtp-Source: AGHT+IGjdm13xpyFUBsvKqAsrU+i0dkkrQXj5LCG7Bm8plsXs46gzCkDnN6CZZzwAs7yjQ+UAPg3aw==
X-Received: by 2002:a05:620a:2289:b0:766:e430:21b8 with SMTP id o9-20020a05620a228900b00766e43021b8mr2046634qkh.75.1692196823122;
        Wed, 16 Aug 2023 07:40:23 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a126a00b00767502e8601sm4452499qkl.35.2023.08.16.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:40:22 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:40:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <64dcdfd5dc25b_23f1f829435@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230816142158.1779798-1-edumazet@google.com>
References: <20230816142158.1779798-1-edumazet@google.com>
Subject: Re: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> One missing check in virtio_net_hdr_to_skb() allowed
> syzbot to crash kernels again [1]
> 
> Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
> because this magic value is used by the kernel.
> 
> [1]
> general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
> Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
> RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
> RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
> RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
> R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
> R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
> FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
> ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
> skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
> __skb_gso_segment+0x339/0x710 net/core/gso.c:124
> skb_gso_segment include/net/gso.h:83 [inline]
> validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
> __dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
> dev_queue_xmit include/linux/netdevice.h:3082 [inline]
> packet_xmit+0x257/0x380 net/packet/af_packet.c:276
> packet_snd net/packet/af_packet.c:3087 [inline]
> packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
> sock_sendmsg_nosec net/socket.c:727 [inline]
> sock_sendmsg+0xd9/0x180 net/socket.c:750
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2579
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff27cdb34d9
> 
> Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


