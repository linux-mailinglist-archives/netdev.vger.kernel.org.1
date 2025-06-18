Return-Path: <netdev+bounces-199241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E6ADF89A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D7C3BE47F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95C27A933;
	Wed, 18 Jun 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFxnse35"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858427A46A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281585; cv=none; b=BW3+P1vL1msWceJuJEGSVLDuuQXehVzVGfZcTmv/ZOKZdKup/qotbO7QLWwJ8fq4c9+a89kKL8SNd+vAMLVmBVQXLj/fnCY/De7pGBCNVH7ZBO5V0vSPsBhefVm05HM6/QQdMeZ3Inef9vzpG+jXuBUYm8JslsEUuMN56Ozsvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281585; c=relaxed/simple;
	bh=Bpk6aIdGoZoKCWNPayNeb8aKmTTtjgj6g6k39AbaS64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gWgGMQYxpQ0SO7rTeosrVV5D0+NuB8Eqtvv3uE2NQ1QgJ2nemuudHjW/oNRttSZ0JK9AtjdacLBYDizsL8r+n3sSmdViBYS1Gn8VFae07rT6lYr50Ffa8+MQD34lpxWfNoMmTaznUoIjq5dzKEdjoDFLYvTioB/AzXXHjkq7sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFxnse35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A660AC4CEEF;
	Wed, 18 Jun 2025 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281584;
	bh=Bpk6aIdGoZoKCWNPayNeb8aKmTTtjgj6g6k39AbaS64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SFxnse35/CN55IauHih6cML8fvpTcVO29A5z2HGfcu4L1S0JneCeAD3ZK9PJ21fYk
	 aQzepOoqKZ8zG9Jnqp0/sl3/CTyHhEjHSEmiZWoG4jheVJ+iFzDRGhTeW33egvNCBt
	 o/bt5Irnoa8LbUtvRWCCGUl8/gfDX5lNB/INJCnsH80Dky1sRoqXPlJ/4niLezFVZY
	 P2zo+1ZG+/YhNlxVdWYgq/Jh0eXWG+s3eN5FwVaSan9FxpKU0w7V4IkDmPZ83w7YxE
	 L66iWXs06AQRI9TWsX/LFdFCxjzOtj7t5mH87fa7QhCd1EbgbHC42JFC21N/WVNean
	 52xZqgxK9owXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D013806649;
	Wed, 18 Jun 2025 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net] net: ftgmac100: select FIXED_PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028161299.259999.1742509414083669246.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:20:12 +0000
References: <476bb33b-5584-40f0-826a-7294980f2895@gmail.com>
In-Reply-To: <476bb33b-5584-40f0-826a-7294980f2895@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 horms@kernel.org, f.fainelli@gmail.com, rentao.bupt@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 20:20:17 +0200 you wrote:
> Depending on e.g. DT configuration this driver uses a fixed link.
> So we shouldn't rely on the user to enable FIXED_PHY, select it in
> Kconfig instead. We may end up with a non-functional driver otherwise.
> 
> Fixes: 38561ded50d0 ("net: ftgmac100: support fixed link")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [RESUBMIT,net] net: ftgmac100: select FIXED_PHY
    https://git.kernel.org/netdev/net/c/ae409629e022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



