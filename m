Return-Path: <netdev+bounces-17859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10597534C5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3262821C3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E6C8F8;
	Fri, 14 Jul 2023 08:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111A79E3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99517C433CD;
	Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689322221;
	bh=GlAZq5npUqXul4zIomw3u4mqvyy1hb0aQKLBV10CF2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqanoF/2s0MB5yJojOLn/z4n3F2CmLk6d1bXpHkZI0v7/88+0DnFfKgXthP5q+hVA
	 pXo32kDQRFj0as/9NRUqB44QT/GbpQ4fqN7pL5+oxSbDfbPs6U8Qo/NPy9ffx/BVbg
	 ysik33L1TFqbedh+GpZ4p1SXvXzxVKlnahtc3cyCZ/bg/ZPl9meOgnBro/deinfpIG
	 hYiai13T+FAwLk/eDNtU5cn07bVfTwN1TZ/ExacU/EtA1WrCRSVdJyOAWIs6Naem0F
	 bynDPtmW8Ydk2zUIq1P2i8YtjfsY8oRv7d7eZn1cOPafOt0wa5bzCj5uj5JL5f/xsr
	 fwsQikVHbx+Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85316E49BBF;
	Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2] devlink: remove reload failed checks in params
 get/set callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932222154.28600.955217270189696898.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 08:10:21 +0000
References: <20230713094419.2534581-1-jiri@resnulli.us>
In-Reply-To: <20230713094419.2534581-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, moshe@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 11:44:19 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] devlink: remove reload failed checks in params get/set callbacks
    https://git.kernel.org/netdev/net-next/c/633d76ad01ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



