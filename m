Return-Path: <netdev+bounces-40137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77517C5E8C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93B51C20A15
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E418B1C;
	Wed, 11 Oct 2023 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdOlIiCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F351B27F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0A5AC433C9;
	Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697056824;
	bh=2RWy9P8mudrSGo3M9kaqok8tQWadDKygPEWWz6VkfhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YdOlIiCsNxt0PHnl1XNnvLDBZ/mUN6zb2SlizzWCmqb8JCm8zvOYn5PenQyqfIsIe
	 d+YIxF6wheapxtTiGZHdyLKqqjWOWSoy+rTJLP7JsdFL9RlRSj9eifrxa98ULsASuE
	 ijJCAerNw8/5EDJ5fY8XNfAPLCJSAva7o+PTsMpbCqxPsXmaw2kMDzPcTQnHCI9XWr
	 p0yIvqSsLA54V31zh3U0jg6DAaI7F4zqE09M4SdNMUSzpwPppVDksYdqRhQuPzFQXH
	 L1AE/kc4AScQmvFtteunN1ApZF8DSeWNSyPQvCLikGrjnBR9DgkEhsP409QjsiqbN+
	 AdZyjUUy8vICQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A406E000BB;
	Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2] netlink: specs: don't allow version to be
 specified for genetlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169705682462.25671.16959951705835597871.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 20:40:24 +0000
References: <20231010074810.191177-1-jiri@resnulli.us>
In-Reply-To: <20231010074810.191177-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 09:48:10 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> There is no good reason to specify the version for new protocols.
> Forbid it in genetlink schema.
> 
> If the future proves me wrong, this restriction could be easily lifted.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: specs: don't allow version to be specified for genetlink
    https://git.kernel.org/netdev/net-next/c/0f07415ebb78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



