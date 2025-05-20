Return-Path: <netdev+bounces-192016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B571BABE424
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5918B4C2C0E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407F2820CC;
	Tue, 20 May 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFCkIs6T"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A9283144
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770836; cv=none; b=IB70Qh+MrYMGzCYZG4m287UQogVyqXS8ggqYM/H9rbrfCt9tF1C6QmoCkHh7zLcVn4nUoUlWiQKD/dlYQzocdfeIZP+zV18In3ckwi2QaqZ4rGFxOum6ojsLQ4odQjRqLoQ9ogKxJoki2q3krN34jxn1QBtMo1JOot3Ou5czMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770836; c=relaxed/simple;
	bh=LMow8st1O7Ysp4v8Zqt9T/zgaRzah2q6OQC3qfPUJiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL+Lfpv2XedKSHUWj8PtlQOcnVjrngt/3wBFWnPxBGS7yfXto290AzPAY+j00aa+c+rZ7gqes9U+1fgYfB1t//MVUuNqVxPHr29O2OCmimHHqilX9aSNnJGmNpl5lJrjRX+/Mdv72YFU7Dbh/ePOxAdTtLp90yoD6iKI00ZVLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFCkIs6T; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abf16cc2-c350-430d-a2fd-2a8bedef9f34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747770822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgVreyh/32mfFDTl9eouagm/kPBKpy5gDkzprCKXQV8=;
	b=QFCkIs6Ti1ypb1zPq6wred4TjtU/VIph0994kvbSrUFnqbsECVutNgiCCrb7t6OrfPKHk/
	/0zEsUTsjc3PM2ue+rWJYcISlDW0c8wVJJCvSBAxxcXvP4TDVUgwtUnPNptQdelcDpPLtY
	wFg9O67+IgAh1R5xLOxp2AHH005ADso=
Date: Tue, 20 May 2025 20:53:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 6/8] gve: Add rx hardware timestamp expansion
Content-Language: en-US
To: Ziwei Xiao <ziweixiao@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, pkaligineedi@google.com, yyd@google.com,
 joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, richardcochran@gmail.com,
 jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250517001110.183077-1-hramamurthy@google.com>
 <20250517001110.183077-7-hramamurthy@google.com>
 <50be88c9-2cb3-421d-a2bf-4ed9c7d58c58@linux.dev>
 <CAG-FcCO7H=1Xj5B830RA-=+W8umUqq=WdOjwNqzeKvJLeMgywA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAG-FcCO7H=1Xj5B830RA-=+W8umUqq=WdOjwNqzeKvJLeMgywA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19.05.2025 19:45, Ziwei Xiao wrote:
> .
> 
> 
> On Sun, May 18, 2025 at 2:45 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 17.05.2025 01:11, Harshitha Ramamurthy wrote:
>>> From: John Fraker <jfraker@google.com>
>>>
>>> Allow the rx path to recover the high 32 bits of the full 64 bit rx
>>> timestamp.
>>>
>>> Use the low 32 bits of the last synced nic time and the 32 bits of the
>>> timestamp provided in the rx descriptor to generate a difference, which
>>> is then applied to the last synced nic time to reconstruct the complete
>>> 64-bit timestamp.
>>>
>>> This scheme remains accurate as long as no more than ~2 seconds have
>>> passed between the last read of the nic clock and the timestamping
>>> application of the received packet.
>>>
>>> Signed-off-by: John Fraker <jfraker@google.com>
>>> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>> ---
>>>    Changes in v2:
>>>    - Add the missing READ_ONCE (Joe Damato)
>>> ---
>>>    drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>>> index dcb0545baa50..c03c3741e0d4 100644
>>> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>>> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>>> @@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
>>>        skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
>>>    }
>>>
>>> +/* Expand the hardware timestamp to the full 64 bits of width, and add it to the
>>> + * skb.
>>> + *
>>> + * This algorithm works by using the passed hardware timestamp to generate a
>>> + * diff relative to the last read of the nic clock. This diff can be positive or
>>> + * negative, as it is possible that we have read the clock more recently than
>>> + * the hardware has received this packet. To detect this, we use the high bit of
>>> + * the diff, and assume that the read is more recent if the high bit is set. In
>>> + * this case we invert the process.
>>> + *
>>> + * Note that this means if the time delta between packet reception and the last
>>> + * clock read is greater than ~2 seconds, this will provide invalid results.
>>> + */
>>> +static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
>>> +{
>>> +     s64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
>>
>> I believe last_read should be u64 as last_sync_nic_counter is u64 and
>> ns_to_ktime expects u64.
>>
> Thanks for the suggestion. The reason to choose s64 for `last_read`
> here is to use signed addition explicitly with `last_read +
> (s32)diff`. This allows diff (which can be positive or negative,
> depending on whether hwts is ahead of or behind low(last_read)) to
> directly adjust last_read without a conditional branch, which makes
> the intent clear IMO. The s64 nanosecond value is not at risk of
> overflow, and the positive s64 result is then safely converted to u64
> for ns_to_ktime.
> 
> I'm happy to change last_read to u64 if that's preferred for type
> consistency, or I can add a comment to clarify the rationale for the
> current s64 approach. Please let me know what you think. Thanks!

I didn't get where is the conditional branch expected? AFAIU, you can do
direct addition u64 + s32 without any branches. The assembly is also pretty
clean in this case (used simplified piece of code):

         movl    -12(%rbp), %eax
         movslq  %eax, %rdx
         movq    -8(%rbp), %rax
         addq    %rax, %rdx


> 
>>> +     struct sk_buff *skb = rx->ctx.skb_head;
>>> +     u32 low = (u32)last_read;
>>> +     s32 diff = hwts - low;
>>> +
>>> +     skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
>>> +}
>>> +
>>>    static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
>>>    {
>>>        if (!rx->ctx.skb_head)
>>


