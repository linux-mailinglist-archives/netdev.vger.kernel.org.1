Return-Path: <netdev+bounces-145516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FFA9CFB4D
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2951F223F4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5C1AE01F;
	Fri, 15 Nov 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpOJXKcP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26717E44A;
	Fri, 15 Nov 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714619; cv=none; b=u7uD6+FMupSqOwDJGVahiAVTHhVEdvNERsT4vV7ijDGGljNGgqyxBRcIrvaPMF+y8xWrMkRYVKqxhDuxtbjgsksTMDP0gGPDN0xhPenGT/Cv8EkxOJVlzZWs35oZHfCnbILtXLNLq0XJDMh9n9NA6yhXfV5vsjyS8I87rkZORx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714619; c=relaxed/simple;
	bh=TkxXcLqiBzWudjdSJSHUIznKHuSnjfJwPmFMTqBz248=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=njvpOcM7o22L6KcdZ5bJGFe+N3TPG8S1ci+czxtXtH/PjyAa8IG8Yo9uISmCqx59cIAwG0zs/kJM0udSVgVcYHI4v/A8d2A2LZvnVlQw6hEGAwCsPaPESHZ4MzDUe/od7L4WooHvEQIihJMro/XykN76DW+IkNRkMlMWFGMR31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpOJXKcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB88C4CECF;
	Fri, 15 Nov 2024 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731714619;
	bh=TkxXcLqiBzWudjdSJSHUIznKHuSnjfJwPmFMTqBz248=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IpOJXKcP3lkZ9lTIz8dmKC6/Dzznp6radZqYa6jD851I/jpWcDXU3rPWK7o/ZOFTp
	 3SO1aPDDl0Eqlu9yT4s/MkiA7Wekmghde38ohVFvcCMF12KMGe1gXP8+0nHRSD8WXK
	 3wLjpyCY43bsvWm2h4+oRHxkv5mLYrjIwmd3uXxRM6JVSR5BzidYp3ZvJN2wl2ub9+
	 FIKZtvpKYVT7t/TRKvoxJnj899tzn4HsG+fuE3RJs4G+9w+mVHd2NhYcGRVjTdmTJz
	 6yidOeFyPM5/gb+VRkrFwAy7Isgd7MDnzulbA7XMLoKFmf8CmxoD34bxcFA8oHWF1s
	 /yjwPFOXQVt4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340E33809A80;
	Fri, 15 Nov 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] enic: Use all the resources configured on
 VIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171463001.2772765.5468131384631362067.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:50:30 +0000
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
To: Nelson Escobar (neescoba) <neescoba@cisco.com>
Cc: johndale@cisco.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, benve@cisco.com, satishkh@cisco.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 23:56:32 +0000 you wrote:
> Allow users to configure and use more than 8 rx queues and 8 tx queues
> on the Cisco VIC.
> 
> This series changes the maximum number of tx and rx queues supported
> from 8 to the hardware limit of 256, and allocates memory based on the
> number of resources configured on the VIC.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] enic: Create enic_wq/rq structures to bundle per wq/rq data
    https://git.kernel.org/netdev/net-next/c/b67609c93153
  - [net-next,v4,2/7] enic: Make MSI-X I/O interrupts come after the other required ones
    https://git.kernel.org/netdev/net-next/c/231646cb6a8c
  - [net-next,v4,3/7] enic: Save resource counts we read from HW
    https://git.kernel.org/netdev/net-next/c/5aee3324724a
  - [net-next,v4,4/7] enic: Allocate arrays in enic struct based on VIC config
    https://git.kernel.org/netdev/net-next/c/a64e5492ca90
  - [net-next,v4,5/7] enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust way
    https://git.kernel.org/netdev/net-next/c/cc94d6c4d40c
  - [net-next,v4,6/7] enic: Move enic resource adjustments to separate function
    https://git.kernel.org/netdev/net-next/c/374f6c04df8e
  - [net-next,v4,7/7] enic: Move kdump check into enic_adjust_resources()
    https://git.kernel.org/netdev/net-next/c/a28ccf1d6c10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



