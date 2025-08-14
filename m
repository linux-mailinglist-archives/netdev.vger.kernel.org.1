Return-Path: <netdev+bounces-213531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D900B2585C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078471C05816
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF03597A;
	Thu, 14 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRHpviKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F72C190
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131397; cv=none; b=Z7wfrfKZndk/0QaOS/3ToHkNVtZOQgeCykdtwkFNY/iFA+vwq2E0n9zlReU7o778R5Fp11F8szU+/0zT8oNk1y8cbLRO4mrvktqPu0Ao9ImHQfjsmfREiW0dDsg+r2jG3Hxfs7PVkDBpiXxQp8N415LN3qBkN5U2z4glhD4Tl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131397; c=relaxed/simple;
	bh=aIXN5HwuaK6Mn0rvPZ4Hl8Mqv0Zv7qP6wJ9pltsLByQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNRcAGODAqAg5k8iQ6Qt15shkjWkCcS4tQFeE5hmanOuenvW7TKqSkVrvymOhKl9yl0OfN/E3/qPV99Neom3YLrlL2FvOE6nCHSA12jVtn/rlCldC8hfOQ+1sUD7ivNmGYmJbRkXH7etqy4RcM8tTqsnapikDT5FHowGeH4/d/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRHpviKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839FC4CEED;
	Thu, 14 Aug 2025 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131397;
	bh=aIXN5HwuaK6Mn0rvPZ4Hl8Mqv0Zv7qP6wJ9pltsLByQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HRHpviKXVhH9Zru9JRePOJzSNbZWzebF5367rF1NLGvKC9CnLtueV+WvQBhTlerhD
	 9I8SZ8jCeizbe5f40y/qf1N5jJM/blZgb1E3PPqh8dmFcI390RTlWzD2E2UaCVU/YK
	 EwbkX9DtaR6Ydibd0yNBQBkZejgF03j3oLdS9soxCMuf0szit2WUJR1heLg4yMiO/1
	 qyHfMjfxgQ/qTIMIep8L3gAAmuRtMhsxOeiYPl6+k9LnPTz92/BlavjCwsLsob123Z
	 yVjj5BP1NPki2qIBQaHfnzo6lwX8h1N6nVpNkGbNvi/E7l8l9PoAqTsHY6vgPOBgEh
	 mPBc8v2F0h6oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DB39D0C37;
	Thu, 14 Aug 2025 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: Add a test for FDB
 activity
 notification control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513140878.3830230.1946098293331346158.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:30:08 +0000
References: <20250812071810.312346-1-idosch@nvidia.com>
In-Reply-To: <20250812071810.312346-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 10:18:10 +0300 you wrote:
> Test various aspects of FDB activity notification control:
> 
> * Transitioning of an FDB entry from inactive to active state.
> 
> * Transitioning of an FDB entry from active to inactive state.
> 
> * Avoiding the resetting of an FDB entry's last activity time (i.e.,
>   "updated" time) using the "norefresh" keyword.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: Add a test for FDB activity notification control
    https://git.kernel.org/netdev/net-next/c/5e88777a3824

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



