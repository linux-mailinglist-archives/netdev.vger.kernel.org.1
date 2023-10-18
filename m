Return-Path: <netdev+bounces-42092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DF7CD1A6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EA72814CB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3D4EC3;
	Wed, 18 Oct 2023 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcKEc7iy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A59A5B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2A89C433CA;
	Wed, 18 Oct 2023 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697591422;
	bh=yE9XF+HEz3/R3bd7m63nQl8iS27OgyW2/Dy/kM2CN1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CcKEc7iyC4XmmRBLScAi+JpMZNjrOIJebgGO2hPqBbCC0vT65RpK9zXvy+wGbrtSq
	 /KpvAHmlePLr2MK/9dVRgiLdfFi/Le4vdp9iSbtlFSTImy3yO7WdxsoNnrKMPtOUqx
	 fu2vZKouSe/uPMoYFpQ3TJxUSZ8VMA1NN/Ic3DNHVT5bCGZdMHn3nmswmrmcX6CCgc
	 dg2zvV5NU6Z2zuIP7mEPRKqf7coxwuLArx/Py8gsFgfU+TtbKBI1BMX3ucBkeEQMaU
	 ZCEhziOq5ZLfAX4cAFvP5drm5CqyG0dA8BWiboiWpJbyCKp+840oBamhXormNNpUHl
	 vwsHIIkLdGTDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAD61C0C40E;
	Wed, 18 Oct 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: fix converting flags to names after
 recent cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759142269.24973.15415935995163143139.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:10:22 +0000
References: <20231016213937.1820386-1-kuba@kernel.org>
In-Reply-To: <20231016213937.1820386-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, sdf@google.com,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 14:39:37 -0700 you wrote:
> I recently cleaned up specs to not specify enum-as-flags
> when target enum is already defined as flags.
> YNL Python library did not convert flags, unfortunately,
> so this caused breakage for Stan and Willem.
> 
> Note that the nlspec.py abstraction already hides the differences
> between flags and enums (value vs user_value), so the changes
> are pretty trivial.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: fix converting flags to names after recent cleanup
    https://git.kernel.org/netdev/net-next/c/9fea94d3a8ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



