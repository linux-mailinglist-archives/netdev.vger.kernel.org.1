Return-Path: <netdev+bounces-34489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A595D7A45E7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6791C20F55
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AD12B93;
	Mon, 18 Sep 2023 09:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF628FE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:29:59 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5B12D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:29:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so4935658a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695029393; x=1695634193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCF0Horr2h7qpSaWZlXlmtXAqYL8heykh2jju7r+Kn8=;
        b=SdNrKQxy7ySP5l7ntIplGkgz1nAlTzW2YDc4CAq7EECwMyqO0FdhiwNfoZ8liKtZwd
         FwJeGsSR8o2fhn5tBlB+2QLMkBll/sCedXkPTs6BRNCwMKumxliWJIKFVnfSg1ytO6Os
         Trwf3nQoqcD1/Z78sNh5PssUhcBNf8dINlqEb2+KoJIHXUdWlgBye0EDOnrD3hTo0oRA
         5m8I1/pPW9B5PRbHOrEaUmvDjGcdNb5nvJzC20eKufTxWe7+K+U2AgyK2C5RylEDGevW
         wYRESE3oh41WE7l5bHfDa360ZEMEo9RxmSqR2eD5gXzYz2wE1R/hIJ7oBwYwViY6xY+B
         /0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029393; x=1695634193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCF0Horr2h7qpSaWZlXlmtXAqYL8heykh2jju7r+Kn8=;
        b=IhUG705BzQQwb4KyKW4OGi7hUbbpNDefEOiuAU6xAoLBaPb3Rro53P/3FiflOlCd10
         qYpLXleN6FPjPTMXS5h3+9PkNKX6X326axXYl55ksS3S3QeBGiSimBuCcyn0IU7Nljzx
         rZ7vR1qU0EsYQ53v37VFgQ6kwlomQ7qFhB1wc0hfnw2m0vW8PzDC5I+gK6Gw2ebkEubY
         QWV0jWI78rs6rqpX5goi6szV8JaYnBA7FlhNqv5baCpVK8AJr2wKZ2ohs5vJFqLH4mva
         J4aL3MnzEydL8pt31SWd3k2n8oc+a3IQgxSnVESXJwhMsfR1HXw9UJUKl67nSeAFH62x
         P9Lg==
X-Gm-Message-State: AOJu0YxtlEqcHFsc8fjR2EdD7pWhOw9QMGVNYHR4hOEXwkH7c3njFAvg
	vvfW3twdwEIs2YIceI9x7ovaEQ==
X-Google-Smtp-Source: AGHT+IGkgJG2oi+1IiOAdsDSHRZapGsHpsvkPvqvWhbn1ZX0g4zjjyu/H3CqgyuqFMT7pBJybUpaXg==
X-Received: by 2002:a05:6402:22d3:b0:530:8d55:9c6f with SMTP id dm19-20020a05640222d300b005308d559c6fmr7051153edb.2.1695029393531;
        Mon, 18 Sep 2023 02:29:53 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id cn10-20020a0564020caa00b00530be302f08sm3165002edb.49.2023.09.18.02.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 02:29:53 -0700 (PDT)
Message-ID: <cf8b9040-46dd-21af-b92f-78af1f1536c7@blackwall.org>
Date: Mon, 18 Sep 2023 12:29:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net] net: bridge: use DEV_STATS_INC()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux-foundation.org
References: <20230918091351.1356153-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230918091351.1356153-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 12:13, Eric Dumazet wrote:
> syzbot/KCSAN reported data-races in br_handle_frame_finish() [1]
> This function can run from multiple cpus without mutual exclusion.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Handles updates to dev->stats.tx_dropped while we are at it.
> 
> [1]
> BUG: KCSAN: data-race in br_handle_frame_finish / br_handle_frame_finish
> 
> read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 1:
> br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
> br_nf_hook_thresh+0x1ed/0x220
> br_nf_pre_routing_finish_ipv6+0x50f/0x540
> NF_HOOK include/linux/netfilter.h:304 [inline]
> br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
> br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
> nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
> nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
> br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
> __netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
> __netif_receive_skb_one_core net/core/dev.c:5521 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
> process_backlog+0x21f/0x380 net/core/dev.c:5965
> __napi_poll+0x60/0x3b0 net/core/dev.c:6527
> napi_poll net/core/dev.c:6594 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6727
> __do_softirq+0xc1/0x265 kernel/softirq.c:553
> run_ksoftirqd+0x17/0x20 kernel/softirq.c:921
> smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 0:
> br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
> br_nf_hook_thresh+0x1ed/0x220
> br_nf_pre_routing_finish_ipv6+0x50f/0x540
> NF_HOOK include/linux/netfilter.h:304 [inline]
> br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
> br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
> nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
> nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
> br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
> __netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
> __netif_receive_skb_one_core net/core/dev.c:5521 [inline]
> __netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
> process_backlog+0x21f/0x380 net/core/dev.c:5965
> __napi_poll+0x60/0x3b0 net/core/dev.c:6527
> napi_poll net/core/dev.c:6594 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6727
> __do_softirq+0xc1/0x265 kernel/softirq.c:553
> do_softirq+0x5e/0x90 kernel/softirq.c:454
> __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
> __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
> _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
> spin_unlock_bh include/linux/spinlock.h:396 [inline]
> batadv_tt_local_purge+0x1a8/0x1f0 net/batman-adv/translation-table.c:1356
> batadv_tt_purge+0x2b/0x630 net/batman-adv/translation-table.c:3560
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> value changed: 0x00000000000d7190 -> 0x00000000000d7191
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 14848 Comm: kworker/u4:11 Not tainted 6.6.0-rc1-syzkaller-00236-gad8a69f361b9 #0
> 
> Fixes: 1c29fc4989bc ("[BRIDGE]: keep track of received multicast packets")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: bridge@lists.linux-foundation.org
> ---
>   net/bridge/br_forward.c | 4 ++--
>   net/bridge/br_input.c   | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



