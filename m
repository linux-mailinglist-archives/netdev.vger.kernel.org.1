Return-Path: <netdev+bounces-147398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901EE9D9685
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567B928A505
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76F1CFEDB;
	Tue, 26 Nov 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsj4b6lT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551421CF7A1;
	Tue, 26 Nov 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621818; cv=none; b=PXJClBMcpfvkrQnR+yChh95Fr10plKjWr3S6y/mLK6HwB3dvErcbQFkibJ6TlXNAWt2LLbvKSPl9U4yRkGHDz+ZNN4PU0SG0W4IMYd+R2ciiM/cbtMChOxe9J9A5SfU5Sd8fkfLsz0P7whCovhSHDje4YbV+WZ51+Na3drtcP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621818; c=relaxed/simple;
	bh=oKh7sp0Ecwnh2RNXEO0aVQBi0j1F4BGPQFwGp6eo3lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhvLYOkx3iirha6oG6cLdmFOCa1kuTL5IvzLzC2VxA+xtEdOFy2DdT8l2U1Ls1TI46g2uqnXg5b98wFx0chMYDDBZBVLa+4rrtUpSTKKlQEwOi1jIfix6rwsmlVEZ90r23h1w9srn6zvG7a3mffSg5zlQYC5jkNKXjqTOqLO6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsj4b6lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5919C4CECF;
	Tue, 26 Nov 2024 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732621818;
	bh=oKh7sp0Ecwnh2RNXEO0aVQBi0j1F4BGPQFwGp6eo3lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qsj4b6lTnsVQv5dupK/3h4xssYEbx65lCg+X2mIwj/h1ZzgjA8YSbvV1xNkAj9Bck
	 OLPeMDJGLNk+CjQ1Gjr8QTiZfoetfF8bCIOe7xLSFzZSkm8Z0xA94pba44xSL2cwZc
	 dqSIjpiVtYmVbmhCiIweO1gmvOfl4VPCXtjoh2y1ykTtRP37AW/uovQi6h2215aaAw
	 yoCMctJeuP0oAa4z/CcyHTXwdm1w3yyJvDz0DEBD+2CwttAUKYx4KOVTuIeb6X33EC
	 x3NI+0woCZrgafDt7tTvO9XKbwsaDYTUeNhiE7tSPuMCLUB1lwih3q95deXjMPtFWf
	 K/P/HZCkE/LxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A33809A00;
	Tue, 26 Nov 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 0/5] octeontx2-af: misc RPM fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173262183075.361852.14254743220816168481.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 11:50:30 +0000
References: <20241122162035.5842-1-hkelam@marvell.com>
In-Reply-To: <20241122162035.5842-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Nov 2024 21:50:30 +0530 you wrote:
> There are few issues with the RPM driver, such as FIFO overflow
> and network performance problems due to wrong FIFO values. This
> patchset adds fixes for the same.
> 
> 
> Patch1: Fixes the mismatch between the lmac type reported by the driver
>         and the actual hardware configuration.
> 
> [...]

Here is the summary with links:
  - [net,1/5] octeontx2-af: RPM: Fix mismatch in lmac type
    https://git.kernel.org/netdev/net/c/7ebbbb23ea5b
  - [net,2/5] octeontx2-af: RPM: Fix low network performance
    https://git.kernel.org/netdev/net/c/d1e8884e050c
  - [net,3/5] octeontx2-af: RPM: fix stale RSFEC counters
    https://git.kernel.org/netdev/net/c/07cd1eb166a3
  - [net,4/5] octeontx2-af: RPM: fix stale FCFEC counters
    https://git.kernel.org/netdev/net/c/6fc216410846
  - [net,5/5] octeontx2-af: Quiesce traffic before NIX block reset
    https://git.kernel.org/netdev/net/c/762ca6eed026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



