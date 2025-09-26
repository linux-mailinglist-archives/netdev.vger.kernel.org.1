Return-Path: <netdev+bounces-226813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA482BA5551
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252203ABF54
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676A29C323;
	Fri, 26 Sep 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J73ODCcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D058296BB3;
	Fri, 26 Sep 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925818; cv=none; b=ktyAUv8lGaGRk69LDvFUw9Xh8yt+QiL0aptaW782nI+4c1XO6TxtqDPGmU5sXSLfIjbL8twZ/3PKAFVahPETPLDZOJtz09OvjtSya0mFLG6HQk3bUltfSrz9pQ5+ABt5XcCQgKyTvwn9o2Gedxj9FWJKLo2wwGyRZRSthvN5718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925818; c=relaxed/simple;
	bh=+M2+1GjsbkGh9cs1g8+9X/sx4uePFBEDPoRDFYkteLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F5D0g4qtEFZlTD/ijKAGoT1Nd6Hy8dmi78JD5m0SxdjRCt05ISomX9EGCwEsAs8iyaJA4tUFTBA3Tfe6xAd/1uUnqrFUBMGHNrt5pb+mwOQIei3V/sRt7p1LpUqzlCA3FKrnqCbzEg7Vz+4MTVtgM31r6THteZrOXYy5QPVarHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J73ODCcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C8CC4CEF4;
	Fri, 26 Sep 2025 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925817;
	bh=+M2+1GjsbkGh9cs1g8+9X/sx4uePFBEDPoRDFYkteLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J73ODCcue9QmmeD8PpQY87Od3HVKda1m1vGMHq2Ka6sdCOtyqCWRUFaQRaFrAAoIi
	 Q/CDMVgvJn0FZqKiQz30xjnH6aBHkiWsn6e+bs4fYvgbO7vzLKZLM6wUTmpRnxots5
	 kRx4BV4e3jH92kUyPeR6tLSyJrQR0isR3uaqRLy+TEdcSGU69fo/Cy0qWWRB6kAYhZ
	 VtsA/tJwDnl0660hJ1dWLBVEHo6+DwP29LSfkU0K7aI8FAnYgG/SsgE1yFy8ygVQcE
	 X7LFaiPSRJ4gLX8xeqcXXeHCEL482oHOoEP74uks0wB0C/GaVAxO9cPYtPVQVP3vNw
	 YnYTvnVpTDsWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340B439D0C3F;
	Fri, 26 Sep 2025 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] dns_resolver docs formatting cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892581299.80352.17629887052028873345.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:30:12 +0000
References: <20250924020626.17073-1-bagasdotme@gmail.com>
In-Reply-To: <20250924020626.17073-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 mchehab+huawei@kernel.org, kees@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 09:06:22 +0700 you wrote:
> Hi,
> 
> Here are reST cleanups for DNS Resolver Module documentation. The shortlog
> below should be self-explanatory.
> 
> Enjoy!
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: dns_resolver: Use reST bullet list for features list
    https://git.kernel.org/netdev/net-next/c/84a27b5a4ced
  - [net-next,v2,2/3] net: dns_resolver: Move dns_query() explanation out of code block
    https://git.kernel.org/netdev/net-next/c/1b1fe672337b
  - [net-next,v2,3/3] net: dns_resolver: Fix request-key cross-reference
    https://git.kernel.org/netdev/net-next/c/ffa8f0791955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



