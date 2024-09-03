Return-Path: <netdev+bounces-124716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914DB96A89B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC6283982
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAF1DB527;
	Tue,  3 Sep 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojDmrktY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89D1DB523
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396031; cv=none; b=Go3PHoZXmiF0pL5DBo6hUR0+DjgWinbTEC/jU4ioEIiKPzLHPQ5hyNOawHIkAWUIKfxH8uWoneIN+h1tzzQM6wVZJTXUtI7v2uFk8Zv7jZIJtym2DWl6MxqM01g9ySKfH/vacgDrnZd1cmIv/XanNGgJ1ef1cyKGDJdFQwPqQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396031; c=relaxed/simple;
	bh=eg53+Sf6KpZ5AtpNvKfku17qG3p59vhLBcgrJFAc5AI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ap4lIMaml45QebpASar68gp9LAm6c+XCSLJddLhfK0kIv/gXFTubHJlGRaFgQiwqYPju1MBKy5GjaZVOwl0HSBI00EfhEmsc7E12EnGG+LfoCztTgI7VkmXb6lZJfta4xUvMAvgetbgyKYT4YruXkRJa00JQx9H8dQbl/yrdFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojDmrktY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F95C4CEC4;
	Tue,  3 Sep 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396030;
	bh=eg53+Sf6KpZ5AtpNvKfku17qG3p59vhLBcgrJFAc5AI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ojDmrktYzgQOIicMvD+auylKn8Vf0ezVOIMo+mIWfxzMVf8yP9hk/Ec79wtvR/rA1
	 YYfKuBBAYqnV1zao4rda2WshNPUetrUhXFdVUNufJiCQPVfjxjcRGG4k/exejeR6BI
	 c3jcAK3kBlg4RWmL4isdOFWmKJBoX3JyGBiLLHwbTXrds3Ps3FtjIBXY66GgXlsWOr
	 DQgXNEzFhduCFRZ+R8dSTp+WGmbwK5bEOg5CFqIDswhJTQrBBG0+V93wQPqyAUzoNA
	 SNuW3GpkUYeJYiazKtQIkQfNNkwJAAKyCa4en2rxT8cUTHFF7SyGUoTSZ0rjVwzcAp
	 932q/LLCAEAig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3415E3805D82;
	Tue,  3 Sep 2024 20:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates
 2024-08-30 (igc, e1000e, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539603101.433234.3474992805062917002.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 20:40:31 +0000
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 30 Aug 2024 14:04:42 -0700 you wrote:
> This series contains updates to igc, e1000e, and i40 drivers.
> 
> Kurt Kanzenbach adds support for MQPRIO offloads and stops unintended,
> excess interrupts on igc.
> 
> Sasha adds reporting of EEE (Energy Efficient Ethernet) ability and
> moves a register define to a better suited file for igc.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] igc: Add MQPRIO offload support
    https://git.kernel.org/netdev/net-next/c/9f3297511dae
  - [net-next,2/6] igc: Get rid of spurious interrupts
    https://git.kernel.org/netdev/net-next/c/8dcf2c212078
  - [net-next,3/6] igc: Add Energy Efficient Ethernet ability
    https://git.kernel.org/netdev/net-next/c/ad7dffae4e40
  - [net-next,4/6] igc: Move the MULTI GBT AN Control Register to _regs file
    https://git.kernel.org/netdev/net-next/c/f9cb5e01cc4e
  - [net-next,5/6] e1000e: avoid failing the system during pm_suspend
    https://git.kernel.org/netdev/net-next/c/0a6ad4d9e169
  - [net-next,6/6] i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX cards
    https://git.kernel.org/netdev/net-next/c/0568ee1198f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



