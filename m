Return-Path: <netdev+bounces-123447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D3964E4E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9709B2125A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E91B9B33;
	Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdVtvX+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F681B86E7
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958028; cv=none; b=KIRJCwAOqht/QMLWC35Cx0xbRMFA9zDx8XpQpZ1iPsczWkQM0cZny5B/Ny9Xk0e44IllckVQa6JV9FqXunGz6bexAzZXUBW0i3uHlQUrBov12qM3zqHuXP4iefYgEyKnVrAM3s0+m9vzibTNGLjrSitLB4nYO6SePdwyFDDjcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958028; c=relaxed/simple;
	bh=tBP2fuO0i8BSDVfOrTovE+0/TNwldpcTD6RVQ9+JldY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kBwXwR3h8qvl+3FxjbeR3rjNowNkQyQu7cOq0ukOw5ZsWzvRuCCU3J1yS5Q2dUEvt+MXzyeMFsr41dCkbw3trPUqWsKFlQyEU/Hmu+aRfTYNFph8JPDrDpM7ACGkFwHJhVl119y2xJPMlbbbiN9lKenNsXNvPltqhI+tDsgnWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdVtvX+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDE3C4CEC8;
	Thu, 29 Aug 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958027;
	bh=tBP2fuO0i8BSDVfOrTovE+0/TNwldpcTD6RVQ9+JldY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kdVtvX+0G3PUVeEYeZ25epTr16sgHnam+cUVid5LPyD0SSaWfztDavgvMJmc84GFB
	 p3CxTaVd92ooAtcXtcL+3jVvrkDni5M2ZlFfHFil0tue2ZaiJaesKvYGTElLV8VIjT
	 gKLPtaFPCCwLhBLzbHV8TCCduZCNhmu/eFG10LbN67w+1lEAnfik7+4471fXJOAhBk
	 yQCG8n86nW97+txkzq4/tPi8KnJ0vhwbiBFyl6Tl2jsrhxgama9Sr/srPRCiDtryoq
	 Hijc7TMKeEZLlKGu7g7sxwUAxo9C0TkvLDiQ3ePSEyrPeVijKx3Eci0If5D/KYyai5
	 zzxp2XuNo4/qA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5369E3822D6B;
	Thu, 29 Aug 2024 19:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns: Use IS_ERR_OR_NULL() helper function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495802933.2053394.15177202056943021032.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:00:29 +0000
References: <20240828122336.3697176-1-lihongbo22@huawei.com>
In-Reply-To: <20240828122336.3697176-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 20:23:36 +0800 you wrote:
> Use the IS_ERR_OR_NULL() helper instead of open-coding a
> NULL and an error pointer checks to simplify the code and
> improve readability.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: hns: Use IS_ERR_OR_NULL() helper function
    https://git.kernel.org/netdev/net-next/c/4266563afbb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



