Return-Path: <netdev+bounces-56817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E8810EA4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377031C20B2C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649422EFE;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpUgq6p5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960722EE6
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 520F5C433CD;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702464030;
	bh=7B6ugx+XEEr1cV3LCCRW8l767Hi+LDDq5/z8sH9g8WU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tpUgq6p5UfhqkpNS1+YVRXzp7aehVS5rMEc7/+bZYpma1r1je38bwgzDRsULimoGg
	 zr9b0zIajYAF+CJoSuJPtA4y998qHIumdS1CznmhSTdyq3rmvvQjrjT/EFtGUNd88b
	 Zh8e1W/4MvVdKzYeEK3rb6Tm/oPMNQmq31g/FIPbUqRSZhOSlZPNtqBWHqrumDs1R8
	 juW1z7oIXtyFFnUnrZtZ868hoibgXcm/Bgp3qVG5QMqONg0rdS+HZpbleYRqa3RMFQ
	 bHxepbuY/MROW2JTl5EsU7K/c/Zb6EhR5QjGo4KufEnTfI39FiSu7WVgxKD7+dd6QO
	 tgUnnuSwx1qdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 361E7DD4F11;
	Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] dpll: remove leftover mode_supported() op and use
 mode_get() instead
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170246403021.27343.14966383934189063898.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 10:40:30 +0000
References: <20231207151204.1007797-1-jiri@resnulli.us>
In-Reply-To: <20231207151204.1007797-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
 richardcochran@gmail.com, jonathan.lemon@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Dec 2023 16:12:04 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Mode supported is currently reported to the user exactly the same, as
> the current mode. That's because mode changing is not implemented.
> Remove the leftover mode_supported() op and use mode_get() to fill up
> the supported mode exposed to user.
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: remove leftover mode_supported() op and use mode_get() instead
    https://git.kernel.org/netdev/net-next/c/4f7aa122bc92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



