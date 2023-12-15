Return-Path: <netdev+bounces-57755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C1814073
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30771F21487
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626905697;
	Fri, 15 Dec 2023 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lutge+8G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D05692
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1574C433AD;
	Fri, 15 Dec 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609826;
	bh=PDCn8BYQR0pViH7jcx385sd+37qFHXo5GCKz34WeP7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lutge+8Gx0maQcbBIuyIxY/NqcOpaNsDiiniCt5yWBNEdVAQiC8NpeQJT1gajZPw7
	 ltpxxoUBJ5r6Atgp5Z3NjaYZaFa0DnCZ8aPa623ON8Nzt8Jg3GTjHw9FMah+VDF5sz
	 hv6G7DGkR63xLqFMHIf8JJv9QAzTmw+olmoz4bVy7RhHY7ncN/ihPZBS0MPosIATNl
	 0pYyvKSld4Dn3YBmVfeXEm9w/ReS37J/YvB6ss/2EFe675a/LcY+mYvWQAHGZ3X8Bp
	 pk+A1MKcEenQw8mzBldaeOIUZOcjftVqcJls4VekrebVyUxEFH2/0cQIJShp+bWXcp
	 /fo6SRjHJqvzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 998D7DD4EFF;
	Fri, 15 Dec 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-12-13 (ice, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260982662.2748.5524035806868477202.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:10:26 +0000
References: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 13 Dec 2023 14:08:24 -0800 you wrote:
> This series contains updates to ice and i40e drivers.
> 
> Michal Schmidt prevents possible out-of-bounds access for ice.
> 
> Ivan Vecera corrects value for MDIO clause 45 on i40e.
> 
> The following are changes since commit 810c38a369a0a0ce625b5c12169abce1dd9ccd53:
>   net/rose: Fix Use-After-Free in rose_ioctl
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: fix theoretical out-of-bounds access in ethtool link modes
    https://git.kernel.org/netdev/net/c/91f9181c7381
  - [net,2/2] i40e: Fix ST code value for Clause 45
    https://git.kernel.org/netdev/net/c/9b3daf2b0443

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



