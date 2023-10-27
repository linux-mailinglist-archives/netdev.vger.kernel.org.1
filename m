Return-Path: <netdev+bounces-44901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445267DA3BD
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657421C2108B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96D1D688;
	Fri, 27 Oct 2023 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERAzT1n/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AB8F69
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56260C433C8;
	Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447025;
	bh=33QsNMsb/vZmRa5UB/QpoNgXgQRoe62LkprwWwGp/OM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERAzT1n/R57NT/LsnLGXXMYNCOKpfwQZF8TqMM9qNjLm72CZJpEu/K4hEqk6FsZCQ
	 Fj4Yl3Ke/VsW1ZbQmevI0iSR98PIknQzygXsGbG1+6mL3DeHvzoNg9jQDjIXFS8Nwr
	 /qriwbBjaWjyHcmdQtdMJa3r2Tc8sXmLCE+UupQ4kINhjgnbYvQlVnWehE7/xEDaPJ
	 sFoA/VccOCPA151MOYW+gauPvNo3LoQATL/xLwU3ebLEByuiBNaV2ZwOp4Vspxez8Y
	 f0adOJ2dRT/c6sBWdQJ0IoAZ5xtw3IsFH/M4sVztSx6P0jkeH+SKhdW0rEjmSJ/C7P
	 Pz8Al6COz60vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C7D3C41620;
	Fri, 27 Oct 2023 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] Intel Wired LAN Driver Updates for 2023-10-23
 (iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844702524.17753.3058534064088871779.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:50:25 +0000
References: <20231027175941.1340255-1-jacob.e.keller@intel.com>
In-Reply-To: <20231027175941.1340255-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 10:59:33 -0700 you wrote:
> This series includes iAVF driver cleanups from Michal Schmidt.
> 
> Michal removes and updates stale comments, fixes some locking anti-patterns,
> improves handling of resets when the PF is slow, avoids unnecessary
> duplication of netdev state, refactors away some duplicate code, and finally
> removes the never-actually-used client interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] iavf: fix comments about old bit locks
    https://git.kernel.org/netdev/net-next/c/77361cb9c1d6
  - [net-next,v2,2/8] iavf: simplify mutex_trylock+sleep loops
    https://git.kernel.org/netdev/net-next/c/5902ee6dc651
  - [net-next,v2,3/8] iavf: in iavf_down, don't queue watchdog_task if comms failed
    https://git.kernel.org/netdev/net-next/c/6a0d989d3cdb
  - [net-next,v2,4/8] iavf: fix the waiting time for initial reset
    https://git.kernel.org/netdev/net-next/c/54584b178806
  - [net-next,v2,5/8] iavf: rely on netdev's own registered state
    https://git.kernel.org/netdev/net-next/c/34ad34bf06ca
  - [net-next,v2,6/8] iavf: use unregister_netdev
    https://git.kernel.org/netdev/net-next/c/5c4e1d187442
  - [net-next,v2,7/8] iavf: add a common function for undoing the interrupt scheme
    https://git.kernel.org/netdev/net-next/c/b5b219a1fa5f
  - [net-next,v2,8/8] iavf: delete the iavf client interface
    https://git.kernel.org/netdev/net-next/c/36d0395b30f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



