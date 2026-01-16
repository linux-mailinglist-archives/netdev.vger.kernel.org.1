Return-Path: <netdev+bounces-250440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F2D2B3A7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6F1300E17E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70E341AD6;
	Fri, 16 Jan 2026 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzgi0q9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50C20C00C
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536814; cv=none; b=n1e9Jd1vOXWxmJXOHvo3BpZm6IBJ3r1wLYprzGrh3ebt4UZ6ptBfpXkoGcsB1OFjQvGSdcwTiM6wBrovioDpyX+c0WfQNQHoziHBGRmyyfeXM2YPmwkjTHUEixAVMEzCwQJuRxZ5xJrBmoVoT/rcR4HKEzgs9hdzGbaA2NxGPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536814; c=relaxed/simple;
	bh=RJgP0oSCPnvtxFvzh7DZGIlYNLvPQY9y/cj4rFBtraA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lcer5PEztBAlWfPUCE0DwbI8bPGFQqphLaM6qCb0W1JmjVo+zdChdj+JxlcoONr6m5nTqMAdcgfFTivShfnvwEYnFg0RbzylPk1X0877Zgzit0780fBe7IrQZsXOuHo06xvAOCCjZcRMabcAxjfTTzv5YgTnBjpAzQqBjVT8RXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzgi0q9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591FDC116C6;
	Fri, 16 Jan 2026 04:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536814;
	bh=RJgP0oSCPnvtxFvzh7DZGIlYNLvPQY9y/cj4rFBtraA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lzgi0q9sGGIz0RYuVBI/EMUSYIp4L75B/ffnqenEiOvwWd1uPffEFKHTeCmpu85gx
	 RW3Ex7nmlrxcGHO8/6F4qjDAw4WmsqXzseYh6hSrXt77RZjBSx/cPLvUC7GHNXrC/T
	 JQmd/3ojM43toZzfqYvzR3OgEIRqh1caecyMfCQwgnVtkaosuxVNVUT3RWLPypSKjP
	 SUnI/BkYep5xQuO1engOKVzAB/SuXwxd/0dWGNsSoamoAJVRkYhrXl2Lb/4qoQgvg3
	 VtnsuWurVtFuvTzFexuaC14IvnSQOO79vIZAzme7+dPvNe2RSs14wue1OrR3o5cwFd
	 OasS/gfBbVfrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A4A380AA4C;
	Fri, 16 Jan 2026 04:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] xgbe: Use netlink extack to report errors to
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853660636.79095.7065833387528038849.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:10:06 +0000
References: <20260114080357.1778132-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260114080357.1778132-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Shyam-sundar.S-k@amd.com, Vishal.Badole@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 13:33:57 +0530 you wrote:
> From: Vishal Badole <Vishal.Badole@amd.com>
> 
> Upgrade XGBE driver to report errors via netlink extack instead
> of netdev_error so ethtool userspace can be aware of failures.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] xgbe: Use netlink extack to report errors to ethtool
    https://git.kernel.org/netdev/net-next/c/74ecff77dace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



