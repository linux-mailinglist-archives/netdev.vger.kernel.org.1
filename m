Return-Path: <netdev+bounces-186208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8644A9D71A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E459C2A23
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF11FCFE9;
	Sat, 26 Apr 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxjlh4cG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AE1FC7CA;
	Sat, 26 Apr 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632797; cv=none; b=FZGjnLOpXtFGVzv8YUDPoz4G2C1+FXg8VuscSKefdM8af+VgrWMnWW4irFTbeqCCkIJlSAQaqrSjm8DPEz1PFmQSkPmjmMEXD1pb4/w/tiZkrSHGDs5ecDc03wCNk13dLkkANbsu1YD/7DNZs/lp/Po4Yx+Ov4szDqLMGYlobGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632797; c=relaxed/simple;
	bh=wmQAsSNirkZECRdBXk5ObeADwvGC+miPFlCACDYLXW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdrwrkzcHJ5OS62dkHMCkviLIn+OrcIC4cWpQft5qm3/DivxMul82FLPrkj0W4z8igoRFiU7AaxNds2Y6t+4kBvvJOP0buWzm9N6FEDpZ3+JTbSidxnHMo/1zmnL6CadDUb1OCP0Ajw+0iMyThmTGug7WkgbjZS4RIZsvYgLjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxjlh4cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99BC4CEED;
	Sat, 26 Apr 2025 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745632797;
	bh=wmQAsSNirkZECRdBXk5ObeADwvGC+miPFlCACDYLXW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xxjlh4cGALzydhzvMt9ca5iFraxN6FrP8TatXjS9BU3JIGd966+yWxjE1Wn3Wkh/y
	 LbOD4SDbCWjc/Kkq9yOkGuJjvuHSGUkASC4gps4NPiU+8L60i/pMXurOMMvD33YUU7
	 hlkICczb4sdQ/xgJx3l0Isv77+V0sUU+Zw3cLr2PxQxwBrp5Qy1OtMhMYPVP2Y9Q7a
	 n8dIx9wY8Ej/zY04zdob6cHdDH7RasgD2uJeQ8NvqmspPYHGEQ7HQQd3YyS1xB+rmi
	 DQyaooCuBA2xTlXvcUySbJQbhMO5qApeJal60NVNcXRQdhonR0lF9h4gI0WFlGETV0
	 k8X+RjxkXuuQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9A380CFDC;
	Sat, 26 Apr 2025 02:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] octeon_ep_vf: Resolve netdevice usage count issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563283574.3899759.5222635769655593485.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:00:35 +0000
References: <20250424133944.28128-1-sedara@marvell.com>
In-Reply-To: <20250424133944.28128-1-sedara@marvell.com>
To: Sathesh B Edara <sedara@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, vburru@marvell.com, srasheed@marvell.com,
 sburla@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 06:39:44 -0700 you wrote:
> The netdevice usage count increases during transmit queue timeouts
> because netdev_hold is called in ndo_tx_timeout, scheduling a task
> to reinitialize the card. Although netdev_put is called at the end
> of the scheduled work, rtnl_unlock checks the reference count during
> cleanup. This could cause issues if transmit timeout is called on
> multiple queues.
> 
> [...]

Here is the summary with links:
  - [net,v4] octeon_ep_vf: Resolve netdevice usage count issue
    https://git.kernel.org/netdev/net/c/8548c84c004b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



