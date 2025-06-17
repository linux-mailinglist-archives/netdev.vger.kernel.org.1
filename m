Return-Path: <netdev+bounces-198378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEFADBE9F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402F57A81CA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA9A19DF4F;
	Tue, 17 Jun 2025 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ3X90Hi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AE33993
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124423; cv=none; b=QsoaP34T0YllyGJ1a+ChmK1tZKV1+a9ZFL+XD+uTEG4cfuBWlW/yFQkleB/jcGzJiUqgSD+ZoS+b4OWqctX8m3i50tnW9oo5f2mmhT3ddEN6wLLHDE861O9EU4dyAY6WHkIy+GNQhTyd7xaktq25fN1ZNe0S1oimvsE6eWJnxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124423; c=relaxed/simple;
	bh=Q06Vfek8pVIkka2gkFLzgHEBRTwKppRw5GXiAvtQNLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wj+wOT52t6cMkGVDbyeLmfwACYgy+wHSqjWxsM8TdJoYo1djjm1HI0Z/8M26gFrqRu5h9vMKmBvrl6L2GWA7ZzmnWJbL854eBGr1KuglWBzEexYJwJASCj9PWWcg+Zeo4J3Ee0/l9LsBVsmWnYbyrajZw5eHJf9Btcx0QJOzMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ3X90Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B8CC4CEEA;
	Tue, 17 Jun 2025 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124423;
	bh=Q06Vfek8pVIkka2gkFLzgHEBRTwKppRw5GXiAvtQNLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IZ3X90HiEnmAmW313D7bRYdDhKxiL9cIKNzEbd4glSMdRfP9w9ydQQEqNpv+8AGqD
	 PqNA5KtgwWE/Sm74Csf2BeExpSmHdv5bjrZqMW7VgZEdd/mLhWl7V+NoDgcnPccOwT
	 BnLF5tTcbI9xRsl9ojBxocRK2TOdhEhETIbUOUbgw1uwn34En369N+qUgf2ujB2sGh
	 3fIdgAqZ90tUIQFNZsHPrLv3i1n7kEWdVivrs98Sbwkomft5XSLUHJBOvRAFB8Goes
	 icgirw6+gbrINMSFxf7/RJwYDVcqXEzUodcJt3JEpBca+1/Lt32IIqnxeaqz2MfDqS
	 JtEzVvi0n7m8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A9238111D8;
	Tue, 17 Jun 2025 01:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175012445200.2579607.10501400435352945895.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 01:40:52 +0000
References: <20250614180907.4167714-1-kuba@kernel.org>
In-Reply-To: <20250614180907.4167714-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 michal.swiatkowski@linux.intel.com, joe@dama.to

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 11:09:00 -0700 you wrote:
> Migrate Intel drivers to the recently added dedicated .get_rxfh_fields
> and .set_rxfh_fields ethtool callbacks.
> 
> Note that I'm deleting all the boilerplate kdoc from the affected
> functions in the more recent drivers. If the maintainers feel strongly
> I can respin and add it back, but it really feels useless and undue
> burden for refactoring. No other vendor does this.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] eth: igb: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/f148250e357b
  - [net-next,v2,2/7] eth: igc: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/575d1b28d204
  - [net-next,v2,3/7] eth: ixgbe: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/ecb86e1ff4a3
  - [net-next,v2,4/7] eth: fm10k: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/5bd68c191a82
  - [net-next,v2,5/7] eth: i40e: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/5a28983710b7
  - [net-next,v2,6/7] eth: ice: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/1899fce53a78
  - [net-next,v2,7/7] eth: iavf: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/2c5f2ad1d919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



