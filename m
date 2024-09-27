Return-Path: <netdev+bounces-130119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424D98865F
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EDB23E0F
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8E199FA8;
	Fri, 27 Sep 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="MxkHJNuf"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85219AA7A
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444366; cv=none; b=HNjj6bKSbnuXwcQ62vLyNGQNTfOub40Ob9GV36tHJL/AVMh+k+ISVB1XV3/+DCs+/gjN6+pNPgTOT2Lw4dh5lLnoGM5+gDNP4/OmKV0P66mn9pjjVuZDvUDRblQq9mcjZz2yeX5ebPebpG9Tv8wJjqS58aQe8lTcBoDFGkU88M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444366; c=relaxed/simple;
	bh=JP2zDIkCGIqbUpTF9oGm2SNhnyhaPLmHo8YmuiJLRUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oy5m7XjlfIoc6UeFi4IST1WjrGjuqGRHFQuMStI8iOHOxgc4TXUiwOeT+oWchMOB9cZ0r/0+MV8F9AD6sIZic3jwtkurfESQmYC3+ZcJ4oD4+tGryvp9NiwXE7dZbfk0fnEHgAUEPrXGSXdjannB92mvzwro0SbtmPGCKFiFQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=MxkHJNuf; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0B75828005D;
	Fri, 27 Sep 2024 13:39:15 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.42.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 874F313C2B0;
	Fri, 27 Sep 2024 06:39:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 874F313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727444355;
	bh=JP2zDIkCGIqbUpTF9oGm2SNhnyhaPLmHo8YmuiJLRUA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MxkHJNufIRnWfdW7WlznLwG2fQ1foLG8BHCDPWY8r2oXWYoJ/bkk3fOQSmxveQj4f
	 +6U4sKP0CWVKRDElwFquIcS29N5jStgM7rFR20YIeoLn56J3yb/jLZ9KV9pZpKb8ui
	 bXUSj66I1LhAK4VcBhcT9hCyZoXUD+rhTybD5MsQ=
Message-ID: <d1907a7e-1988-4570-afb5-49ee4ed4ffa2@candelatech.com>
Date: Fri, 27 Sep 2024 06:39:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
References: <20240925185216.1990381-1-greearb@candelatech.com>
 <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
 <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>
 <66f67c7c5c1de_ba960294f7@willemb.c.googlers.com.notmuch>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <66f67c7c5c1de_ba960294f7@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1727444357-qkrOwM1VFOUd
X-MDID-O:
 us5;ut7;1727444357;qkrOwM1VFOUd;<greearb@candelatech.com>;2f43c458b1d402e5e75c1bcf06c3ca94

On 9/27/24 02:35, Willem de Bruijn wrote:
> Ben Greear wrote:
>> On 9/26/24 02:03, Willem de Bruijn wrote:
>>> greearb@ wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
>>>>
>>>> dev_queue_xmit_nit needs to run with bh locking, otherwise
>>>> it conflicts with packets coming in from a nic in softirq
>>>> context and packets being transmitted from user context.
>>>>
>>>> ================================
>>>> WARNING: inconsistent lock state
>>>> 6.11.0 #1 Tainted: G        W
>>>> --------------------------------
>>>> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>>> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
>>>> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
>>>> {IN-SOFTIRQ-W} state was registered at:
>>>>     lock_acquire+0x19a/0x4f0
>>>>     _raw_spin_lock+0x27/0x40
>>>>     packet_rcv+0xa33/0x1320
>>>>     __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
>>>>     __netif_receive_skb_list_core+0x2c9/0x890
>>>>     netif_receive_skb_list_internal+0x610/0xcc0
>>>>     napi_complete_done+0x1c0/0x7c0
>>>>     igb_poll+0x1dbb/0x57e0 [igb]
>>>>     __napi_poll.constprop.0+0x99/0x430
>>>>     net_rx_action+0x8e7/0xe10
>>>>     handle_softirqs+0x1b7/0x800
>>>>     __irq_exit_rcu+0x91/0xc0
>>>>     irq_exit_rcu+0x5/0x10
>>>>     [snip]
>>>>
>>>> other info that might help us debug this:
>>>>    Possible unsafe locking scenario:
>>>>
>>>>          CPU0
>>>>          ----
>>>>     lock(rlock-AF_PACKET);
>>>>     <Interrupt>
>>>>       lock(rlock-AF_PACKET);
>>>>
>>>>    *** DEADLOCK ***
>>>>
>>>> Call Trace:
>>>>    <TASK>
>>>>    dump_stack_lvl+0x73/0xa0
>>>>    mark_lock+0x102e/0x16b0
>>>>    __lock_acquire+0x9ae/0x6170
>>>>    lock_acquire+0x19a/0x4f0
>>>>    _raw_spin_lock+0x27/0x40
>>>>    tpacket_rcv+0x863/0x3b30
>>>>    dev_queue_xmit_nit+0x709/0xa40
>>>>    vrf_finish_direct+0x26e/0x340 [vrf]
>>>>    vrf_l3_out+0x5f4/0xe80 [vrf]
>>>>    __ip_local_out+0x51e/0x7a0
>>>> [snip]
>>>>
>>>> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
>>>> Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/
>>>>
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>
>>> Please Cc: all previous reviewers and folks who participated in the
>>> discussion. I entirely missed this. No need to add as Cc tags, just
>>> --cc in git send-email will do.
>>>
>>>> ---
>>>>
>>>> v2:  Edit patch description.
>>>>
>>>>    drivers/net/vrf.c | 2 ++
>>>>    net/core/dev.c    | 1 +
>>>>    2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>>> index 4d8ccaf9a2b4..4087f72f0d2b 100644
>>>> --- a/drivers/net/vrf.c
>>>> +++ b/drivers/net/vrf.c
>>>> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
>>>>    		eth_zero_addr(eth->h_dest);
>>>>    		eth->h_proto = skb->protocol;
>>>>    
>>>> +		rcu_read_lock_bh();
>>>>    		dev_queue_xmit_nit(skb, vrf_dev);
>>>> +		rcu_read_unlock_bh();
>>>>    
>>>>    		skb_pull(skb, ETH_HLEN);
>>>>    	}
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index cd479f5f22f6..566e69a38eed 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>>>>    /*
>>>>     *	Support routine. Sends outgoing frames to any network
>>>>     *	taps currently in use.
>>>> + *	BH must be disabled before calling this.
>>>
>>> Unnecessary. Especially patches for stable should be minimal to
>>> reduce the chance of conflicts.
>>
>> I was asked to add this, and also asked to CC stable.
> 
> Conflicting feedback is annoying, but I disagree with the other
> comment.
> 
> Not only does it potentially complicate backporting, it also is no
> longer a strict revert. In which case it must not be labeled as such.
> 
> Easier is to keep the revert unmodified, and add the comment to the
> commit message.
> 
> Most important is the Link to our earlier thread that explains the
> history.
> 
> If the process appears byzantine, if you prefer I can also send it.

I would appreciate it if you can send it.  As long as it functions,
I will be happy.

Thanks,
Ben

> 
> Thanks,
> 
>    Willem
> 
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


