Return-Path: <netdev+bounces-117361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120294DADD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD794B218DA
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AD513D2BE;
	Sat, 10 Aug 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuzdKR9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361113C9A1
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267238; cv=none; b=AQ3At8wRqPJa235/fnoihUoYVxqV/9L8sQhQYIWItmIDX4HaR+BIa7RkCLD6TUIb/QI7PMZx12Kmw8paTWKEgajOElC22PUiwoY+yQcxegMO81zyoBuE6u3FgL4QZYPzX+Isbdz8guifoFkHk5nkGR5h0nBCNTFiIJJBv9qBsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267238; c=relaxed/simple;
	bh=g8F/jwSiC5x3pdw8eN4+qm7w1ZzEM7A91at7rK1/d4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cr0u91fHhEpBxVuO4j4jzzmBZu09Fo92UIEjNzxlNTozfg3EA/LgEEjfWFBHFjez/1Tn2POdqfn++kTYVH/EaX8qFYBg1wwx9dDETEHSv4CXNPvP177ZDYaxR+XlkwltbdMe6lDaabZ/MkbO0SWAwPBLw4XyH5BTx2S4OmOD+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuzdKR9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4443CC32786;
	Sat, 10 Aug 2024 05:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267238;
	bh=g8F/jwSiC5x3pdw8eN4+qm7w1ZzEM7A91at7rK1/d4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GuzdKR9YSr4uac1ztWRiOXfaL2rnHAJ+h7OXh/P31IG1TJMVy6D13/m+UuSTlcCMZ
	 3e2oe523OeLIlIFFcJN++F0BVf0pC6F+bKe6Pm9m/SK5uCvLzQYPQB6AYl7FByoIKG
	 XO/luoSoSGacywG42rS6fb8o/WuUe3RAQjyy/y7eq6sCiwE6D5jxtSQSwsD7t7XA83
	 r+xOrfpQE2/p6fPzkEZ2Vr/2r8vjfCZvcY1u1ZK3pzrw5KkpxOoHLOdOHpbc6YYxdE
	 2ZtrDIAX3w+xl5ENBNF+6WWrw+vi8svGgrbR08po68jmdRoxzy9g9vushbySPuwWwh
	 t3kbCv0hYfO7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7B382333F;
	Sat, 10 Aug 2024 05:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ag71xx: use phylink_mii_ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326723699.4145426.17559628094126761112.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:20:36 +0000
References: <20240807215834.33980-1-rosenp@gmail.com>
In-Reply-To: <20240807215834.33980-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 14:58:27 -0700 you wrote:
> f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
> ndo_eth_ioctl and used the standard phy_do_ioctl which calls
> phy_mii_ioctl. However since then, this driver was ported to phylink
> where it makes more sense to call phylink_mii_ioctl.
> 
> Bring back custom function that calls phylink_mii_ioctl.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ag71xx: use phylink_mii_ioctl
    https://git.kernel.org/netdev/net-next/c/1862923bf6ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



