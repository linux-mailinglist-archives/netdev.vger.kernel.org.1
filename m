Return-Path: <netdev+bounces-24706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E73771506
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938CD2812B6
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431DF5242;
	Sun,  6 Aug 2023 12:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF653220
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE417C43397;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691325021;
	bh=a9yLEOcNaabJ5cs/habcz7/kUUUdaOeenDRKh32WVpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4FvNdM1GcrHhfUJFSKQVKf90pCPQ1H08xmF4eC/D1u9PCUZzC2vcTZnCsXxwBtir
	 Z+tjvlUHI+7rAmGaZPH3CEJBy2KVelpnW0DT8zdriSaDQyeYDRT9FWGICLo1DaeLpb
	 XVVeUR/Hz713yeWfPuH9pUqQzTAYUU4qF2rpx8S7iwtyuyfyjSj+KxpvH5qB9i9Ek7
	 /NwajLBzmJhY7518OrzPeGVw+fu/nidOyp8wl/Ff8+DycqyZ/SCGlMtX7XZqkqbpoY
	 0fhz19YjkxM5+NJ8UKe4bv/70VlonPtuOkUJgudCe7qz66TsLTjvS/sD4LSu6Ceiz5
	 7h9cXW5JjeG9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93C1CC73FE2;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: omit ndo_hwtstamp_get() call when possible in
 dev_set_hwtstamp_phylib()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169132502159.16904.16690341040047268621.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 12:30:21 +0000
References: <20230804134939.3109763-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230804134939.3109763-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 16:49:39 +0300 you wrote:
> Setting dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS is only legal
> for drivers which were converted to ndo_hwtstamp_get() and
> ndo_hwtstamp_set(), and it is only there that we call ndo_hwtstamp_set()
> for a request that otherwise goes to phylib (for stuff like packet traps,
> which need to be undone if phylib failed, hence the old_cfg logic).
> 
> The problem is that we end up calling ndo_hwtstamp_get() when we don't
> need to (even if the SIOCSHWTSTAMP wasn't intended for phylib, or if it
> was, but the driver didn't set IFF_SEE_ALL_HWTSTAMP_REQUESTS). For those
> unnecessary conditions, we share a code path with virtual drivers (vlan,
> macvlan, bonding) where ndo_hwtstamp_get() is implemented as
> generic_hwtstamp_get_lower(), and may be resolved through
> generic_hwtstamp_ioctl_lower() if the lower device is unconverted.
> 
> [...]

Here is the summary with links:
  - [net-next] net: omit ndo_hwtstamp_get() call when possible in dev_set_hwtstamp_phylib()
    https://git.kernel.org/netdev/net-next/c/c35e927cbe09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



