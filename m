Return-Path: <netdev+bounces-119075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A990B953F76
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDCB286107
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECB29D06;
	Fri, 16 Aug 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aznfeoRx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E81EA91
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774828; cv=none; b=rQ0OcsgP7KjbjFlczoAPv5XOsO5x+UkcB7S0NJ3SF4oGlp4nJq4ESu8vEmpfAghAoYykB5+BMfwiyj30KWSxCHi5F29Ea/FL1pCVo9XtI3yC+9HqW7jX0foFd+TvITbDPQ3D2hpKLfCn3edFWzTHjrLsM1YTzLmlZNuo+alEoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774828; c=relaxed/simple;
	bh=d1IW6Mm5xtnhNU5rzQMt1rZy25uP/BHHPfo2itYXrsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I4TQJ0YKWDOJN1ASqPvVXon6+eUdoVGWyAun4wKcYSpAaSycH5b335zTMaizSa8RoV8BqktOej9rJK+GmVtL3WAvU5G4BqYWHWjXMQhgLWbGaRJeG1hRAj9b9e58HqvdvTgKNTCfb+eqmnxVaMUYrj9BQ2/jR5+kPlqOHXwZ9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aznfeoRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE06C4AF09;
	Fri, 16 Aug 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774828;
	bh=d1IW6Mm5xtnhNU5rzQMt1rZy25uP/BHHPfo2itYXrsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aznfeoRxUx9XcSYDfg8Zo85J5gw+YjnViqYlruX7LYXSiIoRH3tFGbH+SsLBN1uMc
	 1tVvDFgy4GnPISs0h5eT7cqVP2cHZX1YpNaVrSvPjtBIoLyfAmVjJClzphbXXqcztr
	 lSz2dVRUIM0VD2TMJHznUeZpkq3ElPkuaSBnwYK33Bz5C+P1/quQyejgcK+zd6QYni
	 KLDuQ2+uW8qeuGXgzD92O3SKO/uyrEVP4DAATZlQLfON0p77yB/mg870vyZNSP/LW+
	 HqE1gkdcWmHbkmO+OZIup1xgYq3xaFXX6idQhtLdSRGf+XcZp7LxOLhvrazF0/3pwr
	 Y1MPVK+pZu3nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC6D382327A;
	Fri, 16 Aug 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add selftests to network drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377482776.3093813.5341431423800854633.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:20:27 +0000
References: <20240814142832.3473685-1-kuba@kernel.org>
In-Reply-To: <20240814142832.3473685-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 07:28:32 -0700 you wrote:
> tools/testing/selftests/drivers/net/ is not listed under
> networking entries. Add it to NETWORKING DRIVERS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] MAINTAINERS: add selftests to network drivers
    https://git.kernel.org/netdev/net/c/b153b3c74700

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



