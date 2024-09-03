Return-Path: <netdev+bounces-124351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18D969164
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3F1C228CF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722D1CDA33;
	Tue,  3 Sep 2024 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9d0wza0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FA2AEFB;
	Tue,  3 Sep 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330034; cv=none; b=AGaRqorxUrFwDwJaMhYWnFFHK9EpVKn/v4dyGPg4iQ7mqFXPuUfyomLLfCNmueRm3za0ajfgalKiqr1iQe25cBVLBP/mtk5WRMmdvZ3N8dWkiIUZSNdb1M1jffVRvsh4jXrse/WrP2gzkHEoJr4EhsZARfTLMbk5gOFf5ATZpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330034; c=relaxed/simple;
	bh=xCy0r0OI+oIFzv4+Fd73i0U/sAlrQZ+2Sxt3fHOd+tE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6fjSsA/3UYCG8LvXggxBNXk63ez0XzzFylNDV4oOQ46WQKAAcvhgIr4dDT4HbvwneWoHGMBEKbAtYw4cXWrQpTK9Ixoalps4SkmZi1rO4VfrArDYsnXAheIQxi1Tu/jKNyfxgATT6n+6meTHWCAjY8kOBcHWYt85p0fxiD7tgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9d0wza0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD9DC4CEC2;
	Tue,  3 Sep 2024 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725330034;
	bh=xCy0r0OI+oIFzv4+Fd73i0U/sAlrQZ+2Sxt3fHOd+tE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9d0wza0cBwY1gtjzwyZlLe+x06NZGCxCvnskkTtKDGK9vQvBOOcdmH0zwxeK6Fxt
	 G5UoYWbhMNECfNUT+Q51NIe5yYFugux2BftuY/Knh1qMXeB6SGnWgwNx14RrVVEyde
	 yER31ORcZ7lceDN+l1q09RSqBjoMMCue1G0rwlH0ZmtAe/rL2rkUg+Lk+vGg1rl6Z5
	 Rz43eTfsE7Yn5wQ5lgsAO6Nf+FMOcwiz5VbiiZnB2apeyMIuZimip2xdYIEF6j1III
	 W6hYWhFTWGSD5fNtFScwmtsJPpHhTG9cVq12KdJMFMfgtOuOFJ7tuad6MtudMo758v
	 JdVsmQPRvC+4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C943805D82;
	Tue,  3 Sep 2024 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for RTL8126A rev.b
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172533003475.4035616.9650408916931285098.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 02:20:34 +0000
References: <20240830021810.11993-1-hau@realtek.com>
In-Reply-To: <20240830021810.11993-1-hau@realtek.com>
To: Hau <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 10:18:10 +0800 you wrote:
> Add support for RTL8126A rev.b. Its XID is 0x64a. It is basically
> based on the one with XID 0x649, but with different firmware file.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 42 ++++++++++++-------
>  .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
>  3 files changed, 29 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] r8169: add support for RTL8126A rev.b
    https://git.kernel.org/netdev/net-next/c/69cb89981c7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



