Return-Path: <netdev+bounces-217575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B44B3915B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB7464FFE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38771FF603;
	Thu, 28 Aug 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvlrhiHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF681CD215
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346428; cv=none; b=KeALSFZKgcGZ6ai424KvwXh134Q0LWDN85X6LHCmG2iopA4bNiRNxcupqWbIzHPNFl+wWD+kOz3gpKo64jVJMk/QDRcTWG+nHnujSeskIYpTYqoWBpBCqp+J9rWshV4Ld+ANeKnfvn0FCBXfgUAEM+otI9+gnUegXATZKqYLp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346428; c=relaxed/simple;
	bh=R4ElHzzIQAcVHSTK92vjmTdqAsOi5LZdoMCEciWgWQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PK6L00ogDlgGhBRRLxjhWHQym4M0qRAI1k78VJMptqFYu0bSQ6R1yqm8/YjajimpIihLyi8EL3zPgzHv/4EMR5QV6T4L4Ak6UJCSmcfGP0sMWL04DbV1SZvJwW3d2vXm0PBngLj4qFmccTvjWQZ/HqkgdWFIJ+syl3Muk7mNLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvlrhiHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E43C4CEF0;
	Thu, 28 Aug 2025 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756346428;
	bh=R4ElHzzIQAcVHSTK92vjmTdqAsOi5LZdoMCEciWgWQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvlrhiHRWbi3usfKahofSdxdXAoxhztbUOkvr4UnvfjUJgQMqkWoUQH/pRJ0nw3EM
	 AGQDbXbhwUUtYx/TT4b/qDJjOnIgpy11a92J8G7H2hdMo38P40NJhe4z4xP5SOYKPe
	 y6dUCYBqJlGzG9KwEnQvEbai/MDWQWjZtOdU/4eYcW589Nh02CKQ1OaatyfqzqAyGO
	 wP6N7zcxc1LNDBzmvKXKNAMyz6V3fKl9qmefkMI6odPh4x0Gj8Ci9Ev9NpFoC6s43X
	 GkpXR7iMW5kJ1AmBfeEWAmXXBXSAYvfp9A3YFvXxcgOfn3ZIwagskDi2JmSU3x0n1u
	 b4GHlFS6Wk4Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB31383BF76;
	Thu, 28 Aug 2025 02:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] eth: fbnic: Extend hw stats support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634643523.908900.2000854189315078878.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 02:00:35 +0000
References: <20250825200206.2357713-1-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 mohsin.bashr@gmail.com, vadim.fedorenko@linux.dev, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 13:02:00 -0700 you wrote:
> Mohsin says:
> 
> Extend hardware stats support for fbnic by adding the ability to reset
> hardware stats when the device experience a reset due to a PCI error and
> include MAC stats in the hardware stats reset. Additionally, expand
> hardware stats coverage to include FEC, PHY, and Pause stats.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] eth: fbnic: Move hw_stats_lock out of fbnic_dev
    https://git.kernel.org/netdev/net-next/c/2ee5c8c0c28e
  - [net-next,v2,2/6] eth: fbnic: Reset hw stats upon PCI error
    https://git.kernel.org/netdev/net-next/c/b1161b1863c5
  - [net-next,v2,3/6] eth: fbnic: Reset MAC stats
    https://git.kernel.org/netdev/net-next/c/bcf54e5d7cd0
  - [net-next,v2,4/6] eth: fbnic: Fetch PHY stats from device
    https://git.kernel.org/netdev/net-next/c/df4c5d9a290e
  - [net-next,v2,5/6] eth: fbnic: Read PHY stats via the ethtool API
    https://git.kernel.org/netdev/net-next/c/33c493791bc0
  - [net-next,v2,6/6] eth: fbnic: Add pause stats support
    https://git.kernel.org/netdev/net-next/c/e9faf4db5f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



