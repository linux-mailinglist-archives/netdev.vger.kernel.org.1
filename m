Return-Path: <netdev+bounces-249697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F090D1C348
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E213017662
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518D31ED67;
	Wed, 14 Jan 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6+mpc3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9830146C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360014; cv=none; b=HPRMycZC+uwzTj6R8nWUlk0cgOc8KyREymuOv3zyEFNyqmSjp6UIvg3zhmmIZsp7Zt6f/sToOk/hqpy7ATAhYLYbUu2SP/11iR24CUWqqj8fdg6Y+LgmfDCFEeHYfesjBSnsHFd1cm3goeDw4UtS0ln1U1O4+nq7CBa+QDqnWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360014; c=relaxed/simple;
	bh=942pRsZcldnp2LqPBajR2bIRtKuydLaZSAfKcluTebk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQFiJjG2FZG7RluDVYz8fDc5KO9wlJ4uRH1uxF0JOE+MCxspKFjZhvFXqq+odg0TpARB634fd8yicbpDS1VPLIIM+6r8XxgrwhAxZWgubx4yaEHFkhsdpaJP668GQLUeUPNKMITxKDAaW5igVLh63GbHTT7N9LGv3j0GW0Afew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6+mpc3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F94EC116C6;
	Wed, 14 Jan 2026 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768360013;
	bh=942pRsZcldnp2LqPBajR2bIRtKuydLaZSAfKcluTebk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G6+mpc3lzfkJxr/Cx9Pd/FMtcCZ9DOnxQQn/98EfiV8/HMChJHfhO9XP544rmHvG6
	 wqvBho8tOrYrYiJO5EUTPevnVIfCSFydEa0WbcQxHLboYkoWg6r3U7O9fGRTCdCXl4
	 YNWE9d1GHjYkCFpJWSgrKw2y7RXK17nieHEvb5IHM3dlUZY2heTeSE8Y3i0oN6UPls
	 dUhxKbeC3rKcgpxSjksSKn9k5r2GUeyX2bgk3JKOPc1eC7IIkgJ7dgTvymvYPGNVR2
	 G3o2IjtAWG5OLJBih9hMDOWgKSOU6nUhvJKKrlCzZt0IQQBU0L1Wpiv+S09JwTdmAL
	 dVgs4T5BhK5wQ==
Date: Tue, 13 Jan 2026 19:06:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2] ethtool: Clarify len/n_stats fields in/out
 semantics
Message-ID: <20260113190652.121a12a6@kernel.org>
In-Reply-To: <20260112115708.244752-1-gal@nvidia.com>
References: <20260112115708.244752-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 13:57:08 +0200 Gal Pressman wrote:
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1101,6 +1101,13 @@ enum ethtool_module_fw_flash_status {
>   * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
>   * the string set.  They must allocate a buffer of the appropriate
>   * size immediately following this structure.
> + *
> + * Setting @len on input is optional (though preferred), but must be zeroed
> + * otherwise.
> + * When set, @len will return the requested count if it matches the actual
> + * count; otherwise, it will be zero.
> + * This prevents issues when the number of strings is different than the
> + * userspace allocation.

Thanks the new text looks good, but we should also remove the 
"On return, the " from the field kdoc?

