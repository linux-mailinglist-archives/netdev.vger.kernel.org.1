Return-Path: <netdev+bounces-220541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B482BB46826
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7585B5C63CB
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8B1CEAD6;
	Sat,  6 Sep 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofIlQSox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA71C863B
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123408; cv=none; b=OYTbbiV+dTNJQu+sa6YTQX217rB9vq3iYki54zx9Qm/QBG05xgYNjtCbP8S9VbxsNQawHI3YEfA1zwHIi8a33M3aNOCt2pQaQyLKdPYuW3XzEiT6C55L2hDGZ9aYyJrkPMqD2OgvJ2AbNjVgqIMLp3Gvioo7ahSXK3FCiOg1yhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123408; c=relaxed/simple;
	bh=kWVzvge+87I9B84weIZKEK/gfqThSa+xLfdC2S0F6ho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MHwi6DWgJFhrYTH6tGCr/qTH7mpbGZbSY6jVHbtLpkzKkluzExskvIbQXi/Y7nffEWWD3gZd6yzgqTJ6AlqhNpstvXOxA8peIwhZMmqwN0UDxMt4K7tRD/8B9EnRMgsq2UDTGZ96EVJzdXjAoXdqinPSDrZcb+GnUtArshGeeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofIlQSox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156FBC4CEF1;
	Sat,  6 Sep 2025 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757123408;
	bh=kWVzvge+87I9B84weIZKEK/gfqThSa+xLfdC2S0F6ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ofIlQSox71LmNtKxGjmugZmJ2TNgRtBnC2Ci0dWewM2AAf7B+sX1+SZb7WOs4DGQY
	 Pb2YAXXoQIPTHtR3Lo1+KwPSQCQ5iSFs8KHA8nGcQcHjYALjFngeDxUVHvSdcAvESU
	 UhmU+rHb0fsikLPrxuMKElxXGTeQSY7cNBQXBNWZ/D5Pvx3k3sM2M7K3OXFL6DGRPy
	 nXAoD3ZAc+ONGsySR8tugrq1ek4GuyzxweDgK7kHjp1Ync0VYgWgWGSfM6ehj4fCYM
	 zEmsiW9i6CfjGz+R64aW/bRQzeSCYwXHJJIgu/PX7Ft3+a77dXZ4nAxR4JOkHQR1vp
	 Pc0YyuzR09EiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB96383BF69;
	Sat,  6 Sep 2025 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fman: clean up included headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712341224.2742584.774559707859072998.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 01:50:12 +0000
References: <a6c502bc-1736-4bab-98dc-7e194d490c19@gmail.com>
In-Reply-To: <a6c502bc-1736-4bab-98dc-7e194d490c19@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, andrew+netdev@lunn.ch,
 linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Sep 2025 22:26:58 +0200 you wrote:
> Both headers aren't used in this source code file.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fman/mac.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: fman: clean up included headers
    https://git.kernel.org/netdev/net-next/c/13a94444fbd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



