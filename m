Return-Path: <netdev+bounces-42374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBAE7CE7F3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B4B20E63
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49C47353;
	Wed, 18 Oct 2023 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="wrodZjX8";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="L6lImKQB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800445F7B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:42:32 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA728120;
	Wed, 18 Oct 2023 12:42:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 07C3260182;
	Wed, 18 Oct 2023 21:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697658148; bh=oVm2UeTLL1+gXo5SxwvlDU0UvwNzbsB+IW0yF0pXPtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wrodZjX8+R/BMPVdgayyc/4NK7tvEvWy6hQD0uLMDqL1dTY8cmDiMgyMF7Vu1sdoL
	 r5Y57l15wv9sNLLUbrDKnFqIxJkUMD4BiPs4haSmXWnnK495TZr6bko5A3IO0i8LwN
	 gdyWC6Bxk6axl57KR8K9eo9xe3+1Y5CE+9eJ5h845bYkzhPqUAycb4uVTFiF26aaMB
	 TT3CA/T/Vt1sqXBIlxuW24FjEvTXP1C7Kr91rgBmEmOvz6+q/TMd7GRbrgcxdfkJS1
	 BD4JfBkSC0bX5av+Z8aTvBAczHbFniZa9O/bGtFKH0PPtqTRv9hduI0CQuqDzpOb/Y
	 pQ3EHcEcPyrXw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKjniq1WPAhA; Wed, 18 Oct 2023 21:42:25 +0200 (CEST)
Received: from [192.168.1.6] (78-2-200-105.adsl.net.t-com.hr [78.2.200.105])
	by domac.alu.hr (Postfix) with ESMTPSA id 677186017E;
	Wed, 18 Oct 2023 21:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697658145; bh=oVm2UeTLL1+gXo5SxwvlDU0UvwNzbsB+IW0yF0pXPtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L6lImKQBvvzlVF7shHHFNP+irS8udWamxDfliouuUsqHppJr8SlkcJl4JKvm9qRT0
	 Es+X+qTzqnQPHEDm/1TXMbLGUs5gTXWAu+cX4tqmPhcA8Vxe8E8Gl5rJ1yDSvPYLEb
	 TVokCvYWEqRTEYLHVIz/G0C/H4DBYlhNJKNwgU8HlyHre6srTe/OWAuWxTLk4mvv0l
	 zpC1ptnCGyJp/Cs/5aZIm5gdyZUfARMeO/PouoZrAfyz8uLxblMM2wZKKP+nJkk99b
	 5wlidJ6TbvcGZGuaCQppwS0RaylcyXgoEREP/QaD7tfKJb8+ARsdFoLrnX4A7v106T
	 Pf+rnS9oGW7/Q==
Message-ID: <0ee096e8-8a72-40fc-824d-aaacfbd12dec@alu.unizg.hr>
Date: Wed, 18 Oct 2023 21:42:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] r8169: fix the KCSAN reported data-race in rtl_tx
 while reading TxDescArray[entry].opts1
To: Simon Horman <horms@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marco Elver <elver@google.com>
References: <20231016214753.175097-1-mirsad.todorovac@alu.unizg.hr>
 <20231016214753.175097-3-mirsad.todorovac@alu.unizg.hr>
 <20231017200138.GB1940501@kernel.org>
 <992dcaf7-2b24-4e91-8c69-a5471da209ae@alu.unizg.hr>
 <20231018135628.GQ1940501@kernel.org>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231018135628.GQ1940501@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 15:56, Simon Horman wrote:
> On Tue, Oct 17, 2023 at 10:43:36PM +0200, Mirsad Todorovac wrote:
>> On 10/17/23 22:01, Simon Horman wrote:
>>> On Mon, Oct 16, 2023 at 11:47:56PM +0200, Mirsad Goran Todorovac wrote:
>>>> KCSAN reported the following data-race:
>>>>
>>>> ==================================================================
>>>> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>>>>
>>>> race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by interrupt on cpu 21:
>>>> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>>>> __napi_poll (net/core/dev.c:6527)
>>>> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>>>> __do_softirq (kernel/softirq.c:553)
>>>> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>>>> irq_exit_rcu (kernel/softirq.c:647)
>>>> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
>>>> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
>>>> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>>>> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>>>> call_cpuidle (kernel/sched/idle.c:135)
>>>> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>>>> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>>>> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>>>> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>>>
>>>> value changed: 0xb0000042 -> 0x00000000
>>>>
>>>> Reported by Kernel Concurrency Sanitizer on:
>>>> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>>>> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>>> ==================================================================
>>>>
>>>> The read side is in
>>>>
>>>> drivers/net/ethernet/realtek/r8169_main.c
>>>> =========================================
>>>>      4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>>>      4356                    int budget)
>>>>      4357 {
>>>>      4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>>>>      4359         struct sk_buff *skb;
>>>>      4360
>>>>      4361         dirty_tx = tp->dirty_tx;
>>>>      4362
>>>>      4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>>>      4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>>>>      4365                 u32 status;
>>>>      4366
>>>>    → 4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>>>>      4368                 if (status & DescOwn)
>>>>      4369                         break;
>>>>      4370
>>>>      4371                 skb = tp->tx_skb[entry].skb;
>>>>      4372                 rtl8169_unmap_tx_skb(tp, entry);
>>>>      4373
>>>>      4374                 if (skb) {
>>>>      4375                         pkts_compl++;
>>>>      4376                         bytes_compl += skb->len;
>>>>      4377                         napi_consume_skb(skb, budget);
>>>>      4378                 }
>>>>      4379                 dirty_tx++;
>>>>      4380         }
>>>>      4381
>>>>      4382         if (tp->dirty_tx != dirty_tx) {
>>>>      4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>>>>      4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>>>>      4385
>>>>      4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>>>>      4387                                               rtl_tx_slots_avail(tp),
>>>>      4388                                               R8169_TX_START_THRS);
>>>>      4389                 /*
>>>>      4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>>>>      4391                  * too close. Let's kick an extra TxPoll request when a burst
>>>>      4392                  * of start_xmit activity is detected (if it is not detected,
>>>>      4393                  * it is slow enough). -- FR
>>>>      4394                  * If skb is NULL then we come here again once a tx irq is
>>>>      4395                  * triggered after the last fragment is marked transmitted.
>>>>      4396                  */
>>>>      4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>>>      4398                         rtl8169_doorbell(tp);
>>>>      4399         }
>>>>      4400 }
>>>>
>>>> tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONCE() fixes
>>>> this KCSAN warning.
>>>>
>>>>      4366
>>>>    → 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
>>>>      4368                 if (status & DescOwn)
>>>>      4369                         break;
>>>>      4370
>>>>
>>>> Fixes: ^1da177e4c3f4 ("initial git repository build")
>>>
>>> Hi Mirsad,
>>>
>>> The fixes tag above seems wrong.
>>
>> Hi, Simon,
>>
>> It is taken directly from "git blame" as you can check for yourself.
>>
>> It is supposed to tag the commits prior to the introduction of git.
>>
>> If you have a better idea how to denote those, I will be happy to learn,
>> but I have no better clue than what "git blame" gives ...
> 
> Interesting, thanks for the explanation.
> I do think it's more usual, in such cases, to use the following.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Objection noted, thanks.

As the Linux kernel development deserves our best, I have submitted the v4 of the patch
series.

Best regards,
Mirsad Todorovac

>> Best regards,
>> Mirsad Todorovac
>>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Cc: nic_swsd@realtek.com
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Marco Elver <elver@google.com>
>>>> Cc: netdev@vger.kernel.org
>>>> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>> Acked-by: Marco Elver <elver@google.com>
>>>
>>> ...
>>

