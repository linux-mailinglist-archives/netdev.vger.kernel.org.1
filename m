Return-Path: <netdev+bounces-115451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61157946640
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B11F226DD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBB13A404;
	Fri,  2 Aug 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU9iX30I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D28131BDF
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642633; cv=none; b=Vbpb/FKN7E6olxLJe04zAYBc0y+7B7LcaBi1nXLD/7xxWMnQ6lHUCgCOxehRpOhzpy0FyeftsyFosXE4Ez9aLE3IItXvcCVezQA5qxM7fFdYrONFV0voEFhFW0J8tE2tTb4HSU7TAOwX4S2e7W8oeUrc07V40VrKIw1GuYK/f+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642633; c=relaxed/simple;
	bh=KS9CiWWD+aMwEhJfuj/FUz08eXVbDzlHy6N1i+r4nTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjVJE2uvZQJ7vURNdys/kujLP81Xqxa7veWt/XkQ+ZNaEA4wtOp99scLQNThgKfyXg06iuLv+aSI/zVpcDtUK7CU877NcvIqH9udMShO/LR7hJ5ozhRga+SRXEmIE+DHNMQfF9yq3i7l+MmGqeWQEmvu2fLv4pRwbhC5hJzEb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU9iX30I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABD0CC4AF09;
	Fri,  2 Aug 2024 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722642632;
	bh=KS9CiWWD+aMwEhJfuj/FUz08eXVbDzlHy6N1i+r4nTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NU9iX30IQTbW5ppB3lAMNsz0EhqD/qMvwky+QOzuZxkDz6GHn0Y93FefJ0ZSaTVD3
	 HtBbRmq/n9d9MeZH0neD0Q2dxhxGRAafiLNGhj3MMjjThyXt2ZlYJLgFZ8F5RgnVEH
	 bx+9rfySAFcu0uQ52Ca6howYbwaK8I1cersVNx4GTC0A3i5YsI7RifFcR66OMs8gPJ
	 ReRQTzs8Pk9zxxDA96l+A+LLi9+H81j4i2drtqTSbutrFw7C3duz+B3N4hfJJsSlYc
	 8tDv7/IHB3zq9gXjYOKukjb8FQnYsFJ7hOhbx0vsefukcHOqkKgfb3XJ/AhFFzZ8xV
	 hxUGka57ggbcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BD8AC43339;
	Fri,  2 Aug 2024 23:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ibmveth RR performance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264263263.4372.15447629382108205353.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:50:32 +0000
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
In-Reply-To: <20240801211215.128101-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 16:12:13 -0500 you wrote:
> Hello!
> 
> This patchset aims to increase the ibmveth drivers small packet
> request response rate.
> 
> These 2 patches address:
> 1. NAPI rescheduling technique
> 2. Driver-side processing of small packets
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ibmveth: Optimize poll rescheduling process
    https://git.kernel.org/netdev/net-next/c/f128c7cf0530
  - [net-next,2/2] ibmveth: Recycle buffers during replenish phase
    https://git.kernel.org/netdev/net-next/c/b5381a5540cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



