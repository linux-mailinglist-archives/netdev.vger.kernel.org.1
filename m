Return-Path: <netdev+bounces-192522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4AAC0331
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417E2A24A4C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36790199223;
	Thu, 22 May 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/gQ0JmH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3141990D9;
	Thu, 22 May 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885815; cv=none; b=kGyqXHAN6MPPdUW0g108I+mYWDbtQ8OBRm3WnUaJMeZ69FVODYfivZxhpm5NEOYKYs9FmeUgKd5fkW4f4ai5WvCEl/4x+fpRM90vtIShMNqo890KBUSXMSxtirdR2Rl+ueAZLKQVbSZVaDCUT5sOW7F1X/+Y1piTK/fl8e5YC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885815; c=relaxed/simple;
	bh=AAi0UNWb2GFkIphLPOyR6H+ke8wyEf8txq1OJ/+7F0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oR/u5i9Hn/YSiC8E8xkcspQls5z/xqGAl1yMiWiWl2DBpoN2oRaxzT7Lf2dnvr8MCyoeXQW6MUhKHoeIH/tjU4z0oJoepspp4F0KQzDdcTmiq9IuCUQKxerGBsek8+4tf62iUVPXj3n9T2+XY2jnOvzLI6Mq/5t7dn6t2lLaAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/gQ0JmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A68C4CEED;
	Thu, 22 May 2025 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885814;
	bh=AAi0UNWb2GFkIphLPOyR6H+ke8wyEf8txq1OJ/+7F0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/gQ0JmHCjCbD79M8Eq25l9+VmR5XFSDKat2eTcrCcJgcc1Qz472UVRWC7iEa44gb
	 2vkH/WDNviGwPNJ0Qd+7lXXf74D7bvm/RE5r7fDiZ23+588kTmN1ikNOGJhqBJD9qT
	 XTHegn/n1Dg3W43gN8nW4b5ry5GePxF2qnjZUPW9z3RcPPQ1cc5S/BL1/B0PYbSWos
	 kS6DqTEtjvb55wW/53c+jfdObGtEnbHdIiY3J8J93IhOcxZ/uNaayPNC09f4YZi0pn
	 aQcASpg7yk6GWJkjNCwDGJXkNZxAbQeQPOP1M1K/iSgX9nMnZlL8f1KMF8DMw5cRtn
	 +4ibUsGX4s2GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE86380AA7C;
	Thu, 22 May 2025 03:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/enic: Allow at least 8 RQs to always be used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788585025.2369658.1657252596771829199.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:50 +0000
References: <20250521-enic_min_8rq-v1-1-691bd2353273@cisco.com>
In-Reply-To: <20250521-enic_min_8rq-v1-1-691bd2353273@cisco.com>
To: Nelson Escobar <neescoba@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, johndale@cisco.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 May 2025 01:19:29 +0000 you wrote:
> Enic started using netif_get_num_default_rss_queues() to set the number
> of RQs used in commit cc94d6c4d40c ("enic: Adjust used MSI-X
> wq/rq/cq/interrupt resources in a more robust way")
> 
> This resulted in machines with less than 16 cpus using less than 8 RQs.
> Allow enic to use at least 8 RQs no matter how many cpus are in the
> machine to not impact existing enic workloads after a kernel upgrade.
> 
> [...]

Here is the summary with links:
  - [net-next] net/enic: Allow at least 8 RQs to always be used
    https://git.kernel.org/netdev/net-next/c/8fa18a3e8c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



