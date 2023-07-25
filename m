Return-Path: <netdev+bounces-20614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700B7603D0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160AD2813C1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175B199;
	Tue, 25 Jul 2023 00:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BA630
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16FD4C433C9;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690244421;
	bh=QC0jDOn3ffVyRUueSqZ7CcXIH137nDxwop1B7b+rSjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0/l2A106jLPJNzT1dhmN14v4NOD9fADIL4rNvbZ9hlUcuryfqyZzuW0/cnz8WXAr
	 4yf7i4oNtO0dweSoPn5bjW3wSW5EOG30Dw3r4qBYNmif30eYxAcX3gljKHUiJm3MAp
	 dhjiPA25ewdS7LsPih429JBMw+fwHk5NHqB3vUq/RK4nvonG6+GsoBCK8eNV9UVOJS
	 EutaVYNmpIX0fSY/tgmzdQCfbcPT5PYbIG9UMExsWwhfzRt2jXZlPxckmBNqmj7+kl
	 sR9ycDOujkQBFKicE+CjgEDasYE6GMYyFxFdgxhC3t0bX3Vd9SVotvkormuuXtbC7O
	 18vZTSWeVN7tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDFA1E21EDD;
	Tue, 25 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-07-21 (i40e, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024442097.15014.3686941471612516296.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 00:20:20 +0000
References: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 21 Jul 2023 08:58:09 -0700 you wrote:
> This series contains updates to i40e and iavf drivers.
> 
> Wang Ming corrects an error check on i40e.
> 
> Jake unlocks crit_lock on allocation failure to prevent deadlock and
> stops re-enabling of interrupts when it's not intended for iavf.
> 
> [...]

Here is the summary with links:
  - [net,1/3] i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()
    https://git.kernel.org/netdev/net/c/043b1f185fb0
  - [net,2/3] iavf: fix potential deadlock on allocation failure
    https://git.kernel.org/netdev/net/c/a2f054c10bef
  - [net,3/3] iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED
    https://git.kernel.org/netdev/net/c/91896c8acce2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



