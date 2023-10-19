Return-Path: <netdev+bounces-42470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EF7CED0D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CC01C20D5F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60E393;
	Thu, 19 Oct 2023 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHkvjVa5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E4390
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA22AC433C9;
	Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677223;
	bh=ppPnL3hdGI779ndscvmZJkrXiE/cXOnJ6qpeMJAvQ6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HHkvjVa5jA1GI7eXhpNgVptS+s+hCjegY2Bj4ZzJc4eNFohmdISzEDOq/b91aJ4Ft
	 2VcPo7UAQ+xnkKTn4QvhS+BrpL8LhKHNbVDjvekMrE+g/FDaQP8/640unEfZQFP6Ox
	 4sFDukUzU22Kj2fyZbH0weOawSabyRhSDjeix/qlPADH7nwrC/2XMv9+9qTIblXig+
	 MDyT/+uO8TUlZ2fkWgqtwiLNLqx9KZEMkW2QIhMHoJiarF3K+8MKM6Qg3hqS1GM7Rn
	 9PqcTGWajFL8iD//MU5wohjIJGPj78xfKLpu26jxmkWDY4+YI/DCvLt1jnPW7TElIS
	 LiFIgLTe5vDRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2BA0C04E27;
	Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: fec: Fix device_get_match_data usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767722372.5576.17707408430157555954.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:00:23 +0000
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, linux-imx@nxp.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 08:34:17 +0200 you wrote:
> Hi,
> 
> this is v2 adressing the regression introduced by commit b0377116decd
> ("net: ethernet: Use device_get_match_data()").
> 
> Changes in v2:
> * Update the OF device data pointers to the actual device specific struct
>   fec_devinfo.
> * Add Patch 2 (unrelated to regression) to remove platform IDs for
>   non-Coldfire
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: fec: Fix device_get_match_data usage
    https://git.kernel.org/netdev/net-next/c/e6809dba5ec3
  - [v2,2/2] net: fec: Remove non-Coldfire platform IDs
    https://git.kernel.org/netdev/net-next/c/50254bfe1438

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



