Return-Path: <netdev+bounces-129017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42D97CECD
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F2B21A7F
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6B142E70;
	Thu, 19 Sep 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Tci0/VQI"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578717555
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782056; cv=none; b=V+FAlo0NVNW6pqGQK6RoQ2IOGz302cg1nnCk7iDIu2qi7scYXwjxOxUC1GFs9TKiXeS/OSLeyRW1tbzpyC+hpwPpiRwVg9ODdKJZI2L+tsWXAiHvhwg4lY91BsaTPxjV8G0wOpMuk8BG0/OfgoYteYVI8BXYwY2O/DNZxKSLNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782056; c=relaxed/simple;
	bh=GFgde50qK2YYL/+S8z0tcWAlgJ8hCcp5nPlP1XguAww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2hS1XvDKjgKlHUZAdNZbSGVLFNbUUIwOzvIaxzynioGF6FEZ3ecYacJRUJyLh65pyRZMjlgUoZ+am42J1K+OAHcOZvR/MARYpa6s+gkMqq/R//fYxn+l1acQQGZnXlfEkUgQnl4KQHpuQVLIIaH8TcQZxGZ3fg6yj0XavCYfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Tci0/VQI; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D03D834006E;
	Thu, 19 Sep 2024 21:40:51 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 64A5D13C2B0;
	Thu, 19 Sep 2024 14:40:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 64A5D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726782051;
	bh=GFgde50qK2YYL/+S8z0tcWAlgJ8hCcp5nPlP1XguAww=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Tci0/VQIQPv4JjvwLBPlF9qW3oJnjhOtR3s6fwRG3nqROfa8nPzm5obob67R9zA9U
	 KWFrkgO8c8+k3d+gEF4ndIg7sTZkV8IPahTyTYJIPDOPpNFzlkgA7+AcLC57KkW7fC
	 EYGgzV8uvImU0Pz1OEnwnzuGMfe6M3quljoGOQWY=
Message-ID: <05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com>
Date: Thu, 19 Sep 2024 14:40:51 -0700
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <05371e60-fe62-4499-b640-11c0635a5186@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1726782052-qgSqlvhi77x4
X-MDID-O:
 us5;ut7;1726782052;qgSqlvhi77x4;<greearb@candelatech.com>;7f5d7a0772171613f08844d6b95fd3b5

On 9/19/24 13:00, David Ahern wrote:
> On 9/19/24 10:44 AM, Willem de Bruijn wrote:
>> Yes, it seems that VRF calls dev_queue_xmit_nit without the same BH
>> protections that it expects.
>>
>> I suspect that the fix is in VRF, to disable BH the same way that
>> __dev_queue_xmit does, before calling dev_queue_xmit_nit.
>>
> 
> commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853 removed the bh around
> dev_queue_xmit_nit:
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 6043e63b42f9..43f374444684 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
>                  eth_zero_addr(eth->h_dest);
>                  eth->h_proto = skb->protocol;
> 
> -               rcu_read_lock_bh();
>                  dev_queue_xmit_nit(skb, vrf_dev);
> -               rcu_read_unlock_bh();
> 
>                  skb_pull(skb, ETH_HLEN);
>          }

So I guess we should revert this?  Maybe original testing passed because veth doesn't do
xmit/rcv quite like a real Eth driver will?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



