Return-Path: <netdev+bounces-270943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCOuGtNWwmmGbwQAu9opvQ
	(envelope-from <netdev+bounces-270943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:18:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B25305746
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A9630DA1F4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147ED3DBD52;
	Tue, 24 Mar 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFmz9FjH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDZYujGT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C853DB65B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343325; cv=none; b=HHawK6xKOZ1JcSM9VWK4Wrdfqat9crT5v3GQDg6slfvWPDpUq4A5fpwVYJDilmErYI8SXPvOmlv8FjoQ24Q+A+uhyZJnyI7dsIY1Fs+z3ZCjvmkRLgo3bXBwh5UuMRFXZAjfZnsHTyBU78/cbZlVU0QvuUtl5L8VtdkLE+xvsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343325; c=relaxed/simple;
	bh=yd6DYJ0y3uwEWAiX1zsawLflirqST3n+PB4JlAWBZoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKL0yiwpw8cwNHfD835WnEih073jB+pX/jWPxNCpRD7kFU5l2j4SgTVWpgU2UMac8QZSnkmxrt9YTFBVOkuEOk1O5KMbJJMpr45dKcV/YhmgD3C2zJ+owe5Y3AGhDsSXkteK3lj2xf1ASoveOkP3yi4QhfX/OkxjjMZ4kgXDFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFmz9FjH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDZYujGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774343318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs+0ES7iUs9GGgQYZZ2Dzqw03OyEpRTN0rke19F7AHA=;
	b=iFmz9FjHjxJ4unO+/xZ4wMeFV8m3EGKEViolPd3lYC5tDx5kPTZwwooWLFUkGFsXia1Nsz
	4GuEIYid75+wjM4NyPb/X4MDPjjAlCfzkUzMZmMHpRBWE2ijOeUD9YQwXi4YxovOw3Sdst
	l5rJvFlVh83PZsrwhmD4s89ogN8m8dg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-XDi7CgjjNq6fnRiuaSnu6A-1; Tue, 24 Mar 2026 05:08:36 -0400
X-MC-Unique: XDi7CgjjNq6fnRiuaSnu6A-1
X-Mimecast-MFC-AGG-ID: XDi7CgjjNq6fnRiuaSnu6A_1774343315
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b41d45be4so4769780f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774343315; x=1774948115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs+0ES7iUs9GGgQYZZ2Dzqw03OyEpRTN0rke19F7AHA=;
        b=aDZYujGT7bUbBHAUbHFxwgOGirL1MTiCBm4tP/dCtrcL7GINysMiMZgHUm+LaZGFxb
         g4VMwXk3efIniNibxf5sYkO/F69N9xSEJEZuuzfoxvvpIbMzfr5u5QgfHyJI+O02yJwp
         Q/FSxUCap8HwArdm5hOMePgu1Q4J7RVbzgWtHtkD0pBDCBpIeSTJcWju07HTZlPVtJ5O
         G7rxXbh15BRw2iF0JloK+l6RcedKuo5MMgLr+SdJhoofZOji3cszM+VFSFfxjY+WkNcz
         zJmrPAMycsVKDpXfvjXqG1HwDOSfO36JnpB0jLZGqnBxpW6Ivmhccv/h0WzybRgZQlVW
         IjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343315; x=1774948115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs+0ES7iUs9GGgQYZZ2Dzqw03OyEpRTN0rke19F7AHA=;
        b=Eyzb956zouLHXA5rSaHvdklnq6xLlpojvCrG4IueQVQ5NEFXJgRc9Rvq0SJ3QB34z9
         KCRBYWtJBEUs0cHPQ8014GFfpozRKWVsTyxD+pXGvBx1andzkVaT7Ov3xGtyysCT99PB
         0ugqg0qQMu0xBiMazGcr4gDc6+L6ga9ogzSgcVVUSyo7QhdjHbJ1PjZS7rYOOPreHQwD
         9Zp/vsJ7Nj5XvySQkWZptYTb/EOpe75rEtPz0awB4lJT2Gh8mP7YCI6EFkxEfCEpJjOO
         HNhjsrwIPY2pLD8v+2Aahiab3nM89m33vo0+IngKUt9JLmMP1H8sPi7g5wbDA0IO55DW
         rAIg==
X-Gm-Message-State: AOJu0YwrtoZxwVyP9+QLTqT2asZyqrVvW4ZrJDvM8pizxtTs8/Th3bOg
	G7ZLYKLx2grsq4TUU26qr8O6IKdT5dd8Nscs4NdyfgChdHSFvTnP7uyBD4p/tJOEEaclmr+wPer
	8/sFUsPeYBkyZi+PTGo6vrEYAlcVGY6F1FCbN5p73Y3FZj8+bpH1iRsE+Wg==
X-Gm-Gg: ATEYQzzYTE5WqJz8V6hpYKTiSGKpy7Kclk0XbxA1xelQI4UWi/lFzPSlYVlkuXNMSZY
	TQiURGJ5R4DA1yG+SwYtocYn8fIpjVlRf0L/O2fdYKTFFQWlP46KPGrs3yM38YFUmRJiWfdjw7t
	49fO2Gy+oKDDfRE4fO14O1ZgXPmpAuIGrXwnINBFWBk45WEJUEAxU8MAEH82cFA3XMIbip8yO1H
	dUMez11TIQqX7HPJ40XsIHE/GW4Q45ue/g8P090dOCPs87bo6ZTa1nBsOQuBqgeySLsyBN5XndT
	Dk3KZQZKL1hQbwxBTpnQwb45W7XOIg93cKIzuZVnjNINxsvmd4HpE7Q+GyIbLigfHiYoAujTCsI
	4aQAbPIU8wPy9xar+TM+xDqCFvHT5hqMzgunzhUoRcn1FXWrwR0YGEjqw
X-Received: by 2002:a05:600c:6309:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4870f1f40d3mr34262345e9.6.1774343315394;
        Tue, 24 Mar 2026 02:08:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6309:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4870f1f40d3mr34261835e9.6.1774343314859;
        Tue, 24 Mar 2026 02:08:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487117077cbsm33820515e9.6.2026.03.24.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 02:08:34 -0700 (PDT)
Message-ID: <df909719-aca7-432c-b381-fee45c6e3ed2@redhat.com>
Date: Tue, 24 Mar 2026 10:08:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bestswngs@gmail.com
References: <20260318232332.3528647-1-xmei5@asu.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260318232332.3528647-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B7B25305746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 12:23 AM, Xiang Mei wrote:
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop.
> This causes the original skb to be either double-consumed or freed.
> 
> Always clone the skb for every slave and unconditionally free the
> original after the loop, removing the racy bond_is_last_slave()
> optimization.
> 
> The UAF can trigger the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in skb_clone
> Read of size 8 at addr ffff888100ef8d40 by task exploit/147
> 
> CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
>  kasan_report (mm/kasan/report.c:597)
>  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
>  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
>  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
>  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
>  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
>  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
>  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
>  ip6_output (net/ipv6/ip6_output.c:250)
>  ip6_send_skb (net/ipv6/ip6_output.c:1985)
>  udp_v6_send_skb (net/ipv6/udp.c:1442)
>  udpv6_sendmsg (net/ipv6/udp.c:1733)
>  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
>  __x64_sys_sendto (net/socket.c:2209)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>  </TASK>
> 
> Allocated by task 147:
> 
> Freed by task 147:
> 
> The buggy address belongs to the object at ffff888100ef8c80
>  which belongs to the cache skbuff_head_cache of size 224
> The buggy address is located 192 bytes inside of
>  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
> 
> Memory state around the buggy address:
>  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                                     ^
>  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/bonding/bond_main.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 33f414d03ab91..8e57bee13e4ad 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5310,7 +5310,6 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  	struct bonding *bond = netdev_priv(bond_dev);
>  	struct bond_up_slave *slaves;
>  	bool xmit_suc = false;
> -	bool skb_used = false;
>  	int slaves_count, i;
>  
>  	if (all_slaves)
> @@ -5326,24 +5325,18 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
>  			continue;
>  
> -		if (bond_is_last_slave(bond, slave)) {
> -			skb2 = skb;
> -			skb_used = true;
> -		} else {
> -			skb2 = skb_clone(skb, GFP_ATOMIC);
> -			if (!skb2) {
> -				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
> -						    bond_dev->name, __func__);
> -				continue;
> -			}
> +		skb2 = skb_clone(skb, GFP_ATOMIC);

The additional clone is prone allocation failure (atomic scope) and adds
additional overhead. Is really needed? Would something alike the
following work instead of the current bond_is_last_slave() check?

		if (i + 1 == slaves_count)

/P


