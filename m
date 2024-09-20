Return-Path: <netdev+bounces-129107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FE97D82D
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EEA1F224DC
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87617E008;
	Fri, 20 Sep 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="eMUG0YVa"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86236F2F3
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849022; cv=none; b=lur/LqTqOxTPuFn9t9daY8Gt+wzUkoTRnWEG24N6PlUE3XI5Be1hAuZvFGQ/bkV2SyU0x7qPBN4KTK5FgATzAOGtwmGDxp0MboTldtxtWhVwKk/pT14rON2EPxxqgFffSGq2CTPe5c78i73pyrMRqhx43Qi4vneOanRw4gtDzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849022; c=relaxed/simple;
	bh=f/8UTt09XOiV8x1XDiwztEOYb3lYZxxZMduFUecgdy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PvPDNhU6oVgSY4zuSPQC9eHWDqhmuqg7mtVi0BUwEaNSX1RukeV857GL+xpHVMb6kP0zrfw12PKnuP+7MYckmn1TimQZVfNNuuY5EFxdsqouM2yPXYN6E0yf0pCEF/JP3pehvA1CaUizp3us5cRtNMWh5U5RdEYSb467lyJQw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=eMUG0YVa; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DD6A7C006E;
	Fri, 20 Sep 2024 16:16:52 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6985813C2B0;
	Fri, 20 Sep 2024 09:16:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6985813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726849012;
	bh=f/8UTt09XOiV8x1XDiwztEOYb3lYZxxZMduFUecgdy8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eMUG0YVaN/mbOQYA0cNSSgDXk1xcMrk2cr3Cb4D8Troev8xoLK2/hZvEvqnOfqUSw
	 GdYxZKYmliePEjrNZpVcjr1aK8565mfWsHi3SnSEqyLmhhqWmGlwBDNYs5/JjYsqeY
	 C4vANQdRRQdH+Br3a5xnztWvREJIhkVKZYngPI0A=
Message-ID: <2c72e9ad-657b-a498-0fe5-1224a4b3dc1a@candelatech.com>
Date: Fri, 20 Sep 2024 09:16:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] af_packet: Fix softirq mismatch in tpacket_rcv
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>
References: <20240918205719.64214-1-greearb@candelatech.com>
 <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
 <0bbcd0f2-42e1-4fdc-a9bd-49dd3506c7f4@candelatech.com>
 <66ec5500c3b26_2e963829496@willemb.c.googlers.com.notmuch>
 <05371e60-fe62-4499-b640-11c0635a5186@kernel.org>
 <05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com>
 <66ed3904738bb_3136a8294eb@willemb.c.googlers.com.notmuch>
 <daa7deb0-8412-4aa3-ab76-a2244995c3f3@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <daa7deb0-8412-4aa3-ab76-a2244995c3f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1726849013-oaxHj3_3yA9d
X-MDID-O:
 us5;ut7;1726849013;oaxHj3_3yA9d;<greearb@candelatech.com>;7f5d7a0772171613f08844d6b95fd3b5

On 9/20/24 08:01, David Ahern wrote:
> On 9/20/24 2:57 AM, Willem de Bruijn wrote:
>> Ben Greear wrote:
>>> On 9/19/24 13:00, David Ahern wrote:
>>>> On 9/19/24 10:44 AM, Willem de Bruijn wrote:
>>>>> Yes, it seems that VRF calls dev_queue_xmit_nit without the same BH
>>>>> protections that it expects.
>>>>>
>>>>> I suspect that the fix is in VRF, to disable BH the same way that
>>>>> __dev_queue_xmit does, before calling dev_queue_xmit_nit.
>>>>>
>>>>
>>>> commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853 removed the bh around
>>>> dev_queue_xmit_nit:
>>>>
>>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>>> index 6043e63b42f9..43f374444684 100644
>>>> --- a/drivers/net/vrf.c
>>>> +++ b/drivers/net/vrf.c
>>>> @@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
>>>>                   eth_zero_addr(eth->h_dest);
>>>>                   eth->h_proto = skb->protocol;
>>>>
>>>> -               rcu_read_lock_bh();
>>>>                   dev_queue_xmit_nit(skb, vrf_dev);
>>>> -               rcu_read_unlock_bh();
>>>>
>>>>                   skb_pull(skb, ETH_HLEN);
>>>>           }
>>>
>>> So I guess we should revert this?
>>
>> Looks like it to me.
>>
>> In which case good to not just revert, but explain why, and probably
>> copy the comment that is present in __dev_queue_xmit.
>>
> 
> Ben: does it resolve the problem you were investigating?
> 
> It would be good to add a selftest that sets up a VRF, attaches tcpdump
> and then sends a few seconds of iperf3 traffic through it. That should
> be similar to the use case here and I expect it to create a similar
> crash. That should help prevent a regression in addition to the comment.

We'll test in next day or two and let you know, but at least the patch
I posted previously 'fixed' things, so likely the revert will as well.

And, I think you need a 'real' eth port in the VRF, as original likely broken
commit claimed to test with veth and tcpdump successfully, probably because
veth rcv path is not in soft-irq or something?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



