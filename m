Return-Path: <netdev+bounces-63264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95082C04B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C651F25952
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB36A34F;
	Fri, 12 Jan 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="23tu3wUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A876A34D
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1358279366b.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705064438; x=1705669238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo/+uwcv6M9RCVLWBTh3+lxGJkmyBn9pvaZy82W6zuc=;
        b=23tu3wUs5e8gPw2LCNvCH8R4kMKtBI2KUZpek+MqIPxCq9mOQHZEm0DpgkqFgIt5tx
         h6eXHZPF6WbUYTBHKuBqaOVQi/k6COQqs637dy5ZrGfeGMh8Ni22VPSvsgm47xtROpv2
         G/lkWurUfbaJ8aqfjS6PmGQToDpGfsrWkpumr4JF8ezdSGN5ziyXHinWCWCa6hZQzApr
         e66C9Sw2utryoA9SoQ7UKv9m5/BjRwHzeYDGS1D6IPEnq3pXxMUEU8evL5rWPQsDFoc2
         HFo88CLhx4XBMkTYSm06gyjKNltXsq9hHeaetb6y+ZjsqjQrJdEObz652Q34+lbcKSLo
         isNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705064438; x=1705669238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo/+uwcv6M9RCVLWBTh3+lxGJkmyBn9pvaZy82W6zuc=;
        b=fbk/RoeCvl2ng+G0omXsSfU6py00lY40EfWm5sCOgTOOwzSdwEwJvo0jTJ3OaryYKD
         00Jx2jrCpUhR7pMP83iIIc+lJauCPLqkCPjx9Mzq3TrCJ1RRHEySxiVlTv4I45b8haF5
         sjv8YR2vYOelP88F9bpQceJFt3H86r+L0e+3EgQUSw/P3617eTLUWfFzheAiHwNbQMB4
         AvLX/3mYAhupvfA95I6GMKCFyjM1Z9Pr5hbJMQ8PInD3XvK4fYcyN6yF5cearaZwMKPC
         MhLyst1jmcEiWGKrxQlVHKdNLU+pfsFZs6yEry/VSr94LP5pw6ReFjfmwNVI3RWK++UP
         aTCQ==
X-Gm-Message-State: AOJu0YxRCldqt3Fx4/uJFQnpZlvGh/Zjt5kFOVzC0Ln+xN8bi1folD4d
	q/MGPxpgz2bqg0Iz62/33raMCevOQ+Hv7w==
X-Google-Smtp-Source: AGHT+IEVmdcu02Kn4wyT9byVJpmuMRo5OM6g9mhxHGY1kQywPLqgFovkJK+cZVV78GKwRE8oYSQS2g==
X-Received: by 2002:a17:906:7105:b0:a28:d32f:14d2 with SMTP id x5-20020a170906710500b00a28d32f14d2mr1395428ejj.72.1705064437939;
        Fri, 12 Jan 2024 05:00:37 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090652ce00b00a19afc16d23sm1778646ejn.104.2024.01.12.05.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:00:37 -0800 (PST)
Date: Fri, 12 Jan 2024 14:00:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
Message-ID: <ZaE39F93nKy4NKqj@nanopsycho>
References: <20240112122816.450197-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112122816.450197-1-edumazet@google.com>

Fri, Jan 12, 2024 at 01:28:16PM CET, edumazet@google.com wrote:
>syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]
>
>The repro use af_packet, injecting a gso packet and hdrlen == 0.
>
>We could fix the issue making gso_features_check() more careful
>while dealing with NETIF_F_TSO_MANGLEID in fast path.
>
>Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
>transport headers as intended.

You describe "either or", but don't really say what to do. Bit
confusing :/


>
>Note that for GSO packets coming from untrusted sources, SKB_GSO_DODGY
>bit forces a proper header validation (and pull) before the packet can
>hit any device ndo_start_xmit(), thus we do not need a precise disection
>at virtio_net_hdr_to_skb() stage.
>
>[1]
>BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline]
>BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
> skb_gso_segment include/net/gso.h:83 [inline]
> validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
> __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
> dev_queue_xmit include/linux/netdevice.h:3134 [inline]
> packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
> packet_snd net/packet/af_packet.c:3087 [inline]
> packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
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
>Uninit was created at:
> slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
> __alloc_skb+0x318/0x740 net/core/skbuff.c:651
> alloc_skb include/linux/skbuff.h:1286 [inline]
> alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
> sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
> packet_alloc_skb net/packet/af_packet.c:2936 [inline]
> packet_snd net/packet/af_packet.c:3030 [inline]
> packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
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
>CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>
>Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
>Link: https://lore.kernel.org/netdev/0000000000005abd7b060eb160cd@google.com/
>Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Willem de Bruijn <willemb@google.com>
>---
> include/linux/virtio_net.h | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>index 27cc1d4643219a44c01a2404124cd45ef46f7f3d..4dfa9b69ca8d95d43e44831bc166eadbe5715d3c 100644
>--- a/include/linux/virtio_net.h
>+++ b/include/linux/virtio_net.h
>@@ -3,6 +3,8 @@
> #define _LINUX_VIRTIO_NET_H
> 
> #include <linux/if_vlan.h>
>+#include <linux/ip.h>
>+#include <linux/ipv6.h>
> #include <linux/udp.h>
> #include <uapi/linux/tcp.h>
> #include <uapi/linux/virtio_net.h>
>@@ -49,6 +51,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 					const struct virtio_net_hdr *hdr,
> 					bool little_endian)
> {
>+	unsigned int nh_min_len = sizeof(struct iphdr);
> 	unsigned int gso_type = 0;
> 	unsigned int thlen = 0;
> 	unsigned int p_off = 0;
>@@ -65,6 +68,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 			gso_type = SKB_GSO_TCPV6;
> 			ip_proto = IPPROTO_TCP;
> 			thlen = sizeof(struct tcphdr);
>+			nh_min_len = sizeof(struct ipv6hdr);
> 			break;
> 		case VIRTIO_NET_HDR_GSO_UDP:
> 			gso_type = SKB_GSO_UDP;
>@@ -100,7 +104,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 		if (!skb_partial_csum_set(skb, start, off))
> 			return -EINVAL;
> 
>-		p_off = skb_transport_offset(skb) + thlen;
>+		nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
>+		p_off = nh_min_len + thlen;
> 		if (!pskb_may_pull(skb, p_off))
> 			return -EINVAL;
> 	} else {
>@@ -140,7 +145,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> 
> 			skb_set_transport_header(skb, keys.control.thoff);
> 		} else if (gso_type) {
>-			p_off = thlen;
>+			p_off = nh_min_len + thlen;
> 			if (!pskb_may_pull(skb, p_off))
> 				return -EINVAL;
> 		}
>-- 
>2.43.0.275.g3460e3d667-goog
>
>

