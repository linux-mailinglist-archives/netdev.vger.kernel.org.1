Return-Path: <netdev+bounces-181557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F1A85795
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444A44E18C3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA726298998;
	Fri, 11 Apr 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJSTH6oG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429A28FFF4
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362595; cv=none; b=Do4nJ1aqvitMDD8cUsjS6/7qnKJNNSCnVbIFFeGKeQp0OEwU09NK8oB+nkRwag893LLx/J364v6UMtC4OU4/KsnNxM1/cOTv3rdoFnWfUflV6qGdee/UKomDYFiQfjrPxmJ45Jsd7jrG0Mixnzg4bbyaWOGofkL7CthW3Vo2LQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362595; c=relaxed/simple;
	bh=6VnD0MPm4z7HbKIrJbYr9StRxLA9SvujgHNIYJ4TYBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mHqKFZV6bfEBbqI4d4tvS0g+/Xs+nIKUIfTDILdCrl4Fg9yEDnaidJtZdBcb+RpcY4SZ+l8+kJpe7K0OaVYLEZd042hMi3T7qSmdToeWicIkKpH7H628KG4tDFDIYQJmwZr1h299p5c26jn7YxL//+XJQ20yV1eQg6/MPjAT2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJSTH6oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D4C4CEE2;
	Fri, 11 Apr 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744362595;
	bh=6VnD0MPm4z7HbKIrJbYr9StRxLA9SvujgHNIYJ4TYBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJSTH6oG6BDrxeCL7BF0NekHosHOpetxnUp8beRbC/F3+drW98xQW5LKVkAxCY71c
	 P/jGHOYiFxGVhetwoBg2Ti3FqJOgEPUxcgzU2rbWX4q69XXrS/ad7Hf28L7kjizdzn
	 fXoxfwnsMS0IeiSJB+l/iZN7GtxxV7OVhtWNCyCXRLg2g9Bc8rZIE+lk5K2yRMBh+v
	 rBY4ytt6/lV12/BZVSmNkwqDeGT+yl0BXsKRTyYxtYNjwYzDcQWBN3gBfYYwr3dpdk
	 ao92avTf4P1IneuaRoPmAFwy9RS39eYPjTKDf4djeY39im+0SFn/XPOCr+H8tEUG/6
	 5NK4p7C/Y+HdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFE38111DF;
	Fri, 11 Apr 2025 09:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: stm32: simplify clock handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174436263279.184109.16205129107386423128.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 09:10:32 +0000
References: <E1u1rwV-0013jc-Ez@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u1rwV-0013jc-Ez@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 07 Apr 2025 20:15:35 +0100 you wrote:
> Some stm32 implementations need the receive clock running in suspend,
> as indicated by dwmac->ops->clk_rx_enable_in_suspend. The existing
> code achieved this in a rather complex way, by passing a flag around.
> 
> However, the clk API prepare/enables are counted - which means that a
> clock won't be stopped as long as there are more prepare and enables
> than disables and unprepares, just like a reference count.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: stm32: simplify clock handling
    https://git.kernel.org/netdev/net-next/c/61499764e5cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



