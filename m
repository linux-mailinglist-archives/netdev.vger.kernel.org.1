Return-Path: <netdev+bounces-45565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A47DE517
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72E1C20BE7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD415AF4;
	Wed,  1 Nov 2023 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D1vLpIgt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCF14A8A
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 17:12:31 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24788124
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 10:12:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so3259239f8f.0
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698858745; x=1699463545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5f6w7YNvEN71xwpSKx485ANlnSMjfkD4DbsGhPU6jU=;
        b=D1vLpIgtiupcxAXr/qOqRi6r3zYsufIEIaGBViBY466ArpfvBuaiNwwegZxWEZ4M+2
         CbkSpk6Xl0fPJRa9QSuBRlDHlVozacz6s9NdnEwDBBahcWoIEXSUC+a2QutSRupHaPoY
         HG9zklL8LWeiSgnoywB7ZzRsRtenQhP0A1QPwvanEcoVd1Soj2+DAAir+4zkonyqWXB6
         LUjS/nDA5jmCw1M84yaneAvP+RfXWCpXI8K6+MaW1o9FB/SfHf4pgH0qVJg76oj7H49g
         fWxIZZ1gkUd+0QPNZVzr4geVaQ4QvIqW6iIm4mK1iglPFtTO2RzgODGqXaKGi2qpiHrl
         YQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858745; x=1699463545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5f6w7YNvEN71xwpSKx485ANlnSMjfkD4DbsGhPU6jU=;
        b=UMZ8XEdarwwwj/zhIPxeOF6Qy5llRNkGQBh1nN4mQBTNenAhgS6ZP+ZUhn4ebT+NTg
         wKqj0SjOujsMUWdE3IamtbyudR7TiANye0DWVzHgbYAB/qh/aXeKaWDWDSlxh5MrSEgy
         CTG1JdsG92myk6MQd2jkUk0eM/fNx29iX6ietL8xLZ5VO33zGnp12+BJ/pEisCQKiio6
         HRXKTZA6kzS+2Bo4mBbmrHGHuv5isMANsTi87i3R9DHYARrnusXeqBxFHHlsPAGRCj5a
         m2VAoYAL1+yo76CGFH0KvOIiTyGCVl7whK1S7g9iZF1p/Zlj4IlSjDHr9y7UlsOdu/5Y
         G28g==
X-Gm-Message-State: AOJu0YysKxHg7Age1GoRG/jC1H2omnVyRx0lLl5EaSJG8++ypVFRW3TV
	3w9SUyl96ecFHV8HiEkXpQ899A==
X-Google-Smtp-Source: AGHT+IGfjTA3RgVYRQhUL1u7OMYPerwBVOfj29r/fdU76yMgcHmES05W+PBtyx3LfocNsmW9Z+Z4IQ==
X-Received: by 2002:a05:6000:184c:b0:32f:7beb:d006 with SMTP id c12-20020a056000184c00b0032f7bebd006mr11334482wri.16.1698858745546;
        Wed, 01 Nov 2023 10:12:25 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600011cc00b0032d81837433sm305522wrx.30.2023.11.01.10.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:12:24 -0700 (PDT)
Message-ID: <5424326f-19ef-4234-8723-7f16f9d7036a@arista.com>
Date: Wed, 1 Nov 2023 17:12:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/tcp: fix possible out-of-bounds reads in
 tcp_hash_fail()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Francesco Ruggeri
 <fruggeri@arista.com>, David Ahern <dsahern@kernel.org>
References: <20231101045233.3387072-1-edumazet@google.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231101045233.3387072-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/23 04:52, Eric Dumazet wrote:
> syzbot managed to trigger a fault by sending TCP packets
> with all flags being set.
> 
> v2:
>  - While fixing this bug, add PSH flag handling and represent
>    flags the way tcpdump does : [S], [S.], [P.]
>  - Print 4-tuples more consistently between families.
> 
> BUG: KASAN: stack-out-of-bounds in string_nocheck lib/vsprintf.c:645 [inline]
> BUG: KASAN: stack-out-of-bounds in string+0x394/0x3d0 lib/vsprintf.c:727
> Read of size 1 at addr ffffc9000397f3f5 by task syz-executor299/5039
> 
> CPU: 1 PID: 5039 Comm: syz-executor299 Not tainted 6.6.0-rc7-syzkaller-02075-g55c900477f5b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc4/0x620 mm/kasan/report.c:475
> kasan_report+0xda/0x110 mm/kasan/report.c:588
> string_nocheck lib/vsprintf.c:645 [inline]
> string+0x394/0x3d0 lib/vsprintf.c:727
> vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
> vprintk_store+0x3a0/0xb80 kernel/printk/printk.c:2191
> vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2288
> vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
> _printk+0xc8/0x100 kernel/printk/printk.c:2332
> tcp_inbound_hash.constprop.0+0xdb2/0x10d0 include/net/tcp.h:2760
> tcp_v6_rcv+0x2b31/0x34d0 net/ipv6/tcp_ipv6.c:1882
> ip6_protocol_deliver_rcu+0x33b/0x13d0 net/ipv6/ip6_input.c:438
> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ip6_input+0xce/0x440 net/ipv6/ip6_input.c:492
> dst_input include/net/dst.h:461 [inline]
> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ipv6_rcv+0x563/0x720 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
> netif_receive_skb_internal net/core/dev.c:5727 [inline]
> netif_receive_skb+0x133/0x700 net/core/dev.c:5786
> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
> tun_get_user+0x29e7/0x3bc0 drivers/net/tun.c:2002
> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
> call_write_iter include/linux/fs.h:1956 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x650/0xe40 fs/read_write.c:584
> ksys_write+0x12f/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited logs")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Francesco Ruggeri <fruggeri@arista.com>
> Cc: David Ahern <dsahern@kernel.org>

LGTM, thanks again!

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  include/net/tcp_ao.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..b56be10838f09a2cb56ab511242d2b583eb4c33b 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -124,7 +124,7 @@ struct tcp_ao_info {
>  #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
>  do {									\
>  	const struct tcphdr *th = tcp_hdr(skb);				\
> -	char hdr_flags[5] = {};						\
> +	char hdr_flags[6];						\
>  	char *f = hdr_flags;						\
>  									\
>  	if (th->fin)							\
> @@ -133,17 +133,18 @@ do {									\
>  		*f++ = 'S';						\
>  	if (th->rst)							\
>  		*f++ = 'R';						\
> +	if (th->psh)							\
> +		*f++ = 'P';						\
>  	if (th->ack)							\
> -		*f++ = 'A';						\
> -	if (f != hdr_flags)						\
> -		*f = ' ';						\
> +		*f++ = '.';						\
> +	*f = 0;								\
>  	if ((family) == AF_INET) {					\
> -		net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s" fmt "\n", \
> +		net_info_ratelimited("%s for %pI4.%d->%pI4.%d [%s] " fmt "\n", \
>  				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
>  				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
>  				hdr_flags, ##__VA_ARGS__);		\
>  	} else {							\
> -		net_info_ratelimited("%s for [%pI6c]:%u->[%pI6c]:%u %s" fmt "\n", \
> +		net_info_ratelimited("%s for [%pI6c].%d->[%pI6c].%d [%s]" fmt "\n", \
>  				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
>  				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
>  				hdr_flags, ##__VA_ARGS__);		\

-- 
Dmitry


