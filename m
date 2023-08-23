Return-Path: <netdev+bounces-29903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E26C78518C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1E91C20C5B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26E8BF6;
	Wed, 23 Aug 2023 07:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBF8BEA
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CA84C433C8;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692775827;
	bh=DMy8mzsfvd4yCf8+OTtKNxB/9kI1lgBvjoLxX442fr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b2R4/TYbRy41BBKYxzw98lCtLssxJ6q7LLpePsYlHnOj1NjXcVY9X0EXtoYAF57IA
	 WgAubMOBAltrgYE0DZnS4LKmBa4kPEgiHFxEOYGPYpbcul0/Zfb6QjG2bLVAp4C3G1
	 FjoJmPnlQ9Z2SFAmKYf9SF/r/rSgex8tDrgXGL7uZtQpkfTW20zr0qVC5d4GvBnxcO
	 9Fmobv1sXclCBfCjLlHouSsgRv6SIXEjwCssqRrmXNHLFF84W75GEm21IaevPv4lSy
	 gDELquhGVqI/j/DKOBGfnSHMpb8VbK4YNYGNjeMP4Vj/F+tSQHyCpFQd1buvcGqVw6
	 Xsn2n8/4uXw3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BB60E330A0;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] qed/qede: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169277582704.32405.1335809177017824612.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 07:30:27 +0000
References: <20230821130002.36700-1-yuehaibing@huawei.com>
In-Reply-To: <20230821130002.36700-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 21:00:02 +0800 you wrote:
> Commit 8cd160a29415 ("qede: convert to new udp_tunnel_nic infra")
> removed qede_udp_tunnel_{add,del}() but not the declarations.
> Commit 0ebcebbef1cc ("qed: Read device port count from the shmem")
> removed qed_device_num_engines() but not its declaration.
> Commit 1e128c81290a ("qed: Add support for hardware offloaded FCoE.")
> declared but never implemented qed_fcoe_set_pf_params().
> 
> [...]

Here is the summary with links:
  - [net-next] qed/qede: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/eb6603246ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



