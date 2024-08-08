Return-Path: <netdev+bounces-116943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BD94C22C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D06C1C20E1D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67018FC93;
	Thu,  8 Aug 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoEQo8pM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746318FC8C
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132794; cv=none; b=hSba9i3U6L0qPbJjOdFm/EA7ZKb+THOdS8Hd/YRj17HFTsLWC0NcGwuxLVsUG6/AjMLOvA+Yyk1sB6CZwNSnJb28SUNN61t04zCQImgMAaa98N79wtWD7kWcMVc/yK3J5oflACkRadicQrmQlGL8DGxjUNQycGhJqccx/JAOR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132794; c=relaxed/simple;
	bh=kO+VSao6Ch3m6waMToU2WPWtR3u4LtsSf7Y7Oiz0nd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+idNSDI4wRx+A+J4HGG/5mZ+z+BPcyJHyDQt/hpgAXIDkzxEMTmjmUUoFCLWpWOyCAqOpc68zWpK2K1OniovvHYAGNuGmLy8XB+Wl6xiaVza7V+sboF5yHwcwKGtjpifUqEJM8JeI0nJyG/U4eG1egzW8VZ7SMhzJNhRpF1jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoEQo8pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5153C32782;
	Thu,  8 Aug 2024 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132794;
	bh=kO+VSao6Ch3m6waMToU2WPWtR3u4LtsSf7Y7Oiz0nd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoEQo8pMalmr0x1TNztKvpfQXAFoOZYQgcIejBIxPOZw8RACGktDwZjhLESzjUaWG
	 kCaBcUHfdm9W9vR+jlmOB7SiWG3fu9Y18y/uGrZyTPL8kmQ1SL2JQDs6kYz4CL7bdr
	 v050O1/vPo2nz/y6a/JWEJBZiOgIKy5rgq6BMXMrVLMk0BLJbW1//xvxhY10Q2/xnE
	 k2Vea7h1jQFSXq6OQEuA6o+NeYvUj+Ji9zJYSALl7dqy17evXN4IR4j2/OFgWzfGuN
	 6gkbLYWqQ9DbMeIMi7c+DwN7c/ur/mVMOKvedCelVKjYZK5duLNj0QlPsZzcY+muW6
	 ONOlDza3mAOZA==
Date: Thu, 8 Aug 2024 08:59:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net v2] ethtool: Fix context creation with no parameters
Message-ID: <20240808085951.15a522f2@kernel.org>
In-Reply-To: <20240807173352.3501746-1-gal@nvidia.com>
References: <20240807173352.3501746-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I'll make some minor modifications when applying..

On Wed, 7 Aug 2024 20:33:52 +0300 Gal Pressman wrote:
>  	if ((rxfh.indir_size &&
>  	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
>  	     rxfh.indir_size != dev_indir_size) ||
> -	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
> -	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
> +	    (rxfh.key_size && (rxfh.key_size != dev_key_size)))

We should take this opportunity to remove the pointless brackets
around key size comparison. Same clause for indir is not bracketed.

> +		return -EINVAL;
> +
> +	/* Must request at least one change: indir size, hash key, function
> +	 * or input transformation.
> +	 * There's no need for any of it in case of context creation.
> +	 */
> +	if (!create && (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
>  	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&

And here if (!create should probably be on a line of its own.
Otherwise continuation lines don't align with the opening bracket.

