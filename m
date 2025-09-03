Return-Path: <netdev+bounces-219455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45BCB41560
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948B83AB7FC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51E2D6417;
	Wed,  3 Sep 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb9z5lUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9698259C9C
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881917; cv=none; b=V9FUQRlRoNyeIXnEVwR0KIJtug0KD1SoBIWyqCakiI/W+h1BgRNM51Vi7M3RAyP278F86xTdF3uuwFYL5DefbYcnJV1mPg6bfh3+IxH0JLSEWwoIWTmADAJ7+Gafioj3FnqNsHtQqPLTvPTtf6yji10OTELM+M6P0x0ofK10grU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881917; c=relaxed/simple;
	bh=NzmIpnXATfnIFuqGaF1OnnwxatEPP8/sKse1ZupCRyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ58hpsVeU+nNdr8d//t3LUWgutJWYhzGbCpp94sEzDwyt4h8m/ruB6/JuMo3ER3GOPOWvOTZLj0mGDPgyO3KDQtgZBHjh6o294NvIlJotag0VzKt3Ic12X26BKwHNT9gXZSkH3nyzaUSWj2dczqsZaHCfzqUWujeXXsdlDMFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb9z5lUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC4C4CEF0;
	Wed,  3 Sep 2025 06:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881917;
	bh=NzmIpnXATfnIFuqGaF1OnnwxatEPP8/sKse1ZupCRyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rb9z5lUUC6cVHSaTxozTKXudFB+h6cYpAKcZv51I7JsH1YRKmLDLsiVe9GyqD7RsL
	 w3b4pA58WMFGilKGQ033/EPdBCP2DbNG7zTBQ0XdHraRYAuHVPpYU+tzjBMkWcsTK4
	 EMKFKTj0lD2aH/kyoYrimBbaVqsZjBnNmh1o1nvJcQgzgKOlHthMZVobOa/j5DIrrn
	 FRhPXmbFeKEFadAXqoSj4fcj2jfQyY/fc0fRPhxgEU8rnJaNiLR6diQUMKyJj650l8
	 4dDPMQ0TuSdbM41mDNyIxpbj9qSjj28wAnoNhm0WbN4D1DcS7TJzMnEqdVptLz4m7i
	 tW28QT9Iv0fbA==
Date: Tue, 2 Sep 2025 23:45:15 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <aLfj-9H-GL_amuYc@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
 <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org>
 <aLC3jlzImChRDeJs@x130>
 <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com>

On 02 Sep 14:57, Jacob Keller wrote:
>
>
>On 8/28/2025 1:09 PM, Saeed Mahameed wrote:
>> On 10 Jul 15:24, Jakub Kicinski wrote:
>>> On Wed, 9 Jul 2025 23:04:07 -0700 Saeed Mahameed wrote:
>>>> On 09 Jul 19:58, Jakub Kicinski wrote:
>>>>> On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
>>>>>> Devices that support this in permanent mode will be requested to keep the
>>>>>> port link up even when driver is not loaded, netdev carrier state won't
>>>>>> affect the physical port link state.
>>>>>>
>>>>>> This is useful for when the link is needed to access onboard management
>>>>>> such as BMC, even if the host driver isn't loaded.
>>>>>
>>>>> Dunno. This deserves a fuller API, and it's squarely and netdev thing.
>>>>> Let's not add it to devlink.
>>>>
>>>> I don't see anything missing in the definition of this parameter
>>>> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
>>>> netdev controls the underlying physical link state. But this is not
>>>> true anymore for complex setups (multi-host, DPU, etc..).
>>>
>>> The policy can be more complex than "keep_link_up"
>>> Look around the tree and search the ML archives please.
>>>
>>
>> Sorry for replying late, had to work on other stuff and was waiting
>> internally for a question I had to ask about this, only recently got the
>> answer.
>>
>> I get your point, but I am not trying to implement any link policy
>> or eth link specification tunables. For me and maybe other vendors
>> this knob makes sense, and Important for the usecase I described.
>>
>> Perhaps move it to a vendor specific knob ? or rename to
>> link_{fw/soc}_controlled?
>>
>
>Intel has also tried something similar sounding with the
>"link_down_on_close" in ethtool, which appears to be have made it in to
>ice and i40e.. (I thought I remembered these flags being rejected but I
>guess not?) I guess the ethtool flag is a bit difference since its
>relating to driver behavior when you bring the port down
>administratively, vs something like this which affects firmware control
>of the link regardless of its state to the kernel.
>

Interesting, it seems that i40/ice LINK_DOWN_ON_CLOSE and TOTAL_PORT_SHUTDOWN_ENA
go hand in hand, tried to read the long comment in i40 but it is mostly
about how these are implemented in both driver and FW/phy but not what they
mean, what I am trying to understand is "LINK_DOWN_ON_CLOSE_ENA" is an
'enable' bit, it is off by default and an opt-in, does that mean by default 
i40e/ice don't actually bring the link down on driver/unload or ndo->close
?

>>>> This is not different as BMC is sort of multi-host, and physical link
>>>> control here is delegated to the firmware.
>>>>
>>>> Also do we really want netdev to expose API for permanent nic tunables ?
>>>> I thought this is why we invented devlink to offload raw NIC underlying
>>>> tunables.
>>>
>>> Are you going to add devlink params for link config?
>>> Its one of the things that's written into the NVMe, usually..
>>
>> No, the purpose of this NVM series is to setup FW boot parameters and not spec related
>> tunables.
>>
>
>This seems quite useful to me w.r.t to BMC access. I think its a stretch
>to say this implies the desire to add many other knobs.

No sure if you are with or against the devlink knob ? :-)
But thanks for the i40e/ice pointers at least I know I am not alone on this
boat..


