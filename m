Return-Path: <netdev+bounces-142608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574619BFC40
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB41F216DC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB671DE2D7;
	Thu,  7 Nov 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKjVD+KX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF171DE2B8;
	Thu,  7 Nov 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944835; cv=none; b=fGElcfTdoQPM5AJQXz2RMHfunw9m4Dly3b9n8dYSHZJp6zu9/8ZSRsh3PlcpmvteB8FCmKyAFre/5lTWFGqOFPsLr89CUgwGkirT2d6Xk+7g6l+HuJyTERJUXCqGGSG/RrFkOxbm4s7fHvRywVauFMysajPcs/QHQu5YMZkDAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944835; c=relaxed/simple;
	bh=xnDZdbD/2xP0tWH/1uuH5+aag4ZGXoc+A93SI5BM0hQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f52S3vTjnCelreLPpC4N1iwSC8hXlUStyjlwXJCrIr+j963RwtUut0SvNT+MkEUBNie+eSgDKfIn3ft5UmAiB0vWGr+u2AINVQ/60xT+w5dnc4WIvhOsoBpHg4GK5TemIFkIFdGMB/BD6Dx7/0JthiABEgzTD9odDglOw2eb9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKjVD+KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A50FC4CEC6;
	Thu,  7 Nov 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944835;
	bh=xnDZdbD/2xP0tWH/1uuH5+aag4ZGXoc+A93SI5BM0hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jKjVD+KXMTWCwxf0K+w7g0Qot3XkaZOaXnjrB7HcK/mym1iQ4eN72InuRfsi53LPH
	 Q1qt+Jm3tzHgwRnhIVPdOWedhvoZXeNvYYWcL8Lx0eSscgbGwAQGJYrFsby7To7XRd
	 4liy7tdVQrXK6MQ/weJh7aLMryXXvOpa/ujIHMnrUI5gheRg2jnIlkhlhu/RG+K9ve
	 SJUebdL6faJHEYxJ/wSWozz8iXA39cpXfKkUtz35k91shpZbCSUnfhyZo4a9KFe57q
	 vaqt801H7QB5yPCdZYtWRMh3xuj00OOX/UmKrrydmnL7Udcgpbe4hNKAhXIpZeXIeo
	 bZUV7B/q9mgcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B8C3809A80;
	Thu,  7 Nov 2024 02:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: enetc: Fix spelling mistake "referencce" ->
 "reference"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094484400.1489169.12133804920635225010.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:44 +0000
References: <20241105093125.1087202-1-colin.i.king@gmail.com>
In-Reply-To: <20241105093125.1087202-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 09:31:25 +0000 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: enetc: Fix spelling mistake "referencce" -> "reference"
    https://git.kernel.org/netdev/net-next/c/4f19c824025a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



