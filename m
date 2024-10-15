Return-Path: <netdev+bounces-135586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5D99E484
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EB5B21DBD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AC1E32D0;
	Tue, 15 Oct 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2DuIiZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387D4683;
	Tue, 15 Oct 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989428; cv=none; b=O4a+37IFw/JXbxAGruqoZCpb8dTZoUm/UTACW9b2OUe/y8k3oWBOfJBlg/Whp+q2c1Gd5IMrhuah3lFOBu3nOP79/SlI2eh1mSMpw2EqFs/ZoHD9TcyG1TsAhm+YKU3UqEed8CWfXHrszIZNzTktL0r3CSxHsl//Z4Pwe5j1CmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989428; c=relaxed/simple;
	bh=ja/d/rq1IfTJFJLTJFWVgn1+fa1Kjnj+heTESXMxPQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YArXhRq/3cr/W9LH/qEHe+UFRIyvtEvRt2pkc7Sblu+FYcljLBIn+OjsHKXyoQimu65hULKpJuGy5wrKFifoaMnfaQlTG98vU84P8+fKpb2sMd+97Yqd8jOdSlnuhoThK6kRgxHFGRn5i3vVNnnszKa/wRxXh1jzMhLQSiEoNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2DuIiZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D42C4CEC6;
	Tue, 15 Oct 2024 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728989426;
	bh=ja/d/rq1IfTJFJLTJFWVgn1+fa1Kjnj+heTESXMxPQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2DuIiZYWTMVVAzlXrVBMLoQEKv4nRGtcgPLeXyXfWy/JYyGTyxhtuxszR8EOuHcA
	 DCj1pZQAvf9fggZFLECwQl4z6+rXigRL6iUg+kbnmba1xSuWTMrSA9y5GqE3lg5t7W
	 ykwPAKT1nTAhUp3zn+dUnyniafTH+TH/h2FtcVxPxpTex/gvRmctheTtLExHxVGRQL
	 HuTLxN0zDM1YtwAZzFUgs/eYFOLoUnf5alBYykq7hXEJcuo/w4XfhNu5bqkq4dcdnE
	 jLXYvBXg2WtWHyFIAi/C9J2DY3cmt/xX9Nyeqjb0ZTFAiKL9H1cU0oAjQM5P2kyyJQ
	 zoanbx2SGQtWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F3E3809A8A;
	Tue, 15 Oct 2024 10:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net: stmmac: dwmac-tegra: Fix link bring-up sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172898943126.1114309.13560475408965156147.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 10:50:31 +0000
References: <20241010142908.602712-1-paritoshd@nvidia.com>
In-Reply-To: <20241010142908.602712-1-paritoshd@nvidia.com>
To: Paritosh Dixit <paritoshd@nvidia.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 vbhadram@nvidia.com, ruppala@nvidia.com, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 10:29:08 -0400 you wrote:
> The Tegra MGBE driver sometimes fails to initialize, reporting the
> following error, and as a result, it is unable to acquire an IP
> address with DHCP:
> 
>  tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready
> 
> As per the recommendation from the Tegra hardware design team, fix this
> issue by:
> - clearing the PHY_RDY bit before setting the CDR_RESET bit and then
> setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
> data is present at UPHY RX inputs before starting the CDR lock.
> - adding the required delays when bringing up the UPHY lane. Note we
> need to use delays here because there is no alternative, such as
> polling, for these cases. Using the usleep_range() instead of ndelay()
> as sleeping is preferred over busy wait loop.
> 
> [...]

Here is the summary with links:
  - [V2] net: stmmac: dwmac-tegra: Fix link bring-up sequence
    https://git.kernel.org/netdev/net/c/1cff6ff302f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



