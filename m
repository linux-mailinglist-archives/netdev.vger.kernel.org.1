Return-Path: <netdev+bounces-172706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AEFA55C33
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CE73AB229
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069D61E868;
	Fri,  7 Mar 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC/rmawH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FD139B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308604; cv=none; b=GitPX1NBDhTAQTpHv0YpwOJ5gnvLZ70+Ges56KnceArb2U/hVUFPIa8cxmGTPL0zvc5NYfP8+IG/rBQSS8IzZaqM++7IXJ6PcS5f25xxp85FLBvuqYvJn6+ZZMOMCMQt2MbgDuejry+m8OsjZsHy+x4ulk5S15wKZQImK3xm0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308604; c=relaxed/simple;
	bh=xLq71JMYceY+9KSdvGajq1teITo7c/UKyhmGeH1lrdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nL3r5c4K3tBXXfojECY4lHRib3dJoXRYSfuktvX7FHe38C9tQi64ad3PuudkzXwD0eSp6IPS6oKU8Aw+pzEFXeHbnWdrBB8bIkfeDU9okzWVbhWj71A8fkm6//QZNWfi2Mwdh/aZdbV2cSkB1I9Vu2eS9KUW4AS5OWAyPmhGrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC/rmawH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA6C4CEE5;
	Fri,  7 Mar 2025 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308604;
	bh=xLq71JMYceY+9KSdvGajq1teITo7c/UKyhmGeH1lrdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lC/rmawHUZSq7SM0wc1thhpfQ6AKSUKUkUxCUXsFeIC8SpOgRG8GzUpoxpeiLv44G
	 YqwVCr0I9yeO4PzM+HL+vCNvkTZpAvbfNH6DOIAuuLYgqberMcKFwYMAJz28WbwQP8
	 aETq7+LKQQlSySpmSnshG5lUveA9oqgNPuilSojfsxQI7nZt65dJ9x9JC93plQWYxZ
	 cmGrghbVrZv/pRKp+zMBBmsbwYnSbcsjDI41gKT3/BvnHpTW5dILX49BpXhX+TPlMA
	 n1NzdIY1h9y0rgOp6xHbaCo16VV/J+cDMbkfl9Yj7eAhdqJPYgObWMaSPbgE7h1lFd
	 pd2Vv2PI9+isA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCA380CFF6;
	Fri,  7 Mar 2025 00:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] Increase maximum MTU to 9k for Airoha EN7581
 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130863748.1835493.6319448617325483055.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:50:37 +0000
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 15:21:07 +0100 you wrote:
> EN7581 SoC supports 9k maximum MTU.
> Enable the reception of Scatter-Gather (SG) frames for Airoha EN7581.
> Introduce airoha_dev_change_mtu callback.
> 
> ---
> Lorenzo Bianconi (4):
>       net: airoha: Move min/max packet len configuration in airoha_dev_open()
>       net: airoha: Enable Rx Scatter-Gather
>       net: airoha: Introduce airoha_dev_change_mtu callback
>       net: airoha: Increase max mtu to 9k
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: airoha: Move min/max packet len configuration in airoha_dev_open()
    https://git.kernel.org/netdev/net-next/c/54d989d58d2a
  - [net-next,2/4] net: airoha: Enable Rx Scatter-Gather
    https://git.kernel.org/netdev/net-next/c/e12182ddb6e7
  - [net-next,3/4] net: airoha: Introduce airoha_dev_change_mtu callback
    https://git.kernel.org/netdev/net-next/c/03b1b69f0662
  - [net-next,4/4] net: airoha: Increase max mtu to 9k
    https://git.kernel.org/netdev/net-next/c/168ef0c1dee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



