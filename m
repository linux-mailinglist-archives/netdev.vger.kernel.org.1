Return-Path: <netdev+bounces-212171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7EB1E8EB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4D6A00672
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8217827A451;
	Fri,  8 Aug 2025 13:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D7260592
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658542; cv=none; b=qarfGJQLGapxSiFN98Pw6y425vaiuSNbosZ6s+KnyDsmaiLZ+hz5QROX9hQoLG2QqT25KtTU5v7WUFWKUCT7fzX9DnJxLp7pVHoFt4GDgPpjKwIVZw9aaiEc7C7opcNZDAT2oFThpK3ssfTwss3NqBsNBXGC6UXXc45S5qAJIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658542; c=relaxed/simple;
	bh=PQ1M3pzKpeS2YwRzTSXMa1vklOw5zErJK7CkDJ41Dcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akv1RV+eYIfuZam+R5qHu1/R6Qhe70M0Ox9keFcRzI1UrVKBqAkHL74i2rJVLdIrInLqpvtndaj8ji1K1JVtz2vxB9FwoP0tgxKZccAYlaRLO8/KZToMN3QY+iBwLN9bYE3Wdm7ZdD0xbOsaIQQWpPSXTpJmxsguSgfCnM7ybjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CD02160288276;
	Fri, 08 Aug 2025 15:08:41 +0200 (CEST)
Message-ID: <62178d70-07c0-471b-b4dd-2e7523776243@molgen.mpg.de>
Date: Fri, 8 Aug 2025 15:08:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] ice: switch to Page Pool
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 aleksander.lobakin@intel.com, larysa.zaremba@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com
References: <20250704161859.871152-1-michal.kubiak@intel.com>
 <20250704161859.871152-4-michal.kubiak@intel.com>
 <53c62d9c-f542-4cf3-8aeb-a1263e05acad@intel.com>
 <aJXiP-_ZUfBErhAv@localhost.localdomain>
 <ee6af42d-b274-4079-8a8b-35ec8d500c1c@molgen.mpg.de>
 <aJX168tInG4tFk5j@localhost.localdomain>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aJX168tInG4tFk5j@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for your reply.

Am 08.08.25 um 15:04 schrieb Michal Kubiak:
> On Fri, Aug 08, 2025 at 02:03:43PM +0200, Paul Menzel wrote:

>> Am 08.08.25 um 13:40 schrieb Michal Kubiak:
>>> On Mon, Jul 07, 2025 at 03:58:37PM -0700, Jacob Keller wrote:
>>>>
>>>>
>>>> On 7/4/2025 9:18 AM, Michal Kubiak wrote:
>>>>> @@ -1075,16 +780,17 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
>>>>>    static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>>>
>>> [...]
>>>
>>>>> @@ -1144,27 +841,35 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>>>>>    		if (ice_is_non_eop(rx_ring, rx_desc))
>>>>>    			continue;
>>>>> -		ice_get_pgcnts(rx_ring);
>>>>>    		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
>>>>>    		if (xdp_verdict == ICE_XDP_PASS)
>>>>>    			goto construct_skb;
>>>>> -		total_rx_bytes += xdp_get_buff_len(xdp);
>>>>> -		total_rx_pkts++;
>>>>> -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
>>>>> +		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
>>>>> +			xdp_xmit |= xdp_verdict;
>>>>> +		total_rx_bytes += xdp_get_buff_len(&xdp->base);
>>>>> +		total_rx_pkts++;
>>>>> +		xdp->data = NULL;
>>>>> +		rx_ring->first_desc = ntc;
>>>>> +		rx_ring->nr_frags = 0;
>>>>>    		continue;
>>>>>    construct_skb:
>>>>> -		skb = ice_build_skb(rx_ring, xdp);
>>>>> +		skb = xdp_build_skb_from_buff(&xdp->base);
>>>>> +
>>>>>    		/* exit if we failed to retrieve a buffer */
>>>>>    		if (!skb) {
>>>>>    			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
>>>>
>>>> This is not your fault, but we've been incorrectly incrementing
>>>> alloc_page_failed here instead of alloc_buf_failed.
>>>>
>>>
>>> Sure. It's a good idea to fix it while we're rewriting the Rx path.
>>> Will be addressed in v2.
>>
>> Should this be a separate patch, that can be easily backported?
>>
>> […]

> Do you mean that the patch should be included as part of the series, or would
> you prefer it to be submitted as a standalone patch targeting the 'net' tree?
Good question. I do not know the rules. My gut would say a separate 
patch for 'net', but the others know best.


Kind regards,

Paul

