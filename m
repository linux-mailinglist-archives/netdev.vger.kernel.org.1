Return-Path: <netdev+bounces-29756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FBE784947
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906CC28117A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118ED1DDF9;
	Tue, 22 Aug 2023 18:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AE1DDFA
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E718C433B6;
	Tue, 22 Aug 2023 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727831;
	bh=n9KP9g7wX+HDOgaQuQD3XrBMsIv8EmSgREDlzRz7WzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PTMgN+0WsB7ls76FIQ31C812K7o8OzWEbEM1eR+706nIImFsHGNh8h4IdGReTbESd
	 BeqNVVxm9qDtT+pWlRSszwwwoj/83bfrrCOBIFH1q+NBfd/UZ3fEqwXFE4RapXOK5Y
	 iDKWt0G2DSxSkCYAm5o5k+FNHSaPv+MYTaAH0nKmDAyUi9B2ObCsFagFGCGF7yrERy
	 Ns3MqgT7s1y4NOEe6aLgLI2tilZ+oTikBo70NAXCbUFsJAzTbK1Szt8XK3Wyd6YCWK
	 V4z9cM0zx6wCah8h+UWpRqjWVO+T6hax8hlMeTqrpiVWBoxXP6Vbb6LaVl6er1PeMg
	 gPfNzeDp7GoRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD2A5E21EE2;
	Tue, 22 Aug 2023 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vrf: Remove unnecessary RCU-bh critical section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272783090.18530.10920057915466701144.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:10:30 +0000
References: <20230821142339.1889961-1-idosch@nvidia.com>
In-Reply-To: <20230821142339.1889961-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 17:23:39 +0300 you wrote:
> dev_queue_xmit_nit() already uses rcu_read_lock() / rcu_read_unlock()
> and nothing suggests that softIRQs should be disabled around it.
> Therefore, remove the rcu_read_lock_bh() / rcu_read_unlock_bh()
> surrounding it.
> 
> Tested using [1] with lockdep enabled.
> 
> [...]

Here is the summary with links:
  - [net-next] vrf: Remove unnecessary RCU-bh critical section
    https://git.kernel.org/netdev/net-next/c/504fc6f4f7f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



