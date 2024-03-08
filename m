Return-Path: <netdev+bounces-78600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57B875D6B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C65B22C3C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170F2C1A6;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgyYhFY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7931A82
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=Cvq0BVc1pfuCF+UZHDwUg2mfITvm+Peg2vxkd4ZRGTY0HlueLOcec3wL5SVaQzvUjLVzmRgGPmj6tptrGKCHCCJlvLoTeGKa0K6q7wNgyoaEr6vPlQvxIM34mTnTpNQAUF2mFKCv10CCMV8i0M91b/cp0SwlJOYs++sZwBNsh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=NrVR4CCfYvZu7uLzOz9Be6YSKk5klhVD6CtmjQrivGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FshOMtXXThQRcibksLKEFYrj6ng3kRjbBoqIOuW2alDk6+q+e9oJfr7PF5lXxUa5xWqczdGuz4MV3WeVmaZciAC2nOENrLhFuL6HTHTLaVWgQuK8IX+Dum6TbYGxcA/XCET6ciBfF2XHZFwLwl7WppPix3R2C6x3F6KkTVaxXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgyYhFY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C38EBC32780;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=NrVR4CCfYvZu7uLzOz9Be6YSKk5klhVD6CtmjQrivGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgyYhFY83n1KBN1wY3/cfEo/i/ZOk5sl9DKFlOWNw+975nrSbt56IqeFRBtq1/GLU
	 i4dbth6EH65nJc4Gzw2KG4mq2nyYSVFvSdImM1j2yrt0I+nyAWbhsTaxrapj1yESGk
	 kHCq2IYitOqMVvQhXPUMUiA5ci3S1gM3VLpB4SF26X5zSo4IIU4YqIvjfnmiINcf7O
	 ojXjKG+zxhSyxpNtjGW+zvL6wyjTYub3G2ykKM9IYywLVYAlTLu9eCg6OG/6ZPqqxp
	 RL+mIr8li4ZcLTZvFaYAITpq4qB8BO11W9qlgjj0lxjVF5CfT6ZrwFMCs+OYdF+VFi
	 1tmCpf4H9BpMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B13B2D84BDD;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mpls: Do not orphan the skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403772.8362.3274190846184456765.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306181117.77419-1-cpaasch@apple.com>
In-Reply-To: <20240306181117.77419-1-cpaasch@apple.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, roopa@nvidia.com,
 cmtaylor@apple.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Mar 2024 10:11:17 -0800 you wrote:
> We observed that TCP-pacing was falling back to the TCP-layer pacing
> instead of utilizing sch_fq for the pacing. This causes significant
> CPU-usage due to the hrtimer running on a per-TCP-connection basis.
> 
> The issue is that mpls_xmit() calls skb_orphan() and thus sets
> skb->sk to NULL. Which implies that many of the goodies of TCP won't
> work. Pacing falls back to TCP-layer pacing. TCP Small Queues does not
> work, ...
> 
> [...]

Here is the summary with links:
  - [net-next] mpls: Do not orphan the skb
    https://git.kernel.org/netdev/net-next/c/8edbd3960150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



