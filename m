Return-Path: <netdev+bounces-167576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A26A3AF58
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33B77A5F1A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD69199FC5;
	Wed, 19 Feb 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c//Farcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C59199237;
	Wed, 19 Feb 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931013; cv=none; b=LxkpVyS6MZQ9J5jH7cPWt+S24WyAO4jxnJWMg4QiwlqXmlBGzQ7HJI6lQjQvm+85PQxqPBNG8wsH4O1l/1OjYsCLsGlkf1GxDAAV6hhduD6K6IsBUNq9pLh9BWWHTOi/0KZ6W1g0W/uhhqlHjvgXJHl/qARRmKDm4wimign5AYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931013; c=relaxed/simple;
	bh=0ptKozIKkFeXC7oC6IU8uLAScpwBrp+shlr1gmMgaQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MIKhP92hyRK5pRRAssBRKlwOk3KsAZMk7vQikqMRpMSRq53mdVTDHljYnQjEkaOMYmGD2ABXcxpTbfkUC2kAcOluVxOaLrmXAjZ5fTdqCOLrNsKP24jWBcy1bWYwqh/YD5LRSxUUXDgsvs3YIisCdnGgdUnnzZy2rW+7MqRWHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c//Farcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1180C4CEEA;
	Wed, 19 Feb 2025 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931012;
	bh=0ptKozIKkFeXC7oC6IU8uLAScpwBrp+shlr1gmMgaQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c//FarcbmHvnslY7S+0sp6kqmjSBp9q2UXaqkgFDhT2Q3oLLHO+XUt1SymT1E/B52
	 HBwA5BO+HgwqQsTN2l+lERUkXrSBXj5ueaZkZu4/9XQmGdsA8rPWtkfxiRQaD3Zwj/
	 gWlxQ9EPaf91+0/oODnzGBM/wCnZBUaSX6Xk4KVxrUgM4Bb2GuPKw7SJsuY9iJpgJA
	 vIfg95XtojSpmX8k4H6Q+SiDGdfiZKds8dcpDh8VMoxUzSON+CAEoy8gmhGYSgNMW9
	 mYQBqOfn7/QYGwAjLtg2BeXeWYp/LApdF8sX4j5aC2wrAhIBQRilqzYD/gMhK96N+K
	 g/v5UAGt1eRLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE7380AAE9;
	Wed, 19 Feb 2025 02:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:42 +0000
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
In-Reply-To: <20250214212703.2618652-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 16:27:01 -0500 you wrote:
> Implement the modern interfaces for statistics reporting.
> 
> 
> Sean Anderson (2):
>   net: cadence: macb: Convert to get_stats64
>   net: cadence: macb: Report standard stats
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: cadence: macb: Convert to get_stats64
    https://git.kernel.org/netdev/net-next/c/75696dd0fd72
  - [net-next,2/2] net: cadence: macb: Report standard stats
    https://git.kernel.org/netdev/net-next/c/f6af690a295a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



