Return-Path: <netdev+bounces-97897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8379A8CDB89
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449DB1F2431C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9984DF9;
	Thu, 23 May 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihx1ovZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12953E31;
	Thu, 23 May 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497233; cv=none; b=u+XZFVWi46KvSXjYR/6l1DrBW1RwayOhazLZwkFqvuMFrwUSJSShfm0tuXWPgAQY66Tf49BVtoON7MxFmdFQe4jZpzo5klJaqRwmnpm4VOnApzOiSUCt98zZSmYyypkV77BAQ23klnPhbuvpX5LaeRRMRRE2Wy6DBH0j8SVKWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497233; c=relaxed/simple;
	bh=0kaKeD5ajy7QjM1HCLCiLb+fHLclywW8P5rBkBL8O1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xtc7Uaf5iGdzwtE3MCRdtvUuL6FJUVukB1AJX4x+9VZZjqdFCYYFIc0BhPxo32SzaF622M3UoWhG12YdXeUQmga7H05Wboe0bzmBWHcK79RJp1VghngnQ+rSp7wKsjJ7RuwaAgSpAyAgcuAtyS5+3kW5qNH+kohBr7ZCf8Hoetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihx1ovZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 081F8C32782;
	Thu, 23 May 2024 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716497233;
	bh=0kaKeD5ajy7QjM1HCLCiLb+fHLclywW8P5rBkBL8O1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ihx1ovZG1slVGXWLTQXUpftJcKYRzcjyIfbyWtQqPdmJtr1afxv627gA0c4XERb2v
	 /j5bC/ysmZzjtwpTvuTKL3MCVk/+QeT44xKYfqLcqtcLnbjx+nrEed/13piXadQO2n
	 /+Ypk6FzzXaVFLZgCHh7tg262cu4Cse50tRj3NPQGmc+MtE3usyjuLSIiR6l93uEOO
	 5deGcQ+UDsvFMfdzS4Zojt2xtRbsqwx6Qcw1CS4mA/bawYiycTSHXO5b77za9Y2oHT
	 pwQ2Wqbtu0GdxGHaDwmN/fxFpdHupZcey54zQUHpOcWEiZ84QbsDNwoUMMCIBGg+UD
	 d6Fe1LJoPvwRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D837AC54BB2;
	Thu, 23 May 2024 20:47:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171649723288.14313.13144191838694065480.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 20:47:12 +0000
References: <ZktYriALqC7ZNQpa@infradead.org>
In-Reply-To: <ZktYriALqC7ZNQpa@infradead.org>
To: hch@infradead.org <hch@infradead.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 20 May 2024 07:05:34 -0700 you wrote:
> Note that the the dma sync optimizations reach into the networking code
> and promptly caused a conflict where the netdev tree constifies the page
> argument to page_pool_dma_sync_for_device and this tree renames that
> function to page_pool_dma_sync_for_device.  The dma-mapping version of
> the merge just works, but you might want to pick the contification
> manually if you think it is useful.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] dma-mapping updates for Linux 6.10
    https://git.kernel.org/netdev/net/c/daa121128a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



