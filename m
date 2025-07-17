Return-Path: <netdev+bounces-207653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BFB08132
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE03189A15E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C62EF671;
	Wed, 16 Jul 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSYY79Up"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DD29AB01
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710389; cv=none; b=Yc90r1hQptnIMukZaF4IU9lyj9ywxgstPgY4SWuAto5bY+DDl4k+tuCWWW/JSQy4sMBQYhbvnd9W/K2d4KgTfCiydk1Pbtl8VnO0Nlma8RwwFV9BZAlpMCRVenK85kDa/eFggGcvEPLe2dryUowrFZQmPzYwLdEmZO+oS7cLCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710389; c=relaxed/simple;
	bh=wZuf6qmofB28INnWqosx1bgjjiI5BgUO9qDoYRvwPEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwK/H74iYkGhLwsQC01GbFiWeYDQG5HQVcAP46RWjQA/rh4wKCdLnDN4hYWwPK/CYojSgLDGb7C/08iraqEbavdSgPAsAri/+NNr1MZpdXlLYwpcMMY0Ny8ESju1ltE8NFwkhgfrtlBYmBUXmoYxa2/dpOiZQTf4khYt9fbSll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSYY79Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C78C4CEE7;
	Wed, 16 Jul 2025 23:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752710389;
	bh=wZuf6qmofB28INnWqosx1bgjjiI5BgUO9qDoYRvwPEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSYY79UpyLK/GCybMk+5/a7CSgOa32ZKS6nI9TlCgpNMjvIbu7SIK5c70aojq9hCc
	 +3heMmZRSxqkpDq3WF8Hc4XCgbdTEDgHNudGL4NxcnNHUhPMCX5xe2gfVwvkhFwesZ
	 EouhQhLQ9aYIDD1XBloyBM7qI+D5oDCjkqEfRtqg95nftd9VnmndQp8tKZsHF8mDYO
	 ZDtgcmTGJHKNCNKolIqfUugfLDAQBVLHlDk2G10XTi7WoOz0WCTvO7V5vuuSxrYeNi
	 x8aTQcrtMlwbZi0DeqHio926VIQBmPLENFrjRsGAFpeFea8xlVjmcXXiEKY0k/S5Dm
	 jxgVPaD8Xb9Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71113383BA38;
	Thu, 17 Jul 2025 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-07-15 (ixgbe, fm10k, i40e, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271040926.1368016.3485291934007397973.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 00:00:09 +0000
References: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 15 Jul 2025 13:29:43 -0700 you wrote:
> Arnd Bergmann resolves compile issues with large NR_CPUS for ixgbe, fm10k,
> and i40e.
> 
> For ice:
> Dave adds a NULL check for LAG netdev.
> 
> Michal corrects a pointer check in debugfs initialization.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ethernet: intel: fix building with large NR_CPUS
    https://git.kernel.org/netdev/net/c/24171a5a4a95
  - [net,2/3] ice: add NULL check in eswitch lag check
    https://git.kernel.org/netdev/net/c/3ce58b01ada4
  - [net,3/3] ice: check correct pointer in fwlog debugfs
    https://git.kernel.org/netdev/net/c/bedd0330a19b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



