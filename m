Return-Path: <netdev+bounces-147698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C709DB439
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515D4B2304A
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E0153BFC;
	Thu, 28 Nov 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybg28bvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BA14BF92
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783817; cv=none; b=MJkYGD1zA8UcavwZzXf151BqwmmFpHCgzVWoYv5OREzbc1U7FSL1WCwuwkXAnZRMTxRhK4eCoJsqLQ0ToXjXl64+jR76xjkEzUfPE5Nt83BeJgo+GZkKZVXedQsdzFfJeAHt1s43g7xeCGf8dFq1P7bfIJTLhkqo7cnHm9cg6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783817; c=relaxed/simple;
	bh=pOcdRj/do7BteHA2VoGFWL/Qsh1SUnRQmFi+Mdigqic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJC7+5BusDxm+YC9vlq9Fw9G3VhsOIzmwEftxIAD4xGgQ/3+abv6B0kJPzMYEC89OFp814dr5zpIs59cTNFTpJjQgoV5ZHLHHBARe/jIl8Za5xZnfYPTs501q9G5Ymq6HEcs2YyQ7bORIk4AkgNxFNeVp7Gi4Z3YIa71M1W0AzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybg28bvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5ADC4CECE;
	Thu, 28 Nov 2024 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732783817;
	bh=pOcdRj/do7BteHA2VoGFWL/Qsh1SUnRQmFi+Mdigqic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ybg28bvMNSU3V/JaZf7m/0mAsIt+TSMWkZgKI08D3hUEHfe4cb7PG4B7z9/acJiOQ
	 D/hiUjABFyjhzZXmq9b6l58T+t0AZzkg3mDMJhPAJ53H1SSLq3IZ0XOORAsLFCzM5o
	 H6p2A5dzqrlQlhPVtJZQ8ACLXWuPOOP9LE5Lw51nQEvs8ArLuqWhN35CjFytCTNL6Q
	 nBerXZmMlI6nXGSuKEhLhVqR6rooy5azN0lYnVcWbjM0CFPG8PLtQKkYU0DqAqK6ed
	 LwreMfr/GyaGFmuXS/tgk/zZgCM44VMPbVcltgPKX/AGzK4QYTGKs9LAn5IcuYu5NM
	 0/Y46OoEdU0hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE842380A944;
	Thu, 28 Nov 2024 08:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278383051.1665084.15526754846308175245.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 08:50:30 +0000
References: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, florian.fainelli@broadcom.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 23 Nov 2024 14:50:12 +0000 you wrote:
> When phy_ethtool_set_eee_noneg() detects a change in the LPI
> parameters, it attempts to update phylib state and trigger the link
> to cycle so the MAC sees the updated parameters.
> 
> However, in doing so, it sets phydev->enable_tx_lpi depending on
> whether the EEE configuration allows the MAC to generate LPI without
> taking into account the result of negotiation.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: fix phy_ethtool_set_eee() incorrectly enabling LPI
    https://git.kernel.org/netdev/net/c/e2668c34b7e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



