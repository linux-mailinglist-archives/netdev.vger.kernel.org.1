Return-Path: <netdev+bounces-50682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B147F6A12
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7597A28182D
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5C639;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4eFvgwi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C281391
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C84BC433C9;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700788825;
	bh=3YNY0FGhwNjgZ9y5kYvFwAoFLUnt1fRQkW73Q8rJClU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4eFvgwinzR4zM2mSTDkPbUdOzYjp/0A89HaFP6rfxsHPCr3Ie/Ky+sJodg+PxOwW
	 MgtKfLEsw/+rsUzqhSuEh1gRSoJk3YXERVyjqV5oMzqR4rl4+l5PmZY/tMngpAE/xs
	 1ppOYUMuR+PfAuNtJiGV9X8OGAFptl6M5tA/McRKZZHNerCesnkGBfTt9Adv6wKyfr
	 OSn2IZd21xLx/Bp6UyYh8jSICd2pg1pbkN92K7YZyBGxrVhpb0kUjfhD5Mil+o2MG2
	 1fJC4LUDk0xxWQkyKYdiCH5F8ei8BIZ+O13OpRl/PZbtOIKud4u0MEVg8qGvM4q/nT
	 osAGvFWqaglzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13193C595D0;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] net: phy: correctly check soft_reset ret ONLY if
 defined for PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170078882507.20317.14960769186656222790.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 01:20:25 +0000
References: <20231121135332.1455-1-ansuelsmth@gmail.com>
In-Reply-To: <20231121135332.1455-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 larysa.zaremba@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 14:53:32 +0100 you wrote:
> Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
> reset").
> 
> soft_reset call for phy_init_hw had multiple revision across the years
> and the implementation goes back to 2014. Originally was a simple call
> to write the generic PHY reset BIT, it was then moved to a dedicated
> function. It was then added the option for PHY driver to define their
> own special way to reset the PHY. Till this change, checking for ret was
> correct as it was always filled by either the generic reset or the
> custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> phy: Stop with excessive soft reset"), as the generic reset call to PHY
> was dropped but the ret check was never made entirely optional and
> dependent whether soft_reset was defined for the PHY driver or not.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: correctly check soft_reset ret ONLY if defined for PHY
    https://git.kernel.org/netdev/net-next/c/aadbd27f9674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



