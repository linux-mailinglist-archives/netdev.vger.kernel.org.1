Return-Path: <netdev+bounces-133045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA24994596
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216BA1F2569A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA31C1AB8;
	Tue,  8 Oct 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4oSGpxX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B91779B1;
	Tue,  8 Oct 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384032; cv=none; b=oGJrajKvnA6Ho2JyD41yAAOn909bA37Li0cc0Za0Cs397C/lPJrbsPWjFb/hq3pJ7Ys/z/wkv7BtrY6o1gtSpCln9KPVoBU95Yt0ALdVEPzQq8C+52EH7fpmSvJVGmlqF+sGcGPLZK0wzelkwSUizTj5BT3RQQbTBgzHL9+U+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384032; c=relaxed/simple;
	bh=A0YhKsiXP2Xt18H5UHnW7+vMopAENwLVs835p9iWjjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPSa9u9DeMNqaGNJnCNsUVUzP9eVPjDuIAih8sV5O/Dbyr3ZNJExRnOowMJqbPGDrI28ozC1cGuDJgVmZEuYOJorLtNf3/6nGwlb72Z69t3clWq4LojxdEevVlNks4YZ2U2/3wlGZq4CUIYLPDYfan5xr2ZOttDWmqMiUA4wGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4oSGpxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D6AC4CEC7;
	Tue,  8 Oct 2024 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728384032;
	bh=A0YhKsiXP2Xt18H5UHnW7+vMopAENwLVs835p9iWjjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4oSGpxXrm4k8oHsZEaPcGJ6huOlT3dJbsCtUHoIXhqTjr51iovBmkHz18fcmFBjJ
	 5OvMzRAmRDz8a4WCZTfeqYKnrSevIB1DpgV80YkTY4v5W6LyDyu272OqC7m3G/nZ5z
	 TxLPAi1HKTR9a2GhAXk+mdIcrDIFx0uMKr4YGAWYtaw38gYkFIOHo8/7c2qvaSyFwY
	 UglkBV1lYd5u83fTEItQ8K+U70pMJFl+8+x4NRZuNwnPEglOoHmrtB2maHtd9rC5UL
	 b5WD/ihkrLqHiKL+gGWBhpEeYdJenVAnh/7NshRPvaC42Dqvwb1Hd+E4q0Q6WoaaCN
	 KhNqDvE9dE8gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 728F83810938;
	Tue,  8 Oct 2024 10:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: fec: add PPS channel configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172838403627.487135.12470699672942876836.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 10:40:36 +0000
References: <20241004152419.79465-1-francesco@dolcini.it>
In-Reply-To: <20241004152419.79465-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, linux-imx@nxp.com,
 francesco.dolcini@toradex.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Oct 2024 17:24:16 +0200 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Make the FEC Ethernet PPS channel configurable from device tree.
> 
> v3: https://lore.kernel.org/all/20240809094804.391441-1-francesco@dolcini.it/
> v2: https://lore.kernel.org/all/20240809091844.387824-1-francesco@dolcini.it/
> v1: https://lore.kernel.org/all/20240807144349.297342-1-francesco@dolcini.it/
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] dt-bindings: net: fec: add pps channel property
    https://git.kernel.org/netdev/net-next/c/1aa772be0444
  - [net-next,v4,2/3] net: fec: refactor PPS channel configuration
    https://git.kernel.org/netdev/net-next/c/bf8ca67e2167
  - [net-next,v4,3/3] net: fec: make PPS channel configurable
    https://git.kernel.org/netdev/net-next/c/566c2d83887f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



