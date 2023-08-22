Return-Path: <netdev+bounces-29754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5AF784943
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A666128117A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF51DA46;
	Tue, 22 Aug 2023 18:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9C1DDF5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0671DC433A9;
	Tue, 22 Aug 2023 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727831;
	bh=DlPAhv/G1JFquP4jxc97hpIyWZErZEtr8/QyBJ+4eZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fi4yLhtd/N+5lmpVIQ4MWk0OhkrXJqxctgSocsVbFcPuodGDH0OqUnqbBJht1Q915
	 2hccZCkpUZ0x9ulcNyALIQWNRF2oh3dgAUKiKJXDFOJzeOfLPqRfrNF4PSAK5Xj4m5
	 fNusxNRa9Mfzp9KtPmdcKJ88vTN1waAhYLhzmz0rumB6RdblLFbwvzEJ6vCgPqUg06
	 uyXVs4cRayhwqmWyFsr0uC5DczpdYeXtmf352PdBXof5jHRAuQitMNeTq1L9DlogF4
	 ebJFq+dHsK6Af5S0RyrN5redZ81BnbeOXEOdfZrlc1Zdm2nUG3saOtQvpiHQP40+lB
	 NUUMegTWr+faA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D290BE4EAF6;
	Tue, 22 Aug 2023 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vxlan: vnifilter: Use GFP_KERNEL instead of
 GFP_ATOMIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272783085.18530.7969425058494199986.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:10:30 +0000
References: <20230821141923.1889776-1-idosch@nvidia.com>
In-Reply-To: <20230821141923.1889776-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 17:19:23 +0300 you wrote:
> The function is not called from an atomic context so use GFP_KERNEL
> instead of GFP_ATOMIC. The allocation of the per-CPU stats is already
> performed with GFP_KERNEL.
> 
> Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] vxlan: vnifilter: Use GFP_KERNEL instead of GFP_ATOMIC
    https://git.kernel.org/netdev/net-next/c/63c11dc2ca8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



