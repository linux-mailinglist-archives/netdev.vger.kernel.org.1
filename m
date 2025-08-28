Return-Path: <netdev+bounces-217987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF51B3AB4C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A641B3A6F40
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868D258EF5;
	Thu, 28 Aug 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frV3LaKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD51862A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411792; cv=none; b=kc3/o43dtp7KH9Wnh+jnKoHf+y80OGkgADYt9VnX+Lc4LjAXSDCn7+2DEpRLoHY1AH/2fuzth+tzWjG7nigzNzQoP4pTd382Yy0PXseg2SXfBREXCsDTv2LUN+SKx/4v0QAvz2N0FLzQa3kR45agyIxaERIZ7Tnkliu5chIx3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411792; c=relaxed/simple;
	bh=WVVhSFnEfuQY5vGS7w9O7aus+94H8CFCh01HdLD/b8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzr5QbWls4Cft+6X3kf/jQOkLB2ByNp5FBatXVO/88/Iepd0iipax21V22oRa7jlR8WXYuq1qlZKHW9ZU8f92EgrN6Sqt12Sn7mAuntGyEwiPtCFM/M6/UPEyGGtkufi+xUg0dY7eS+OAlX+wTHsJ8fjae/kCe4mIAz5rnJcLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frV3LaKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0A1C4CEEB;
	Thu, 28 Aug 2025 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756411791;
	bh=WVVhSFnEfuQY5vGS7w9O7aus+94H8CFCh01HdLD/b8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frV3LaKH4cwyRA7Frh+pDKtNYvZ8QCIRNCw3tW5pVLJ9uvghfY0hrW3T/FF+hSPeo
	 WzVeSvSIp2yL4u6XyM53MpbpO7MDXfVn/I/StEs0zrh+Qy677WVY1//SP7QZUsqpnM
	 C0x5OCRMbBacsVkueMYviqj1dAFymga6L+HAEVT9mt8Ih9Z0AixEs1f5PuGQOrflLD
	 0uNlYNznlgaMC7mS2q1sFqJXxhlOlkb0yp67Khb+KbIL5Zy5yKtxap3T8qR6JriJQY
	 7JAfE6aco1JqLzp58REbnTOs3YcAcSjq0tX+wkHXJE5tf1mjoF0Teg0nU9DIBiiaDy
	 RMzBNIx6SbUag==
Date: Thu, 28 Aug 2025 13:09:50 -0700
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
Message-ID: <aLC3jlzImChRDeJs@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
 <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250710152421.31901790@kernel.org>

On 10 Jul 15:24, Jakub Kicinski wrote:
>On Wed, 9 Jul 2025 23:04:07 -0700 Saeed Mahameed wrote:
>> On 09 Jul 19:58, Jakub Kicinski wrote:
>> >On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
>> >> Devices that support this in permanent mode will be requested to keep the
>> >> port link up even when driver is not loaded, netdev carrier state won't
>> >> affect the physical port link state.
>> >>
>> >> This is useful for when the link is needed to access onboard management
>> >> such as BMC, even if the host driver isn't loaded.
>> >
>> >Dunno. This deserves a fuller API, and it's squarely and netdev thing.
>> >Let's not add it to devlink.
>>
>> I don't see anything missing in the definition of this parameter
>> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
>> netdev controls the underlying physical link state. But this is not
>> true anymore for complex setups (multi-host, DPU, etc..).
>
>The policy can be more complex than "keep_link_up"
>Look around the tree and search the ML archives please.
>

Sorry for replying late, had to work on other stuff and was waiting
internally for a question I had to ask about this, only recently got the
answer.

I get your point, but I am not trying to implement any link policy
or eth link specification tunables. For me and maybe other vendors
this knob makes sense, and Important for the usecase I described.

Perhaps move it to a vendor specific knob ? or rename to
link_{fw/soc}_controlled?

>> This is not different as BMC is sort of multi-host, and physical link
>> control here is delegated to the firmware.
>>
>> Also do we really want netdev to expose API for permanent nic tunables ?
>> I thought this is why we invented devlink to offload raw NIC underlying
>> tunables.
>
>Are you going to add devlink params for link config?
>Its one of the things that's written into the NVMe, usually..

No, the purpose of this NVM series is to setup FW boot parameters and not spec related
tunables.


