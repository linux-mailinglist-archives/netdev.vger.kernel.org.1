Return-Path: <netdev+bounces-42725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D57CFF9B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961731C20E4D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C432C75;
	Thu, 19 Oct 2023 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsnWKQdh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66A321B5
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 812F8C433C7;
	Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697733026;
	bh=alzRBJBaWdAUIW2ABZ3W5+qDNybK9OSXuWMCqmQDjno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rsnWKQdh1speLpg+8MHXsy7XsxX7M6ydZGHxAQk19/1hfzcU//sAfXck21GHYSgx3
	 q4jpKLTVgDOOJXXdfwhBM+u8IEcao7JIMFG1p0+tXB9tUMrFzAqH7LCzmKT6kcEXiJ
	 r3j6KzsFOad34HB0lErOrXZP4NNbYAiplql+4NbShGq8znc0n6VO8GFXysuDZaxMSx
	 x+qqkseta3fDS6Rb8BhbpCkjxpysdPgwSxKWkvFuEbsZ4bEmtcEZnietEkW6xvPdfK
	 ZAP+RMOQBuY5LaWt5FQIX+T7j7AwM/8YZW4zUh8R4uRegfXjgy3EKQQD5dZOs99PLM
	 jweuilgZ+yv2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6609CC04DD9;
	Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "ethtool: Fix mod state of verbose no_mask
 bitset"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169773302641.11126.3411409282171593715.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 16:30:26 +0000
References: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
In-Reply-To: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 mkubecek@suse.cz, stable@vger.kernel.org, linux@rempel-privat.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 15:16:41 +0200 you wrote:
> This reverts commit 108a36d07c01edbc5942d27c92494d1c6e4d45a0.
> 
> It was reported that this fix breaks the possibility to remove existing WoL
> flags. For example:
> ~$ ethtool lan2
> ...
>         Supports Wake-on: pg
>         Wake-on: d
> ...
> ~$ ethtool -s lan2 wol gp
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> ~$ ethtool -s lan2 wol d
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> 
> [...]

Here is the summary with links:
  - [net] Revert "ethtool: Fix mod state of verbose no_mask bitset"
    https://git.kernel.org/netdev/net/c/524515020f25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



