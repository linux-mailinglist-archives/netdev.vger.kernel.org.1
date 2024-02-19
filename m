Return-Path: <netdev+bounces-72836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932E859E10
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050B8280DC2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEED20DFA;
	Mon, 19 Feb 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hy/SMU/X"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAE210E1
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330835; cv=none; b=K968o4pw9a0CsaUYakE8JGY3KIVgdZ1KKq/fa4Cw/MX/u3zdsmHXx4ErgL5H0uvadYWi7OMfSs504kawol4RNAnQTrO728e/r1uD9YwhZPUhuHtlqVChvQHKXxN5iIUVNQFD/nwLd2sdv/ql3PC5xbyK6BrckIeS532czXU/HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330835; c=relaxed/simple;
	bh=OngStKLWA/FvchTmAXxNqAPV+uRdOnu6k2F2Sieq6q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eBr3FHGExLpeQi5kXi04K+QQpVz6dpr7O1Piimmq6Nt+gMsYGVFYLBf7RDwquv+9AxDaWK4BfI+wmNGa5Og0+6BfREWGgxjiHoo3goaxF3MexwNBjdC6AN6qD75oh4TXlvyDsdKEd16nhLkQpsJgSxm0RqBRLEBJfvmDzp846jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hy/SMU/X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=hJiOP12KV9zgjXzUPTwEbRnjiDrwo8oS8JXNvhn8qdw=; b=hy/SMU/XKPp9pBhUlHAVVbadgt
	lPgwiEZFqltInppo02U2sRziizoSoq8YFJPtgcHSvSfTNjX8Xt2TSr4AUcqyL2FPI9UeVWVInEcps
	BO4avB/FLKY+WUzxOSgaks4iwepX4bz+7wQQLojJ6uYtU3RO7c0MlQ3QoYK3P4EEmAouRigRPjSp9
	TmfUqlYmFNkkU0DhXbD9nqLX8J4WR96L6Q5YdOZVDLZ5hIyHUsUlFfsNWIYMI09L80fvgKL/RIfXd
	MQbDXx4Ilfu51Up+bwCp4r0xKDF5tELvIpJDa2T9+lBlAi6pOC81sYRFeGKdZ9DcgXYwXJmebwJL3
	fqlOqcMg==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbysz-0000000CJqI-3949;
	Mon, 19 Feb 2024 08:20:26 +0000
Message-ID: <92d9d2bd-14db-4782-ae3e-737459a8672d@infradead.org>
Date: Mon, 19 Feb 2024 17:20:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
To: Paolo Abeni <pabeni@redhat.com>, sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
 <0b649004-4465-404f-b873-1013bb03a42d@infradead.org>
 <e3953200fb8f0e81f76e62e3cb397b31f9c864b3.camel@redhat.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <e3953200fb8f0e81f76e62e3cb397b31f9c864b3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/24 19:06, Paolo Abeni wrote:
> On Fri, 2024-02-16 at 18:37 +0900, Geoff Levand wrote:
>> On 2/13/24 21:07, Paolo Abeni wrote:
>>> On Sat, 2024-02-10 at 17:15 +0900, Geoff Levand wrote:
>>>> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
>>>> 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in a
>>>> kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.
>>>>
>>>> This fix changes the way the napi buffer and corresponding SKB are
>>>> allocated and managed.
>>>
>>> I think this is not what Jakub asked on v3.
>>>
>>> Isn't something alike the following enough to fix the NULL ptr deref?
>>>
>>> Thanks,
>>>
>>> Paolo
>>> ---
>>> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
>>> index d5b75af163d3..51ee6075653f 100644
>>> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
>>> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
>>> @@ -395,7 +395,6 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
>>>         descr->hw_regs.data_error = 0;
>>>         descr->hw_regs.payload.dev_addr = 0;
>>>         descr->hw_regs.payload.size = 0;
>>> -       descr->skb = NULL;
>>
>> The reason we set the SKB pointer to NULL here is so we can
>> detect if an SKB has been allocated or not.  If the SKB pointer
>> is not NULL, then we delete it.
>>
>> If we just let the SKB pointer be some random value then later
>> we will try to delete some random address.
> 
> Note that this specific 'skb = NULL' assignment happens just after a
> successful allocation and just before unconditional dereference of such
> ptr:
> 
>         descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
>         if (!descr->skb) {
>                 descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
>                 return -ENOMEM;
>         }
> 
>         descr->hw_regs.dmac_cmd_status = 0;
>         descr->hw_regs.result_size = 0;
>         descr->hw_regs.valid_size = 0;
>         descr->hw_regs.data_error = 0;
>         descr->hw_regs.payload.dev_addr = 0;
>         descr->hw_regs.payload.size = 0;
> 	// XXX here skb is not NULL and valid 
>         descr->skb = NULL;

I see your point now.  I'll send out a fix-up patch that just
moves the initialization of the descr to before the allocation
of the SKB.  Thanks.

-Geoff

