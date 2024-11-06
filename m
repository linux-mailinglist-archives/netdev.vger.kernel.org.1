Return-Path: <netdev+bounces-142358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D99BE7C3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B291F21B72
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002021DF257;
	Wed,  6 Nov 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5KnG693"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5A1DED58
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895449; cv=none; b=GGxkAFmGnmNBHIDJbjRnnkSCUHnwsjfzKg0B2zEnsPw8Vw02Kc7cu2d9NIvJ0EyB7o94plBr3J/3ubfBFYWtbhYM5Trx7UJQq7FGElDq0JH73yOd2v2wFUPypNJIixNkJR+cs0979VDUAkrucLBDUWjPanA1gLkIK26yG+KLO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895449; c=relaxed/simple;
	bh=196TVmiakRBy02EBSoKk7AzlI/8SaJ3TbzOQPpXj/HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqu021Cs6Laf+KxiEPHZnFUzyV0Wad9F0Z7mM3aENCGpHBYIi/Q0poewd5DhY5SQciO0ROzmIAiRPqckvwmiCFUu95mDkn0YNehM9T987iRJ+ZbnO5fvTuHyMbOeT8snBn5TqCoKFfcPHC203YIyqQ6Jg1wj5Hhn9gWwIbaJO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5KnG693; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F7C4CECD;
	Wed,  6 Nov 2024 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730895449;
	bh=196TVmiakRBy02EBSoKk7AzlI/8SaJ3TbzOQPpXj/HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5KnG693j91BpLtNQ0rhU5nUa/AkOC+/7C8ssR2DuaYpWJV+Smysb89VsK8KMGxbp
	 6mwjYCz2y4/49nWGKPhAD5Z52ZhISHy+Joy3Bl0NAcwjqYmZERdm1Zst9wIDgYy093
	 CSv41e+dd+60eGxoRxIMfzrLGBS8+3UeyzxAAgl1SWdKpiQGOtEvjTSLRCJcURPwNV
	 LgdfiTGHOKUKwJTwR7sUEVbgKMzX0bMvOBYOLgBLC3896kb8j9xw3Hb0hBWJgyhheR
	 PRpZOypBjVFEwDHcAeHvzcZob1vzLDvMPxu4DIFdmfzfxoWeC5XNufxX1+76hqNQvT
	 pWrSS9ZULWh6Q==
Date: Wed, 6 Nov 2024 14:17:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	antony.antony@secunet.com
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
Message-ID: <20241106121724.GB5006@unreal>
References: <20241104233251.3387719-1-wangfe@google.com>
 <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>

On Tue, Nov 05, 2024 at 03:41:15PM -0800, Feng Wang wrote:
> Hi Leon,
> I checked the current tree and there are no drivers who support packet
> offload. Even for the mlx5 driver, it only supports crypto offload
> mode. 

I don't know what to add here. We already had this discussion for more
than once.
https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
Let's me cite Steffen:

"There are 'packet offload drivers' in the kernel, that's why we
support this kind of offload."

> If I miss anything, please let me know.
> Since the driver only requires the Security Association (SA) to
> perform the necessary transformations,  policy information is not
> needed. Storing policy information, matching the policy and checking
> the if_id within the driver wouldn't provide much benefit. 

You need to make sure that policy and SA has match in their selectors,
and IMHO you can't add support to SA without adding same support to
policy.

> It would increase CPU and memory usage without a clear advantage.
> For all other suggestions, I totally agree with you.
> 
> Thanks,
> Feng

