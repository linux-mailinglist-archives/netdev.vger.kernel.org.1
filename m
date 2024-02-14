Return-Path: <netdev+bounces-71597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2598541AD
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92283285B30
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA18F6D;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E39/+0RU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AF8F56
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879631; cv=none; b=BH1qruDDx7MUDWr/74vD9qgHgvLayXC0y0znR8wX9ZODBrW9OXaOqMDIgwIhM1J9M3cX36/FJZzpp5zG7d3FUs5QzTwcC7PnRzyrRito3m8+y92uaMiKXwBH4KpUbTJ0LlwxOIMpPWGTTSt9LlRwOBVHNSAOFqfQeTFqWbzfB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879631; c=relaxed/simple;
	bh=D5uKYLnG2sRT4HqqcZmCBvg/QYzlLZucOM6wlIQYyYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFzTIbaGrxYFwbrP35iYS7weRzZ3eYaAk2jgNxA22Vc7+gTw3TV4wN7NTNAMPjV4PV+2meT6v2AKanONhIZ9E/0+e1n729ZefXMJ0L0T+k27nthOKc2456PooMs7zwwMRFgO4uX2HkX3fEp4m08QHbc2aodWTMeIjvfBQ6d+Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E39/+0RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C00C433C7;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879631;
	bh=D5uKYLnG2sRT4HqqcZmCBvg/QYzlLZucOM6wlIQYyYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E39/+0RUtJwNW9r6RzvCqjACM+dB+eTc5kp/ZhCPc53JdxGG3+DbYJDVtej57y6ij
	 xXXAy8cQn1+jtTqnpSeBXuW4VMJGlQkSsrc+jR7bb19Xy0yPvA68GUSD2qwaKqG4uC
	 Nky7KviCUKsv5IMKmFIxDA8SIkKvzPcWX04zv3WIw8dQYrspjHUQ7FGfZczQlLwS6s
	 32Z+EWuZx4byp8PywqrO6SqVVQWo9gJAnTbhk4QI3JSg+3y7O3iC+glk2BMurUHJcM
	 9iuIB6+hJOkSDzcczPZqwRiCGQP3RWlBP6TIn8A8wHmxmSJzHrcxapNpR6plLdy1Ym
	 3VjsT7KFEjkPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE705C1614E;
	Wed, 14 Feb 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 1/2] net: fec: Refactor: #define magic constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787963096.17924.5611859737966888474.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:00:30 +0000
References: <20240212153717.10023-1-csokas.bence@prolan.hu>
In-Reply-To: <20240212153717.10023-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, edumazet@google.com, pabeni@redhat.com,
 francesco.dolcini@toradex.com, andrew@lunn.ch, mkl@pengutronix.de,
 dkirjanov@suse.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 16:37:17 +0100 you wrote:
> Add defines for bits of ECR, RCR control registers, TX watermark etc.
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Changes in v4:
>     * factored out the removal of FEC_ENET_FCE
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: fec: Refactor: #define magic constants
    https://git.kernel.org/netdev/net-next/c/ff049886671c
  - [net-next,v4,2/2] net: fec: Refactor: Replace FEC_ENET_FCE with FEC_RCR_FLOWCTL
    https://git.kernel.org/netdev/net-next/c/f7859a03fba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



