Return-Path: <netdev+bounces-199298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F92CADFB22
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D5817FD39
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6E17A31B;
	Thu, 19 Jun 2025 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxzs4Vni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FD158874
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299587; cv=none; b=FIQ6TYMfzwHYLKBubI2AGwCSIDHpO+pu5SnU89ppMHReZ5ErB3vgDHmaASKURm413QVwxZZ+tyTD9hkSj0z1NQ5GDbaImG8plxOoxQ8c3VY5SBrWyV6Yx3zaP2pvWA+69/LQiZawGMs8Ibbl45meGIqYoLSU0Ky0gcr+SbBX7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299587; c=relaxed/simple;
	bh=k9Zt1lKrEKgqHPvcvoh4T8RzjzThcCpI6CuBgLVExTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lapr2TGur8mJIj8c2z+wQfK/ywx7tV2ixvCPadmeZjF7vu4ZO/8gi0ri4/zpMFw3ltEXQYfDuLMSx79BGXUx6pyBaxzDQ9a+f5UpWZMAeQ1vs8V8k+Q+Knoc6lBDWOgaDlVCd0WzXQWJMw7HxqztsyQjo4jpjdUfjU3sBwk9orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxzs4Vni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428DC4CEE7;
	Thu, 19 Jun 2025 02:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750299586;
	bh=k9Zt1lKrEKgqHPvcvoh4T8RzjzThcCpI6CuBgLVExTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxzs4VnibfRAZCCtdHE2LZoZzRqZZqLVoaVv/vNjQYBZ/Z5ff0jmTnBK2te8vTMii
	 z/hG7+f59Q70Ay96GQLRnzwe2GFXR+xx3FOnbrEhCavxGKFgyFc21RKfw713wd+o4M
	 Yb0lo0qMGwVcKE9lA3Q3mbFNlyf2HyuS2vzwUxhQBtPLJlaxbTrEkVe8KrgRrrarcS
	 21jEqA4NEPkI1QjJ3bQ9r2QDDlwSP9gssMXC9z4nW9e3qr6GagTurWbEhpGxUFdxd/
	 hMHyzlEOyCL1VdmOl7sG3bOokTZ50lfOu7KPhXTQ+hDRYdJdKOAd4dd1UGUs7rBKwM
	 XT9u6Wm0B/DMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE993806649;
	Thu, 19 Jun 2025 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net: fix passive TFO socket having invalid
 NAPI ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029961475.324281.15474653143296280415.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 02:20:14 +0000
References: <20250617212102.175711-1-dw@davidwei.uk>
In-Reply-To: <20250617212102.175711-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuni1840@gmail.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 14:20:58 -0700 you wrote:
> Found a bug where an accepted passive TFO socket returns an invalid NAPI
> ID (i.e. 0) from SO_INCOMING_NAPI_ID. Add a selftest for this using
> netdevsim and fix the bug.
> 
> Patch 1 is a drive-by fix for the lib.sh include in an existing
> drivers/net/netdevsim/peer.sh selftest.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] selftests: netdevsim: improve lib.sh include in peer.sh
    https://git.kernel.org/netdev/net/c/316827659121
  - [net,v2,2/4] selftests: net: add passive TFO test binary
    https://git.kernel.org/netdev/net/c/c65b5bb2329e
  - [net,v2,3/4] selftests: net: add test for passive TFO socket NAPI ID
    https://git.kernel.org/netdev/net/c/137e7b5cceda
  - [net,v2,4/4] tcp: fix passive TFO socket having invalid NAPI ID
    https://git.kernel.org/netdev/net/c/dbe0ca8da1f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



