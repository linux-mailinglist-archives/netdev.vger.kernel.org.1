Return-Path: <netdev+bounces-54713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21659807F2A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C191F21134
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C542D46A7;
	Thu,  7 Dec 2023 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIiOK5h6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B120F3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E36C433C9;
	Thu,  7 Dec 2023 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701919824;
	bh=MQIxBAe0m9iYoCyhtmJlq3AYZ3y0n+vAEC35xQaWTWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sIiOK5h6h2IfC45dTBbk/4lDw/LQJ/8ridJ7U6TWAhvYQ8MxbAITBhj6wuCX8kE/6
	 o0aFouxM/7JcbMARxpqT1t/9brF2ktNXwn/D0Ld+ySmjPKUddVbw7J6UH9FJJ/aKMS
	 MLXp7r3Ma1xYGzdC/wzbNpegZTlFziIo7uz78j15JkvCK4T5bVDob1gBhgE8Zs596I
	 +I68FBUKnfxITIPsSNBITd24uxNq+0L1lxsPe9PurG54Ij7Jx7dRPZVSbqEAzpjVin
	 yWqbLOCvFReoRjPSeYZklMrXMd3p80l6uLwHQzbq6hberCGAvpVXlB/EpzizqkgATK
	 PWOMu92DqLRhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 005D3C395DC;
	Thu,  7 Dec 2023 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for 6393X
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170191982399.16034.3800722489934391752.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 03:30:23 +0000
References: <20231205221359.3926018-1-tobias@waldekranz.com>
In-Reply-To: <20231205221359.3926018-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, linux@armlinux.org.uk,
 michal.smulski@ooma.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Dec 2023 23:13:59 +0100 you wrote:
> In 4a56212774ac, USXGMII support was added for 6393X, but this was
> lost in the PCS conversion (the blamed commit), most likely because
> these efforts where more or less done in parallel.
> 
> Restore this feature by porting Michal's patch to fit the new
> implementation.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: Restore USXGMII support for 6393X
    https://git.kernel.org/netdev/net/c/0c7ed1f9197a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



