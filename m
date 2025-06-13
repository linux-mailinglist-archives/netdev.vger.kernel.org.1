Return-Path: <netdev+bounces-197290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D2AD8050
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBE7AF7FB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C61E7C19;
	Fri, 13 Jun 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS5/RzWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0B1E5B99;
	Fri, 13 Jun 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778213; cv=none; b=ub9b3+C3pOXH5F+TrkfqdXGtKknlG3Tz2FUXSLkDc9Nf9MAM6HOx8Erc7+t2lek2qQz7NYNAwdlP+UHPJ8kNTnLmVh8LRA/vIQRVyvD28QWXmWbwcaSwW0M/dBH4xZpo5ABOoR2vTYXVk4pA3mlVF+zJz+tf/BLInvdsMntWAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778213; c=relaxed/simple;
	bh=Hx+/lC7LYVz3SY8vMHRPDhOTUtw75OttHQFIbpRL8XU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=emMlFwgobNDtqx3aS4n8PI8EAYJTjvF9oDGqlfRnOsOiAlKJdR7DieVF2MTam7bKWXZgSQokr0GXAWm8cu2B6+sDP/tYeFLLX9yZk1cqFoQ/H4KDV4ItLWJT4qW+7wgT2E33+44OC/0STq4JoUgucbqg1p/HilruYf0oKHefthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS5/RzWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D6C4CEEA;
	Fri, 13 Jun 2025 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778212;
	bh=Hx+/lC7LYVz3SY8vMHRPDhOTUtw75OttHQFIbpRL8XU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nS5/RzWd9y3iOyAPmI5gxiPhJO/8yKreR3q82Uf5lhvyOEGy1O6Lz5vtMREJmT48M
	 E9W2gkZin06hR7K7+8tDpDLG/zAgH5e+34Fen68PXt1VELhRC2d79aQExOQDoPvkLE
	 49+tDSe/mV3OZIzejecE9OQArnuRwdTFJbRFvCKGpmbY0VqDnCMQB6cpd4wFRaWgSl
	 xny23I70p57wfwvxAh7xsoRx0OBlAppPhT8jdANqHk8J5u9rKsZtVVU/kQ4FnvSsWb
	 S/PZsMt5nofJM26f5vRveg3lpxSvMHTElW0AzRbeL+SpaQZ2WlbqPndzHcVlZpKJuS
	 av2XTGi3gPiow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA939EFFCF;
	Fri, 13 Jun 2025 01:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: bcmasp: add support for GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977824248.179245.828577192312003957.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:42 +0000
References: <20250611212730.252342-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250611212730.252342-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 14:27:28 -0700 you wrote:
> These two patches add support for GRO software interrupt coalescing,
> kudos to Zak for doing this on bcmgenet first.
> 
> before:
> 
> 00:03:31     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
> %guest   %idle
> 00:03:32     all    0.00    0.00    1.51    0.00    0.50    7.29    0.00 0.00   90.70
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: bcmasp: Utilize napi_complete_done() return value
    https://git.kernel.org/netdev/net-next/c/391859cb17f5
  - [net-next,v2,2/2] net: bcmasp: enable GRO software interrupt coalescing by default
    https://git.kernel.org/netdev/net-next/c/b0f5b1682957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



