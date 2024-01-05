Return-Path: <netdev+bounces-62090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1429825B31
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 20:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B476AB230D9
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B725740;
	Fri,  5 Jan 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKN5qVXU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF235EF7
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-781706de787so125674685a.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 11:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704483956; x=1705088756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z36cTENiE16T5F5xWC0S560wbZS1tL2/6K+MQP/dl1E=;
        b=TKN5qVXUm9zpXLYv/9NYm6mPyaDku1sb/F2c3iZkxd+L8GMas+mcsItmZpiLMyyg4C
         95E9IAGBwlj0ebYLArBV7iT4w4qCwe+LdmqlYY72Vs7D0WLYcYy4sIk07Vm7G39QrJwD
         Nf5092jTqASZVzXISbJryzM1E6zq2zy9dhwE8Ycl3rRLOks6VuJorxBh6QzerwHqtgh8
         26gGlHKyGIrhV4+qEkbRBNVmYW/V7yFuPP0iguz4el//+2c4ywWrShL++L+w/8JuDMYS
         Dq/GeWhn18+pX1wNSeZkUFZ95O7AuRxSmWjD+9a6DlvH5gxB1EVyAfYwCeK58JzV25ny
         O6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483956; x=1705088756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z36cTENiE16T5F5xWC0S560wbZS1tL2/6K+MQP/dl1E=;
        b=W57Ix3xhvpnswoVy3ItkCL8pacl5KiOVjFUOWSQF8WE2eNn0EkMRS7OO5U10D35L/l
         pmfUBoso/SqApZ/Ik3Wgsa/BKp61ZGo0gUphZgFbHYE0fNMIyj0l3C3gq3MTfDB1ENxC
         2nH0ZZuv+SxtRuN6bLmvcxxI7Lj4kB+hCC9luLrlN/niyMkIDxibnLv3MdDUNSzY8YXJ
         6Gtf+CBI4NqHHMewUBuBwat2iGV9xjIVt8KnlUloqcl0mebsPqHnryOj2spsVu4xJnWx
         FDOmxxdMTc2/Rz/K6MsuIZklFBx5Onu29oEwaWeb9ZwmRraxTVhrDG/5tKzA8hFS0FxI
         mHOg==
X-Gm-Message-State: AOJu0YzR0LLfZcGZFcpJK62sNf1d2ZzVt4ETMIp50tJGFUVc5I2ES85b
	7XoIvU6V/m5axL2ys3kSQks=
X-Google-Smtp-Source: AGHT+IGtRLo/yCVVHqgmNKyxGNmHbsoQHuLRIzh/E5O1qJPexZFXgXhmWxrelOD8qxqI7BcF4RsmPA==
X-Received: by 2002:a37:f51a:0:b0:781:9a96:4c77 with SMTP id l26-20020a37f51a000000b007819a964c77mr2919326qkk.30.1704483956664;
        Fri, 05 Jan 2024 11:45:56 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bs44-20020a05620a472c00b007815d11eab5sm815783qkb.26.2024.01.05.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:45:56 -0800 (PST)
Date: Fri, 05 Jan 2024 14:45:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>
Message-ID: <65985c73ca5b9_122cbd29414@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240105170313.2946078-1-edumazet@google.com>
References: <20240105170313.2946078-1-edumazet@google.com>
Subject: Re: [PATCH net] ip6_tunnel: fix NEXTHDR_FRAGMENT handling in
 ip6_tnl_parse_tlv_enc_lim()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot pointed out [1] that NEXTHDR_FRAGMENT handling is broken.
> 
> Reading frag_off can only be done if we pulled enough bytes
> to skb->head. Currently we might access garbage.
> 
> [1]
> BUG: KMSAN: uninit-value in ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ip6_tnl_parse_tlv_enc_lim+0x94f/0xbb0
> ipxip6_tnl_xmit net/ipv6/ip6_tunnel.c:1326 [inline]
> ip6_tnl_start_xmit+0xab2/0x1a70 net/ipv6/ip6_tunnel.c:1432
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3548 [inline]
> dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
> __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> neigh_connected_output+0x569/0x660 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:542 [inline]
> ip6_finish_output2+0x23a9/0x2b30 net/ipv6/ip6_output.c:137
> ip6_finish_output+0x855/0x12b0 net/ipv6/ip6_output.c:222
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip6_output+0x323/0x610 net/ipv6/ip6_output.c:243
> dst_output include/net/dst.h:451 [inline]
> ip6_local_out+0xe9/0x140 net/ipv6/output_core.c:155
> ip6_send_skb net/ipv6/ip6_output.c:1952 [inline]
> ip6_push_pending_frames+0x1f9/0x560 net/ipv6/ip6_output.c:1972
> rawv6_push_pending_frames+0xbe8/0xdf0 net/ipv6/raw.c:582
> rawv6_sendmsg+0x2b66/0x2e70 net/ipv6/raw.c:920
> inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
> slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> slab_alloc_node mm/slub.c:3478 [inline]
> __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
> __do_kmalloc_node mm/slab_common.c:1006 [inline]
> __kmalloc_node_track_caller+0x118/0x3c0 mm/slab_common.c:1027
> kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
> pskb_expand_head+0x226/0x1a00 net/core/skbuff.c:2098
> __pskb_pull_tail+0x13b/0x2310 net/core/skbuff.c:2655
> pskb_may_pull_reason include/linux/skbuff.h:2673 [inline]
> pskb_may_pull include/linux/skbuff.h:2681 [inline]
> ip6_tnl_parse_tlv_enc_lim+0x901/0xbb0 net/ipv6/ip6_tunnel.c:408
> ipxip6_tnl_xmit net/ipv6/ip6_tunnel.c:1326 [inline]
> ip6_tnl_start_xmit+0xab2/0x1a70 net/ipv6/ip6_tunnel.c:1432
> __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
> netdev_start_xmit include/linux/netdevice.h:4954 [inline]
> xmit_one net/core/dev.c:3548 [inline]
> dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
> __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> neigh_connected_output+0x569/0x660 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:542 [inline]
> ip6_finish_output2+0x23a9/0x2b30 net/ipv6/ip6_output.c:137
> ip6_finish_output+0x855/0x12b0 net/ipv6/ip6_output.c:222
> NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> ip6_output+0x323/0x610 net/ipv6/ip6_output.c:243
> dst_output include/net/dst.h:451 [inline]
> ip6_local_out+0xe9/0x140 net/ipv6/output_core.c:155
> ip6_send_skb net/ipv6/ip6_output.c:1952 [inline]
> ip6_push_pending_frames+0x1f9/0x560 net/ipv6/ip6_output.c:1972
> rawv6_push_pending_frames+0xbe8/0xdf0 net/ipv6/raw.c:582
> rawv6_sendmsg+0x2b66/0x2e70 net/ipv6/raw.c:920
> inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> __sys_sendmsg net/socket.c:2667 [inline]
> __do_sys_sendmsg net/socket.c:2676 [inline]
> __se_sys_sendmsg net/socket.c:2674 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 7345 Comm: syz-executor.3 Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> 
> Fixes: fbfa743a9d2a ("ipv6: fix ip6_tnl_parse_tlv_enc_lim()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/ipv6/ip6_tunnel.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 5e80e517f071013410349d1fd93afc00a394e284..46c19bd4899011d53b4feb84e25013c01ddce701 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -399,7 +399,7 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>  	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
>  	unsigned int nhoff = raw - skb->data;
>  	unsigned int off = nhoff + sizeof(*ipv6h);
> -	u8 next, nexthdr = ipv6h->nexthdr;
> +	u8 nexthdr = ipv6h->nexthdr;
>  
>  	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
>  		struct ipv6_opt_hdr *hdr;
> @@ -410,25 +410,25 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>  
>  		hdr = (struct ipv6_opt_hdr *)(skb->data + off);
>  		if (nexthdr == NEXTHDR_FRAGMENT) {
> -			struct frag_hdr *frag_hdr = (struct frag_hdr *) hdr;
> -			if (frag_hdr->frag_off)
> -				break;
>  			optlen = 8;

Eventually this could be sizeof(struct frag_hdr). Not necessarily for
this fix.

