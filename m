Return-Path: <netdev+bounces-62533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2F827B53
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 00:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8CD1F23943
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FA46556;
	Mon,  8 Jan 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwPS8J2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2241A85
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 23:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C47DC433F1;
	Mon,  8 Jan 2024 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704755664;
	bh=Qm7M4TAZCE/JXikm/GtbWhwvcUkRXXYIN2AdlFytQIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwPS8J2cmGAj/SCxDiAXt0KGsRQVdCDoe9qQVg1KlaRMDy1G3V7grEthN64y1AwkJ
	 nlfMRZ3W9i+qBlbXX0LtmCOhLPXRh1cmET7p6Cmh6hedQD9+VIbEXKghqMO9UQyUxd
	 oJYKjfqorwzIICz4Xiq591kFETg5fUyJHmnbZp6UU03CcHKdVVv6jWZ7t3WPy9uFXD
	 SYDlm4A8bL72JLiZ3wOAhwOfiCmPvvEN+0IU+5BhcG4fGSDAXXvjM7pa1zfuvybUUG
	 tOPK5qDVHwMZfMjfx13CV6ggSnBN9PT07HbFOyHY23AgPhDVwGf9/jRWbmrgLvUSRD
	 UQkiPhR/TNgow==
Date: Mon, 8 Jan 2024 15:14:22 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next 00/15] mlx5 updates 2023-12-20
Message-ID: <ZZyBzmqsFy6nTs2R@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20240104144721.1eaff202@kernel.org>
 <20240107171902.5f23ad0f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240107171902.5f23ad0f@kernel.org>

On 07 Jan 17:19, Jakub Kicinski wrote:
>On Thu, 4 Jan 2024 14:47:21 -0800 Jakub Kicinski wrote:
>> On Wed, 20 Dec 2023 16:57:06 -0800 Saeed Mahameed wrote:
>> > Support Socket-Direct multi-dev netdev
>>
>> There's no documentation for any of it?
>>
>> $ git grep -i 'socket.direct' -- Documentation/
>> $
>>
>> it's a feature many people have talked about for ever.
>> I'm pretty sure there are at least 2 vendors who have
>> HW support to do the same thing. Without docs everyone
>> will implement is slightly differently :(
>
>No replies so far, and v6.8 merge window has just begun,
>so let me drop this from -next for now.
>

But why revert ? what was wrong with the code or the current design? 
The current comments aren't that critical and I am sure you understand
that people are on holiday vacation.

We will provide the docs, but IMHO, docs could have been easily a follow
up.

What's the point of the upstream process if a surprise
revert can be done at any point by a maintainer? This is is not the first
instance, This has happened before with the management PF first iteration,
at least that time you asked for a revert and we approved, but this revert
came as a complete surprise.. 

Can we not do these reverts in such a stealthy way, this makes the whole
acceptance criteria unreliable, many teams rely on things getting accepted
so they plan the next steps, we have an upstream first open source policy
at nVidia networking and predictability is very important to us,
uncertainty especially when things are already accepted is something that
is very hard for us to work with.

Thanks,
Saeed.


