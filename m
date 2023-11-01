Return-Path: <netdev+bounces-45497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDC7DD96E
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A11C20AB1
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C387E6;
	Wed,  1 Nov 2023 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NNWaeOIN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BD627
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 00:03:03 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEFED
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 17:02:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso48878865e9.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698796975; x=1699401775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCqY1HboLQJdMnOqVCc+R0nEwlAbx/lXsonSgDvCE5U=;
        b=NNWaeOIN46rAwv4orWB/qfDJ5NzRa1mX7IJJ77rzuhk4PBU3XFZ1Syw4DsyftwNN+X
         0OzDQAWmgznZKtXQGeXmc18KpUhqUgMR/IAoRQnUDcEklAo9+cQzIIPAS8TQlzjxW0io
         XMJmZ5kPlMC+s0/hJUSImQlGZg22jEOw2ynxg76j39iZk77mY/Lrtw9pn50jFAmEX5qd
         sKfmX41bbPZejqLdOAIUH7A7GiUHWX7cjwiZldellftV4YuIkoJXLq+LIAQAtVRrc8Ah
         ihOyTpqj5wCS663N8mD0hCZ9IAsmFXZmu7hpNTo6gIBFtRpH5yirDEvEftzgJ1djbE0R
         ucmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698796975; x=1699401775;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCqY1HboLQJdMnOqVCc+R0nEwlAbx/lXsonSgDvCE5U=;
        b=GiJ9aRrjX+ZR1VmVfUSYoOx+lp+4v7lUtAy8ciDk5/ucG8X+KOhFF4x08RdH0SQWGX
         Q8iNxnTzFLujHliMRWtTIXFBOHuY+WPjqm8/NovIXs4Ik+KoMXG0pxXJNT2ojZHxP1jV
         0snWl7Us+5bFLmN6qjv8iuAnTku9R8gq+gHto/9L2meowCkdTcJxw6Vmg69A5saW1Ujg
         RkxOhtw+JPGwQTiEtNkRc6tO6HBuL29gKNRtRQJY8rdbKyRk2OrEXBfFavQMNAjTuVOU
         q0I3v311cS7T8kurjk/+5pqFTalOS8avsl2Rtmc08T5ZYdOot236CqVIRVs3QpXPgj2E
         4lTw==
X-Gm-Message-State: AOJu0YybRM1wVs6nfvoYVaMYWtexjfDSDwGk6YMLnfPadQufe50NRwtv
	IL++nqp30M4uWCVTLz8+kwJsSg==
X-Google-Smtp-Source: AGHT+IGOpLF9NnH9vNwhSqhoEpqzEykYwBKfibFciFfY5wtIzXSWtVXtmBSGbakVFPN7Thp5EC7iCA==
X-Received: by 2002:a5d:6a92:0:b0:32d:cd02:d4f3 with SMTP id s18-20020a5d6a92000000b0032dcd02d4f3mr12664379wru.40.1698796975172;
        Tue, 31 Oct 2023 17:02:55 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4991000000b0032d9a1f2ec3sm2592935wrq.27.2023.10.31.17.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:02:54 -0700 (PDT)
Message-ID: <b3f9ae14-0cf6-4587-8d2a-9db1661746cc@arista.com>
Date: Wed, 1 Nov 2023 00:02:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/tcp: fix possible out-of-bounds reads in
 tcp_hash_fail()
Content-Language: en-US
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>
References: <20231030084529.2057421-1-edumazet@google.com>
 <4053721c-8207-4793-8f43-7207a1454d63@arista.com>
In-Reply-To: <4053721c-8207-4793-8f43-7207a1454d63@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 10/30/23 17:47, Dmitry Safonov wrote:
> On 10/30/23 08:45, Eric Dumazet wrote:
>> syzbot managed to trigger a fault by sending TCP packets
>> with all flags being set.
>>
>> BUG: KASAN: stack-out-of-bounds in string_nocheck lib/vsprintf.c:645 [inline]
>> BUG: KASAN: stack-out-of-bounds in string+0x394/0x3d0 lib/vsprintf.c:727
>> Read of size 1 at addr ffffc9000397f3f5 by task syz-executor299/5039
>>
>> CPU: 1 PID: 5039 Comm: syz-executor299 Not tainted 6.6.0-rc7-syzkaller-02075-g55c900477f5b #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
>> Call Trace:
>> <TASK>
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>> print_address_description mm/kasan/report.c:364 [inline]
>> print_report+0xc4/0x620 mm/kasan/report.c:475
>> kasan_report+0xda/0x110 mm/kasan/report.c:588
>> string_nocheck lib/vsprintf.c:645 [inline]
>> string+0x394/0x3d0 lib/vsprintf.c:727
>> vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
>> vprintk_store+0x3a0/0xb80 kernel/printk/printk.c:2191
>> vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2288
>> vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
>> _printk+0xc8/0x100 kernel/printk/printk.c:2332
>> tcp_inbound_hash.constprop.0+0xdb2/0x10d0 include/net/tcp.h:2760
>> tcp_v6_rcv+0x2b31/0x34d0 net/ipv6/tcp_ipv6.c:1882
>> ip6_protocol_deliver_rcu+0x33b/0x13d0 net/ipv6/ip6_input.c:438
>> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
>> NF_HOOK include/linux/netfilter.h:314 [inline]
>> NF_HOOK include/linux/netfilter.h:308 [inline]
>> ip6_input+0xce/0x440 net/ipv6/ip6_input.c:492
>> dst_input include/net/dst.h:461 [inline]
>> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
>> NF_HOOK include/linux/netfilter.h:314 [inline]
>> NF_HOOK include/linux/netfilter.h:308 [inline]
>> ipv6_rcv+0x563/0x720 net/ipv6/ip6_input.c:310
>> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
>> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
>> netif_receive_skb_internal net/core/dev.c:5727 [inline]
>> netif_receive_skb+0x133/0x700 net/core/dev.c:5786
>> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
>> tun_get_user+0x29e7/0x3bc0 drivers/net/tun.c:2002
>> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
>> call_write_iter include/linux/fs.h:1956 [inline]
>> new_sync_write fs/read_write.c:491 [inline]
>> vfs_write+0x650/0xe40 fs/read_write.c:584
>> ksys_write+0x12f/0x250 fs/read_write.c:637
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Fixes: 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited logs")
>> Reported-by: syzbot <syzkaller@googlegroups.com>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Dmitry Safonov <dima@arista.com>
>> Cc: Francesco Ruggeri <fruggeri@arista.com>
>> Cc: David Ahern <dsahern@kernel.org>
> 
> Thanks for fixing this,
> Reviewed-by: Dmitry Safonov <dima@arista.com>
> 
>> ---
>>  include/net/tcp_ao.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..5daf96a3dbee14bd3786e19ea4972e351058e6e7 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -124,7 +124,7 @@ struct tcp_ao_info {
>>  #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
>>  do {									\
>>  	const struct tcphdr *th = tcp_hdr(skb);				\
>> -	char hdr_flags[5] = {};						\
>> +	char hdr_flags[5];						\
>>  	char *f = hdr_flags;						\
>>  									\
>>  	if (th->fin)							\
>> @@ -135,8 +135,7 @@ do {									\
>>  		*f++ = 'R';						\
>>  	if (th->ack)							\
>>  		*f++ = 'A';						\
>> -	if (f != hdr_flags)						\
>> -		*f = ' ';						\
> Ah, that was clearly typo: I meant "*f = 0;"

Actually, after testing, I can see that the space was intended as well,
otherwise it "sticks" to L3index:
[  130.965652] TCP: AO key not found for (10.0.1.1, 56920)->(10.0.254.1,
7010) Skeyid: 100 L3index: 0
[  131.975116] TCP: AO hash is required, but not found for (10.0.1.1,
52686)->(10.0.254.1, 7011) SL3 index 0
[  132.984024] TCP: AO hash mismatch for (10.0.1.1, 51382)->(10.0.254.1,
7012) SL3index: 0
[  133.992221] TCP: Requested by the peer AO key id not found for
(10.0.1.1, 36548)->(10.0.254.1, 7013) SL3index: 0


If you don't mind, I'll send an updated version of your patch together
with some other small post-merge fixes this week.

> 
>> +	*f = 0;								\
>>  	if ((family) == AF_INET) {					\
>>  		net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s" fmt "\n", \
>>  				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
> 

Thank you,
            Dmitry


