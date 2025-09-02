Return-Path: <netdev+bounces-219273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E14B40D7C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6AE7AEFCE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA762312817;
	Tue,  2 Sep 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSUxiyMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0C2853E0
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839742; cv=none; b=CHR/DE/P8Z6r+9LUTZgxe9OH0ROcCqhw3W3g72IWrVNLNjR2JmFoUJCo/d6kHCoN7dzGhZnhJZUzgEeZOCJmx0krZssSOtuk/We/hRWiNRsNt7JKJj3R5NpLL4AmQWGJM4EBI9wfMCGee7z0JKi5Xd5QP04d0xh2SJeazGDsKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839742; c=relaxed/simple;
	bh=L62VBLHJLzF3yTlsxR3Y9WihEr42n+OtrGy3bHC1Er4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mya8IBOt0sN8+on4ajMGn1labCkbtI0eq802VMbLqxyQaf3IhAyGRxX88UJrrWls9JJajNz085JRGNTvXERUWBfgr9MV2sOH5Td76mFigSUHtn6vLLDVyTolK9ahf74D9stqlX8rkMTy9Pm0j79+ghaafohu4kuSIuTloC17Cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSUxiyMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F502C4CEED;
	Tue,  2 Sep 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839742;
	bh=L62VBLHJLzF3yTlsxR3Y9WihEr42n+OtrGy3bHC1Er4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSUxiyMqGoWErJfbe87wvKOCzDW23+Z+jU7IP+st/V/S9oYmCRUT/7o4Wo522Nl1l
	 xiYe5oxRtSrwh7wN/yLC3ig79//vXztyyLreryuJqfEomdiXaFVrA9O7+fBfoWZWH2
	 6jsogBeEtBymChVYbABBInJlrEnmTuUA/3U3+Dbpnkbc+sUQzPK+op1xr+1mCi4YMf
	 urz6Q0eKLOm3cW2HwjW2eqgNwYcymOvK1+wMNUFMmhE5vsL/UZL4FWKY7fVm+7g+te
	 nTgE447SesFqYqoex3fzghUFjncYb3GN8CvP/HvhLSoxAtfT9iH2vMVSjSZvD12dSU
	 beRfBfm7Glv+A==
Date: Tue, 2 Sep 2025 12:02:21 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <aLc_PWj1OKkjrZ0e@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
 <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org>
 <aLC3jlzImChRDeJs@x130>
 <20250828153845.4928772b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828153845.4928772b@kernel.org>

On 28 Aug 15:38, Jakub Kicinski wrote:
>On Thu, 28 Aug 2025 13:09:50 -0700 Saeed Mahameed wrote:
>> >> I don't see anything missing in the definition of this parameter
>> >> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
>> >> netdev controls the underlying physical link state. But this is not
>> >> true anymore for complex setups (multi-host, DPU, etc..).
>> >
>> >The policy can be more complex than "keep_link_up"
>> >Look around the tree and search the ML archives please.
>>
>> Sorry for replying late, had to work on other stuff and was waiting
>> internally for a question I had to ask about this, only recently got the
>> answer.
>>
>> I get your point, but I am not trying to implement any link policy
>> or eth link specification tunables. For me and maybe other vendors
>> this knob makes sense, and Important for the usecase I described.
>
>I think I was alluding to making the link stay up dependent on presence
>of BMC / management engine and or some NIC-internal agents. So to give
>a trivial example the policy could be:
> - force down
> - leave up if BMC present
> - force up
>I don't recall prior discussions TBH so doing more research will be
>necessary..

Sounds good will drop this patch and re-post. Will suggest the policy to
our Arch people to see if FW can adapt.

Thanks,
Saeed.

